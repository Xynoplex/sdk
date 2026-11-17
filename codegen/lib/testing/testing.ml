(* The testing group: the testing kit's facts (protocol/specs/src/client/
   testing.json) for the Haskell and OCaml SDKs. The faults a faulty transport
   injects, each drawn as likely as the others and a delay of the table's
   bounds; how long a drawn schedule is; the slack a liveness check gives a
   case; the steps a delivery check interleaves; and, for Haskell, the kit's
   records.

   What a fault holds is a whole number of milliseconds drawn from the delay
   bounds, the only thing the table lets a fault hold. A record's members are
   the table's, each of the type this writer gives it in Haskell, which is
   Haskell's own: a member the table has and this writer gives no type, or
   one this writer types and the table no longer has, is refused. Haskell's
   liveness spec holds the retry clock it runs under besides, and its faulty
   transport is the kit's own record, of Haskell's controls. *)

module H = Haskell_syntax
module T = Tables.Client_testing

let file = "client/testing.json"
let from_ = "protocol/specs/src/" ^ file
let refusal pointer message = { Decode.file; pointer; message }
let io_unit = H.T_apply ("IO", [ T_tuple [] ])

(* Each record member's Haskell type, by the record. *)
let member_types =
  [
    ( "RequestLogEntry",
      [
        ("channel", H.T_name "Text");
        ("action", T_name "FaultAction");
        ("correlationId", T_apply ("Maybe", [ T_name "Text" ]));
        ("retryKey", T_name "Text");
        ("payload", T_name "Object");
      ] );
    ( "LivenessScenario",
      [ ("outputs", H.T_list io_unit); ("settlements", T_list io_unit) ] );
    ( "LivenessSpec",
      [
        ( "setup",
          H.T_fun
            ( T_name "FaultyTransport",
              T_fun (T_fun (T_name "LivenessScenario", io_unit), io_unit) ) );
        ("timeoutMs", T_name "Integer");
        ("retryBudget", T_name "Integer");
        ("cases", T_name "Int");
        ("schedules", T_apply ("Gen", [ T_list (T_name "FaultAction") ]));
        ("makeResponse", T_name "Respond");
      ] );
  ]

type t = {
  table : T.t;
  records : (T.record * (string * H.type_) list) list;
      (** Each record, with its members' Haskell types. *)
}

let derive (table : T.t) =
  let refusals = ref [] in
  let refuse pointer message =
    refusals := refusal pointer message :: !refusals
  in
  List.iteri
    (fun i (fault : T.fault_action) ->
      match fault.holds with
      | [] | [ "ms" ] -> ()
      | _ ->
          refuse
            (Printf.sprintf "/faultActions/%d/holds" i)
            "holds what is not one delay of milliseconds")
    table.fault_actions;
  let records =
    List.mapi
      (fun i (record : T.record) ->
        let at = Printf.sprintf "/records/%d" i in
        match List.assoc_opt record.name member_types with
        | None ->
            refuse at (record.name ^ " is a record no Haskell type is given for");
            (record, [])
        | Some types ->
            let typed =
              List.filter_map
                (fun member ->
                  match List.assoc_opt member types with
                  | Some t -> Some (member, t)
                  | None ->
                      refuse at
                        (Printf.sprintf
                           "%s's %s is a member Haskell gives no type"
                           record.name member);
                      None)
                record.members
            in
            List.iter
              (fun (member, _) ->
                if not (List.mem member record.members) then
                  refuse at
                    (Printf.sprintf "%s has no %s, and Haskell types one"
                       record.name member))
              types;
            (record, typed))
      table.records
  in
  List.iter
    (fun (name, _) ->
      if not (List.exists (fun (r : T.record) -> r.name = name) table.records)
      then refuse "/records" (name ^ " is no record, and Haskell types one"))
    member_types;
  match List.rev !refusals with
  | [] -> Ok { table; records }
  | errors -> Error errors

let fields (record : T.record) typed =
  List.map
    (fun (member, t) ->
      (String.uncapitalize_ascii record.name ^ String.capitalize_ascii member, t))
    typed

let record name = List.find (fun ((r : T.record), _) -> r.name = name)

let haskell t =
  let s = t.table in
  let constructor (fault : T.fault_action) =
    H.constructor fault.name
      ~fields:(List.map (fun _ -> H.T_name "Integer") fault.holds)
  in
  let draw (fault : T.fault_action) =
    match fault.holds with
    | [] -> H.Apply (Name "pure", [ Name fault.name ])
    | _ ->
        Infix
          ( Name fault.name,
            [
              ( "<$>",
                Apply
                  ( Name "chooseInteger",
                    [ Tuple [ Int s.delay_ms.minimum; Int s.delay_ms.maximum ] ]
                  ) );
            ] )
  in
  let kit_record name =
    let r, typed = record name t.records in
    H.record ~about:[ r.docs ] r.name (fields r typed)
  in
  let spec, spec_typed = record "LivenessSpec" t.records in
  {
    Output.path = "haskell/sdk/generated/Xynolog/Internal/Generated/Testing.hs";
    text =
      H.text
        {
          banner = Banner.haskell_lines ~from_ __FILE__;
          extensions = [ "OverloadedStrings" ];
          name = "Xynolog.Internal.Generated.Testing";
          imports =
            [
              H.import "Data.Aeson" ~items:[ Plain "Object"; Plain "Value" ];
              H.import "Data.Text" ~items:[ Plain "Text" ];
              H.import "Xynolog.Retry" ~items:[ Plain "RetryOptions" ];
              H.import "Xynolog.Transport"
                ~items:[ Plain "Transport"; Plain "Carried" ];
              H.import "Test.QuickCheck"
                ~items:[ Plain "Gen"; Plain "oneof"; Plain "chooseInteger" ];
            ];
          body =
            [
              H.data "FaultAction" ~deriving:[ "Eq"; "Show" ]
                (List.map constructor s.fault_actions);
              Value
                {
                  about = [];
                  name = "faultKind";
                  type_ = T_fun (T_name "FaultAction", T_name "Text");
                  clauses =
                    List.map
                      (fun (fault : T.fault_action) ->
                        {
                          H.patterns =
                            [
                              Constructor
                                ( fault.name,
                                  List.map (fun _ -> H.Otherwise) fault.holds );
                            ];
                          body = Str fault.kind;
                        })
                      s.fault_actions;
                };
              H.data "DeliveryOp" ~about:[ s.delivery_ops.docs ]
                ~deriving:[ "Eq"; "Ord"; "Show"; "Enum"; "Bounded" ]
                (List.map
                   (fun op -> H.constructor (String.capitalize_ascii op))
                   s.delivery_ops.ops);
              Value
                {
                  about = [];
                  name = "deliveryOpName";
                  type_ = T_fun (T_name "DeliveryOp", T_name "Text");
                  clauses =
                    List.map
                      (fun op ->
                        {
                          H.patterns =
                            [ Constructor (String.capitalize_ascii op, []) ];
                          body = Str op;
                        })
                      s.delivery_ops.ops;
                };
              H.value "faultActions"
                (T_apply ("Gen", [ T_name "FaultAction" ]))
                (Apply (Name "oneof", [ List (List.map draw s.fault_actions) ]));
              H.value "scheduleLength" ~about:[ s.schedule_length.docs ]
                (T_tuple [ T_name "Int"; T_name "Int" ])
                (Tuple
                   [
                     Int s.schedule_length.minimum;
                     Int s.schedule_length.maximum;
                   ]);
              H.value "slack" ~about:[ s.slack.docs ] (T_name "Integer")
                (Int s.slack.times);
              H.alias "Respond"
                (T_fun
                   ( T_name "Text",
                     T_fun
                       ( T_name "Object",
                         T_apply
                           ("IO", [ T_apply ("Maybe", [ T_name "Value" ]) ]) )
                   ));
              kit_record "RequestLogEntry";
              H.record "FaultyTransport"
                ~about:
                  [
                    "The transport owner fills this with its real carrier and \
                     its native controls.";
                  ]
                [
                  ("carrier", T_name "Transport");
                  ( "queueReply",
                    T_fun
                      ( T_name "Text",
                        T_fun
                          ( T_list (T_apply ("Maybe", [ T_name "Value" ])),
                            io_unit ) ) );
                  ( "refuseWhen",
                    T_fun
                      ( T_fun
                          ( T_name "Text",
                            T_fun
                              ( T_name "Object",
                                T_apply
                                  ( "IO",
                                    [ T_apply ("Maybe", [ T_name "Object" ]) ]
                                  ) ) ),
                        io_unit ) );
                  ( "requestLog",
                    T_apply ("IO", [ T_list (T_name "RequestLogEntry") ]) );
                  ("deliver", T_fun (T_name "Carried", io_unit));
                ];
              kit_record "LivenessScenario";
              H.record ~about:[ spec.docs ] spec.name
                (fields spec spec_typed
                @ [ ("livenessClock", T_name "RetryOptions") ]);
            ];
        };
  }

let ocaml t =
  let s = t.table in
  let name (fault : T.fault_action) =
    String.capitalize_ascii (Text.snake fault.name)
  in
  let count = List.length s.fault_actions in
  let span (b : T.bounds) = b.maximum - b.minimum + 1 in
  {
    Output.path = "ocaml/sdk/lib/testing_facts.ml";
    text =
      Banner.ocaml ~from_:file __FILE__
      ^ "type fault_action = "
      ^ String.concat " | "
          (List.map
             (fun (fault : T.fault_action) ->
               name fault ^ if fault.holds = [] then "" else " of int")
             s.fault_actions)
      ^ "\ntype delivery_op = "
      ^ String.concat " | "
          (List.map String.capitalize_ascii s.delivery_ops.ops)
      ^ "\nlet fault_actions random =\n  match Random.State.int random "
      ^ string_of_int count ^ " with\n"
      ^ String.concat ""
          (List.mapi
             (fun i (fault : T.fault_action) ->
               Printf.sprintf "  | %d -> %s%s\n" i (name fault)
                 (if fault.holds = [] then ""
                  else
                    Printf.sprintf " (%d + Random.State.int random %d)"
                      s.delay_ms.minimum (span s.delay_ms)))
             s.fault_actions)
      ^ "  | _ -> assert false\n"
      ^ Printf.sprintf "let schedule_length = (%d, %d)\nlet slack = %d\n"
          s.schedule_length.minimum s.schedule_length.maximum s.slack.times;
  }

let files ~root:_ (spec : Spec.t) =
  Result.map
    (fun t -> [ haskell t; ocaml t ])
    (derive spec.tables.client_testing)
