#!/usr/bin/env node
// generate-oauth-clients-go.mjs — generate the Go SDK's OAuth client ids and
// the scope a sign-in asks for from protocol/specs/src/session/oauth.json, the file the
// TypeScript, Rust, Python and Kotlin SDKs generate theirs from.
//
//   go/oauthclients_gen.go
//
// The SDK signs in as the script client, and the launcher registers both
// clients in a knowledge base's realm, so an id restated by hand is a sign-in
// that fails the day the registration changes.
//
// --check diffs without writing (the CI drift gate).

import { dirname, resolve } from 'node:path';
import { fileURLToPath } from 'node:url';
import { readOAuthClients } from '../../../typescript/scripts/generators/oauth-clients.mjs';
import { goComment } from '../lib/go-source.mjs';
import { writeOrCheck } from '../lib/committed-source.mjs';

const ROOT = resolve(dirname(fileURLToPath(import.meta.url)), '../../..');
const TABLE = resolve(ROOT, 'protocol/specs/src/session/oauth.json');
const OUT = resolve(ROOT, 'go/oauthclients_gen.go');
const CHECK = process.argv.includes('--check');

const { clients, scope } = readOAuthClients(TABLE);

/** `script` → `ScriptClientID` */
const goName = (name) => `${name[0].toUpperCase()}${name.slice(1)}ClientID`;

const constant = (name, docs, value) => `${goComment(`${name}: ${docs}`)}\nconst ${name} = ${JSON.stringify(value)}\n`;

const text = `// Code generated from protocol/specs/src/session/oauth.json — DO NOT EDIT.
//
// Regenerate: node codegen/node/schemas/generate-oauth-clients-go.mjs
// The TypeScript (typescript/core/src/generated/oauth-clients.ts), Rust
// (rust/sdk/build.rs) and Python (xynolog.oauth_clients) SDKs generate
// from the same file.

package xynolog

${clients.map(({ name, id, docs }) => constant(goName(name), docs, id)).join('\n')}
${constant('SignInScope', scope.docs, scope.value)}`;

writeOrCheck(ROOT, OUT, text, CHECK);
console.log(`clients: ${clients.length}, and the sign-in scope`);
