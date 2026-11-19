(* The testing kit's facts as the Rust SDK reads them
   (rust/sdk/src/generated/testing.rs, which rust/sdk/src/testing/kit.rs
   includes): the faults, a variant each, a delay held as a Duration; the
   word each is logged by; the delay and schedule bounds as ranges; the
   slack; the delivery steps; and the kit's records, each member of Rust's
   type for it. A liveness spec is generic over its setup, which the harness
   calls once a run. Drawing a schedule is the SDK's own (liveness.rs). *)

module R = Rust_syntax
module T = Tables.Client_testing

let path = "rust/sdk/src/generated/testing.rs"
let duration = R.named "Duration"
let payload = R.named ~args:[ R.named "String"; R.named "Value" ] "Map"
let future = R.named ~args:[ R.Lifetime "'static"; R.Tuple_of [] ] "BoxFuture"
let faults = R.named ~args:[ R.named "FaultAction" ] "Vec"
let derive names = R.List ([ "derive" ], List.map (fun n -> R.Word [ n ]) names)

(* Each record member's type, by the record. *)
let member_types =
  [
    ( "RequestLogEntry",
      [
        ("channel", R.named "String");
        ("action", R.named "FaultAction");
        ("correlationId", R.named ~args:[ R.named "String" ] "Option");
        ("retryKey", R.named "String");
        ("payload", payload);
      ] );
    ( "LivenessScenario",
      [
        ("outputs", R.named ~args:[ future ] "Vec");
        ("settlements", R.named ~args:[ future ] "Vec");
      ] );
    ( "LivenessSpec",
      [
        ("setup", R.named "Setup");
        ("timeoutMs", duration);
        ("retryBudget", R.named "usize");
        ("cases", R.named "u32");
        ( "schedules",
          R.named ~args:[ R.named ~args:[ faults ] "BoxedStrategy" ] "Option" );
        ( "makeResponse",
          R.named ~args:[ R.named ~args:[ R.named "Respond" ] "Arc" ] "Option"
        );
      ] );
  ]

(* What each record derives, and what it is generic over. *)
let shape = function
  | "RequestLogEntry" -> ([ "Debug"; "Clone"; "PartialEq" ], [])
  | "LivenessScenario" -> ([ "Default" ], [])
  | _ -> ([], [ R.Type_param ("Setup", []) ])

let record records name =
  let (r : T.records_item), typed = Table.record name records in
  let derives, generics = shape name in
  R.Struct_def
    {
      doc = [ r.docs ];
      attrs = (if derives = [] then [] else [ derive derives ]);
      vis = Pub;
      name = r.name;
      generics;
      body =
        Fields
          (List.map (fun (member, ty) -> R.field (Text.snake member) ty) typed);
    }

(* [name]'s [fn word(&self) -> &'static str], a variant's word each. *)
let words ~doc name fn arms =
  R.Impl
    {
      generics = [];
      trait_ = None;
      for_ = R.named name;
      items =
        [
          R.I_fn
            (R.fn_ ~doc:[ doc ] ~vis:Pub ~const:true fn ~params:[ R.Self_ref ]
               ~ret:R.static_str
               [ R.Tail (R.Match (R.p "self", arms)) ]);
        ];
    }

let range ~docs name ty minimum maximum =
  R.Const
    {
      doc = [ docs ];
      attrs = [];
      vis = Pub;
      name;
      ty = R.named ~args:[ R.named ty ] "std::ops::RangeInclusive";
      value = R.Range_inclusive (R.Int minimum, R.Int maximum);
    }

let text (s : T.t) records =
  let fault_pattern (f : T.fault_actions_item) =
    let at = R.Path [ "FaultAction"; f.name ] in
    if f.holds = [] then at else R.Call (at, List.map (fun _ -> R.Wild) f.holds)
  in
  let op word = String.capitalize_ascii word in
  R.text
    ~header:(Banner.lines ~from_:Table.from_ __FILE__)
    [
      R.Enum
        {
          doc = [ "What a faulty transport does to one request." ];
          attrs = [ derive [ "Debug"; "Clone"; "Copy"; "PartialEq"; "Eq" ] ];
          vis = Pub;
          name = "FaultAction";
          variants =
            List.map
              (fun (f : T.fault_actions_item) ->
                match f.holds with
                | [] -> R.variant ~doc:[ f.docs ] f.name
                | _ -> R.variant ~doc:[ f.docs ] ~payload:duration f.name)
              s.fault_actions;
        };
      R.Blank;
      words ~doc:"The word a request log names it by." "FaultAction" "kind"
        (List.map
           (fun (f : T.fault_actions_item) -> (fault_pattern f, R.Str f.kind))
           s.fault_actions);
      R.Blank;
      range ~docs:s.delay_ms.docs "DELAY_MS" "u64" s.delay_ms.minimum
        s.delay_ms.maximum;
      R.Blank;
      range ~docs:s.schedule_length.docs "SCHEDULE_LENGTH" "usize"
        s.schedule_length.minimum s.schedule_length.maximum;
      R.Blank;
      R.Const
        {
          doc = [ s.slack.docs ];
          attrs = [];
          vis = Pub;
          name = "SLACK";
          ty = R.named "u32";
          value = R.Int s.slack.times;
        };
      R.Blank;
      R.Enum
        {
          doc = [ s.delivery_ops.docs ];
          attrs = [ derive [ "Debug"; "Clone"; "Copy"; "PartialEq"; "Eq" ] ];
          vis = Pub;
          name = "DeliveryOp";
          variants = List.map (fun w -> R.variant (op w)) s.delivery_ops.ops;
        };
      R.Blank;
      words ~doc:"The word the step is named by." "DeliveryOp" "name"
        (List.map
           (fun w -> (R.Path [ "DeliveryOp"; op w ], R.Str w))
           s.delivery_ops.ops);
      R.Blank;
      R.Const
        {
          doc = [ "Every delivery step." ];
          attrs = [];
          vis = Pub;
          name = "DELIVERY_OPS";
          ty = R.Array_of (R.named "DeliveryOp", List.length s.delivery_ops.ops);
          value =
            R.Array
              (List.map
                 (fun w -> R.Path [ "DeliveryOp"; op w ])
                 s.delivery_ops.ops);
        };
      R.Blank;
      record records "RequestLogEntry";
      R.Blank;
      record records "LivenessScenario";
      R.Blank;
      record records "LivenessSpec";
    ]

let file table =
  Result.map
    (fun records -> { Output.path; text = text table records })
    (Table.typed ~language:"Rust" member_types table)
