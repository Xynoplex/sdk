(* The gateway's component schemas as the Rust and Swift types are generated
   from them: the document bundled (each file it names as a component, or that
   a directory of schemas holds, is a schema by its name, and any other file a
   [$ref] names is written in its place, the [$ref]'s siblings with it gone),
   and OpenAPI's [nullable] as JSON Schema draft 7 states it: beside one
   [type], [null] is a second type; beside anything else, the schema is a
   union of [null] and the rest. *)

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
    any_of = None;
    one_of = None;
    discriminator = None;
    pattern = None;
  }

type definitions = {
  names : string list;  (** Every component schema, by its name. *)
  schema : string -> t;  (** A component schema; refused if there is none. *)
}

let stem file = Filename.remove_extension (Filename.basename file)

(* The view of a schema written in [file], each [$ref] it holds resolved by
   [named] or written in place from [schemas]. *)
let rec view ~named ~schemas (s : Schema.t) =
  match s with
  | Schema.Boolean_schema b -> Bool b
  | Schema.Schema ({ ref_ = Some r; _ } as _s) -> (
      let file, pointer = Decode.resolve r in
      if pointer <> "" then
        refuse
          "$ref %s points into a file: protocol/specs/src refers to whole files"
          r.target;
      match named file with
      | Some name -> Ref name
      | None -> (
          match Hashtbl.find_opt schemas file with
          | Some target -> view ~named ~schemas target
          | None -> refuse "$ref %s names no schema" r.target))
  | Schema.Schema s -> (
      let sub = view ~named ~schemas in
      let subs = Option.map (List.map sub) in
      let nullable = s.nullable = Some true in
      let keys =
        List.filter
          (fun k -> not (nullable && k = "nullable"))
          (Schema.keywords s)
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
          description = s.description;
          type_ = types;
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
        | _ -> Node { (node [ "anyOf" ]) with any_of = Some [ Null; Node own ] }
      )

(* Every [$ref] a schema holds, through the files written in its place. *)
let rec references ~named ~schemas (s : Schema.t) =
  match s with
  | Schema.Boolean_schema _ -> []
  | Schema.Schema { ref_ = Some r; _ } -> (
      let file, _ = Decode.resolve r in
      match named file with
      | Some _ -> [ file ]
      | None -> (
          match Hashtbl.find_opt schemas file with
          | Some target -> references ~named ~schemas target
          | None -> []))
  | Schema.Schema s ->
      let each = List.concat_map (references ~named ~schemas) in
      let opt = function
        | None -> []
        | Some x -> references ~named ~schemas x
      in
      let opts = function None -> [] | Some xs -> each xs in
      List.concat
        [
          (match s.properties with
          | None -> []
          | Some ps -> each (List.map snd ps));
          opt s.additional_properties;
          opt s.property_names;
          opt s.items;
          opts s.all_of;
          opts s.any_of;
          opts s.one_of;
          opt s.not_;
        ]

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
}

let bundle (spec : Spec.t) =
  let schemas = Hashtbl.create 1024 in
  List.iter (fun (file, s) -> Hashtbl.replace schemas file s) spec.schemas;
  let declared =
    List.map
      (fun (name, r) -> (fst (Decode.resolve r), name))
      spec.gateway.components.schemas
  in
  (* A file is a schema by the name the document gives it, or by its own in a
     directory of schemas. *)
  let named file =
    match List.assoc_opt file declared with
    | Some name -> Some name
    | None ->
        if Filename.basename (Filename.dirname file) = "schemas" then
          Some (stem file)
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
  let names =
    List.sort String.compare (Hashtbl.fold (fun n _ acc -> n :: acc) by_name [])
  in
  {
    definitions = { names; schema };
    view = view ~named ~schemas;
    bodies =
      List.filter_map named (List.concat_map refs body_schemas)
      |> List.sort_uniq String.compare;
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
