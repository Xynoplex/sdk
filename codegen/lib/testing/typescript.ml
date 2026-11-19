(* The testing kit's facts as the TypeScript SDK reads them
   (typescript/core/src/testing-kit.ts): the faults, a case each, told apart
   by `kind`; the delay and schedule bounds; the slack; the delivery steps;
   and the kit's records, each member of TypeScript's type for it. A liveness
   scenario holds its own teardown besides, which the harness runs once a
   case is judged. Drawing a schedule is the SDK's own (liveness-axioms.ts). *)

module S = Typescript_syntax
module T = Tables.Client_testing

let path = "typescript/core/src/testing-kit.ts"
let payload = S.T_generic ("Record", [ T_name "string"; T_name "unknown" ])

let scenario =
  S.T_union
    [
      T_name "LivenessScenario";
      T_generic ("Promise", [ T_name "LivenessScenario" ]);
    ]

(* Each record member's type, and whether a caller may leave it out. *)
let member_types =
  [
    ( "RequestLogEntry",
      [
        ("channel", (S.T_name "BusOperationKey", false));
        ("action", (T_name "FaultAction", false));
        ( "correlationId",
          (T_union [ T_name "string"; T_name "undefined" ], false) );
        ("retryKey", (T_name "string", false));
        ("payload", (payload, false));
      ] );
    ( "LivenessScenario",
      [
        ( "outputs",
          ( S.T_readonly
              (T_array (T_generic ("Observable", [ T_name "unknown" ]))),
            false ) );
        ( "settlements",
          ( T_readonly (T_array (T_generic ("Promise", [ T_name "unknown" ]))),
            true ) );
      ] );
    ( "LivenessSpec",
      [
        ( "setup",
          ( S.T_function ([ ("transport", T_name "FaultyTransport") ], scenario),
            false ) );
        ("timeoutMs", (T_name "number", false));
        ("retryBudget", (T_name "number", true));
        ("cases", (T_name "number", true));
        ( "schedules",
          ( T_generic
              ("Arbitrary", [ T_readonly (T_array (T_name "FaultAction")) ]),
            true ) );
        ( "makeResponse",
          ( T_function
              ( [ ("operation", T_name "string"); ("payload", payload) ],
                T_name "unknown" ),
            true ) );
      ] );
  ]

let extras =
  [
    ( "LivenessScenario",
      [
        S.member (Ident "teardown") ~optional:true
          (T_function ([], T_name "void"));
      ] );
  ]

let interface records name =
  let (r : T.records_item), typed = Table.record name records in
  S.Interface
    {
      about = [ Doc r.docs ];
      export = true;
      name = r.name;
      members =
        List.map
          (fun (member, (type_, optional)) ->
            S.member (Ident member) ~optional type_)
          typed
        @ Option.value ~default:[] (List.assoc_opt name extras);
    }

let range name ~docs ~minimum ~maximum =
  S.const ~about:[ Doc docs ] ~as_const:true name
    (Object
       {
         layout = Inline;
         entries =
           [
             S.entry (Ident "minimum") (Int minimum);
             S.entry (Ident "maximum") (Int maximum);
           ];
       })

let text (s : T.t) records =
  let fault (f : T.fault_actions_item) =
    S.case ~about:[ Doc f.docs ]
      (T_object
         ( Inline,
           S.member (Ident "kind") (T_str f.kind)
           :: List.map
                (fun held -> S.member (Ident held) (T_name "number"))
                f.holds ))
  in
  S.text
    {
      banner = Banner.typescript_lines ~authority:[ Table.from_ ] __FILE__;
      body =
        [
          S.Adjacent
            [
              S.import ~type_only:true [ "Arbitrary" ] "fast-check";
              S.import ~type_only:true [ "Observable" ] "rxjs";
              S.import ~type_only:true [ "BusOperationKey" ] "./bus-operations";
              S.import ~type_only:true [ "FaultyTransport" ]
                "./faulty-transport";
            ];
          S.type_alias "FaultAction" (T_cases (List.map fault s.fault_actions));
          range "DELAY_MS" ~docs:s.delay_ms.docs ~minimum:s.delay_ms.minimum
            ~maximum:s.delay_ms.maximum;
          range "SCHEDULE_LENGTH" ~docs:s.schedule_length.docs
            ~minimum:s.schedule_length.minimum
            ~maximum:s.schedule_length.maximum;
          S.const ~about:[ Doc s.slack.docs ] "SLACK" (Int s.slack.times);
          S.const
            ~about:[ Doc s.delivery_ops.docs ]
            ~as_const:true "DELIVERY_OPS"
            (S.strings s.delivery_ops.ops);
          S.type_alias "DeliveryOp"
            (T_index (T_paren (T_typeof "DELIVERY_OPS"), T_name "number"));
          interface records "RequestLogEntry";
          interface records "LivenessScenario";
          interface records "LivenessSpec";
        ];
    }

let file table =
  Result.map
    (fun records -> { Output.path; text = text table records })
    (Table.typed ~language:"TypeScript" member_types table)
