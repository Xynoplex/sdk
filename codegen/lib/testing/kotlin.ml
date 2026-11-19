(* The testing kit's facts as the Kotlin SDK reads them
   (kotlin/sdk/src/generated/kotlin/xynolog/testing/Kit.kt): the faults, a
   sealed interface and an object or a data class each, told by the word a
   request log names it by; every fault, to draw from; the delay and
   schedule bounds, each a range; the slack; the delivery steps; and the
   kit's records, each member of Kotlin's type for it, and each marked
   generated, which the ABI dump leaves out. A liveness scenario
   is closed besides, and a liveness spec keeps the context its cases run
   on. Drawing a schedule is the SDK's own (Liveness.kt). *)

module K = Kotlin_syntax
module T = Tables.Client_testing

let package = "xynolog.testing"
let t name = K.Type name
let list_of item = K.Generic ("List", [ item ])
let futures = list_of (K.Generic ("CompletableFuture", [ K.Star ]))
let public_val = K.Bound { visibility = K.Public; mutable_ = false }

(* What the ABI dump leaves out: the spec fixes it. *)
let generated = K.annotation "Generated"

(* Each record member's parameter: its name, its type, its default if it has
   one, and its doc. *)
let member ?default name type_ doc = (name, type_, default, doc)

let member_types =
  [
    ( "RequestLogEntry",
      [
        ("channel", member "channel" (t "String") "The channel it was sent on.");
        ( "action",
          member "action" (t "FaultAction") "What the schedule did to it." );
        ( "correlationId",
          member "correlationId"
            (K.Nullable (t "String"))
            "What pairs it with its reply; null for a request that awaits none."
        );
        ( "retryKey",
          member "retryKey" (t "String")
            "The request's identity across retries: two entries with the same \
             key are one logical request, sent again (`retryKeyOf`)." );
        ( "payload",
          member "payload" (t "JsonObject") "The payload as it was sent." );
      ] );
    ( "LivenessScenario",
      [
        ( "outputs",
          member "outputs" futures
            "One per output: each completes when the output has said \
             something, a value or a failure (L1). A live query's first state, \
             pending, is nothing said." );
        ( "settlements",
          member "settlements" futures
            "One per awaited path: each completes when the path has settled, \
             by returning or by failing (L2)." );
      ] );
    ( "LivenessSpec",
      [
        ( "setup",
          member "setup"
            (K.Function_type ([ t "FaultyTransport" ], t "LivenessScenario"))
            "Builds a fresh composition over the transport it is given, whose \
             stream names a full client's channels (`BRIDGED_CHANNELS`). The \
             scenario it gives is closed when the case is over, and the \
             transport after it." );
        ( "timeoutMs",
          member "timeoutMs" (t "Long")
            "The time the composition gives a bus request. A case's bound is \
             derived from it: the timeout times one more than `retryBudget`, \
             and the schedule's delays, all of it `SLACK` times over." );
        ( "retryBudget",
          member "retryBudget" (t "Int")
            "How often the composition may send a logical request again." );
        ( "cases",
          member "cases" (t "Int")
            "How many schedules are drawn (`faultSchedules`) when `schedules` \
             states none." );
        ( "schedules",
          member "schedules"
            ~default:(K.call (K.Name "emptyList") [])
            (list_of (list_of (t "FaultAction")))
            "The fault schedules to run, one case each, in place of drawn ones."
        );
        ( "makeResponse",
          member "makeResponse" ~default:(K.Name "REFUSE_UNSCRIPTED")
            (t "Respond")
            "What the gateway answers a request nothing queued an answer for, \
             as `FaultyTransport`'s `respond` does." );
      ] );
  ]

(* A member Kotlin's records hold that the table's do not, and whether it is
   the record's own. *)
let extras =
  [
    ( "LivenessScenario",
      [
        ( K.Bound { visibility = K.Private; mutable_ = false },
          member "end" (t "AutoCloseable")
            ~default:
              (K.call
                 ~lambda:(K.Lambda ([], K.Name "Unit"))
                 (K.Name "AutoCloseable") [])
            "What closing it ends: the composition." );
      ] );
    ( "LivenessSpec",
      [
        ( public_val,
          member "context" (t "CoroutineContext")
            ~default:(K.Name "Dispatchers.Default")
            "What the transport is made on. Each case blocks its caller's \
             thread while it waits out its bound there, and a wait on a clock \
             the caller controls ends only when the caller moves it, so on a \
             test dispatcher, whose time moves only when its test advances it, \
             a case never ends: give it a dispatcher that keeps the system's \
             time." );
      ] );
  ]

let param binding (name, type_, default, doc) =
  K.param ~about:(K.Doc doc) ~binding ?default name type_

let record records name =
  let (r : T.records_item), typed = Table.record name records in
  let params =
    List.map (fun (_, m) -> param public_val m) typed
    @ List.map
        (fun (binding, m) -> param binding m)
        (Option.value ~default:[] (List.assoc_opt name extras))
  in
  match name with
  | "RequestLogEntry" ->
      K.class_ ~annotations:[ generated ] ~about:(K.Doc r.docs)
        ~visibility:K.Public ~constructor:(K.constructor params) K.Data_class
        r.name
  | "LivenessScenario" ->
      K.class_ ~annotations:[ generated ] ~about:(K.Doc r.docs)
        ~visibility:K.Public
        ~constructor:
          (K.constructor ~annotations:[ K.annotation "JvmOverloads" ] params)
        ~supers:[ K.super (t "AutoCloseable") ]
        ~members:
          [
            K.function_ ~override:true ~returns:(t "Unit") "close"
              (K.Same_line (K.call (K.Member (K.Name "end", "close")) []));
          ]
        K.Class r.name
  | _ ->
      K.class_ ~annotations:[ generated ] ~about:(K.Doc r.docs)
        ~visibility:K.Public
        ~constructor:
          (K.constructor ~annotations:[ K.annotation "JvmOverloads" ] params)
        K.Class r.name

let kind_of (f : T.fault_actions_item) =
  K.property ~override:true ~type_:(t "String")
    ~value:(K.Same_line (K.Str f.kind)) "kind"

let fault (f : T.fault_actions_item) =
  match f.holds with
  | [] ->
      K.class_ ~annotations:[ generated ] ~about:(K.Doc f.docs)
        ~visibility:K.Public
        ~supers:[ K.super (t "FaultAction") ]
        ~members:[ kind_of f ]
        K.Data_object f.name
  | holds ->
      K.class_ ~annotations:[ generated ] ~about:(K.Doc f.docs)
        ~visibility:K.Public
        ~constructor:
          (K.constructor ~layout:K.Inline
             (List.map
                (fun held -> K.param ~binding:public_val held (t "Long"))
                holds))
        ~supers:[ K.super (t "FaultAction") ]
        ~members:[ kind_of f ]
        K.Data_class f.name

let constant ?type_ ?(const = false) ~doc name value =
  K.property ~about:(K.Doc doc) ~visibility:K.Internal ~const ?type_
    ~value:(K.Same_line value) name

let range ~doc name minimum maximum =
  constant ~doc ~type_:(t "IntRange") name
    (K.Binary (K.Int minimum, K.Range, K.Int maximum))

let decls (s : T.t) records =
  [
    K.class_ ~annotations:[ generated ]
      ~about:(K.Doc "What the wire does to one request.") ~visibility:K.Public
      ~members:
        [
          K.property ~about:(K.Doc "The word a request log names it by.")
            ~visibility:K.Public ~type_:(t "String") "kind";
        ]
      K.Sealed_interface "FaultAction";
  ]
  @ List.map fault s.fault_actions
  @ [
      constant
        ~doc:
          "Every fault: what a schedule is drawn from, a delay's own \
           milliseconds drawn apart."
        ~type_:(list_of (t "FaultAction"))
        "FAULTS"
        (K.call (K.Name "listOf")
           (List.map
              (fun (f : T.fault_actions_item) ->
                match f.holds with
                | [] -> K.Name f.name
                | holds ->
                    K.call (K.Name f.name) (List.map (fun _ -> K.Int 0) holds))
              s.fault_actions));
      range ~doc:s.delay_ms.docs "DELAY_MS" s.delay_ms.minimum
        s.delay_ms.maximum;
      range ~doc:s.schedule_length.docs "SCHEDULE_LENGTH"
        s.schedule_length.minimum s.schedule_length.maximum;
      constant ~const:true ~type_:(t "Int") ~doc:s.slack.docs "SLACK"
        (K.Int s.slack.times);
      K.class_ ~annotations:[ generated ] ~about:(K.Doc s.delivery_ops.docs)
        ~visibility:K.Public
        ~constructor:
          (K.constructor
             [
               K.param ~about:(K.Doc "The step, as every SDK spells it.")
                 ~binding:public_val "value" (t "String");
             ])
        ~entries:
          (List.map
             (fun op ->
               K.entry ~args:[ K.Str op ] (Kotlin_sdk.Names.variant_of op))
             s.delivery_ops.ops)
        K.Enum_class "DeliveryOp";
      record records "RequestLogEntry";
      record records "LivenessScenario";
      record records "LivenessSpec";
    ]

let file table =
  Result.map
    (fun records ->
      Kotlin_sdk.data_file
        ~banner:(Banner.lines ~from_:Table.from_ __FILE__)
        ~package ~name:"Kit"
        ~imports:
          [
            "java.util.concurrent.CompletableFuture";
            "kotlin.coroutines.CoroutineContext";
            "kotlinx.coroutines.Dispatchers";
            "kotlinx.serialization.json.JsonObject";
            "xynolog.Generated";
          ]
        (decls table records))
    (Table.typed ~language:"Kotlin" member_types table)
