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
    <div className={`xynolog-page${activePanel && COMMON_PANELS.includes(activePanel) ? ' xynolog-page--panel-open' : ''}`}>
      {/* Main Content Area */}
      <div className="xynolog-page__content">
        {/* Page Title */}
        <div className="xynolog-page__header">
          <h1 className="xynolog-page__title">{t.pageTitle}</h1>
          <p className="xynolog-page__subtitle">
            {t.pageDescription}
          </p>
        </div>

        {/* Entity Tags Management */}
        <div className="xynolog-card">
          <div className="xynolog-entity-tags__header">
            <div className="xynolog-entity-tags__icon-box">
              <TagIcon className="xynolog-entity-tags__icon" />
            </div>
            <div className="xynolog-entity-tags__content">
              <h3 className="xynolog-entity-tags__title">{t.sectionTitle}</h3>
              <p className="xynolog-entity-tags__description">
                {t.sectionDescription}
              </p>
            </div>
          </div>

          {/* Existing tags */}
          <div className="xynolog-entity-tags__tags-section">
            <div className="xynolog-tags">
              {entityTypes.map((tag: string) => (
                <span
                  key={tag}
                  className="xynolog-tag xynolog-tag--info xynolog-tag--rounded-md"
                >
                  {tag}
                </span>
              ))}
            </div>
          </div>

          {/* Add new tag */}
          <div className="xynolog-entity-tags__input-group">
            <input
              type="text"
              value={newTag}
              onChange={(e) => onNewTagChange(e.target.value)}
              onKeyDown={handleKeyDown}
              placeholder={t.inputPlaceholder}
              className="xynolog-entity-tags__input"
              disabled={isAddingTag}
            />
            <button
              onClick={onAddTag}
              disabled={isAddingTag || !newTag.trim()}
              className="xynolog-button xynolog-button--primary"
            >
              {isAddingTag ? (
                t.adding
              ) : (
                <>
                  <PlusIcon className="xynolog-icon xynolog-icon--small xynolog-icon--inline" />
                  {t.addTag}
                </>
              )}
            </button>
          </div>

          {/* Error message */}
          {error && (
            <div className="xynolog-entity-tags__error">
              <ExclamationCircleIcon className="xynolog-entity-tags__error-icon" />
              {error}
            </div>
          )}
        </div>
      </div>

      {/* Right Sidebar - Panels and Toolbar */}
      <div className="xynolog-page__sidebar">
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
