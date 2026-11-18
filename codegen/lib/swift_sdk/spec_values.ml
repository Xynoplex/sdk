(* The tables the Swift SDK holds whole, each as the JSON value its file
   states, by the name the SDK gives it: the type each one's Swift value has is
   inferred from that value. Each is written back from its typed table, whose
   every field the patterns here name, so a field the table gains fails to
   compile here; census.exe holds each to its file. *)

let string s = `String s
let strings l = `List (List.map string l)
let optional key write = function None -> [] | Some v -> [ (key, write v) ]

let telemetry_spans (t : Tables.Sdk_telemetry_telemetry.t) =
  `List
    (List.map
       (fun ({ name; transport; kind; meaning; attributes } :
              Tables.Sdk_telemetry_telemetry.span) ->
         `Assoc
           [
             ("name", string name);
             ("transport", string transport);
             ("kind", string kind);
             ("meaning", string meaning);
             ( "attributes",
               `List
                 (List.map
                    (fun ({ key; only; values } :
                           Tables.Sdk_telemetry_telemetry.attribute) ->
                      `Assoc
                        ([ ("key", string key) ]
                        @ optional "only" string only
                        @ optional "values" strings values))
                    attributes) );
           ])
       t.spans)

let telemetry_metrics (t : Tables.Sdk_telemetry_telemetry.t) =
  `List
    (List.map
       (fun ({ name; transport; instrument; meaning; attributes } :
              Tables.Sdk_telemetry_telemetry.metric) ->
         `Assoc
           [
             ("name", string name);
             ("transport", string transport);
             ("instrument", string instrument);
             ("meaning", string meaning);
             ( "attributes",
               `List
                 (List.map
                    (fun ({ key; only } :
                           Tables.Sdk_telemetry_telemetry.metric_attribute) ->
                      `Assoc
                        ([ ("key", string key) ] @ optional "only" string only))
                    attributes) );
           ])
       t.metrics)

let oauth_clients (t : Tables.Session_oauth.t) =
  `List
    (List.map
       (fun ({ name; id; docs } : Tables.Session_oauth.client) ->
         `Assoc
           [ ("name", string name); ("id", string id); ("docs", string docs) ])
       t.clients)

let sign_in_scope (t : Tables.Session_oauth.t) =
  let ({ value; docs } : Tables.Session_oauth.scope) = t.scope in
  `Assoc [ ("value", string value); ("docs", string docs) ]

let directory_mode (t : Tables.Sign_in_store_owner_only.t) =
  let ({ value; docs } : Tables.Sign_in_store_owner_only.directory_mode) =
    t.directory_mode
  in
  `Assoc [ ("value", string value); ("docs", string docs) ]

let file_mode (t : Tables.Sign_in_store_owner_only.t) =
  let ({ value; docs } : Tables.Sign_in_store_owner_only.file_mode) =
    t.file_mode
  in
  `Assoc [ ("value", string value); ("docs", string docs) ]

let media_types (t : Tables.Media_types_registry.t) =
  `List
    (List.map
       (fun ({
               media_type;
               extension;
               label;
               render;
               anchoring;
               text_source;
               authorable;
               uploadable;
               generatable;
             } :
              Tables.Media_types_registry.media_type) ->
         `Assoc
           [
             ("mediaType", string media_type);
             ("extension", string extension);
             ("label", string label);
             ("render", string render);
             ("anchoring", string anchoring);
             ("textSource", string text_source);
             ("authorable", `Bool authorable);
             ("uploadable", `Bool uploadable);
             ("generatable", `Bool generatable);
           ])
       t.media_types)

let encodings (t : Tables.Text_encoding_cases.t) =
  `List
    (List.map
       (fun ({ encoding; labels; kind } : Tables.Text_encoding_cases.case) ->
         `Assoc
           ([ ("encoding", string encoding); ("labels", strings labels) ]
           @
           match kind with
           | Decoded { bytes; text } ->
               [ ("bytes", string bytes); ("text", string text) ]
           | Single_byte { every_byte } -> [ ("everyByte", string every_byte) ]
           | Refused -> [ ("refused", `Bool true) ]))
       t.cases)

let cache_queries (t : Tables.Client_refresh.t) =
  `List
    (List.map
       (fun ({ name; per; source; persisted; value; docs } :
              Tables.Client_refresh.query) ->
         `Assoc
           ([ ("name", string name) ]
           @ optional "per"
               (function
                 | Tables.Client_refresh.Resource -> string "resource"
                 | Annotation -> string "annotation"
                 | Filters -> string "filters")
               per
           @ (match source with
             | Asks operation -> [ ("asks", string operation) ]
             | Reads get -> [ ("reads", string get) ])
           @ (if persisted then [ ("persisted", `Bool true) ] else [])
           @ [
               ("value", `Assoc [ ("$ref", string value.target) ]);
               ("docs", string docs);
             ]))
       t.queries)

let credential_names (t : Tables.Bus_log_cases.t) = strings t.names

(* Each value: its file, its member there, and its name in the SDK. *)
let all (tables : Spec.tables) =
  [
    ( "sdk-telemetry/telemetry.json",
      "spans",
      "telemetrySpans",
      telemetry_spans tables.sdk_telemetry_telemetry );
    ( "sdk-telemetry/telemetry.json",
      "metrics",
      "telemetryMetrics",
      telemetry_metrics tables.sdk_telemetry_telemetry );
    ( "session/oauth.json",
      "clients",
      "oauthClients",
      oauth_clients tables.session_oauth );
    ( "session/oauth.json",
      "scope",
      "signInScope",
      sign_in_scope tables.session_oauth );
    ( "sign-in-store/owner-only.json",
      "directoryMode",
      "ownerOnlyDirectory",
      directory_mode tables.sign_in_store_owner_only );
    ( "sign-in-store/owner-only.json",
      "fileMode",
      "ownerOnlyFile",
      file_mode tables.sign_in_store_owner_only );
    ( "media-types/registry.json",
      "mediaTypes",
      "mediaTypes",
      media_types tables.media_types_registry );
    ( "text/encoding-cases.json",
      "cases",
      "encodings",
      encodings tables.text_encoding_cases );
    ( "client/refresh.json",
      "queries",
      "cacheQueries",
      cache_queries tables.client_refresh );
    ( "bus/log-cases.json",
      "names",
      "credentialNames",
      credential_names tables.bus_log_cases );
  ]
