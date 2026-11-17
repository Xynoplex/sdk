open Xynolog_codegen

let case name test = Alcotest.test_case name `Quick test

let command_error =
  ( "CommandError",
    {|{"type":"object","properties":{"code":{"type":"string","enum":["a-code"]}}}|}
  )

let component (name, text) =
  let file = "components/schemas/" ^ name ^ ".json" in
  match Decode.run ~file (Yojson.Safe.from_string text) Schema.decode with
  | Ok (schema, _) -> (name, file, schema)
  | Error error -> failwith (Decode.error_to_string error)

let derived components =
  Required.Shape.derive ~unrecognized:"Unrecognized"
    (List.map component (command_error :: components))

let compact text = Yojson.Safe.to_string (Yojson.Safe.from_string text)

let shape_text ?(pairs = false) shape =
  Yojson.Safe.to_string (Required.Shape.to_json ~pairs shape)

(* The shape the derivation gives [name], among [components], as JSON. *)
let derives ?pairs components name expected () =
  match derived components with
  | Error errors ->
      Alcotest.failf "refused:\n  %s"
        (String.concat "\n  " (List.map Decode.error_to_string errors))
  | Ok derivation ->
      Alcotest.(check string)
        name (compact expected)
        (shape_text ?pairs (List.assoc name derivation.shapes))

let refuses components expected () =
  match derived components with
  | Ok _ -> Alcotest.failf "expected the refusal\n  %s\nand none came" expected
  | Error errors ->
      let found = List.map Decode.error_to_string errors in
      if not (List.mem expected found) then
        Alcotest.failf "expected the refusal\n  %s\nfound\n  %s" expected
          (String.concat "\n  " found)

let s = "components/schemas/S.json"
let string_component = ("Str", {|{"type":"string"}|})

let kinds =
  [
    case "a type is a kind"
      (derives [ ("S", {|{"type":"string"}|}) ] "S" {|{"kinds":["string"]}|});
    case "a number allows an integer"
      (derives
         [ ("S", {|{"type":["integer","number"]}|}) ]
         "S" {|{"kinds":["number"]}|});
    case "kinds in the table's order"
      (derives
         [ ("S", {|{"type":["boolean","array","string"]}|}) ]
         "S" {|{"kinds":["array","string","boolean"]}|});
    case "a schema that states nothing allows anything"
      (derives [ ("S", {|{"description":"anything"}|}) ] "S" {|{}|});
    case "an enum's values are its kinds"
      (derives
         [ ("S", {|{"enum":["a",1,true]}|}) ]
         "S" {|{"kinds":["string","integer","boolean"],"enum":["a",1,true]}|});
    case "properties make an object"
      (derives
         [ ("S", {|{"required":["a"]}|}) ]
         "S" {|{"kinds":["object"],"required":["a"]}|});
    case "items make an array"
      (derives
         [ ("S", {|{"items":{"type":"string"}}|}) ]
         "S" {|{"kinds":["array"],"items":{"kinds":["string"]}}|});
    case "allOf allows what each part allows"
      (derives
         [
           ("S", {|{"allOf":[{"type":["string","integer"]},{"type":"number"}]}|});
         ]
         "S"
         {|{"kinds":["integer"],"allOf":[{"kinds":["string","integer"]},{"kinds":["number"]}]}|});
    case "oneOf allows what any variant allows"
      (derives
         [ ("S", {|{"oneOf":[{"type":"string"},{"type":"boolean"}]}|}) ]
         "S"
         {|{"kinds":["string","boolean"],"oneOf":[{"kinds":["string"]},{"kinds":["boolean"]}]}|});
  ]

let nullable =
  [
    case "nullable beside a type allows null"
      (derives
         [ ("S", {|{"type":"string","nullable":true}|}) ]
         "S" {|{"kinds":["string","null"]}|});
    case "nullable around a reference is a union with null"
      (derives
         [
           string_component;
           ("S", {|{"nullable":true,"allOf":[{"$ref":"./Str.json"}]}|});
         ]
         "S"
         {|{"kinds":["string","null"],"oneOf":[{"kinds":["null"]},{"ref":"Str"}]}|});
    case "nullable false is refused"
      (refuses
         [ ("S", {|{"type":"string","nullable":false}|}) ]
         (s
        ^ ": /: states nullable false, which says nothing: a schema is \
           nullable, or says nothing of null"));
    case "an enum beside a nullable type is refused"
      (refuses
         [ ("S", {|{"type":"string","nullable":true,"enum":["a"]}|}) ]
         (s
        ^ ": /: states an enum beside a type that allows null, and an enum \
           states no null"));
  ]

let values =
  [
    case "a pattern's sets, escapes and quantifiers"
      (derives
         [
           ( "S",
             {|{"type":"string","pattern":"^[c-ea]\\d{2,}[^b]?x*\\.{1,3}y+$"}|}
           );
         ]
         "S"
         {|{"kinds":["string"],"pattern":[
             {"of":[[97,97],[99,101]],"min":1,"max":1},
             {"of":[[48,57]],"min":2},
             {"of":[[0,97],[99,1114111]],"min":0,"max":1},
             {"of":[[120,120]],"min":0},
             {"of":[[46,46]],"min":1,"max":3},
             {"of":[[121,121]],"min":1}]}|});
    case "dot and the white space escape"
      (derives
         [ ("S", {|{"type":"string","pattern":"^.\\s$"}|}) ]
         "S"
         {|{"kinds":["string"],"pattern":[
             {"of":[[0,9],[11,12],[14,8231],[8234,1114111]],"min":1,"max":1},
             {"of":[[9,13],[32,32],[160,160],[5760,5760],[8192,8202],[8232,8233],[8239,8239],[8287,8287],[12288,12288],[65279,65279]],"min":1,"max":1}]}|});
    case "a pattern with an alternative is refused"
      (refuses
         [ ("S", {|{"type":"string","pattern":"^(a|b)$"}|}) ]
         (s
        ^ ": /pattern: is ^(a|b)$, which is not a pattern the table can spell \
           out"));
    case "an unanchored pattern is refused"
      (refuses
         [ ("S", {|{"type":"string","pattern":"ab"}|}) ]
         (s
        ^ ": /pattern: is ab, which is not a pattern the table can spell out"));
    case "a backward range is refused"
      (refuses
         [ ("S", {|{"type":"string","pattern":"^[z-a]$"}|}) ]
         (s
        ^ ": /pattern: is ^[z-a]$, which is not a pattern the table can spell \
           out"));
    case "bounds and counts"
      (derives
         [
           ( "S",
             {|{"type":"object","properties":{
                 "n":{"type":"integer","minimum":1,"maximum":100},
                 "f":{"type":"number","minimum":0.5},
                 "t":{"type":"string","minLength":1,"maxLength":5},
                 "l":{"type":"array","minItems":1,"maxItems":3}}}|}
           );
         ]
         "S"
         {|{"kinds":["object"],"members":{
             "f":{"kinds":["number"],"minimum":0.5},
             "l":{"kinds":["array"],"minItems":1,"maxItems":3},
             "n":{"kinds":["integer"],"minimum":1,"maximum":100},
             "t":{"kinds":["string"],"minLength":1,"maxLength":5}}}|});
    case "a negative count is refused"
      (refuses
         [ ("S", {|{"type":"string","minLength":-1}|}) ]
         (s ^ ": /minLength: is -1, which is no count"));
  ]

let objects =
  [
    case "members by their code points, and only those that can be wrong"
      (derives
         [
           ( "S",
             {|{"type":"object","required":["b","a"],"properties":{
                 "é":{"type":"string"},"b":{"type":"string"},
                 "a":{"description":"anything"},"B":{"type":"boolean"}}}|}
           );
         ]
         "S"
         {|{"kinds":["object"],"required":["b","a"],"members":{
             "B":{"kinds":["boolean"]},"b":{"kinds":["string"]},
             "é":{"kinds":["string"]}}}|});
    case "members as pairs, for a reader whose objects keep no order"
      (derives ~pairs:true
         [
           ( "S",
             {|{"type":"object","properties":{"b":{"type":"string"},"a":{"type":"string"}}}|}
           );
         ]
         "S"
         {|{"kinds":["object"],"members":[["a",{"kinds":["string"]}],["b",{"kinds":["string"]}]]}|});
    case "closed to what it names"
      (derives
         [
           ( "S",
             {|{"type":"object","additionalProperties":false,"properties":{"b":{},"a":{}}}|}
           );
         ]
         "S" {|{"kinds":["object"],"closed":["a","b"]}|});
    case "closed to every member"
      (derives
         [ ("S", {|{"type":"object","maxProperties":0}|}) ]
         "S" {|{"kinds":["object"],"closed":[]}|});
    case "a maxProperties above zero is refused"
      (refuses
         [ ("S", {|{"type":"object","maxProperties":1}|}) ]
         (s
        ^ ": /maxProperties: is 1 beside 0 properties, and the table states \
           only an object that carries none"));
    case "a map's values"
      (derives
         [
           ("S", {|{"type":"object","additionalProperties":{"type":"integer"}}|});
         ]
         "S" {|{"kinds":["object"],"values":{"kinds":["integer"]}}|});
    case "a closed part of an allOf is refused"
      (refuses
         [
           ("Closed", {|{"type":"object","additionalProperties":false}|});
           ( "S",
             {|{"allOf":[{"$ref":"./Closed.json"},{"type":"object","required":["a"]}]}|}
           );
         ]
         (s
        ^ ": /allOf: has a closed part, which would refuse the other parts' \
           members"));
    case "an allOf of one schema is that schema"
      (derives
         [
           string_component;
           ("S", {|{"allOf":[{"$ref":"./Str.json"}],"description":"d"}|});
         ]
         "S" {|{"ref":"Str"}|});
  ]

let unions =
  [
    case "a discriminator's mapping by the variants' places"
      (derives
         [
           ("A", {|{"type":"object","required":["kind"]}|});
           ("B", {|{"type":"object","required":["kind"]}|});
           ( "S",
             {|{"oneOf":[{"$ref":"./A.json"},{"$ref":"./B.json"}],
                "discriminator":{"propertyName":"kind","mapping":{"b":"./B.json","a":"./A.json"}}}|}
           );
         ]
         "S"
         {|{"kinds":["object"],"oneOf":[{"ref":"A"},{"ref":"B"}],
            "discriminator":{"property":"kind","mapping":{"b":1,"a":0}}}|});
    case "a mapping to no variant is refused"
      (refuses
         [
           ("A", {|{"type":"object","required":["kind"]}|});
           ("B", {|{"type":"object","required":["kind"]}|});
           ( "S",
             {|{"oneOf":[{"$ref":"./A.json"}],
                "discriminator":{"propertyName":"kind","mapping":{"b":"./B.json"}}}|}
           );
         ]
         (s
        ^ ": /discriminator/mapping/b: maps \"b\" to ./B.json, which is none \
           of its variants"));
    case "a discriminator with no mapping is refused"
      (refuses
         [
           ("A", {|{"type":"object","required":["kind"]}|});
           ( "S",
             {|{"oneOf":[{"$ref":"./A.json"}],"discriminator":{"propertyName":"kind"}}|}
           );
         ]
         (s ^ ": /discriminator: states no mapping"));
    case "a discriminator beside no union is refused"
      (refuses
         [
           ( "S",
             {|{"type":"object","discriminator":{"propertyName":"kind","mapping":{}}}|}
           );
         ]
         (s ^ ": /discriminator: is beside no oneOf or anyOf"));
    case "oneOf beside anyOf is refused"
      (refuses
         [
           ("S", {|{"oneOf":[{"type":"string"}],"anyOf":[{"type":"string"}]}|});
         ]
         (s ^ ": /: states both oneOf and anyOf"));
    case "a component's union none of whose variants can be wrong is left out"
      (derives
         [ ("S", {|{"type":"object","anyOf":[{},{"description":"x"}]}|}) ]
         "S" {|{"kinds":["object"]}|});
    case "a member's union none of whose variants can be wrong is left out"
      (derives
         [
           ( "S",
             {|{"type":"object","properties":{"u":{"anyOf":[{},{"description":"x"}]}}}|}
           );
         ]
         "S" {|{"kinds":["object"]}|});
  ]

let references =
  [
    case "a component that can be wrong is referred to"
      (derives
         [
           string_component;
           ("S", {|{"type":"object","properties":{"a":{"$ref":"./Str.json"}}}|});
         ]
         "S" {|{"kinds":["object"],"members":{"a":{"ref":"Str"}}}|});
    case "components that refer only to each other can be wrong in no way"
      (derives
         [
           ("A", {|{"allOf":[{"$ref":"./B.json"},{"description":"x"}]}|});
           ("B", {|{"anyOf":[{"$ref":"./A.json"},{}]}|});
           ("S", {|{"type":"object","properties":{"a":{"$ref":"./A.json"}}}|});
         ]
         "S" {|{"kinds":["object"]}|});
    case "a reference to no component is refused"
      (refuses
         [ ("S", {|{"$ref":"./Missing.json"}|}) ]
         (s
        ^ ": /$ref: names ./Missing.json, which is no component of openapi.json"
         ));
    case "a reference into a component is refused"
      (refuses
         [ string_component; ("S", {|{"$ref":"./Str.json#/type"}|}) ]
         (s ^ ": /$ref: names ./Str.json#/type, a place within a component"));
    case "a keyword the table cannot state is refused"
      (refuses
         [ ("S", {|{"not":{"type":"string"}}|}) ]
         (s ^ ": /: states not, which the table does not know how to state"));
    case "a schema that allows nothing is refused"
      (refuses
         [ ("S", {|{"type":"array","items":false}|}) ]
         (s
        ^ ": /items: allows no value, which the table does not know how to \
           state"));
  ]

let command_errors =
  [
    case "CommandError's codes are recognized, and no enum"
      (derives [] "CommandError"
         {|{"kinds":["object"],"members":{"code":{"kinds":["string"],"recognized":["a-code"]}}}|});
    case "a CommandError that requires its code is refused" (fun () ->
        match
          Required.Shape.derive ~unrecognized:"Unrecognized"
            [
              component
                ( "CommandError",
                  {|{"type":"object","required":["code"],"properties":{"code":{"type":"string","enum":["a"]}}}|}
                );
            ]
        with
        | Ok _ -> Alcotest.fail "accepted"
        | Error errors ->
            Alcotest.(check (list string))
              "refusals"
              [
                "components/schemas/CommandError.json: /required: requires \
                 code, and codes.json reads a code its enum does not name as \
                 Unrecognized, as one that states none";
              ]
              (List.map Decode.error_to_string errors));
    case "a CommandError whose code names no list is refused" (fun () ->
        match
          Required.Shape.derive ~unrecognized:"Unrecognized"
            [
              component
                ( "CommandError",
                  {|{"type":"object","properties":{"code":{"type":"string"}}}|}
                );
            ]
        with
        | Ok _ -> Alcotest.fail "accepted"
        | Error errors ->
            Alcotest.(check (list string))
              "refusals"
              [
                "components/schemas/CommandError.json: /properties/code: is \
                 one of no enum, and codes.json reads a code the enum does not \
                 name as Unrecognized";
              ]
              (List.map Decode.error_to_string errors));
  ]

let json shape =
  Yojson.Safe.to_string (Required.Shape.to_json ~pairs:false shape)

let string_shape =
  Required.Shape.Shape { Required.Shape.empty with kinds = Some [ String ] }

let go =
  let declared =
    Required.Go.declared
      "package api\n\n\
       type A struct {\n\
       type B = string\n\
       type C = map[string]int\n\
       \ttype D = string\n\
       type (\n"
  in
  let check shapes =
    List.map Decode.error_to_string (Required.Go.check ~declared shapes)
  in
  [
    case "the types a Go file declares" (fun () ->
        Alcotest.(check (list (pair string (option string))))
          "declared"
          [ ("A", None); ("B", Some "string"); ("C", Some "map[string]int") ]
          declared);
    case "an alias read as the kind its schema states" (fun () ->
        Alcotest.(check (list string))
          "refusals" []
          (check
             [
               ("A", Required.Shape.Ref "B");
               ( "B",
                 Required.Shape.Shape
                   {
                     Required.Shape.empty with
                     kinds = Some [ String ];
                     enum = Some [ String_literal "x" ];
                   } );
               ( "C",
                 Required.Shape.Shape
                   { Required.Shape.empty with kinds = Some [ Object ] } );
             ]));
    case "an alias whose schema holds more is refused" (fun () ->
        Alcotest.(check (list string))
          "refusals"
          [
            "go/api/client_gen.go: /: writes C as an alias of map[string]int, \
             which is read as {\"kinds\":[\"object\"]}, and its schema \
             requires {\"kinds\":[\"object\"],\"closed\":[]} of it";
          ]
          (check
             [
               ( "C",
                 Required.Shape.Shape
                   {
                     Required.Shape.empty with
                     kinds = Some [ Object ];
                     closed = Some [];
                   } );
             ]));
    case "a component with no type is refused" (fun () ->
        Alcotest.(check (list string))
          "refusals"
          [
            "go/api/client_gen.go: /: declares no type E, and E is a component \
             of openapi.json";
          ]
          (check [ ("E", string_shape) ]));
  ]

let writers =
  [
    case "the JSON table, a schema to a line" (fun () ->
        Alcotest.(check string)
          "text"
          ("{\n  \"$comment\": "
          ^ Yojson.Safe.to_string (`String Required.Table.comment)
          ^ ",\n\
            \  \"schemas\": {\n\
            \    \"A\": {},\n\
            \    \"B\": {\"kinds\":[\"string\"]}\n\
            \  }\n\
             }\n")
          (Required.Table.text
             [
               ("A", Required.Shape.Shape Required.Shape.empty);
               ("B", string_shape);
             ]));
    case "an envelope holds only its response" (fun () ->
        let channel payload : Tables.Bus_registry.channel =
          let docs : Tables.Bus_registry.docs = { lead = []; trailing = "" } in
          { channel = "c"; payload; docs; schema_docs = docs }
        in
        Alcotest.(check (list (result string string)))
          "shapes"
          [
            Ok
              {|{"kinds":["object"],"required":["response"],"members":{"response":{"ref":"A"}},"closed":["response"]}|};
            Ok {|{"kinds":["object"],"closed":[]}|};
            Ok {|{"ref":"StoredEventResponse"}|};
            Error
              {|bus/registry.json: /channels: "c" carries Missing, which is no component|};
          ]
          (List.map
             (fun payload ->
               Result.map_error Decode.error_to_string
                 (Result.map json
                    (Required.Event.channel
                       ~known:(fun name -> name <> "Missing")
                       (channel payload))))
             [
               Tables.Bus_registry.Envelope { schema = "A" };
               Void;
               Stored_event
                 {
                   event = "e";
                   payload = "P";
                   enriched = false;
                   system = false;
                 };
               Schema { schema = "Missing"; validate = None };
             ]));
  ]

let () =
  Alcotest.run "required"
    [
      ("kinds", kinds);
      ("nullable", nullable);
      ("values", values);
      ("objects", objects);
      ("unions", unions);
      ("references", references);
      ("CommandError", command_errors);
      ("Go", go);
      ("writers", writers);
    ]
