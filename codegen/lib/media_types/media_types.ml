(* The media types group: the types a knowledge base admits and what the
   system can do with each (protocol/specs/src/media-types/registry.json), for
   the Go, Python, TypeScript and Haskell SDKs; Haskell's module beside the
   Encoding Standard's labels, which it has always held.

   A type is a base media type, stated once, with an extension (a dot, then
   lower-case letters and digits), a label, and a word of each vocabulary.
   An alias is another spelling of a row's extension and never a row's own.
   The rows are the SupportedMediaType enum's members, no more and no fewer:
   the enum gates what is admitted, the registry says what each is. *)

module T = Tables.Media_types_registry

let file = "media-types/registry.json"
let enum_file = "components/schemas/SupportedMediaType.json"
let quoted = Text.quoted

let is_extension text =
  String.length text > 1
  && text.[0] = '.'
  && String.for_all
       (function 'a' .. 'z' | '0' .. '9' -> true | _ -> false)
       (String.sub text 1 (String.length text - 1))

let admitted (spec : Spec.t) =
  match List.assoc_opt enum_file spec.schemas with
  | Some (Schema.Schema { enum = Some members; _ }) ->
      Ok
        (List.filter_map
           (function Schema.String_literal s -> Some s | _ -> None)
           members)
  | _ ->
      Error
        [
          { Decode.file = enum_file; pointer = ""; message = "states no enum" };
        ]

let derive (table : T.t) admitted =
  let refusals = ref [] in
  let refuse pointer message =
    refusals := { Decode.file; pointer; message } :: !refusals
  in
  let vocabularies =
    [
      ("render", table.render);
      ("anchoring", table.anchoring);
      ("textSource", table.text_source);
    ]
  in
  List.iter
    (fun (name, words) ->
      if words = [] then refuse ("/" ^ name) "lists no words";
      List.iteri
        (fun i word ->
          if word = "" then refuse (Printf.sprintf "/%s/%d" name i) "is empty";
          match List.find_index (( = ) word) words with
          | Some j when j < i ->
              refuse
                (Printf.sprintf "/%s/%d" name i)
                (Printf.sprintf "is %s, which /%s/%d states already" word name j)
          | _ -> ())
        words)
    vocabularies;
  if table.media_types = [] then refuse "/mediaTypes" "lists no media types";
  List.iteri
    (fun i (row : T.media_type) ->
      let at = Printf.sprintf "/mediaTypes/%d" i in
      let m = row.media_type in
      if m = "" || m <> String.lowercase_ascii m || String.contains m ';' then
        refuse (at ^ "/mediaType")
          (Printf.sprintf
             "is %S, which is not a base media type: lower case, and no \
              parameters"
             m);
      (match
         List.find_index
           (fun (r : T.media_type) -> r.media_type = m)
           table.media_types
       with
      | Some j when j < i ->
          refuse (at ^ "/mediaType")
            (Printf.sprintf "is %s, which /mediaTypes/%d states already" m j)
      | _ -> ());
      if not (is_extension row.extension) then
        refuse (at ^ "/extension")
          (Printf.sprintf "is %S, not a dot, then lower-case letters and digits"
             row.extension);
      if row.label = "" then refuse (at ^ "/label") "is empty";
      List.iter
        (fun (name, word) ->
          let words = List.assoc name vocabularies in
          if not (List.mem word words) then
            refuse
              (at ^ "/" ^ name)
              (Printf.sprintf "is %S, which is none of %s" word
                 (String.concat ", " words)))
        [
          ("render", row.render);
          ("anchoring", row.anchoring);
          ("textSource", row.text_source);
        ])
    table.media_types;
  let extensions =
    List.map (fun (r : T.media_type) -> r.extension) table.media_types
  in
  List.iter
    (fun (alias, extension) ->
      let at = "/extensionAliases/" ^ Decode.escape alias in
      if not (is_extension alias) then
        refuse at "is not a dot, then lower-case letters and digits";
      if List.mem alias extensions then
        refuse at
          (Printf.sprintf
             "is a row's own extension: it would never be read as %s" extension);
      if not (List.mem extension extensions) then
        refuse at
          (Printf.sprintf "is read as %s, which no row states" extension))
    table.extension_aliases;
  let stated =
    List.map (fun (r : T.media_type) -> r.media_type) table.media_types
  in
  List.iter
    (fun m ->
      if not (List.mem m stated) then
        refuse "/mediaTypes"
          (Printf.sprintf "has no row for %s, which %s admits" m enum_file))
    admitted;
  List.iter
    (fun m ->
      if not (List.mem m admitted) then
        refuse "/mediaTypes"
          (Printf.sprintf "has a row for %s, which %s does not admit" m
             enum_file))
    stated;
  match List.rev !refusals with [] -> Ok table | errors -> Error errors

