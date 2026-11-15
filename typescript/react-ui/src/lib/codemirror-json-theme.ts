/**
 * The CodeMirror theme of the JSON views, `JsonLdView` (popups) and
 * `JsonLdPanel` (sidebar), for light and dark alike.
 *
 * Every colour is a CSS variable of `styles/variables.css`, so the page's
 * `data-theme` attribute picks them, as it picks every other colour, and the
 * views read no theme of their own. The frame takes the page's background,
 * text and gutter colours; the syntax takes the `--xynolog-json-*` ones.
 */

import { EditorView } from '@codemirror/view';
import { HighlightStyle } from '@codemirror/language';
import { tags as t } from '@lezer/highlight';

export const jsonTheme = EditorView.theme({
  '&': {
    backgroundColor: 'var(--xynolog-bg-primary)',
    color: 'var(--xynolog-text-primary)',
  },
  '.cm-content': {
    caretColor: 'var(--xynolog-text-primary)',
  },
  '.cm-cursor, .cm-dropCursor': {
    borderLeftColor: 'var(--xynolog-text-primary)',
  },
  '&.cm-focused .cm-selectionBackground, .cm-selectionBackground, .cm-content ::selection': {
    backgroundColor: 'var(--xynolog-bg-tertiary)',
  },
  '.cm-gutters': {
    backgroundColor: 'var(--xynolog-bg-secondary)',
    color: 'var(--xynolog-text-tertiary)',
    border: 'none',
  },
});

export const jsonHighlightStyle = HighlightStyle.define([
  { tag: t.string, color: 'var(--xynolog-json-string)' },
  { tag: t.number, color: 'var(--xynolog-json-number)' },
  { tag: [t.bool, t.null, t.keyword], color: 'var(--xynolog-json-literal)' },
  { tag: t.propertyName, color: 'var(--xynolog-json-property)' },
  { tag: [t.punctuation, t.bracket], color: 'var(--xynolog-json-punctuation)' },
]);
