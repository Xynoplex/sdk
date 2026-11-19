(* Each group refuses a spec that breaks a rule its files rely on, naming the
   file and the place; and the drift gate reports a file that is not what its
   group writes. *)

open Xynolog_codegen

let docs = `Assoc [ ("lead", `List []); ("trailing", `String "") ]
let prose = `List [ `String "Words." ]

let channel name members : Yojson.Safe.t =
  `Assoc
    ((("channel", `String name) :: members)
    @ [ ("docs", docs); ("schemaDocs", docs) ])

let carrying name schema =
  channel name
    [
      ("shape", `String "schema");
      ("schema", `String schema);
      ("validate", `String schema);
    ]

let strings list = `List (List.map (fun s -> `String s) list)

(* One operation, one event, one in-process channel: a registry every rule
   holds. *)
let base : Yojson.Safe.t =
  `Assoc
    [
      ("$comment", `String "c");
      ( "channelOrder",
        `Assoc
          [
            ( "eventMap",
              strings
                [
                  "demo:limits-requested";
                  "demo:limits-result";
                  "demo:limits-failed";
                  "demo:happened";
                  "demo:internal";
                ] );
            ("schemas", `List []);
          ] );
      ( "channels",
        `List
          [
            carrying "demo:limits-requested" "DemoRequest";
            carrying "demo:limits-result" "DemoResult";
            carrying "demo:limits-failed" "CommandError";
            carrying "demo:happened" "DemoEvent";
            carrying "demo:internal" "DemoInternal";
          ] );
      ( "operations",
        `List
          [
            `Assoc
              [
                ("request", `String "demo:limits-requested");
                ("result", `String "demo:limits-result");
                ("failure", `String "demo:limits-failed");
                ("docs", docs);
              ];
          ] );
      ( "docs",
        `Assoc
          [
            ("eventName", prose);
            ("enrichedEvents", prose);
            ("channelSchemas", prose);
            ("emittableChannel", prose);
          ] );
      ( "inProcess",
        `Assoc [ ("doc", prose); ("channels", strings [ "demo:internal" ]) ] );
      ( "kind",
        `Assoc
          [
            ("doc", prose);
            ("command", `List []);
            ("event", strings [ "demo:happened" ]);
          ] );
      ( "audience",
        `Assoc
          [
            ("doc", prose);
            ("everyone", strings [ "demo:happened" ]);
            ("scoped", `List []);
            ("declared", `List []);
          ] );
      ( "effect",
        `Assoc
          [
            ("doc", prose);
            ("writes", strings [ "demo:limits-requested" ]);
            ("reads", `List []);
          ] );
      ( "trace",
        `Assoc
          [
            ("meaning", `String "Where a relayed frame carries its trace.");
            ("field", `String "_carried");
          ] );
    ]

let object_schema = {|{"type":"object"}|}

let base_schemas =
  [
    ("DemoRequest", object_schema);
    ("DemoResult", object_schema);
    ("CommandError", object_schema);
    ("DemoEvent", object_schema);
    ("DemoInternal", object_schema);
    ("DemoExtra", object_schema);
  ]

(* [json] with the value at [path] replaced, or added as an object's last
   member. *)
let rec set path value (json : Yojson.Safe.t) : Yojson.Safe.t =
  match (path, json) with
  | [], _ -> value
  | [ key ], `Assoc members when not (List.mem_assoc key members) ->
      `Assoc (members @ [ (key, value) ])
  | key :: rest, `Assoc members ->
      `Assoc
        (List.map
           (fun (k, v) -> if k = key then (k, set rest value v) else (k, v))
           members)
  | index :: rest, `List items ->
      `List
        (List.mapi
           (fun i v -> if string_of_int i = index then set rest value v else v)
           items)
  | _ -> invalid_arg ("no place " ^ String.concat "/" path)

let rec get path (json : Yojson.Safe.t) =
  match (path, json) with
  | [], _ -> json
  | key :: rest, `Assoc members -> get rest (List.assoc key members)
  | _ -> invalid_arg ("no place " ^ String.concat "/" path)

let append path item json =
  match get path json with
  | `List items -> set path (`List (items @ [ item ])) json
  | _ -> invalid_arg ("not an array: " ^ String.concat "/" path)

let renamed ~from ~into json =
  Yojson.Safe.from_string
    (Text.replace_all ~sub:from ~by:into (Yojson.Safe.to_string json))

let schema_of text =
  match
    Decode.run ~file:"schema.json" (Yojson.Safe.from_string text) Schema.decode
  with
  | Ok (schema, _) -> schema
  | Error error -> failwith (Decode.error_to_string error)

let derived ?(schemas = base_schemas) json =
  match Decode.run ~file:Bus.Registry.file json Tables.Bus_registry.decode with
  | Error error -> Error [ Decode.error_to_string error ]
  | Ok (registry, _) -> (
      let component name = Option.map schema_of (List.assoc_opt name schemas) in
      match Bus.Registry.derive ~component registry with
      | Ok bus -> Ok bus
      | Error errors -> Error (List.map Decode.error_to_string errors))

let refusals ?schemas json =
  match derived ?schemas json with Ok _ -> [] | Error errors -> errors

let refuses ?schemas json expected () =
  let found = refusals ?schemas json in
  if not (List.mem ("bus/registry.json: " ^ expected) found) then
    Alcotest.failf "expected the refusal\n  %s\nfound\n  %s" expected
      (String.concat "\n  " found)

let accepts ?schemas json () =
  Alcotest.(check (list string)) "refusals" [] (refusals ?schemas json)

(* The base registry with one more channel, in-process and in the EventMap. *)
let with_channel members =
  base
  |> append [ "channels" ] (channel "demo:extra" members)
  |> append [ "channelOrder"; "eventMap" ] (`String "demo:extra")
  |> append [ "inProcess"; "channels" ] (`String "demo:extra")

let case name test = Alcotest.test_case name `Quick test

let axes =
  [
    case "the base registry holds every rule" (accepts base);
    case "prose of paragraphs and items, and a lead of every block"
      (accepts
         (base
         |> set [ "kind"; "doc" ]
              (`List
                 [
                   `String "Words."; `Assoc [ ("items", strings [ "a"; "b" ]) ];
                 ])
         |> set
              [ "operations"; "0"; "docs"; "lead" ]
              (`List
                 [
                   `Assoc [ ("section", `String "Part") ];
                   `String "";
                   `Assoc [ ("comment", prose) ];
                   `Assoc [ ("doc", prose) ];
                 ])));
    case "a lead line as one language writes it"
      (refuses
         (set
            [ "operations"; "0"; "docs"; "lead" ]
            (strings [ "  // a comment" ])
            base)
         "/operations/0/docs/lead/0: expected \"\", found \"  // a comment\"");
  ]

let payloads =
  [
    case "a channel of each shape" (fun () ->
        List.iter
          (fun members -> accepts (with_channel members) ())
          [
            [
              ("shape", `String "schema");
              ("schema", `String "DemoExtra");
              ("validate", `Null);
            ];
            [
              ("shape", `String "envelope");
              ("schema", `String "DemoExtra");
              ("validate", `Null);
            ];
            [ ("shape", `String "void"); ("validate", `Null) ];
            [ ("shape", `String "empty"); ("validate", `Null) ];
            [
              ("shape", `String "storedEvent");
              ("event", `String "demo:extra");
              ("payload", `String "DemoPayload");
              ("validate", `Null);
              ("system", `Bool true);
              ("enriched", `Bool true);
            ];
          ]);
  ]

let with_schemas changes =
  changes
  @ List.filter (fun (n, _) -> not (List.mem_assoc n changes)) base_schemas

(* The registry derives, and its one operation's result names nothing beside
   its response. *)
let names_nothing ~schemas json =
  match derived ~schemas json with
  | Ok bus ->
      Alcotest.(check (list (pair string (list string))))
        "reply names"
        [ ("demo:limits-requested", []) ]
        bus.reply_names
  | Error errors -> Alcotest.fail (String.concat "\n" errors)

let derivations =
  [
    case "a reply names what its schema requires beside its response" (fun () ->
        match
          derived
            ~schemas:
              (with_schemas
                 [
                   ( "DemoResult",
                     {|{"type":"object","required":["response","demoId"],"properties":{"response":{},"demoId":{"type":"string"}}}|}
                   );
                   ( "DemoRequest",
                     {|{"type":"object","properties":{"demoId":{"type":"string"}}}|}
                   );
                 ])
            base
        with
        | Ok bus ->
            Alcotest.(check (list (pair string (list string))))
              "reply names"
              [ ("demo:limits-requested", [ "demoId" ]) ]
              bus.reply_names
        | Error errors -> Alcotest.fail (String.concat "\n" errors));
    case "a reply that requires its response alone, or nothing, names nothing"
      (fun () ->
        List.iter
          (fun result ->
            names_nothing
              ~schemas:(with_schemas [ ("DemoResult", result) ])
              base)
          [
            {|{"type":"object","required":["response"],"properties":{"response":{}}}|};
            {|{"type":"object","properties":{}}|};
          ]);
    case "a property a reply may state and does not require is no name"
      (fun () ->
        names_nothing
          ~schemas:
            (with_schemas
               [
                 ( "DemoResult",
                   {|{"type":"object","required":["response"],"properties":{"response":{},"demoId":{"type":"string"}}}|}
                 );
               ])
          base);
    case "a reply of no schema names nothing, and no schema is read for it"
      (fun () ->
        let unread =
          List.filter (fun (name, _) -> name <> "DemoResult") base_schemas
        in
        List.iter
          (fun members ->
            names_nothing ~schemas:unread
              (set [ "channels"; "1" ]
                 (channel "demo:limits-result"
                    (members @ [ ("validate", `Null) ]))
                 base))
          [
            [ ("shape", `String "envelope"); ("schema", `String "DemoResult") ];
            [ ("shape", `String "empty") ];
            [ ("shape", `String "void") ];
          ]);
    case "a reply whose schema is composed"
      (refuses
         ~schemas:
           (with_schemas [ ("DemoResult", {|{"allOf":[{"type":"object"}]}|}) ])
         base
         "/operations/0: demo:limits-result carries DemoResult, which is \
          composed with allOf: what it requires is not read from its own \
          required");
    case "a reply naming what its request does not state"
      (refuses
         ~schemas:
           (with_schemas
              [
                ( "DemoResult",
                  {|{"type":"object","required":["demoId"],"properties":{"demoId":{}}}|}
                );
              ])
         base
         "/operations/0: demo:limits-result names \"demoId\" beside its \
          response, which demo:limits-requested does not state");
    case "a reply that is a stored event"
      (refuses
         (set [ "channels"; "1" ]
            (channel "demo:limits-result"
               [
                 ("shape", `String "storedEvent");
                 ("event", `String "demo:limits-result");
                 ("payload", `String "DemoPayload");
                 ("validate", `Null);
               ])
            base)
         "/operations/0: demo:limits-result is the reply to \
          demo:limits-requested and is a stored event, which states no \
          response to name anything beside");
    case "a payload's stamps, through its composition" (fun () ->
        match
          derived
            ~schemas:
              (with_schemas
                 [
                   ( "DemoEvent",
                     {|{"properties":{"_userId":{},"name":{}},"allOf":[{"$ref":"./Stamped.json"}]}|}
                   );
                   ("Stamped", {|{"properties":{"_roles":{},"_userId":{}}}|});
                 ])
            base
        with
        | Ok bus ->
            Alcotest.(check (list string))
              "stamps" [ "_roles"; "_userId" ]
              (List.assoc "demo:happened" bus.stamps)
        | Error errors -> Alcotest.fail (String.concat "\n" errors));
    case "a union whose members declare different stamps"
      (refuses
         ~schemas:
           (with_schemas
              [
                ( "DemoEvent",
                  {|{"oneOf":[{"$ref":"./Signed.json"},{"$ref":"./Plain.json"}]}|}
                );
                ("Signed", {|{"properties":{"_userId":{},"kind":{}}}|});
                ("Plain", {|{"properties":{"kind":{}}}|});
              ])
         base
         "/channelOrder/eventMap/3: DemoEvent: its members do not declare the \
          same stamps ([_userId]; []), and a stamp is kept or dropped before \
          it is known which member a frame is");
    case "a union whose members declare the same stamps" (fun () ->
        match
          derived
            ~schemas:
              (with_schemas
                 [
                   ( "DemoEvent",
                     {|{"anyOf":[{"$ref":"./Signed.json"},{"$ref":"./Also.json"}]}|}
                   );
                   ("Signed", {|{"properties":{"_userId":{},"kind":{}}}|});
                   ("Also", {|{"properties":{"_userId":{}}}|});
                 ])
            base
        with
        | Ok bus ->
            Alcotest.(check (list string))
              "stamps" [ "_userId" ]
              (List.assoc "demo:happened" bus.stamps)
        | Error errors -> Alcotest.fail (String.concat "\n" errors));
    case "a payload schema referring to no component"
      (refuses
         ~schemas:
           (with_schemas
              [ ("DemoEvent", {|{"allOf":[{"$ref":"Stamped.json"}]}|}) ])
         base
         "/channelOrder/eventMap/3: a payload schema refers to \
          \"Stamped.json\", which names no component schema");
    case "a payload naming a schema Protocol lacks"
      (refuses
         ~schemas:(List.remove_assoc "DemoEvent" base_schemas)
         base
         "/channelOrder/eventMap/3: names the schema DemoEvent, which Protocol \
          does not have");
    case "no limits operation"
      (refuses
         (renamed ~from:"demo:limits-requested" ~into:"demo:requested" base)
         "/operations: no operation is named <flow>:limits-requested");
    case "limits operations that answer differently"
      (refuses
         (base
         |> append [ "channels" ]
              (carrying "other:limits-requested" "OtherRequest")
         |> append [ "channels" ]
              (channel "other:limits-result"
                 [
                   ("shape", `String "envelope");
                   ("schema", `String "OtherResult");
                   ("validate", `Null);
                 ])
         |> append [ "channels" ]
              (carrying "other:limits-failed" "CommandError")
         |> append [ "operations" ]
              (`Assoc
                 [
                   ("request", `String "other:limits-requested");
                   ("result", `String "other:limits-result");
                   ("failure", `String "other:limits-failed");
                   ("docs", docs);
                 ])
         |> append [ "effect"; "writes" ] (`String "other:limits-requested"))
         "/operations: the limits operations do not all ask and answer the \
          same: demo:limits-requested, other:limits-requested");
  ]

let names =
  let colliding =
    base
    |> append [ "channels" ] (carrying "demo:x-y" "DemoExtra")
    |> append [ "channels" ] (carrying "demo:x:y" "DemoExtra")
    |> append [ "channelOrder"; "eventMap" ] (`String "demo:x-y")
    |> append [ "channelOrder"; "eventMap" ] (`String "demo:x:y")
    |> append [ "inProcess"; "channels" ] (`String "demo:x-y")
    |> append [ "inProcess"; "channels" ] (`String "demo:x:y")
  in
  let refusal files =
    match derived colliding with
    | Error errors -> Alcotest.fail (String.concat "\n" errors)
    | Ok bus -> (
        match files bus with
        | Ok _ -> Alcotest.fail "accepted two channels of one name"
        | Error errors -> List.map Decode.error_to_string errors)
  in
  [
    case "two channels of one Go name" (fun () ->
        Alcotest.(check (list string))
          "refusals"
          [
            "bus/registry.json: /channels: \"demo:x-y\" and \"demo:x:y\" would \
             both be the Go name DemoXY";
          ]
          (refusal Bus.Go.files));
    case "two channels of one Python constant" (fun () ->
        Alcotest.(check (list string))
          "refusals"
          [
            "bus/registry.json: /channels: \"demo:x-y\" and \"demo:x:y\" would \
             both be the Python constant DEMO_X_Y";
          ]
          (refusal Bus.Python.files));
    case "Go names and Python constants" (fun () ->
        Alcotest.(check (list string))
          "Go"
          [ "MarkDelegateTimeout"; "JobQueued" ]
          (List.map Bus.Go.name [ "mark:delegate-timeout"; "job:queued" ]);
        Alcotest.(check (list string))
          "Python"
          [ "MARK_DELEGATE_TIMEOUT"; "EMIT_RETRY"; "A_B_" ]
          (List.map Bus.Python.constant
             [ "mark:delegate-timeout"; "emitRetry"; "a--b?" ]));
  ]

let text =
  [
    case "a width in code points" (fun () ->
        Alcotest.(check (list string))
          "padded"
          [ "\226\134\146  "; "abcd "; "\240\159\152\128  " ]
          [
            Text.pad "\226\134\146" 3;
            Text.pad "abcd" 3;
            Text.pad "\240\159\152\128" 3;
          ]);
    case "words wrapped to their width behind a lead" (fun () ->
        Alcotest.(check (list string))
          "wrapped"
          [ "one two"; "three"; "fourfourfour" ]
          (Text.wrapped ~lead:"// " ~width:12 "one  two\nthree fourfourfour"));
    case "a no-break space joins its words" (fun () ->
        Alcotest.(check (list string))
          "wrapped"
          [ "one"; "two\194\160three" ]
          (Text.wrapped ~lead:"// " ~width:12 "one two\194\160three"));
  ]

let output =
  [
    case "a write replaces each file that differs" (fun () ->
        let root = Filename.temp_dir "groups" "" in
        let file path text = { Output.path; text } in
        Output.write ~root
          [ file "a/same.txt" "same\n"; file "a/differs.txt" "old\n" ];
        let files =
          [
            file "a/same.txt" "same\n";
            file "a/differs.txt" "new\n";
            file "b/absent.txt" "x\n";
            file "c/laid-out.ts" "export const x = 1\n";
          ]
        in
        Output.write ~root files;
        Alcotest.(check (list (option string)))
          "written"
          (List.map (fun (f : Output.file) -> Some f.text) files)
          (List.map (Output.committed ~root) files));
    case "Prettier lays out the TypeScript files" (fun () ->
        Alcotest.(check (list bool))
          "laid out" [ true; false; false ]
          (List.map
             (fun path -> Output.prettier { Output.path; text = "" })
             [
               "typescript/core/src/a.ts";
               "go/a.go";
               "typescript/core/README.md";
             ]));
  ]

let () =
  Alcotest.run "groups"
    [
      ("bus axes", axes);
      ("bus payloads", payloads);
      ("bus derivations", derivations);
      ("bus names", names);
      ("text", text);
      ("output", output);
    ]
