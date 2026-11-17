(* The client types' and the testing kit's writers: what each writes of a
   shape it can state, and each shape it refuses. *)

open Xynolog_codegen
module M = Client_types.Model
module W = Client_types.Haskell
module T = Tables.Client_testing

let case name test = Alcotest.test_case name `Quick test
let member ?(required = true) name held = { M.name; held; required }

let refused = function
  | Ok _ -> Alcotest.fail "wrote what it should refuse"
  | Error (_ :: _) -> ()
  | Error [] -> Alcotest.fail "refused, naming nothing"

let shapes list name = List.assoc_opt name list

let refused_frame members =
  shapes
    [
      ("FrameRefusalReason", M.Words [ "lacks"; "malformed" ]);
      ( "JobEvent",
        Union
          {
            tag = "kind";
            branches = [ ("refused", [ member "data" (Inline members) ]) ];
          } );
      ( "UploadProgress",
        Union
          {
            tag = "phase";
            branches = [ ("started", [ member "totalBytes" (Scalar Integer) ]) ];
          } );
    ]

let text (file : Output.file) = file.text

let contains needle haystack =
  let n = String.length needle and h = String.length haystack in
  let rec at i =
    i + n <= h && (String.sub haystack i n = needle || at (i + 1))
  in
  at 0

let fault name kind holds : T.fault_action = { name; kind; docs = "d"; holds }

let table ~records =
  {
    T.comment = "c";
    fault_actions =
      [ fault "Deliver" "deliver" []; fault "Delay" "delay" [ "ms" ] ];
    delay_ms = { docs = "d"; minimum = 0; maximum = 5 };
    schedule_length = { docs = "d"; minimum = 1; maximum = 8 };
    slack = { docs = "d"; times = 4 };
    delivery_ops = { docs = "d"; ops = [ "write"; "transition" ] };
    records;
  }

let kit_records =
  [
    {
      T.name = "RequestLogEntry";
      docs = "d";
      members = [ "channel"; "action"; "correlationId"; "retryKey"; "payload" ];
    };
    {
      name = "LivenessScenario";
      docs = "d";
      members = [ "outputs"; "settlements" ];
    };
    {
      name = "LivenessSpec";
      docs = "d";
      members =
        [
          "setup";
          "timeoutMs";
          "retryBudget";
          "cases";
          "schedules";
          "makeResponse";
        ];
    };
  ]

let cases =
  [
    case "a refused frame's report is stated by the transport's FrameRefusal"
      (fun () ->
        match
          W.operation_reports
            ~shape:
              (refused_frame
                 [
                   member "channel" (Scalar String);
                   member "member" (Scalar String);
                   member "reason"
                     (Named { name = "FrameRefusalReason"; union = false });
                 ])
        with
        | Ok file ->
            Alcotest.(check bool)
              "the reason is the generated dispatch's" true
              (contains "\"reason\" .= refusalReason (reason (fault value0))"
                 (text file))
        | Error errors ->
            Alcotest.failf "refused: %s"
              (String.concat "; " (List.map Decode.error_to_string errors)));
    case
      "a refused frame's report of a member no FrameRefusal states is refused"
      (fun () ->
        refused
          (W.operation_reports
             ~shape:(refused_frame [ member "payload" (Scalar String) ])));
    case "a record's optional member is refused" (fun () ->
        refused
          (W.pending_annotation
             ~shape:
               (shapes
                  [
                    ( "PendingAnnotation",
                      M.Fields
                        [ member ~required:false "selector" (Scalar String) ] );
                  ])));
    case "an adapter states an integer as one" (fun () ->
        match
          W.adapters
            ~shape:
              (shapes
                 [
                   ("QuotedText", M.Fields [ member "exact" (Scalar String) ]);
                   ("TextSpan", M.Fields [ member "start" (Scalar Integer) ]);
                   ( "ReconciledSpan",
                     M.Fields [ member "start" (Scalar Integer) ] );
                   ("AnchorMethod", M.Words [ "unique-match" ]);
                   ("MatchQuality", M.Words [ "fuzzy" ]);
                   ("PdfCoordinate", M.Fields [ member "page" (Scalar Integer) ]);
                   ("IssuedTokens", M.Fields [ member "access" (Scalar String) ]);
                   ( "DeviceCode",
                     M.Fields [ member "expiresIn" (Scalar Integer) ] );
                   ( "BeginAuthorizationOptions",
                     M.Fields
                       [
                         member "target"
                           (Named { name = "HttpEndpoint"; union = false });
                       ] );
                 ])
        with
        | Ok adapters -> (
            match List.assoc_opt "TextSpan" adapters with
            | Some (Schema.Schema { properties = Some properties; _ }) -> (
                match List.assoc_opt "start" properties with
                | Some (Schema.Schema { type_ = Some [ Integer ]; _ }) -> ()
                | _ -> Alcotest.fail "start is not an integer")
            | _ -> Alcotest.fail "no TextSpan of properties")
        | Error _ -> Alcotest.fail "refused");
    case "a secret proof whose grant is not the client assertion's is refused"
      (fun () ->
        refused
          (W.service_proof ~grant_type:"client_credentials"
             [ member "grant_type" (Word [ "password" ]) ]));
    case "the kit's records are typed member for member" (fun () ->
        match Testing.derive (table ~records:kit_records) with
        | Ok t ->
            Alcotest.(check bool)
              "the spec holds its clock" true
              (contains "  , livenessClock :: RetryOptions"
                 (Testing.haskell t).Output.text)
        | Error _ -> Alcotest.fail "refused");
    case "a record member Haskell gives no type is refused" (fun () ->
        refused
          (Testing.derive
             (table
                ~records:
                  (List.map
                     (fun (r : T.record) ->
                       if r.name = "LivenessScenario" then
                         { r with members = r.members @ [ "deadline" ] }
                       else r)
                     kit_records))));
    case "a member Haskell types that the table no longer has is refused"
      (fun () ->
        refused
          (Testing.derive
             (table
                ~records:
                  (List.map
                     (fun (r : T.record) ->
                       if r.name = "RequestLogEntry" then
                         {
                           r with
                           members = List.filter (( <> ) "retryKey") r.members;
                         }
                       else r)
                     kit_records))));
    case "a fault holding other than one delay is refused" (fun () ->
        refused
          (Testing.derive
             {
               (table ~records:kit_records) with
               fault_actions = [ fault "Burst" "burst" [ "count" ] ];
             }));
  ]

let () = Alcotest.run "client_types" [ ("the writers", cases) ]
