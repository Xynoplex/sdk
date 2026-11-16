// @vitest-environment node
/**
 * xynolog-react-ui-check, run as a host runs it: over an app's source, a git
 * repository of its own made here. The app that keeps every rule passes, and
 * each rule refuses an app that breaks it. react-ui's own source is held by
 * CI's run of the command over `src`.
 */
import { execFileSync, spawnSync } from 'node:child_process';
import { mkdirSync, mkdtempSync, rmSync, writeFileSync } from 'node:fs';
import { tmpdir } from 'node:os';
import { dirname, join } from 'node:path';
import { fileURLToPath } from 'node:url';
import { afterEach, describe, expect, it } from 'vitest';

const BIN = join(dirname(fileURLToPath(import.meta.url)), 'bin.mjs');

const made: string[] = [];
afterEach(() => {
  for (const directory of made.splice(0)) rmSync(directory, { recursive: true, force: true });
});

/** A git repository holding `files`, as paths under it. */
function app(files: Record<string, string>): string {
  const root = mkdtempSync(join(tmpdir(), 'react-ui-check-'));
  made.push(root);
  execFileSync('git', ['init', '--quiet'], { cwd: root });
  for (const [file, text] of Object.entries(files)) {
    mkdirSync(dirname(join(root, file)), { recursive: true });
    writeFileSync(join(root, file), text);
  }
  return root;
}

function run(...args: string[]): { status: number | null; out: string } {
  const result = spawnSync(process.execPath, [BIN, ...args], { encoding: 'utf8' });
  return { status: result.status, out: `${result.stdout}${result.stderr}` };
}

/** An app that keeps every rule: it renders a class react-ui offers, and styles its own with react-ui's tokens. */
const KEPT = {
  'src/App.tsx': [
    "export function App() {",
    "  return <p className=\"xynolog-sr-only app-note\">hidden</p>;",
    "}",
    "",
  ].join('\n'),
  'src/app.css': '.app-note { color: var(--xynolog-color-primary-500); }\n',
};

describe('xynolog-react-ui-check', () => {
  it('takes one source directory and nothing else', () => {
    expect(run().status).toBe(2);
    expect(run(app(KEPT), app(KEPT)).status).toBe(2);
    expect(run('--debt').status).toBe(2);
  });

  it('refuses a directory that holds no source', () => {
    const { status, out } = run(app({ 'README.md': 'nothing here\n' }));
    expect(status).toBe(2);
    expect(out).toContain('holds no TypeScript and no stylesheet');
  });

  it('passes an app that keeps every rule, as a host', () => {
    const { status, out } = run(join(app(KEPT), 'src'));
    expect(out).toContain('the source of an app that uses react-ui');
    expect(status, out).toBe(0);
  });

  const BROKEN: Array<[string, Record<string, string>, string]> = [
    ['gathered context held in component state',
      { 'src/Panel.tsx': 'const [context] = useState<GatheredContext | null>(null);\n' },
      'GatheredContext held in useState'],
    ['useResourceGather',
      { 'src/Panel.tsx': 'const context = useResourceGather(resourceId);\n' },
      'useResourceGather'],
    ['a factory given a non-null-asserted client',
      { 'src/Page.tsx': 'const unit = useSessionStateUnit(() => createThing(client!, id));\n' },
      'non-null-asserted client or session'],
    ['a unit made with useStateUnit',
      { 'src/Page.tsx': 'const unit = useStateUnit(() => createThing(id));\n' },
      'useStateUnit( makes a unit no session bounds'],
    ['a hook called inline in a conditional render',
      { 'src/Page.tsx': 'const page = <Button onClick={open ? useCallback(() => go(), []) : undefined} />;\n' },
      'is called inline as a prop inside a conditional render'],
    ['a hook called inside useMemo',
      { 'src/Page.tsx': 'const value = useMemo(() => useThing(), []);\n' },
      "is called inside useMemo()'s function"],
    ['two useEventSubscriptions calls in one file',
      { 'src/Page.tsx': "useEventSubscriptions({ a: onA });\nuseEventSubscriptions({ b: onB });\n" },
      '2 useEventSubscriptions calls'],
    ["a toolbar preference's key read by a component",
      { 'src/Toolbar.tsx': "const click = localStorage.getItem('xynolog-toolbar-click');\n" },
      "a toolbar preference's storage key outside useToolbarPrefs()"],
    ['a var() nothing defines',
      { 'src/app.css': '.app-note { color: var(--app-nowhere); }\n' },
      '--app-nowhere, used at'],
    ['a class no stylesheet styles',
      { 'src/Note.tsx': 'const note = <p className="xynolog-styled-nowhere">x</p>;\n' },
      'rendered and styled nowhere'],
    ["a class of react-ui's it does not offer to hosts",
      { 'src/Wait.tsx': 'const wait = <span className="xynolog-spinner" />;\n' },
      'which it does not offer to hosts'],
    ['a class the app defines twice',
      {
        'src/one.css': '.xynolog-app-twice { color: red; }\n',
        'src/two.css': '.xynolog-app-twice { color: blue; }\n',
        'src/Twice.tsx': 'const twice = <p className="xynolog-app-twice">x</p>;\n',
      },
      "defined in more than one stylesheet, one of them this app's"],
    ['a class the app styles and never renders',
      { 'src/unused.css': '.xynolog-app-unused { color: red; }\n' },
      'styled by this app and rendered by none of its markup'],
  ];

  it.each(BROKEN)('refuses %s', (_, files, problem) => {
    const { status, out } = run(join(app({ ...KEPT, ...files }), 'src'));
    expect(status, out).toBe(1);
    expect(out).toContain(problem);
  });
});
