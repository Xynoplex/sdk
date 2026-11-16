(* Each way a file can fail the model is a refusal naming the file and the
   JSON Pointer of the value refused. *)

open Xynolog_codegen

let refusal decoder text =
  match Decode.run ~file:"x.json" (Yojson.Safe.from_string text) decoder with
  | Ok _ -> Alcotest.fail ("accepted " ^ text)
  | Error error -> Decode.error_to_string error

let refuses decoder text expected () =
  Alcotest.(check string) text expected (refusal decoder text)

let accepts decoder text () =
  match Decode.run ~file:"x.json" (Yojson.Safe.from_string text) decoder with
  | Ok _ -> ()
  | Error error -> Alcotest.fail (Decode.error_to_string error)

let schema = Schema.decode

let retry =
  {|{"$comment":"c","runBy":{"ocaml":["test"]},
     "rules":[{"why":"w","rule":"boot","status":503,"retries":true,"colour":"red"}],
     "retryAfter":[]}|}

let () =
  Alcotest.run "strict"
    [
      ( "schema",
        [
          Alcotest.test_case "a known schema" `Quick
            (accepts schema {|{"type":"string","minLength":1}|});
          Alcotest.test_case "an unknown keyword" `Quick
            (refuses schema {|{"type":"string","minLenght":1}|}
               "x.json: /minLenght: an unknown member");
          Alcotest.test_case "a wrong type" `Quick
            (refuses schema {|{"type":"string","minLength":"1"}|}
               "x.json: /minLength: expected an integer, found a string");
          Alcotest.test_case "a duplicate member" `Quick
            (refuses schema {|{"type":"string","type":"object"}|}
               "x.json: /type: a duplicate member");
          Alcotest.test_case "a type it does not know" `Quick
            (refuses schema {|{"type":"null"}|}
               {|x.json: /type: "null" is none of string, object, integer, array, boolean, number|});
          Alcotest.test_case "a nested place, escaped" `Quick
            (refuses schema {|{"properties":{"a/b~c":{"type":7}}}|}
               "x.json: /properties/a~1b~0c/type: expected a string, found an \
                integer");
        ] );
      ( "openapi",
        [
          Alcotest.test_case "a missing member" `Quick
            (refuses Openapi.path_item
               {|{"get":{"summary":"s","description":"d","security":[],"responses":{}}}|}
               {|x.json: /get: lacks the member "operationId"|});
          Alcotest.test_case "a path item with no operation" `Quick
            (refuses Openapi.path_item {|{}|}
               "x.json: /: a path item with no operation");
        ] );
      ( "table",
        [
          Alcotest.test_case "an unknown member of a case" `Quick
            (refuses Tables.Retry_cases.decode retry
               "x.json: /rules/0/colour: an unknown member");
          Alcotest.test_case "a case of a kind the table has none of" `Quick
            (refuses Tables.Retry_cases.decode
               {|{"$comment":"c","runBy":{"ocaml":["t"]},
                  "rules":[{"why":"w","rule":"dawn","retries":true}],"retryAfter":[]}|}
               {|x.json: /rules/0/rule: "dawn" is none of boot, job, transport, refresh|});
          Alcotest.test_case "a runner with no test" `Quick
            (refuses Tables.Retry_cases.decode
               {|{"$comment":"c","runBy":{"ocaml":[]},"rules":[],"retryAfter":[]}|}
               "x.json: /runBy/ocaml: expected a non-empty array");
          Alcotest.test_case "a missing envelope" `Quick
            (refuses Tables.Retry_cases.decode
               {|{"runBy":{"ocaml":["t"]},"rules":[],"retryAfter":[]}|}
               {|x.json: /: lacks the member "$comment"|});
        ] );
    ]
