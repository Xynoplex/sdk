/**
 * Annotate Bar display forms.
 *
 * Behavior is mostly fixed (the bar IS the annotation capability); the host
 * gets freedom over its display form. `compact` is a display-only variant:
 * icon-only, tight, chromeless — the functional groups stay present and wired.
 * BrowseView's `inline` embed shows the compact bar automatically. Theming
 * (xynoplex-* classes + CSS vars) and labels (i18n) have their own mechanisms —
 * `compact` adds no API for those.
 */
import { resourceId, EventBus } from '@xynoplex/core';
import { describe, it, expect, vi } from 'vitest';
import { screen } from '@testing-library/react';
import { renderInEnglish, englishTranslationManager } from '../../../test-utils';
import '@testing-library/jest-dom';
import { readFileSync } from 'node:fs';
import { resolve } from 'node:path';
import type { XynoplexSession } from '@xynoplex/sdk';
import { AnnotateToolbar } from '../AnnotateToolbar';
import { ANNOTATORS } from '../../../lib/annotation-registry';
import { BrowseView } from '../../resource/BrowseView';

vi.mock('react-markdown', () => ({ default: ({ children }: { children: string }) => <div>{children}</div> }));
vi.mock('remark-gfm', () => ({ default: () => ({}) }));

const emptyAnnotations = { highlights: [], references: [], assessments: [], comments: [], tags: [] };

function fakeSession(): XynoplexSession {
  return {
    client: { bus: new EventBus(), browse: { click: vi.fn() }, beckon: { hover: vi.fn() } },
  } as unknown as XynoplexSession;
}

const toolbarProps = {
  selectedMotivation: null,
  selectedClick: 'detail' as const,
  annotateMode: false,
  annotators: ANNOTATORS,
  session: null,
};

describe('Annotate Bar display forms', () => {
  it('`compact` adds the display modifier; default does not', () => {
    const { container: normal } = renderInEnglish(<AnnotateToolbar {...toolbarProps} />);
    expect(normal.querySelector('.xynoplex-annotate-toolbar')).not.toHaveClass('xynoplex-annotate-toolbar--compact');

    const { container } = renderInEnglish(<AnnotateToolbar {...toolbarProps} compact />);
    expect(container.querySelector('.xynoplex-annotate-toolbar')).toHaveClass('xynoplex-annotate-toolbar--compact');
  });

  it('compact is display-only: the functional groups are still present', () => {
    renderInEnglish(<AnnotateToolbar {...toolbarProps} compact />);
    // Groups render with their aria labels (the English translations `renderInEnglish` mounts).
    expect(screen.getByLabelText(/mode/i)).toBeInTheDocument();
    expect(screen.getByLabelText(/click/i)).toBeInTheDocument();
  });

  it('BrowseView inline embeds show the compact bar automatically', () => {
    const props = {
      content: 'x', mimeType: 'text/plain', resourceUri: resourceId('res-1'),
      annotations: emptyAnnotations, annotateMode: false, session: fakeSession(),
    };
    const { container: pane } = renderInEnglish(<BrowseView translationManager={englishTranslationManager} {...props} />);
    expect(pane.querySelector('.xynoplex-annotate-toolbar')).not.toHaveClass('xynoplex-annotate-toolbar--compact');

    const { container } = renderInEnglish(<BrowseView translationManager={englishTranslationManager} {...props} inline />);
    expect(container.querySelector('.xynoplex-annotate-toolbar')).toHaveClass('xynoplex-annotate-toolbar--compact');
  });

  it('stylesheet carries the compact form (static gate — icon-only, chromeless)', () => {
    const css = readFileSync(resolve(process.cwd(), 'src/components/toolbar/Toolbar.css'), 'utf8');
    expect(css).toMatch(/\.xynoplex-annotate-toolbar--compact\s*\{/);

    // Icon-only VISUALLY, but the label stays in the accessibility tree: its
    // sibling is a bare emoji span with no accessible name, so `display: none`
    // would leave the collapsed trigger unnamed for screen readers. The
    // clipped-1px technique (same as .xynoplex-sr-only) is the contract.
    const compactLabel = css.match(
      /\.xynoplex-annotate-toolbar--compact\s+\.xynoplex-dropdown-label\s*\{([^}]*)\}/,
    );
    expect(compactLabel).not.toBeNull();
    expect(compactLabel![1]).toMatch(/clip:\s*rect\(0,\s*0,\s*0,\s*0\)/);
    expect(compactLabel![1]).not.toMatch(/display:\s*none/);
  });
});
