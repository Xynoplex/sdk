'use client';
import { WizardFooter } from './WizardFooter';

import type { ResourceDescriptor, ResourceId } from '@xynolog/core';

export type ScoredResult = ResourceDescriptor & {
  score?: number;
  matchReason?: string;
};

/**
 * Pure RESULTS: ranked rows with scores and Link buttons.
 * The evidence display is the HOST's job — the wizard stacks the full
 * display-only GatherContextStep (with the collapsed strategy band) above
 * this step, the same grammar as the configure steps.
 */
export interface SearchResultsStepProps {
  results: ScoredResult[];
  onLink: (resourceId: ResourceId) => void;
  onBack: () => void;
  translations: {
    noResults: string;
    link: string;
    back: string;
    score: string;
  };
}

export function SearchResultsStep({
  results,
  onLink,
  onBack,
  translations: t,
}: SearchResultsStepProps) {
  return (
    <>
      <div className="xynolog-search-results">
        {results.length === 0 ? (
          <div className="xynolog-modal__empty-state" style={{ textAlign: 'center', padding: '2rem 0' }}>
            {t.noResults}
          </div>
        ) : (
          results.map((result) => {
            const id = result['@id'];
            return (
              <div
                key={id}
                style={{
                  padding: '0.75rem',
                  borderBottom: '1px solid var(--xynolog-border-primary)',
                  display: 'flex',
                  alignItems: 'center',
                  justifyContent: 'space-between',
                  gap: '0.75rem',
                }}
              >
                <div style={{ flex: 1, minWidth: 0 }}>
                  <div style={{ fontWeight: 500, color: 'var(--xynolog-text-primary)' }}>
                    {result.name}
                  </div>
                  {result.description && (
                    <div style={{
                      fontSize: 'var(--xynolog-text-sm)',
                      color: 'var(--xynolog-text-secondary)',
                      marginTop: '0.25rem',
                      overflow: 'hidden',
                      textOverflow: 'ellipsis',
                      whiteSpace: 'nowrap',
                    }}>
                      {result.description}
                    </div>
                  )}
                  <div style={{ fontSize: 'var(--xynolog-text-xs)', color: 'var(--xynolog-text-tertiary)', marginTop: '0.25rem', display: 'flex', gap: '0.5rem' }}>
                    {result.score !== undefined && (
                      <span>{t.score}: {result.score}</span>
                    )}
                    {result.matchReason && (
                      <span>{result.matchReason}</span>
                    )}
                  </div>
                </div>
                <button
                  type="button"
                  onClick={() => onLink(id)}
                  className="xynolog-button--primary"
                  style={{ flexShrink: 0 }}
                >
                  🔗 {t.link}
                </button>
              </div>
            );
          })
        )}
      </div>

      <WizardFooter backLabel={t.back} onBack={onBack} />
    </>
  );
}
