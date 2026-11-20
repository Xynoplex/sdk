(* The stack group: the launcher's types for its documents, and the schemas
   it reads them against, from protocol/specs/src/stack/ and
   kb-identity/ProjectConfig.json, for cli's internal/launcher/stack:

   - types_gen.go: a Go type for each document, named by its title, and each
     object it reaches;
   - schemas_gen.go: the text of every schema they reach, and the schema each
     kind of document is read against, by its [kind] (the project file by its
     title).

   A document is each schema in stack/ whose [kind] is a const, and the
   project file. The launcher validates a document against its schema and
   only then reads it, so a type states the schema's shape and no rule of its
   own: [oneOf], [allOf] of a rule, a bound and the like are the validator's.
   A reference into components/schemas is the Go SDK's type. A schema form
   this group does not render is refused by name, rather than rendered as a
   guess. *)

module G = Go_syntax
open Schemas

let stack = "stack/"
let project = "kb-identity/ProjectConfig.json"
let components = "components/schemas/"
let directory = "internal/launcher/stack/"

let shape =
  [
    "title";
    "type";
    "description";
    "properties";
    "required";
    "additionalProperties";
    "propertyNames";
    "$ref";
  ]

let rules =
  [
    "const";
    "minLength";
    "maxLength";
    "minimum";
    "maximum";
    "pattern";
    "minProperties";
    "oneOf";
    "anyOf";
    "not";
    "allOf";
  ]

type state = {
  spec : Spec.t;
  api : Schemas.api;
  documents : string list;
  mutable order : string list;  (** Each type's name, reversed. *)
  types : (string, G.decl option) Hashtbl.t;
  mutable uses_api : bool;
}

(* The Go type of [s], written in [from_], named [name] if it is an object of
   its own, whose own objects are named from [prefix]. *)
let rec type_of st ~from_ ?prefix ?(document = false) name (s : Schema.t) =
  let l = layer from_ s in
  (match unknown ~known:(shape @ rules) l with
  | [] -> ()
  | k :: _ ->
      refuse from_
        (Printf.sprintf "%s uses `%s`, which this group does not render" name k));
  List.iter
    (fun rule ->
      let ruled =
        match rule with
        | Schema.Schema { ref_ = Some r; _ } ->
            let file, _ = Decode.resolve st.spec.ids r in
            layer file (schema st.spec file)
        | rule -> layer from_ rule
      in
      if ruled.properties <> None then
        refuse from_
          (name
         ^ " is all of a schema with properties, which this group does not \
            merge"))
    (Option.value ~default:[] l.all_of);
  match l with
  | { ref_ = Some r; _ } -> (
      let file, fragment, referred = resolve st.spec r in
      if String.starts_with ~prefix:components file then (
        st.uses_api <- true;
        G.Named (api_type st.api ~from_ file fragment))
      else if fragment <> "" then
        refuse from_
          (Printf.sprintf "%s refers to %s#%s, which this group does not render"
             name file fragment)
      else if not (String.starts_with ~prefix:stack file || file = project) then
        refuse from_
          (Printf.sprintf
             "%s refers to %s, outside the stack's schemas and the components"
             name file)
      else
        let rl = layer file referred in
        match rl.title with
        | None -> refuse file ("referred to by " ^ name ^ ", and has no title")
        | Some title ->
            type_of st ~from_:file
              ~document:(List.mem file st.documents)
              title referred)
  | _ -> shaped st ~from_ ?prefix ~document name l

and shaped st ~from_ ?prefix ~document name (l : Schema.schema) =
  match l.type_ with
  | Some [ Object ] -> (
      match (l.properties, l.additional_properties) with
      | Some _, _ -> object_type st ~from_ ?prefix ~document name l
      | None, Some (Schema.Schema _ as values) ->
          let key =
            match l.property_names with
            | Some names -> type_of st ~from_ (name ^ "Key") names
            | None -> G.Named "string"
          in
          G.Map (key, type_of st ~from_ (name ^ "Value") values)
      | None, _ ->
          refuse from_
            (name
           ^ " is an object with neither properties nor a schema for its values"
            ))
  | Some [ String ] -> G.Named "string"
  | Some [ Integer ] -> G.Named "int"
  | Some [ Number ] -> G.Named "float64"
  | Some [ Boolean ] -> G.Named "bool"
  | Some types ->
      refuse from_
        (Printf.sprintf
           "%s is a schema of the types [%s], which this group does not render"
           name
           (String.concat ", " (List.map Schema.type_word types)))
  | None -> refuse from_ (name ^ " states no type")

(* An object's struct. Its fields are named as its properties, and an object
   of its own as [prefix] and the property: a document's spec names its own
   after the document, StackKnowledgeBase's gateway is
   StackKnowledgeBaseGateway. *)
and object_type st ~from_ ?(prefix : string option) ~document name
    (l : Schema.schema) =
  let prefix = Option.value ~default:name prefix in
  if not (Hashtbl.mem st.types name) then (
    Hashtbl.replace st.types name None;
    st.order <- name :: st.order;
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
         ^ " admits properties it does not name: a document is held to its \
            schema"));
    let required = Option.value ~default:[] l.required in
    let fields =
      List.map
        (fun (property, sub) ->
          let optional = not (List.mem property required) in
          let t =
            type_of st ~from_
              ?prefix:
                (if document && property = "spec" then Some name else None)
              (prefix ^ Text.pascal property)
              sub
          in
          let pointer =
            optional && match t with G.Map _ | G.Slice _ -> false | _ -> true
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
    Hashtbl.replace st.types name
      (Some
         (G.Type
            {
              doc = G.prose (name ^ ": " ^ description);
              name;
              def = Struct { fields; spacing = Spaced };
            })));
  G.Named name

