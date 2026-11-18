'use client';

import type { GatheredContext } from '@xynolog/core';

export interface CorpusPaneTranslations {
  corpusPaneTitle: string;
  /** Strategy-relevant empty state — emptiness is evidence. */
  corpusEmpty: string;
  /** Label for the match's cosine score. */
  score: string;
  /** The filter receipt; interpolates `{{types}}`. */
  excludedReceipt: string;
  /** The trust marker for machine-read (OCR) sources. */
  machineRead: string;
}

export interface CorpusPaneProps {
  semanticContext: GatheredContext['semanticContext'];
  translations: CorpusPaneTranslations;
}

/**
 * The corpus pane: latent knowledge — ranked `SemanticMatch` cards,
 * read-only. THE datum for Search-vs-Generate ("does the KB already discuss
 * this?"). This is recall-at-gather evidence, not a preview of Search: the
 * matcher re-runs fresh (selected text + hint, scoring) and may rank
 * differently.
 *
 * Read-only by decision: per-match actions belong to the footer's fork or a
 * designed extension of it, never ad-hoc buttons here.
 */
export function CorpusPane({
  semanticContext,
  translations: t,
}: CorpusPaneProps) {
  // Descending by score, whatever order the wire delivered.
  const matches = [...(semanticContext?.similar ?? [])].sort(
    (a, b) => b.score - a.score,
  );
  const excluded = semanticContext?.excludedEntityTypes ?? [];

  return (
    <div className="xynolog-gather-pane xynolog-gather-pane--corpus">
      <div className="xynolog-gather-pane__title">{t.corpusPaneTitle}</div>
      {matches.length === 0 ? (
        <p className="xynolog-gather-pane__empty">{t.corpusEmpty}</p>
      ) : (
        <ul className="xynolog-corpus__list">
          {matches.map((m, i) => (
            <li key={`${m.resourceId}-${i}`} className="xynolog-corpus__card">
              <div className="xynolog-corpus__card-head">
                <span className="xynolog-corpus__source">{m.resourceName}</span>
                {(m.entityTypes ?? []).map((et) => (
                  <span
                    key={et}
                    className="xynolog-chip"
                    style={{
                      fontSize: 'var(--xynolog-text-xs)',
                      padding: '0.125rem 0.375rem',
                      fontWeight: 400,
                    }}
                  >
                    {et}
                  </span>
                ))}
                {m.machineRead && (
                  <span
                    className="xynolog-chip xynolog-corpus__trust"
                    style={{
                      fontSize: 'var(--xynolog-text-xs)',
                      padding: '0.125rem 0.375rem',
                      fontWeight: 400,
                    }}
                  >
                    {t.machineRead}
                  </span>
                )}
                {/* 0–1 cosine to two places — deliberately NOT the search step's
                    raw render, which is a different scale. */}
                <span className="xynolog-corpus__score">
                  {t.score}: {m.score.toFixed(2)}
                </span>
              </div>
              <p className="xynolog-corpus__snippet">{m.text}</p>
            </li>
          ))}
        </ul>
      )}
      {excluded.length > 0 && (
        <p className="xynolog-corpus__receipt">
          {t.excludedReceipt.replace('{{types}}', excluded.join(', '))}
        </p>
      )}
    </div>
  );
}
