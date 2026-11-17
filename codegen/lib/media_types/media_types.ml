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
  let module S = Typescript_syntax in
  let text value = S.Str (Single, value) in
  let union name words =
    S.type_alias name (T_union (List.map (fun w -> S.T_str (Single, w)) words))
  in
  let attrs (r : T.media_type) =
    S.Object
      {
        layout = Inline;
        column = None;
        entries =
          [
            S.entry (Ident "extension") (text r.extension);
            S.entry (Ident "label") (text r.label);
            S.entry (Ident "render") (text r.render);
            S.entry (Ident "anchoring") (text r.anchoring);
            S.entry (Ident "textSource") (text r.text_source);
            S.entry (Ident "authorable") (Bool r.authorable);
            S.entry (Ident "uploadable") (Bool r.uploadable);
            S.entry (Ident "generatable") (Bool r.generatable);
          ];
      }
  in
  {
    Output.path = "typescript/core/src/media-type-registry.ts";
    text =
      S.text
        {
          banner =
            Banner.typescript_lines
              ~authority:[ "protocol/specs/src/" ^ file ]
              __FILE__;
          body =
            [
              S.Adjacent
                [
                  union "RenderMode" t.render;
                  union "AnchoringModel" t.anchoring;
                  union "TextSource" t.text_source;
                ];
              S.const "MEDIA_TYPE_ROWS" ~as_const:true
                ~about:
                  [
                    Doc
                      "A row of the registry, by media type, in the registry's \
                       order.";
                  ]
                (S.rows
                   (List.map
                      (fun (r : T.media_type) ->
                        S.entry (Quoted (Single, r.media_type)) (attrs r))
                      t.media_types));
              S.const "EXTENSION_ALIASES"
                ~about:
                  [
                    Doc
                      "Other spellings of an extension, each with the one a \
                       row states.";
                  ]
                ~annotation:
                  (T_generic
                     ( "Readonly",
                       [
                         T_generic
                           ("Record", [ T_name "string"; T_name "string" ]);
                       ] ))
                (S.rows
                   (List.map
                      (fun (a, e) -> S.entry (Quoted (Single, a)) (text e))
                      t.extension_aliases));
            ];
        };
  }

let haskell (t : T.t) (encodings : Encodings.Table.t) =
  let module H = Haskell_syntax in
  let text = H.T_name "Text" in
  let map k v = H.T_apply ("Map.Map", [ k; v ]) in
  let from_list pairs = H.Apply (Name "Map.fromList", [ List pairs ]) in
  let pair a b = H.Tuple [ Str a; Str b ] in
  let code_points every_byte =
    List.rev
      (Text.fold_uchars
         (fun acc u -> H.Int (Uchar.to_int u) :: acc)
         [] every_byte)
  in
  let source w = H.Name (constructor w) in
  {
    Output.path = "haskell/sdk/generated/Xynolog/Internal/Generated/Text.hs";
    text =
      H.text
        {
          banner =
            Banner.haskell_lines
              ~from_:(Encodings.Table.file ^ " and " ^ file)
              __FILE__;
          extensions = [ "OverloadedStrings" ];
          name = "Xynolog.Internal.Generated.Text";
          imports =
            [
              H.import "Data.Text" ~items:[ Plain "Text" ];
              H.import "Data.Aeson"
                ~items:
                  [
                    All "FromJSON";
                    All "ToJSON";
                    With ("Value", [ "String" ]);
                    Plain "withText";
                  ];
              H.import "Data.Map.Strict" ~qualified:"Map";
              H.import "Data.Vector" ~qualified:"Vector";
            ];
          body =
            [
              H.value "encodingOf" (map text text)
                (from_list
                   (List.map
                      (fun (label, encoding) -> pair label encoding)
                      encodings.labels));
              H.value "singleByte"
                (map text (T_apply ("Vector.Vector", [ T_name "Int" ])))
                (from_list
                   (List.map
                      (fun (encoding, every_byte) ->
                        H.Tuple
                          [
                            Str encoding;
                            Apply
                              ( Name "Vector.fromList",
                                [ List (code_points every_byte) ] );
                          ])
                      encodings.single_byte));
              H.value "refused" (T_list text)
                (List (List.map (fun e -> H.Str e) encodings.refused));
              H.data "TextSource"
                (List.map
                   (fun w -> H.constructor (constructor w))
                   t.text_source)
                ~deriving:[ "Eq"; "Ord"; "Show"; "Enum"; "Bounded" ];
              Instance
                {
                  class_ = "ToJSON";
                  instance = "TextSource";
                  methods =
                    [
                      ("toJSON", Compose (Name "String", Name "textSourceName"));
                    ];
                };
              Instance
                {
                  class_ = "FromJSON";
                  instance = "TextSource";
                  methods =
                    [
                      ( "parseJSON",
                        Dollar
                          ( Apply (Name "withText", [ Str "TextSource" ]),
                            Lambda
                              ( "value",
                                Case
                                  ( Name "value",
                                    List.map
                                      (fun w ->
                                        ( H.Literal w,
                                          H.Apply (Name "pure", [ source w ]) ))
                                      t.text_source
                                    @ [
                                        ( Otherwise,
                                          Apply
                                            ( Name "fail",
                                              [ Str "unknown text source" ] ) );
                                      ] ) ) ) );
                    ];
                };
              Value
                {
                  about = [];
                  name = "textSourceName";
                  type_ = T_fun (T_name "TextSource", text);
                  clauses =
                    List.map
                      (fun w ->
                        {
                          H.patterns = [ Constructor (constructor w, []) ];
                          body = Str w;
                        })
                      t.text_source;
                };
              H.value "mediaTypes"
                (map text
                   (T_tuple [ text; T_name "TextSource"; T_name "Bool" ]))
                (from_list
                   (List.map
                      (fun (r : T.media_type) ->
                        H.Tuple
                          [
                            Str r.media_type;
                            Tuple
                              [
                                Str r.extension;
                                source r.text_source;
                                Name (if r.authorable then "True" else "False");
                              ];
                          ])
                      t.media_types));
              H.value "extensions"
                (T_list (T_tuple [ text; text ]))
                (List
                   (List.map
                      (fun (r : T.media_type) -> pair r.extension r.media_type)
                      t.media_types));
              H.value "aliases" (map text text)
                (from_list
                   (List.map (fun (a, e) -> pair a e) t.extension_aliases));
            ];
        };
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