(* pdf-text-layer is PdfTextLayer. *)
let constructor word =
  String.concat ""
    (List.map String.capitalize_ascii (String.split_on_char '-' word))

let go (t : T.t) =
  let source word = "TextSource" ^ constructor word in
  let width =
    List.fold_left (fun w s -> max w (String.length (source s))) 0 t.text_source
  in
  (* gofmt aligns the values of a map literal's consecutive lines. *)
  let key_width =
    List.fold_left
      (fun w (a, _) -> max w (String.length (quoted a) + 1))
      0 t.extension_aliases
  in
  let pad width text = text ^ String.make (width - String.length text) ' ' in
  let bool b = if b then "true" else "false" in
  {
    Output.path = "go/mediatypes/registry_gen.go";
    text =
      String.concat ""
        [
          "// Code generated from protocol/specs/src/" ^ file
          ^ " — DO NOT EDIT.\n//\n// Regenerate: make generate (";
          Banner.writer __FILE__;
          {|)
// The TypeScript (typescript/core/src/media-type-registry.ts) and Rust
// (xynolog::media_types) SDKs generate from the same registry.

package mediatypes

// TextSource is where a type's text comes from: decoded from its own bytes,
// derived by reading them, or nowhere.
type TextSource string

const (
|};
          String.concat "\n"
            (List.map
               (fun word ->
                 "\t" ^ pad width (source word) ^ " TextSource = " ^ quoted word)
               t.text_source);
          {|
)

// Row is one media type a knowledge base admits, with the extension a stored
// name takes for it, where its text comes from, and whether it is offered
// where a person writes a resource.
type Row struct {
	MediaType  string
	Extension  string
	TextSource TextSource
	Authorable bool
}

|};
          Printf.sprintf
            "// Rows is the registry, in its own order: %d media types. The \
             order is\n"
            (List.length t.media_types);
          {|// read: two types that share an extension resolve, from the extension, to the
// first row that states it.
var Rows = []Row{
|};
          String.concat "\n"
            (List.map
               (fun (r : T.media_type) ->
                 "\t{MediaType: " ^ quoted r.media_type ^ ", Extension: "
                 ^ quoted r.extension ^ ", TextSource: " ^ source r.text_source
                 ^ ", Authorable: " ^ bool r.authorable ^ "},")
               t.media_types);
          {|
}

// ExtensionAliases are other spellings of an extension, each with the one a
// row states.
var ExtensionAliases = map[string]string{
|};
          String.concat "\n"
            (List.map
               (fun (alias, extension) ->
                 "\t"
                 ^ pad key_width (quoted alias ^ ":")
                 ^ " " ^ quoted extension ^ ",")
               t.extension_aliases);
          "\n}\n";
        ];
  }

let python (t : T.t) =
  let module L = Python_layout in
  let bool b = L.Atom (if b then "True" else "False") in
  let row (r : T.media_type) =
    L.Call
      ( "MediaType",
        [
          L.Keyword ("media_type", L.Atom (quoted r.media_type));
          L.Keyword ("extension", L.Atom (quoted r.extension));
          L.Keyword ("text_source", L.Atom (quoted r.text_source));
          L.Keyword ("authorable", bool r.authorable);
          L.Keyword ("generatable", bool r.generatable);
        ] )
  in
  {
    Output.path = "python/sdk/src/xynolog/media_types_table.py";
    text =
      String.concat ""
        [
          Banner.python ~from_:("protocol/specs/src/" ^ file) __FILE__;
          {|
"""The media types a knowledge base admits, with what this SDK reads of each."""

from dataclasses import dataclass
from typing import Final, Literal, final

__all__ = ["MEDIA_TYPES", "MediaType", "TextSource"]

type TextSource = Literal[|};
          String.concat ", " (List.map quoted t.text_source);
          {|]
"""Where a type's text comes from: decoded from its own bytes, derived by reading them, or nowhere."""


@final
@dataclass(frozen=True, slots=True, kw_only=True)
class MediaType:
    """One media type a knowledge base admits."""

    media_type: str
    extension: str
    """The extension a stored name takes, with its dot."""
    text_source: TextSource
    authorable: bool
    """Offered where a person writes a resource."""
    generatable: bool
    """The generation worker can produce it."""


|};
          Printf.sprintf "# The registry, in its own order: %d media types.\n"
            (List.length t.media_types);
          L.statement ~indent:0
            ~prefix:"MEDIA_TYPES: Final[tuple[MediaType, ...]] = " ~suffix:""
            (L.Rows (List.map row t.media_types));
          "\n";
        ];
  }

let typescript (t : T.t) =
  (* A TypeScript string in single quotes, as the hand-written modules write
     theirs. *)
  let text value =
    "'"
    ^ Text.replace_all ~sub:"'" ~by:"\\'"
        (Text.replace_all ~sub:"\\" ~by:"\\\\" value)
    ^ "'"
  in
  let union words = String.concat " | " (List.map text words) in
  let bool b = if b then "true" else "false" in
  {
    Output.path = "typescript/core/src/media-type-registry.ts";
    text =
      String.concat ""
        [
          "// ⚠ GENERATED FILE — do not edit.\n\
           //\n\
           // Authority:   protocol/specs/src/" ^ file
          ^ "\n// Regenerate:  make generate  (";
          Banner.writer __FILE__;
          ")\n\nexport type RenderMode = " ^ union t.render
          ^ ";\nexport type AnchoringModel = " ^ union t.anchoring
          ^ ";\nexport type TextSource = " ^ union t.text_source
          ^ ";\n\n\
             /** A row of the registry, by media type, in the registry's \
             order. */\n\
             export const MEDIA_TYPE_ROWS = {\n";
          String.concat "\n"
            (List.map
               (fun (r : T.media_type) ->
                 "  " ^ text r.media_type ^ ": { extension: " ^ text r.extension
                 ^ ", label: " ^ text r.label ^ ", render: " ^ text r.render
                 ^ ", anchoring: " ^ text r.anchoring ^ ", textSource: "
                 ^ text r.text_source ^ ", authorable: " ^ bool r.authorable
                 ^ ", uploadable: " ^ bool r.uploadable ^ ", generatable: "
                 ^ bool r.generatable ^ " },")
               t.media_types);
          "\n\
           } as const;\n\n\
           /** Other spellings of an extension, each with the one a row \
           states. */\n\
           export const EXTENSION_ALIASES: Readonly<Record<string, string>> = {\n";
          String.concat "\n"
            (List.map
               (fun (a, e) -> "  " ^ text a ^ ": " ^ text e ^ ",")
               t.extension_aliases);
          "\n};\n";
        ];
  }

(* A Haskell string literal: a quote and a backslash escaped, printable ASCII
   as itself, and every other character by its code point, ended by \& so a
   digit after it is not read as more of it. *)
let haskell_literal value =
  let out = Buffer.create (String.length value + 2) in
  Buffer.add_char out '"';
  Text.fold_uchars
    (fun () u ->
      match Uchar.to_int u with
      | (0x22 | 0x5C) as c ->
          Buffer.add_char out '\\';
          Buffer.add_char out (Char.chr c)
      | c when c >= 32 && c <= 126 -> Buffer.add_char out (Char.chr c)
      | c -> Buffer.add_string out (Printf.sprintf "\\x%x\\&" c))
    () value;
  Buffer.add_char out '"';
  Buffer.contents out

let haskell (t : T.t) (encodings : Encodings.Table.t) =
  let l = haskell_literal in
  let list items = "[" ^ String.concat ", " items ^ "]" in
  let pair a b = "(" ^ a ^ ", " ^ b ^ ")" in
  let code_points text =
    List.rev
      (Text.fold_uchars
         (fun acc u -> string_of_int (Uchar.to_int u) :: acc)
         [] text)
  in
  {
    Output.path = "haskell/sdk/generated/Xynolog/Internal/Generated/Text.hs";
    text =
      String.concat ""
        [
          "-- Generated from " ^ Encodings.Table.file ^ " and " ^ file
          ^ ". Do not edit.\n-- Regenerate: make generate (";
          Banner.writer __FILE__;
          {|)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Text (encodingOf, singleByte, refused, TextSource(..), textSourceName, mediaTypes, extensions, aliases) where
import Data.Text (Text)
import Data.Aeson (FromJSON(..), ToJSON(..), Value(String), withText)
import qualified Data.Map.Strict as Map
import qualified Data.Vector as Vector
encodingOf :: Map.Map Text Text
encodingOf = Map.fromList |};
          list
            (List.map
               (fun (label, encoding) -> pair (l label) (l encoding))
               encodings.labels);
          "\n\
           singleByte :: Map.Map Text (Vector.Vector Int)\n\
           singleByte = Map.fromList ";
          list
            (List.map
               (fun (encoding, every_byte) ->
                 pair (l encoding)
                   ("Vector.fromList " ^ list (code_points every_byte)))
               encodings.single_byte);
          "\nrefused :: [Text]\nrefused = ";
          list (List.map l encodings.refused);
          "\ndata TextSource = ";
          String.concat " | " (List.map constructor t.text_source);
          {| deriving (Eq, Ord, Show, Enum, Bounded)
instance ToJSON TextSource where toJSON = String . textSourceName
instance FromJSON TextSource where
  parseJSON = withText "TextSource" $ \value -> case value of
|};
          String.concat ""
            (List.map
               (fun w -> "    " ^ l w ^ " -> pure " ^ constructor w ^ "\n")
               t.text_source);
          "    _ -> fail \"unknown text source\"\n\
           textSourceName :: TextSource -> Text\n";
          String.concat ""
            (List.map
               (fun w -> "textSourceName " ^ constructor w ^ " = " ^ l w ^ "\n")
               t.text_source);
          "mediaTypes :: Map.Map Text (Text,TextSource,Bool)\n\
           mediaTypes = Map.fromList ";
          list
            (List.map
               (fun (r : T.media_type) ->
                 pair (l r.media_type)
                   ("(" ^ l r.extension ^ ", " ^ constructor r.text_source
                  ^ ", "
                   ^ (if r.authorable then "True" else "False")
                   ^ ")"))
               t.media_types);
          "\nextensions :: [(Text,Text)]\nextensions = ";
          list
            (List.map
               (fun (r : T.media_type) -> pair (l r.extension) (l r.media_type))
               t.media_types);
          "\naliases :: Map.Map Text Text\naliases = Map.fromList ";
          list (List.map (fun (a, e) -> pair (l a) (l e)) t.extension_aliases);
          "\n";
        ];
  }

(* Each type as the OCaml SDK reads it (ocaml/sdk/lib/media_facts.ml): its
   extension, whether a person authors one, and how its text is had. *)
let ocaml (t : T.t) =
  let string = Text.ocaml_quoted in
  {
    Output.path = "ocaml/sdk/lib/media_facts.ml";
    text =
      Banner.ocaml ~from_:file __FILE__
      ^ "let types = ["
      ^ String.concat "; "
          (List.map
             (fun (m : T.media_type) ->
               Printf.sprintf "(%s, (%s, %b, %s))" (string m.media_type)
                 (string m.extension) m.authorable (string m.text_source))
             t.media_types)
      ^ "]\n";
  }

let files ~root:_ (spec : Spec.t) =
  let registry =
    Result.bind (admitted spec) (derive spec.tables.media_types_registry)
  in
  let encodings = Encodings.Table.derive spec.tables.text_encoding_cases in
  match (registry, encodings) with
  | Ok t, Ok e -> Ok [ go t; python t; typescript t; haskell t e; ocaml t ]
  | _ ->
      let errors = function Ok _ -> [] | Error e -> e in
      Error (errors registry @ errors encodings)
