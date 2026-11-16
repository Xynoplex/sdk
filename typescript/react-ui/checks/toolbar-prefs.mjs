/**
 * Toolbar preferences are stored in one place.
 *
 * The preferences (mode, click action, selection motivation, shape) are React
 * state that flows through controlled props. Their localStorage persistence
 * lives in react-ui's policy layer alone: `useToolbarPrefs()`, and the
 * per-selector-type shape helpers in media-shapes it delegates to. A component
 * that reads or writes the keys itself made the preferences implicit global
 * mutable state: flips nothing scoped, drift between mounts, hosts setting
 * private keys by name.
 *
 * Tests, which seed and assert the keys, are not read.
 */
export const name = 'toolbar preferences are stored by useToolbarPrefs alone';

const POLICY_LAYER = new Set(['hooks/useToolbarPrefs.ts', 'lib/media-shapes.ts']);
const KEYS = /xynolog-toolbar-click|xynolog-toolbar-selection|xynolog-toolbar-shape|localStorage\.(get|set)Item\('annotateMode'/;

export function check(tree) {
  const failures = [];
  const read = tree.files.filter((file) => /\.tsx?$/.test(file)
    && !file.includes('__tests__/') && !file.includes('.test.')
    && !(tree.own && POLICY_LAYER.has(file)));
  for (const file of read) {
    tree.read(file).split('\n').forEach((line, i) => {
      if (KEYS.test(line)) {
        failures.push(`${tree.show(file)}:${i + 1}: a toolbar preference's storage key outside useToolbarPrefs(); components take preferences as controlled props`);
      }
    });
  }
  return { failures, notes: [] };
}
