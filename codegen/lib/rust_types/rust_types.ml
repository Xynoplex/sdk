(* The Rust SDK's protocol types (rust/sdk/src/types.rs): the body of every
   request and response the gateway declares but the ones a service only
   passes through, every channel's payload, the schemas the SDK holds beside
   them, every kind of id, and the records Protocol states in its tables
   ([Table_records]), with every schema they reach; and an entry of
   the store [xynolog login] keeps (rust/sdk/src/sign_in_store.rs). *)

module Generate = Generate

(* What the SDK holds beside the bodies and the payloads: the job a client
   watches and what generating one takes, an event as the store keeps it
   and as a reader is given it, the level and format the public crate's
   logging takes, the document a launcher publishes of the knowledge bases
   it manages, a PDF's anchored text, which an annotation of a span of one
   is built over, and a knowledge base as a client names it: where to
   connect, what registering one takes, and what a registered one holds. *)
let beside =
  [
    "AnchoredText";
    "Job";
    "GenerationJobParams";
    "StoredEventResponse";
    "EnrichedResourceEvent";
    "LogLevel";
    "LogFormat";
    "DiscoveryDocument";
    "KbTarget";
    "KnowledgeBase";
    "NewKnowledgeBase";
  ]

(* The client types (protocol/specs/src/client/types) the SDK generates. The
   rest wait on Protocol: an object among them states no additionalProperties,
   which the types read as open, and AnchorMethod is held with
   ReconciledSpan's shape. *)
let client_types = [ "FrameRefusalReason"; "MatchQuality" ]

(* A body that is not JSON: an upload is a multipart form, whose fields
   [xynolog::transport::PutBinaryRequest] carries. *)
let passed_through = [ "ResourceUpload" ]

(* The mark unit holds the motivation a job's parameters state. *)
let accessors = [ "MarkJobParams" ]
let sign_in_file = "sign-in-store/SignIn.json"
let regenerate from_ = Banner.lines ~from_ __FILE__

let payloads (spec : Spec.t) =
  List.filter_map
    (fun (c : Tables.Bus_registry.channel) ->
      match c.payload with
      | Schema { schema; _ } | Envelope { schema } -> Some schema
      | Stored_event { payload; _ } -> Some payload
      | Void | Empty -> None)
    spec.tables.bus_registry.channels

let types (spec : Spec.t) =
  let bundle = Definitions.bundle spec in
  let identifiers =
    List.map
      (fun (k : Tables.Identifiers_kinds.kind) -> k.schema)
      spec.tables.identifiers_kinds.kinds
  in
  let roots =
    List.sort_uniq String.compare
      (payloads spec
      @ List.filter (fun b -> not (List.mem b passed_through)) bundle.bodies
      @ beside @ identifiers @ client_types
      @ List.map (fun (_, name, _) -> name) (Definitions.records spec))
  in
  {
    Output.path = "rust/sdk/src/generated/types.rs";
    text =
      Rust_syntax.text
        ~header:(regenerate "the component schemas in protocol/specs/src")
        (Generate.items bundle.definitions { roots; identifiers; accessors });
  }

let sign_in (spec : Spec.t) =
  let schema =
    match List.assoc_opt sign_in_file spec.schemas with
    | Some s -> s
    | None -> Definitions.refuse "Protocol has no %s" sign_in_file
  in
  {
    Output.path = "rust/sdk/src/generated/sign_in.rs";
    text =
      Rust_syntax.text
        ~header:(regenerate ("protocol/specs/src/" ^ sign_in_file))
        (Generate.items
           (Definitions.alone ~name:"SignIn" schema)
           { roots = [ "SignIn" ]; identifiers = []; accessors = [] });
  }

(* Why a client that read a launcher's discovery document found no launcher
   (rust/sdk/src/discovery.rs): an enumeration of the reasons. *)
let discovery_absent (spec : Spec.t) =
  let reasons =
    List.map
      (fun (r : Tables.Client_discovery_absent.reason) ->
        Schema.String_literal r.reason)
      spec.tables.client_discovery_absent.reasons
  in
  {
    Output.path = "rust/sdk/src/generated/discovery_absent.rs";
    text =
      Rust_syntax.text
        ~header:(regenerate "protocol/specs/src/client/discovery-absent.json")
        (Generate.enumeration "DiscoveryAbsentReason"
           {
             (Definitions.node [ "type"; "enum" ]) with
             type_ = Some (One String);
             enum = Some reasons;
           }
           [ "Why no launcher was found." ]);
  }

let files ~root:_ (spec : Spec.t) =
  match [ types spec; sign_in spec; discovery_absent spec ] with
  | files -> Ok files
  | exception Definitions.Refused message ->
      Error [ { Decode.file = "openapi.json"; pointer = ""; message } ]
