(* The kinds of id as the Go SDK's package api declares them
   (go/api/ids_gen.go): a type of its own for each, made only through the
   kind's rule.

   oapi-codegen writes the rest of package api, and would write each kind as
   an alias of string, which any text converts to. So go/oapi-codegen.yaml's
   exclude-schemas names the kinds, and this writes them instead. That list
   restates the table, so it is held to it here. *)

let path = "go/api/ids_gen.go"
let config = "go/oapi-codegen.yaml"

(* The config's exclude-schemas, read as the config writes it: one `- Name`
   per line, indented four, under the key indented two. *)
let excluded text =
  let rec after_key = function
    | [] -> None
    | "  exclude-schemas:" :: rest -> Some (names rest)
    | _ :: rest -> after_key rest
  and names = function
    | line :: rest when String.starts_with ~prefix:"    - " line ->
        String.trim (String.sub line 6 (String.length line - 6)) :: names rest
    | _ -> []
  in
  after_key (String.split_on_char '\n' text)

let held ~root (kinds : Table.kind list) =
  let refuse message =
    Error [ { Decode.file = config; pointer = ""; message } ]
  in
  let text =
    In_channel.with_open_bin (Filename.concat root config) In_channel.input_all
  in
  let named = List.map (fun (k : Table.kind) -> k.name) kinds in
  match excluded text with
  | None | Some [] ->
      refuse
        "names no exclude-schemas under output-options, so oapi-codegen would \
         write each kind of id as a string"
  | Some excluded -> (
      let missing = List.filter (fun n -> not (List.mem n excluded)) named in
      let stray = List.filter (fun n -> not (List.mem n named)) excluded in
      match (missing, stray) with
      | [], [] -> Ok ()
      | _ :: _, _ ->
          refuse
            ("exclude-schemas leaves out " ^ String.concat ", " missing
           ^ ", a kind of id in protocol/specs/src/" ^ Table.file)
      | [], _ :: _ ->
          refuse
            ("exclude-schemas names " ^ String.concat ", " stray
           ^ ", which is no kind of id in protocol/specs/src/" ^ Table.file))

module G = Go_syntax

let lower name =
  String.make 1 (Char.lowercase_ascii name.[0])
  ^ String.sub name 1 (String.length name - 1)

let kind (k : Table.kind) =
  let name = k.name in
  let rule = lower name ^ "Rule" and pattern = lower name ^ "Pattern" in
  let id = G.Named name and text = G.Name "text" in
  let invalid value =
    G.Unary
      ( G.Address,
        G.inline ~of_:(G.Named "InvalidIdentifierError")
          [
            G.keyed "Kind" (G.Quoted name);
            G.keyed "Pattern" (G.Name pattern);
            G.keyed "Value" value;
          ] )
  in
  let errors = G.Unnamed [ G.Named "error" ] in
  let held = G.Binary (G.Name "id.text", G.Eq, G.Quoted "") in
  [
    G.Type
      {
        doc =
          G.prose k.description
          @ G.verbatim
              (Printf.sprintf
                 "\n\
                  It is made only by Parse%s, which holds text to the kind's \
                  rule, and\n\
                  by decoding, which goes through the same rule. Its zero \
                  value is no id: it\n\
                  is refused wherever an id is written, and IsZero names it."
                 name);
        name;
        def = G.Is (G.Struct_type [ ([ "text" ], G.Named "string") ]);
      };
    G.Const (G.spec pattern (G.Quoted k.pattern));
    G.Var (G.spec rule (G.call "regexp.MustCompile" [ G.Name pattern ]));
    G.func
      ~doc:
        (G.verbatim
           (Printf.sprintf
              "Parse%s is text as a %s, or an *InvalidIdentifierError when the\n\
               kind's rule refuses it."
              name name))
      ~params:[ ("text", G.Named "string") ]
      ~results:(G.Unnamed [ id; G.Named "error" ])
      ("Parse" ^ name)
      (G.Block
         [
           G.If
             ( G.Unary (G.Not, G.call (rule ^ ".MatchString") [ text ]),
               [ G.Return [ G.inline ~of_:id []; invalid text ] ] );
           G.Return [ G.inline ~of_:id [ G.keyed "text" text ]; G.Name "nil" ];
         ]);
    G.func
      ~doc:[ G.Line "String is the id's text." ]
      ~receiver:("id", id) ~results:(G.Unnamed [ G.Named "string" ]) "String"
      (G.One_line (G.Return [ G.Name "id.text" ]));
    G.func
      ~doc:
        [
          G.Line "IsZero reports whether id is the zero value, which is no id.";
        ]
      ~receiver:("id", id) ~results:(G.Unnamed [ G.Named "bool" ]) "IsZero"
      (G.One_line (G.Return [ held ]));
    G.func
      ~doc:
        (G.verbatim
           "MarshalText is the id's text. The zero value is refused, as the \
            rule refuses\n\
            empty text.")
      ~receiver:("id", id)
      ~results:(G.Unnamed [ G.Slice (G.Named "byte"); G.Named "error" ])
      "MarshalText"
      (G.Block
         [
           G.If (held, [ G.Return [ G.Name "nil"; invalid (G.Quoted "") ] ]);
           G.Return
             [
               G.Convert (G.Slice (G.Named "byte"), G.Name "id.text");
               G.Name "nil";
             ];
         ]);
    G.func
      ~doc:[ G.Line "UnmarshalText holds decoded text to the kind's rule." ]
      ~receiver:("id", G.Pointer id)
      ~params:[ ("text", G.Slice (G.Named "byte")) ]
      ~results:errors "UnmarshalText"
      (G.Block
         [
           G.Define
             ( [ "parsed"; "err" ],
               G.call ("Parse" ^ name) [ G.Convert (G.Named "string", text) ] );
           G.If
             ( G.Binary (G.Name "err", G.Ne, G.Name "nil"),
               [ G.Return [ G.Name "err" ] ] );
           G.Assign (G.Unary (G.Deref, G.Name "id"), G.Name "parsed");
           G.Return [ G.Name "nil" ];
         ]);
  ]

let text kinds =
  G.text
    {
      header =
        G.verbatim
          ("Code generated from protocol/specs/src/identifiers/kinds.json and \
            each kind's schema — DO NOT EDIT.\n\n\
            Regenerate: make generate (" ^ Banner.writer __FILE__
         ^ ")\n\
            The TypeScript and Python kinds are generated from the same table, \
            and Rust's\n\
            by its SDK's build script.");
      package = "api";
      imports = [ [ "regexp" ] ];
      decls = List.concat_map kind kinds;
    }

let file ~root kinds =
  Result.map (fun () -> { Output.path; text = text kinds }) (held ~root kinds)
