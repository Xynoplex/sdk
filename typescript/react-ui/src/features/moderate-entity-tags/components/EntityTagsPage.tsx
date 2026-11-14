/**
 * EntityTagsPage Component
 *
 * Pure React component for managing entity tags.
 * All dependencies passed as props - no Next.js hooks!
 */

import React from 'react';
import {
  TagIcon,
  PlusIcon,
  ExclamationCircleIcon
} from '@heroicons/react/24/outline';
import { COMMON_PANELS, type ToolbarPanelType } from '../../../state/shell-state-unit';
import { type ToolbarPanelsProps, type ToolbarProps } from '../../../components/Toolbar';
export interface EntityTagsPageProps {
  // Data props
  entityTypes: string[];
  isLoading: boolean;
  error: string;

  // Tag input state
  newTag: string;
  onNewTagChange: (value: string) => void;

  // Actions
  onAddTag: () => void;
  isAddingTag: boolean;

  // UI state
  theme: 'light' | 'dark' | 'system';
  activePanel: ToolbarPanelType | null;

  // Translations
  translations: {
    pageTitle: string;
    pageDescription: string;
    sectionTitle: string;
    sectionDescription: string;
    inputPlaceholder: string;
    addTag: string;
    adding: string;
  };

  // Component dependencies
  ToolbarPanels: React.ComponentType<ToolbarPanelsProps>;
  Toolbar: React.ComponentType<ToolbarProps<ToolbarPanelType>>;
}

export function EntityTagsPage({
  entityTypes,
  error,
  newTag,
  onNewTagChange,
  onAddTag,
  isAddingTag,
  theme,
  activePanel,
  translations: t,
  ToolbarPanels,
  Toolbar,
}: EntityTagsPageProps) {

  const handleKeyDown = (e: React.KeyboardEvent<HTMLInputElement>) => {
    if (e.key === 'Enter') {
      onAddTag();
    }
  };

  return (
    <div className={`xynoplex-page${activePanel && COMMON_PANELS.includes(activePanel) ? ' xynoplex-page--panel-open' : ''}`}>
      {/* Main Content Area */}
      <div className="xynoplex-page__content">
        {/* Page Title */}
        <div className="xynoplex-page__header">
          <h1 className="xynoplex-page__title">{t.pageTitle}</h1>
          <p className="xynoplex-page__subtitle">
            {t.pageDescription}
          </p>
        </div>

        {/* Entity Tags Management */}
        <div className="xynoplex-card">
          <div className="xynoplex-entity-tags__header">
            <div className="xynoplex-entity-tags__icon-box">
              <TagIcon className="xynoplex-entity-tags__icon" />
            </div>
            <div className="xynoplex-entity-tags__content">
              <h3 className="xynoplex-entity-tags__title">{t.sectionTitle}</h3>
              <p className="xynoplex-entity-tags__description">
                {t.sectionDescription}
              </p>
            </div>
          </div>

          {/* Existing tags */}
          <div className="xynoplex-entity-tags__tags-section">
            <div className="xynoplex-tags">
              {entityTypes.map((tag: string) => (
                <span
                  key={tag}
                  className="xynoplex-tag xynoplex-tag--info xynoplex-tag--rounded-md"
                >
                  {tag}
                </span>
              ))}
            </div>
          </div>

          {/* Add new tag */}
          <div className="xynoplex-entity-tags__input-group">
            <input
              type="text"
              value={newTag}
              onChange={(e) => onNewTagChange(e.target.value)}
              onKeyDown={handleKeyDown}
              placeholder={t.inputPlaceholder}
              className="xynoplex-entity-tags__input"
              disabled={isAddingTag}
            />
            <button
              onClick={onAddTag}
              disabled={isAddingTag || !newTag.trim()}
              className="xynoplex-button xynoplex-button--primary"
            >
              {isAddingTag ? (
                t.adding
              ) : (
                <>
                  <PlusIcon className="xynoplex-icon xynoplex-icon--small xynoplex-icon--inline" />
                  {t.addTag}
                </>
              )}
            </button>
          </div>

          {/* Error message */}
          {error && (
            <div className="xynoplex-entity-tags__error">
              <ExclamationCircleIcon className="xynoplex-entity-tags__error-icon" />
              {error}
            </div>
          )}
        </div>
      </div>

      {/* Right Sidebar - Panels and Toolbar */}
      <div className="xynoplex-page__sidebar">
        <ToolbarPanels
          activePanel={activePanel}
          theme={theme}
        />

        <Toolbar
          context="simple"
          activePanel={activePanel}
        />
      </div>
    </div>
  );
}
