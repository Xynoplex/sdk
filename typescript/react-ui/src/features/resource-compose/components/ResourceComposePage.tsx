/**
 * ResourceComposePage Component
 *
 * Pure React component for creating and editing resources.
 * Supports two modes: new resource and clone. (Reference completion moved
 * into the resolve wizard, as its in-modal compose step.)
 * All dependencies passed as props - no Next.js hooks!
 */

import React, { useState, useEffect } from 'react';
import { capabilitiesOf, AUTHORABLE_MEDIA_TYPES, MEDIA_TYPES, mediaTypeForExtension, isSupportedMediaType, LOCALES, folderOf, proposeStoragePath, getStorageUri } from '@xynolog/core';
import type { SupportedMediaType } from '@xynolog/core';
import type { UploadProgress } from '@xynolog/sdk';
import { type CloneData } from '../state/compose-page-state-unit';
import { COMMON_PANELS, type ToolbarPanelType } from '../../../state/shell-state-unit';
import { type ToolbarPanelsProps, type ToolbarProps } from '../../../components/Toolbar';
import { buttonStyles } from '../../../lib/button-styles';
import { CodeMirrorRenderer } from '../../../components/CodeMirrorRenderer';
import { useFormAnnouncements } from '../../../components/LiveRegion';
import { useLineNumbers } from '../../../contexts/LineNumbersContext';
import { UploadProgressBar } from './UploadProgressBar';

/**
 * Big tent: every registry type is uploadable. The `accept` hint lists all
 * known extensions — it's only a hint; `handleFileUpload` never rejects.
 */
const UPLOAD_ACCEPT = Object.values(MEDIA_TYPES).map((c) => c.extension).join(',');

/**
 * Detection chain for uploaded files (same spirit as the CLI):
 * 1. the browser's `file.type`, if it names a registry member;
 * 2. otherwise the filename extension (`file.type` is routinely empty for
 *    `.md` and friends);
 * 3. otherwise `application/octet-stream` — itself a registry member, so
 *    under the big tent every file is uploadable.
 */
function detectUploadMediaType(file: File): string {
  if (file.type && isSupportedMediaType(file.type)) return file.type;
  if (file.name.includes('.')) {
    const byExt = mediaTypeForExtension(file.name.slice(file.name.lastIndexOf('.')));
    if (byExt) return byExt;
  }
  return 'application/octet-stream';
}

export interface ResourceComposePageProps {
  mode: 'new' | 'clone';
  cloneData?: CloneData | null;

  // Available options
  availableEntityTypes: string[];

  // Initial values
  initialLocale: string;

  // UI state
  theme: 'light' | 'dark';
  hoverDelayMs: number;
  activePanel: ToolbarPanelType | null;

  // Actions
  onSaveResource: (params: SaveResourceParams) => Promise<void>;
  onCancel: () => void;
  /** Choose a destination directory and return its path relative to the KB root. */
  onChooseStorageDirectory?: (suggestedDirectory: string) => Promise<string | null>;

  /**
   * Live upload-progress for the in-flight save. Resolved by the route
   * shell from `composeVM.uploadProgress$`. `null` between saves and
   * after completion. When non-null, the form disables Save and the
   * inline `<UploadProgressBar />` below the action buttons renders.
   */
  uploadProgress?: UploadProgress | null;

  // Translations
  translations: {
    title: string;
    titleEditClone: string;
    subtitleClone: string;
    resourceName: string;
    resourceNamePlaceholder: string;
    entityTypes: string;
    language: string;
    contentSource: string;
    uploadFile: string;
    uploadFileDescription: string;
    writeContent: string;
    writeContentDescription: string;
    dropFileOrClick: string;
    supportedFormats: string;
    mediaType: string;
    autoDetected: string;
    format: string;
    content: string;
    resourceContent: string;
    encoding: string;
    archiveOriginal: string;
    cancel: string;
    saving: string;
    creating: string;
    saveClonedResource: string;
    createResource: string;
    chooseFolder?: string;
    locationHint?: string;
  };

