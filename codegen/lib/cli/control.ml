(* The control group: the launcher's control API, from
   protocol/specs/src/control/methods.json and the schemas it names, for cli's
   internal/launcher:

   - control_types_gen.go: a Go type for each object a method's params,
     result or notification reaches, prefixed Control;
   - control_schemas_gen.go: the text of every schema they reach, the method
     and notification tables, and the control group of errors/codes.json.

   The launcher validates a message against its schema and only then reads
   it, so a type states the schema's shape and no rule of its own: [oneOf],
   [pattern], a bound and the like are the validator's. A reference into
   discovery/ is the Go SDK's type. A schema form this group does not render
   is refused by name, rather than rendered as a guess. *)

module G = Go_syntax
module T = Tables.Control_methods
open Schemas

let table = "control/methods.json"
let discovery = "discovery/"
let directory = "internal/launcher/"

(* The keywords a type is made from, and those that are rules the validator
   enforces. *)
let shape =
  [
    "title";
    "type";
    "description";
    "properties";
    "required";
    "additionalProperties";
    "items";
    "$ref";
  ]

let rules =
  [ "oneOf"; "not"; "const"; "enum"; "pattern"; "minLength"; "minimum" ]

type state = {
  spec : Spec.t;
  api : Schemas.api;
  mutable order : string list;  (** Each struct's name, reversed. *)
  structs : (string, G.decl option) Hashtbl.t;
  mutable described : string list;
      (** Each scalar file held to a description. *)
  mutable raw : bool;  (** Whether a type is [json.RawMessage]. *)
  mutable uses_api : bool;
}

let raw_message = "json.RawMessage"

let rec type_of st ~from_ name (s : Schema.t) =
  let l = layer from_ s in
  (match unknown ~known:(shape @ rules) l with
  | [] -> ()
  | k :: _ ->
      refuse from_
        (Printf.sprintf "%s uses `%s`, which this group does not render" name k));
  match l with
  | { ref_ = Some r; _ } -> (
      let file, fragment, referred = resolve st.spec r in
      if String.starts_with ~prefix:discovery file then
        match (fragment, referred) with
        | "", _ | _, Schema.Schema { enum = Some _; _ } ->
            st.uses_api <- true;
            G.Named (api_type st.api ~from_ file fragment)
        | _ -> type_of st ~from_:file name referred
      else if fragment <> "" then
        refuse from_
          (Printf.sprintf "%s refers to %s#%s, which this group does not render"
             name file fragment)
      else if not (String.starts_with ~prefix:"control/" file) then
        refuse from_
          (Printf.sprintf
             "%s refers to %s, outside the control contract and the discovery \
              contract"
             name file)
      else
        let rl = layer file referred in
        match rl.title with
        | None -> refuse file ("referred to by " ^ name ^ ", and has no title")
        | Some title ->
            if rl.type_ = Some [ Object ] then
              object_type st ~from_:file title rl
            else scalar_type st ~from_:file ~own:true title rl)
  | { type_ = Some [ Object ]; properties = None; _ } ->
      refuse from_ (name ^ " is an object with no properties")
  | { type_ = Some [ Object ]; _ } -> object_type st ~from_ name l
  | { type_ = Some [ Array ]; items = None; _ } ->
      refuse from_ (name ^ " is an array with no items")
  | { type_ = Some [ Array ]; items = Some items; _ } ->
      G.Slice (type_of st ~from_ (name ^ "Item") items)
  | _ -> scalar_type st ~from_ ~own:false name l

(* A string, number or boolean: the Go type it is made of; the validator
   holds its values. *)
and scalar_type st ~from_ ~own name (l : Schema.schema) =
  let go =
    match l.type_ with
    | Some [ String; Integer ] ->
        st.raw <- true;
        G.Named raw_message
    | Some [ String ] -> G.Named "string"
    | Some [ Integer ] -> G.Named "int"
    | Some [ Boolean ] -> G.Named "bool"
    | Some types ->
        refuse from_
          (Printf.sprintf
             "%s is of the types [%s], which this group does not render" name
             (String.concat ", " (List.map Schema.type_word types)))
    | None -> refuse from_ (name ^ " states no type")
  in
  if own && not (List.mem from_ st.described) then (
    if l.description = None then refuse from_ (name ^ " has no description");
    st.described <- from_ :: st.described);
  go

(* An object's struct, its fields named as its properties. *)
and object_type st ~from_ name (l : Schema.schema) =
  let type_name = "Control" ^ name in
  if not (Hashtbl.mem st.structs type_name) then (
    Hashtbl.replace st.structs type_name None;
    st.order <- type_name :: st.order;
    let description =
      match l.description with
      | Some d -> d
      | None -> refuse from_ (name ^ " is an object with no description")
    in
    (match l.additional_properties with
    | Some (Schema.Boolean_schema false) -> ()
    | _ ->
        refuse from_
          (name
         ^ " admits properties it does not name: a message is held to its \
            schema"));
    let required = Option.value ~default:[] l.required in
    let fields =
      List.map
        (fun (property, sub) ->
          let optional = not (List.mem property required) in
          let t = type_of st ~from_ (name ^ Text.pascal property) sub in
          let pointer =
            optional
            && (match t with G.Slice _ -> false | _ -> true)
            && t <> G.Named raw_message
          in
          {
            G.doc =
              (match describe st.spec sub with
              | Some d -> G.prose d
              | None -> []);
            names = [ Text.pascal property ];
            type_ = (if pointer then G.Pointer t else t);
            tag =
              Some
                (Printf.sprintf "json:\"%s%s\"" property
                   (if optional then ",omitempty" else ""));
          })
        (Option.value ~default:[] l.properties)
    in
    Hashtbl.replace st.structs type_name
      (Some
         (G.Type
            {
              doc = G.prose (type_name ^ ": " ^ description);
              name = type_name;
              def = Struct { fields; spacing = Spaced };
            })));
  G.Named type_name

(* A file a method or notification names, from the table's place. *)
let named_file ids path =
  fst (Decode.resolve ids { Decode.target = path; file = table; pointer = "" })

let header =
  G.verbatim
    ("Code generated from protocol/specs/src/control/methods.json and the \
      schemas it names — DO NOT EDIT.\n\n\
      Regenerate: make generate (xynolog/sdk's " ^ Banner.writer __FILE__ ^ ")"
    )

let derive ~root (spec : Spec.t) =
  let t : T.t = spec.tables.control_methods in
  List.iter
    (fun (m : T.methods_item) ->
      List.iter
        (fun sent ->
          if
            not
              (List.exists
                 (fun (n : T.notifications_item) ->
                   n.name = sent && n.from = T.Launcher)
                 t.notifications)
          then
            refuse table
              (Printf.sprintf
                 "%s sends %s, which is no notification the launcher sends"
                 m.name sent))
        m.sends)
    t.methods;
  let st =
    {
      spec;
      api = Schemas.api spec;
      order = [];
      structs = Hashtbl.create 64;
      described = [];
      raw = false;
      uses_api = false;
    }
  in
  let named file =
    let l = layer file (schema spec file) in
    match (l.type_, l.title) with
    | Some [ Object ], Some title -> ignore (object_type st ~from_:file title l)
    | _ ->
        refuse file
          "a method or notification names a schema that is not an object with \
           a title"
  in
  let methods =
    List.map
      (fun (m : T.methods_item) ->
        (m, named_file spec.ids m.params, named_file spec.ids m.result))
      t.methods
  in
  let notifications =
    List.map
      (fun (n : T.notifications_item) -> (n, named_file spec.ids n.params))
      t.notifications
  in
  List.iter
    (fun (_, params, result) ->
      named params;
      named result)
    methods;
  List.iter (fun (_, params) -> named params) notifications;
  let error_data = named_file spec.ids t.error_data in
  named error_data;
  let api_version_file = named_file spec.ids t.api_version in
  let api_version =
    match layer api_version_file (schema spec api_version_file) with
    | { const = Some (String_literal v); _ } -> v
    | _ -> refuse api_version_file "states no version as its const"
  in
  let reached =
    reach spec
      (api_version_file :: error_data
       :: List.concat_map (fun (_, p, r) -> [ p; r ]) methods
      @ List.map snd notifications)
  in
  let codes =
    match Error_codes.Table.derive spec.tables.errors_codes with
    | Ok table -> table.control.codes
    | Error (e :: _) -> raise (Refused e)
    | Error [] -> refuse Error_codes.Table.file "refused"
  in
  if codes = [] then
    refuse Error_codes.Table.file "its control group lists no codes";
  let constant (c : Error_codes.Table.code) =
    if not (String.starts_with ~prefix:"control." c.code) then
      refuse Error_codes.Table.file
        (Printf.sprintf "control's %s is not control.<kebab-case>" c.code);
    "controlCode" ^ Error_codes.Table.pascal (Error_codes.Table.segment c.code)
  in
  let structs =
    List.rev_map
      (fun name -> Option.get (Hashtbl.find st.structs name))
      st.order
  in
  let types_file =
    {
      Output.path = directory ^ "control_types_gen.go";
      text =
        G.text
          {
            header;
            package = "launcher";
            imports =
              ((if st.raw then [ [ "encoding/json" ] ] else [])
              @
              if st.uses_api then [ [ "github.com/xynolog/sdk/go/api" ] ]
              else []);
            decls = structs;
          };
    }
  in
  let q s = G.Quoted s in
  let strings items =
    G.inline ~of_:(G.Slice (G.Named "string"))
      (List.map (fun s -> G.item (q s)) items)
  in
  let schemas_file =
    {
      Output.path = directory ^ "control_schemas_gen.go";
      text =
        G.text
          {
            header;
            package = "launcher";
            imports = [];
            decls =
              [
                G.Const
                  (G.spec
                     ~doc:
                       (G.prose
                          "controlAPIVersion: the version of the control API \
                           this launcher speaks.")
                     "controlAPIVersion" (q api_version));
                G.Const
                  (G.spec
                     ~doc:
                       (G.prose
                          "controlErrorDataSchema: the schema of a failed \
                           request's error data.")
                     "controlErrorDataSchema"
                     (q (id ~root error_data)));
                G.Var
                  (G.spec
                     ~doc:
                       (G.prose
                          "controlSchemaFiles: the text of every schema a \
                           control message is read against, and of every \
                           schema those refer to, by its $id.")
                     "controlSchemaFiles"
                     (G.lines
                        ~of_:(G.Map (G.Named "string", G.Named "string"))
                        ~spacing:Spaced
                        (List.map
                           (fun file ->
                             G.element
                               ~key:(q (id ~root file))
                               (q (text ~root file)))
                           reached)));
                G.Var
                  (G.spec
                     ~doc:
                       (G.prose
                          "controlMethods: each method, the schemas of its \
                           params and its result, whether it is exclusive, and \
                           the notifications it may send besides progress.")
                     "controlMethods"
                     (G.lines ~of_:(G.Slice (G.Named "controlMethod"))
                        (List.map
                           (fun ((m : T.methods_item), params, result) ->
                             G.item
                               (G.inline
                                  [
                                    G.keyed "name" (q m.name);
                                    G.keyed "params" (q (id ~root params));
                                    G.keyed "result" (q (id ~root result));
                                    G.keyed "exclusive"
                                      (G.Name (string_of_bool m.exclusive));
                                    G.keyed "sends" (strings m.sends);
                                  ]))
                           methods)));
                G.Var
                  (G.spec
                     ~doc:
                       (G.prose
                          "controlNotifications: each notification, who sends \
                           it, and the schema of its params.")
                     "controlNotifications"
                     (G.lines ~of_:(G.Slice (G.Named "controlNotification"))
                        (List.map
                           (fun ((n : T.notifications_item), params) ->
                             G.item
                               (G.inline
                                  [
                                    G.keyed "name" (q n.name);
                                    G.keyed "from" (q (T.from_value n.from));
                                    G.keyed "params" (q (id ~root params));
                                  ]))
                           notifications)));
                G.Consts
                  {
                    doc =
                      G.prose
                        "The control group of \
                         protocol/specs/src/errors/codes.json: why a request \
                         failed.";
                    specs =
                      List.map
                        (fun (c : Error_codes.Table.code) ->
                          G.spec ~doc:(G.prose c.docs) (constant c) (q c.code))
                        codes;
                    spacing = Spaced;
                  };
                G.Var
                  (G.spec
                     ~doc:
                       (G.prose
                          "controlCodes: every code of the control group, in \
                           its order.")
                     "controlCodes"
                     (G.lines ~of_:(G.Slice (G.Named "string"))
                        (List.map (fun c -> G.item (G.Name (constant c))) codes)));
              ];
          };
    }
  in
  [ types_file; schemas_file ]

let files ~root spec = Schemas.files (fun () -> derive ~root spec)
