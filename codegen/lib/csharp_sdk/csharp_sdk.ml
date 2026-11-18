(* The C# SDK's group: its models (Models), each schema they are made from as
   the SDK validates a value against it (WireSchemas.g.cs), the code each of
   the wire's own failure codes becomes (FailureCodes.g.cs), and the tables
   the SDK reads as Protocol writes them, with what the sign-in store's
   contract states (ProtocolTables.g.cs). What is read as Protocol writes it
   is read from the pinned checkout, byte for byte. *)

module C = Csharp_syntax
module Models = Models

let generated = "csharp/sdk/src/Xynolog/Generated/"
let types = generated ^ "Types"
let specs = "protocol/specs/src/"
let ( let* ) = Result.bind

let file ~from_ ?(nullable = false) ~namespace path decls =
  {
    Output.path;
    text =
      C.text
        {
          header = Banner.lines ~from_ __FILE__;
          nullable;
          usings = [];
          namespace;
          decls;
        };
  }

let static_class ?(modifiers = [ C.Internal; Static ]) name members =
  C.Type
    {
      attributes = [];
      modifiers;
      kind = Class;
      name;
      params = None;
      base = None;
      body = Some (Packed, members);
    }

let constant type_ name value =
  C.Field
    {
      modifiers = [ Internal; Const ];
      type_ = T type_;
      name;
      value = Some value;
    }

let json ~root path =
  Result.map_error (fun e -> [ e ]) (Decode.parse_file ~root (specs ^ path))

let member key path = function
  | `Assoc members when List.mem_assoc key members ->
      Ok (List.assoc key members)
  | _ ->
      Error [ { Decode.file = path; pointer = ""; message = "has no " ^ key } ]

let schema_of (spec : Spec.t) path =
  match List.assoc_opt path spec.schemas with
  | Some schema -> Ok schema
  | None ->
      Error
        [
          {
            Decode.file = path;
            pointer = "";
            message = "is not among the spec's schemas";
          };
        ]

(* The schemas the models are made from: every component schema, the
   sign-in store's entry, the discovery document and what it names, a
   stored session and why a session ends; each with the file it is read
   from. *)
let roots ~root (spec : Spec.t) =
  let read name path schema json =
    ((name, path, { Models.schema; json }) : _)
  in
  let whole name path =
    let* schema = schema_of spec path in
    let* json = json ~root path in
    Ok (read name path schema json)
  in
  let within name path key schema =
    let* table = json ~root path in
    let* json = member key path table in
    Ok (read name path schema json)
  in
  let components =
    List.filter_map
      (fun (path, _) ->
        if String.starts_with ~prefix:"components/schemas/" path then
          Some (whole (Filename.remove_extension (Filename.basename path)) path)
        else None)
      spec.schemas
  in
  Spec.all
    (components
    @ [
        whole "SignIn" Sign_in.schema_file;
        whole "DiscoveryDocument" "discovery/DiscoveryDocument.json";
        whole "DiscoveredKB" "discovery/DiscoveredKB.json";
        within "StoredSession" "session/stored.json" "storedSession"
          spec.tables.session_stored.stored_session;
        within "SessionEndReason" "session/cases.json" "told"
          spec.tables.session_cases.told;
      ])

let refused message =
  [ { Decode.file = "components/schemas"; pointer = ""; message } ]

let model_file (name, _, decls) =
  file ~nullable:true ~namespace:"Xynolog.Types"
    ~from_:"the schemas of protocol/specs/src the C# SDK models"
    (types ^ "/" ^ name ^ ".g.cs")
    decls

let wire_schemas (models : Models.t) =
  file ~namespace:"Xynolog.Serialization"
    ~from_:"the schemas of protocol/specs/src the C# SDK models"
    (generated ^ "WireSchemas.g.cs")
    [
      static_class
        ~modifiers:[ Internal; Static; Partial ]
        "WireJson"
        [
          C.Field
            {
              modifiers = [ Private; Const ];
              type_ = T "string";
              name = "SchemaSource";
              value = Some (Str (Yojson.Safe.to_string (`Assoc models.schemas)));
            };
        ];
    ]

