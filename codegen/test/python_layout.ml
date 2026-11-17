(* Each expected text is what ruff format 0.17.4 wrote, at line-length 140,
   for a line of a generated file. *)

open Xynolog_codegen
module L = Python_layout

let case name test = Alcotest.test_case name `Quick test

let lays ?(indent = 0) ?(prefix = "") ?(suffix = "") expr expected () =
  Alcotest.(check string)
    "layout" expected
    (L.statement ~indent ~prefix ~suffix expr)

let atoms = List.map (fun a -> L.Atom a)
let strings = List.map (fun s -> L.Atom (Text.quoted s))

let channel name event payload =
  L.Call
    ( "RecordedChannel[" ^ event ^ ", " ^ payload ^ "]",
      [ L.Atom (Text.quoted name); L.Atom event; L.Atom payload ] )

let media_type media_type extension =
  L.Call
    ( "MediaType",
      [
        L.Keyword ("media_type", L.Atom (Text.quoted media_type));
        L.Keyword ("extension", L.Atom (Text.quoted extension));
        L.Keyword ("text_source", L.Atom {|"none"|});
        L.Keyword ("authorable", L.Atom "False");
        L.Keyword ("generatable", L.Atom "False");
      ] )

let refresh fields = L.Call ("CacheRefresh", fields)

let cases =
  [
    case "what fits is one line"
      (lays ~prefix:"YIELD_MOVED: Final = "
         (channel "yield:moved" "StoredEventResponse" "ResourceMovedPayload")
         {|YIELD_MOVED: Final = RecordedChannel[StoredEventResponse, ResourceMovedPayload]("yield:moved", StoredEventResponse, ResourceMovedPayload)|});
    case "a call too long has its arguments on a line of their own"
      (lays ~prefix:"YIELD_CREATED: Final = "
         (channel "yield:created" "StoredEventResponse" "ResourceCreatedPayload")
         {|YIELD_CREATED: Final = RecordedChannel[StoredEventResponse, ResourceCreatedPayload](
    "yield:created", StoredEventResponse, ResourceCreatedPayload
)|});
    case "arguments too long for their line are one a line, with a comma"
      (lays ~indent:4 ~suffix:","
         (media_type
            "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
            ".docx")
         {|    MediaType(
        media_type="application/vnd.openxmlformats-officedocument.wordprocessingml.document",
        extension=".docx",
        text_source="none",
        authorable=False,
        generatable=False,
    ),|});
    case "a tuple of one that fits is one line"
      (lays ~prefix:"METRICS: Final[tuple[MetricRow, ...]] = "
         (L.Tuple (atoms [ "XYNOLOG_BUS_SENT" ]))
         "METRICS: Final[tuple[MetricRow, ...]] = (XYNOLOG_BUS_SENT,)");
    case "a tuple of one in an entry that fits is one line"
      (lays ~indent:8 ~prefix:{|"mark:added": |} ~suffix:","
         (L.Tuple
            [
              refresh
                [
                  L.Keyword ("reach", L.Atom {|"subject"|});
                  L.Keyword
                    ("names_resource", L.Tuple (strings [ "resourceId" ]));
                  L.Keyword
                    ("refetches", L.Tuple (strings [ "annotations"; "events" ]));
                ];
            ])
         {|        "mark:added": (CacheRefresh(reach="subject", names_resource=("resourceId",), refetches=("annotations", "events")),),|});
    case "a tuple of one too long has its call on a line of its own"
      (lays ~indent:8 ~prefix:{|"bus:resume-gap": |} ~suffix:","
         (L.Tuple
            [
              refresh
                [
                  L.Keyword ("reach", L.Atom {|"subject"|});
                  L.Keyword ("names_resource", L.Tuple (strings [ "scope" ]));
                  L.Keyword
                    ( "refetches",
                      L.Tuple
                        (strings
                           [
                             "annotations";
                             "annotation";
                             "resource";
                             "events";
                             "referencedBy";
                           ]) );
                ];
            ])
         {|        "bus:resume-gap": (
            CacheRefresh(
                reach="subject", names_resource=("scope",), refetches=("annotations", "annotation", "resource", "events", "referencedBy")
            ),
        ),|});
    case "what is too long at each depth is one a line at each"
      (lays ~indent:8 ~prefix:{|"unreadable": |} ~suffix:","
         (L.Tuple
            [
              refresh
                [
                  L.Keyword ("reach", L.Atom {|"held"|});
                  L.Keyword
                    ( "refetches",
                      L.Tuple
                        (strings
                           [
                             "resource";
                             "annotations";
                             "annotation";
                             "events";
                             "referencedBy";
                             "resources";
                             "matchedResources";
                             "entityTypes";
                             "tagSchemas";
                             "engines";
                           ]) );
                ];
            ])
         {|        "unreadable": (
            CacheRefresh(
                reach="held",
                refetches=(
                    "resource",
                    "annotations",
                    "annotation",
                    "events",
                    "referencedBy",
                    "resources",
                    "matchedResources",
                    "entityTypes",
                    "tagSchemas",
                    "engines",
                ),
            ),
        ),|});
    case "rows are one a line, though they fit"
      (lays ~indent:8 ~prefix:{|"demo:split": |} ~suffix:","
         (L.Rows
            [
              refresh [ L.Keyword ("when", L.Atom {|"enriched"|}) ];
              refresh [ L.Keyword ("when", L.Atom {|"unenriched"|}) ];
            ])
         {|        "demo:split": (
            CacheRefresh(when="enriched"),
            CacheRefresh(when="unenriched"),
        ),|});
    case "a row too long within rows is laid out as its own line"
      (lays ~indent:4 ~prefix:"X = "
         (L.Rows
            [
              media_type
                "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
                ".docx";
              L.Atom "Y";
            ])
         {|    X = (
        MediaType(
            media_type="application/vnd.openxmlformats-officedocument.wordprocessingml.document",
            extension=".docx",
            text_source="none",
            authorable=False,
            generatable=False,
        ),
        Y,
    )|});
    case "an empty call and an empty tuple"
      (lays ~prefix:"X = "
         (L.Call ("f", [ L.Call ("g", []); L.Tuple [] ]))
         "X = f(g(), ())");
    case "a line exactly as wide as the limit is one line"
      (lays
         (L.Call ("f", [ L.Atom (String.make (140 - 3) 'x') ]))
         ("f(" ^ String.make 137 'x' ^ ")"));
    case "a line one wider than the limit is split"
      (lays
         (L.Call ("f", [ L.Atom (String.make (140 - 2) 'x') ]))
         ("f(\n    " ^ String.make 138 'x' ^ "\n)"));
    case "a sole argument takes no comma, and is laid out in turn"
      (lays
         (L.Call
            ( "f",
              [ L.Call ("g", atoms [ String.make 70 'y'; String.make 70 'z' ]) ]
            ))
         ("f(\n    g(\n        " ^ String.make 70 'y' ^ ",\n        "
        ^ String.make 70 'z' ^ ",\n    )\n)"));
  ]

let () = Alcotest.run "python_layout" [ ("layout", cases) ]
