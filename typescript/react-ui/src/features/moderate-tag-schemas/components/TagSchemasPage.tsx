/**
 * TagSchemasPage Component
 *
 * Pure React component for viewing tag schemas.
 * All dependencies passed as props - no Next.js hooks!
 */

import React from 'react';
import {
  AcademicCapIcon,
  ScaleIcon,
  LightBulbIcon
} from '@heroicons/react/24/outline';
import { COMMON_PANELS, type ToolbarPanelType } from '../../../state/shell-state-unit';
import { type ToolbarPanelsProps, type ToolbarProps } from '../../../components/Toolbar';
import type { TagSchema } from '@xynoplex/sdk';
export type { TagSchema };

export interface TagSchemasPageProps {
  // Data props
  schemas: TagSchema[];
  isLoading: boolean;

  // UI state
  theme: 'light' | 'dark' | 'system';
  activePanel: ToolbarPanelType | null;

  // Translations
  translations: {
    pageTitle: string;
    pageDescription: string;
    categories: string;
    loading: string;
  };

  // Component dependencies
  ToolbarPanels: React.ComponentType<ToolbarPanelsProps>;
  Toolbar: React.ComponentType<ToolbarProps<ToolbarPanelType>>;
}

const domainIcons: Record<string, React.ComponentType<{ className?: string }>> = {
  legal: ScaleIcon,
  scientific: AcademicCapIcon,
  general: LightBulbIcon
};

const domainClasses: Record<string, string> = {
  legal: 'xynoplex-schema-domain--legal',
  scientific: 'xynoplex-schema-domain--scientific',
  general: 'xynoplex-schema-domain--general'
};

export function TagSchemasPage({
  schemas,
  isLoading,
  theme,
  activePanel,
  translations: t,
  ToolbarPanels,
  Toolbar,
}: TagSchemasPageProps) {

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

        {/* Schemas Grid */}
        <div className="xynoplex-card-grid xynoplex-card-grid--two-columns">
          {schemas.map((schema) => {
            const Icon = domainIcons[schema.domain] || LightBulbIcon;
            const domainClass = domainClasses[schema.domain] || domainClasses.general!;

            return (
              <div
                key={schema.id}
                className="xynoplex-card"
              >
                {/* Schema Header */}
                <div className="xynoplex-schema__header">
                  <div className={`xynoplex-schema__icon-wrapper ${domainClass}`}>
                    {Icon && <Icon className="xynoplex-schema__icon" />}
                  </div>
                  <div className="xynoplex-schema__content">
                    <h3 className="xynoplex-schema__title">{schema.name}</h3>
                    <p className="xynoplex-schema__description">
                      {schema.description}
                    </p>
                    <span className={`xynoplex-schema__badge ${domainClass}`}>
                      {schema.domain}
                    </span>
                  </div>
                </div>

                {/* Categories */}
                <div className="xynoplex-schema__categories">
                  <h4 className="xynoplex-schema__categories-title">
                    {t.categories}
                  </h4>
                  {schema.tags.map((tag) => (
                    <div
                      key={tag.name}
                      className="xynoplex-schema__category"
                    >
                      <div className="xynoplex-schema__category-name">
                        {tag.name}
                      </div>
                      <div className="xynoplex-schema__category-description">
                        {tag.description}
                      </div>
                      <div className="xynoplex-schema__examples">
                        {tag.examples.slice(0, 2).map((example, idx) => (
                          <span
                            key={idx}
                            className="xynoplex-schema__example"
                          >
                            {example}
                          </span>
                        ))}
                        {tag.examples.length > 2 && (
                          <span className="xynoplex-schema__example-more">
                            +{tag.examples.length - 2} more
                          </span>
                        )}
                      </div>
                    </div>
                  ))}
                </div>
              </div>
            );
          })}
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
