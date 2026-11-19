(* The testing kit's facts as the Swift SDK reads them
   (swift/sdk/Sources/XynologTesting/Generated/Kit.swift): the faults, an
   enumeration's cases each told by the word a request log names it by, a
   delay held as a Duration; every fault, to draw from; the delay and
   schedule bounds, each a closed range; the slack; the delivery steps; and
   the kit's records, each member of Swift's type for it, a duration named
   without its unit as the timing is. A liveness scenario is disposed of
   besides, and a liveness spec keeps the clock its cases are timed by.
   Drawing a schedule is the SDK's own (Liveness.swift). *)

module S = Swift_syntax
module T = Tables.Client_testing

let path = "swift/sdk/Sources/XynologTesting/Generated/Kit.swift"

type member = {
  field : string;
  type_ : S.type_;
  escaping : bool;  (** A closure its initializer keeps. *)
  default : S.expr option;
  public_ : bool;
  doc : string;
}

let member ?(escaping = false) ?default ?(public_ = true) field type_ doc =
  { field; type_; escaping; default; public_; doc }

let closure ?(async_ = true) ?(throws = false) params result =
  S.Function { sendable = true; params; async_; throws; result }

let waits = S.Array_of (closure [] (S.Named "Void"))
let docs ~indent text = Text.wrapped ~lead:(indent ^ "/// ") ~width:100 text
let decl ?(doc = []) modifiers body = { S.doc; modifiers; body }

(* Each record member's field, its type and its doc. *)
let member_types =
  [
    ( "RequestLogEntry",
      [
        ( "channel",
          member "channel" (S.Named "String") "The channel it was sent on." );
        ( "action",
          member "action" (S.Named "FaultAction") "What the schedule did to it."
        );
        ( "correlationId",
          member "correlationId" (S.Optional (S.Named "String"))
            "What pairs it with its reply; nil for a request that awaits none."
        );
        ( "retryKey",
          member "retryKey" (S.Named "String")
            "Its identity across retries: two entries with the same key are \
             one logical request, sent again." );
        ( "payload",
          member "payload"
            (S.Dictionary_of (S.Named "String", S.Named "JSONValue"))
            "Its payload, as it was sent." );
      ] );
    ( "LivenessScenario",
      [
        ( "outputs",
          member "outputs" waits
            "One per output: each returns when the output has said something, \
             a value or a failure (L1)." );
        ( "settlements",
          member "settlements" waits
            "One per awaited path: each returns when the path has settled, by \
             returning or by throwing (L2)." );
      ] );
    ( "LivenessSpec",
      [
        ( "setup",
          member ~escaping:true "setup"
            (closure ~throws:true
               [ S.Named "ScriptedTransport" ]
               (S.Named "LivenessScenario"))
            "Builds a fresh composition over the transport it is given, which \
             keeps no deadline, and gives what it exposes. Called once per \
             case." );
        ( "timeoutMs",
          member "timeout" (S.Named "Duration")
            "The time the composition gives a bus request, its client's \
             `busRequestTimeoutMs`. A case's bound is derived from it: the \
             timeout times one more than `retryBudget`, and the schedule's \
             delays, all of it `slack` times over." );
        ( "retryBudget",
          member "retryBudget" (S.Named "Int")
            "How often the composition may send a logical request again." );
        ( "cases",
          member "cases" (S.Named "Int")
            "How many schedules are drawn (`faultSchedules`) when `schedules` \
             states none." );
        ( "schedules",
          member "schedules" (S.Array_of (S.Array_of (S.Named "FaultAction")))
            ~default:(S.Array (S.Inline, []))
            "The fault schedules to run, one case each, in place of drawn ones."
        );
        ( "makeResponse",
          member ~escaping:true "makeResponse" (S.Named "Respond")
            "What the gateway answers a request no queued reply answers, as \
             `ScriptedTransport`'s `respond` does." );
      ] );
  ]

(* A member Swift's records hold that the table's do not. *)
let extras =
  [
    ( "LivenessScenario",
      [
        member ~escaping:true "dispose"
          (closure ~async_:false [] (S.Named "Void"))
          "Ends what the run opened; called once its case is checked.";
      ] );
    ( "LivenessSpec",
      [
        member ~public_:false "clock"
          (S.Any (S.Generic ("Clock", [ S.Named "Duration" ])))
          ~default:(S.Call (S.Name "ContinuousClock", []))
          "The clock a case's bound and the schedule's delays are timed by.";
      ] );
  ]

let property m =
  decl ~doc:(docs ~indent:"  " m.doc)
    (if m.public_ then [ "public" ] else [])
    (S.Property
       { var = false; name = m.field; type_ = Some m.type_; value = None })

let init members =
  decl [ "public" ]
    (S.Init
       {
         params =
           List.map
             (fun m ->
               {
                 S.label = None;
                 name = m.field;
                 type_ = (if m.escaping then S.Escaping m.type_ else m.type_);
                 default = m.default;
               })
             members;
         throws = false;
         body =
           {
             layout = S.Lines;
             stmts =
               List.map
                 (fun m ->
                   S.Expr
                     (S.Binary
                        (S.Member (S.Name "self", m.field), "=", S.Name m.field)))
                 members;
           };
       })

(* A record; one a caller builds is given a public initializer, and the
   request log's entry, which only the transport builds, Swift's own. *)
let record records name =
  let (r : T.records_item), typed = Table.record name records in
  let members =
    List.map snd typed @ Option.value ~default:[] (List.assoc_opt name extras)
  in
  decl ~doc:(docs ~indent:"" r.docs) [ "public" ]
    (S.Struct
       {
         name = r.name;
         generics = [];
         inherits = [ S.Named "Sendable" ];
         layout = S.Lines;
         members =
           (List.map property members
           @ if name = "RequestLogEntry" then [] else [ init members ]);
       })

let fault_case (f : T.fault_actions_item) = Swift_sdk.Models.enum_case f.kind

let faults (s : T.t) =
  decl
    ~doc:[ "What the wire does to one request." ]
    [ "public" ]
    (S.Enum
       {
         name = "FaultAction";
         inherits = [ S.Named "Sendable"; S.Named "Equatable" ];
         layout = S.Lines;
         members =
           List.map
             (fun (f : T.fault_actions_item) ->
               decl ~doc:(docs ~indent:"  " f.docs) []
                 (S.Case
                    {
                      name = fault_case f;
                      value =
                        (match f.holds with
                        | [] -> S.Bare
                        | _ -> S.Associated [ S.Named "Duration" ]);
                    }))
             s.fault_actions
           @ [
               decl
                 ~doc:[ "The word a request log names it by." ]
                 [ "public" ]
                 (S.Computed
                    {
                      name = "kind";
                      type_ = S.Named "String";
                      body =
                        {
                          layout = S.Lines;
                          stmts =
                            [
                              S.Switch
                                {
                                  subject = S.Name "self";
                                  layout = S.Lines;
                                  cases =
                                    List.map
                                      (fun (f : T.fault_actions_item) ->
                                        {
                                          S.patterns =
                                            [ S.Implicit_member (fault_case f) ];
                                          body = [ S.Expr (S.String f.kind) ];
                                        })
                                      s.fault_actions;
                                };
                            ];
                        };
                    });
             ];
       })

let every_fault (s : T.t) =
  decl
    ~doc:
      [
        "Every fault: what a schedule is drawn from, a delay's own duration \
         drawn apart.";
      ]
    []
    (S.Property
       {
         var = false;
         name = "faults";
         type_ = Some (S.Array_of (S.Named "FaultAction"));
         value =
           Some
             (S.Array
                ( S.Inline,
                  List.map
                    (fun (f : T.fault_actions_item) ->
                      let case = S.Implicit_member (fault_case f) in
                      match f.holds with
                      | [] -> case
                      | _ ->
                          S.Call
                            ( case,
                              [
                                {
                                  S.label = None;
                                  value = S.Implicit_member "zero";
                                };
                              ] ))
                    s.fault_actions ));
       })

let constant ~doc name value =
  decl ~doc:(docs ~indent:"" doc) []
    (S.Property { var = false; name; type_ = None; value = Some value })

let range ~doc name minimum maximum =
  constant ~doc name (S.Binary (S.Int minimum, "...", S.Int maximum))

let delivery_ops (s : T.t) =
  decl
    ~doc:(docs ~indent:"" s.delivery_ops.docs)
    [ "public" ]
    (S.Enum
       {
         name = "DeliveryOp";
         inherits =
           [ S.Named "String"; S.Named "Sendable"; S.Named "CaseIterable" ];
         layout = S.Lines;
         members =
           List.map
             (fun op ->
               decl []
                 (S.Case
                    { name = Swift_sdk.Models.enum_case op; value = S.Bare }))
             s.delivery_ops.ops;
       })

let swift_file (s : T.t) records =
  {
    S.banner = Banner.lines ~from_:Table.from_ __FILE__;
    imports = [ { S.module_ = "Xynolog"; testable = false } ];
    decls =
      List.map
        (fun d -> (S.Blank, d))
        [
          faults s;
          every_fault s;
          range ~doc:s.delay_ms.docs "delayMs" s.delay_ms.minimum
            s.delay_ms.maximum;
          range ~doc:s.schedule_length.docs "scheduleLength"
            s.schedule_length.minimum s.schedule_length.maximum;
          constant ~doc:s.slack.docs "slack" (S.Int s.slack.times);
          delivery_ops s;
          record records "RequestLogEntry";
          record records "LivenessScenario";
          record records "LivenessSpec";
        ];
  }

let file table =
  Result.map
    (fun records -> { Output.path; text = S.print (swift_file table records) })
    (Table.typed ~language:"Swift" member_types table)
