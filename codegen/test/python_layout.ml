(* Each expected text is what ruff format 0.17.4 wrote, at line-length 140,
   for a line of a generated file. *)

open Xynolog_codegen
module P = Python_syntax

let case name test = Alcotest.test_case name `Quick test

let lays ?(indent = 0) ?(prefix = "") expr expected () =
  Alcotest.(check string) "layout" expected (P.statement ~indent prefix expr)

let names = List.map (fun n -> P.item (P.Name n))
let strings = List.map (fun s -> P.item (P.Str s))

let channel name event payload =
  P.Call
    ( P.sub "RecordedChannel" (names [ event; payload ]),
      P.items (P.item (P.Str name) :: names [ event; payload ]) )

let media_type media_type extension =
  P.call "MediaType"
    [
      P.keyword "media_type" (P.Str media_type);
      P.keyword "extension" (P.Str extension);
      P.keyword "text_source" (P.Str "none");
      P.keyword "authorable" (P.Name "False");
      P.keyword "generatable" (P.Name "False");
    ]

let refresh fields = P.call "CacheRefresh" fields

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
      (lays ~indent:4
         (media_type
            "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
            ".docx")
         {|    MediaType(
        media_type="application/vnd.openxmlformats-officedocument.wordprocessingml.document",
        extension=".docx",
        text_source="none",
        authorable=False,
        generatable=False,
    )|});
    case "a tuple of one that fits is one line"
      (lays ~prefix:"METRICS: Final[tuple[MetricRow, ...]] = "
         (P.tuple (names [ "XYNOLOG_BUS_SENT" ]))
         "METRICS: Final[tuple[MetricRow, ...]] = (XYNOLOG_BUS_SENT,)");
    case "a tuple of one's comma is not magic"
      (lays ~prefix:"METRICS: Final[tuple[MetricRow, ...]] = "
         (P.tuple ~magic:true (names [ "XYNOLOG_BUS_SENT" ]))
         "METRICS: Final[tuple[MetricRow, ...]] = (XYNOLOG_BUS_SENT,)");
    case "a tuple of one in an entry that fits is one line"
      (lays ~indent:8 ~prefix:{|"mark:added": |}
         (P.tuple
            [
              P.item
                (refresh
                   [
                     P.keyword "reach" (P.Str "subject");
                     P.keyword "names_resource" (P.strings [ "resourceId" ]);
                     P.keyword "refetches"
                       (P.strings [ "annotations"; "events" ]);
                   ]);
            ])
         {|        "mark:added": (CacheRefresh(reach="subject", names_resource=("resourceId",), refetches=("annotations", "events")),)|});
    case "a tuple of one too long has its call on a line of its own"
      (lays ~indent:8 ~prefix:{|"bus:resume-gap": |}
         (P.tuple
            [
              P.item
                (refresh
                   [
                     P.keyword "reach" (P.Str "subject");
                     P.keyword "names_resource" (P.strings [ "scope" ]);
                     P.keyword "refetches"
                       (P.strings
                          [
                            "annotations";
                            "annotation";
                            "resource";
                            "events";
                            "referencedBy";
                          ]);
                   ]);
            ])
         {|        "bus:resume-gap": (
            CacheRefresh(
                reach="subject", names_resource=("scope",), refetches=("annotations", "annotation", "resource", "events", "referencedBy")
            ),
        )|});
    case "what is too long at each depth is one a line at each"
      (lays ~indent:8 ~prefix:{|"unreadable": |}
         (P.tuple
            [
              P.item
                (refresh
                   [
                     P.keyword "reach" (P.Str "held");
                     P.keyword "refetches"
                       (P.strings
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
                          ]);
                   ]);
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
        )|});
    case "a magic comma's items are one a line, though they fit"
      (lays ~indent:8 ~prefix:{|"demo:split": |}
         (P.tuple ~magic:true
            [
              P.item (refresh [ P.keyword "when" (P.Str "enriched") ]);
              P.item (refresh [ P.keyword "when" (P.Str "unenriched") ]);
            ])
         {|        "demo:split": (
            CacheRefresh(when="enriched"),
            CacheRefresh(when="unenriched"),
        )|});
    case "an item too long among magic items is laid out as its own line"
      (lays ~indent:4 ~prefix:"X = "
         (P.tuple ~magic:true
            [
              P.item
                (media_type
                   "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
                   ".docx");
              P.item (P.Name "Y");
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
    case "a magic subscript of one keeps its comma"
      (lays ~prefix:"type JobErrorCode = "
         (P.sub ~magic:true "Literal"
            [ P.element ~about:[ Line "It failed." ] (P.Str "job.failed") ])
         {|type JobErrorCode = Literal[
    # It failed.
    "job.failed",
]|});
    case "an empty call and an empty tuple"
      (lays ~prefix:"X = "
         (P.call "f" [ P.item (P.call "g" []); P.item (P.tuple []) ])
         "X = f(g(), ())");
    case "a line exactly as wide as the limit is one line"
      (lays
         (P.call "f" [ P.item (P.Name (String.make (140 - 3) 'x')) ])
         ("f(" ^ String.make 137 'x' ^ ")"));
    case "a line one wider than the limit is split"
      (lays
         (P.call "f" [ P.item (P.Name (String.make (140 - 2) 'x')) ])
         ("f(\n    " ^ String.make 138 'x' ^ "\n)"));
    case "a sole argument takes no comma, and is laid out in turn"
      (lays
         (P.call "f"
            [
              P.item
                (P.call "g" (names [ String.make 70 'y'; String.make 70 'z' ]));
            ])
         ("f(\n    g(\n        " ^ String.make 70 'y' ^ ",\n        "
        ^ String.make 70 'z' ^ ",\n    )\n)"));
    case "a string with more double quotes than single is in single quotes"
      (lays (P.Str {|"a'b\c"|}) {|'"a\'b\\c"'|});
    case "an import too long for its line is one name a line" (fun () ->
        Alcotest.(check string)
          "import"
          ("from m import (\n    " ^ String.make 70 'a' ^ ",\n    "
         ^ String.make 70 'b' ^ ",\n)")
          (P.import ~indent:0
             (P.From ("m", [ String.make 70 'a'; String.make 70 'b' ]))));
  ]

let () = Alcotest.run "python_layout" [ ("layout", cases) ]
