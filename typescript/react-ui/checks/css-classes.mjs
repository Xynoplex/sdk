/**
 * Questions about the stylesheet set that no single-file linter can answer:
 * is each class defined in ONE file, is it rendered by any markup, and, the
 * reverse, does each class the markup renders actually HAVE any CSS?
 *
 * The third is not optional: a gate that only looks for CSS nobody renders is
 * blind to markup nobody styles, and a component whose classes exist in no
 * stylesheet renders as unstyled text on the page background, very nearly
 * invisible in dark mode, under a green build.
 *
 * WHY THIS IS NOT A STYLELINT RULE. Stylelint lints one file at a time.
 * "Defined twice" spans files, and "rendered nowhere" spans languages: the
 * answer lives in TSX.
 *
 * WHY IT MATTERS. A duplicate definition means every change has to be made N
 * times, and whichever copy you miss silently wins or loses on import order.
 * A rule for a class nobody renders is dead weight that still gets read,
 * maintained, and dutifully given a dark-theme variant.
 *
 * Class names built by concatenation (`xynolog-${kind}-badge`) cannot be seen
 * by a grep, so a class is also considered live if its literal prefix appears
 * in a template string. That is deliberately permissive: this gate exists to
 * catch the obvious, not to be clever.
 *
 * REACT-UI'S OWN SOURCE is held to a baseline, not to zero
 * (css-classes-baseline.json). It holds the debt the tree carries; the gate
 * fails on anything new, and on an entry that got fixed without being removed
 * from it, so the debt can only shrink. Nothing may be added to it.
 *
 * A HOST is an app that renders react-ui's classes itself. The classes
 * react-ui styles for hosts, and renders nowhere itself, are
 * host-classes.json, each with the reason it is there. react-ui's own source
 * cannot see a host render one, so they are exempt there from "rendered by no
 * markup"; and each must be one react-ui styles. A host's source is read
 * beside the stylesheets react-ui ships, and fails on what is wrong in the
 * host: a class its markup renders that no stylesheet styles, a class of
 * react-ui's it renders that react-ui does not offer to hosts and the host
 * does not style itself, and duplicates and unrendered classes among its own
 * stylesheets. No host can show that a class on the list is dead: another
 * host may render it.
 */
import { readFileSync } from 'node:fs';
import { packageStylesheets } from './source-tree.mjs';

export const name = 'every class is styled once and rendered, and every rendered class is styled';

const BASELINE_FILE = new URL('./css-classes-baseline.json', import.meta.url);
const HOST_CLASSES = new Map(Object.entries(JSON.parse(readFileSync(new URL('./host-classes.json', import.meta.url), 'utf8'))));

const DEFINITION = /\.(xynolog-[a-zA-Z0-9_-]+)/g;
const RENDERED = /xynolog-[a-zA-Z0-9_-]+/g;

/**
 * Walk a stylesheet, tracking whether we are inside an at-rule. A rule nested
 * in `@media (prefers-reduced-motion: reduce)` or `@media (prefers-contrast:
 * more)` is a CONDITIONAL variant of a class, not a second definition of it:
 * the accessibility layers are built entirely that way on purpose.
 *
 * Calls `defines(cls)` for each bare `.xynolog-x { }` rule outside an at-rule,
 * and `mentions(cls)` for each class any selector names.
 */
