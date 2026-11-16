#!/usr/bin/env bash
set -euo pipefail

# Every published @xynolog/* tarball resolves under `tsc --moduleResolution
# NodeNext`, installed as an external consumer installs it. This catches an
# asymmetric dist, a bundled .js beside per-file .d.ts shards, before a
# tarball reaches a NodeNext consumer: `export * from './client'` in
# dist/index.d.ts fails when no ./client.js sits beside it.
#
#   typescript/scripts/verify-nodenext-resolution.sh <tarball dir> <version>
#
# Run after `publish.sh --pack-dir`, in the container that built the packages,
# so the consumer is checked with the TypeScript compiler the workspace
# installed. The tarballs are installed together: each package depends on the
# others at this exact version, which no registry holds.

cd "$(dirname "${BASH_SOURCE[0]}")/../.."
tarballs="$(cd "$1" && pwd)"
version="$2"
tsc="$PWD/typescript/node_modules/typescript/bin/tsc"
[[ -f "$tsc" ]] || { echo "verify-nodenext-resolution.sh: $tsc is missing; install the workspace first" >&2; exit 1; }

consumer="$(mktemp -d)"
trap 'rm -rf "$consumer"' EXIT

node - "$tarballs" "$version" "$consumer" <<'NODE'
const { existsSync, readFileSync, writeFileSync } = require('node:fs');
const [tarballs, version, consumer] = process.argv.slice(2);
const names = Object.entries(JSON.parse(readFileSync('version.json', 'utf8')).packages)
  .filter(([, entry]) => entry.publish === true)
  .map(([name]) => name);
const dependencies = {};
for (const name of names) {
  const tarball = `${tarballs}/${name.slice(1).replace('/', '-')}-${version}.tgz`;
  if (!existsSync(tarball)) throw new Error(`${name}: no tarball at ${tarball}`);
  dependencies[name] = `file:${tarball}`;
}
writeFileSync(`${consumer}/package.json`, JSON.stringify({ name: 'verify-nodenext', version: '0.0.0', private: true, type: 'module', dependencies }, null, 2));
writeFileSync(`${consumer}/tsconfig.json`, JSON.stringify({
  compilerOptions: { target: 'ES2022', module: 'NodeNext', moduleResolution: 'NodeNext', strict: true, skipLibCheck: true, noEmit: true, types: [] },
  include: ['smoke.ts'],
}, null, 2));
// `import *` makes the resolver walk each package's whole re-export chain.
writeFileSync(`${consumer}/smoke.ts`, names.map((name, index) => `import * as package${index} from '${name}';\nvoid package${index};\n`).join(''));
console.log(`Checking ${names.join(', ')} at ${version}`);
NODE

(cd "$consumer" && npm install --no-package-lock --no-audit --no-fund --loglevel=error)
node "$tsc" --noEmit -p "$consumer"
echo "Every @xynolog/* tarball resolves under NodeNext."
