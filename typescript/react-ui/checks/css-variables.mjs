/**
 * Every `var(--x)` resolves to a `--x:` some stylesheet defines.
 *
 * WHY THIS IS NOT A STYLELINT RULE. Stylelint lints one file at a time, and a
 * `var()` in a component's CSS is *supposed* to be satisfied by a token file
 * it never imports, so per-file analysis cannot tell "defined elsewhere" from
 * "defined nowhere" without whole-project knowledge stylelint does not have.
 * Its nearest built-in, `custom-property-no-missing-var-function`, catches the
 * opposite mistake (`color: --x` with no `var()`). There is no core rule for
 * undefined references, which is why 46 of them accumulated silently.
 *
 * WHY IT MATTERS THAT NOTHING ERRORS. An unresolved `var()` with no fallback
 * makes the declaration invalid at computed-value time: the property silently
 * takes its inherited or initial value. A border becomes `currentColor`, a
 * background becomes transparent. The page looks nearly right and cannot be
 * themed, with no console warning and no failing build.
 *
 * Inline fallbacks, `var(--x, #fff)`, are allowed and not reported: those are
 * deliberate optional theming hooks a host may override.
 *
 * react-ui's own stylesheets resolve among themselves. A host's resolve among
 * its own and the ones react-ui ships, which a host imports.
 */
import { packageStylesheets } from './source-tree.mjs';

export const name = 'every var() resolves to a defined custom property';

const DEFINITION = /^\s*(--[a-zA-Z0-9_-]+)\s*:/gm;
// The delimiter tells `var(--x, fallback)` from `var(--x)`.
const USAGE = /var\(\s*(--[a-zA-Z0-9_-]+)\s*([,)])/g;

export function check(tree) {
  const sheets = tree.files.filter((file) => file.endsWith('.css'))
    .map((file) => ({ name: tree.show(file), text: tree.read(file) }));
  if (sheets.length === 0) return { failures: ['no stylesheet to check'], notes: [] };

  const defined = new Set();
  for (const { text } of tree.own ? sheets : [...sheets, ...packageStylesheets()]) {
    for (const m of text.matchAll(DEFINITION)) defined.add(m[1]);
  }

  const missing = new Map(); // name -> sites
  for (const { name: sheet, text } of sheets) {
    text.split('\n').forEach((line, i) => {
      for (const [, property, delimiter] of line.matchAll(USAGE)) {
        if (delimiter === ',' || defined.has(property)) continue;
        if (!missing.has(property)) missing.set(property, []);
        missing.get(property).push(`${sheet}:${i + 1}`);
      }
    });
  }

  const failures = [...missing].sort().map(([property, sites]) =>
    `${property}, used at ${sites.slice(0, 3).join(', ')}${sites.length > 3 ? ` and ${sites.length - 3} more` : ''}`);
  const notes = failures.length === 0
    ? [`${defined.size} custom properties defined, ${sheets.length} stylesheets read`]
    : ['Define the token (react-ui: styles/variables.css, in every theme block) or point the usage at one that exists. Do not silence this with an inline fallback at each usage.'];
  return { failures, notes };
}
