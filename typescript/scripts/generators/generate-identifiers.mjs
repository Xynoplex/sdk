// Give each kind of id (protocol/specs/src/identifiers/kinds.json) its brand
// in `types.ts`, which openapi-typescript has just generated, so that every
// property that refers to the kind is of that type and of no other kind's.
//
// The guards and constructors are codegen/lib/identifiers/typescript.ml's, in
// the committed src/identifiers.ts. This step goes when the generator writes
// types.ts itself.
//
// `--kinds <path>`, `--schemas <dir>` and `--types <path>` name other inputs;
// the test of the refusals passes them.

import { readFileSync, writeFileSync } from 'node:fs';
import { dirname, resolve } from 'node:path';
import { fileURLToPath } from 'node:url';
import { readIdentifierKinds } from './identifier-kinds.mjs';

const HERE = dirname(fileURLToPath(import.meta.url));
const ROOT = resolve(HERE, '../../..');

function option(name) {
  const at = process.argv.indexOf(name);
  return at === -1 ? undefined : process.argv[at + 1];
}

const KINDS = resolve(option('--kinds') ?? resolve(ROOT, 'protocol/specs/src/identifiers/kinds.json'));
const SCHEMAS = resolve(option('--schemas') ?? resolve(ROOT, 'protocol/specs/src/components/schemas'));
const TYPES = resolve(option('--types') ?? resolve(ROOT, 'typescript/core/src/types.ts'));

function refuse(message) {
  console.error(`✗ ${KINDS}: ${message}`);
  process.exit(1);
}

let types = readFileSync(TYPES, 'utf8');
const branded = [];
for (const { name } of readIdentifierKinds(KINDS, SCHEMAS, refuse)) {
  // The schema as openapi-typescript writes it, once, among the components.
  const written = new RegExp(`^( +)${name}: string;$`, 'gm');
  const found = [...types.matchAll(written)];
  if (found.length !== 1) refuse(`${TYPES} declares ${name} as a string ${found.length} times; exactly one is the schema`);
  types = types.replace(written, `$1${name}: string & { readonly __brand: "${name}" };`);
  branded.push(name);
}

writeFileSync(TYPES, types);
console.log(`✓ ${branded.length} kinds of id branded: ${branded.join(', ')}`);
