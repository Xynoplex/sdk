(* The table as the Python SDK's reading of a reply reads it
   (python/sdk/src/xynolog/_required.py): JSON text, one schema to a line, which
   the SDK parses as it imports the module. *)

let path = "python/sdk/src/xynolog/_required_table.py"

(* [text] as a Python string in single quotes: a JSON line holds double
   quotes, and a member's name may hold a backslash. *)
let quoted text =
  "'"
  ^ Text.replace_all ~sub:"'" ~by:"\\'"
      (Text.replace_all ~sub:"\\" ~by:"\\\\" text)
  ^ "'"

let text (shapes : (string * Shape.shape) list) =
  let count = List.length shapes in
  let line i (name, shape) =
    "    "
    ^ quoted
        (Yojson.Safe.to_string (`String name)
        ^ ":"
        ^ Yojson.Safe.to_string (Shape.to_json ~pairs:false shape)
        ^ if i < count - 1 then "," else "")
  in
  String.concat ""
    [
      {|# Generated from the component schemas of protocol/specs/src/openapi.json; do not edit.
# Regenerate: make generate (codegen/lib/required/python.ml)

"""What each component schema requires of a value, by its name, as JSON: codegen/lib/required/shape.ml states the rules."""

from typing import Final

__all__ = ["SCHEMAS"]

SCHEMAS: Final = (
    "{"
|};
      String.concat "\n" (List.mapi line shapes);
      {|
    "}"
)
|};
    ]

let file shapes = { Output.path; text = text shapes }
