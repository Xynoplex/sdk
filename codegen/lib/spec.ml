(* The pinned Protocol's specs/src, every file of it accounted for and every
   JSON file read into the model. A file is one of:
   - the two OpenAPI documents (specs/README.md: "the gateway and Archivist
     OpenAPI documents");
   - a path item, which a document's "paths" names;
   - a response, which a document's components or an operation names;
   - a table, each of which the model names here and types in Tables;
   - a fixture, which smelter/extraction-cases.json names;
   - a README.md;
   - a JSON Schema: every other JSON file.
   Any other file is refused, as is a file the model names that Protocol does
   not have, and every "$ref" must name a file of the kind its place calls
   for. *)

let ( let+ ) result f = Result.map f result

let ( and+ ) a b =
  match (a, b) with
  | Ok a, Ok b -> Ok (a, b)
  | Error e, Ok _ | Ok _, Error e -> Error e
  | Error a, Error b -> Error (a @ b)

let ( let* ) = Result.bind

let all results =
  List.fold_right
    (fun result rest ->
      let+ value = result and+ values = rest in
      value :: values)
    results (Ok [])

type loader = {
  table : 'a. string -> (Decode.cursor -> 'a) -> ('a, Decode.error list) result;
}

type tables = {
  annotations_builder_cases : Tables.Annotations_builder_cases.t;
  annotations_id_cases : Tables.Annotations_id_cases.t;
  annotations_pdf_locate_cases : Tables.Annotations_pdf_locate_cases.t;
  annotations_reader_cases : Tables.Annotations_reader_cases.t;
  annotations_reconcile_cases : Tables.Annotations_reconcile_cases.t;
  archivist_shard_cases : Tables.Archivist_shard_cases.t;
  bus_frame_cases : Tables.Bus_frame_cases.t;
  bus_log_cases : Tables.Bus_log_cases.t;
  bus_registry : Tables.Bus_registry.t;
  bus_reply_bounds : Tables.Bus_reply_bounds.t;
  client_clock_cases : Tables.Client_clock_cases.t;
  client_discovery_absent : Tables.Client_discovery_absent.t;
  client_refresh : Tables.Client_refresh.t;
  client_registry : Tables.Client_registry.t;
  client_state_units : Tables.Client_state_units.t;
  client_surface : Tables.Client_surface.t;
  client_testing : Tables.Client_testing.t;
  client_timing : Tables.Client_timing.t;
  control_cli : Tables.Control_cli.t;
  control_methods : Tables.Control_methods.t;
  control_request_cases : Tables.Control_request_cases.t;
  errors_codes : Tables.Errors_codes.t;
  follower_follow_cases : Tables.Follower_follow_cases.t;
  graph_codec_cases : Tables.Graph_codec_cases.t;
  graph_database_cases : Tables.Graph_database_cases.t;
  identifiers_kinds : Tables.Identifiers_kinds.t;
  jobs_filter_cases : Tables.Jobs_filter_cases.t;
  jobs_retry_cases : Tables.Jobs_retry_cases.t;
  jobs_storage : Tables.Jobs_storage.t;
  kb_identity_cases : Tables.Kb_identity_cases.t;
  librarian_derive_views_cases : Tables.Librarian_derive_views_cases.t;
  librarian_knowledge_graph_cases : Tables.Librarian_knowledge_graph_cases.t;
  librarian_prompt_cases : Tables.Librarian_prompt_cases.t;
  librarian_reply_cases : Tables.Librarian_reply_cases.t;
  librarian_score_cases : Tables.Librarian_score_cases.t;
  librarian_search_cases : Tables.Librarian_search_cases.t;
  librarian_window_cases : Tables.Librarian_window_cases.t;
  locales_registry : Tables.Locales_registry.t;
  media_types_cases : Tables.Media_types_cases.t;
  media_types_registry : Tables.Media_types_registry.t;
  principals_cases : Tables.Principals_cases.t;
  principals_kind_cases : Tables.Principals_kind_cases.t;
  principals_naming_cases : Tables.Principals_naming_cases.t;
  resources_reader_cases : Tables.Resources_reader_cases.t;
  retry_cases : Tables.Retry_cases.t;
  sdk_telemetry_telemetry : Tables.Sdk_telemetry_telemetry.t;
  service_environment_variables : Tables.Service_environment_variables.t;
  service_telemetry_telemetry : Tables.Service_telemetry_telemetry.t;
  session_cache_cases : Tables.Session_cache_cases.t;
  session_cases : Tables.Session_cases.t;
  session_client_assertion_cases : Tables.Session_client_assertion_cases.t;
  session_gateway_url_cases : Tables.Session_gateway_url_cases.t;
  session_oauth : Tables.Session_oauth.t;
  session_open_resource_cases : Tables.Session_open_resource_cases.t;
  session_persisted_cases : Tables.Session_persisted_cases.t;
  session_registry_cases : Tables.Session_registry_cases.t;
  session_registry_errors_cases : Tables.Session_registry_errors_cases.t;
  session_stored : Tables.Session_stored.t;
  sign_in_store_cases : Tables.Sign_in_store_cases.t;
  sign_in_store_owner_only : Tables.Sign_in_store_owner_only.t;
  smelter_extraction_cases : Tables.Smelter_extraction_cases.t;
  smelter_reconcile_cases : Tables.Smelter_reconcile_cases.t;
  stack_cases : Tables.Stack_cases.t;
  text_chunk_cases : Tables.Text_chunk_cases.t;
  text_decode_cases : Tables.Text_decode_cases.t;
  text_encoding_cases : Tables.Text_encoding_cases.t;
  text_offset_cases : Tables.Text_offset_cases.t;
  vectors_payload_cases : Tables.Vectors_payload_cases.t;
  vectors_store_cases : Tables.Vectors_store_cases.t;
  vectors_token_cases : Tables.Vectors_token_cases.t;
  weaver_fold_cases : Tables.Weaver_fold_cases.t;
  worker_chunk_plan_cases : Tables.Worker_chunk_plan_cases.t;
  worker_citation_cases : Tables.Worker_citation_cases.t;
  worker_failure_class_cases : Tables.Worker_failure_class_cases.t;
  worker_parser_cases : Tables.Worker_parser_cases.t;
}

let tables { table } =
  let+ annotations_builder_cases =
    table "annotations/builder-cases.json"
      Tables.Annotations_builder_cases.decode
  and+ annotations_id_cases =
    table "annotations/id-cases.json" Tables.Annotations_id_cases.decode
  and+ annotations_pdf_locate_cases =
    table "annotations/pdf-locate-cases.json"
      Tables.Annotations_pdf_locate_cases.decode
  and+ annotations_reader_cases =
    table "annotations/reader-cases.json" Tables.Annotations_reader_cases.decode
  and+ annotations_reconcile_cases =
    table "annotations/reconcile-cases.json"
      Tables.Annotations_reconcile_cases.decode
  and+ archivist_shard_cases =
    table "archivist/shard-cases.json" Tables.Archivist_shard_cases.decode
  and+ bus_frame_cases =
    table "bus/frame-cases.json" Tables.Bus_frame_cases.decode
  and+ bus_log_cases = table "bus/log-cases.json" Tables.Bus_log_cases.decode
  and+ bus_registry = table "bus/registry.json" Tables.Bus_registry.decode
  and+ bus_reply_bounds =
    table "bus/reply-bounds.json" Tables.Bus_reply_bounds.decode
  and+ client_clock_cases =
    table "client/clock-cases.json" Tables.Client_clock_cases.decode
  and+ client_discovery_absent =
    table "client/discovery-absent.json" Tables.Client_discovery_absent.decode
  and+ client_refresh = table "client/refresh.json" Tables.Client_refresh.decode
  and+ client_registry =
    table "client/registry.json" Tables.Client_registry.decode
  and+ client_state_units =
    table "client/state-units.json" Tables.Client_state_units.decode
  and+ client_surface = table "client/surface.json" Tables.Client_surface.decode
  and+ client_testing = table "client/testing.json" Tables.Client_testing.decode
  and+ client_timing = table "client/timing.json" Tables.Client_timing.decode
  and+ control_cli = table "control/cli.json" Tables.Control_cli.decode
  and+ control_methods =
    table "control/methods.json" Tables.Control_methods.decode
  and+ control_request_cases =
    table "control/request-cases.json" Tables.Control_request_cases.decode
  and+ errors_codes = table "errors/codes.json" Tables.Errors_codes.decode
  and+ follower_follow_cases =
    table "follower/follow-cases.json" Tables.Follower_follow_cases.decode
  and+ graph_codec_cases =
    table "graph/codec-cases.json" Tables.Graph_codec_cases.decode
  and+ graph_database_cases =
    table "graph/database-cases.json" Tables.Graph_database_cases.decode
  and+ identifiers_kinds =
    table "identifiers/kinds.json" Tables.Identifiers_kinds.decode
  and+ jobs_filter_cases =
    table "jobs/filter-cases.json" Tables.Jobs_filter_cases.decode
  and+ jobs_retry_cases =
    table "jobs/retry-cases.json" Tables.Jobs_retry_cases.decode
  and+ jobs_storage = table "jobs/storage.json" Tables.Jobs_storage.decode
  and+ kb_identity_cases =
    table "kb-identity/cases.json" Tables.Kb_identity_cases.decode
  and+ librarian_derive_views_cases =
    table "librarian/derive-views-cases.json"
      Tables.Librarian_derive_views_cases.decode
  and+ librarian_knowledge_graph_cases =
    table "librarian/knowledge-graph-cases.json"
      Tables.Librarian_knowledge_graph_cases.decode
  and+ librarian_prompt_cases =
    table "librarian/prompt-cases.json" Tables.Librarian_prompt_cases.decode
  and+ librarian_reply_cases =
    table "librarian/reply-cases.json" Tables.Librarian_reply_cases.decode
  and+ librarian_score_cases =
    table "librarian/score-cases.json" Tables.Librarian_score_cases.decode
  and+ librarian_search_cases =
    table "librarian/search-cases.json" Tables.Librarian_search_cases.decode
  and+ librarian_window_cases =
    table "librarian/window-cases.json" Tables.Librarian_window_cases.decode
  and+ locales_registry =
    table "locales/registry.json" Tables.Locales_registry.decode
  and+ media_types_cases =
    table "media-types/cases.json" Tables.Media_types_cases.decode
  and+ media_types_registry =
    table "media-types/registry.json" Tables.Media_types_registry.decode
  and+ principals_cases =
    table "principals/cases.json" Tables.Principals_cases.decode
  and+ principals_kind_cases =
    table "principals/kind-cases.json" Tables.Principals_kind_cases.decode
  and+ principals_naming_cases =
    table "principals/naming-cases.json" Tables.Principals_naming_cases.decode
  and+ resources_reader_cases =
    table "resources/reader-cases.json" Tables.Resources_reader_cases.decode
  and+ retry_cases = table "retry/cases.json" Tables.Retry_cases.decode
  and+ sdk_telemetry_telemetry =
    table "sdk-telemetry/telemetry.json" Tables.Sdk_telemetry_telemetry.decode
  and+ service_environment_variables =
    table "service-environment/variables.json"
      Tables.Service_environment_variables.decode
  and+ service_telemetry_telemetry =
    table "service-telemetry/telemetry.json"
      Tables.Service_telemetry_telemetry.decode
  and+ session_cache_cases =
    table "session/cache-cases.json" Tables.Session_cache_cases.decode
  and+ session_cases = table "session/cases.json" Tables.Session_cases.decode
  and+ session_client_assertion_cases =
    table "session/client-assertion-cases.json"
      Tables.Session_client_assertion_cases.decode
  and+ session_gateway_url_cases =
    table "session/gateway-url-cases.json"
      Tables.Session_gateway_url_cases.decode
  and+ session_oauth = table "session/oauth.json" Tables.Session_oauth.decode
  and+ session_open_resource_cases =
    table "session/open-resource-cases.json"
      Tables.Session_open_resource_cases.decode
  and+ session_persisted_cases =
    table "session/persisted-cases.json" Tables.Session_persisted_cases.decode
  and+ session_registry_cases =
    table "session/registry-cases.json" Tables.Session_registry_cases.decode
  and+ session_registry_errors_cases =
    table "session/registry-errors-cases.json"
      Tables.Session_registry_errors_cases.decode
  and+ session_stored = table "session/stored.json" Tables.Session_stored.decode
  and+ sign_in_store_cases =
    table "sign-in-store/cases.json" Tables.Sign_in_store_cases.decode
  and+ sign_in_store_owner_only =
    table "sign-in-store/owner-only.json" Tables.Sign_in_store_owner_only.decode
  and+ smelter_extraction_cases =
    table "smelter/extraction-cases.json" Tables.Smelter_extraction_cases.decode
  and+ smelter_reconcile_cases =
    table "smelter/reconcile-cases.json" Tables.Smelter_reconcile_cases.decode
  and+ stack_cases = table "stack/cases.json" Tables.Stack_cases.decode
  and+ text_chunk_cases =
    table "text/chunk-cases.json" Tables.Text_chunk_cases.decode
  and+ text_decode_cases =
    table "text/decode-cases.json" Tables.Text_decode_cases.decode
  and+ text_encoding_cases =
    table "text/encoding-cases.json" Tables.Text_encoding_cases.decode
  and+ text_offset_cases =
    table "text/offset-cases.json" Tables.Text_offset_cases.decode
  and+ vectors_payload_cases =
    table "vectors/payload-cases.json" Tables.Vectors_payload_cases.decode
  and+ vectors_store_cases =
    table "vectors/store-cases.json" Tables.Vectors_store_cases.decode
  and+ vectors_token_cases =
    table "vectors/token-cases.json" Tables.Vectors_token_cases.decode
  and+ weaver_fold_cases =
    table "weaver/fold-cases.json" Tables.Weaver_fold_cases.decode
  and+ worker_chunk_plan_cases =
    table "worker/chunk-plan-cases.json" Tables.Worker_chunk_plan_cases.decode
  and+ worker_citation_cases =
    table "worker/citation-cases.json" Tables.Worker_citation_cases.decode
  and+ worker_failure_class_cases =
    table "worker/failure-class-cases.json"
      Tables.Worker_failure_class_cases.decode
  and+ worker_parser_cases =
    table "worker/parser-cases.json" Tables.Worker_parser_cases.decode
  in
  {
    annotations_builder_cases;
    annotations_id_cases;
    annotations_pdf_locate_cases;
    annotations_reader_cases;
    annotations_reconcile_cases;
    archivist_shard_cases;
    bus_frame_cases;
    bus_log_cases;
    bus_registry;
    bus_reply_bounds;
    client_clock_cases;
    client_discovery_absent;
    client_refresh;
    client_registry;
    client_state_units;
    client_surface;
    client_testing;
    client_timing;
    control_cli;
    control_methods;
    control_request_cases;
    errors_codes;
    follower_follow_cases;
    graph_codec_cases;
    graph_database_cases;
    identifiers_kinds;
    jobs_filter_cases;
    jobs_retry_cases;
    jobs_storage;
    kb_identity_cases;
    librarian_derive_views_cases;
    librarian_knowledge_graph_cases;
    librarian_prompt_cases;
    librarian_reply_cases;
    librarian_score_cases;
    librarian_search_cases;
    librarian_window_cases;
    locales_registry;
    media_types_cases;
    media_types_registry;
    principals_cases;
    principals_kind_cases;
    principals_naming_cases;
    resources_reader_cases;
    retry_cases;
    sdk_telemetry_telemetry;
    service_environment_variables;
    service_telemetry_telemetry;
    session_cache_cases;
    session_cases;
    session_client_assertion_cases;
    session_gateway_url_cases;
    session_oauth;
    session_open_resource_cases;
    session_persisted_cases;
    session_registry_cases;
    session_registry_errors_cases;
    session_stored;
    sign_in_store_cases;
    sign_in_store_owner_only;
    smelter_extraction_cases;
    smelter_reconcile_cases;
    stack_cases;
    text_chunk_cases;
    text_decode_cases;
    text_encoding_cases;
    text_offset_cases;
    vectors_payload_cases;
    vectors_store_cases;
    vectors_token_cases;
    weaver_fold_cases;
    worker_chunk_plan_cases;
    worker_citation_cases;
    worker_failure_class_cases;
    worker_parser_cases;
  }

type t = {
  gateway : Openapi.document;
  archivist : Openapi.document;
  path_items : (string * Openapi.path_item) list;
  responses : (string * Openapi.response) list;
  schemas : (string * Schema.t) list;
  tables : tables;
}

type kind = Document | Path_item | Response | Table | Schema_file

let kind_name = function
  | Document -> "an OpenAPI document"
  | Path_item -> "a path item"
  | Response -> "a response"
  | Table -> "a table"
  | Schema_file -> "a JSON Schema"

let refusal file pointer message = { Decode.file; pointer; message }

let refused_at (reference : Decode.reference) message =
  refusal reference.file reference.pointer message

let rec walk root relative =
  let path = Filename.concat root relative in
  if Sys.is_directory path then
    Sys.readdir path |> Array.to_list |> List.sort compare
    |> List.concat_map (fun name ->
        walk root (if relative = "" then name else relative ^ "/" ^ name))
  else [ relative ]

let operations (item : Openapi.path_item) =
  List.filter_map Fun.id [ item.get; item.put; item.post ]

let operation_responses item =
  List.concat_map
    (fun (operation : Openapi.operation) ->
      List.filter_map
        (function
          | _, Openapi.Ref reference -> Some reference
          | _, Openapi.Inline _ -> None)
        operation.responses)
    (operations item)

let component_responses (document : Openapi.document) =
  match document.components.responses with
  | None -> []
  | Some responses -> List.map snd responses

(* The files the references name that Protocol has; a reference naming one it
   does not have is refused where it is written. *)
let named_files files references =
  List.sort_uniq compare (List.map (fun r -> fst (Decode.resolve r)) references)
  |> List.filter (fun file -> List.mem file files)

let same (a : Decode.reference) (b : Decode.reference) =
  a.file = b.file && a.pointer = b.pointer

let load root =
  let files = walk root "" in
  let decoded = Hashtbl.create 1024 in
  let references = ref [] in
  let decode kind file decoder =
    if not (List.mem file files) then
      Error
        [ refusal file "" "the model reads this file, and Protocol has none" ]
    else
      match Decode.parse_file ~root file with
      | Error error -> Error [ error ]
      | Ok json -> (
          match Decode.run ~file json decoder with
          | Error error -> Error [ error ]
          | Ok (value, found) ->
              Hashtbl.replace decoded file (kind, json);
              references := found @ !references;
              Ok value)
  in
  let named kind decoder file =
    let+ value = decode kind file decoder in
    (file, value)
  in
  (* The directory smelter/extraction-cases.json's "fixtures" names, from the
     repository's root, within specs/src; and the fixtures its cases name. *)
  let fixtures_of (extraction : Tables.Smelter_extraction_cases.t) =
    let prefix = "specs/src/" in
    let directory = extraction.fixtures in
    if not (String.starts_with ~prefix directory) then
      Error
        [
          refusal "smelter/extraction-cases.json" "/fixtures"
            "names a directory outside specs/src";
        ]
    else
      let within =
        String.sub directory (String.length prefix)
          (String.length directory - String.length prefix)
      in
      Ok
        ( within,
          List.filter_map
            (fun (case : Tables.Smelter_extraction_cases.case) ->
              Option.map (fun fixture -> within ^ "/" ^ fixture) case.fixture)
            extraction.cases )
  in
  let* gateway, archivist, tables =
    let+ gateway = decode Document "openapi.json" Openapi.document
    and+ archivist = decode Document "archivist/openapi.json" Openapi.document
    and+ tables =
      tables { table = (fun file decoder -> decode Table file decoder) }
    in
    (gateway, archivist, tables)
  in
  let documents = [ gateway; archivist ] in
  let* path_items =
    documents
    |> List.concat_map (fun (document : Openapi.document) ->
        List.map snd document.paths)
    |> named_files files
    |> List.map (named Path_item Openapi.path_item)
    |> all
  in
  let response_references =
    List.concat_map component_responses documents
    @ List.concat_map (fun (_, item) -> operation_responses item) path_items
  in
  let* responses =
    named_files files response_references
    |> List.map (named Response Openapi.response)
    |> all
  in
  let* fixture_directory, fixtures =
    fixtures_of tables.smelter_extraction_cases
  in
  let is_fixture file =
    String.starts_with ~prefix:(fixture_directory ^ "/") file
  in
  let is_readme file = Filename.basename file = "README.md" in
  let schemas =
    files
    |> List.filter (fun file ->
        Filename.check_suffix file ".json"
        && (not (Hashtbl.mem decoded file))
        && not (is_fixture file))
    |> List.map (named Schema_file Schema.decode)
    |> all
  in
  let census =
    List.filter_map
      (fun file ->
        if Hashtbl.mem decoded file || is_readme file || is_fixture file then
          None
        else Some (refusal file "" "a file the model does not know"))
      files
    @ List.filter_map
        (fun fixture ->
          if List.mem fixture files then None
          else
            Some
              (refusal "smelter/extraction-cases.json" "/cases"
                 (Printf.sprintf
                    "names the fixture %s, which Protocol does not have" fixture)))
        fixtures
  in
  let whole kind (reference : Decode.reference) =
    let target, fragment = Decode.resolve reference in
    match Hashtbl.find_opt decoded target with
    | Some (found, _) when found = kind && fragment = "" -> None
    | Some (found, _) ->
        Some
          (refused_at reference
             (Printf.sprintf "names %s, %s where %s belongs" reference.target
                (kind_name found) (kind_name kind)))
    | None ->
        Some
          (refused_at reference
             (Printf.sprintf "names %s, which Protocol does not have"
                reference.target))
  in
  let schema (reference : Decode.reference) =
    let target, fragment = Decode.resolve reference in
    match Hashtbl.find_opt decoded target with
    | Some (Schema_file, _) when fragment = "" -> None
    | Some (((Schema_file | Table) as found), json) -> (
        match Decode.at_pointer fragment json with
        | None ->
            Some
              (refused_at reference
                 (Printf.sprintf "names %s, which is nothing in %s"
                    reference.target (kind_name found)))
        | Some node -> (
            match
              Decode.run ~file:(target ^ "#" ^ fragment) node Schema.decode
            with
            | Ok _ -> None
            | Error error ->
                Some
                  (refused_at reference
                     (Printf.sprintf "names %s, which is not a JSON Schema: %s"
                        reference.target
                        (Decode.error_to_string error)))))
    | Some (found, _) ->
        Some
          (refused_at reference
             (Printf.sprintf "names %s, %s where a JSON Schema belongs"
                reference.target (kind_name found)))
    | None ->
        Some
          (refused_at reference
             (Printf.sprintf "names %s, which Protocol does not have"
                reference.target))
  in
  let path_references =
    List.concat_map
      (fun (document : Openapi.document) -> List.map snd document.paths)
      documents
  in
  let schema_file_references =
    List.concat_map
      (fun (document : Openapi.document) ->
        List.map snd document.components.schemas)
      documents
  in
  let placed = path_references @ response_references @ schema_file_references in
  let unresolved =
    List.filter_map (whole Path_item) path_references
    @ List.filter_map (whole Response) response_references
    @ List.filter_map (whole Schema_file) schema_file_references
    @ List.filter_map schema
        (List.filter
           (fun reference -> not (List.exists (same reference) placed))
           (List.rev !references))
  in
  match (schemas, census @ unresolved) with
  | Ok schemas, [] ->
      Ok { gateway; archivist; path_items; responses; schemas; tables }
  | Ok _, errors -> Error errors
  (* A file that is no JSON Schema leaves the references to it unresolved, so
     its refusal is given in their place. *)
  | Error errors, _ -> Error (errors @ census)
