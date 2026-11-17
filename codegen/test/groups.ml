(* Each group refuses a spec that breaks a rule its files rely on, naming the
   file and the place; and the drift gate reports a file that is not what its
   group writes. *)

open Xynolog_codegen

let docs = `Assoc [ ("lead", `List []); ("trailing", `String "") ]

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
      ( "preamble",
        `Assoc
          [
            ("protocolHeader", `String "");
            ("eventMapTail", `List []);
            ("schemasTail", `List []);
            ("operationsHeader", `String "");
            ("operationsInnerTail", `List []);
            ("operationsFooter", `String "");
            ("bridgedHeader", `String "");
            ("bridgedDerivation", `String "");
          ] );
      ( "docs",
        `Assoc
          [
            ("eventName", `String "");
            ("enrichedEvents", `String "");
            ("channelSchemas", `String "");
            ("emittableChannel", `String "");
          ] );
      ( "inProcess",
        `Assoc
          [ ("doc", `String ""); ("channels", strings [ "demo:internal" ]) ] );
      ( "kind",
        `Assoc
          [
            ("doc", `String "");
            ("command", `List []);
            ("event", strings [ "demo:happened" ]);
          ] );
      ( "audience",
        `Assoc
          [
            ("doc", `String "");
            ("everyone", strings [ "demo:happened" ]);
            ("scoped", `List []);
            ("declared", `List []);
          ] );
      ( "effect",
        `Assoc
          [
            ("doc", `String "");
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
    case "a crossing channel with no audience"
      (refuses
         (set [ "audience"; "everyone" ] (`List []) base)
         "/channels/3: channel \"demo:happened\" declares no audience: add it \
          to audience.everyone, audience.scoped or audience.declared. There is \
          no default.");
    case "a crossing channel with no kind"
      (refuses
         (set [ "kind"; "event" ] (`List []) base)
         "/channels/3: channel \"demo:happened\" declares no kind: add it to \
          kind.command or kind.event, or to inProcess if it never crosses. \
          There is no default.");
    case "a channel in two audiences"
      (refuses
         (set [ "audience"; "scoped" ] (strings [ "demo:happened" ]) base)
         "/audience/scoped/0: \"demo:happened\" is declared both \
          audience.everyone and audience.scoped: a channel crosses exactly one \
          way");
    case "an in-process channel given an audience"
      (refuses
         (set [ "audience"; "declared" ] (strings [ "demo:internal" ]) base)
         "/inProcess/channels: \"demo:internal\" is declared inProcess and \
          given audience.declared: inProcess means it never crosses");
    case "an operation's channel given a kind"
      (refuses
         (append [ "kind"; "event" ] (`String "demo:limits-result") base)
         "/kind: \"demo:limits-result\" belongs to an operation, so its kind \
          is derived: remove it from kind.event");
    case "a command sent to everyone"
      (refuses
         (base
         |> append [ "channels" ] (carrying "demo:do-it" "DemoCommand")
         |> append [ "channelOrder"; "eventMap" ] (`String "demo:do-it")
         |> set [ "kind"; "command" ] (strings [ "demo:do-it" ])
         |> append [ "audience"; "everyone" ] (`String "demo:do-it")
         |> append [ "effect"; "writes" ] (`String "demo:do-it"))
         "/kind/command: \"demo:do-it\" is kind command with audience \
          everyone: a directive is not a broadcast");
    case "an axis naming an undeclared channel"
      (refuses
         (set [ "audience"; "declared" ] (strings [ "demo:typo" ]) base)
         "/audience/declared/0: names \"demo:typo\", which is not declared in \
          channels[]");
    case "a declaration of a channel the EventMap lacks"
      (refuses
         (set
            [ "channelOrder"; "eventMap" ]
            (strings
               [
                 "demo:limits-requested";
                 "demo:limits-result";
                 "demo:limits-failed";
                 "demo:happened";
               ])
            base)
         "/inProcess/channels: \"demo:internal\" is classified but not in \
          channelOrder.eventMap");
    case "an emittable channel with no effect"
      (refuses
         (set [ "effect"; "writes" ] (`List []) base)
         "/effect: emittable channel \"demo:limits-requested\" declares no \
          effect: add it to effect.writes or effect.reads. There is no \
          default.");
    case "a channel both written and read"
      (refuses
         (set [ "effect"; "reads" ] (strings [ "demo:limits-requested" ]) base)
         "/effect/reads/0: \"demo:limits-requested\" is declared both \
          effect.writes and effect.reads: an emit either changes the knowledge \
          base or it does not");
    case "an effect of a channel nobody emits"
      (refuses
         (set [ "effect"; "reads" ] (strings [ "demo:happened" ]) base)
         "/effect/reads/0: effect.reads names \"demo:happened\", which nobody \
          emits: the domain is an operation's request or a kind.command");
    case "a request that names no validate schema"
      (refuses
         (set [ "channels"; "0"; "validate" ] `Null base)
         "/operations/0/request: \"demo:limits-requested\" is an operation's \
          request and names no validate schema: /bus/emit could never accept \
          it, so Bus.request could never send it");
    case "a channel declared twice"
      (refuses
         (append [ "channels" ] (carrying "demo:happened" "DemoEvent") base)
         "/channels/5: channel \"demo:happened\" is declared more than once");
    case "a reply two operations share"
      (refuses
         (base
         |> append [ "channels" ] (carrying "demo:again" "DemoRequest")
         |> append [ "operations" ]
              (`Assoc
                 [
                   ("request", `String "demo:again");
                   ("result", `String "demo:limits-result");
                   ("failure", `String "demo:limits-failed");
                   ("docs", docs);
                 ]))
         "/operations/1/result: \"demo:limits-result\" is the result of both \
          demo:limits-requested and demo:again: a reply channel is one \
          operation's");
    case "a request that is a reply"
      (refuses
         (append [ "operations" ]
            (`Assoc
               [
                 ("request", `String "demo:limits-result");
                 ("result", `String "demo:happened");
                 ("failure", `String "demo:internal");
                 ("docs", docs);
               ])
            base)
         "/operations/1/request: \"demo:limits-result\" is both a request and \
          a reply");
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
              ("shape", `String "schema");
              ("schema", `String "DemoExtra");
              ("validate", `Null);
              ("tsRefinement", `String "DemoExtraRefined");
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
              ("tsRefinement", `String "DemoRefined");
            ];
          ]);
    case "a shape no language can type"
      (refuses
         (with_channel [ ("shape", `String "custom"); ("validate", `Null) ])
         "/channels/5/shape: \"custom\" is none of schema, envelope, \
          storedEvent, void, empty");
    case "a TypeScript type stated as a string"
      (refuses
         (with_channel
            [
              ("shape", `String "schema");
              ("schema", `String "DemoExtra");
              ("validate", `Null);
              ("ts", `String "components['schemas']['DemoExtra']");
            ])
         "/channels/5/ts: an unknown member");
    case "a schema shape that names no schema"
      (refuses
         (with_channel [ ("shape", `String "envelope"); ("validate", `Null) ])
         "/channels/5: lacks the member \"schema\"");
    case "a schema on a shape that carries none"
      (refuses
         (with_channel
            [
              ("shape", `String "void");
              ("schema", `String "DemoExtra");
              ("validate", `Null);
            ])
         "/channels/5/schema: an unknown member");
    case "a refinement with no schema to narrow"
      (refuses
         (with_channel
            [
              ("shape", `String "empty");
              ("validate", `Null);
              ("tsRefinement", `String "Whatever");
            ])
         "/channels/5/tsRefinement: an unknown member");
    case "a channel that carries one schema and validates against another"
      (refuses
         (with_channel
            [
              ("shape", `String "schema");
              ("schema", `String "DemoExtra");
              ("validate", `String "DemoOther");
            ])
         "/channels/5: \"demo:extra\" carries DemoExtra and validates against \
          DemoOther: one channel, one schema");
    case "a validate schema on a channel that carries none"
      (refuses
         (with_channel
            [ ("shape", `String "empty"); ("validate", `String "DemoExtra") ])
         "/channels/5/validate: expected null, found a string");
    case "a stored event on a channel not its own type"
      (refuses
         (with_channel
            [
              ("shape", `String "storedEvent");
              ("event", `String "demo:other");
              ("payload", `String "DemoPayload");
              ("validate", `Null);
            ])
         "/channels/5: \"demo:extra\" is a stored event named \"demo:other\": \
          a persisted event is published on the channel of its own type");
    case "a stored event that names no payload"
      (refuses
         (with_channel
            [
              ("shape", `String "storedEvent");
              ("event", `String "demo:extra");
              ("validate", `Null);
            ])
         "/channels/5: lacks the member \"payload\"");
    case "a payload on a channel that is no stored event"
      (refuses
         (with_channel
            [
              ("shape", `String "schema");
              ("schema", `String "DemoExtra");
              ("payload", `String "DemoExtra");
              ("validate", `Null);
            ])
         "/channels/5/payload: an unknown member");
    case "the system flag on a channel that is no stored event"
      (refuses
         (with_channel
            [
              ("shape", `String "empty");
              ("system", `Bool true);
              ("validate", `Null);
            ])
         "/channels/5/system: an unknown member");
    case "the system flag false"
      (refuses
         (with_channel
            [
              ("shape", `String "storedEvent");
              ("event", `String "demo:extra");
              ("payload", `String "DemoPayload");
              ("system", `Bool false);
              ("validate", `Null);
            ])
         "/channels/5/system: a flag is true, or absent");
    case "a scoped channel that is no stored event"
      (let scoped members =
         base
         |> append [ "channels" ] (channel "demo:scoped" members)
         |> append [ "kind"; "event" ] (`String "demo:scoped")
         |> set [ "audience"; "scoped" ] (strings [ "demo:scoped" ])
       in
       fun () ->
         accepts
           (scoped
              [
                ("shape", `String "storedEvent");
                ("event", `String "demo:scoped");
                ("payload", `String "DemoScopedPayload");
                ("validate", `Null);
              ])
           ();
         refuses
           (scoped
              [
                ("shape", `String "schema");
                ("schema", `String "DemoScoped");
                ("validate", `Null);
              ])
           "/channels/5: \"demo:scoped\" has audience scoped and is no stored \
            event: a resource's scope carries the events of its record"
           ());
  ]

let trace =
  [
    case "a trace with no field"
      (refuses
         (set [ "trace" ] (`Assoc [ ("meaning", `String "m") ]) base)
         "/trace: lacks the member \"field\"");
    case "a field whose name does not begin with _"
      (refuses
         (set [ "trace"; "field" ] (`String "carried") base)
         "/trace/field: is \"carried\": it is a payload field the bus writes, \
          so a name that begins with \"_\" and a letter");
    case "a trace with no meaning"
      (refuses
         (set [ "trace"; "meaning" ] (`String "") base)
         "/trace/meaning: expected a non-empty string");
  ]

let with_schemas changes =
  changes
  @ List.filter (fun (n, _) -> not (List.mem_assoc n changes)) base_schemas

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
    case "a comment wrapped to its width" (fun () ->
        Alcotest.(check string)
          "comment" "// one two\n// three\n// fourfourfour"
          (Text.comment ~marker:"// " ~indent:"" ~width:12
             "one  two\nthree fourfourfour"));
    case "a no-break space joins its words" (fun () ->
        Alcotest.(check string)
          "comment" "// one\n// two\194\160three"
          (Text.comment ~marker:"// " ~indent:"" ~width:12
             "one two\194\160three"));
  ]

let output =
  [
    case "the drift gate" (fun () ->
        let root = Filename.temp_dir "groups" "" in
        let file path text = { Output.path; text } in
        let files =
          [
            file "a/same.txt" "same\n";
            file "a/differs.txt" "new\n";
            file "b/absent.txt" "x\n";
          ]
        in
        Output.write ~root
          [ file "a/same.txt" "same\n"; file "a/differs.txt" "old\n" ];
        Alcotest.(check (list string))
          "drifted"
          [ "a/differs.txt"; "b/absent.txt" ]
          (List.map
             (fun (f : Output.file) -> f.path)
             (Output.check ~root files));
        Output.write ~root files;
        Alcotest.(check (list string))
          "drifted after a write" []
          (List.map
             (fun (f : Output.file) -> f.path)
             (Output.check ~root files)));
  ]

let () =
  Alcotest.run "groups"
    [
      ("bus axes", axes);
      ("bus payloads", payloads);
      ("bus trace", trace);
      ("bus derivations", derivations);
      ("bus names", names);
      ("text", text);
      ("output", output);
    ]
