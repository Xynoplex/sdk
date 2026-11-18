'use client';

import { useTranslations } from '../../../contexts/TranslationContext';
import { isBodyResolved } from '@xynolog/core';
import { getEntityTypes } from '@xynolog/core';
import './StatisticsPanel.css';

import type { Annotation } from '@xynolog/core';

interface StatisticsPanelProps {
  highlights: Annotation[];
  comments: Annotation[];
  assessments: Annotation[];
  references: Annotation[];
  tags: Annotation[];
}

export function StatisticsPanel({
  highlights,
  comments,
  assessments,
  references,
  tags,
}: StatisticsPanelProps) {
  const t = useTranslations('StatisticsPanel');

  // Count stub vs resolved references
  const stubCount = references.filter((r) => !isBodyResolved(r.body)).length;
  const resolvedCount = references.filter((r) => isBodyResolved(r.body)).length;

  // Count entity types from references (at annotation level)
  const entityTypeCounts = new Map<string, number>();
  references.forEach((ref) => {
    const entityTypes = getEntityTypes(ref);
    entityTypes.forEach((type: string) => {
      entityTypeCounts.set(type, (entityTypeCounts.get(type) || 0) + 1);
    });
  });

  const entityTypesList = Array.from(entityTypeCounts.entries()).sort(
    (a, b) => b[1] - a[1],
  ); // Sort by count descending

  return (
    <div className="xynolog-statistics-panel">
      <div className="xynolog-statistics-panel__content">
        <h2 className="xynolog-statistics-panel__title">{t('title')}</h2>

        <div className="xynolog-statistics-panel__list">
          {/* Highlights */}
          <div className="xynolog-statistics-panel__item">
            <span className="xynolog-statistics-panel__label">
              {t('highlights')}
            </span>
            <span className="xynolog-statistics-panel__value">
              {highlights.length}
            </span>
          </div>

          {/* Comments */}
          <div className="xynolog-statistics-panel__item">
            <span className="xynolog-statistics-panel__label">
              {t('comments')}
            </span>
            <span className="xynolog-statistics-panel__value">
              {comments.length}
            </span>
          </div>

          {/* Assessments */}
          <div className="xynolog-statistics-panel__item">
            <span className="xynolog-statistics-panel__label">
              {t('assessments')}
            </span>
            <span className="xynolog-statistics-panel__value">
              {assessments.length}
            </span>
          </div>

          {/* Tags */}
          <div className="xynolog-statistics-panel__item">
            <span className="xynolog-statistics-panel__label">{t('tags')}</span>
            <span className="xynolog-statistics-panel__value">
              {tags.length}
            </span>
          </div>

          {/* References */}
          <div className="xynolog-statistics-panel__item">
            <span className="xynolog-statistics-panel__label">
              {t('references')}
            </span>
            <span className="xynolog-statistics-panel__value">
              {references.length}
            </span>

            {/* Sub-categories indented */}
            <div className="xynolog-statistics-panel__subitems">
              <div className="xynolog-statistics-panel__subitem">
                <span className="xynolog-statistics-panel__sublabel">
                  {t('stub')}
                </span>
                <span className="xynolog-statistics-panel__subvalue">
                  {stubCount}
                </span>
              </div>
              <div className="xynolog-statistics-panel__subitem">
                <span className="xynolog-statistics-panel__sublabel">
                  {t('resolved')}
                </span>
                <span className="xynolog-statistics-panel__subvalue">
                  {resolvedCount}
                </span>
              </div>
            </div>
          </div>

          {/* Entity Types */}
          {entityTypesList.length > 0 && (
            <div className="xynolog-statistics-panel__entity-types">
              <span className="xynolog-statistics-panel__label">
                {t('entityTypes')}
              </span>
              <div className="xynolog-statistics-panel__entity-list">
                {entityTypesList.map(([type, count]) => (
                  <div
                    key={type}
                    className="xynolog-statistics-panel__entity-item"
                  >
                    <span className="xynolog-statistics-panel__entity-name">
                      {type}
                    </span>
                    <span className="xynolog-tag" data-variant="blue">
                      {count}
                    </span>
                  </div>
                ))}
              </div>
            </div>
          )}
        </div>
      </div>
    </div>
  );
}
