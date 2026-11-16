#!/usr/bin/env node
// generate-sign-in-go.mjs — generate the Go SDK's entry of the sign-in store
// from protocol/specs/src/sign-in-store/SignIn.json, the schema the Rust and Python SDKs
// generate theirs from, and how the store's directory and files are kept to
// their owner from protocol/specs/src/sign-in-store/owner-only.json.
//
//   go/signin_gen.go          the entry, and the names every
//                                          entry must state
//   go/owneronly_gen.go       the directory's and the files' modes,
//                                          and the directory's access list
//
// Programs in several languages read and write <stateDir>/tokens.json, so the
// entry's shape is the contract's to state, and so is how its directory and
// files are kept.
//
// The reading of the schema is sign-in-schema.mjs's, and of the owner-only
// file owner-only.mjs's, each shared with the Python SDK's generator.
//
// --check diffs without writing (the CI drift gate).

import { dirname, resolve } from 'node:path';
import { fileURLToPath } from 'node:url';
import { goComment } from '../lib/go-source.mjs';
import { writeOrCheck } from '../lib/committed-source.mjs';
import { forAFile, readOwnerOnly } from '../../../typescript/scripts/generators/owner-only.mjs';
import { readSignInSchema } from '../../../typescript/scripts/generators/sign-in-schema.mjs';

const ROOT = resolve(dirname(fileURLToPath(import.meta.url)), '../../..');
const SCHEMA = resolve(ROOT, 'protocol/specs/src/sign-in-store/SignIn.json');
const OWNER_ONLY = resolve(ROOT, 'protocol/specs/src/sign-in-store/owner-only.json');
const OUT = resolve(ROOT, 'go/signin_gen.go');
const SDK_OWNER_ONLY = resolve(ROOT, 'go/owneronly_gen.go');
const CHECK = process.argv.includes('--check');

function refuse(message) {
  console.error(`✗ ${SCHEMA}: ${message}`);
  process.exit(1);
}

const schema = readSignInSchema(SCHEMA, refuse);
const { required } = schema;

const fields = schema.fields.map(({ name, description, isTime, required: must }) => {
  // An absent optional property is the zero value: "" for a string, the zero
  // time for a date-time. Neither is written.
  const omit = must ? '' : isTime ? ',omitzero' : ',omitempty';
  return {
    usesTime: isTime,
    text: [goComment(description, '\t'), `\t${name[0].toUpperCase()}${name.slice(1)} ${isTime ? 'time.Time' : 'string'} \`json:"${name}${omit}"\``].join(
      '\n',
    ),
  };
});

const lowerFirst = (text) => `${text[0].toLowerCase()}${text.slice(1)}`;
const requiredName = `${lowerFirst(schema.title)}Required`;

const text = `// Code generated from protocol/specs/src/sign-in-store/SignIn.json — DO NOT EDIT.
//
// Regenerate: node codegen/node/schemas/generate-sign-in-go.mjs
// The Rust (xynolog::sign_in_store) and Python (xynolog.sign_in) SDKs generate
// their entries from the same schema.

package xynolog
${fields.some((field) => field.usesTime) ? '\nimport "time"\n' : ''}
${goComment(`${schema.title}: ${schema.description}`)}
type ${schema.title} struct {
${fields.map((field) => field.text).join('\n\n')}
}

// ${requiredName}: the properties every ${schema.title} states. A member of the
// document that lacks one is not a ${schema.title}.
var ${requiredName} = []string{${required.map((name) => JSON.stringify(name)).join(', ')}}
`;

writeOrCheck(ROOT, OUT, text, CHECK);
console.log(`properties: ${schema.fields.length}, required: ${required.length}`);

const { directoryMode, fileMode, accessList } = readOwnerOnly(OWNER_ONLY);

/** A function that gives `list` with `owner` where the owner's SID goes. */
const listFunction = (name, docs, list) =>
  `${goComment(`${name}: ${docs}`)}\nfunc ${name}(owner string) string {\n\treturn ${JSON.stringify(list.before)} + owner + ${JSON.stringify(list.after)}\n}\n`;

const ownerOnlyText = (pkg, others, lists) => `// Code generated from protocol/specs/src/sign-in-store/owner-only.json — DO NOT EDIT.
//
// Regenerate: node codegen/node/schemas/generate-sign-in-go.mjs
// ${others}

package ${pkg}

import "os"

${goComment(`ownerOnlyDirMode: ${directoryMode.docs}`)}
const ownerOnlyDirMode os.FileMode = 0o${directoryMode.octal}

${goComment(`ownerOnlyFileMode: ${fileMode.docs}`)}
const ownerOnlyFileMode os.FileMode = 0o${fileMode.octal}

${lists.join('\n')}`;

writeOrCheck(
  ROOT,
  SDK_OWNER_ONLY,
  ownerOnlyText(
    'xynolog',
    'The Rust, Python and Kotlin SDKs generate theirs from the same file.',
    [listFunction('ownerOnlyAccessList', accessList.docs, accessList)],
  ),
  CHECK,
);
console.log(`the owner-only modes ${directoryMode.written} and ${fileMode.written}, and the access list, for the SDK`);
