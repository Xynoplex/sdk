/**
 * Media-completeness sweep.
 *
 * ONE mounted component (`ResourceViewer`, inline, bare session, no providers)
 * renders every standard media type from the DEFAULTS — text, markdown, image,
 * pdf — with the annotation-overlay container present and zero per-type wiring.
 * (Formatted-markdown correctness is pinned by browse-renderers.test; visual
 * overlay alignment is a manual, live smoke-test. This sweep pins the routing
 * parity: every type reaches its renderer from one component.)
 */
import { describe, it, expect, vi } from 'vitest';
import { screen } from '@testing-library/react';
import { renderInEnglish, englishTranslationManager } from '../../../test-utils';
import '@testing-library/jest-dom';
import type { XynoplexSession } from '@xynoplex/sdk';
import { EventBus } from '@xynoplex/core';
import type { ResourceDescriptor as XynoplexResource, ResourceId } from '@xynoplex/core';
import { ResourceViewer } from '../ResourceViewer';

vi.mock('react-markdown', () => ({ default: ({ children }: { children: string }) => <div data-testid="md">{children}</div> }));
vi.mock('remark-gfm', () => ({ default: () => ({}) }));
// pdfjs can't load in jsdom — the sweep pins ROUTING to the pdf renderer, not pdf.js itself.
vi.mock('../../pdf-annotation/PdfAnnotationCanvas.client', () => ({
  PdfAnnotationCanvas: ({ pdfUrl }: { pdfUrl: string }) => <div data-testid="pdf-canvas">{pdfUrl}</div>,
}));

const emptyAnnotations = { highlights: [], references: [], assessments: [], comments: [], tags: [] };

function fakeSession(): XynoplexSession {
  return {
    client: {
      bus: new EventBus(),
      // The image canvas asks for the resource's text, in browse mode too.
      browse: { click: vi.fn(), resourceAnchoredText: vi.fn().mockResolvedValue({ kind: 'no-map' }) },
      beckon: { hover: vi.fn() },
    },
  } as unknown as XynoplexSession;
}

function makeResource(mediaType: string, content: string): XynoplexResource & { content: string } {
  return {
    '@context': 'https://www.w3.org/ns/activitystreams',
    '@id': 'res-1' as ResourceId,
    name: 'Doc',
    created: '2024-01-01T00:00:00Z',
    entityTypes: [],
    archived: false,
    representations: [{ mediaType, byteSize: 10 }],
    content,
  };
}

function mount(mediaType: string, content: string) {
  return renderInEnglish(
    <ResourceViewer
      translationManager={englishTranslationManager}
      resource={makeResource(mediaType, content)}
      annotations={emptyAnnotations}
      session={fakeSession()}
      inline
    />,
  );
}

describe('media-completeness sweep — one component, all types, inline, defaults only', () => {
  it.each([
    ['text/plain', 'plain body'],
    ['text/markdown', '# md body'],
  ])('%s renders via the text default with the overlay container', (mt, content) => {
    const { container } = mount(mt, content);
    expect(container.querySelector('.xynoplex-browse-view[data-mime-type="text"]')).toBeInTheDocument();
    expect(screen.getByTestId('md')).toHaveTextContent(content.replace('# ', '# ').trim());
    expect(container.querySelector('.xynoplex-browse-view__content')).toBeInTheDocument(); // overlay anchor
    expect(container.querySelector('.xynoplex-browse-view')).toHaveClass('xynoplex-browse-view--inline');
  });

  it('image/png renders via the image default', () => {
    const { container } = mount('image/png', 'https://media.test/img.png?token=t');
    expect(container.querySelector('.xynoplex-browse-view[data-mime-type="image"]')).toBeInTheDocument();
    expect(container.querySelector('img')).toBeInTheDocument();
    expect(container.querySelector('.xynoplex-browse-view__content')).toBeInTheDocument();
  });

  it('application/pdf routes to the pdf default', async () => {
    const { container } = mount('application/pdf', 'https://media.test/doc.pdf?token=t');
    expect(container.querySelector('.xynoplex-browse-view[data-mime-type="pdf"]')).toBeInTheDocument();
    expect(await screen.findByTestId('pdf-canvas')).toHaveTextContent('https://media.test/doc.pdf?token=t');
  });

  it('an unknown type degrades to metadata + download (no crash, no per-type wiring)', () => {
    const { container } = mount('application/octet-stream', '');
    expect(container.querySelector('[data-mime-type="unsupported"]')).toBeInTheDocument();
    expect(screen.getByText(/Preview not available/)).toBeInTheDocument();
  });
});
