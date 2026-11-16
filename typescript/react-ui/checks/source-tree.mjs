import { execFileSync } from 'node:child_process';
import { readdirSync, readFileSync, realpathSync, statSync } from 'node:fs';
import { join, relative } from 'node:path';
import { fileURLToPath } from 'node:url';

/** This package's root, where it is checked out or where it is installed. */
export const PACKAGE = fileURLToPath(new URL('..', import.meta.url));

/**
 * The repository's files as the working tree holds them: every file git
 * tracks and has not seen deleted, and every new one it does not ignore,
 * relative to `root`. On a clean checkout, CI's, it is `git ls-files`
 * exactly; before a change is staged it is still the change, so a check run
 * then judges the tree it will be committed as.
 */
export function repositoryFiles(root) {
  const list = (...args) => execFileSync('git', ['ls-files', '-z', ...args], { cwd: root, encoding: 'utf8', maxBuffer: 256 * 1024 * 1024 }).split('\0').filter(Boolean);
  const deleted = new Set(list('--deleted'));
  return [...new Set([...list('--cached'), ...list('--others', '--exclude-standard')])].filter((file) => !deleted.has(file)).sort();
}

/**
 * The source directory a check reads: the files git says it holds, as paths
 * relative to it, and whether it is this package's own `src`. A host's source
 * is judged by what it may do with react-ui; react-ui's own, by what react-ui
 * may do itself.
 */
export function sourceTree(directory) {
  const root = realpathSync(directory);
  if (!statSync(root).isDirectory()) throw new Error(`${directory} is not a directory`);
  const files = repositoryFiles(root);
  if (!files.some((file) => /\.(tsx?|css)$/.test(file))) {
    throw new Error(`${directory} holds no TypeScript and no stylesheet that git knows of`);
  }
  return {
    own: root === realpathSync(join(PACKAGE, 'src')),
    files,
    read: (file) => readFileSync(join(root, file), 'utf8'),
    show: (file) => relative(process.cwd(), join(root, file)),
  };
}

/**
 * The stylesheets this package ships, under `src/styles` and beside the
 * components and features they style, read from where the package is: an
 * installed package has no git, so these are what is on disk under `src`.
 * Each is named as a host imports it.
 */
export function packageStylesheets() {
  return readdirSync(join(PACKAGE, 'src'), { recursive: true, withFileTypes: true })
    .filter((entry) => entry.isFile() && entry.name.endsWith('.css'))
    .map((entry) => join(entry.parentPath, entry.name))
    .sort()
    .map((path) => ({ name: `@xynolog/react-ui/${relative(PACKAGE, path)}`, text: readFileSync(path, 'utf8') }));
}
