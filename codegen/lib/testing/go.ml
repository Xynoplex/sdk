(* The testing kit's facts as the Go SDK reads them
   (go/xynologtest/kit_gen.go): the faults, a struct each, sealed in one
   interface and each told by the word a request log names it by, a delay
   held as a time.Duration; every fault, to draw from; the delay and schedule
   bounds; the slack; the delivery steps, and every one of them; and the
   kit's records, each member of Go's type for it, a duration named without
   its unit as the timing is. A request log entry holds the scope the request
   went on besides. Drawing a schedule is the SDK's own (liveness.go). *)

module G = Go_syntax
module T = Tables.Client_testing

let path = "go/xynologtest/kit_gen.go"
let channels = G.Slice (G.Receive G.Empty_struct)
let sentence text = String.uncapitalize_ascii text

(* Each record member's field, its type and its doc. *)
let member_types =
  [
    ( "RequestLogEntry",
      [
        ( "channel",
          ("Channel", G.Named "bus.Channel", "the channel it was sent on.") );
        ( "action",
          ("Action", G.Named "FaultAction", "what the schedule did to it.") );
        ( "correlationId",
          ( "CorrelationID",
            G.Named "string",
            "what pairs it with its reply; empty for a request that awaits \
             none." ) );
        ( "retryKey",
          ( "RetryKey",
            G.Named "string",
            "its identity across retries: two entries with the same key are \
             one logical request, sent again (RetryKeyOf)." ) );
        ( "payload",
          ("Payload", G.Named "json.RawMessage", "its payload, as it was sent.")
        );
      ] );
    ( "LivenessScenario",
      [
        ( "outputs",
          ( "Outputs",
            channels,
            "one channel per output, closed when the output has said \
             something, a value or a failure (L1)." ) );
        ( "settlements",
          ( "Settlements",
            channels,
            "one channel per awaited path, closed when it has settled, either \
             way (L2)." ) );
      ] );
    ( "LivenessSpec",
      [
        ( "setup",
          ( "Setup",
            G.Func_type
              ( [
                  G.Pointer (G.Named "testing.T");
                  G.Pointer (G.Named "FaultyTransport");
                ],
                [ G.Named "LivenessScenario" ] ),
            "what builds a fresh composition over the transport it is given, \
             whose stream names what a client's does (bus.BridgedChannels). It \
             is called once per schedule, inside the case's bubble; what it \
             opens it closes by t.Cleanup, which runs before the transport is \
             closed. What it starts must end once the transport has closed: a \
             goroutine still blocked then fails the test as the bubble's \
             deadlock." ) );
        ( "timeoutMs",
          ( "Timeout",
            G.Named "time.Duration",
            "the time the composition gives a bus request. The bound is \
             derived from it: (Timeout × (1 + RetryBudget) + the schedule's \
             delays) × the slack." ) );
        ( "retryBudget",
          ( "RetryBudget",
            G.Named "int",
            "how often the composition may send a logical request again." ) );
        ( "cases",
          ( "Cases",
            G.Named "int",
            "how many schedules are drawn (FaultSchedules) when Schedules \
             states none." ) );
        ( "schedules",
          ( "Schedules",
            G.Slice (G.Slice (G.Named "FaultAction")),
            "the fault schedules to run, one case each, in place of drawn ones."
          ) );
        ( "makeResponse",
          ( "MakeResponse",
            G.Named "MakeResponse",
            "what the gateway answers a request no queued response answers, as \
             FaultyConfig.MakeResponse is." ) );
      ] );
  ]

(* A member Go's records hold that the table's do not. *)
let extras =
  [
    ( "RequestLogEntry",
      [
        ( "Scope",
          G.Named "api.ResourceId",
          "the resource whose scope it was sent on; the zero ResourceId for a \
           request on no scope." );
      ] );
  ]

let field (name, type_, doc) =
  { G.doc = G.prose (name ^ " is " ^ doc); names = [ name ]; type_; tag = None }

let record records name =
  let (r : T.records_item), typed = Table.record name records in
  G.Type
    {
      doc = G.prose (r.name ^ " is " ^ sentence r.docs);
      name = r.name;
      def =
        Struct
          {
            spacing = Packed;
            fields =
              List.map (fun (_, member) -> field member) typed
              @ List.map field
                  (Option.value ~default:[] (List.assoc_opt name extras));
          };
    }

let receiver name = ("", G.Named name)

let fault (f : T.fault_actions_item) =
  [
    G.Type
      {
        doc = G.prose (f.name ^ " is a fault. " ^ f.docs);
        name = f.name;
        def =
          Struct
            {
              spacing = Packed;
              fields =
                List.map
                  (fun _ ->
                    field
                      ( "For",
                        G.Named "time.Duration",
                        "how long after the request its reply comes: ms \
                         milliseconds." ))
                  f.holds;
            };
      };
    G.Adjacent
      [
        G.func ~receiver:(receiver f.name)
          ~results:(Unnamed [ G.Named "string" ]) "Kind"
          (One_line (Return [ G.Quoted f.kind ]));
        G.func ~receiver:(receiver f.name) "faultAction" Empty;
      ];
  ]

(* [a, b or c]. *)
let either names =
  match List.rev names with
  | [] -> ""
  | [ one ] -> one
  | last :: rest -> String.concat ", " (List.rev rest) ^ " or " ^ last

let op word = "DeliveryOp" ^ String.capitalize_ascii word

let const ~docs name value =
  G.Const (G.spec ~doc:(G.prose docs) name (G.Int value))

(* A range's bounds, [name ^ "Minimum"] and [name ^ "Maximum"]. *)
let range ~docs name minimum maximum =
  G.Consts
    {
      doc = G.prose docs;
      spacing = Packed;
      specs =
        [
          G.spec (name ^ "Minimum") (G.Int minimum);
          G.spec (name ^ "Maximum") (G.Int maximum);
        ];
    }

let text (s : T.t) records =
  let names =
    List.map (fun (f : T.fault_actions_item) -> f.name) s.fault_actions
  in
  G.text
    {
      header =
        G.verbatim
          "Code generated from protocol/specs/src/client/testing.json; DO NOT \
           EDIT.\n\n\
           Regenerate: make generate (codegen/lib/testing/go.ml)";
      package = "xynologtest";
      imports =
        [
          [ "encoding/json"; "testing"; "time" ];
          [ "github.com/xynolog/sdk/go/api"; "github.com/xynolog/sdk/go/bus" ];
        ];
      decls =
        [
          G.Type
            {
              doc =
                G.prose
                  ("FaultAction is what the wire does to one request: "
                 ^ either names
                 ^ ". Read it with a type switch; Kind is the word a request \
                    log names it by.");
              name = "FaultAction";
              def =
                Interface
                  [
                    G.method_ ~results:(Unnamed [ G.Named "string" ]) "Kind" [];
                    G.method_ "faultAction" [];
                  ];
            };
        ]
        @ List.concat_map fault s.fault_actions
        @ [
            G.Var
              (G.spec
                 ~doc:
                   (G.prose
                      "faults is every fault, each holding nothing yet: what a \
                       schedule is drawn from.")
                 "faults"
                 (G.inline ~of_:(G.Slice (G.Named "FaultAction"))
                    (List.map
                       (fun n -> G.item (G.inline ~of_:(G.Named n) []))
                       names)));
            range ~docs:s.delay_ms.docs "delayMs" s.delay_ms.minimum
              s.delay_ms.maximum;
            range ~docs:s.schedule_length.docs "scheduleLength"
              s.schedule_length.minimum s.schedule_length.maximum;
            const
              ~docs:("slack is " ^ sentence s.slack.docs)
              "slack" s.slack.times;
            G.Type
              {
                doc = G.prose ("DeliveryOp is " ^ sentence s.delivery_ops.docs);
                name = "DeliveryOp";
                def = Is (G.Named "string");
              };
            G.Consts
              {
                doc = [];
                spacing = Packed;
                specs =
                  List.map
                    (fun w ->
                      G.spec
                        ~doc:
                          (G.prose
                             (Printf.sprintf "%s is the step %S." (op w) w))
                        ~type_:(G.Named "DeliveryOp") (op w) (G.Quoted w))
                    s.delivery_ops.ops;
              };
            G.Var
              (G.spec
                 ~doc:(G.prose "deliveryOps is every delivery step.")
                 "deliveryOps"
                 (G.inline ~of_:(G.Slice (G.Named "DeliveryOp"))
                    (List.map
                       (fun w -> G.item (G.Name (op w)))
                       s.delivery_ops.ops)));
            record records "RequestLogEntry";
            record records "LivenessScenario";
            record records "LivenessSpec";
          ];
    }

let file table =
  Result.map
    (fun records -> { Output.path; text = text table records })
    (Table.typed ~language:"Go" member_types table)
