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
  let module G = Go_syntax in
  let source word = "TextSource" ^ constructor word in
  {
    Output.path = "go/mediatypes/registry_gen.go";
    text =
      G.text
        {
          header =
            G.verbatim
              ("Code generated from protocol/specs/src/" ^ file
             ^ " — DO NOT EDIT.\n\nRegenerate: make generate ("
             ^ Banner.writer __FILE__
             ^ ")\n\
                The TypeScript (typescript/core/src/media-type-registry.ts) \
                and Rust\n\
                (xynolog::media_types) SDKs generate from the same registry.");
          package = "mediatypes";
          imports = [];
          decls =
            [
              G.Consts
                {
                  doc = [];
                  spacing = G.Packed;
                  specs =
                    List.map
                      (fun word ->
                        G.spec ~type_:(G.Named "TextSource") (source word)
                          (G.Quoted word))
                      t.text_source;
                };
              G.Var
                (G.spec
                   ~doc:
                     (G.verbatim
                        (Printf.sprintf
                           "Rows is the registry, in its own order: %d media \
                            types. The order is\n\
                            read: two types that share an extension resolve, \
                            from the extension, to the\n\
                            first row that states it."
                           (List.length t.media_types)))
                   "Rows"
                   (G.lines ~of_:(G.Slice (G.Named "Row"))
                      (List.map
                         (fun (r : T.media_type) ->
                           G.item
                             (G.inline
                                [
                                  G.keyed "MediaType" (G.Quoted r.media_type);
                                  G.keyed "Extension" (G.Quoted r.extension);
                                  G.keyed "TextSource"
                                    (G.Name (source r.text_source));
                                  G.keyed "Authorable"
                                    (G.Name
                                       (if r.authorable then "true" else "false"));
                                ]))
                         t.media_types)));
              G.Var
                (G.spec
                   ~doc:
                     (G.verbatim
                        "ExtensionAliases are other spellings of an extension, \
                         each with the one a\n\
                         row states.")
                   "ExtensionAliases"
                   (G.lines
                      ~of_:(G.Map (G.Named "string", G.Named "string"))
                      (List.map
                         (fun (alias, extension) ->
                           G.element ~key:(G.Quoted alias) (G.Quoted extension))
                         t.extension_aliases)));
            ];
        };
  }

let python (t : T.t) =
  let module P = Python_syntax in
  let bool b = P.Name (if b then "True" else "False") in
  let row (r : T.media_type) =
    P.item
      (P.call "MediaType"
         [
           P.keyword "media_type" (P.Str r.media_type);
           P.keyword "extension" (P.Str r.extension);
           P.keyword "text_source" (P.Str r.text_source);
           P.keyword "authorable" (bool r.authorable);
           P.keyword "generatable" (bool r.generatable);
         ])
  in
  {
    Output.path = "python/sdk/src/xynolog/media_types_table.py";
    text =
      P.text
        {
          header =
            Banner.python_lines ~from_:("protocol/specs/src/" ^ file) __FILE__;
          doc =
            As_is
              "The media types a knowledge base admits, with what this SDK \
               reads of each.";
          imports =
            [
              [
                P.From ("dataclasses", [ "dataclass" ]);
                P.From ("typing", [ "Final"; "Literal"; "final" ]);
              ];
            ];
          body =
            [
              P.assign "__all__"
                ~value:
                  (P.List
                     (P.items
                        (List.map
                           (fun n -> P.item (P.Str n))
                           [ "MEDIA_TYPES"; "MediaType"; "TextSource" ])));
              P.alias
                ~doc:
                  (As_is
                     "Where a type's text comes from: decoded from its own \
                      bytes, derived by reading them, or nowhere.")
                "TextSource"
                (P.sub "Literal"
                   (List.map (fun w -> P.item (P.Str w)) t.text_source));
              P.frozen_dataclass "MediaType"
                "One media type a knowledge base admits."
                [
                  P.field "media_type" (P.Name "str");
                  P.field "extension" (P.Name "str")
                    ~doc:"The extension a stored name takes, with its dot.";
                  P.field "text_source" (P.Name "TextSource");
                  P.field "authorable" (P.Name "bool")
                    ~doc:"Offered where a person writes a resource.";
                  P.field "generatable" (P.Name "bool")
                    ~doc:"The generation worker can produce it.";
                ];
              P.assign
                ~about:
                  [
                    Line
                      (Printf.sprintf
                         "The registry, in its own order: %d media types."
                         (List.length t.media_types));
                  ]
                ~annotation:
                  (P.sub "Final"
                     [
                       P.item
                         (P.sub "tuple"
                            [ P.item (P.Name "MediaType"); P.item P.Ellipsis ]);
                     ])
                ~value:(P.tuple ~magic:true (List.map row t.media_types))
                "MEDIA_TYPES";
            ];
        };
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
