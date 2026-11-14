/**
 * The CodeMirror theme of the JSON views, `JsonLdView` (popups) and
 * `JsonLdPanel` (sidebar), for light and dark alike.
 *
 * Every colour is a CSS variable of `styles/variables.css`, so the page's
 * `data-theme` attribute picks them, as it picks every other colour, and the
 * views read no theme of their own. The frame takes the page's background,
 * text and gutter colours; the syntax takes the `--xynoplex-json-*` ones.
 */

import { EditorView } from '@codemirror/view';
import { HighlightStyle } from '@codemirror/language';
import { tags as t } from '@lezer/highlight';

export const jsonTheme = EditorView.theme({
  '&': {
    backgroundColor: 'var(--xynoplex-bg-primary)',
    color: 'var(--xynoplex-text-primary)',
  },
  '.cm-content': {
    caretColor: 'var(--xynoplex-text-primary)',
  },
  '.cm-cursor, .cm-dropCursor': {
    borderLeftColor: 'var(--xynoplex-text-primary)',
  },
  '&.cm-focused .cm-selectionBackground, .cm-selectionBackground, .cm-content ::selection': {
    backgroundColor: 'var(--xynoplex-bg-tertiary)',
  },
  '.cm-gutters': {
    backgroundColor: 'var(--xynoplex-bg-secondary)',
    color: 'var(--xynoplex-text-tertiary)',
    border: 'none',
  },
});

export const jsonHighlightStyle = HighlightStyle.define([
  { tag: t.string, color: 'var(--xynoplex-json-string)' },
  { tag: t.number, color: 'var(--xynoplex-json-number)' },
  { tag: [t.bool, t.null, t.keyword], color: 'var(--xynoplex-json-literal)' },
  { tag: t.propertyName, color: 'var(--xynoplex-json-property)' },
  { tag: [t.punctuation, t.bracket], color: 'var(--xynoplex-json-punctuation)' },
]);
