open Xynolog_codegen
module Shape = Required.Shape
module Table = Cache_refresh.Table

let case name test = Alcotest.test_case name `Quick test
let file = "client/refresh.json"

(* ── The context: components, shapes, channels, operations and GETs ───── *)

let schema name text =
  let file = "components/schemas/" ^ name ^ ".json" in
  match Decode.run ~file (Yojson.Safe.from_string text) Schema.decode with
  | Ok (schema, _) -> (name, file, schema)
  | Error error -> Alcotest.fail (Decode.error_to_string error)

let components =
  [
    schema "Thing"
      {|{"type":"object","required":["items"],"properties":{
          "items":{"type":"array","items":{"$ref":"./Item.json"}},
          "inner":{"$ref":"./Inner.json"},
          "label":{"type":"string"},
          "count":{"type":"integer"},
          "loose":{"type":"object","properties":{"deep":{"type":"string"}}}}}|};
    schema "Inner"
      {|{"type":"object","required":["names"],"properties":{
          "names":{"type":"array","items":{"type":"string"}}}}|};
    schema "Item" {|{"type":"object"}|};
    schema "Both"
      {|{"type":"object","required":["a","b"],"properties":{
          "a":{"type":"string"},"b":{"type":"string"}}}|};
  ]

let object_of members = Shape.Shape { Shape.empty with members }

let shapes =
  [
    ( "Event",
      object_of
        [
          ("resourceId", Shape.Ref "ResourceId");
          ("annotationId", Shape.Ref "AnnotationId");
          ("annotation", Shape.Ref "Annotation");
          ("payload", object_of []);
          ("plain", object_of []);
        ] );
    ("Annotation", object_of [ ("id", Shape.Ref "AnnotationId") ]);
    ("Payload", object_of [ ("annotationId", Shape.Ref "AnnotationId") ]);
    ("Wrapped", Shape.Shape { Shape.empty with all_of = [ Shape.Ref "Event" ] });
    ( "Restated",
      Shape.Shape
        {
          Shape.empty with
          all_of =
            [
              Shape.Ref "Event";
              object_of [ ("resourceId", Shape.Ref "AnnotationId") ];
            ];
        } );
  ]

let channel ?payload ?(enriched = false) ?(system = false) ?(scoped = false)
    ?(passing = false) ?(event = "Event") () =
  { Table.event = Shape.Ref event; payload; enriched; system; scoped; passing }

let context =
  {
    Table.requests = [ "demo:get-requested" ];
    reads = [ "GET /things" ];
    channels =
      [
        ( "demo:changed",
          channel ~payload:"Payload" ~enriched:true ~scoped:true () );
        ("demo:said", channel ~passing:true ());
        ("demo:system", channel ~payload:"Payload" ~system:true ~scoped:true ());
        ("demo:wrapped", channel ~event:"Wrapped" ());
        ("demo:restated", channel ~event:"Restated" ());
        ("bus:resume-gap", channel ~passing:true ());
      ];
    shapes;
    components;
  }

(* ── The table ─────────────────────────────────────────────────────────── *)

let thing = "../components/schemas/Thing.json"

let query ?per ?asks ?reads ?(persisted = false) ?(docs = "Docs.") ~value name =
  let member key value =
    Option.map (fun v -> Printf.sprintf "%S:%s" key (Text.quoted v)) value
  in
  "{"
  ^ String.concat ","
      (List.filter_map Fun.id
         [
           member "name" (Some name);
           member "per" per;
           member "asks" asks;
           member "reads" reads;
           (if persisted then Some {|"persisted":true|} else None);
           Some (Printf.sprintf {|"value":{"$ref":%s}|} (Text.quoted value));
           member "docs" (Some docs);
         ])
  ^ "}"

let names pairs =
  "{"
  ^ String.concat ","
      (List.map (fun (k, v) -> Printf.sprintf "%S:%s" k (Text.quoted v)) pairs)
  ^ "}"

let row ?when_ ?reach ?names ?carries ?refetches ?writes ?removes
    ?(docs = "Docs.") on =
  let string key value =
    Option.map (fun v -> Printf.sprintf "%S:%s" key (Text.quoted v)) value
  in
  let list key value =
    Option.map
      (fun vs ->
        Printf.sprintf "%S:[%s]" key
          (String.concat "," (List.map Text.quoted vs)))
      value
  in
  "{"
  ^ String.concat ","
      (List.filter_map Fun.id
         [
           string "on" (Some on);
           string "when" when_;
           string "reach" reach;
           Option.map (Printf.sprintf {|"names":%s|}) names;
           string "carries" carries;
           list "refetches" refetches;
           list "writes" writes;
           list "removes" removes;
           string "docs" (Some docs);
         ])
  ^ "}"

let queries =
  [
    query "thing" ~per:"resource" ~asks:"demo:get-requested" ~persisted:true
      ~value:thing ~docs:"A thing.";
    query "items" ~per:"resource" ~reads:"GET /things"
      ~value:(thing ^ "#/properties/items")
      ~docs:"Its items.";
    query "names" ~asks:"demo:get-requested"
      ~value:(thing ^ "#/properties/inner/properties/names")
      ~docs:"Names.";
  ]

let reopened = row "reopened" ~reach:"held" ~refetches:[ "thing"; "names" ]

let unreadable =
  row "unreadable" ~reach:"held" ~refetches:[ "thing"; "items"; "names" ]

let enriched =
  row "demo:changed" ~when_:"enriched"
    ~names:
      (names [ ("resource", "resourceId"); ("annotation", "annotation.id") ])
    ~carries:"annotation" ~writes:[ "items" ] ~refetches:[ "thing" ]
    ~docs:"It changed, and says how."

let unenriched =
  row "demo:changed" ~when_:"unenriched"
    ~names:
      (names
         [ ("resource", "resourceId"); ("annotation", "payload.annotationId") ])
    ~refetches:[ "items"; "thing" ] ~docs:"It changed."

let said = row "demo:said" ~refetches:[ "names" ] ~docs:"Something was said."
let rows = [ reopened; unreadable; enriched; unenriched; said ]

let table ?(queries = queries) rows =
  Printf.sprintf {|{"$comment":"c","queries":[%s],"refresh":[%s]}|}
    (String.concat "," queries)
    (String.concat "," rows)

let decode text =
  Decode.run ~file (Yojson.Safe.from_string text) Tables.Client_refresh.decode

let model text =
  match decode text with
  | Ok (t, _) -> t
  | Error error -> Alcotest.fail (Decode.error_to_string error)

let derive text = Table.derive context (model text)

let derived text =
  match derive text with
  | Ok t -> t
  | Error errors ->
      Alcotest.fail
        (String.concat "\n" (List.map Decode.error_to_string errors))

let refuses text expected () =
  match derive text with
  | Ok _ ->
      Alcotest.failf "expected the refusals\n  %s\nand none came"
        (String.concat "\n  " expected)
  | Error errors ->
      Alcotest.(check (list string))
        "refusals"
        (List.map (fun e -> file ^ ": " ^ e) expected)
        (List.map Decode.error_to_string errors)

let model_refuses text expected () =
  match decode text with
  | Ok _ -> Alcotest.failf "expected the refusal\n  %s\nand none came" expected
  | Error error ->
      Alcotest.(check string)
        "refusal"
        (file ^ ": " ^ expected)
        (Decode.error_to_string error)

let the_model =
  [
    case "no queries are refused"
      (model_refuses (table ~queries:[] rows)
         "/queries: expected a non-empty array");
    case "no rows are refused"
      (model_refuses (table []) "/refresh: expected a non-empty array");
    case "a query with empty docs is refused"
      (model_refuses
         (table
            ~queries:
              [ query "thing" ~asks:"demo:get-requested" ~value:thing ~docs:"" ]
            rows)
         "/queries/0/docs: expected a non-empty string");
    case "a query that asks and reads is refused"
      (model_refuses
         (table
            ~queries:
              [
                query "thing" ~asks:"demo:get-requested" ~reads:"GET /things"
                  ~value:thing;
              ]
            rows)
         "/queries/0: asks an operation and reads a GET: a query does one");
    case "a query that neither asks nor reads is refused"
      (model_refuses
         (table ~queries:[ query "thing" ~value:thing ] rows)
         "/queries/0: neither asks an operation nor reads a GET: a query does \
          one");
    case "a query kept per what is not a key is refused"
      (model_refuses
         (table
            ~queries:
              [
                query "thing" ~per:"session" ~asks:"demo:get-requested"
                  ~value:thing;
              ]
            rows)
         "/queries/0/per: \"session\" is none of resource, annotation, filters");
    case "a query persisted false is refused"
      (model_refuses
         (table
            ~queries:
              [
                {|{"name":"thing","asks":"demo:get-requested","persisted":false,"value":{"$ref":"../components/schemas/Thing.json"},"docs":"D."}|};
              ]
            rows)
         "/queries/0/persisted: is false: a query not persisted states no \
          persisted");
    case "a query with no value is refused"
      (model_refuses
         (table
            ~queries:
              [ {|{"name":"thing","asks":"demo:get-requested","docs":"D."}|} ]
            rows)
         "/queries/0: lacks the member \"value\"");
    case "a value beside its $ref is refused"
      (model_refuses
         (table
            ~queries:
              [
                {|{"name":"thing","asks":"demo:get-requested","value":{"$ref":"../components/schemas/Thing.json","type":"object"},"docs":"D."}|};
              ]
            rows)
         "/queries/0/value/type: an unknown member");
    case "a query that states what a query does not have is refused"
      (model_refuses
         (table
            ~queries:
              [
                {|{"name":"thing","asks":"demo:get-requested","value":{"$ref":"../components/schemas/Thing.json"},"docs":"D.","kept":true}|};
              ]
            rows)
         "/queries/0/kept: an unknown member");
    case "a row that states what a row does not have is refused"
      (model_refuses
         (table
            [
              {|{"on":"reopened","reach":"held","refetches":["thing"],"docs":"D.","invalidates":["thing"]}|};
            ])
         "/refresh/0/invalidates: an unknown member");
    case "a row with empty docs is refused"
      (model_refuses
         (table
            [ row "reopened" ~reach:"held" ~refetches:[ "thing" ] ~docs:"" ])
         "/refresh/0/docs: expected a non-empty string");
    case "a reach that is neither is refused"
      (model_refuses
         (table [ row "reopened" ~reach:"all" ~refetches:[ "thing" ] ])
         "/refresh/0/reach: \"all\" is none of subject, held");
    case "a split that is neither is refused"
      (model_refuses
         (table
            [ row "demo:changed" ~when_:"sometimes" ~refetches:[ "thing" ] ])
         "/refresh/0/when: \"sometimes\" is none of enriched, unenriched");
    case "an empty act is refused"
      (model_refuses
         (table [ row "reopened" ~reach:"held" ~refetches:[] ])
         "/refresh/0/refetches: expected a non-empty array");
    case "a name of no slot is refused"
      (model_refuses
         (table
            [
              row "demo:changed"
                ~names:(names [ ("carries", "annotation") ])
                ~refetches:[ "thing" ];
            ])
         "/refresh/0/names/carries: an unknown member");
  ]

(* ── What the table derives ────────────────────────────────────────────── *)

let rec value_type : Table.value_type -> string = function
  | Component name -> name
  | List t -> "[" ^ value_type t ^ "]"
  | Text -> "text"

let per : Tables.Client_refresh.per option -> string = function
  | Some Resource -> "resource"
  | Some Annotation -> "annotation"
  | Some Filters -> "filters"
  | None -> "whole"

let way = function None -> "-" | Some names -> String.concat "." names

let row_summary (r : Table.row) =
  String.concat " "
    [
      (match r.when_ with
      | Some Enriched -> "enriched"
      | Some Unenriched -> "unenriched"
      | None -> "-");
      (match r.reach with Subject -> "subject" | Held -> "held");
      way r.resource;
      way r.annotation;
      way r.carries;
      String.concat "," r.refetches;
      String.concat "," r.writes;
      String.concat "," r.removes;
    ]

let trigger_summary (t : Table.trigger) =
  ( t.on,
    (match t.kind with
    | Reopened -> "reopened"
    | Unreadable -> "unreadable"
    | Channel { scoped = true } -> "scoped channel"
    | Channel { scoped = false } -> "channel"),
    t.docs,
    List.map row_summary t.rows )

(* The rows of a table whose one query is [thing]. *)
let alone =
  [
    row "reopened" ~reach:"held" ~refetches:[ "thing" ];
    row "unreadable" ~reach:"held" ~refetches:[ "thing" ];
  ]

let query_value ?per:(p = "resource") ?(persisted = false) member =
  table
    ~queries:
      [
        query "thing" ~per:p ~asks:"demo:get-requested" ~persisted
          ~value:(thing ^ member);
      ]
    alone

let values_of member =
  match (derived (query_value member)).queries with
  | [ q ] -> (q.value.component, q.value.members, value_type q.value.type_)
  | _ -> Alcotest.fail "one query"

let values =
  [
    case "each query, its key, whether it is kept, and its value" (fun () ->
        Alcotest.(check (list (pair string (pair string (pair bool string)))))
          "queries"
          [
            ("thing", ("resource", (true, "Thing  Thing")));
            ("items", ("resource", (false, "Thing items [Item]")));
            ("names", ("whole", (false, "Thing inner.names [text]")));
          ]
          (List.map
             (fun (q : Table.query) ->
               ( q.name,
                 ( per q.per,
                   ( q.persisted,
                     String.concat " "
                       [
                         q.value.component;
                         String.concat "." q.value.members;
                         value_type q.value.type_;
                       ] ) ) ))
             (derived (table rows)).queries));
    case "a value within an inline member" (fun () ->
        Alcotest.(check (triple string (list string) string))
          "value"
          ("Thing", [ "loose"; "deep" ], "text")
          (values_of "#/properties/loose/properties/deep"));
    case "a value that is text" (fun () ->
        Alcotest.(check (triple string (list string) string))
          "value"
          ("Thing", [ "label" ], "text")
          (values_of "#/properties/label"));
    case "a value that names no component is refused"
      (refuses
         (table
            ~queries:
              [
                query "thing" ~asks:"demo:get-requested"
                  ~value:"../components/schemas/Other.json";
              ]
            alone)
         [
           "/queries/0/value/$ref: names ../components/schemas/Other.json, \
            which is no component";
         ]);
    case "a value that is not named member by member is refused"
      (refuses (query_value "#/items")
         [
           "/queries/0/value/$ref: names \
            ../components/schemas/Thing.json#/items, which is neither a \
            component nor a member within one, named member by member \
            (#/properties/...)";
         ]);
    case "a value that names a member not there is refused"
      (refuses
         (query_value "#/properties/nope")
         [
           "/queries/0/value/$ref: names \
            ../components/schemas/Thing.json#/properties/nope, and Thing has \
            no member nope";
         ]);
    case "a value that steps through what is not a member is refused"
      (refuses
         (query_value "#/definitions/items")
         [
           "/queries/0/value/$ref: names \
            ../components/schemas/Thing.json#/definitions/items, which is \
            neither a component nor a member within one, named member by \
            member (#/properties/...)";
         ]);
    case
      "a value that names a member not within a component a member refers to \
       is refused"
      (refuses
         (query_value "#/properties/inner/properties/nope")
         [
           "/queries/0/value/$ref: names \
            ../components/schemas/Thing.json#/properties/inner/properties/nope, \
            and Inner has no member nope";
         ]);
    case "a persisted value that is one of what its holder requires is refused"
      (refuses
         (table
            ~queries:
              [
                query "thing" ~asks:"demo:get-requested" ~persisted:true
                  ~value:"../components/schemas/Both.json#/properties/a";
              ]
            alone)
         [
           "/queries/0/value/$ref: names \
            ../components/schemas/Both.json#/properties/a, and Both requires \
            a, b: a persisted query's value is a member only where it is all \
            its holder requires";
         ]);
    case "a value that names a member not within an inline one is refused"
      (refuses
         (query_value "#/properties/loose/properties/nope")
         [
           "/queries/0/value/$ref: names \
            ../components/schemas/Thing.json#/properties/loose/properties/nope, \
            and Thing.loose has no member nope";
         ]);
    case "a value of no type the writers write is refused"
      (refuses
         (query_value "#/properties/count")
         [
           "/queries/0/value/$ref: names \
            ../components/schemas/Thing.json#/properties/count, which is of no \
            type the writers write: a component, a list of one, or text";
         ]);
    case "a persisted value that is all its holder requires" (fun () ->
        ignore (derived (query_value ~persisted:true "#/properties/items")));
    case "a persisted value that is not all its holder requires is refused"
      (refuses
         (query_value ~persisted:true "#/properties/inner/properties/names")
         [
           "/queries/0/value/$ref: names \
            ../components/schemas/Thing.json#/properties/inner/properties/names, \
            and Thing requires items: a persisted query's value is a member \
            only where it is all its holder requires";
         ]);
    case "a persisted value within what requires nothing is refused"
      (refuses
         (query_value ~persisted:true "#/properties/loose/properties/deep")
         [
           "/queries/0/value/$ref: names \
            ../components/schemas/Thing.json#/properties/loose/properties/deep, \
            and Thing requires items: a persisted query's value is a member \
            only where it is all its holder requires";
           "/queries/0/value/$ref: names \
            ../components/schemas/Thing.json#/properties/loose/properties/deep, \
            and Thing.loose requires nothing: a persisted query's value is a \
            member only where it is all its holder requires";
         ]);
    case "a persisted query per filters is refused"
      (refuses
         (query_value ~per:"filters" ~persisted:true "")
         [
           "/queries/0/persisted: is true of a query per filters, which is not \
            kept";
         ]);
  ]

let the_queries =
  [
    case "a name that is not camel case is refused"
      (refuses
         (table
            ~queries:[ query "Thing" ~asks:"demo:get-requested" ~value:thing ]
            [
              row "reopened" ~reach:"held" ~refetches:[ "Thing" ];
              row "unreadable" ~reach:"held" ~refetches:[ "Thing" ];
            ])
         [
           "/queries/0/name: is \"Thing\", which is not a query's name: a \
            lower-case letter, then letters";
         ]);
    case "a name with a digit is refused"
      (refuses
         (table
            ~queries:[ query "thing2" ~asks:"demo:get-requested" ~value:thing ]
            [
              row "reopened" ~reach:"held" ~refetches:[ "thing2" ];
              row "unreadable" ~reach:"held" ~refetches:[ "thing2" ];
            ])
         [
           "/queries/0/name: is \"thing2\", which is not a query's name: a \
            lower-case letter, then letters";
         ]);
    case "a query stated twice is refused"
      (refuses
         (table ~queries:(queries @ [ List.nth queries 1 ]) rows)
         [ "/queries/3/name: is items, which /queries/1 states already" ]);
    case "a query that asks what is no operation is refused"
      (refuses
         (table ~queries:[ query "thing" ~asks:"demo:nope" ~value:thing ] alone)
         [
           "/queries/0/asks: is \"demo:nope\", which is no operation of the \
            registry";
         ]);
    case "a query that reads what is no GET is refused"
      (refuses
         (table
            ~queries:[ query "thing" ~reads:"POST /things" ~value:thing ]
            alone)
         [
           "/queries/0/reads: is \"POST /things\", which is no GET of the \
            gateway's API";
         ]);
  ]

let the_rows =
  [
    case "each trigger, in the order first stated, with its rows" (fun () ->
        Alcotest.(
          check (list (pair string (pair string (pair string (list string))))))
          "triggers"
          [
            ( "reopened",
              ("reopened", ("Docs.", [ "- held - - - thing,names  " ])) );
            ( "unreadable",
              ("unreadable", ("Docs.", [ "- held - - - thing,items,names  " ]))
            );
            ( "demo:changed",
              ( "scoped channel",
                ( "enriched: It changed, and says how. unenriched: It changed.",
                  [
                    "enriched subject resourceId annotation.id annotation \
                     thing items ";
                    "unenriched subject resourceId payload.annotationId - \
                     items,thing  ";
                  ] ) ) );
            ( "demo:said",
              ("channel", ("Something was said.", [ "- subject - - - names  " ]))
            );
          ]
          (List.map
             (fun t ->
               let on, kind, docs, rows = trigger_summary t in
               (on, (kind, (docs, rows))))
             (derived (table rows)).triggers));
    case
      "a trigger that is neither a channel nor reopened nor unreadable is \
       refused"
      (refuses
         (table (rows @ [ row "demo:nope" ~refetches:[ "thing" ] ]))
         [
           "/refresh/5/on: is \"demo:nope\", which is neither a channel of the \
            registry nor reopened nor unreadable";
         ]);
    case "a trigger that is no event, reaching its subject, is refused"
      (refuses
         (table
            [ row "reopened" ~refetches:[ "thing"; "names" ]; unreadable; said ])
         [
           "/refresh/0: is on reopened, which is no event: it names no subject \
            and reaches what is held";
         ]);
    case "a trigger that is no event, naming a subject, is refused"
      (refuses
         (table
            [
              row "reopened" ~reach:"held"
                ~names:(names [ ("resource", "resourceId") ])
                ~refetches:[ "thing"; "names" ];
              unreadable;
              said;
            ])
         [
           "/refresh/0/names: is on reopened, which is no event, so it names \
            no subject";
         ]);
    case "a trigger that is no event, carrying a value, is refused"
      (refuses
         (table
            [
              row "unreadable" ~reach:"held" ~carries:"annotation"
                ~writes:[ "items" ];
              reopened;
            ])
         [
           "/refresh/0/carries: is on unreadable, which is no event, so it \
            carries no value";
         ]);
    case "a row that names a subject and reaches what is held is refused"
      (refuses
         (table
            (rows
            @ [
                row "demo:wrapped" ~reach:"held"
                  ~names:(names [ ("resource", "resourceId") ])
                  ~refetches:[ "thing" ];
              ]))
         [
           "/refresh/5/names: names a subject, on a row that reaches what is \
            held";
         ]);
    case "a way through allOf" (fun () ->
        ignore
          (derived
             (table
                (rows
                @ [
                    row "demo:wrapped"
                      ~names:(names [ ("resource", "resourceId") ])
                      ~refetches:[ "thing" ];
                  ]))));
    case "a way through a member two parts state differently is refused"
      (refuses
         (table
            (rows
            @ [
                row "demo:restated"
                  ~names:(names [ ("resource", "resourceId") ])
                  ~refetches:[ "thing" ];
              ]))
         [
           "/refresh/5/names/resource: is resourceId, which ends at no \
            component, not at ResourceId";
         ]);
    case "a way that is no way is refused"
      (refuses
         (table
            (rows
            @ [
                row "demo:wrapped"
                  ~names:(names [ ("resource", "payload..id") ])
                  ~refetches:[ "thing" ];
              ]))
         [
           "/refresh/5/names/resource: is \"payload..id\", which is no way to \
            a member: the names of the members it is within and its own, \
            joined by dots";
         ]);
    case "a way that begins with a digit is refused"
      (refuses
         (table
            (rows
            @ [
                row "demo:wrapped"
                  ~names:(names [ ("resource", "1d") ])
                  ~refetches:[ "thing" ];
              ]))
         [
           "/refresh/5/names/resource: is \"1d\", which is no way to a member: \
            the names of the members it is within and its own, joined by dots";
         ]);
    case "a way to no member of the event is refused"
      (refuses
         (table
            (rows
            @ [
                row "demo:wrapped"
                  ~names:(names [ ("resource", "resource_id") ])
                  ~refetches:[ "thing" ];
              ]))
         [
           "/refresh/5/names/resource: is resource_id, and demo:wrapped's \
            event has no member resource_id";
         ]);
    case
      "a way into a channel's payload, which only a recorded event names, is \
       refused"
      (refuses
         (table
            (rows
            @ [
                row "demo:wrapped"
                  ~names:(names [ ("annotation", "payload.annotationId") ])
                  ~refetches:[ "thing" ];
              ]))
         [
           "/refresh/5/names/annotation: is payload.annotationId, and payload \
            has no member annotationId";
         ]);
    case "a way that ends at another component than its slot's is refused"
      (refuses
         (table
            (rows
            @ [
                row "demo:wrapped"
                  ~names:(names [ ("resource", "annotationId") ])
                  ~refetches:[ "thing" ];
              ]))
         [
           "/refresh/5/names/resource: is annotationId, which ends at \
            AnnotationId, not at ResourceId";
         ]);
    case "a way into the payload of what is not the event is refused"
      (refuses
         (table
            (rows
            @ [
                row "demo:system"
                  ~names:
                    (names [ ("annotation", "plain.payload.annotationId") ])
                  ~refetches:[ "thing" ];
              ]))
         [
           "/refresh/5/names/annotation: is plain.payload.annotationId, and \
            plain has no member payload";
         ]);
    case "a way that ends at no component is refused"
      (refuses
         (table
            (rows
            @ [
                row "demo:wrapped"
                  ~names:(names [ ("annotation", "plain") ])
                  ~refetches:[ "thing" ];
              ]))
         [
           "/refresh/5/names/annotation: is plain, which ends at no component, \
            not at AnnotationId";
         ]);
    case "a resource named by an event of no resource is refused"
      (refuses
         (table
            (rows
            @ [
                row "demo:system"
                  ~names:(names [ ("resource", "resourceId") ])
                  ~refetches:[ "thing" ];
              ]))
         [
           "/refresh/5/names/resource: names a resource, and the registry says \
            demo:system's events are the knowledge base's, of no resource";
         ]);
    case "a carried value that is no Annotation is refused"
      (refuses
         (table
            (rows
            @ [ row "demo:wrapped" ~carries:"resourceId" ~writes:[ "thing" ] ]))
         [
           "/refresh/5/carries: is resourceId, which ends at ResourceId, not \
            at Annotation";
         ]);
    case "a carried value with no write is refused"
      (refuses
         (table
            (rows
            @ [
                row "demo:wrapped" ~carries:"annotation" ~refetches:[ "thing" ];
              ]))
         [
           "/refresh/5: writes what its event carries, so it states both \
            writes and carries, or neither";
         ]);
    case "a write with nothing carried is refused"
      (refuses
         (table (rows @ [ row "demo:wrapped" ~writes:[ "thing" ] ]))
         [
           "/refresh/5: writes what its event carries, so it states both \
            writes and carries, or neither";
         ]);
    case "an enriched row that carries nothing is refused"
      (refuses
         (table
            [
              reopened;
              unreadable;
              row "demo:changed" ~when_:"enriched" ~refetches:[ "thing" ];
              unenriched;
              said;
            ])
         [
           "/refresh/2/when: is enriched, so it carries the value that makes \
            it so";
         ]);
    case "an unenriched row that carries a value is refused"
      (refuses
         (table
            [
              reopened;
              unreadable;
              enriched;
              row "demo:changed" ~when_:"unenriched" ~carries:"annotation"
                ~writes:[ "items" ];
              said;
            ])
         [ "/refresh/3/when: is unenriched, so it carries nothing" ]);
    case "a split the registry does not say is enriched is refused"
      (refuses
         (table
            (rows
            @ [
                row "demo:wrapped" ~when_:"unenriched" ~refetches:[ "thing" ];
                row "demo:wrapped" ~when_:"enriched" ~carries:"annotation"
                  ~writes:[ "items" ];
              ]))
         [
           "/refresh/5/when: splits demo:wrapped, which the registry does not \
            say is enriched";
           "/refresh/6/when: splits demo:wrapped, which the registry does not \
            say is enriched";
         ]);
    case "a split with one row is refused"
      (refuses
         (table [ reopened; unreadable; unenriched; said ])
         [
           "/refresh/2: splits demo:changed, so it has a row for each of \
            enriched and unenriched and no other";
         ]);
    case "a split beside a row of no split is refused"
      (refuses
         (table (rows @ [ row "demo:changed" ~refetches:[ "thing" ] ]))
         [
           "/refresh/2: splits demo:changed, so it has a row for each of \
            enriched and unenriched and no other";
         ]);
    case "a row stated twice is refused"
      (refuses
         (table (rows @ [ said; enriched ]))
         [
           "/refresh/5: is on demo:said again, which /refresh/4 states already";
           "/refresh/6: is on demo:changed (enriched) again, which /refresh/2 \
            states already";
         ]);
    case "an act on what is no query is refused"
      (refuses
         (table (rows @ [ row "demo:wrapped" ~refetches:[ "thing"; "nope" ] ]))
         [ "/refresh/5/refetches/1: is nope, which is no query" ]);
    case "an act on a query the row acts on already is refused"
      (refuses
         (table
            (rows
            @ [ row "demo:wrapped" ~refetches:[ "thing" ] ~removes:[ "thing" ] ]
            ))
         [ "/refresh/5/removes/0: is thing, which the row acts on already" ]);
    case "a row that does nothing is refused"
      (refuses
         (table (rows @ [ row "demo:wrapped" ]))
         [
           "/refresh/5: does nothing: it refetches, writes or removes a query \
            at least";
         ]);
    case "a table with no row for reopened is refused"
      (refuses (table [ unreadable ]) [ "/refresh: has no row for reopened" ]);
    case "a table with no row for unreadable is refused"
      (refuses (table [ reopened ]) [ "/refresh: has no row for unreadable" ]);
    case "a passing trigger that writes is refused"
      (refuses
         (table
            (rows
            @ [ row "demo:said" ~carries:"annotation" ~writes:[ "items" ] ]))
         [
           "/refresh/5: is on demo:said again, which /refresh/4 states already";
           "/refresh/5/writes: writes items, and demo:said's frames are \
            passing: one lost must leave the cache right";
         ]);
    case "a passing trigger that removes is refused"
      (refuses
         (table
            [
              reopened;
              unreadable;
              enriched;
              unenriched;
              row "demo:said" ~removes:[ "names"; "thing" ];
            ])
         [
           "/refresh/4/removes: removes names, thing, and demo:said's frames \
            are passing: one lost must leave the cache right";
         ]);
    case "a passing trigger whose refetch reopened does not repair is refused"
      (refuses
         (table
            [
              reopened;
              unreadable;
              enriched;
              unenriched;
              row "demo:said" ~refetches:[ "items"; "names"; "thing" ];
            ])
         [
           "/refresh/4/refetches: refetches items, which nothing replays to a \
            client whose stream was down: reopened must refetch items too";
         ]);
    case
      "the stream's own gap, which cannot be missed, may refetch what reopened \
       does not" (fun () ->
        ignore
          (derived
             (table
                (rows
                @ [
                    row "bus:resume-gap"
                      ~names:(names [ ("resource", "resourceId") ])
                      ~refetches:[ "items" ];
                  ]))));
  ]

(* ── The writers ───────────────────────────────────────────────────────── *)

(* Docs whose wrap behind a query's lead changes at a column more or less:
   Go's 78 behind a tab and "// ", and Python's 96 behind four spaces and
   "# ". *)
let go_wrapped =
  "resource event remove stream gap scope gap value refetch stream annotation \
   cache value frame cache scope remove write stream subject cache xxxxxxxxx a \
   closes it."

let python_wrapped =
  "query event event key annotation held remove refetch query annotation frame \
   value resource client scope reply remove query cache key scope subject \
   value frame reply annotation held a closes it."

let written =
  derived
    (table
       ~queries:
         [
           query "thing" ~per:"resource" ~asks:"demo:get-requested"
             ~persisted:true ~value:thing ~docs:go_wrapped;
           query "items" ~per:"resource" ~reads:"GET /things"
             ~value:(thing ^ "#/properties/items")
             ~docs:python_wrapped;
           query "names" ~asks:"demo:get-requested"
             ~value:(thing ^ "#/properties/inner/properties/names")
             ~docs:"Names.";
           query "deep" ~per:"annotation" ~asks:"demo:get-requested"
             ~persisted:true
             ~value:(thing ^ "#/properties/items")
             ~docs:"Deep.";
           query "labels" ~per:"filters" ~asks:"demo:get-requested"
             ~value:(thing ^ "#/properties/loose/properties/deep")
             ~docs:"Labels.";
         ]
       [
         reopened;
         unreadable;
         enriched;
         row "demo:changed" ~when_:"unenriched"
           ~names:
             (names
                [
                  ("resource", "resourceId");
                  ("annotation", "payload.annotationId");
                ])
           ~refetches:[ "items"; "thing" ] ~removes:[ "names" ]
           ~docs:"It changed.";
         row "demo:said" ~refetches:[ "names" ] ~docs:"Something */ was said.";
       ])

let writes name (text : Table.t -> string) expected =
  case name (fun () -> Alcotest.(check string) name expected (text written))

let writers =
  [
    writes "Go's table" Cache_refresh.Go.text Cache_refresh_texts.go;
    writes "Python's table" Cache_refresh.Python.text Cache_refresh_texts.python;
    writes "TypeScript's table" Cache_refresh.Typescript.text
      Cache_refresh_texts.typescript;
    writes "Haskell's table" Cache_refresh.Haskell.text
      Cache_refresh_texts.haskell;
    writes "Haskell's live queries" Cache_refresh.Haskell.live_queries
      Cache_refresh_texts.live_queries;
  ]

let () =
  Alcotest.run "cache_refresh"
    [
      ("model", the_model);
      ("values", values);
      ("queries", the_queries);
      ("rows", the_rows);
      ("writers", writers);
    ]
