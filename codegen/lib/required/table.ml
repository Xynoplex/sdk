(* The table as JSON, which Go's package embeds. *)

let path = "go/internal/required/schemas_gen.json"

let comment =
  "Generated from the component schemas of protocol/specs/src/openapi.json; do \
   not edit. Regenerate: make generate (codegen/lib/required). What each \
   requires of a value, by its name: codegen/lib/required/shape.ml states the \
   rules."

(* One schema to a line, so a change to one shows as that line. *)
let text (shapes : (string * Shape.shape) list) =
  let entry (name, shape) =
    "    "
    ^ Yojson.Safe.to_string (`String name)
    ^ ": "
    ^ Yojson.Safe.to_string (Shape.to_json ~pairs:false shape)
  in
  "{\n  \"$comment\": "
  ^ Yojson.Safe.to_string (`String comment)
  ^ ",\n  \"schemas\": {\n"
  ^ String.concat ",\n" (List.map entry shapes)
  ^ "\n  }\n}\n"

let file shapes = { Output.path; text = text shapes }
