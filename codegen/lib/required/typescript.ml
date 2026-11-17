(* The table as the TypeScript SDK's reply checks read it
   (typescript/core/src/required.ts). It is typed by the schemas
   openapi-typescript writes (src/types.ts), so one it leaves out, or a name
   that is no schema, fails to compile. *)

let path = "typescript/core/src/required-schemas.ts"

let text (shapes : (string * Shape.shape) list) =
  let entry (name, shape) =
    "  "
    ^ Yojson.Safe.to_string (`String name)
    ^ ": "
    ^ Yojson.Safe.to_string (Shape.to_json ~pairs:false shape)
    ^ ","
  in
  {|// ⚠ GENERATED FILE — do not edit.
//
// Authority:   the component schemas of protocol/specs/src/openapi.json
// Regenerate:  make generate  (codegen/lib/required/typescript.ml)
// The rules:   codegen/lib/required/shape.ml

import type { Shape } from './required';
import type { components } from './types';

/** What each component schema requires of a value, by its name. */
export const REQUIRED_SCHEMAS: { readonly [Name in keyof components['schemas']]: Shape } = {
|}
  ^ String.concat "\n" (List.map entry shapes)
  ^ "\n};\n"

let file shapes = { Output.path; text = text shapes }
