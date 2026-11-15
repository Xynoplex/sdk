import { describe, it, expect, beforeEach, vi } from 'vitest';
import { screen } from '@testing-library/react';
import '@testing-library/jest-dom';
import { renderWithProviders, createTestXynologWrapper } from '../../../../test-utils';
import userEvent from '@testing-library/user-event';
import type { XynologSession } from '@xynolog/sdk';

import type { Annotation, AnnotationId, EventBus } from '@xynolog/core';

// Mock @xynolog/http-transport
vi.mock('@xynolog/core', async () => {
  const actual = await vi.importActual('@xynolog/core');
  return {
    ...actual,
    getAnnotationExactText: vi.fn(),
  };
});

import { getAnnotationExactText, resourceId } from '@xynolog/core';
import type { MockedFunction } from 'vitest';
import { HighlightEntry } from '../HighlightEntry';

const mockGetAnnotationExactText = getAnnotationExactText as MockedFunction<typeof getAnnotationExactText>;

const createMockHighlight = (overrides?: Partial<Annotation>): Annotation => ({
  '@context': 'http://www.w3.org/ns/anno.jsonld',
  id: 'highlight-1' as AnnotationId,
  type: 'Annotation',
  motivation: 'highlighting',
  creator: {
    '@type': 'Person',
    name: 'alice@example.com',
  },
  created: '2024-06-15T12:00:00Z',
  modified: '2024-06-15T12:00:00Z',
  target: {
    source: resourceId('resource-1'),
    selector: {
      type: 'TextPositionSelector',
      start: 0,
      end: 50,
    },
  },
  ...overrides,
});

describe('HighlightEntry', () => {
  const defaultProps = {
    highlight: createMockHighlight(),
    isFocused: false,
  };

  // Created per-test: test-utils disposes every created client in a
  // module-scope afterEach, so a module-scope session would be dead
  // after the first test.
  let session: XynologSession;
  let eventBus: EventBus;

  beforeEach(() => {
    vi.clearAllMocks();
    mockGetAnnotationExactText.mockReturnValue('This is the highlighted text');
    ({ session, eventBus } = createTestXynologWrapper());
  });

  describe('Rendering', () => {
    it('should render the selected text in quotes', () => {
      renderWithProviders(<HighlightEntry {...defaultProps} session={session} />);

      expect(screen.getByText(/This is the highlighted text/)).toBeInTheDocument();
    });

    it('should truncate text over 200 characters', () => {
      const longText = 'A'.repeat(250);
      mockGetAnnotationExactText.mockReturnValue(longText);

      renderWithProviders(<HighlightEntry {...defaultProps} session={session} />);

      // Should show first 200 chars followed by ellipsis
      expect(screen.getByText(new RegExp(`"${'A'.repeat(200)}`))).toBeInTheDocument();
      expect(screen.getByText(/\.\.\./)).toBeInTheDocument();
    });

    it('should not truncate text at exactly 200 characters', () => {
      const exactText = 'B'.repeat(200);
      mockGetAnnotationExactText.mockReturnValue(exactText);

      const { container } = renderWithProviders(<HighlightEntry {...defaultProps} session={session} />);

      const quote = container.querySelector('.xynolog-annotation-entry__quote');
      expect(quote).toBeInTheDocument();
      expect(quote!.textContent).not.toContain('...');
    });

    it('should show creator name', () => {
      renderWithProviders(<HighlightEntry {...defaultProps} session={session} />);

      expect(screen.getByText(/alice@example.com/)).toBeInTheDocument();
    });

    it('names no creator when the highlight has none', () => {
      const highlight = createMockHighlight();
      delete (highlight as Record<string, unknown>).creator;

      const { container } = renderWithProviders(
        <HighlightEntry highlight={highlight} isFocused={false} session={session} />
      );

      const metadata = container.querySelector('.xynolog-annotation-entry__metadata');
      expect(metadata).toBeInTheDocument();
      expect(metadata?.textContent).not.toMatch(/By|Unknown/);
    });

    it('should format relative time', () => {
      const recentHighlight = createMockHighlight({
        created: new Date(Date.now() - 30000).toISOString(),
      });

      renderWithProviders(
        <HighlightEntry highlight={recentHighlight} isFocused={false} session={session} />
      );

      expect(screen.getByText(/just now/)).toBeInTheDocument();
    });

    it('should not render quote section when selectedText is empty', () => {
      mockGetAnnotationExactText.mockReturnValue('');

      const { container } = renderWithProviders(<HighlightEntry {...defaultProps} session={session} />);

      expect(container.querySelector('.xynolog-annotation-entry__quote')).not.toBeInTheDocument();
    });
  });

  describe('Interactions', () => {
    it('should emit browse:click on click', async () => {
      const clickHandler = vi.fn();

      // The component only sees the `session` prop, so the assertion
      // must subscribe on that same session's bus — not the bus of the
      // wrapper renderWithProviders creates internally.
      const { container } = renderWithProviders(
        <HighlightEntry {...defaultProps} session={session} />
      );

      const subscription = eventBus.on('browse:click').subscribe(clickHandler);

      const entry = container.firstChild as HTMLElement;
      await userEvent.click(entry);

      expect(clickHandler).toHaveBeenCalledWith({
        annotationId: 'highlight-1',
      });

      subscription.unsubscribe();
    });
  });

  describe('Hover state', () => {
    it('should apply pulse class when isHovered is true', () => {
      const { container } = renderWithProviders(
        <HighlightEntry {...defaultProps} isHovered={true} session={session} />
      );

      const entry = container.firstChild as HTMLElement;
      expect(entry).toHaveClass('xynolog-annotation-pulse');
    });

    it('should not apply pulse class when isHovered is false', () => {
      const { container } = renderWithProviders(
        <HighlightEntry {...defaultProps} isHovered={false} session={session} />
      );

      const entry = container.firstChild as HTMLElement;
      expect(entry).not.toHaveClass('xynolog-annotation-pulse');
    });
  });

  describe('Focus state', () => {
    it('should set data-focused to true when focused', () => {
      const { container } = renderWithProviders(
        <HighlightEntry {...defaultProps} isFocused={true} session={session} />
      );

      const entry = container.firstChild as HTMLElement;
      expect(entry).toHaveAttribute('data-focused', 'true');
    });

    it('should set data-focused to false when not focused', () => {
      const { container } = renderWithProviders(
        <HighlightEntry {...defaultProps} isFocused={false} session={session} />
      );

      const entry = container.firstChild as HTMLElement;
      expect(entry).toHaveAttribute('data-focused', 'false');
    });
  });
});
