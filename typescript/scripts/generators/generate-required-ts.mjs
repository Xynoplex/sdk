// Generate what each component schema requires of a value, as the TypeScript
// SDK's reply checks read it (typescript/core/src/required.ts):
//
//   typescript/core/src/generated/required-schemas.ts
//
// The reading of the schemas, and the rules a shape states, are
// required-shapes.mjs's, shared with every SDK's generator. The table is typed by
// the schemas openapi-typescript writes (src/types.ts), so one it leaves out,
// or a name that is no schema, fails to compile. Output is gitignored and
// rebuilt by core's `prebuild`.

import { mkdirSync, writeFileSync } from 'node:fs';
import { dirname, resolve } from 'node:path';
import { fileURLToPath } from 'node:url';
import { readRequiredShapes } from './required-shapes.mjs';

const ROOT = resolve(dirname(fileURLToPath(import.meta.url)), '../../..');
const OUT = resolve(ROOT, 'typescript/core/src/generated/required-schemas.ts');

const { names, shapes } = readRequiredShapes(ROOT, (message) => {
  console.error(`✗ ${message}`);
  process.exit(1);
});

mkdirSync(dirname(OUT), { recursive: true });
writeFileSync(
  OUT,
  `// ⚠ GENERATED FILE — do not edit.
// Source: the component schemas of protocol/specs/src/openapi.json → typescript/scripts/generators/generate-required-ts.mjs,
// by the rules of typescript/scripts/generators/required-shapes.mjs.
// Rebuilt by \`npm run prebuild\` in @xynolog/core; gitignored on purpose.

import type { Shape } from '../required';
import type { components } from '../types';

/** What each component schema requires of a value, by its name. */
export const REQUIRED_SCHEMAS: { readonly [Name in keyof components['schemas']]: Shape } = {
${names.map((name) => `  ${JSON.stringify(name)}: ${JSON.stringify(shapes.get(name))},`).join('\n')}
};
`,
);

console.log(`generated what ${names.length} schemas require → ${OUT}`);
