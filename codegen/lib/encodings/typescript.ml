(* The table as the TypeScript SDK's reader of a resource's text reads it
   (typescript/core/src/text-encoding.ts): the platform's TextDecoder has the
   standard's labels and its encodings, and decodes the refused ones all the
   same. *)

let path = "typescript/core/src/refused-encodings.ts"

let text (t : Table.t) =
  {|// ⚠ GENERATED FILE — do not edit.
//
// Authority:   protocol/specs/src/text/encoding-cases.json
// Regenerate:  make generate  (codegen/lib/encodings/typescript.ml)

/** The encodings of the Encoding Standard whose labels every reader of a resource's text refuses, by their names in lower case. */
export const REFUSED_ENCODINGS: ReadonlySet<string> = new Set([|}
  ^ String.concat ", " (List.map Text.quoted t.refused)
  ^ "]);\n"

let file t = { Output.path; text = text t }
