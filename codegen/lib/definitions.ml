(* The gateway's component schemas as the Rust and Swift types are generated
   from them: the document bundled (each file it names as a component, or that
   a directory of schemas holds, is a schema by its name, and any other file a
   [$ref] names is written in its place, the [$ref]'s siblings with it gone),
   and OpenAPI's [nullable] as JSON Schema draft 7 states it: beside one
   [type], [null] is a second type; beside anything else, the schema is a
   union of [null] and the rest. A schema that states an [allOf] holds its
   parts, for the names a writer gives what they state, and what they merge
   to ([Normalize]), which describes it. *)

exception Refused of string

let refuse fmt = Printf.ksprintf (fun message -> raise (Refused message)) fmt

type types =
  | One of Schema.type_name
  | Or_null of Schema.type_name  (** draft 7's [[T, "null"]] *)

type t =
  | Ref of string  (** A component schema, by its name. *)
  | Null  (** [{type: "null"}], a nullable union's other member. *)
  | Bool of bool
  | Node of node

and node = {
  keys : string list;  (** The keywords it states, by their names. *)
  description : string option;
  type_ : types option;
  format : Schema.format option;
  enum : Schema.literal list option;
  const : bool;
  properties : (string * t) list option;
  required : string list option;
  additional_properties : t option;
  max_properties : int option;
  minimum : float option;
  maximum : float option;
  items : t option;
  all_of : t list option;
  merged : t option;  (** What its [allOf] merges to, when it states one. *)
  any_of : t list option;
  one_of : t list option;
  discriminator : string option;  (** Its property's name. *)
  pattern : string option;
}

let node keys =
  {
    keys;
    description = None;
    type_ = None;
    format = None;
    enum = None;
    const = false;
    properties = None;
    required = None;
    additional_properties = None;
    max_properties = None;
    minimum = None;
    maximum = None;
    items = None;
    all_of = None;
    merged = None;
    any_of = None;
    one_of = None;
    discriminator = None;
    pattern = None;
  }

(* A schema as what it means: one that states an [allOf], what its parts
   merge to. Whether it admits null is the schema's own: its merge is made
   from what it states beside its null. *)
let meant = function Node { merged = Some m; _ } -> m | s -> s

type definitions = {
  names : string list;  (** Every component schema, by its name. *)
  schema : string -> t;  (** A component schema; refused if there is none. *)
}

let stem file = Filename.remove_extension (Filename.basename file)

(* A file written in place that reaches itself would be written in place
   without end. *)
let in_place ~trail file =
  if List.mem file trail then
    refuse "%s reaches itself through the files written in its place" file;
  file :: trail

(* A schema a [$ref] names, as [named] names it or, when it names none, the
   schema written in its place from [schemas]. *)
type referent = Named of string | In_place of string * Schema.t

let referent ~named ~schemas (r : Decode.reference) =
  let key = Table_records.key r in
  match named key with
  | Some name -> Some (Named name)
  | None ->
      if snd (Decode.resolve r) <> "" then
        refuse "$ref %s points into a file at a schema no table record is"
          r.target;
      Option.map (fun s -> In_place (key, s)) (Hashtbl.find_opt schemas key)

(* The schema a [$ref] names, for [Normalize], from [schemas]. *)
let schema_of ~schemas (r : Decode.reference) =
  match Hashtbl.find_opt schemas (Table_records.key r) with
  | Some s -> Ok s
  | None -> Error ("$ref " ^ r.target ^ " names no schema")

(* What a client hands its callers that no wire message carries: each file of
   protocol/specs/src/client/types, and the records of the registry and of the
   state units' notices. *)
let client_types = "client/types/"

let records spec =
  match Table_records.all spec with
  | Ok records -> records
  | Error message -> refuse "%s" message

let client_roots (spec : Spec.t) =
  List.filter
    (String.starts_with ~prefix:client_types)
    (List.map fst spec.schemas)
  @ List.filter_map
      (fun (key, _, _) ->
        if
          String.starts_with ~prefix:"client/registry.json#" key
          || String.starts_with ~prefix:"client/state-units.json#" key
        then Some key
        else None)
      (records spec)

(* The view of a schema written in [file], each [$ref] it holds resolved by
   [named] or written in place from [schemas]. *)
let view ~named ~schemas =
  let rec view s = Schema.para ~boolean:(fun b _ -> Bool b) ~schema:layer s
  and layer (l : (Schema.t * (string list -> t)) Schema.layer) trail =
    let s = Schema.map snd l in
    match s.ref_ with
    | Some r -> (
        match referent ~named ~schemas r with
        | Some (Named name) -> Ref name
        | Some (In_place (file, target)) -> view target (in_place ~trail file)
        | None -> refuse "$ref %s names no schema" r.target)
    | None -> (
        let sub f = f trail in
        let subs = Option.map (List.map sub) in
        let nullable = s.nullable = Some true in
        let keys =
          List.filter
            (fun k -> not (nullable && k = "nullable"))
            (Schema.keywords s)
        in
        let merged =
          Option.map
            (fun _ ->
              match
                Normalize.normalize ~find:(schema_of ~schemas)
                  (Schema.Schema { (Schema.map fst l) with nullable = None })
              with
              | Ok m -> view (Schema.Schema m) trail
              | Error message -> refuse "%s" message)
            s.all_of
        in
        let types =
          match s.type_ with
          | None -> None
          | Some [ t ] -> Some (One t)
          | Some _ ->
              refuse "a schema of several types the generator does not know"
        in
        let own =
          {
            keys;
            description =
              (match merged with
              | Some (Node m) -> m.description
              | _ -> s.description);
            type_ = types;
            format = s.format;
            enum = s.enum;
            const = Option.is_some s.const;
            properties =
              Option.map (List.map (fun (k, v) -> (k, sub v))) s.properties;
            required = s.required;
            additional_properties = Option.map sub s.additional_properties;
            max_properties = s.max_properties;
            minimum = s.minimum;
            maximum = s.maximum;
            items = Option.map sub s.items;
            all_of = subs s.all_of;
            merged;
            any_of = subs s.any_of;
            one_of = subs s.one_of;
            discriminator =
              Option.map
                (fun (d : Schema.discriminator) -> d.property_name)
                s.discriminator;
            pattern = s.pattern;
          }
        in
        if not nullable then Node own
        else
          match types with
          | Some (One t) -> Node { own with type_ = Some (Or_null t) }
          | _ ->
              Node { (node [ "anyOf" ]) with any_of = Some [ Null; Node own ] })
  in
  fun s -> view s []

(* Every [$ref] a schema holds, through the files written in its place. *)
let references ~named ~schemas =
  let rec references s = Schema.cata ~boolean:(fun _ _ -> []) ~schema:layer s
  and layer (s : (string list -> string list) Schema.layer) trail =
    match s.ref_ with
    | Some r -> (
        match referent ~named ~schemas r with
        | Some (Named _) -> [ Table_records.key r ]
        | Some (In_place (file, target)) ->
            references target (in_place ~trail file)
        | None -> [])
    | None -> List.concat_map (fun f -> f trail) (Schema.children s)
  in
  fun s -> references s []

let response_schemas (r : Openapi.response) =
  match r.content with
  | None -> []
  | Some content ->
      List.map (fun (_, (m : Openapi.media_type)) -> m.schema) content

let header_schemas (r : Openapi.response) =
  match r.headers with
  | None -> []
  | Some hs -> List.map (fun (_, (h : Openapi.header)) -> h.schema) hs

type bundle = {
  definitions : definitions;
  view : Schema.t -> t;
      (** Any other schema, each file it names as the bundle names it. *)
  bodies : string list;
      (** Every component schema a request or response body of the paths names.
      *)
  client : string list;
      (** Every client type ([client_roots]), and every schema only they reach,
          by its name: in neither [definitions.names] nor any other writer's
          output unless a writer roots them. *)
}

let bundle (spec : Spec.t) =
  let schemas = Hashtbl.create 1024 in
  List.iter (fun (file, s) -> Hashtbl.replace schemas file s) spec.schemas;
  let records = records spec in
  List.iter (fun (key, _, s) -> Hashtbl.replace schemas key s) records;
  let declared =
    List.map
      (fun (name, r) -> (fst (Decode.resolve r), name))
      spec.gateway.components.schemas
  in
  let titled = List.map (fun (key, name, _) -> (key, name)) records in
  (* A schema is named by the name the document gives it, a table's record by
     its title, and a file of a directory of schemas or of client types by its
     own. *)
  let named key =
    match List.assoc_opt key (declared @ titled) with
    | Some name -> Some name
    | None ->
        if
          Filename.basename (Filename.dirname key) = "schemas"
          || String.starts_with ~prefix:client_types key
        then Some (stem key)
        else None
  in
  let response file =
    match List.assoc_opt file spec.responses with
    | Some r -> r
    | None ->
        refuse
          "the document names the response %s, which Protocol does not have"
          file
  in
  let item_responses (item : Openapi.path_item) =
    List.concat_map
      (fun (op : Openapi.operation) ->
        List.map
          (function
            | _, Openapi.Ref r -> response (fst (Decode.resolve r))
            | _, Openapi.Inline r -> r)
          op.responses)
      (Spec.operations item)
  in
  let items =
    List.map
      (fun (_, r) ->
        let file = fst (Decode.resolve r) in
        match List.assoc_opt file spec.path_items with
        | Some item -> item
        | None ->
            refuse
              "the document names the path item %s, which Protocol does not \
               have"
              file)
      spec.gateway.paths
  in
  let request_schemas (item : Openapi.path_item) =
    List.concat_map
      (fun (op : Openapi.operation) ->
        match op.request_body with
        | None -> []
        | Some body ->
            List.map
              (fun (_, (m : Openapi.media_type)) -> m.schema)
              body.content)
      (Spec.operations item)
  in
  let parameter_schemas (item : Openapi.path_item) =
    List.concat_map
      (fun (op : Openapi.operation) ->
        match op.parameters with
        | None -> []
        | Some ps -> List.map (fun (p : Openapi.parameter) -> p.schema) ps)
      (Spec.operations item)
  in
  let component_responses =
    match spec.gateway.components.responses with
    | None -> []
    | Some rs -> List.map (fun (_, r) -> response (fst (Decode.resolve r))) rs
  in
  let refs = references ~named ~schemas in
  let body_schemas =
    List.concat_map
      (fun item ->
        request_schemas item
        @ List.concat_map response_schemas (item_responses item))
      items
  in
  (* Every schema the document reaches, by its file. *)
  let reached = Hashtbl.create 512 in
  let rec reach file =
    if not (Hashtbl.mem reached file) then (
      Hashtbl.replace reached file ();
      match Hashtbl.find_opt schemas file with
      | Some s -> List.iter reach (refs s)
      | None ->
          refuse
            "the document names the schema %s, which Protocol does not have"
            file)
  in
  List.iter (fun (file, _) -> reach file) declared;
  List.iter reach
    (List.concat_map refs
       (body_schemas
       @ List.concat_map parameter_schemas items
       @ List.concat_map
           (fun r -> response_schemas r @ header_schemas r)
           (component_responses @ List.concat_map item_responses items)
       @ List.concat_map header_schemas (List.concat_map item_responses items)));
  let gateway = Hashtbl.copy reached in
  List.iter reach (client_roots spec);
  let by_name = Hashtbl.create 512 in
  Hashtbl.iter
    (fun file () ->
      let name = Option.get (named file) in
      match Hashtbl.find_opt by_name name with
      | Some other when other <> file ->
          refuse "%s and %s are both the schema %s" other file name
      | _ -> Hashtbl.replace by_name name file)
    reached;
  let views = Hashtbl.create 512 in
  let schema name =
    match Hashtbl.find_opt views name with
    | Some v -> v
    | None -> (
        match Hashtbl.find_opt by_name name with
        | None -> refuse "the spec declares no schema %s" name
        | Some file ->
            let v = view ~named ~schemas (Hashtbl.find schemas file) in
            Hashtbl.replace views name v;
            v)
  in
  let names_of keep =
    List.sort String.compare
      (Hashtbl.fold
         (fun n file acc -> if keep file then n :: acc else acc)
         by_name [])
  in
  let names = names_of (Hashtbl.mem gateway) in
  {
    definitions = { names; schema };
    view = view ~named ~schemas;
    bodies =
      List.filter_map named (List.concat_map refs body_schemas)
      |> List.sort_uniq String.compare;
    client = names_of (fun file -> not (Hashtbl.mem gateway file));
  }

(* One schema file alone, as its own definitions: its [$ref]s are refused. *)
let alone ~name (s : Schema.t) =
  let v =
    view
      ~named:(fun file ->
        refuse "%s refers to %s, and is generated alone" name file)
      ~schemas:(Hashtbl.create 0) s
  in
  {
    names = [ name ];
    schema =
      (fun n ->
        if n = name then v else refuse "the spec declares no schema %s" n);
  }

(* The schema that states each property of [name]'s schema [s], as
   [Inherited.owners] decides it: an [allOf]'s members are its parts, and any
   other schema is one part stating its own properties. *)
let owners definitions name s =
  let stated = function
    | Node { properties = Some ps; _ } -> Inherited.Stated (List.map fst ps)
    | _ -> Inherited.Stated []
  in
  let parts = function
    | Node { all_of = Some members; _ } ->
        List.map
          (function Ref n -> Inherited.Component n | m -> stated m)
          members
    | s -> [ stated s ]
  in
  Inherited.owners ~parts:(fun n -> parts (definitions.schema n)) name (parts s)