  // Component dependencies
  ToolbarPanels: React.ComponentType<ToolbarPanelsProps>;
  Toolbar: React.ComponentType<ToolbarProps<ToolbarPanelType>>;
}

export interface SaveResourceParams {
  mode: 'new' | 'clone';
  name: string;
  storageUri: string;
  content?: string;
  file?: File;
  format?: string;
  charset?: string;
  entityTypes?: string[];
  language: string;
  archiveOriginal?: boolean;
}

export function ResourceComposePage({
  mode,
  cloneData,
  availableEntityTypes,
  initialLocale,
  theme,
  hoverDelayMs,
  activePanel,
  onSaveResource,
  onCancel,
  onChooseStorageDirectory,
  uploadProgress = null,
  translations: t,
  ToolbarPanels,
  Toolbar,
}: ResourceComposePageProps) {
  // Form announcements
  const { announceFormSubmitting, announceFormSuccess, announceFormError } = useFormAnnouncements();

  // Shared display setting (LineNumbersContext) — was a prop threaded from
  // the route, which desynced it from the Settings toggle.
  const { showLineNumbers } = useLineNumbers();

  // Form state
  const [newResourceName, setNewResourceName] = useState('');
  const [newResourceContent, setNewResourceContent] = useState('');
  const [selectedEntityTypes, setSelectedEntityTypes] = useState<string[]>([]);
  const [isCreating, setIsCreating] = useState(false);

  // Content input method selection
  const [inputMethod, setInputMethod] = useState<'upload' | 'write'>('write');

  // File upload state
  const [uploadedFile, setUploadedFile] = useState<File | null>(null);
  const [fileMimeType, setFileMimeType] = useState<string>('text/markdown');
  const [filePreviewUrl, setFilePreviewUrl] = useState<string | null>(null);
  const [isDragOver, setIsDragOver] = useState(false);

  // Format selection for manual content entry
  const [selectedFormat, setSelectedFormat] = useState<string>('text/markdown');

  // Language selection - default to current user locale
  const [selectedLanguage, setSelectedLanguage] = useState<string>(initialLocale);

  // Character encoding selection - default to UTF-8 (empty string means use default)
  const [selectedCharset, setSelectedCharset] = useState<string>('');

  // Working-tree path (bare, no protocol prefix) — converted to file:// URI on submit
  const [storagePath, setStoragePath] = useState('');
  const [storageDirectory, setStorageDirectory] = useState<string | null>(null);
  const [choosingStorageDirectory, setChoosingStorageDirectory] = useState(false);
  const [storageLocationError, setStorageLocationError] = useState<string | null>(null);

  // Archive original checkbox (for clones only)
  const [archiveOriginal, setArchiveOriginal] = useState(true);

  // The Save location starts filled and follows the title until the user
  // takes it over; `pathTouched` is derived, so clearing restores the proposal.
  // A clone proposes beside its source; a new resource proposes at the root.
  const composeFormat: SupportedMediaType =
    isSupportedMediaType(selectedFormat) ? selectedFormat : 'text/markdown';
  const pathTouched = storagePath !== '';
  const proposedPath = pathTouched
    ? storagePath
    : proposeStoragePath(
        mode === 'clone' && cloneData ? folderOf(getStorageUri(cloneData.sourceResource)) : '',
        newResourceName,
        composeFormat,
      );
  const proposedFilename = proposedPath.split('/').filter(Boolean).at(-1) ?? '';
  const effectivePath = onChooseStorageDirectory && storageDirectory !== null
    ? [storageDirectory, proposedFilename].filter(Boolean).join('/')
    : proposedPath;

  // Initialize form data based on mode
  useEffect(() => {
    if (mode === 'clone' && cloneData) {
      setNewResourceName(cloneData.sourceResource.name);
      setNewResourceContent(cloneData.sourceContent);
    }
  }, [mode, cloneData]);

  // Handle file upload
  const handleFileUpload = (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (!file) return;
    applyUploadedFile(file);
  };

  // One application path for both entries into the dropzone: the file-input
  // change (click) and a real drag-and-drop (the input is display:none, so
  // native input drops can never land — the label owns the drop).
  const applyUploadedFile = (file: File) => {
    const detectedMediaType = detectUploadMediaType(file);
    setUploadedFile(file);
    setFileMimeType(detectedMediaType);
    setInputMethod('upload');

    // Set file name as default resource name if empty
    if (!newResourceName) {
      const nameWithoutExt = file.name.replace(/\.[^/.]+$/, '');
      setNewResourceName(nameWithoutExt);
    }

    // Images and PDFs get an object-URL preview; everything else reads as text.
    const detectedRender = capabilitiesOf(detectedMediaType)?.render;
    if (detectedRender === 'image' || detectedRender === 'pdf') {
      const previewUrl = URL.createObjectURL(file);
      setFilePreviewUrl(previewUrl);
    } else {
      // For text files, read content
      const reader = new FileReader();
      reader.onload = (event) => {
        const content = event.target?.result as string;
        setNewResourceContent(content);
      };
      reader.readAsText(file);
    }
  };

  // Cleanup preview URL on unmount
  useEffect(() => {
    return () => {
      if (filePreviewUrl) {
        URL.revokeObjectURL(filePreviewUrl);
      }
    };
  }, [filePreviewUrl]);

  const handleSaveResource = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!newResourceName.trim()) return;

    setIsCreating(true);
    announceFormSubmitting();

    try {
      const params: SaveResourceParams = {
        mode,
        name: newResourceName,
        storageUri: `file://${effectivePath}`,
        content: newResourceContent,
        format: uploadedFile ? fileMimeType : selectedFormat,
        entityTypes: selectedEntityTypes,
        language: selectedLanguage,
      };

      if (uploadedFile) {
        params.file = uploadedFile;
      }
      if (selectedCharset) {
        params.charset = selectedCharset;
      }
      if (mode === 'clone') {
        params.archiveOriginal = archiveOriginal;
      }

      await onSaveResource(params);

      // Announce success based on mode
      const successMessage = mode === 'clone'
        ? 'Resource cloned successfully'
        : 'Resource created successfully';
      announceFormSuccess(successMessage);
    } catch (error) {
      announceFormError('Failed to save resource. Please try again.');
      throw error;
    } finally {
      setIsCreating(false);
    }
  };

  const chooseStorageDirectory = async () => {
    if (!onChooseStorageDirectory) return;
    setChoosingStorageDirectory(true);
    setStorageLocationError(null);
    try {
      const pathParts = effectivePath.split('/');
      pathParts.pop();
      const chosen = await onChooseStorageDirectory(pathParts.join('/'));
      if (chosen !== null) setStorageDirectory(chosen);
    } catch (error) {
      setStorageLocationError(error instanceof Error ? error.message : String(error));
    } finally {
      setChoosingStorageDirectory(false);
    }
  };

  const isClone = mode === 'clone';

  return (
    <div className={`xynolog-page${activePanel && COMMON_PANELS.includes(activePanel) ? ' xynolog-page--panel-open' : ''}`}>
      {/* Main Content Area */}
      <div className="xynolog-page__content xynolog-page__compose">
        {/* Page Title */}
        <div className="xynolog-page__header">
          <h1 className="xynolog-page__title">
            {isClone ? t.titleEditClone : t.title}
          </h1>
          {isClone && (
            <p className="xynolog-page__subtitle">
              {t.subtitleClone}
            </p>
          )}
        </div>

        {/* Create Form */}
        <div className="xynolog-form">
        <form onSubmit={handleSaveResource} className="xynolog-form__fields xynolog-compose-grid">
          {/* Left column: metadata */}
          <div className="xynolog-compose-grid__meta">
          {/* Name */}
          <div className="xynolog-form__field">
            <label htmlFor="docName" className="xynolog-form__label">
              {t.resourceName}
            </label>
            <input
              id="docName"
              type="text"
              value={newResourceName}
              onChange={(e) => setNewResourceName(e.target.value)}
              placeholder={t.resourceNamePlaceholder}
              className="xynolog-input"
              required
              disabled={isCreating}
            />
          </div>

          {/* Storage URI */}
          <div className="xynolog-form__field">
            {onChooseStorageDirectory
              ? <div className="xynolog-form__label">Location in Knowledge Base</div>
              : <label htmlFor="storagePath" className="xynolog-form__label">Save location</label>}
            {onChooseStorageDirectory ? (
              <div className="xynolog-form__location-picker">
                <code id="storagePath" title={effectivePath}>file://{effectivePath}</code>
                <button
                  type="button"
                  className="xynolog-form__location-button"
                  onClick={() => void chooseStorageDirectory()}
                  disabled={isCreating || choosingStorageDirectory}
                >
                  {choosingStorageDirectory ? 'Choosing…' : (t.chooseFolder ?? 'Choose folder…')}
                </button>
              </div>
            ) : (
              <div className="xynolog-input-addon">
                <span className="xynolog-input-addon__prefix">file://</span>
                <input
                  id="storagePath"
                  type="text"
                  value={effectivePath}
                  onChange={(e) => setStoragePath(e.target.value)}
                  placeholder="docs/my-resource.md"
                  required
                  className="xynolog-input xynolog-input--addon"
                  disabled={isCreating}
                />
              </div>
            )}
            {onChooseStorageDirectory && (
              <p className="xynolog-form__location-hint">
                {t.locationHint ?? 'The resource name determines the filename. Choose a folder within this Knowledge Base.'}
              </p>
            )}
            {storageLocationError && <p className="xynolog-form__location-error" role="alert">{storageLocationError}</p>}
          </div>

          {/* Entity Types Selection */}
          {(
            <div className="xynolog-form__field xynolog-form__entity-types">
              <div className="xynolog-form__label">
                {t.entityTypes}
              </div>
              <div
                className="xynolog-form__entity-type-buttons"
                role="group"
                aria-describedby="entity-types-description"
              >
                {availableEntityTypes.map((type: string) => {
                  const isSelected = selectedEntityTypes.includes(type);
                  return (
                    <button
                      key={type}
                      type="button"
                      onClick={() => {
                        setSelectedEntityTypes(prev =>
                          prev.includes(type)
                            ? prev.filter(t => t !== type)
                            : [...prev, type]
                        );
                      }}
                      className="xynolog-form__entity-type-button"
                      data-selected={isSelected}
                      disabled={isCreating}
                      aria-pressed={isSelected}
                      aria-label={`${type} entity type, ${isSelected ? 'selected' : 'not selected'}`}
                    >
                      {type}
                    </button>
                  );
                })}
              </div>
              {selectedEntityTypes.length > 0 && (
                <div
                  className="sr-only"
                  aria-live="polite"
                  aria-atomic="true"
                >
                  {selectedEntityTypes.length} entity type{selectedEntityTypes.length !== 1 ? 's' : ''} selected: {selectedEntityTypes.join(', ')}
                </div>
              )}
            </div>
          )}

          {/* Language Selector */}
          <div className="xynolog-form__field">
            <label htmlFor="language-select" className="xynolog-form__label">
              {t.language}
            </label>
            <select
              id="language-select"
              value={selectedLanguage}
              onChange={(e) => setSelectedLanguage(e.target.value)}
              disabled={isCreating}
              className="xynolog-select"
            >
              {LOCALES.map((lang) => (
                <option key={lang.code} value={lang.code}>
                  {lang.nativeName}
                </option>
              ))}
            </select>
          </div>

          </div>{/* end xynolog-compose-grid__meta */}

          {/* Right column: content */}
          <div className="xynolog-compose-grid__content">

          {/* Content Source Toggle - only show for new resources */}
          {!isClone && (
            <div className="xynolog-form__field">
              <label className="xynolog-form__label">
                {t.contentSource}
              </label>
              <div className="xynolog-form__content-source-toggle">
                <button
                  type="button"
                  onClick={() => setInputMethod('upload')}
                  disabled={isCreating}
                  className="xynolog-form__content-source-button"
                  data-active={inputMethod === 'upload'}
                >
                  <div className="xynolog-form__content-source-icon-wrapper">
                    <span className="xynolog-form__content-source-icon">📎</span>
                    <span className="xynolog-form__content-source-label">{t.uploadFile}</span>
                  </div>
                  <div className="xynolog-form__content-source-description">
                    {t.uploadFileDescription}
                  </div>
                </button>

                <button
                  type="button"
                  onClick={() => setInputMethod('write')}
                  disabled={isCreating}
                  className="xynolog-form__content-source-button"
                  data-active={inputMethod === 'write'}
                >
                  <div className="xynolog-form__content-source-icon-wrapper">
                    <span className="xynolog-form__content-source-icon">✍️</span>
                    <span className="xynolog-form__content-source-label">{t.writeContent}</span>
                  </div>
                  <div className="xynolog-form__content-source-description">
                    {t.writeContentDescription}
                  </div>
                </button>
              </div>
            </div>
          )}

          {/* Upload File Section */}
          {!isClone && inputMethod === 'upload' && (
            <div className="xynolog-form__upload-section">
              <div>
                <div className="xynolog-form__upload-container">
                  <label
                    className="xynolog-form__upload-dropzone"
                    data-drag-over={isDragOver ? 'true' : 'false'}
                    onDragOver={(e) => { e.preventDefault(); setIsDragOver(true); }}
                    onDragLeave={() => setIsDragOver(false)}
                    onDrop={(e) => {
                      e.preventDefault();
                      setIsDragOver(false);
                      const file = e.dataTransfer.files?.[0];
                      if (file && !isCreating) applyUploadedFile(file);
                    }}
                  >
                    <div className="xynolog-form__upload-area">
                      <input
                        type="file"
                        accept={UPLOAD_ACCEPT}
                        onChange={handleFileUpload}
                        className="xynolog-form__upload-input"
                        disabled={isCreating}
                      />
                      <p className="xynolog-form__upload-text">
                        {uploadedFile ? uploadedFile.name : t.dropFileOrClick}
                      </p>
                      <p className="xynolog-form__upload-hint">
                        {t.supportedFormats}
                      </p>
                    </div>
                  </label>
                  {uploadedFile && (
                    <button
                      type="button"
                      onClick={() => {
                        setUploadedFile(null);
                        setFilePreviewUrl(null);
                        setFileMimeType('text/markdown');
                      }}
                      className="xynolog-button xynolog-button--danger xynolog-button--small"
                      disabled={isCreating}
                    >
                      Clear
                    </button>
                  )}
                </div>
              </div>

              {/* Media Type Display - Auto-detected */}
              {uploadedFile && (
                <div className="xynolog-form__media-type">
                  <span className="xynolog-form__media-type-label">{t.mediaType}:</span>
                  <code className="xynolog-form__media-type-value">
                    {fileMimeType}
                  </code>
                  <span className="xynolog-form__media-type-lock" title={t.autoDetected}>🔒</span>
                </div>
              )}

              {/* Image Preview */}
              {uploadedFile && filePreviewUrl && capabilitiesOf(fileMimeType)?.render === 'image' && (
                <div className="xynolog-form__image-preview">
                  <p className="xynolog-form__image-preview-label">Preview:</p>
                  <div className="xynolog-form__image-preview-container">
                    <img
                      src={filePreviewUrl}
                      alt="Upload preview"
                      className="xynolog-form__image-preview-img"
                    />
                  </div>
                </div>
              )}
            </div>
          )}

          {/* Write Content Section */}
          {(isClone || inputMethod === 'write') && (
            <div className="xynolog-form__write-section">
              {/* Format Selector - only for manual entry, not clones */}
              {!isClone && (
                <div className="xynolog-form__field">
                  <label htmlFor="format-select" className="xynolog-form__label">
                    {t.format}
                  </label>
                  <select
                    id="format-select"
                    value={selectedFormat}
                    onChange={(e) => setSelectedFormat(e.target.value)}
                    disabled={isCreating}
                    className="xynolog-select"
                  >
                    {AUTHORABLE_MEDIA_TYPES.map((mt) => (
                      <option key={mt} value={mt}>
                        {capabilitiesOf(mt)?.label ?? mt} ({mt})
                      </option>
                    ))}
                  </select>
                </div>
              )}

              {/* Content Editor */}
              <div className="xynolog-form__field xynolog-form__editor">
                <label className="xynolog-form__label">
                  {isClone ? t.resourceContent : t.content}
                </label>
                <div className="xynolog-form__editor-wrapper" lang={selectedLanguage}>
                  <CodeMirrorRenderer
                    content={newResourceContent}
                    editable={!isCreating}
                    sourceView={true}
                    showLineNumbers={showLineNumbers}
                    hoverDelayMs={hoverDelayMs}
                    onChange={(newContent) => setNewResourceContent(newContent)}
                  />
                </div>
              </div>

              {/* Encoding Selector - only for manual text entry */}
              {!isClone && (
                <div className="xynolog-form__field">
                  <label htmlFor="charset-select" className="xynolog-form__label">
                    {t.encoding}
                  </label>
                  <select
                    id="charset-select"
                    value={selectedCharset}
                    onChange={(e) => setSelectedCharset(e.target.value)}
                    disabled={isCreating}
                    className="xynolog-select"
                  >
                    <option value="">UTF-8 (default)</option>
                    <option value="iso-8859-1">ISO-8859-1 (Latin-1)</option>
                    <option value="windows-1252">Windows-1252</option>
                    <option value="ascii">ASCII</option>
                    <option value="utf-16le">UTF-16LE</option>
                  </select>
                </div>
              )}
            </div>
          )}

          {/* Archive Original Checkbox (for clones only) */}
          {isClone && (
            <div className="xynolog-form__checkbox-field">
              <input
                id="archiveOriginal"
                type="checkbox"
                checked={archiveOriginal}
                onChange={(e) => setArchiveOriginal(e.target.checked)}
                className="xynolog-checkbox"
                disabled={isCreating}
              />
              <label htmlFor="archiveOriginal" className="xynolog-form__checkbox-label">
                {t.archiveOriginal}
              </label>
            </div>
          )}

          </div>{/* end xynolog-compose-grid__content */}

          {/* Action Buttons */}
          <div className="xynolog-form__actions">
            <button
              type="button"
              onClick={onCancel}
              disabled={isCreating || uploadProgress !== null}
              className={buttonStyles.tertiary.base}
            >
              {t.cancel}
            </button>
            <button
              type="submit"
              disabled={isCreating || uploadProgress !== null || !newResourceName.trim()}
              className={buttonStyles.primary.base}
            >
              {isCreating
                ? (isClone ? t.saving : t.creating)
                : (isClone ? t.saveClonedResource : t.createResource)}
            </button>
          </div>

          {/* Inline upload progress — renders below the action buttons while
              an upload is in flight. `null` between saves and after completion. */}
          <UploadProgressBar progress={uploadProgress} label={t.uploadFile} />
        </form>
      </div>
      </div>

      {/* Right Sidebar - Panels and Toolbar */}
      <div className="xynolog-page__sidebar">
        {/* Panels Container */}
        <ToolbarPanels
          activePanel={activePanel}
          theme={theme}
        />

        {/* Toolbar - Always visible on the right */}
        <Toolbar
          context="simple"
          activePanel={activePanel}
        />
      </div>
    </div>
  );
}