(* A document's kind: the const of its [kind], when it states one. *)
let kind spec file =
  match layer file (schema spec file) with
  | { properties = Some properties; _ } -> (
      match List.assoc_opt "kind" properties with
      | Some (Schema.Schema { const = Some (String_literal kind); _ }) ->
          Some kind
      | _ -> None)
  | _ -> None

let header =
  G.verbatim
    ("Code generated from protocol/specs/src/stack and \
      protocol/specs/src/kb-identity/ProjectConfig.json — DO NOT EDIT.\n\n\
      Regenerate: make generate (xynolog/sdk's " ^ Banner.writer __FILE__ ^ ")"
    )

let derive ~root (spec : Spec.t) =
  let kinds =
    List.filter_map
      (fun (file, _) ->
        if
          String.starts_with ~prefix:stack file
          && (not
                (String.contains
                   (String.sub file 6 (String.length file - 6))
                   '/'))
          && Filename.check_suffix file ".json"
        then Option.map (fun kind -> (file, kind)) (kind spec file)
        else None)
      spec.schemas
    |> List.sort compare
  in
  let documents = List.map fst kinds @ [ project ] in
  let st =
    {
      spec;
      api = Schemas.api spec;
      documents;
      order = [];
      types = Hashtbl.create 64;
      uses_api = false;
    }
  in
  let titled file =
    match layer file (schema spec file) with
    | { type_ = Some [ Object ]; title = Some title; _ } as l -> (title, l)
    | _ -> refuse file "a document is not an object with a title"
  in
  List.iter
    (fun file ->
      let title, l = titled file in
      ignore (object_type st ~from_:file ~document:true title l))
    documents;
  let reached = reach spec documents in
  let types =
    List.rev_map (fun name -> Option.get (Hashtbl.find st.types name)) st.order
  in
  let q s = G.Quoted s in
  let map elements =
    G.lines
      ~of_:(G.Map (G.Named "string", G.Named "string"))
      ~spacing:Spaced elements
  in
  [
    {
      Output.path = directory ^ "types_gen.go";
      text =
        G.text
          {
            header;
            package = "stack";
            imports =
              (if st.uses_api then [ [ "github.com/xynolog/sdk/go/api" ] ]
               else []);
            decls = types;
          };
    };
    {
      Output.path = directory ^ "schemas_gen.go";
      text =
        G.text
          {
            header;
            package = "stack";
            imports = [];
            decls =
              [
                G.Var
                  (G.spec
                     ~doc:
                       (G.prose
                          "schemaFiles: the text of every schema a document is \
                           read against, and of every schema those refer to, \
                           by its path in the repository.")
                     "schemaFiles"
                     (map
                        (List.map
                           (fun file ->
                             G.element
                               ~key:(q (repository file))
                               (q (text ~root file)))
                           reached)));
                G.Var
                  (G.spec
                     ~doc:
                       (G.prose
                          "schemaOf: the schema each kind of document is read \
                           against.")
                     "schemaOf"
                     (map
                        (List.map
                           (fun (key, file) ->
                             G.element ~key:(q key) (q (repository file)))
                           (List.map (fun (file, kind) -> (kind, file)) kinds
                           @ [ (fst (titled project), project) ]))));
              ];
          };
    };
  ]

let files ~root spec = Schemas.files (fun () -> derive ~root spec)
