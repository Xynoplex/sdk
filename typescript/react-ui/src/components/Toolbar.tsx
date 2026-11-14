'use client';

import type { ReactNode } from 'react';
import { useTranslations } from '../contexts/TranslationContext';
import type { Theme } from '../contexts/ThemeContext';
import { useXynoplex } from '../session/XynoplexProvider';
import type { ToolbarPanelType } from '../state/shell-state-unit';
import './toolbar/Toolbar.css';

type ToolbarContext = 'document' | 'simple';

export interface ToolbarProps<T extends string = string> {
  context: ToolbarContext;
  activePanel: T | null;

  // Document context specific
  isArchived?: boolean;
}

/**
 * What a page renders the host's panel container with (its `ToolbarPanels`
 * prop): the open panel, the theme setting, and the page's own panels.
 */
export interface ToolbarPanelsProps {
  activePanel: ToolbarPanelType | null;
  theme: Theme;
  children?: ReactNode;
}

/**
 * Toolbar component for panel navigation
 *
 * @emits panel:toggle - Toggle panel visibility. Payload: { panel: string }
 */
export function Toolbar<T extends string = string>({
  context,
  activePanel,
  isArchived = false
}: ToolbarProps<T>) {
  const t = useTranslations('Toolbar');
  const xynoplex = useXynoplex();

  const handlePanelToggle = (panel: string) => {
    xynoplex.emit('panel:toggle', { panel });
  };

  return (
    <div className="xynoplex-toolbar" data-context={context}>
      {/* Document Context - show document-specific panels */}
      {context === 'document' && (
        <>
          {/* Annotations Icon - unified panel for all annotation types */}
          {!isArchived && (
            <button
              onClick={() => handlePanelToggle('annotations')}
              className="xynoplex-toolbar-button"
              data-active={activePanel === 'annotations'}
              data-panel="annotations"
              aria-label={t('annotations')}
              aria-pressed={activePanel === 'annotations'}
              title={t('annotations')}
            >
              <span className="xynoplex-toolbar-icon xynoplex-toolbar-icon-large" aria-hidden="true">A</span>
            </button>
          )}

          {/* Document Info Icon */}
          <button
            onClick={() => handlePanelToggle('info')}
            className="xynoplex-toolbar-button"
            data-active={activePanel === 'info'}
            data-panel="info"
            aria-label={t('resourceInfo')}
            aria-pressed={activePanel === 'info'}
            title={t('resourceInfo')}
          >
            <span className="xynoplex-toolbar-icon" aria-hidden="true">ℹ️</span>
          </button>

          {/* History Icon */}
          <button
            onClick={() => handlePanelToggle('history')}
            className="xynoplex-toolbar-button"
            data-active={activePanel === 'history'}
            data-panel="history"
            aria-label={t('history')}
            aria-pressed={activePanel === 'history'}
            title={t('history')}
          >
            <span className="xynoplex-toolbar-icon" aria-hidden="true">📒</span>
          </button>

          {/* JSON-LD Icon */}
          <button
            onClick={() => handlePanelToggle('jsonld')}
            className="xynoplex-toolbar-button"
            data-active={activePanel === 'jsonld'}
            data-panel="jsonld"
            aria-label="JSON-LD"
            aria-pressed={activePanel === 'jsonld'}
            title="JSON-LD"
          >
            <span className="xynoplex-toolbar-icon" aria-hidden="true">🌐</span>
          </button>

          {/* Collaboration Icon */}
          <button
            onClick={() => handlePanelToggle('collaboration')}
            className="xynoplex-toolbar-button"
            data-active={activePanel === 'collaboration'}
            data-panel="collaboration"
            aria-label={t('collaboration')}
            aria-pressed={activePanel === 'collaboration'}
            title={t('collaboration')}
          >
            <span className="xynoplex-toolbar-icon" aria-hidden="true">👥</span>
          </button>
        </>
      )}

      {/* Knowledge Base Icon - always visible */}
      <button
        onClick={() => handlePanelToggle('knowledge-base')}
        className="xynoplex-toolbar-button"
        data-active={activePanel === 'knowledge-base'}
        data-panel="knowledge-base"
        aria-label={t('knowledgeBase')}
        aria-pressed={activePanel === 'knowledge-base'}
        title={t('knowledgeBase')}
      >
        <svg className="xynoplex-toolbar-icon" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" strokeWidth={1.5} stroke="currentColor" width="20" height="20">
          <path strokeLinecap="round" strokeLinejoin="round" d="M20.25 6.375c0 2.278-3.694 4.125-8.25 4.125S3.75 8.653 3.75 6.375m16.5 0c0-2.278-3.694-4.125-8.25-4.125S3.75 4.097 3.75 6.375m16.5 0v11.25c0 2.278-3.694 4.125-8.25 4.125s-8.25-1.847-8.25-4.125V6.375m16.5 5.625c0 2.278-3.694 4.125-8.25 4.125s-8.25-1.847-8.25-4.125" />
        </svg>
      </button>

      {/* User Icon - always visible, appears above settings */}
      <button
        onClick={() => handlePanelToggle('user')}
        className="xynoplex-toolbar-button"
        data-active={activePanel === 'user'}
        data-panel="user"
        aria-label={t('userAccount')}
        aria-pressed={activePanel === 'user'}
        title={t('userAccount')}
      >
        <span className="xynoplex-toolbar-icon" aria-hidden="true">👤</span>
      </button>

      {/* Settings Icon - always visible without scrolling */}
      <button
        onClick={() => handlePanelToggle('settings')}
        className="xynoplex-toolbar-button"
        data-active={activePanel === 'settings'}
        data-panel="settings"
        aria-label={t('settings')}
        aria-pressed={activePanel === 'settings'}
        title={t('settings')}
      >
        <span className="xynoplex-toolbar-icon" aria-hidden="true">⚙️</span>
      </button>
    </div>
  );
}
