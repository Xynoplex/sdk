(* The sign-in group: one entry of the sign-in store (sign-in-store/SignIn.json),
   how a writer keeps the store's directory and files to their owner
   (sign-in-store/owner-only.json), and, for TypeScript, the names the
   contract gives the store's files (sign-in-store/README.md). Programs in
   several languages read and write <stateDir>/tokens.json, so each of these
   is the contract's to state, for the Go, Python and TypeScript SDKs. *)

module Flat = Flat
module Owner_only = Owner_only
module Contract = Contract

let schema_file = "sign-in-store/SignIn.json"
let quoted = Text.quoted
let snake name = String.lowercase_ascii (Text.upper_snake name)
let regenerate = "make generate (" ^ Banner.writer __FILE__ ^ ")"

let go_entry (entry : Flat.t) =
  let field (f : Flat.field) =
    (* An absent optional property is the zero value: "" for a string, the
       zero time for a date-time. Neither is written. *)
    let omit =
      if f.required then "" else if f.is_time then ",omitzero" else ",omitempty"
    in
    Text.go_comment ~indent:"\t" f.description
    ^ "\n\t"
    ^ String.capitalize_ascii f.name
    ^ " "
    ^ (if f.is_time then "time.Time" else "string")
    ^ " `json:\"" ^ f.name ^ omit ^ "\"`"
  in
  let required = String.uncapitalize_ascii entry.title ^ "Required" in
  {
    Output.path = "go/signin_gen.go";
    text =
      String.concat ""
        [
          "// Code generated from protocol/specs/src/" ^ schema_file
          ^ " — DO NOT EDIT.\n//\n// Regenerate: " ^ regenerate
          ^ "\n\
             // The Rust (xynolog::sign_in_store) and Python (xynolog.sign_in) \
             SDKs generate\n\
             // their entries from the same schema.\n\n\
             package xynolog\n";
          (if List.exists (fun (f : Flat.field) -> f.is_time) entry.fields then
             "\nimport \"time\"\n"
           else "");
          "\n";
          Text.go_comment ~indent:"" (entry.title ^ ": " ^ entry.description);
          "\ntype " ^ entry.title ^ " struct {\n";
          String.concat "\n\n" (List.map field entry.fields);
          "\n}\n\n// " ^ required ^ ": the properties every " ^ entry.title
          ^ " states. A member of the\n// document that lacks one is not a "
          ^ entry.title ^ ".\nvar " ^ required ^ " = []string{"
          ^ String.concat ", " (List.map quoted entry.required)
          ^ "}\n";
        ];
  }

let go_owner_only (o : Owner_only.t) =
  {
    Output.path = "go/owneronly_gen.go";
    text =
      String.concat ""
        [
          "// Code generated from protocol/specs/src/" ^ Owner_only.file
          ^ " — DO NOT EDIT.\n//\n// Regenerate: " ^ regenerate
          ^ "\n\
             // The Rust, Python and Kotlin SDKs generate theirs from the same \
             file.\n\n\
             package xynolog\n\n\
             import \"os\"\n\n";
          Text.go_comment ~indent:"" ("ownerOnlyDirMode: " ^ o.directory.docs);
          "\nconst ownerOnlyDirMode os.FileMode = 0o" ^ o.directory.octal
          ^ "\n\n";
          Text.go_comment ~indent:"" ("ownerOnlyFileMode: " ^ o.file.docs);
          "\nconst ownerOnlyFileMode os.FileMode = 0o" ^ o.file.octal ^ "\n\n";
          Text.go_comment ~indent:""
            ("ownerOnlyAccessList: " ^ o.access_list.docs);
          "\nfunc ownerOnlyAccessList(owner string) string {\n\treturn "
          ^ quoted o.access_list.before
          ^ " + owner + " ^ quoted o.access_list.after ^ "\n}\n";
        ];
  }

let python_entry (entry : Flat.t) =
  (* A time stays the text it is written as: what this SDK reads it writes
     back as it came. The wire's name is beside the type, where both type
     checkers leave the Python name as the one an entry is built by. *)
  let field (f : Flat.field) =
    let python = snake f.name in
    let plain = if f.required then "str" else "str | None" in
    let type_ =
      if python = f.name then plain
      else "Annotated[" ^ plain ^ ", Field(alias=" ^ quoted f.name ^ ")]"
    in
    Text.python_comment ~indent:"    " f.description
    ^ "\n    " ^ python ^ ": " ^ type_
    ^ if f.required then "" else " = None"
  in
  let aliased =
    List.exists (fun (f : Flat.field) -> snake f.name <> f.name) entry.fields
  in
  {
    Output.path = "python/sdk/src/xynolog/sign_in.py";
    text =
      String.concat ""
        [
          Banner.python ~from_:("protocol/specs/src/" ^ schema_file) __FILE__;
          {|
"""One entry of the sign-in store (`protocol/specs/src/sign-in-store`): the file where
`xynolog login` keeps the sign-in to each stack, and where an application
finds it.
"""

from typing import |};
          (if aliased then "Annotated, " else "");
          "final\n";
          (if aliased then "\nfrom pydantic import Field\n" else "");
          "\nfrom xynolog.model import WireModel\n\n__all__ = [";
          quoted entry.title;
          "]\n\n\n@final\nclass " ^ entry.title ^ "(WireModel, frozen=True):\n";
          Text.python_docstring ~indent:"    " entry.description;
          "\n\n";
          String.concat "\n\n" (List.map field entry.fields);
          "\n";
        ];
  }

let python_owner_only (o : Owner_only.t) =
  {
    Output.path = "python/sdk/src/xynolog/_owner_only_table.py";
    text =
      String.concat ""
        [
          Banner.python
            ~from_:("protocol/specs/src/" ^ Owner_only.file)
            __FILE__;
          {|
"""How a writer of the sign-in store keeps its directory and its files to their owner, as the launcher keeps its state home."""

from typing import Final

__all__ = ["DIRECTORY_MODE", "FILE_MODE", "access_list"]

|};
          Text.python_comment ~indent:"" o.directory.docs;
          "\nDIRECTORY_MODE: Final = 0o" ^ o.directory.octal ^ "\n\n";
          Text.python_comment ~indent:"" o.file.docs;
          "\nFILE_MODE: Final = 0o" ^ o.file.octal
          ^ "\n\n\ndef access_list(owner: str) -> str:\n";
          Text.python_docstring ~indent:"    " o.access_list.docs;
          "\n    return "
          ^ quoted o.access_list.before
          ^ " + owner + " ^ quoted o.access_list.after ^ "\n";
        ];
  }

let typescript (entry : Flat.t) (o : Owner_only.t) (names : Contract.t) =
  let field (f : Flat.field) =
    "  "
    ^ Text.doc_comment f.description
    ^ "\n  " ^ f.name
    ^ (if f.required then "" else "?")
    ^ ": string;"
  in
  let check (f : Flat.field) =
    let member = "value[" ^ quoted f.name ^ "]" in
    if f.required then "isString(" ^ member ^ ")"
    else "(" ^ member ^ " === undefined || isString(" ^ member ^ "))"
  in
  {
    Output.path = "typescript/core/src/sign-in.ts";
    text =
      String.concat ""
        [
          "// ⚠ GENERATED FILE — do not edit.\n\
           //\n\
           // Authority:   protocol/specs/src/sign-in-store (SignIn.json, \
           owner-only.json, README.md)\n\
           // Regenerate:  make generate  (";
          Banner.writer __FILE__;
          ")\n\nimport { isObject, isString } from './type-guards';\n\n";
          Text.doc_comment entry.description;
          "\nexport interface " ^ entry.title ^ " {\n";
          String.concat "\n" (List.map field entry.fields);
          "\n}\n\n/** Whether `value` is a " ^ entry.title
          ^ ": what it requires is there, and every member it has is text. */\n\
             export function is" ^ entry.title ^ "(value: unknown): value is "
          ^ entry.title ^ " {\n  return isObject(value)\n    && ";
          String.concat "\n    && " (List.map check entry.fields);
          ";\n}\n\n";
          Text.doc_comment o.directory.docs;
          "\nexport const OWNER_ONLY_DIRECTORY_MODE = 0o" ^ o.directory.octal
          ^ ";\n\n";
          Text.doc_comment o.file.docs;
          "\nexport const OWNER_ONLY_FILE_MODE = 0o" ^ o.file.octal ^ ";\n\n";
          Text.doc_comment o.access_list.docs;
          "\n\
           export function ownerOnlyAccessList(owner: string): string {\n\
          \  return "
          ^ quoted o.access_list.before
          ^ " + owner + " ^ quoted o.access_list.after ^ ";\n}\n\n";
          "/** The document's name in the state home: one sign-in per stack. */\n\
           export const SIGN_IN_STORE_FILE = ";
          quoted names.document;
          ";\n\n\
           /** The name, beside the document, of the file every writer locks \
           from before its read until after its rename. */\n\
           export const SIGN_IN_STORE_LOCK = ";
          quoted names.lock;
          ";\n\n\
           /** On Windows, the high 32 bits of the offset of the one byte of \
           the lock file that is locked: far past anything the file holds. */\n\
           export const SIGN_IN_STORE_WINDOWS_OFFSET_HIGH = ";
          names.offset_high;
          ";\n";
        ];
  }

let files ~root (spec : Spec.t) =
  let entry =
    match List.assoc_opt schema_file spec.schemas with
    | Some schema -> Flat.read ~file:schema_file schema
    | None ->
        Error
          [
            {
              Decode.file = schema_file;
              pointer = "";
              message = "is not in the spec";
            };
          ]
  in
  let owner_only = Owner_only.derive spec.tables.sign_in_store_owner_only in
  let names = Contract.read ~root in
  match (entry, owner_only, names) with
  | Ok entry, Ok o, Ok names ->
      Ok
        [
          go_entry entry;
          go_owner_only o;
          python_entry entry;
          python_owner_only o;
          typescript entry o names;
        ]
  | _ ->
      let errors = function Ok _ -> [] | Error e -> e in
      Error (errors entry @ errors owner_only @ errors names)