(* The tables the SDK reads, by the constant it reads each as. *)
let tables =
  [
    ("Registry", "bus/registry.json");
    ("Timing", "client/timing.json");
    ("Errors", Error_codes.Table.file);
    ("Retry", "retry/cases.json");
    ("Telemetry", "sdk-telemetry/telemetry.json");
    ("Log", "bus/log-cases.json");
    ("OwnerOnly", "sign-in-store/owner-only.json");
    ("OAuth", "session/oauth.json");
    ("ClientAssertion", "session/client-assertion-cases.json");
    ("Principals", "principals/cases.json");
    ("MediaTypes", "media-types/registry.json");
    ("Encodings", "text/encoding-cases.json");
    ("CacheRefresh", "client/refresh.json");
    ("Stored", "session/stored.json");
    ("Discovery", "discovery/DiscoveryDocument.json");
  ]

let protocol_tables ~root =
  let* contract = Sign_in.Contract.read ~root in
  let text path =
    In_channel.with_open_bin
      (Filename.concat root (specs ^ path))
      In_channel.input_all
  in
  Ok
    (file ~namespace:"Xynolog.Protocol"
       ~from_:
         ("protocol/specs/src: "
         ^ String.concat ", " (List.map snd tables)
         ^ " and " ^ Sign_in.Contract.file)
       (generated ^ "ProtocolTables.g.cs")
       [
         static_class "ProtocolTables"
           (List.map
              (fun (name, path) -> constant "string" name (Str (text path)))
              tables
           @ [
               constant "uint" "WindowsOffsetHigh"
                 (Uint_hex contract.offset_high);
               constant "string" "StoreFileName" (Str contract.document);
               constant "string" "StoreLockName" (Str contract.lock);
             ]);
       ])

(* The code a bus request fails under, by the code its failure states, in
   the order CommandError names them; one that states none is the
   unrecognized failure. *)
let failure_codes (spec : Spec.t) (models : Models.t) =
  let* wire_codes = Error_codes.Table.wire_codes spec in
  let* t = Error_codes.Table.derive ~wire_codes spec.tables.errors_codes in
  let* code_type =
    match models.member_type "CommandError" "code" with
    | Some name -> Ok ("global::Xynolog.Types." ^ name)
    | None -> Error (refused "CommandError.code is made as no type of its own.")
  in
  (* Derive holds every code CommandError names to the one it becomes. *)
  let arms =
    List.map
      (fun code ->
        let failure : Error_codes.Table.code = List.assoc code t.wire in
        ( C.Value (Name (code_type ^ "." ^ Models.pascal code)),
          C.Str failure.code ))
      wire_codes
  in
  Ok
    (file ~namespace:"Xynolog.Protocol"
       ~from_:("protocol/specs/src/" ^ Error_codes.Table.file)
       (generated ^ "FailureCodes.g.cs")
       [
         static_class "FailureCodes"
           [
             C.Method
               {
                 modifiers = [ Internal; Static ];
                 returns = T "string";
                 name = "Of";
                 params =
                   [
                     {
                       by = `Value;
                       type_ = Nullable (T code_type);
                       name = "code";
                     };
                   ];
                 body =
                   Arrow
                     (Switch
                        ( Name "code",
                          arms
                          @ [
                              (Value Null, Str t.unrecognized.code);
                              ( Discard,
                                Throw
                                  (New
                                     {
                                       type_ =
                                         Some
                                           (T
                                              "global::System.ArgumentOutOfRangeException");
                                       args =
                                         Some
                                           [
                                             Arg (Nameof "code");
                                             Arg (Name "code");
                                             Arg
                                               (Str "No code of CommandError.");
                                           ];
                                       init = None;
                                     }) );
                            ] ));
               };
           ];
       ])

let files ~root (spec : Spec.t) =
  let* kinds = Identifiers.Table.derive spec in
  let* roots = roots ~root spec in
  let* made =
    Spec.all
      (Bus.Csharp.payloads spec.tables.bus_registry
      |> List.map (Result.map_error (fun e -> [ e ])))
  in
  let* models =
    Result.map_error refused
      (Models.make
         ~identifiers:
           (List.map (fun (k : Identifiers.Table.kind) -> k.name) kinds)
         ~roots
         ~made:
           (List.map
              (fun (name, json, schema) -> (name, { Models.schema; json }))
              made))
  in
  let* failures = failure_codes spec models in
  let* tables = protocol_tables ~root in
  let written = List.map model_file models.models in
  match Output.stale ~root ~directory:types written with
  | [] -> Ok (written @ [ wire_schemas models; failures; tables ])
  | stale -> Error stale
