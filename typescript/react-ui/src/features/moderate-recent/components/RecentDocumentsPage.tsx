/**
 * RecentDocumentsPage Component
 *
 * Pure React component for viewing recent documents.
 * All dependencies passed as props - no Next.js hooks!
 */

import React from 'react';
import { ClockIcon } from '@heroicons/react/24/outline';
import { COMMON_PANELS, type ToolbarPanelType } from '../../../state/shell-state-unit';
import { type ToolbarPanelsProps, type ToolbarProps } from '../../../components/Toolbar';
export interface RecentDocumentsPageProps {
  // Data props
  isLoading: boolean;

  // UI state
  theme: 'light' | 'dark' | 'system';
  activePanel: ToolbarPanelType | null;

  // Translations
  translations: {
    pageTitle: string;
    pageDescription: string;
    sectionTitle: string;
    sectionDescription: string;
    noDocuments: string;
    activityWillAppear: string;
    loading: string;
  };

  // Component dependencies
  ToolbarPanels: React.ComponentType<ToolbarPanelsProps>;
  Toolbar: React.ComponentType<ToolbarProps<ToolbarPanelType>>;
}

export function RecentDocumentsPage({
  isLoading,
  theme,
  activePanel,
  translations: t,
  ToolbarPanels,
  Toolbar,
}: RecentDocumentsPageProps) {

  if (isLoading) {
    return (
      <div className="xynoplex-page__loading">
        <p className="xynoplex-page__loading-text">{t.loading}</p>
      </div>
    );
  }

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

        {/* Recent Documents Section */}
        <div className="xynoplex-card">
          <div className="xynoplex-recent-docs__header">
            <div className="xynoplex-recent-docs__icon-box">
              <ClockIcon className="xynoplex-recent-docs__icon" />
            </div>
            <div className="xynoplex-recent-docs__content">
              <h3 className="xynoplex-recent-docs__title">{t.sectionTitle}</h3>
              <p className="xynoplex-recent-docs__description">
                {t.sectionDescription}
              </p>
            </div>
          </div>

          <div className="xynoplex-recent-docs__empty-state">
            <svg className="xynoplex-recent-docs__empty-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
            </svg>
            <p className="xynoplex-recent-docs__empty-message">{t.noDocuments}</p>
            <p className="xynoplex-recent-docs__empty-hint">
              {t.activityWillAppear}
            </p>
          </div>
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