function scan(source, defines, mentions) {
  // Comments first: a section banner sitting above `@media` ends up in the
  // same selector-head buffer, and `'/* … */ @media'.startsWith('@')` is
  // false, so an unstripped comment silently turns a whole conditional layer
  // into "definitions".
  const css = source.replace(/\/\*[\s\S]*?\*\//g, ' ');
  let depth = 0;
  let atDepth = null;
  let buf = '';
  for (const ch of css) {
    if (ch === '{') {
      const head = buf.trim();
      depth++;
      if (head.startsWith('@')) {
        if (atDepth === null) atDepth = depth;
      } else {
        for (const part of head.split(',')) {
          const selector = part.trim();
          const own = /^\.(xynolog-[a-zA-Z0-9_-]+)$/.exec(selector);
          if (own && atDepth === null) defines(own[1]);
          for (const cls of selector.matchAll(DEFINITION)) mentions(cls[1]);
        }
      }
      buf = '';
    } else if (ch === '}') {
      if (atDepth !== null && depth === atDepth) atDepth = null;
      depth--;
      buf = '';
    } else {
      buf += ch;
    }
  }
}

/**
 * The `xynolog-` names in a source file that are actually CLASSES.
 *
 * A bare scan cannot be used here. The prefix is also worn by CSS custom
 * properties (`--xynolog-color-primary-500`), localStorage keys
 * (`xynolog-toolbar-click`, `xynolog-panel-width`) and assorted identifiers,
 * none of which any stylesheet should define. Being loose here ACCUSES, where
 * being loose about what is rendered only spares a class from being called
 * dead, so this side is strict.
 */
function classNamesIn(rawSource) {
  const names = new Set();
  // Data attributes wear the same prefix: `data-testid="xynolog-delegate-bar"`
  // is a TEST HOOK, never a class. They sit inches from a `className`, so the
  // window below would otherwise accuse every one of them.
  const source = rawSource.replace(/data-[a-z-]+\s*=\s*(?:"[^"]*"|'[^']*'|\{[^}]*\})/g, ' ');
  // In a className position: `className="a b"`, `className={cn('a', x)}`,
  // `` className={`a ${b}`} ``. A window, because the expression forms vary.
  for (const at of source.matchAll(/className/g)) {
    const window = source.slice(at.index, at.index + 200);
    for (const t of window.matchAll(RENDERED)) {
      // `--xynolog-x` is a custom property, not a class.
      if (window[t.index - 1] === '-') continue;
      // `xynolog-badge-${kind}` is a concatenation PREFIX, not a class.
      if (window.startsWith('${', t.index + t[0].length)) continue;
      // A name touching the window's edge was CUT by it, a fragment no
      // stylesheet could define. Dropping it loses a class ending exactly at
      // the edge, which is the right way to be wrong for a check that accuses.
      if (t.index + t[0].length >= window.length) continue;
      names.add(t[0]);
    }
  }
  // Selector form: `querySelector('.xynolog-x')`, `closest('.xynolog-x')`.
  for (const m of source.matchAll(/\.(xynolog-[a-zA-Z0-9_-]+)/g)) names.add(m[1]);
  return names;
}

const add = (map, key, value) => {
  if (!map.has(key)) map.set(key, new Set());
  map.get(key).add(value);
};

/** Whether markup renders `cls`: by its full name, or by a prefix a template string completes. */
const renders = (markup, cls) => markup.includes(cls) || cls.split('-').some((_, i, parts) => {
  const prefix = parts.slice(0, parts.length - i).join('-');
  return prefix.length > 'xynolog-'.length + 3 && markup.includes(`${prefix}-\${`);
});

const listed = (entries) => entries.map(([cls, files]) => `.${cls}  (${[...files].join(', ')})`);

export function check(tree) {
  const hostSheets = tree.files.filter((file) => file.endsWith('.css') && !file.includes('variables.css'))
    .map((file) => ({ name: tree.show(file), text: tree.read(file), host: !tree.own }));
  const sheets = tree.own
    ? hostSheets
    : [...hostSheets, ...packageStylesheets().filter(({ name: sheet }) => !sheet.includes('variables.css')).map((sheet) => ({ ...sheet, host: false }))];

  const definedIn = new Map(); // class -> stylesheets with a bare rule for it
  const mentionedIn = new Map(); // class -> stylesheets with any selector naming it
  for (const sheet of sheets) {
    scan(sheet.text, (cls) => add(definedIn, cls, sheet.name), (cls) => add(mentionedIn, cls, sheet.name));
  }
  const hostSheetNames = new Set(sheets.filter((sheet) => sheet.host).map((sheet) => sheet.name));

  // A test that names a class asserts what a component renders; it renders
  // nothing for anyone, so it keeps no class alive and needs none styled.
  let markup = '';
  const renderedIn = new Map(); // class -> markup files that render it
  for (const file of tree.files.filter((file) => /\.tsx?$/.test(file) && !file.includes('__tests__/') && !/\.(test|spec)\.tsx?$/.test(file))) {
    const source = tree.read(file);
    markup += source;
    for (const cls of classNamesIn(source)) add(renderedIn, cls, tree.show(file));
  }

  const failures = [];
  const fail = (problem, entries) => {
    if (entries.length > 0) failures.push(`${problem}:`, ...listed(entries).map((line) => `  ${line}`));
  };
  const sorted = (map) => [...map].sort(([a], [b]) => a.localeCompare(b));
  const duplicated = sorted(definedIn).filter(([, files]) => files.size > 1);
  const unstyled = sorted(renderedIn).filter(([cls]) => !mentionedIn.has(cls));

  if (!tree.own) {
    fail('defined in more than one stylesheet, one of them this app\'s (one file owns a class)',
      duplicated.filter(([, files]) => [...files].some((file) => hostSheetNames.has(file))));
    fail('styled by this app and rendered by none of its markup (delete the rules)',
      sorted(mentionedIn).filter(([cls, files]) => [...files].every((file) => hostSheetNames.has(file)) && !renders(markup, cls)));
    fail('rendered and styled nowhere: the element renders unstyled, which on a themed background can mean invisible',
      unstyled);
    fail('react-ui\'s own, which it does not offer to hosts (host-classes.json), and this app does not style',
      sorted(renderedIn).filter(([cls]) => mentionedIn.has(cls) && !HOST_CLASSES.has(cls)
        && ![...mentionedIn.get(cls)].some((file) => hostSheetNames.has(file))));
    return { failures, notes: [] };
  }

  const baseline = JSON.parse(readFileSync(BASELINE_FILE, 'utf8'));
  const unrendered = sorted(mentionedIn).filter(([cls]) => !HOST_CLASSES.has(cls) && !renders(markup, cls));
  const ownUnstyled = unstyled.filter(([cls]) => !HOST_CLASSES.has(cls));
  const fixed = [
    ...baseline.duplicated.filter((cls) => !duplicated.some(([found]) => found === cls)),
    ...baseline.unrendered.filter((cls) => !unrendered.some(([found]) => found === cls)),
    ...baseline.unstyled.filter((cls) => !ownUnstyled.some(([found]) => found === cls)),
  ];
  fail('NEW: defined in more than one file (one file owns a class: delete the copies, or qualify the variant)',
    duplicated.filter(([cls]) => !baseline.duplicated.includes(cls)));
  if (fixed.length > 0) {
    failures.push('now clean, so delete them from checks/css-classes-baseline.json, so they cannot come back:',
      ...fixed.map((cls) => `  .${cls}`));
  }
  fail('NEW: styled and rendered by no markup (delete the rules, or add the class to host-classes.json with the reason)',
    unrendered.filter(([cls]) => !baseline.unrendered.includes(cls)));
  fail('NEW: rendered by markup and styled nowhere (write the rule, or fix the name)',
    ownUnstyled.filter(([cls]) => !baseline.unstyled.includes(cls)));
  const unoffered = [...HOST_CLASSES.keys()].filter((cls) => !mentionedIn.has(cls)).sort();
  if (unoffered.length > 0) {
    failures.push('in host-classes.json and styled by no stylesheet of react-ui\'s (delete the entry):',
      ...unoffered.map((cls) => `  .${cls}`));
  }
  const notes = [`${definedIn.size} classes defined, ${mentionedIn.size} styled, ${HOST_CLASSES.size} offered to hosts`];
  if (duplicated.length || unrendered.length || ownUnstyled.length) {
    notes.push(`carrying ${duplicated.length} duplicated, ${unrendered.length} unrendered and ${ownUnstyled.length} unstyled from checks/css-classes-baseline.json`);
  }
  return { failures, notes };
}
