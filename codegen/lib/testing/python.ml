(* The testing kit's facts as the Python SDK reads them: in
   python/sdk/src/xynolog/testing/_kit.py, the faults, a frozen dataclass
   each told by its `kind`, and every one of them, to draw from; the delay
   and schedule bounds, each its least and its most; the slack; the delivery
   steps, and every one of them; and the request log's entry. In
   _liveness_kit.py beside it, the liveness records. Each record member is of
   Python's type for it, with the default a caller may leave it to. What only
   a type names is imported under [if TYPE_CHECKING:]. Drawing a schedule is
   the SDK's own (liveness.py). *)

module P = Python_syntax
module T = Tables.Client_testing

let path = "python/sdk/src/xynolog/testing/_kit.py"
let liveness_path = "python/sdk/src/xynolog/testing/_liveness_kit.py"
let name n = P.Name n

let union names =
  List.fold_left
    (fun a b -> P.Binary (a, Or, name b))
    (name (List.hd names))
    (List.tl names)

let awaitables =
  P.sub "Sequence" [ P.item (P.sub "Awaitable" [ P.item (name "object") ]) ]

(* Each record member's type, its default if it has one, and its doc. *)
let member_types =
  [
    ( "RequestLogEntry",
      [
        ("channel", (name "str", None, "The channel it was sent on."));
        ("action", (name "FaultAction", None, "What the schedule did to it."));
        ( "correlationId",
          ( P.Binary (name "str", Or, name "None"),
            None,
            "What pairs it with its reply; `None` for a request that awaits \
             none." ) );
        ( "retryKey",
          ( name "str",
            None,
            "The request's identity across retries: two entries with the same \
             key are one logical request, sent again." ) );
        ( "payload",
          ( P.sub "Mapping" [ P.item (name "str"); P.item (name "JsonValue") ],
            None,
            "The payload as it was sent." ) );
      ] );
    ( "LivenessScenario",
      [
        ( "outputs",
          ( awaitables,
            None,
            "One per output: it completes when the output has said something, \
             a value or a failure (L1).\n\n\
             A live query's first state, `Pending`, is nothing said: an output \
             of one\n\
             completes on the first state that is not." ) );
        ( "settlements",
          ( awaitables,
            None,
            "One per awaited path: it completes when the path has settled, by \
             returning or by raising (L2)." ) );
      ] );
    ( "LivenessSpec",
      [
        ( "setup",
          ( P.Str
              "Callable[[FaultyTransport], \
               AbstractAsyncContextManager[LivenessScenario]]",
            None,
            "Build a fresh composition over the transport it is given, and \
             give what it exposes.\n\n\
             The transport's stream names a full client's channels, \
             `BRIDGED_CHANNELS`.\n\n\
             Called once per case, inside the case's loop. What it opened it \
             ends on\n\
             the way out, and the transport is closed after." ) );
        ( "timeoutMs",
          ( name "int",
            None,
            "The time the composition gives a bus request.\n\n\
             The bound is derived from it: the timeout times one more than the \
             retry\n\
             budget, and the schedule's delays, all of it `SLACK` times over."
          ) );
        ( "retryBudget",
          (name "int", None, "How often a logical request may be sent again.")
        );
        ("cases", (name "int", None, "How many schedules it is run under."));
        ( "schedules",
          ( P.Str "SearchStrategy[Sequence[FaultAction]] | None",
            Some (name "None"),
            "The schedules drawn; with none, `fault_schedules()`'s." ) );
        ( "makeResponse",
          ( P.Str "MakeResponse | None",
            Some (name "None"),
            "What the gateway answers a request nothing queued an answer for, \
             as `FaultyTransport`'s `make_response` does; with none, \
             `refuse_unscripted_operation`." ) );
      ] );
  ]

let record records n =
  let (r : T.records_item), typed = Table.record n records in
  P.frozen_dataclass r.name r.docs
    (List.map
       (fun (member, (type_, default, doc)) ->
         P.field ~doc ?default (Text.snake member) type_)
       typed)

let fault (f : T.fault_actions_item) =
  P.Class
    {
      decorators =
        [
          name "final";
          P.call "dataclass"
            [
              P.keyword "frozen" (name "True"); P.keyword "slots" (name "True");
            ];
        ];
      name = f.name;
      bases = [];
      doc = Some (As_is f.docs);
      spacing = Packed;
      body =
        List.map (fun held -> P.field held (name "int")) f.holds
        @ [
            P.field "kind"
              (P.sub "Literal" [ P.item (P.Str f.kind) ])
              ~default:
                (P.call "field"
                   [
                     P.keyword "default" (P.Str f.kind);
                     P.keyword "init" (name "False");
                   ]);
          ];
    }

(* A range, as its least and its most. *)
let range ~docs n minimum maximum =
  P.assign ~annotation:(name "Final")
    ~value:(P.tuple [ P.item (P.Int minimum); P.item (P.Int maximum) ])
    ~doc:(As_is (docs ^ " Its least and its most."))
    n

let exports names =
  P.assign "__all__"
    ~value:
      (P.List
         (P.items ~magic:true
            (List.map (fun n -> P.item (P.Str n)) (List.sort compare names))))

let text (s : T.t) records =
  let faults =
    List.map (fun (f : T.fault_actions_item) -> f.name) s.fault_actions
  in
  P.text
    {
      header = Banner.python_lines ~from_:Table.from_ __FILE__;
      doc =
        As_is
          "The testing kit's facts: what a faulty transport does to a request, \
           the bounds a\n\
           liveness check draws a schedule within and the room it gives a \
           case, the steps\n\
           an exactly-once check interleaves, and the request log's entry.";
      imports =
        [
          [
            P.From ("collections.abc", [ "Mapping" ]);
            P.From ("dataclasses", [ "dataclass"; "field" ]);
            P.From ("typing", [ "Final"; "Literal"; "final" ]);
          ];
          [ P.From ("pydantic", [ "JsonValue" ]) ];
        ];
      body =
        exports
          (faults
          @ [
              "FaultAction";
              "FAULTS";
              "DELAY_MS";
              "SCHEDULE_LENGTH";
              "SLACK";
              "DeliveryOp";
              "DELIVERY_OPS";
              "RequestLogEntry";
            ])
        :: List.map fault s.fault_actions
        @ [
            P.alias ~doc:(As_is "What the wire does to one request.")
              "FaultAction" (union faults);
            P.assign ~annotation:(name "Final")
              ~value:(P.tuple (List.map (fun n -> P.item (name n)) faults))
              ~doc:(As_is "Every fault: what a schedule is drawn from.")
              "FAULTS";
            range ~docs:s.delay_ms.docs "DELAY_MS" s.delay_ms.minimum
              s.delay_ms.maximum;
            range ~docs:s.schedule_length.docs "SCHEDULE_LENGTH"
              s.schedule_length.minimum s.schedule_length.maximum;
            P.assign ~annotation:(name "Final") ~value:(P.Int s.slack.times)
              ~doc:(As_is s.slack.docs) "SLACK";
            P.alias ~doc:(As_is s.delivery_ops.docs) "DeliveryOp"
              (P.sub "Literal"
                 (List.map (fun w -> P.item (P.Str w)) s.delivery_ops.ops));
            P.assign
              ~annotation:
                (P.sub "Final"
                   [
                     P.item
                       (P.sub "tuple"
                          [ P.item (name "DeliveryOp"); P.item P.Ellipsis ]);
                   ])
              ~value:(P.strings s.delivery_ops.ops)
              ~doc:(As_is "Every delivery step.") "DELIVERY_OPS";
            record records "RequestLogEntry";
          ];
    }

(* The liveness records, which name the transport they are run over: a
   module of their own, so the transport's, which this one names only as a
   type, imports none of it. *)
let liveness_text records =
  P.text
    {
      header = Banner.python_lines ~from_:Table.from_ __FILE__;
      doc =
        As_is
          "What a liveness check is run over: a composition, the schedules it \
           is run under,\n\
           and what one fresh run of it exposes.";
      imports =
        [
          [
            P.From ("collections.abc", [ "Awaitable"; "Sequence" ]);
            P.From ("dataclasses", [ "dataclass" ]);
            P.From ("typing", [ "TYPE_CHECKING"; "final" ]);
          ];
        ];
      body =
        [
          P.If
            ( name "TYPE_CHECKING",
              [
                P.Imports
                  [
                    [
                      P.From ("collections.abc", [ "Callable" ]);
                      P.From ("contextlib", [ "AbstractAsyncContextManager" ]);
                    ];
                    [ P.From ("hypothesis.strategies", [ "SearchStrategy" ]) ];
                    [
                      P.From ("xynolog.testing._kit", [ "FaultAction" ]);
                      P.From
                        ( "xynolog.testing.transport",
                          [ "FaultyTransport"; "MakeResponse" ] );
                    ];
                  ];
              ] );
          exports [ "LivenessScenario"; "LivenessSpec" ];
          record records "LivenessScenario";
          record records "LivenessSpec";
        ];
    }

let files table =
  Result.map
    (fun records ->
      [
        { Output.path; text = text table records };
        { Output.path = liveness_path; text = liveness_text records };
      ])
    (Table.typed ~language:"Python" member_types table)
