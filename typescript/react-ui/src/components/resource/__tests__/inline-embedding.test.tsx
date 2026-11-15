/**
 * Inline embedding.
 *
 * `inline` is a display variant (default: the pane behavior): the viewer
 * renders at content height in a bare container — no
 * inner scroll container, no pane chrome. jsdom can't compute stylesheet
 * layout, so this spec pins the two testable seams: (1) the components emit
 * the `--inline` modifier classes; (2) the stylesheet contains the inline
 * overrides (height:auto / overflow:visible / padding drop). The visual
 * auto-height check is a manual, live smoke-test.
 */
import { resourceId, EventBus } from '@xynolog/core';
import { describe, it, expect, vi } from 'vitest';
import { renderInEnglish, englishTranslationManager } from '../../../test-utils';
import '@testing-library/jest-dom';
import { readFileSync } from 'node:fs';
import { resolve } from 'node:path';
import type { XynologSession } from '@xynolog/sdk';
import type { ResourceDescriptor as XynologResource, ResourceId } from '@xynolog/core';
import { BrowseView } from '../BrowseView';
import { ResourceViewer } from '../ResourceViewer';

vi.mock('../../annotation/AnnotateToolbar', () => ({ AnnotateToolbar: () => null }));
vi.mock('react-markdown', () => ({ default: ({ children }: { children: string }) => <div>{children}</div> }));
vi.mock('remark-gfm', () => ({ default: () => ({}) }));

const emptyAnnotations = { highlights: [], references: [], assessments: [], comments: [], tags: [] };

function fakeSession(): XynologSession {
  return {
    client: { bus: new EventBus(), browse: { click: vi.fn() }, beckon: { hover: vi.fn() } },
  } as unknown as XynologSession;
}

const resource: XynologResource & { content: string } = {
  '@context': 'https://www.w3.org/ns/activitystreams',
  '@id': 'res-1' as ResourceId,
  name: 'Doc',
  created: '2024-01-01T00:00:00Z',
  entityTypes: [],
  archived: false,
  representations: [{ mediaType: 'text/plain', byteSize: 10 }],
  content: 'Inline content.',
};

describe('inline embedding', () => {
  it('BrowseView: `inline` adds the modifier class; default does not', () => {
    const props = {
      content: 'x', mimeType: 'text/plain', resourceUri: resourceId('res-1'),
      annotations: emptyAnnotations, annotateMode: false, session: fakeSession(),
    };
    const { container: pane } = renderInEnglish(<BrowseView translationManager={englishTranslationManager} {...props} />);
    expect(pane.querySelector('.xynolog-browse-view')).not.toHaveClass('xynolog-browse-view--inline');

    const { container } = renderInEnglish(<BrowseView translationManager={englishTranslationManager} {...props} inline />);
    expect(container.querySelector('.xynolog-browse-view')).toHaveClass('xynolog-browse-view--inline');
  });

  it('ResourceViewer: `inline` marks its root and threads to BrowseView', () => {
    const { container } = renderInEnglish(
      <ResourceViewer
        translationManager={englishTranslationManager}
        resource={resource} annotations={emptyAnnotations}
        session={fakeSession()} inline
      />,
    );
    expect(container.querySelector('.xynolog-resource-viewer')).toHaveClass('xynolog-resource-viewer--inline');
    expect(container.querySelector('.xynolog-browse-view')).toHaveClass('xynolog-browse-view--inline');
  });

  it('stylesheet carries the inline overrides (static gate — layout itself is the live check)', () => {
    // vitest runs with cwd = the package root (same in CI's per-workspace run).
    const css = readFileSync(resolve(process.cwd(), 'src/styles/features/resource-viewer.css'), 'utf8');
    // Auto-height roots, and the content area stops being a scroll container / drops the pane gutter.
    expect(css).toMatch(/\.xynolog-resource-viewer--inline\s*\{[^}]*height:\s*auto/);
    expect(css).toMatch(/\.xynolog-browse-view--inline\s*\{[^}]*height:\s*auto/);
    expect(css).toMatch(/\.xynolog-browse-view--inline\s+\.xynolog-browse-view__content\s*\{[^}]*overflow:\s*visible/);
    expect(css).toMatch(/\.xynolog-browse-view--inline\s+\.xynolog-browse-view__content\s*\{[^}]*padding:\s*0/);
  });
});
