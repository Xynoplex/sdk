(* Every schema the Haskell SDK's models type, by name: the gateway's
   component schemas, and the schemas the SDK derives beside them. A
   component is named by its file. Beside them are the form a resource's
   upload states its metadata in (ResourceUpload without its file), the trace
   carrier, the records of the client registry, of the state units' notices
   and of how a session ends, the stored sign-in, session and resources, the
   options of an engine, of a gather and of a search (each a request without
   what an SDK passes positionally), what an HTTP operation states in place,
   and each bus envelope. None may take a component's name. *)

let ( let* ) = Result.bind

module Named = Map.Make (String)

let each f xs =
  Result.map List.rev
    (List.fold_left
       (fun found x ->
         let* found = found in
         let* y = f x in
         Ok (y :: found))
       (Ok []) xs)

exception Unresolved of string

(* [schema] as the models compare and name it: a reference by what it names,
   rewritten by [rewrite] if that names it otherwise, and members in order of
   name. *)
let canonical ~rewrite : Schema.t -> Schema.t =
  Schema.cata
    ~boolean:(fun b -> Schema.Boolean_schema b)
    ~schema:(fun s ->
      Schema.Schema
        {
          s with
          ref_ =
            Option.map
              (fun r -> { Decode.target = rewrite r; file = ""; pointer = "" })
              s.ref_;
          properties =
            Option.map
              (List.sort (fun (a, _) (b, _) -> String.compare a b))
              s.properties;
          example = Option.map Yojson.Safe.sort s.example;
        })

let unchanged (r : Decode.reference) = r.target

let layer name = function
  | Schema.Schema s -> Ok s
  | Boolean_schema _ -> Error (name ^ " is no schema object")

let property name key (s : Schema.schema) =
  match Option.bind s.properties (List.assoc_opt key) with
  | Some p -> Ok p
  | None -> Error (name ^ " has no property " ^ key)

let without_properties keys (s : Schema.schema) =
  {
    s with
    properties =
      Option.map
        (List.filter (fun (k, _) -> not (List.mem k keys)))
        s.properties;
  }

let reference name =
  Schema.Schema
    {
      Schema.empty with
      ref_ = Some { Decode.target = name ^ ".json"; file = ""; pointer = "" };
    }

let with_property key schema (s : Schema.schema) =
  {
    s with
    properties =
      Some
        (List.map
           (fun (k, v) -> if k = key then (k, schema) else (k, v))
           (Option.value s.properties ~default:[])
        @
        if List.mem_assoc key (Option.value s.properties ~default:[]) then []
        else [ (key, schema) ]);
  }

let payload_types = "typescript/core/src/payload-types.ts"

let squeeze text =
  String.concat ""
    (List.map (String.make 1)
       (List.filter
          (fun c -> not (List.mem c [ ' '; '\n'; '\r'; '\t' ]))
          (List.of_seq (String.to_seq text))))

(* The component schemas, each the schema of the file its reference names. *)
let components (spec : Spec.t) =
  each
    (fun (name, (r : Decode.reference)) ->
      let file, fragment = Decode.resolve r in
      let base = Filename.remove_extension (Filename.basename r.target) in
      if
        fragment <> ""
        || Filename.extension r.target <> ".json"
        || base <> name
        || Marker.find "://" r.target <> None
      then
        Error
          ("OpenAPI schema reference needs an explicit Haskell naming rule: "
         ^ name)
      else
        match List.assoc_opt file spec.schemas with
        | Some s -> Ok (name, s)
        | None -> Error ("no schema file " ^ file))
    spec.gateway.components.schemas

(* A table's record that a reference into the table names is named by its
   title. *)
let titled (spec : Spec.t) (r : Decode.reference) =
  let file, fragment = Decode.resolve r in
  if fragment = "" then r.target
  else
    let target =
      match (file, String.split_on_char '/' fragment) with
      | "client/registry.json", [ ""; "types"; name ] ->
          List.assoc_opt name spec.tables.client_registry.types
      | "session/stored.json", [ ""; "storedSession" ] ->
          Some spec.tables.session_stored.stored_session
      | "session/cases.json", [ ""; "told" ] ->
          Some spec.tables.session_cases.told
      | _ -> None
    in
    match target with
    | Some (Schema { title = Some title; _ }) -> title ^ ".json"
    | Some _ ->
        raise (Unresolved ("reference to a schema with no title: " ^ r.target))
    | None ->
        raise (Unresolved ("reference into a table not read: " ^ r.target))

let derive ~root (spec : Spec.t) ~adapters ~carrier ~http ~envelopes =
  let* components = components spec in
  let component name =
    match List.assoc_opt name components with
    | Some s -> Ok s
    | None -> Error (name ^ " schema missing")
  in
  let normalize s =
    Normalize.normalize
      ~find:(fun name ->
        match List.assoc_opt name components with
        | Some s -> Ok s
        | None -> Error ("unknown schema reference: " ^ name))
      (canonical ~rewrite:unchanged s)
  in
  let* upload =
    Result.bind (component "ResourceUpload") (layer "ResourceUpload")
  in
  let* _ = property "ResourceUpload" "file" upload in
  let* required =
    Option.to_result ~none:"ResourceUpload has no required list" upload.required
  in
  let metadata =
    Schema.Schema
      {
        (without_properties [ "file" ] upload) with
        required = Some (List.filter (( <> ) "file") required);
      }
  in
  let* () =
    if
      Marker.find
        "exporttypeEngineWithLimits=EngineEntry&{limits?:components['schemas']['InferenceLimits'];};"
        (squeeze (Marker.read ~root payload_types))
      = None
    then Error "EngineWithLimits changed: update its derived Haskell adapter"
    else Ok ()
  in
  let* engine = Result.bind (component "EngineEntry") normalize in
  let* () =
    if engine.properties = None then Error "EngineEntry properties missing"
    else Ok ()
  in
  let* gather =
    Result.bind
      (component "GatherResourceRequestOptions")
      (layer "GatherResourceRequestOptions")
  in
  let* search =
    Result.bind (component "MatchSearchRequest") (layer "MatchSearchRequest")
  in
  let positional = [ "resourceId"; "referenceId"; "context" ] in
  let* _ = each (fun k -> property "MatchSearchRequest" k search) positional in
  let options =
    [
      ( "EngineWithLimits",
        Schema.Schema
          (with_property "limits" (reference "InferenceLimits") engine) );
      ("GatherResourceOptions", Schema.Schema { gather with required = None });
      ( "MatchSearchOptions",
        Schema.Schema
          { (without_properties positional search) with required = None } );
    ]
  in
  let tables = spec.tables in
  let* told_title =
    match tables.session_cases.told with
    | Schema { title = Some t; _ } -> Ok t
    | _ -> Error "session end reasons have no title"
  in
  let pointed =
    tables.client_registry.types @ tables.client_state_units.notices
  in
  let told = (told_title, tables.session_cases.told) in
  let adapter_names =
    List.map fst adapters @ List.map fst pointed @ [ fst told ]
  in
  let* () =
    if
      List.length (List.sort_uniq String.compare adapter_names)
      <> List.length adapter_names
    then Error "an SDK-owned adapter and a record of the spec share a name"
    else Ok ()
  in
  let* records =
    match
      List.map (fun (n, s) -> (n, canonical ~rewrite:(titled spec) s)) pointed
    with
    | records -> Ok (records @ [ told ])
    | exception Unresolved message -> Error message
  in
  let* pending =
    layer "pending authorization" tables.session_stored.pending_authorization
  in
  let* issuer = property "pending authorization" "issuer" pending in
  let* sign_in =
    Option.to_result ~none:"SignIn schema missing"
      (List.assoc_opt "sign-in-store/SignIn.json" spec.schemas)
  in
  let stored =
    List.sort (fun (a, _) (b, _) -> String.compare a b) (adapters @ records)
    @ [
        ("SignIn", sign_in);
        ("StoredSession", tables.session_stored.stored_session);
        ("OpenResource", tables.session_stored.open_resource_schema);
        ("IssuerEndpoints", issuer);
        ( "PendingAuthorization",
          Schema.Schema
            (with_property "issuer" (reference "IssuerEndpoints") pending) );
      ]
  in
  let derived =
    [ ("ResourceUploadMetadata", metadata); ("TraceCarrier", carrier) ]
    @ stored @ options @ http @ envelopes
  in
  let* () =
    match List.find_opt (fun (n, _) -> List.mem_assoc n components) derived with
    | Some (n, _) -> Error ("adapter schema name is owned by OpenAPI: " ^ n)
    | None -> Ok ()
  in
  let all = components @ derived in
  let names = List.map fst all in
  let* () =
    if List.length (List.sort_uniq String.compare names) <> List.length names
    then Error "two schemas the models type share a name"
    else Ok ()
  in
  Ok
    (List.sort
       (fun (a, _) (b, _) -> String.compare a b)
       (List.map (fun (n, s) -> (n, canonical ~rewrite:unchanged s)) all))
