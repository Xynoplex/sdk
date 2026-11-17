(* The kinds of id as the TypeScript SDK's core declares them
   (typescript/core/src/identifiers.ts): for each, its branded type, a guard
   and the one constructor that makes it. The brands themselves are written
   into openapi-typescript's types.ts by generate-identifiers.mjs, until
   types.ts is the generator's own. *)

let path = "typescript/core/src/identifiers.ts"

let kind (k : Table.kind) =
  let name = k.name in
  let make = Go.lower name and rule = Text.upper_snake name in
  Printf.sprintf
    {|%s
export type %s = components['schemas']['%s'];

const %s = new RegExp(%s, 'u');

/** Whether `value` is a `%s`: where text enters and what is not an id is an answer, not a fault. */
export function is%s(value: string): value is %s {
  return %s.test(value);
}

/** `value` as a `%s`. Throws a `TypeError` when the kind's rule refuses it. */
export function %s(value: string): %s {
  if (!is%s(value)) {
    throw new TypeError(`${JSON.stringify(value)} is not a %s: it does not match ${%s.source}`);
  }
  return value;
}
|}
    (Text.doc_comment k.description)
    name name rule (Text.quoted k.pattern) name name name rule name make name
    name name rule

let text kinds =
  {|// ⚠ GENERATED FILE — do not edit.
//
// Authority:   protocol/specs/src/identifiers/kinds.json and each kind's schema
// Regenerate:  make generate  (|}
  ^ Banner.writer __FILE__
  ^ {|)

/**
 * The kinds of id. Each is a type of its own, so one kind is not taken for
 * another, and each is made by one constructor that holds text to the kind's
 * rule, which is the schema's pattern; its guard asks the same of text without
 * throwing. A constructor stands where text enters: a URL, a DOM attribute, a
 * script's argument. What the gateway answers is typed already and is not
 * checked again here.
 */

import type { components } from './types';

|}
  ^ String.concat "\n" (List.map kind kinds)

let file kinds = { Output.path; text = text kinds }
