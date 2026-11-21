(* Generated from OpenAPI component schemas through codegen/lib/required/shape.ml. Do not edit.
   Regenerate: make generate (codegen/lib/required/ocaml.ml) *)

open Schema_shape

let shape_0 () =
  {
    any with
    kinds = Some [ Object ];
    variants =
      [
        { any with reference = Some "AgentPerson" };
        { any with reference = Some "AgentOrganization" };
        { any with reference = Some "AgentSoftware" };
      ];
    discriminator =
      Some ("@type", [ ("Person", 0); ("Organization", 1); ("Software", 2) ]);
  }

let shape_1 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "@type"; "name" ];
    members =
      [
        ("@id", { any with kinds = Some [ String ] });
        ( "@type",
          {
            any with
            kinds = Some [ String ];
            enum = Some [ `Stringlit "\"Organization\"" ];
          } );
        ("homepage", { any with kinds = Some [ String ] });
        ("name", { any with kinds = Some [ String ] });
      ];
  }

let shape_2 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "@type" ];
    members =
      [
        ("@id", { any with kinds = Some [ String ] });
        ( "@type",
          {
            any with
            kinds = Some [ String ];
            enum = Some [ `Stringlit "\"Person\"" ];
          } );
        ("email", { any with kinds = Some [ String ] });
        ("email_sha1", { any with kinds = Some [ String ] });
        ("homepage", { any with kinds = Some [ String ] });
        ("name", { any with kinds = Some [ String ] });
        ("nickname", { any with kinds = Some [ String ] });
      ];
  }

let shape_3 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "@type" ];
    members =
      [
        ("@id", { any with kinds = Some [ String ] });
        ( "@type",
          {
            any with
            kinds = Some [ String ];
            enum = Some [ `Stringlit "\"Software\"" ];
          } );
        ("model", { any with kinds = Some [ String ] });
        ("name", { any with kinds = Some [ String ] });
        ("parameters", { any with kinds = Some [ Object ] });
        ("provider", { any with kinds = Some [ String ] });
      ];
  }

let shape_4 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "x"; "y"; "width"; "height"; "top"; "right"; "bottom"; "left" ];
    members =
      [
        ("bottom", { any with kinds = Some [ Number ] });
        ("height", { any with kinds = Some [ Number ] });
        ("left", { any with kinds = Some [ Number ] });
        ("right", { any with kinds = Some [ Number ] });
        ("top", { any with kinds = Some [ Number ] });
        ("width", { any with kinds = Some [ Number ] });
        ("x", { any with kinds = Some [ Number ] });
        ("y", { any with kinds = Some [ Number ] });
      ];
  }

let shape_5 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "text"; "items" ];
    members =
      [
        ( "items",
          {
            any with
            kinds = Some [ Array ];
            items = Some { any with reference = Some "PdfTextItem" };
          } );
        ("text", { any with kinds = Some [ String ] });
      ];
  }

let shape_6 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "kind" ];
    members =
      [
        ( "kind",
          {
            any with
            kinds = Some [ String ];
            enum =
              Some
                [
                  `Stringlit "\"not-yet\"";
                  `Stringlit "\"no-map\"";
                  `Stringlit "\"unknown\"";
                ];
          } );
      ];
  }

let shape_7 () =
  {
    any with
    kinds = Some [ Object ];
    variants =
      [
        { any with reference = Some "ExtractedText" };
        { any with reference = Some "ExtractionDeclined" };
        { any with reference = Some "AnchoredTextAbsent" };
      ];
    discriminator =
      Some
        ( "kind",
          [
            ("extracted", 0);
            ("declined", 1);
            ("not-yet", 2);
            ("no-map", 2);
            ("unknown", 2);
          ] );
  }

let shape_8 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "v"; "stamp"; "declined" ];
    members =
      [
        ("declined", { any with reference = Some "ExtractionDeclinedReason" });
        ("stamp", { any with kinds = Some [ String ]; min_length = Some 1 });
        ("v", { any with kinds = Some [ Integer ]; enum = Some [ `Intlit "3" ] });
      ];
    closed = Some [ "declined"; "stamp"; "v" ];
  }

let shape_9 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "checksums" ];
    members =
      [
        ( "checksums",
          {
            any with
            kinds = Some [ Array ];
            items =
              Some
                {
                  any with
                  kinds = Some [ String ];
                  pattern = Some [ ([ (48, 57); (97, 102) ], 64, Some 64) ];
                };
          } );
      ];
    closed = Some [ "checksums" ];
  }

let shape_10 () =
  {
    any with
    kinds = Some [ Object ];
    variants =
      [
        { any with reference = Some "AnchoredTextExtractedEntry" };
        { any with reference = Some "AnchoredTextDeclinedEntry" };
      ];
  }

let shape_11 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "v"; "stamp"; "text"; "lines"; "method" ];
    members =
      [
        ( "lines",
          {
            any with
            kinds = Some [ Array ];
            items =
              Some
                {
                  any with
                  kinds = Some [ Object ];
                  required = [ "p"; "y"; "h"; "words" ];
                  members =
                    [
                      ("h", { any with kinds = Some [ Number ] });
                      ("p", { any with kinds = Some [ Integer ] });
                      ( "words",
                        {
                          any with
                          kinds = Some [ Array ];
                          items =
                            Some
                              {
                                any with
                                kinds = Some [ Array ];
                                min_items = Some 4;
                                max_items = Some 4;
                                items =
                                  Some { any with kinds = Some [ Number ] };
                              };
                        } );
                      ("y", { any with kinds = Some [ Number ] });
                    ];
                  closed = Some [ "h"; "p"; "words"; "y" ];
                };
          } );
        ("method", { any with reference = Some "ExtractionMethod" });
        ("ocrConfidence", { any with reference = Some "OcrConfidence" });
        ("pdfClass", { any with reference = Some "PdfClass" });
        ("stamp", { any with kinds = Some [ String ]; min_length = Some 1 });
        ("text", { any with kinds = Some [ String ] });
        ( "unreadPages",
          {
            any with
            kinds = Some [ Array ];
            items = Some { any with kinds = Some [ Integer ] };
          } );
        ("v", { any with kinds = Some [ Integer ]; enum = Some [ `Intlit "3" ] });
      ];
    closed =
      Some
        [
          "lines";
          "method";
          "ocrConfidence";
          "pdfClass";
          "stamp";
          "text";
          "unreadPages";
          "v";
        ];
  }

let shape_12 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "stamp" ];
    members =
      [
        ( "stamp",
          {
            any with
            kinds = Some [ String ];
            pattern =
              Some
                [
                  ( [
                      (0, 8);
                      (14, 31);
                      (33, 159);
                      (161, 5759);
                      (5761, 8191);
                      (8203, 8231);
                      (8234, 8238);
                      (8240, 8286);
                      (8288, 12287);
                      (12289, 65278);
                      (65280, 1114111);
                    ],
                    1,
                    None );
                ];
            min_length = Some 1;
          } );
      ];
    closed = Some [ "stamp" ];
  }

let shape_13 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "contentChecksum"; "entry" ];
    members =
      [
        ( "contentChecksum",
          {
            any with
            kinds = Some [ String ];
            pattern = Some [ ([ (48, 57); (97, 102) ], 64, Some 64) ];
          } );
        ("entry", { any with reference = Some "AnchoredTextEntry" });
      ];
    closed = Some [ "contentChecksum"; "entry" ];
  }

let shape_14 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "@context"; "type"; "id"; "motivation"; "target"; "created" ];
    members =
      [
        ( "@context",
          {
            any with
            kinds = Some [ String ];
            enum = Some [ `Stringlit "\"http://www.w3.org/ns/anno.jsonld\"" ];
          } );
        ("body", { any with reference = Some "AnnotationBodies" });
        ("created", { any with kinds = Some [ String ] });
        ("creator", { any with reference = Some "Agent" });
        ("generator", { any with reference = Some "OneOrMoreAgents" });
        ("id", { any with reference = Some "AnnotationId" });
        ("modified", { any with kinds = Some [ String ] });
        ("motivation", { any with reference = Some "Motivation" });
        ( "target",
          {
            any with
            kinds = Some [ Object; String ];
            variants =
              [
                { any with reference = Some "ResourceId" };
                { any with reference = Some "AnnotationTarget" };
              ];
          } );
        ( "type",
          {
            any with
            kinds = Some [ String ];
            enum = Some [ `Stringlit "\"Annotation\"" ];
          } );
        ("wasAttributedTo", { any with reference = Some "OneOrMoreAgents" });
      ];
  }

let shape_15 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "annotation" ];
    members =
      [
        ("annotation", { any with reference = Some "Annotation" });
        ("contentChecksum", { any with kinds = Some [ String ] });
      ];
  }

let shape_16 () =
  {
    any with
    kinds = Some [ Object; Array ];
    variants =
      [
        { any with reference = Some "AnnotationBody" };
        {
          any with
          kinds = Some [ Array ];
          min_items = Some 1;
          items = Some { any with reference = Some "AnnotationBody" };
        };
      ];
  }

let shape_17 () =
  {
    any with
    kinds = Some [ Object ];
    variants =
      [
        { any with reference = Some "TextualBody" };
        { any with reference = Some "SpecificResource" };
      ];
    discriminator =
      Some ("type", [ ("TextualBody", 0); ("SpecificResource", 1) ]);
  }

let shape_18 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "annotationId"; "operations" ];
    members =
      [
        ("annotationId", { any with reference = Some "AnnotationId" });
        ( "operations",
          {
            any with
            kinds = Some [ Array ];
            items = Some { any with reference = Some "BodyOperation" };
          } );
      ];
  }

let shape_19 () =
  {
    any with
    kinds = Some [ String ];
    pattern =
      Some
        [ ([ (45, 45); (48, 57); (65, 90); (95, 95); (97, 122) ], 1, Some 128) ];
  }

let shape_20 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "annotationId" ];
    members = [ ("annotationId", { any with reference = Some "AnnotationId" }) ];
  }

let shape_21 () =
  {
    any with
    kinds = Some [ Object; Array ];
    variants =
      [
        { any with reference = Some "Selector" };
        {
          any with
          kinds = Some [ Array ];
          items = Some { any with reference = Some "Selector" };
        };
      ];
  }

let shape_22 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "source" ];
    members =
      [
        ("selector", { any with reference = Some "AnnotationSelector" });
        ("source", { any with reference = Some "ResourceId" });
        ( "type",
          {
            any with
            kinds = Some [ String ];
            enum = Some [ `Stringlit "\"SpecificResource\"" ];
          } );
      ];
  }

let shape_23 () =
  {
    any with
    kinds = Some [ Object ];
    required =
      [
        "gatewayUrl";
        "identity";
        "root";
        "stateHome";
        "anchoredTextDir";
        "engines";
        "port";
        "skipRebuild";
        "staging";
        "logLevel";
        "logFormat";
      ];
    members =
      [
        ( "anchoredTextDir",
          { any with kinds = Some [ String ]; min_length = Some 1 } );
        ("engines", { any with reference = Some "ArchivistEngines" });
        ("gatewayUrl", { any with kinds = Some [ String ]; min_length = Some 1 });
        ("identity", { any with reference = Some "ServiceIdentity" });
        ("logFormat", { any with reference = Some "LogFormat" });
        ("logLevel", { any with reference = Some "LogLevel" });
        ( "port",
          {
            any with
            kinds = Some [ Integer ];
            minimum = Some "1";
            maximum = Some "65535";
          } );
        ("root", { any with kinds = Some [ String ]; min_length = Some 1 });
        ("skipRebuild", { any with kinds = Some [ Boolean ] });
        ( "staging",
          {
            any with
            kinds = Some [ Object ];
            required = [ "flushMs"; "maxWaitMs" ];
            members =
              [
                ( "flushMs",
                  { any with kinds = Some [ Integer ]; minimum = Some "1" } );
                ( "maxWaitMs",
                  { any with kinds = Some [ Integer ]; minimum = Some "1" } );
              ];
            closed = Some [ "flushMs"; "maxWaitMs" ];
          } );
        ("stateHome", { any with kinds = Some [ String ]; min_length = Some 1 });
      ];
    closed =
      Some
        [
          "anchoredTextDir";
          "engines";
          "gatewayUrl";
          "identity";
          "logFormat";
          "logLevel";
          "port";
          "root";
          "skipRebuild";
          "staging";
          "stateHome";
        ];
  }

let shape_24 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "jobs"; "actors" ];
    members =
      [
        ( "actors",
          {
            any with
            kinds = Some [ Object ];
            members =
              [
                ("gatherer", { any with reference = Some "Engine" });
                ("matcher", { any with reference = Some "Engine" });
              ];
            closed = Some [ "gatherer"; "matcher" ];
          } );
        ( "jobs",
          {
            any with
            kinds = Some [ Object ];
            members =
              [
                ( "mark",
                  {
                    any with
                    kinds = Some [ Object ];
                    members =
                      [
                        ("assessing", { any with reference = Some "Engine" });
                        ("commenting", { any with reference = Some "Engine" });
                        ("highlighting", { any with reference = Some "Engine" });
                        ("linking", { any with reference = Some "Engine" });
                        ("tagging", { any with reference = Some "Engine" });
                      ];
                    closed =
                      Some
                        [
                          "assessing";
                          "commenting";
                          "highlighting";
                          "linking";
                          "tagging";
                        ];
                  } );
                ("yield", { any with reference = Some "Engine" });
              ];
            closed = Some [ "mark"; "yield" ];
          } );
      ];
    closed = Some [ "actors"; "jobs" ];
  }

let shape_25 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "events"; "lastSequence" ];
    members =
      [
        ( "events",
          {
            any with
            kinds = Some [ Array ];
            items = Some { any with reference = Some "StoredEventResponse" };
          } );
        ( "lastSequence",
          { any with kinds = Some [ Integer ]; minimum = Some "0" } );
      ];
  }

let shape_26 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "status"; "actors" ];
    members =
      [
        ( "actors",
          {
            any with
            kinds = Some [ Array ];
            min_items = Some 3;
            max_items = Some 3;
            items =
              Some
                {
                  any with
                  kinds = Some [ String ];
                  enum =
                    Some
                      [
                        `Stringlit "\"stower\"";
                        `Stringlit "\"browser\"";
                        `Stringlit "\"cloneTokenManager\"";
                      ];
                };
          } );
        ( "status",
          {
            any with
            kinds = Some [ String ];
            enum = Some [ `Stringlit "\"ok\"" ];
          } );
      ];
  }

let shape_27 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "resourceId"; "lastSequence" ];
    members =
      [
        ( "lastSequence",
          { any with kinds = Some [ Integer ]; minimum = Some "0" } );
        ("resourceId", { any with reference = Some "ResourceId" });
      ];
    closed = Some [ "lastSequence"; "resourceId" ];
  }

let shape_28 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "streams" ];
    members =
      [
        ( "streams",
          {
            any with
            kinds = Some [ Array ];
            items = Some { any with reference = Some "ArchivistStream" };
          } );
      ];
    closed = Some [ "streams" ];
  }

let shape_29 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "motivation" ];
    members =
      [
        ("density", { any with kinds = Some [ Number ] });
        ("instructions", { any with kinds = Some [ String ] });
        ("language", { any with kinds = Some [ String ] });
        ( "motivation",
          {
            any with
            kinds = Some [ String ];
            enum = Some [ `Stringlit "\"assessing\"" ];
          } );
        ("sourceLanguage", { any with kinds = Some [ String ] });
        ( "tone",
          {
            any with
            kinds = Some [ String ];
            enum =
              Some
                [
                  `Stringlit "\"analytical\"";
                  `Stringlit "\"critical\"";
                  `Stringlit "\"balanced\"";
                  `Stringlit "\"constructive\"";
                ];
          } );
      ];
    closed =
      Some
        [
          "density";
          "instructions";
          "language";
          "motivation";
          "sourceLanguage";
          "tone";
        ];
  }

let shape_30 () =
  {
    any with
    kinds = Some [ Object ];
    all_of =
      [
        { any with reference = Some "StoredEventResponse" };
        {
          any with
          kinds = Some [ Object ];
          required = [ "agent" ];
          members = [ ("agent", { any with reference = Some "Agent" }) ];
        };
      ];
  }

let shape_31 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "resourceId" ];
    members =
      [
        ("annotationId", { any with reference = Some "AnnotationId" });
        ("resourceId", { any with reference = Some "ResourceId" });
      ];
  }

let shape_32 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "annotationId" ];
    members =
      [
        ( "annotationId",
          {
            any with
            kinds = Some [ String; Null ];
            variants =
              [
                { any with kinds = Some [ Null ] };
                { any with reference = Some "AnnotationId" };
              ];
          } );
      ];
  }

let shape_33 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "annotationId" ];
    members = [ ("annotationId", { any with reference = Some "AnnotationId" }) ];
  }

let shape_34 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "op" ];
    members =
      [
        ("item", { any with reference = Some "AnnotationBody" });
        ("newItem", { any with reference = Some "AnnotationBody" });
        ("oldItem", { any with reference = Some "AnnotationBody" });
        ( "op",
          {
            any with
            kinds = Some [ String ];
            enum =
              Some
                [
                  `Stringlit "\"add\"";
                  `Stringlit "\"remove\"";
                  `Stringlit "\"replace\"";
                ];
          } );
      ];
  }

let shape_35 () = { any with kinds = Some [ Object ] }

let shape_36 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "annotationId"; "resourceId"; "defaultTitle"; "entityTypes" ];
    members =
      [
        ("annotationId", { any with reference = Some "AnnotationId" });
        ("defaultTitle", { any with kinds = Some [ String ] });
        ( "entityTypes",
          {
            any with
            kinds = Some [ Array ];
            items = Some { any with kinds = Some [ String ] };
          } );
        ("resourceId", { any with reference = Some "ResourceId" });
      ];
  }

let shape_37 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "annotationId"; "resourceId"; "operations" ];
    members =
      [
        ("_userId", { any with reference = Some "UserId" });
        ("annotationId", { any with reference = Some "AnnotationId" });
        ( "operations",
          {
            any with
            kinds = Some [ Array ];
            items = Some { any with reference = Some "BindBodyOperation" };
          } );
        ("resourceId", { any with reference = Some "ResourceId" });
      ];
  }

let shape_38 () =
  {
    any with
    kinds = Some [ Object ];
    variants =
      [
        { any with reference = Some "BodyOperationAdd" };
        { any with reference = Some "BodyOperationRemove" };
        { any with reference = Some "BodyOperationReplace" };
      ];
  }

let shape_39 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "op"; "item" ];
    members =
      [
        ("item", { any with reference = Some "AnnotationBody" });
        ( "op",
          {
            any with
            kinds = Some [ String ];
            enum = Some [ `Stringlit "\"add\"" ];
          } );
      ];
  }

let shape_40 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "op"; "item" ];
    members =
      [
        ("item", { any with reference = Some "AnnotationBody" });
        ( "op",
          {
            any with
            kinds = Some [ String ];
            enum = Some [ `Stringlit "\"remove\"" ];
          } );
      ];
  }

let shape_41 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "op"; "oldItem"; "newItem" ];
    members =
      [
        ("newItem", { any with reference = Some "AnnotationBody" });
        ("oldItem", { any with reference = Some "AnnotationBody" });
        ( "op",
          {
            any with
            kinds = Some [ String ];
            enum = Some [ `Stringlit "\"replace\"" ];
          } );
      ];
  }

let shape_42 () =
  {
    any with
    kinds = Some [ String ];
    enum =
      Some
        [
          `Stringlit "\"assessing\"";
          `Stringlit "\"bookmarking\"";
          `Stringlit "\"classifying\"";
          `Stringlit "\"commenting\"";
          `Stringlit "\"describing\"";
          `Stringlit "\"editing\"";
          `Stringlit "\"highlighting\"";
          `Stringlit "\"identifying\"";
          `Stringlit "\"linking\"";
          `Stringlit "\"moderating\"";
          `Stringlit "\"questioning\"";
          `Stringlit "\"replying\"";
          `Stringlit "\"tagging\"";
        ];
  }

let shape_43 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "resourceId"; "annotationId" ];
    members =
      [
        ("annotationId", { any with reference = Some "AnnotationId" });
        ("resourceId", { any with reference = Some "ResourceId" });
      ];
  }

let shape_44 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "response" ];
    members =
      [
        ( "response",
          { any with reference = Some "GetAnnotationHistoryResponse" } );
      ];
  }

let shape_45 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "resourceId"; "annotationId" ];
    members =
      [
        ("annotationId", { any with reference = Some "AnnotationId" });
        ("resourceId", { any with reference = Some "ResourceId" });
      ];
  }

let shape_46 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "response" ];
    members =
      [ ("response", { any with reference = Some "GetAnnotationResponse" }) ];
  }

let shape_47 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "annotationId" ];
    members =
      [
        ("anchorRect", { any with reference = Some "AnchorRect" });
        ("annotationId", { any with reference = Some "AnnotationId" });
      ];
  }

let shape_48 () =
  {
    any with
    kinds = Some [ Object ];
    all_of =
      [
        { any with reference = Some "CommandError" };
        {
          any with
          kinds = Some [ Object ];
          required = [ "path" ];
          members = [ ("path", { any with kinds = Some [ String ] }) ];
        };
      ];
  }

let shape_49 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "path" ];
    members =
      [
        ("path", { any with kinds = Some [ String ] });
        ( "sort",
          {
            any with
            kinds = Some [ String ];
            enum =
              Some
                [
                  `Stringlit "\"name\"";
                  `Stringlit "\"mtime\"";
                  `Stringlit "\"annotationCount\"";
                ];
          } );
      ];
  }

let shape_50 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "response" ];
    members =
      [
        ( "response",
          { any with reference = Some "BrowseDirectoryResultResponse" } );
      ];
  }

let shape_51 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "path"; "entries" ];
    members =
      [
        ( "entries",
          {
            any with
            kinds = Some [ Array ];
            items = Some { any with reference = Some "DirectoryEntry" };
          } );
        ("path", { any with kinds = Some [ String ] });
      ];
  }

let shape_52 () = { any with kinds = Some [ Object ] }

let shape_53 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "response" ];
    members =
      [
        ( "response",
          {
            any with
            kinds = Some [ Object ];
            required = [ "engines" ];
            members =
              [
                ( "engines",
                  {
                    any with
                    kinds = Some [ Array ];
                    items = Some { any with reference = Some "EngineEntry" };
                  } );
              ];
          } );
      ];
  }

let shape_54 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "entityType" ];
    members = [ ("entityType", { any with kinds = Some [ String ] }) ];
  }

let shape_55 () = { any with kinds = Some [ Object ] }

let shape_56 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "response" ];
    members =
      [ ("response", { any with reference = Some "GetEntityTypesResponse" }) ];
  }

let shape_57 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "resourceId" ];
    members =
      [
        ("limit", { any with kinds = Some [ Integer ] });
        ("resourceId", { any with reference = Some "ResourceId" });
        ("type", { any with kinds = Some [ String ] });
        ("userId", { any with reference = Some "UserId" });
      ];
  }

let shape_58 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "response" ];
    members =
      [ ("response", { any with reference = Some "GetEventsResponse" }) ];
  }

let shape_59 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "url" ];
    members =
      [
        ("resourceId", { any with reference = Some "ResourceId" });
        ("url", { any with kinds = Some [ String ] });
      ];
  }

let shape_60 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "path"; "entries" ];
    members =
      [
        ( "entries",
          {
            any with
            kinds = Some [ Array ];
            items = Some { any with reference = Some "DirectoryEntry" };
          } );
        ("path", { any with kinds = Some [ String ] });
      ];
    closed = Some [ "entries"; "path" ];
  }

let shape_61 () = { any with kinds = Some [ Object ] }

let shape_62 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "response" ];
    members = [ ("response", { any with reference = Some "KbDescription" }) ];
  }

let shape_63 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "href" ];
    members =
      [
        ("href", { any with kinds = Some [ String ] });
        ("label", { any with kinds = Some [ String ] });
      ];
  }

let shape_64 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "panel" ];
    members =
      [
        ("motivation", { any with reference = Some "Motivation" });
        ("panel", { any with kinds = Some [ String ] });
        ("scrollToAnnotationId", { any with reference = Some "AnnotationId" });
      ];
  }

let shape_65 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "panel" ];
    members = [ ("panel", { any with kinds = Some [ String ] }) ];
  }

let shape_66 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "dids" ];
    members =
      [
        ( "dids",
          {
            any with
            kinds = Some [ Array ];
            min_items = Some 1;
            max_items = Some 500;
            items = Some { any with reference = Some "UserId" };
          } );
      ];
    closed = Some [ "dids" ];
  }

let shape_67 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "response" ];
    members =
      [
        ( "response",
          {
            any with
            kinds = Some [ Object ];
            required = [ "profiles" ];
            members =
              [
                ( "profiles",
                  {
                    any with
                    kinds = Some [ Object ];
                    values = Some { any with reference = Some "Profile" };
                  } );
              ];
            closed = Some [ "profiles" ];
          } );
      ];
  }

let shape_68 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "resourceId" ];
    members = [ ("resourceId", { any with reference = Some "ResourceId" }) ];
  }

let shape_69 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "resourceId" ];
    members = [ ("resourceId", { any with reference = Some "ResourceId" }) ];
  }

let shape_70 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "oldIndex"; "newIndex" ];
    members =
      [
        ("newIndex", { any with kinds = Some [ Integer ] });
        ("oldIndex", { any with kinds = Some [ Integer ] });
      ];
  }

let shape_71 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "resourceId" ];
    members = [ ("resourceId", { any with reference = Some "ResourceId" }) ];
  }

let shape_72 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "response" ];
    members =
      [
        ( "response",
          {
            any with
            kinds = Some [ Object ];
            required = [ "resource"; "lastSequence" ];
            members =
              [
                ( "lastSequence",
                  { any with kinds = Some [ Integer ]; minimum = Some "1" } );
                ("resource", { any with reference = Some "ResourceDescriptor" });
              ];
            closed = Some [ "lastSequence"; "resource" ];
          } );
      ];
  }

let shape_73 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "resourceId" ];
    members = [ ("resourceId", { any with reference = Some "ResourceId" }) ];
  }

let shape_74 () =
  {
    any with
    kinds = Some [ Object ];
    members =
      [
        ("archived", { any with kinds = Some [ Boolean ] });
        ("entityType", { any with kinds = Some [ String ] });
        ("limit", { any with kinds = Some [ Integer ]; minimum = Some "1" });
        ("offset", { any with kinds = Some [ Integer ]; minimum = Some "0" });
      ];
  }

let shape_75 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "response" ];
    members =
      [ ("response", { any with reference = Some "ListResourcesResponse" }) ];
  }

let shape_76 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "path" ];
    members =
      [
        ("path", { any with kinds = Some [ String ] });
        ("reason", { any with kinds = Some [ String ] });
      ];
  }

let shape_77 () = { any with kinds = Some [ Object ] }

let shape_78 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "response" ];
    members =
      [ ("response", { any with reference = Some "GetTagSchemasResponse" }) ];
  }

let shape_79 () =
  {
    any with
    kinds = Some [ Object ];
    members =
      [
        ( "subscribers",
          { any with kinds = Some [ Integer ]; minimum = Some "0" } );
      ];
  }

let shape_80 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "channel"; "payload" ];
    members =
      [
        ("channel", { any with kinds = Some [ String ]; min_length = Some 1 });
        ("clientId", { any with kinds = Some [ String ] });
        ( "correlationId",
          { any with kinds = Some [ String ]; min_length = Some 1 } );
        ("payload", { any with kinds = Some [ Object ] });
        ("scope", { any with reference = Some "ResourceId" });
      ];
  }

let shape_81 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "event"; "id"; "data" ];
    members =
      [
        ("data", { any with reference = Some "BusFrame" });
        ( "event",
          {
            any with
            kinds = Some [ String ];
            enum = Some [ `Stringlit "\"bus-event\"" ];
          } );
        ( "id",
          {
            any with
            kinds = Some [ String ];
            variants =
              [
                { any with reference = Some "PersistedEventId" };
                { any with reference = Some "ReplyEventId" };
                { any with reference = Some "EphemeralEventId" };
              ];
          } );
      ];
    closed = Some [ "data"; "event"; "id" ];
  }

let shape_82 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "channel"; "payload" ];
    members =
      [
        ("channel", { any with kinds = Some [ String ]; min_length = Some 1 });
        ( "correlationId",
          { any with kinds = Some [ String ]; min_length = Some 1 } );
        ("payload", { any with kinds = Some [ Object ] });
        ("scope", { any with reference = Some "ResourceId" });
      ];
    closed = Some [ "channel"; "correlationId"; "payload"; "scope" ];
  }

let shape_83 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "event"; "data" ];
    members =
      [
        ("data", { any with kinds = Some [ String ]; max_length = Some 0 });
        ( "event",
          {
            any with
            kinds = Some [ String ];
            enum = Some [ `Stringlit "\"ping\"" ];
          } );
      ];
    closed = Some [ "data"; "event" ];
  }

let shape_84 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "scope"; "lastSeenId"; "reason" ];
    members =
      [
        ("lastSeenId", { any with kinds = Some [ String ] });
        ( "reason",
          {
            any with
            kinds = Some [ String ];
            enum =
              Some
                [
                  `Stringlit "\"unparseable-last-event-id\"";
                  `Stringlit "\"scope-mismatch\"";
                  `Stringlit "\"retention-exceeded\"";
                  `Stringlit "\"query-error\"";
                ];
          } );
        ("scope", { any with reference = Some "ResourceId" });
      ];
    closed = Some [ "lastSeenId"; "reason"; "scope" ];
  }

let shape_85 () =
  {
    any with
    kinds = Some [ Object ];
    variants =
      [
        { any with reference = Some "BusEventMessage" };
        { any with reference = Some "BusPingMessage" };
      ];
  }

let shape_86 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "clientId" ];
    members =
      [
        ("clientId", { any with kinds = Some [ String ]; min_length = Some 1 });
        ( "global",
          {
            any with
            kinds = Some [ Array ];
            items =
              Some { any with kinds = Some [ String ]; min_length = Some 1 };
          } );
        ( "pendingReplies",
          {
            any with
            kinds = Some [ Array ];
            max_items = Some 256;
            items =
              Some { any with kinds = Some [ String ]; min_length = Some 1 };
          } );
        ( "scoped",
          {
            any with
            kinds = Some [ Array ];
            max_items = Some 512;
            items =
              Some
                {
                  any with
                  kinds = Some [ Object ];
                  required = [ "scope"; "channels" ];
                  members =
                    [
                      ( "channels",
                        {
                          any with
                          kinds = Some [ Array ];
                          min_items = Some 1;
                          items =
                            Some
                              {
                                any with
                                kinds = Some [ String ];
                                min_length = Some 1;
                              };
                        } );
                      ("lastEventId", { any with kinds = Some [ String ] });
                      ("scope", { any with reference = Some "ResourceId" });
                    ];
                  closed = Some [ "channels"; "lastEventId"; "scope" ];
                };
          } );
      ];
    closed = Some [ "clientId"; "global"; "pendingReplies"; "scoped" ];
  }

let shape_87 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "token"; "expiresAt"; "resource" ];
    members =
      [
        ("expiresAt", { any with kinds = Some [ String ] });
        ("resource", { any with reference = Some "ResourceDescriptor" });
        ("token", { any with kinds = Some [ String ] });
      ];
  }

let shape_88 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "message" ];
    members =
      [
        ( "code",
          {
            any with
            kinds = Some [ String ];
            recognized =
              Some
                [
                  "peer-unavailable";
                  "not-found";
                  "unauthorized";
                  "none-pending";
                ];
          } );
        ("details", { any with kinds = Some [ String ] });
        ("message", { any with kinds = Some [ String ] });
      ];
  }

let shape_89 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "motivation" ];
    members =
      [
        ("density", { any with kinds = Some [ Number ] });
        ("instructions", { any with kinds = Some [ String ] });
        ("language", { any with kinds = Some [ String ] });
        ( "motivation",
          {
            any with
            kinds = Some [ String ];
            enum = Some [ `Stringlit "\"commenting\"" ];
          } );
        ("sourceLanguage", { any with kinds = Some [ String ] });
        ( "tone",
          {
            any with
            kinds = Some [ String ];
            enum =
              Some
                [
                  `Stringlit "\"scholarly\"";
                  `Stringlit "\"explanatory\"";
                  `Stringlit "\"conversational\"";
                  `Stringlit "\"technical\"";
                ];
          } );
      ];
    closed =
      Some
        [
          "density";
          "instructions";
          "language";
          "motivation";
          "sourceLanguage";
          "tone";
        ];
  }

let shape_90 () = { any with kinds = Some [ String ] }

let shape_91 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "summary"; "relevantFields"; "context" ];
    members =
      [
        ( "context",
          {
            any with
            kinds = Some [ Object ];
            required = [ "selected" ];
            members =
              [
                ("after", { any with kinds = Some [ String ] });
                ("before", { any with kinds = Some [ String ] });
                ("selected", { any with kinds = Some [ String ] });
              ];
          } );
        ( "relevantFields",
          {
            any with
            kinds = Some [ Object ];
            required = [ "resourceId"; "resourceName"; "entityTypes" ];
            members =
              [
                ( "entityTypes",
                  {
                    any with
                    kinds = Some [ Array ];
                    items = Some { any with kinds = Some [ String ] };
                  } );
                ("resourceId", { any with reference = Some "ResourceId" });
                ("resourceName", { any with kinds = Some [ String ] });
              ];
            closed = Some [ "entityTypes"; "resourceId"; "resourceName" ];
          } );
        ("summary", { any with kinds = Some [ String ] });
      ];
  }

let shape_92 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "target"; "motivation" ];
    members =
      [
        ("body", { any with reference = Some "AnnotationBodies" });
        ("motivation", { any with reference = Some "Motivation" });
        ("target", { any with reference = Some "AnnotationTarget" });
      ];
  }

let shape_93 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "resourceId" ];
    members = [ ("resourceId", { any with reference = Some "ResourceId" }) ];
  }

let shape_94 () = { any with kinds = Some [ String ]; min_length = Some 1 }

let shape_95 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "type"; "name"; "path"; "mtime" ];
    members =
      [
        ("mtime", { any with kinds = Some [ String ] });
        ("name", { any with kinds = Some [ String ] });
        ("path", { any with kinds = Some [ String ] });
        ( "type",
          {
            any with
            kinds = Some [ String ];
            enum = Some [ `Stringlit "\"dir\"" ];
          } );
      ];
    closed = Some [ "mtime"; "name"; "path"; "type" ];
  }

let shape_96 () =
  {
    any with
    kinds = Some [ Object ];
    variants =
      [
        { any with reference = Some "FileEntry" };
        { any with reference = Some "DirEntry" };
      ];
    discriminator = Some ("type", [ ("file", 0); ("dir", 1) ]);
  }

let shape_97 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "host"; "port"; "placement"; "did"; "managedBy" ];
    members =
      [
        ("did", { any with kinds = Some [ String ] });
        ("host", { any with kinds = Some [ String ] });
        ("managedBy", { any with kinds = Some [ String ] });
        ( "placement",
          {
            any with
            kinds = Some [ String ];
            enum = Some [ `Stringlit "\"local\""; `Stringlit "\"codespace\"" ];
          } );
        ("port", { any with kinds = Some [ Integer ] });
        ("repo", { any with kinds = Some [ String ] });
        ("siteName", { any with kinds = Some [ String ] });
      ];
  }

let shape_98 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "version"; "kbs" ];
    members =
      [
        ( "kbs",
          {
            any with
            kinds = Some [ Array ];
            items = Some { any with reference = Some "DiscoveredKB" };
          } );
        ( "version",
          { any with kinds = Some [ Integer ]; enum = Some [ `Intlit "1" ] } );
      ];
  }

let shape_99 () =
  {
    any with
    kinds = Some [ Object ];
    required =
      [
        "kb";
        "gatewayUrl";
        "identity";
        "queue";
        "port";
        "timing";
        "logLevel";
        "logFormat";
      ];
    members =
      [
        ("gatewayUrl", { any with kinds = Some [ String ]; min_length = Some 1 });
        ("identity", { any with reference = Some "ServiceIdentity" });
        ("kb", { any with reference = Some "KbIdentity" });
        ("logFormat", { any with reference = Some "LogFormat" });
        ("logLevel", { any with reference = Some "LogLevel" });
        ( "port",
          {
            any with
            kinds = Some [ Integer ];
            minimum = Some "1";
            maximum = Some "65535";
          } );
        ( "queue",
          {
            any with
            kinds = Some [ Object ];
            required = [ "servers" ];
            members =
              [
                ( "passwordEnv",
                  { any with kinds = Some [ String ]; min_length = Some 1 } );
                ( "servers",
                  { any with kinds = Some [ String ]; min_length = Some 1 } );
                ( "userEnv",
                  { any with kinds = Some [ String ]; min_length = Some 1 } );
              ];
            closed = Some [ "passwordEnv"; "servers"; "userEnv" ];
          } );
        ( "timing",
          {
            any with
            kinds = Some [ Object ];
            required =
              [
                "tickMs";
                "staleRunningMs";
                "ackWaitMs";
                "retentionMs";
                "retentionSweepMs";
                "progressWriteIntervalMs";
                "bootDeadlineMs";
              ];
            members =
              [
                ( "ackWaitMs",
                  { any with kinds = Some [ Integer ]; minimum = Some "1" } );
                ( "bootDeadlineMs",
                  { any with kinds = Some [ Integer ]; minimum = Some "1" } );
                ( "progressWriteIntervalMs",
                  { any with kinds = Some [ Integer ]; minimum = Some "1" } );
                ( "retentionMs",
                  { any with kinds = Some [ Integer ]; minimum = Some "1" } );
                ( "retentionSweepMs",
                  { any with kinds = Some [ Integer ]; minimum = Some "1" } );
                ( "staleRunningMs",
                  { any with kinds = Some [ Integer ]; minimum = Some "1" } );
                ( "tickMs",
                  { any with kinds = Some [ Integer ]; minimum = Some "1" } );
              ];
            closed =
              Some
                [
                  "ackWaitMs";
                  "bootDeadlineMs";
                  "progressWriteIntervalMs";
                  "retentionMs";
                  "retentionSweepMs";
                  "staleRunningMs";
                  "tickMs";
                ];
          } );
      ];
    closed =
      Some
        [
          "gatewayUrl";
          "identity";
          "kb";
          "logFormat";
          "logLevel";
          "port";
          "queue";
          "timing";
        ];
  }

let shape_100 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "status"; "queue" ];
    members =
      [
        ( "queue",
          {
            any with
            kinds = Some [ String ];
            enum = Some [ `Stringlit "\"jetstream\"" ];
          } );
        ( "status",
          {
            any with
            kinds = Some [ String ];
            enum = Some [ `Stringlit "\"ok\"" ];
          } );
      ];
    closed = Some [ "queue"; "status" ];
  }

let shape_101 () =
  {
    any with
    kinds = Some [ String ];
    enum =
      Some
        [
          `Stringlit "\"acknowledged\"";
          `Stringlit "\"probe-confirmed\"";
          `Stringlit "\"probe-refused\"";
          `Stringlit "\"probe-unreachable\"";
        ];
  }

let shape_102 () =
  {
    any with
    kinds = Some [ Object ];
    variants =
      [
        { any with reference = Some "OllamaEmbeddingConfig" };
        { any with reference = Some "VoyageEmbeddingConfig" };
      ];
    discriminator = Some ("type", [ ("ollama", 0); ("voyage", 1) ]);
  }

let shape_103 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "provider"; "model" ];
    members =
      [
        ("model", { any with kinds = Some [ String ]; min_length = Some 1 });
        ( "provider",
          {
            any with
            kinds = Some [ String ];
            enum =
              Some
                [
                  `Stringlit "\"anthropic\"";
                  `Stringlit "\"google\"";
                  `Stringlit "\"llamacpp\"";
                  `Stringlit "\"ollama\"";
                  `Stringlit "\"openai\"";
                  `Stringlit "\"together\"";
                  `Stringlit "\"vllm\"";
                ];
          } );
      ];
    closed = Some [ "model"; "provider" ];
  }

let shape_104 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "engine" ];
    members =
      [
        ("engine", { any with reference = Some "Engine" });
        ( "jobs",
          {
            any with
            kinds = Some [ Array ];
            items = Some { any with reference = Some "JobFilter" };
          } );
      ];
    closed = Some [ "engine"; "jobs" ];
  }

let shape_105 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "engine"; "limits" ];
    members =
      [
        ("engine", { any with reference = Some "Engine" });
        ("limits", { any with reference = Some "InferenceLimits" });
      ];
    closed = Some [ "engine"; "limits" ];
  }

let shape_106 () =
  {
    any with
    kinds = Some [ Object ];
    all_of =
      [
        { any with reference = Some "StoredEventResponse" };
        {
          any with
          kinds = Some [ Object ];
          members =
            [ ("annotation", { any with reference = Some "Annotation" }) ];
        };
      ];
  }

let shape_107 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "entityType" ];
    members = [ ("entityType", { any with kinds = Some [ String ] }) ];
  }

let shape_108 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "entityType" ];
    members = [ ("entityType", { any with kinds = Some [ String ] }) ];
  }

let shape_109 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "entityTypes" ];
    members =
      [
        ( "entityTypes",
          {
            any with
            kinds = Some [ Array ];
            items = Some { any with kinds = Some [ String ] };
          } );
      ];
    closed = Some [ "entityTypes" ];
  }

let shape_110 () =
  {
    any with
    kinds = Some [ String ];
    pattern =
      Some
        [
          ([ (101, 101) ], 1, Some 1);
          ([ (45, 45) ], 1, Some 1);
          ([ (0, 57); (59, 1114111) ], 1, None);
        ];
  }

let shape_111 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "error" ];
    members =
      [
        ("code", { any with kinds = Some [ String ] });
        ("error", { any with kinds = Some [ String ] });
        ("hint", { any with kinds = Some [ String ] });
      ];
  }

let shape_112 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "sequenceNumber" ];
    members = [ ("sequenceNumber", { any with kinds = Some [ Integer ] }) ];
  }

let shape_113 () =
  {
    any with
    kinds = Some [ Object ];
    all_of =
      [
        { any with reference = Some "AnchoredText" };
        {
          any with
          kinds = Some [ Object ];
          required = [ "kind"; "method" ];
          members =
            [
              ( "kind",
                {
                  any with
                  kinds = Some [ String ];
                  enum = Some [ `Stringlit "\"extracted\"" ];
                } );
              ("method", { any with reference = Some "ExtractionMethod" });
              ("ocrConfidence", { any with reference = Some "OcrConfidence" });
              ("pdfClass", { any with reference = Some "PdfClass" });
              ( "unreadPages",
                {
                  any with
                  kinds = Some [ Array ];
                  items = Some { any with kinds = Some [ Integer ] };
                } );
            ];
        };
      ];
  }

let shape_114 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "kind"; "declined" ];
    members =
      [
        ("declined", { any with reference = Some "ExtractionDeclinedReason" });
        ( "kind",
          {
            any with
            kinds = Some [ String ];
            enum = Some [ `Stringlit "\"declined\"" ];
          } );
      ];
  }

let shape_115 () =
  {
    any with
    kinds = Some [ String ];
    enum =
      Some
        [
          `Stringlit "\"no-text-layer\"";
          `Stringlit "\"encrypted\"";
          `Stringlit "\"corrupt\"";
          `Stringlit "\"too-large\"";
        ];
  }

let shape_116 () =
  {
    any with
    kinds = Some [ String ];
    enum =
      Some
        [
          `Stringlit "\"text-passthrough\"";
          `Stringlit "\"pdf-text-layer\"";
          `Stringlit "\"table\"";
          `Stringlit "\"form\"";
          `Stringlit "\"ocr\"";
        ];
  }

let shape_117 () =
  {
    any with
    kinds = Some [ Object ];
    variants =
      [
        { any with reference = Some "ExtractedText" };
        { any with reference = Some "ExtractionDeclined" };
      ];
    discriminator = Some ("kind", [ ("extracted", 0); ("declined", 1) ]);
  }

let shape_118 () =
  {
    any with
    kinds = Some [ String ];
    enum =
      Some
        [
          `Stringlit "\"transient\"";
          `Stringlit "\"deterministic\"";
          `Stringlit "\"withheld\"";
        ];
  }

let shape_119 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "type"; "name"; "path"; "size"; "mtime"; "tracked" ];
    members =
      [
        ("annotationCount", { any with kinds = Some [ Integer ] });
        ("creator", { any with kinds = Some [ String ] });
        ( "entityTypes",
          {
            any with
            kinds = Some [ Array ];
            items = Some { any with kinds = Some [ String ] };
          } );
        ("mtime", { any with kinds = Some [ String ] });
        ("name", { any with kinds = Some [ String ] });
        ("path", { any with kinds = Some [ String ] });
        ("resourceId", { any with reference = Some "ResourceId" });
        ("size", { any with kinds = Some [ Integer ] });
        ("tracked", { any with kinds = Some [ Boolean ] });
        ( "type",
          {
            any with
            kinds = Some [ String ];
            enum = Some [ `Stringlit "\"file\"" ];
          } );
      ];
    closed =
      Some
        [
          "annotationCount";
          "creator";
          "entityTypes";
          "mtime";
          "name";
          "path";
          "resourceId";
          "size";
          "tracked";
          "type";
        ];
  }

let shape_120 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "type"; "value" ];
    members =
      [
        ("conformsTo", { any with kinds = Some [ String ] });
        ( "type",
          {
            any with
            kinds = Some [ String ];
            enum = Some [ `Stringlit "\"FragmentSelector\"" ];
          } );
        ("value", { any with kinds = Some [ String ] });
      ];
  }

let shape_121 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "tag" ];
    members =
      [
        ("_userId", { any with reference = Some "UserId" });
        ("tag", { any with kinds = Some [ String ] });
      ];
  }

let shape_122 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "schema" ];
    members =
      [
        ("_userId", { any with reference = Some "UserId" });
        ("schema", { any with reference = Some "TagSchema" });
      ];
  }

let shape_123 () =
  {
    any with
    kinds = Some [ Object ];
    required =
      [
        "kb";
        "port";
        "publicUrl";
        "identity";
        "archivist";
        "signal";
        "logLevel";
        "logFormat";
        "capacity";
      ];
    members =
      [
        ("archivist", { any with reference = Some "ServiceAddress" });
        ( "capacity",
          {
            any with
            kinds = Some [ Object ];
            required = [ "queuedBytes"; "connections" ];
            members =
              [
                ( "connections",
                  { any with kinds = Some [ Integer ]; minimum = Some "1" } );
                ( "queuedBytes",
                  { any with kinds = Some [ Integer ]; minimum = Some "1" } );
              ];
            closed = Some [ "connections"; "queuedBytes" ];
          } );
        ( "identity",
          {
            any with
            kinds = Some [ Object ];
            required = [ "issuer"; "subjectClaim" ];
            members =
              [
                ( "issuer",
                  { any with kinds = Some [ String ]; min_length = Some 1 } );
                ( "subjectClaim",
                  { any with kinds = Some [ String ]; min_length = Some 1 } );
              ];
            closed = Some [ "issuer"; "subjectClaim" ];
          } );
        ("kb", { any with reference = Some "KbIdentity" });
        ("logFormat", { any with reference = Some "LogFormat" });
        ("logLevel", { any with reference = Some "LogLevel" });
        ( "port",
          {
            any with
            kinds = Some [ Integer ];
            minimum = Some "1";
            maximum = Some "65535";
          } );
        ("publicUrl", { any with kinds = Some [ String ]; min_length = Some 1 });
        ( "signal",
          {
            any with
            kinds = Some [ Object ];
            required = [ "type" ];
            members =
              [
                ( "passwordEnv",
                  { any with kinds = Some [ String ]; min_length = Some 1 } );
                ( "servers",
                  { any with kinds = Some [ String ]; min_length = Some 1 } );
                ( "type",
                  {
                    any with
                    kinds = Some [ String ];
                    enum =
                      Some
                        [ `Stringlit "\"in-process\""; `Stringlit "\"nats\"" ];
                  } );
                ( "userEnv",
                  { any with kinds = Some [ String ]; min_length = Some 1 } );
              ];
            closed = Some [ "passwordEnv"; "servers"; "type"; "userEnv" ];
          } );
      ];
    closed =
      Some
        [
          "archivist";
          "capacity";
          "identity";
          "kb";
          "logFormat";
          "logLevel";
          "port";
          "publicUrl";
          "signal";
        ];
  }

let shape_124 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "annotationId"; "response" ];
    members =
      [
        ("annotationId", { any with reference = Some "AnnotationId" });
        ("response", { any with reference = Some "GatheredContext" });
      ];
  }

let shape_125 () =
  {
    any with
    kinds = Some [ Object ];
    members =
      [
        ( "contextWindow",
          {
            any with
            kinds = Some [ Integer ];
            minimum = Some "100";
            maximum = Some "5000";
          } );
        ("includeSourceContext", { any with kinds = Some [ Boolean ] });
        ("includeTargetContext", { any with kinds = Some [ Boolean ] });
      ];
  }

let shape_126 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "annotationId"; "resourceId" ];
    members =
      [
        ("annotationId", { any with reference = Some "AnnotationId" });
        ("options", { any with reference = Some "GatherAnnotationOptions" });
        ("resourceId", { any with reference = Some "ResourceId" });
      ];
  }

let shape_127 () =
  {
    any with
    kinds = Some [ Object ];
    all_of =
      [
        { any with reference = Some "CommandError" };
        {
          any with
          kinds = Some [ Object ];
          required = [ "annotationId" ];
          members =
            [ ("annotationId", { any with reference = Some "AnnotationId" }) ];
        };
      ];
  }

let shape_128 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "resourceId" ];
    members =
      [
        ("motivation", { any with reference = Some "Motivation" });
        ("resourceId", { any with reference = Some "ResourceId" });
      ];
  }

let shape_129 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "response" ];
    members =
      [ ("response", { any with reference = Some "GetReferencedByResponse" }) ];
  }

let shape_130 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "resourceId"; "response" ];
    members =
      [
        ("resourceId", { any with reference = Some "ResourceId" });
        ("response", { any with reference = Some "GatheredContext" });
      ];
  }

let shape_131 () =
  {
    any with
    kinds = Some [ Object ];
    all_of =
      [
        { any with reference = Some "CommandError" };
        {
          any with
          kinds = Some [ Object ];
          required = [ "resourceId" ];
          members =
            [ ("resourceId", { any with reference = Some "ResourceId" }) ];
        };
      ];
  }

let shape_132 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "resourceId"; "options" ];
    members =
      [
        ("options", { any with reference = Some "GatherResourceRequestOptions" });
        ("resourceId", { any with reference = Some "ResourceId" });
      ];
  }

let shape_133 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "depth"; "maxResources"; "includeContent"; "includeSummary" ];
    members =
      [
        ( "depth",
          {
            any with
            kinds = Some [ Integer ];
            minimum = Some "1";
            maximum = Some "3";
          } );
        ( "excludeEntityTypes",
          {
            any with
            kinds = Some [ Array ];
            items = Some { any with kinds = Some [ String ] };
          } );
        ("includeContent", { any with kinds = Some [ Boolean ] });
        ("includeSummary", { any with kinds = Some [ Boolean ] });
        ( "maxResources",
          {
            any with
            kinds = Some [ Integer ];
            minimum = Some "1";
            maximum = Some "200";
          } );
      ];
  }

let shape_134 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "annotationId"; "resourceId" ];
    members =
      [
        ("annotationId", { any with reference = Some "AnnotationId" });
        ("resourceId", { any with reference = Some "ResourceId" });
      ];
  }

let shape_135 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "focus"; "graph"; "metadata" ];
    members =
      [
        ( "focus",
          {
            any with
            kinds = Some [ Object ];
            variants =
              [
                {
                  any with
                  kinds = Some [ Object ];
                  required = [ "kind"; "annotation"; "sourceResource" ];
                  members =
                    [
                      ("annotation", { any with reference = Some "Annotation" });
                      ( "kind",
                        {
                          any with
                          kinds = Some [ String ];
                          enum = Some [ `Stringlit "\"annotation\"" ];
                        } );
                      ( "selected",
                        {
                          any with
                          kinds = Some [ Object ];
                          required = [ "text" ];
                          members =
                            [
                              ("after", { any with kinds = Some [ String ] });
                              ("before", { any with kinds = Some [ String ] });
                              ("text", { any with kinds = Some [ String ] });
                            ];
                        } );
                      ( "sourceResource",
                        { any with reference = Some "ResourceDescriptor" } );
                      ( "targetContext",
                        {
                          any with
                          kinds = Some [ Object ];
                          required = [ "content" ];
                          members =
                            [
                              ("content", { any with kinds = Some [ String ] });
                              ("summary", { any with kinds = Some [ String ] });
                            ];
                        } );
                      ( "targetResource",
                        { any with reference = Some "ResourceDescriptor" } );
                      ("userHint", { any with kinds = Some [ String ] });
                    ];
                };
                {
                  any with
                  kinds = Some [ Object ];
                  required = [ "kind"; "resource" ];
                  members =
                    [
                      ( "content",
                        {
                          any with
                          kinds = Some [ Object ];
                          members =
                            [
                              ("main", { any with kinds = Some [ String ] });
                              ( "related",
                                {
                                  any with
                                  kinds = Some [ Object ];
                                  values =
                                    Some { any with kinds = Some [ String ] };
                                } );
                            ];
                        } );
                      ( "kind",
                        {
                          any with
                          kinds = Some [ String ];
                          enum = Some [ `Stringlit "\"resource\"" ];
                        } );
                      ( "resource",
                        { any with reference = Some "ResourceDescriptor" } );
                      ( "suggestedReferences",
                        {
                          any with
                          kinds = Some [ Array ];
                          items = Some { any with kinds = Some [ String ] };
                        } );
                      ("summary", { any with kinds = Some [ String ] });
                    ];
                };
              ];
          } );
        ("graph", { any with reference = Some "KnowledgeGraph" });
        ("inferredRelationshipSummary", { any with kinds = Some [ String ] });
        ( "metadata",
          {
            any with
            kinds = Some [ Object ];
            members =
              [
                ( "entityTypeFrequencies",
                  {
                    any with
                    kinds = Some [ Object ];
                    values = Some { any with kinds = Some [ Integer ] };
                  } );
                ( "entityTypes",
                  {
                    any with
                    kinds = Some [ Array ];
                    items = Some { any with kinds = Some [ String ] };
                  } );
                ("language", { any with kinds = Some [ String ] });
                ("resourceType", { any with kinds = Some [ String ] });
              ];
          } );
        ( "semanticContext",
          {
            any with
            kinds = Some [ Object ];
            required = [ "similar" ];
            members =
              [
                ( "excludedEntityTypes",
                  {
                    any with
                    kinds = Some [ Array ];
                    items = Some { any with kinds = Some [ String ] };
                  } );
                ( "similar",
                  {
                    any with
                    kinds = Some [ Array ];
                    items = Some { any with reference = Some "SemanticMatch" };
                  } );
              ];
          } );
      ];
  }

let shape_136 () =
  {
    any with
    kinds = Some [ Object ];
    all_of =
      [
        { any with reference = Some "GenerationJobRequest" };
        {
          any with
          kinds = Some [ Object ];
          required = [ "context" ];
          members =
            [ ("context", { any with reference = Some "GatheredContext" }) ];
        };
      ];
  }

let shape_137 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "title"; "storageUri" ];
    members =
      [
        ("cite", { any with kinds = Some [ Boolean ] });
        ( "entityTypes",
          {
            any with
            kinds = Some [ Array ];
            items = Some { any with kinds = Some [ String ] };
          } );
        ("language", { any with kinds = Some [ String ] });
        ("maxTokens", { any with kinds = Some [ Number ] });
        ("outputMediaType", { any with reference = Some "SupportedMediaType" });
        ("prompt", { any with kinds = Some [ String ] });
        ("sourceLanguage", { any with kinds = Some [ String ] });
        ("storageUri", { any with kinds = Some [ String ]; min_length = Some 1 });
        ("structure", { any with kinds = Some [ String ] });
        ("task", { any with kinds = Some [ String ] });
        ("temperature", { any with kinds = Some [ Number ] });
        ("title", { any with kinds = Some [ String ]; min_length = Some 1 });
      ];
  }

let shape_138 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "events"; "total"; "annotationId"; "resourceId" ];
    members =
      [
        ("annotationId", { any with reference = Some "AnnotationId" });
        ( "events",
          {
            any with
            kinds = Some [ Array ];
            items = Some { any with reference = Some "AttributedEvent" };
          } );
        ("resourceId", { any with reference = Some "ResourceId" });
        ("total", { any with kinds = Some [ Number ] });
      ];
  }

let shape_139 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "annotation"; "resource"; "resolvedResource" ];
    members =
      [
        ("annotation", { any with reference = Some "Annotation" });
        ( "resolvedResource",
          {
            any with
            kinds = Some [ Object; Null ];
            variants =
              [
                { any with kinds = Some [ Null ] };
                { any with reference = Some "ResourceDescriptor" };
              ];
          } );
        ( "resource",
          {
            any with
            kinds = Some [ Object; Null ];
            variants =
              [
                { any with kinds = Some [ Null ] };
                { any with reference = Some "ResourceDescriptor" };
              ];
          } );
      ];
  }

let shape_140 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "annotations"; "total" ];
    members =
      [
        ( "annotations",
          {
            any with
            kinds = Some [ Array ];
            items = Some { any with reference = Some "Annotation" };
          } );
        ( "motivation",
          {
            any with
            kinds = Some [ String; Null ];
            variants =
              [
                { any with kinds = Some [ Null ] };
                { any with reference = Some "Motivation" };
              ];
          } );
        ("total", { any with kinds = Some [ Number ] });
      ];
  }

let shape_141 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "entityTypes" ];
    members =
      [
        ( "entityTypes",
          {
            any with
            kinds = Some [ Array ];
            items = Some { any with kinds = Some [ String ] };
          } );
      ];
  }

let shape_142 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "events"; "total"; "resourceId" ];
    members =
      [
        ( "events",
          {
            any with
            kinds = Some [ Array ];
            items = Some { any with reference = Some "AttributedEvent" };
          } );
        ("resourceId", { any with reference = Some "ResourceId" });
        ("total", { any with kinds = Some [ Number ] });
      ];
  }

let shape_143 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "referencedBy" ];
    members =
      [
        ( "referencedBy",
          {
            any with
            kinds = Some [ Array ];
            items =
              Some
                {
                  any with
                  reference = Some "GetReferencedByResponseReferencedByItem";
                };
          } );
      ];
  }

let shape_144 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "id"; "target" ];
    members =
      [
        ("id", { any with reference = Some "AnnotationId" });
        ( "resourceName",
          { any with kinds = Some [ String ]; min_length = Some 1 } );
        ( "target",
          {
            any with
            kinds = Some [ Object ];
            required = [ "source"; "selector" ];
            members =
              [
                ( "selector",
                  {
                    any with
                    kinds = Some [ Object ];
                    required = [ "exact" ];
                    members =
                      [ ("exact", { any with kinds = Some [ String ] }) ];
                  } );
                ("source", { any with reference = Some "ResourceId" });
              ];
          } );
      ];
  }

let shape_145 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "sourceResource"; "expiresAt" ];
    members =
      [
        ("expiresAt", { any with kinds = Some [ String ] });
        ("sourceResource", { any with reference = Some "ResourceDescriptor" });
      ];
  }

let shape_146 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "resource"; "annotations" ];
    members =
      [
        ( "annotations",
          {
            any with
            kinds = Some [ Array ];
            items = Some { any with reference = Some "Annotation" };
          } );
        ("resource", { any with reference = Some "ResourceDescriptor" });
      ];
  }

let shape_147 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "tagSchemas" ];
    members =
      [
        ( "tagSchemas",
          {
            any with
            kinds = Some [ Array ];
            items = Some { any with reference = Some "TagSchema" };
          } );
      ];
  }

let shape_148 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "id"; "type"; "label"; "annotation" ];
    members =
      [
        ("annotation", { any with reference = Some "Annotation" });
        ( "entityTypes",
          {
            any with
            kinds = Some [ Array ];
            items = Some { any with kinds = Some [ String ] };
          } );
        ("id", { any with reference = Some "AnnotationId" });
        ("label", { any with kinds = Some [ String ] });
        ("metadata", { any with kinds = Some [ Object ] });
        ( "type",
          {
            any with
            kinds = Some [ String ];
            enum = Some [ `Stringlit "\"annotation\"" ];
          } );
      ];
  }

let shape_149 () =
  {
    any with
    kinds = Some [ Object ];
    variants =
      [
        { any with reference = Some "Neo4jGraphConfig" };
        { any with reference = Some "JanusGraphConfig" };
        { any with reference = Some "NeptuneGraphConfig" };
        { any with reference = Some "MemoryGraphConfig" };
      ];
    discriminator =
      Some
        ( "type",
          [ ("neo4j", 0); ("janusgraph", 1); ("neptune", 2); ("memory", 3) ] );
  }

let shape_150 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "id"; "type"; "label" ];
    members =
      [
        ( "entityTypes",
          {
            any with
            kinds = Some [ Array ];
            items = Some { any with kinds = Some [ String ] };
          } );
        ("id", { any with reference = Some "ResourceId" });
        ("label", { any with kinds = Some [ String ] });
        ("metadata", { any with kinds = Some [ Object ] });
        ( "type",
          {
            any with
            kinds = Some [ String ];
            enum = Some [ `Stringlit "\"resource\"" ];
          } );
      ];
  }

let shape_151 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "status"; "message"; "version"; "timestamp" ];
    members =
      [
        ("message", { any with kinds = Some [ String ] });
        ("status", { any with kinds = Some [ String ] });
        ("timestamp", { any with kinds = Some [ String ] });
        ("version", { any with kinds = Some [ String ] });
      ];
  }

let shape_152 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "motivation" ];
    members =
      [
        ("density", { any with kinds = Some [ Number ] });
        ("instructions", { any with kinds = Some [ String ] });
        ( "motivation",
          {
            any with
            kinds = Some [ String ];
            enum = Some [ `Stringlit "\"highlighting\"" ];
          } );
        ("sourceLanguage", { any with kinds = Some [ String ] });
      ];
    closed = Some [ "density"; "instructions"; "motivation"; "sourceLanguage" ];
  }

let shape_153 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "kind"; "host"; "port"; "protocol" ];
    members =
      [
        ("host", { any with kinds = Some [ String ] });
        ( "kind",
          {
            any with
            kinds = Some [ String ];
            enum = Some [ `Stringlit "\"http\"" ];
          } );
        ( "port",
          {
            any with
            kinds = Some [ Integer ];
            minimum = Some "1";
            maximum = Some "65535";
          } );
        ( "protocol",
          {
            any with
            kinds = Some [ String ];
            enum = Some [ `Stringlit "\"http\""; `Stringlit "\"https\"" ];
          } );
      ];
  }

let shape_154 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "contextTokens"; "maxOutputTokens" ];
    members =
      [
        ("acceptsTemperature", { any with kinds = Some [ Boolean ] });
        ("contextTokens", { any with kinds = Some [ Number ] });
        ("maxOutputTokens", { any with kinds = Some [ Number ] });
      ];
  }

let shape_155 () = { any with kinds = Some [ Object ] }

let shape_156 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "response" ];
    members =
      [
        ( "response",
          {
            any with
            kinds = Some [ Object ];
            required = [ "limits" ];
            members =
              [
                ( "limits",
                  {
                    any with
                    kinds = Some [ Array ];
                    items = Some { any with reference = Some "EngineLimits" };
                  } );
              ];
          } );
      ];
  }

let shape_157 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "type"; "host"; "port" ];
    members =
      [
        ("host", { any with kinds = Some [ String ]; min_length = Some 1 });
        ( "port",
          {
            any with
            kinds = Some [ Integer ];
            minimum = Some "1";
            maximum = Some "65535";
          } );
        ( "type",
          {
            any with
            kinds = Some [ String ];
            enum = Some [ `Stringlit "\"janusgraph\"" ];
          } );
      ];
    closed = Some [ "host"; "port"; "type" ];
  }

let shape_158 () =
  {
    any with
    kinds = Some [ Object ];
    variants =
      [
        { any with reference = Some "JobPending" };
        { any with reference = Some "JobRunning" };
        { any with reference = Some "JobComplete" };
        { any with reference = Some "JobFailed" };
        { any with reference = Some "JobCancelled" };
      ];
    discriminator =
      Some
        ( "status",
          [
            ("pending", 0);
            ("running", 1);
            ("complete", 2);
            ("failed", 3);
            ("cancelled", 4);
          ] );
  }

let shape_159 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "jobId"; "jobType"; "resourceId"; "holder"; "requester" ];
    members =
      [
        ("_userId", { any with reference = Some "UserId" });
        ("holder", { any with reference = Some "UserId" });
        ("jobId", { any with reference = Some "JobId" });
        ("jobType", { any with reference = Some "JobType" });
        ("requester", { any with reference = Some "UserId" });
        ("resourceId", { any with reference = Some "ResourceId" });
      ];
  }

let shape_160 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "jobId"; "jobType"; "resourceId"; "holder"; "requester" ];
    members =
      [
        ("holder", { any with reference = Some "UserId" });
        ("jobId", { any with reference = Some "JobId" });
        ("jobType", { any with reference = Some "JobType" });
        ("requester", { any with reference = Some "UserId" });
        ("resourceId", { any with reference = Some "ResourceId" });
      ];
  }

let shape_161 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "resourceId"; "jobId"; "jobType" ];
    members =
      [
        ("_userId", { any with reference = Some "UserId" });
        ("annotationId", { any with reference = Some "AnnotationId" });
        ( "completedUnits",
          {
            any with
            kinds = Some [ Array ];
            items = Some { any with kinds = Some [ String ] };
          } );
        ("jobId", { any with reference = Some "JobId" });
        ("jobType", { any with reference = Some "JobType" });
        ("resourceId", { any with reference = Some "ResourceId" });
        ( "unitCursors",
          {
            any with
            kinds = Some [ Object ];
            values = Some { any with reference = Some "UnitCursor" };
          } );
      ];
  }

let shape_162 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "jobId" ];
    members = [ ("jobId", { any with reference = Some "JobId" }) ];
  }

let shape_163 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "cancelled" ];
    members = [ ("cancelled", { any with kinds = Some [ Boolean ] }) ];
  }

let shape_164 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "status"; "metadata"; "params"; "completedAt" ];
    members =
      [
        ("completedAt", { any with kinds = Some [ String ] });
        ("metadata", { any with reference = Some "JobMetadata" });
        ("params", { any with reference = Some "JobParams" });
        ("startedAt", { any with kinds = Some [ String ] });
        ( "status",
          {
            any with
            kinds = Some [ String ];
            enum = Some [ `Stringlit "\"cancelled\"" ];
          } );
      ];
    closed = Some [ "completedAt"; "metadata"; "params"; "startedAt"; "status" ];
  }

let shape_165 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "jobId"; "completedUnits" ];
    members =
      [
        ("_userId", { any with reference = Some "UserId" });
        ( "completedUnits",
          {
            any with
            kinds = Some [ Array ];
            items = Some { any with kinds = Some [ String ] };
          } );
        ("jobId", { any with reference = Some "JobId" });
        ( "unitCursors",
          {
            any with
            kinds = Some [ Object ];
            values = Some { any with reference = Some "UnitCursor" };
          } );
      ];
  }

let shape_166 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "accepts" ];
    members =
      [
        ( "_roles",
          {
            any with
            kinds = Some [ Array ];
            items = Some { any with kinds = Some [ String ] };
          } );
        ("_userId", { any with reference = Some "UserId" });
        ( "accepts",
          {
            any with
            kinds = Some [ Array ];
            min_items = Some 1;
            items = Some { any with reference = Some "JobFilter" };
          } );
      ];
  }

let shape_167 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "response" ];
    members = [ ("response", { any with reference = Some "JobRunning" }) ];
    closed = Some [ "response" ];
  }

let shape_168 () =
  {
    any with
    kinds = Some [ Object ];
    required =
      [ "status"; "metadata"; "params"; "startedAt"; "completedAt"; "result" ];
    members =
      [
        ("completedAt", { any with kinds = Some [ String ] });
        ("metadata", { any with reference = Some "JobMetadata" });
        ("params", { any with reference = Some "JobParams" });
        ("result", { any with reference = Some "JobStoredResult" });
        ("startedAt", { any with kinds = Some [ String ] });
        ( "status",
          {
            any with
            kinds = Some [ String ];
            enum = Some [ `Stringlit "\"complete\"" ];
          } );
      ];
    closed =
      Some
        [ "completedAt"; "metadata"; "params"; "result"; "startedAt"; "status" ];
  }

let shape_169 () =
  {
    any with
    kinds = Some [ Object ];
    variants =
      [
        { any with reference = Some "MarkJobCompleteCommand" };
        { any with reference = Some "YieldJobCompleteCommand" };
      ];
    discriminator = Some ("jobType", [ ("mark", 0); ("yield", 1) ]);
  }

let shape_170 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "jobId"; "jobType" ];
    members =
      [
        ("annotationId", { any with reference = Some "AnnotationId" });
        ("annotationUri", { any with kinds = Some [ String ] });
        ("attempt", { any with kinds = Some [ Integer ] });
        ("durability", { any with reference = Some "DurabilityEvidence" });
        ("foundCount", { any with kinds = Some [ Integer ] });
        ("jobId", { any with reference = Some "JobId" });
        ("jobType", { any with reference = Some "JobType" });
        ("result", { any with kinds = Some [ Object ] });
        ("resultResourceId", { any with reference = Some "ResourceId" });
        ("totalSteps", { any with kinds = Some [ Integer ] });
      ];
  }

let shape_171 () =
  {
    any with
    kinds = Some [ Object ];
    variants =
      [
        { any with reference = Some "MarkJobCreateCommand" };
        { any with reference = Some "YieldJobCreateCommand" };
      ];
    discriminator = Some ("jobType", [ ("mark", 0); ("yield", 1) ]);
  }

let shape_172 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "response" ];
    members =
      [ ("response", { any with reference = Some "JobCreatedResultResponse" }) ];
  }

let shape_173 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "jobId" ];
    members = [ ("jobId", { any with reference = Some "JobId" }) ];
  }

let shape_174 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "declined"; "reason" ];
    members =
      [
        ( "declined",
          { any with kinds = Some [ Boolean ]; enum = Some [ `Bool true ] } );
        ( "reason",
          {
            any with
            kinds = Some [ String ];
            enum =
              Some
                [
                  `Stringlit "\"no-text-layer\"";
                  `Stringlit "\"encrypted\"";
                  `Stringlit "\"corrupt\"";
                  `Stringlit "\"too-large\"";
                  `Stringlit "\"empty\"";
                ];
          } );
      ];
    closed = Some [ "declined"; "reason" ];
  }

let shape_175 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "resourceId"; "jobId"; "jobType"; "error" ];
    members =
      [
        ("_userId", { any with reference = Some "UserId" });
        ("annotationId", { any with reference = Some "AnnotationId" });
        ("attempt", { any with kinds = Some [ Integer ] });
        ( "completedUnits",
          {
            any with
            kinds = Some [ Array ];
            items = Some { any with kinds = Some [ String ] };
          } );
        ("durability", { any with reference = Some "DurabilityEvidence" });
        ("error", { any with kinds = Some [ String ] });
        ("failureClass", { any with reference = Some "FailureClass" });
        ("jobId", { any with reference = Some "JobId" });
        ("jobType", { any with reference = Some "JobType" });
        ("resourceId", { any with reference = Some "ResourceId" });
        ( "unitCursors",
          {
            any with
            kinds = Some [ Object ];
            values = Some { any with reference = Some "UnitCursor" };
          } );
        ("willRetry", { any with kinds = Some [ Boolean ] });
      ];
  }

let shape_176 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "status"; "metadata"; "params"; "completedAt"; "error" ];
    members =
      [
        ("completedAt", { any with kinds = Some [ String ] });
        ("error", { any with kinds = Some [ String ] });
        ("failureClass", { any with reference = Some "FailureClass" });
        ("metadata", { any with reference = Some "JobMetadata" });
        ("params", { any with reference = Some "JobParams" });
        ("startedAt", { any with kinds = Some [ String ] });
        ( "status",
          {
            any with
            kinds = Some [ String ];
            enum = Some [ `Stringlit "\"failed\"" ];
          } );
      ];
    closed =
      Some
        [
          "completedAt";
          "error";
          "failureClass";
          "metadata";
          "params";
          "startedAt";
          "status";
        ];
  }

let shape_177 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "jobId"; "jobType"; "error" ];
    members =
      [
        ("annotationId", { any with reference = Some "AnnotationId" });
        ("attempt", { any with kinds = Some [ Integer ] });
        ("durability", { any with reference = Some "DurabilityEvidence" });
        ("error", { any with kinds = Some [ String ] });
        ("failureClass", { any with reference = Some "FailureClass" });
        ("jobId", { any with reference = Some "JobId" });
        ("jobType", { any with reference = Some "JobType" });
        ("willRetry", { any with kinds = Some [ Boolean ] });
      ];
  }

let shape_178 () =
  {
    any with
    kinds = Some [ Object ];
    variants =
      [
        { any with reference = Some "MarkJobFilter" };
        { any with reference = Some "YieldJobFilter" };
      ];
    discriminator = Some ("jobType", [ ("mark", 0); ("yield", 1) ]);
  }

let shape_179 () =
  {
    any with
    kinds = Some [ String ];
    pattern =
      Some
        [ ([ (45, 45); (48, 57); (65, 90); (95, 95); (97, 122) ], 1, Some 128) ];
  }

let shape_180 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "id"; "type"; "userId"; "created"; "retryCount"; "maxRetries" ];
    members =
      [
        ( "completedUnits",
          {
            any with
            kinds = Some [ Array ];
            items = Some { any with kinds = Some [ String ] };
          } );
        ("created", { any with kinds = Some [ String ] });
        ("id", { any with reference = Some "JobId" });
        ("maxRetries", { any with kinds = Some [ Integer ]; minimum = Some "0" });
        ("retryCount", { any with kinds = Some [ Integer ]; minimum = Some "0" });
        ("type", { any with reference = Some "JobType" });
        ( "unitCursors",
          {
            any with
            kinds = Some [ Object ];
            values = Some { any with reference = Some "UnitCursor" };
          } );
        ("userId", { any with reference = Some "UserId" });
      ];
    closed =
      Some
        [
          "completedUnits";
          "created";
          "id";
          "maxRetries";
          "retryCount";
          "type";
          "unitCursors";
          "userId";
        ];
  }

let shape_181 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "resourceId" ];
    members =
      [
        ("resourceId", { any with reference = Some "ResourceId" });
        ("schema", { any with reference = Some "TagSchema" });
      ];
  }

let shape_182 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "status"; "metadata"; "params" ];
    members =
      [
        ("metadata", { any with reference = Some "JobMetadata" });
        ("params", { any with reference = Some "JobParams" });
        ( "status",
          {
            any with
            kinds = Some [ String ];
            enum = Some [ `Stringlit "\"pending\"" ];
          } );
      ];
    closed = Some [ "metadata"; "params"; "status" ];
  }

let shape_183 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "percentage" ];
    members =
      [
        ("annotationId", { any with reference = Some "AnnotationId" });
        ( "completedItems",
          {
            any with
            kinds = Some [ Array ];
            items =
              Some
                {
                  any with
                  kinds = Some [ Object ];
                  required = [ "value"; "foundCount" ];
                  members =
                    [
                      ("foundCount", { any with kinds = Some [ Integer ] });
                      ("persistedCount", { any with kinds = Some [ Integer ] });
                      ( "underReported",
                        {
                          any with
                          kinds = Some [ Object ];
                          required = [ "pieces"; "found"; "counted" ];
                          members =
                            [
                              ("counted", { any with kinds = Some [ Integer ] });
                              ("found", { any with kinds = Some [ Integer ] });
                              ("pieces", { any with kinds = Some [ Integer ] });
                            ];
                        } );
                      ("value", { any with kinds = Some [ String ] });
                    ];
                };
          } );
        ( "current",
          {
            any with
            kinds = Some [ Object ];
            required = [ "kind"; "value" ];
            members =
              [
                ( "kind",
                  {
                    any with
                    kinds = Some [ String ];
                    enum =
                      Some
                        [
                          `Stringlit "\"entity-type\"";
                          `Stringlit "\"category\"";
                        ];
                  } );
                ("value", { any with kinds = Some [ String ] });
              ];
          } );
        ("entitiesEmitted", { any with kinds = Some [ Integer ] });
        ("entitiesExpected", { any with kinds = Some [ Integer ] });
        ("entitiesFound", { any with kinds = Some [ Integer ] });
        ("message", { any with reference = Some "JobProgressMessage" });
        ("percentage", { any with kinds = Some [ Number ] });
        ("processed", { any with kinds = Some [ Integer ] });
        ( "requestParams",
          {
            any with
            kinds = Some [ Array ];
            items =
              Some
                {
                  any with
                  kinds = Some [ Object ];
                  required = [ "label"; "value" ];
                  members =
                    [
                      ( "label",
                        {
                          any with
                          kinds = Some [ String ];
                          enum =
                            Some
                              [
                                `Stringlit "\"entity-types\"";
                                `Stringlit "\"instructions\"";
                                `Stringlit "\"tone\"";
                                `Stringlit "\"density\"";
                              ];
                        } );
                      ("value", { any with kinds = Some [ String ] });
                    ];
                };
          } );
        ("total", { any with kinds = Some [ Integer ] });
      ];
  }

let shape_184 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "code" ];
    members =
      [
        ( "code",
          {
            any with
            kinds = Some [ String ];
            enum = Some [ `Stringlit "\"analyzing\"" ];
          } );
      ];
  }

let shape_185 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "code" ];
    members =
      [
        ( "code",
          {
            any with
            kinds = Some [ String ];
            enum = Some [ `Stringlit "\"analyzing-tags\"" ];
          } );
      ];
  }

let shape_186 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "code"; "count"; "motivation" ];
    members =
      [
        ( "code",
          {
            any with
            kinds = Some [ String ];
            enum = Some [ `Stringlit "\"complete-created\"" ];
          } );
        ("count", { any with kinds = Some [ Integer ] });
        ("motivation", { any with reference = Some "Motivation" });
      ];
  }

let shape_187 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "code"; "truncated" ];
    members =
      [
        ( "code",
          {
            any with
            kinds = Some [ String ];
            enum = Some [ `Stringlit "\"complete-generated\"" ];
          } );
        ("truncated", { any with kinds = Some [ Boolean ] });
      ];
  }

let shape_188 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "code"; "count" ];
    members =
      [
        ( "code",
          {
            any with
            kinds = Some [ String ];
            enum = Some [ `Stringlit "\"creating-annotations\"" ];
          } );
        ("count", { any with kinds = Some [ Integer ] });
      ];
  }

let shape_189 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "code" ];
    members =
      [
        ( "code",
          {
            any with
            kinds = Some [ String ];
            enum = Some [ `Stringlit "\"creating-resource\"" ];
          } );
      ];
  }

let shape_190 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "code"; "count" ];
    members =
      [
        ( "code",
          {
            any with
            kinds = Some [ String ];
            enum = Some [ `Stringlit "\"creating-tag-annotations\"" ];
          } );
        ("count", { any with kinds = Some [ Integer ] });
      ];
  }

let shape_191 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "code"; "entityType" ];
    members =
      [
        ( "code",
          {
            any with
            kinds = Some [ String ];
            enum = Some [ `Stringlit "\"detecting-entities\"" ];
          } );
        ("entityType", { any with kinds = Some [ String ] });
      ];
  }

let shape_192 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "code" ];
    members =
      [
        ( "code",
          {
            any with
            kinds = Some [ String ];
            enum = Some [ `Stringlit "\"generating-resource\"" ];
          } );
      ];
  }

let shape_193 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "code" ];
    members =
      [
        ( "code",
          {
            any with
            kinds = Some [ String ];
            enum = Some [ `Stringlit "\"loading\"" ];
          } );
      ];
  }

let shape_194 () =
  {
    any with
    kinds = Some [ Object ];
    variants =
      [
        { any with reference = Some "JobProgressLoading" };
        { any with reference = Some "JobProgressAnalyzing" };
        { any with reference = Some "JobProgressAnalyzingTags" };
        { any with reference = Some "JobProgressGeneratingResource" };
        { any with reference = Some "JobProgressCreatingResource" };
        { any with reference = Some "JobProgressCompleteGenerated" };
        { any with reference = Some "JobProgressDetectingEntities" };
        { any with reference = Some "JobProgressCreatingAnnotations" };
        { any with reference = Some "JobProgressCreatingTagAnnotations" };
        { any with reference = Some "JobProgressCompleteCreated" };
      ];
    discriminator =
      Some
        ( "code",
          [
            ("loading", 0);
            ("analyzing", 1);
            ("analyzing-tags", 2);
            ("generating-resource", 3);
            ("creating-resource", 4);
            ("complete-generated", 5);
            ("detecting-entities", 6);
            ("creating-annotations", 7);
            ("creating-tag-annotations", 8);
            ("complete-created", 9);
          ] );
  }

let shape_195 () =
  {
    any with
    kinds = Some [ Object ];
    variants =
      [
        { any with reference = Some "MarkJobQueuedEvent" };
        { any with reference = Some "YieldJobQueuedEvent" };
      ];
    discriminator = Some ("jobType", [ ("mark", 0); ("yield", 1) ]);
  }

let shape_196 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "job"; "lastProgressAt" ];
    members =
      [
        ("job", { any with reference = Some "Job" });
        ("lastProgressAt", { any with kinds = Some [ String ] });
      ];
    closed = Some [ "job"; "lastProgressAt" ];
  }

let shape_197 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "resourceId"; "jobId"; "jobType"; "percentage" ];
    members =
      [
        ("_userId", { any with reference = Some "UserId" });
        ("annotationId", { any with reference = Some "AnnotationId" });
        ("attempt", { any with kinds = Some [ Integer ] });
        ("jobId", { any with reference = Some "JobId" });
        ("jobType", { any with reference = Some "JobType" });
        ("percentage", { any with kinds = Some [ Number ] });
        ("progress", { any with reference = Some "JobProgress" });
        ("resourceId", { any with reference = Some "ResourceId" });
      ];
  }

let shape_198 () =
  {
    any with
    kinds = Some [ Object ];
    variants =
      [
        { any with reference = Some "MarkJobDone" };
        { any with reference = Some "YieldJobDone" };
        { any with reference = Some "JobDeclined" };
      ];
  }

let shape_199 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "status"; "metadata"; "params"; "startedAt"; "progress" ];
    members =
      [
        ("metadata", { any with reference = Some "JobMetadata" });
        ("params", { any with reference = Some "JobParams" });
        ("progress", { any with reference = Some "JobStoredProgress" });
        ("startedAt", { any with kinds = Some [ String ] });
        ( "status",
          {
            any with
            kinds = Some [ String ];
            enum = Some [ `Stringlit "\"running\"" ];
          } );
      ];
    closed = Some [ "metadata"; "params"; "progress"; "startedAt"; "status" ];
  }

let shape_200 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "resourceId"; "jobId"; "jobType" ];
    members =
      [
        ("_userId", { any with reference = Some "UserId" });
        ("annotationId", { any with reference = Some "AnnotationId" });
        ("attempt", { any with kinds = Some [ Integer ] });
        ("jobId", { any with reference = Some "JobId" });
        ("jobType", { any with reference = Some "JobType" });
        ("resourceId", { any with reference = Some "ResourceId" });
      ];
  }

let shape_201 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "jobId"; "jobType" ];
    members =
      [
        ("annotationId", { any with reference = Some "AnnotationId" });
        ("jobId", { any with reference = Some "JobId" });
        ("jobType", { any with reference = Some "JobType" });
        ("totalSteps", { any with kinds = Some [ Integer ] });
      ];
  }

let shape_202 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "jobId" ];
    members = [ ("jobId", { any with reference = Some "JobId" }) ];
  }

let shape_203 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "jobId"; "type"; "status"; "userId"; "created" ];
    members =
      [
        ("completedAt", { any with kinds = Some [ String ] });
        ("created", { any with kinds = Some [ String ] });
        ("error", { any with kinds = Some [ String ] });
        ("failureClass", { any with reference = Some "FailureClass" });
        ("jobId", { any with reference = Some "JobId" });
        ("progress", { any with reference = Some "JobStoredProgress" });
        ("result", { any with reference = Some "JobStoredResult" });
        ("startedAt", { any with kinds = Some [ String ] });
        ( "status",
          {
            any with
            kinds = Some [ String ];
            enum =
              Some
                [
                  `Stringlit "\"pending\"";
                  `Stringlit "\"running\"";
                  `Stringlit "\"complete\"";
                  `Stringlit "\"failed\"";
                  `Stringlit "\"cancelled\"";
                ];
          } );
        ("type", { any with reference = Some "JobType" });
        ("userId", { any with reference = Some "UserId" });
      ];
  }

let shape_204 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "response" ];
    members =
      [ ("response", { any with reference = Some "JobStatusResponse" }) ];
  }

let shape_205 () =
  {
    any with
    kinds = Some [ Object ];
    variants =
      [
        { any with reference = Some "JobProgress" };
        { any with kinds = Some [ Object ]; closed = Some [] };
      ];
  }

let shape_206 () =
  {
    any with
    kinds = Some [ Object ];
    variants =
      [
        { any with reference = Some "JobResult" };
        { any with kinds = Some [ Object ]; closed = Some [] };
      ];
  }

let shape_207 () =
  {
    any with
    kinds = Some [ String ];
    enum = Some [ `Stringlit "\"mark\""; `Stringlit "\"yield\"" ];
  }

let shape_208 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "name"; "domain" ];
    members =
      [
        ("domain", { any with kinds = Some [ String ] });
        ("gitBranch", { any with kinds = Some [ String ] });
        ("name", { any with kinds = Some [ String ] });
      ];
  }

let shape_209 () =
  {
    any with
    kinds = Some [ Object ];
    variants =
      [
        { any with reference = Some "HttpEndpoint" };
        { any with reference = Some "LocalEndpoint" };
      ];
    discriminator = Some ("kind", [ ("http", 0); ("local", 1) ]);
  }

let shape_210 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "name"; "domain" ];
    members =
      [
        ( "domain",
          {
            any with
            kinds = Some [ String ];
            pattern =
              Some
                [
                  ( [
                      (0, 8);
                      (14, 31);
                      (33, 159);
                      (161, 5759);
                      (5761, 8191);
                      (8203, 8231);
                      (8234, 8238);
                      (8240, 8286);
                      (8288, 12287);
                      (12289, 65278);
                      (65280, 1114111);
                    ],
                    1,
                    None );
                ];
            min_length = Some 1;
          } );
        ("name", { any with kinds = Some [ String ]; min_length = Some 1 });
      ];
    closed = Some [ "domain"; "name" ];
  }

let shape_211 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "at" ];
    members =
      [
        ("at", { any with kinds = Some [ String ] });
        ("gitBranch", { any with kinds = Some [ String ] });
      ];
  }

let shape_212 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "id"; "label"; "endpoint" ];
    members =
      [
        ("endpoint", { any with reference = Some "KbEndpoint" });
        ("id", { any with kinds = Some [ String ] });
        ("label", { any with kinds = Some [ String ] });
      ];
  }

let shape_213 () =
  {
    any with
    kinds = Some [ Object ];
    all_of =
      [
        { any with reference = Some "KbTarget" };
        { any with reference = Some "NewKnowledgeBase" };
      ];
  }

let shape_214 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "nodes"; "edges" ];
    members =
      [
        ( "edges",
          {
            any with
            kinds = Some [ Array ];
            items =
              Some
                {
                  any with
                  kinds = Some [ Object ];
                  required = [ "source"; "target"; "type" ];
                  members =
                    [
                      ("bidirectional", { any with kinds = Some [ Boolean ] });
                      ("metadata", { any with kinds = Some [ Object ] });
                      ("source", { any with kinds = Some [ String ] });
                      ("target", { any with kinds = Some [ String ] });
                      ("type", { any with kinds = Some [ String ] });
                    ];
                };
          } );
        ( "nodes",
          {
            any with
            kinds = Some [ Array ];
            items =
              Some
                {
                  any with
                  kinds = Some [ Object ];
                  variants =
                    [
                      { any with reference = Some "GraphResourceNode" };
                      { any with reference = Some "GraphAnnotationNode" };
                    ];
                  discriminator =
                    Some ("type", [ ("resource", 0); ("annotation", 1) ]);
                };
          } );
        ("truncated", { any with kinds = Some [ Boolean ] });
      ];
  }

let shape_215 () =
  {
    any with
    kinds = Some [ Object ];
    required =
      [
        "kb";
        "gatewayUrl";
        "identity";
        "archivist";
        "graph";
        "vectors";
        "embedding";
        "matcher";
        "gatherer";
        "modelCatalogue";
        "gather";
        "search";
        "port";
        "logLevel";
        "logFormat";
      ];
    members =
      [
        ("archivist", { any with reference = Some "ServiceAddress" });
        ("embedding", { any with reference = Some "EmbeddingConfig" });
        ("gatewayUrl", { any with kinds = Some [ String ]; min_length = Some 1 });
        ( "gather",
          {
            any with
            kinds = Some [ Object ];
            required = [ "settleTimeoutMs" ];
            members =
              [
                ( "settleTimeoutMs",
                  { any with kinds = Some [ Integer ]; minimum = Some "1" } );
              ];
            closed = Some [ "settleTimeoutMs" ];
          } );
        ("gatherer", { any with reference = Some "LibrarianEngineConfig" });
        ("graph", { any with reference = Some "GraphConfig" });
        ("identity", { any with reference = Some "ServiceIdentity" });
        ("kb", { any with reference = Some "KbIdentity" });
        ("logFormat", { any with reference = Some "LogFormat" });
        ("logLevel", { any with reference = Some "LogLevel" });
        ("matcher", { any with reference = Some "LibrarianEngineConfig" });
        ( "modelCatalogue",
          { any with kinds = Some [ String ]; min_length = Some 1 } );
        ( "port",
          {
            any with
            kinds = Some [ Integer ];
            minimum = Some "1";
            maximum = Some "65535";
          } );
        ( "search",
          {
            any with
            kinds = Some [ Object ];
            required = [ "semanticFloor" ];
            members =
              [
                ( "semanticFloor",
                  {
                    any with
                    kinds = Some [ Number ];
                    minimum = Some "0";
                    maximum = Some "1";
                  } );
              ];
            closed = Some [ "semanticFloor" ];
          } );
        ("vectors", { any with reference = Some "VectorsConfig" });
      ];
    closed =
      Some
        [
          "archivist";
          "embedding";
          "gatewayUrl";
          "gather";
          "gatherer";
          "graph";
          "identity";
          "kb";
          "logFormat";
          "logLevel";
          "matcher";
          "modelCatalogue";
          "port";
          "search";
          "vectors";
        ];
  }

let shape_216 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "engine"; "baseUrl" ];
    members =
      [
        ("apiKeyEnv", { any with kinds = Some [ String ]; min_length = Some 1 });
        ("baseUrl", { any with kinds = Some [ String ]; min_length = Some 1 });
        ("engine", { any with reference = Some "Engine" });
      ];
    closed = Some [ "apiKeyEnv"; "baseUrl"; "engine" ];
  }

let shape_217 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "status"; "kb"; "actors" ];
    members =
      [
        ( "actors",
          {
            any with
            kinds = Some [ Array ];
            min_items = Some 2;
            items =
              Some
                {
                  any with
                  kinds = Some [ String ];
                  enum =
                    Some [ `Stringlit "\"matcher\""; `Stringlit "\"gatherer\"" ];
                };
          } );
        ( "kb",
          {
            any with
            kinds = Some [ String ];
            pattern =
              Some
                [
                  ([ (100, 100) ], 1, Some 1);
                  ([ (105, 105) ], 1, Some 1);
                  ([ (100, 100) ], 1, Some 1);
                  ([ (58, 58) ], 1, Some 1);
                  ([ (119, 119) ], 1, Some 1);
                  ([ (101, 101) ], 1, Some 1);
                  ([ (98, 98) ], 1, Some 1);
                  ([ (58, 58) ], 1, Some 1);
                  ( [
                      (0, 8);
                      (14, 31);
                      (33, 159);
                      (161, 5759);
                      (5761, 8191);
                      (8203, 8231);
                      (8234, 8238);
                      (8240, 8286);
                      (8288, 12287);
                      (12289, 65278);
                      (65280, 1114111);
                    ],
                    1,
                    None );
                ];
          } );
        ( "status",
          {
            any with
            kinds = Some [ String ];
            enum = Some [ `Stringlit "\"ok\"" ];
          } );
      ];
    closed = Some [ "actors"; "kb"; "status" ];
  }

let shape_218 () =
  {
    any with
    kinds = Some [ Object ];
    all_of =
      [
        { any with reference = Some "ErrorResponse" };
        {
          any with
          kinds = Some [ Object ];
          required = [ "code" ];
          members =
            [
              ( "code",
                {
                  any with
                  kinds = Some [ String ];
                  enum =
                    Some
                      [
                        `Stringlit "\"streams\"";
                        `Stringlit "\"emit-rate\"";
                        `Stringlit "\"unanswered-requests\"";
                        `Stringlit "\"capacity\"";
                        `Stringlit "\"refusal-rate\"";
                      ];
                } );
            ];
        };
      ];
  }

let shape_219 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "motivation"; "entityTypes" ];
    members =
      [
        ( "entityTypes",
          {
            any with
            kinds = Some [ Array ];
            min_items = Some 1;
            items = Some { any with kinds = Some [ String ] };
          } );
        ("includeDescriptiveReferences", { any with kinds = Some [ Boolean ] });
        ("language", { any with kinds = Some [ String ] });
        ( "motivation",
          {
            any with
            kinds = Some [ String ];
            enum = Some [ `Stringlit "\"linking\"" ];
          } );
        ("sourceLanguage", { any with kinds = Some [ String ] });
      ];
    closed =
      Some
        [
          "entityTypes";
          "includeDescriptiveReferences";
          "language";
          "motivation";
          "sourceLanguage";
        ];
  }

let shape_220 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "resources"; "total"; "offset"; "limit" ];
    members =
      [
        ("limit", { any with kinds = Some [ Number ] });
        ("offset", { any with kinds = Some [ Number ] });
        ( "resources",
          {
            any with
            kinds = Some [ Array ];
            items = Some { any with reference = Some "ResourceDescriptor" };
          } );
        ("total", { any with kinds = Some [ Number ] });
      ];
  }

let shape_221 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "kind"; "kbId" ];
    members =
      [
        ("kbId", { any with kinds = Some [ String ] });
        ( "kind",
          {
            any with
            kinds = Some [ String ];
            enum = Some [ `Stringlit "\"local\"" ];
          } );
      ];
  }

let shape_222 () =
  {
    any with
    kinds = Some [ String ];
    enum = Some [ `Stringlit "\"json\""; `Stringlit "\"simple\"" ];
  }

let shape_223 () =
  {
    any with
    kinds = Some [ String ];
    enum =
      Some
        [
          `Stringlit "\"error\"";
          `Stringlit "\"warn\"";
          `Stringlit "\"info\"";
          `Stringlit "\"http\"";
          `Stringlit "\"debug\"";
        ];
  }

let shape_224 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "resourceId" ];
    members =
      [
        ("_userId", { any with reference = Some "UserId" });
        ("keepFile", { any with kinds = Some [ Boolean ] });
        ("resourceId", { any with reference = Some "ResourceId" });
        ("storageUri", { any with kinds = Some [ String ] });
      ];
  }

let shape_225 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "resourceId"; "annotations" ];
    members =
      [
        ( "_roles",
          {
            any with
            kinds = Some [ Array ];
            items = Some { any with kinds = Some [ String ] };
          } );
        ("_userId", { any with reference = Some "UserId" });
        ( "annotations",
          {
            any with
            kinds = Some [ Array ];
            items = Some { any with reference = Some "Annotation" };
          } );
        ("jobId", { any with reference = Some "JobId" });
        ("resourceId", { any with reference = Some "ResourceId" });
      ];
  }

let shape_226 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "response" ];
    members =
      [
        ( "response",
          {
            any with
            kinds = Some [ Object ];
            required = [ "persisted"; "annotationIds" ];
            members =
              [
                ( "annotationIds",
                  {
                    any with
                    kinds = Some [ Array ];
                    items = Some { any with reference = Some "AnnotationId" };
                  } );
                ("persisted", { any with kinds = Some [ Integer ] });
              ];
          } );
      ];
  }

let shape_227 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "response" ];
    members =
      [ ("response", { any with reference = Some "MarkCreateOkResponse" }) ];
  }

let shape_228 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "annotationId" ];
    members = [ ("annotationId", { any with reference = Some "AnnotationId" }) ];
  }

let shape_229 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "resourceId"; "request" ];
    members =
      [
        ("request", { any with reference = Some "CreateAnnotationRequest" });
        ("resourceId", { any with reference = Some "ResourceId" });
      ];
  }

let shape_230 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "resourceId"; "motivation" ];
    members =
      [
        ("motivation", { any with reference = Some "Motivation" });
        ("resourceId", { any with reference = Some "ResourceId" });
      ];
  }

let shape_231 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "annotationId" ];
    members =
      [
        ("_userId", { any with reference = Some "UserId" });
        ("annotationId", { any with reference = Some "AnnotationId" });
        ("resourceId", { any with reference = Some "ResourceId" });
      ];
  }

let shape_232 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "response" ];
    members =
      [
        ( "response",
          {
            any with
            kinds = Some [ Object ];
            required = [ "annotationId" ];
            members =
              [ ("annotationId", { any with reference = Some "AnnotationId" }) ];
          } );
      ];
  }

let shape_233 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "resourceId"; "jobId"; "jobType" ];
    members =
      [
        ("_userId", { any with reference = Some "UserId" });
        ("attempt", { any with kinds = Some [ Integer ] });
        ("durability", { any with reference = Some "DurabilityEvidence" });
        ("jobId", { any with reference = Some "JobId" });
        ( "jobType",
          {
            any with
            kinds = Some [ String ];
            enum = Some [ `Stringlit "\"mark\"" ];
          } );
        ("resourceId", { any with reference = Some "ResourceId" });
        ("result", { any with reference = Some "MarkJobResult" });
      ];
  }

let shape_234 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "jobType"; "resourceId"; "params" ];
    members =
      [
        ( "_roles",
          {
            any with
            kinds = Some [ Array ];
            items = Some { any with kinds = Some [ String ] };
          } );
        ("_userId", { any with reference = Some "UserId" });
        ( "jobType",
          {
            any with
            kinds = Some [ String ];
            enum = Some [ `Stringlit "\"mark\"" ];
          } );
        ("params", { any with reference = Some "MarkJobParams" });
        ("resourceId", { any with reference = Some "ResourceId" });
      ];
    closed = Some [ "_roles"; "_userId"; "jobType"; "params"; "resourceId" ];
  }

let shape_235 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "found"; "persisted" ];
    members =
      [
        ( "byCategory",
          {
            any with
            kinds = Some [ Object ];
            values = Some { any with kinds = Some [ Integer ] };
          } );
        ("errors", { any with kinds = Some [ Integer ]; minimum = Some "1" });
        ("found", { any with kinds = Some [ Integer ]; minimum = Some "0" });
        ("persisted", { any with kinds = Some [ Integer ]; minimum = Some "0" });
        ( "uncheckedPieces",
          { any with kinds = Some [ Integer ]; minimum = Some "1" } );
        ("underReportedPieces", { any with kinds = Some [ Integer ] });
      ];
    closed =
      Some
        [
          "byCategory";
          "errors";
          "found";
          "persisted";
          "uncheckedPieces";
          "underReportedPieces";
        ];
  }

let shape_236 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "jobType"; "params" ];
    members =
      [
        ( "jobType",
          {
            any with
            kinds = Some [ String ];
            enum = Some [ `Stringlit "\"mark\"" ];
          } );
        ( "params",
          {
            any with
            kinds = Some [ Object ];
            required = [ "motivation" ];
            members =
              [ ("motivation", { any with reference = Some "Motivation" }) ];
            closed = Some [ "motivation" ];
          } );
      ];
    closed = Some [ "jobType"; "params" ];
  }

let shape_237 () =
  {
    any with
    kinds = Some [ Object ];
    variants =
      [
        { any with reference = Some "HighlightingJobParams" };
        { any with reference = Some "CommentingJobParams" };
        { any with reference = Some "AssessingJobParams" };
        { any with reference = Some "LinkingJobParams" };
        { any with reference = Some "TaggingJobParams" };
      ];
    discriminator =
      Some
        ( "motivation",
          [
            ("highlighting", 0);
            ("commenting", 1);
            ("assessing", 2);
            ("linking", 3);
            ("tagging", 4);
          ] );
  }

let shape_238 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "jobId"; "jobType"; "resourceId"; "userId"; "params" ];
    members =
      [
        ("jobId", { any with reference = Some "JobId" });
        ( "jobType",
          {
            any with
            kinds = Some [ String ];
            enum = Some [ `Stringlit "\"mark\"" ];
          } );
        ("params", { any with reference = Some "MarkJobParams" });
        ("resourceId", { any with reference = Some "ResourceId" });
        ("userId", { any with reference = Some "UserId" });
      ];
  }

let shape_239 () =
  {
    any with
    kinds = Some [ Object ];
    variants =
      [
        { any with reference = Some "MarkJobDone" };
        { any with reference = Some "JobDeclined" };
      ];
  }

let shape_240 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "source"; "selector"; "motivation" ];
    members =
      [
        ("motivation", { any with reference = Some "Motivation" });
        ("selector", { any with reference = Some "AnnotationSelector" });
        ("source", { any with reference = Some "ResourceId" });
      ];
  }

let shape_241 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "source"; "motivation"; "selector" ];
    members =
      [
        ("body", { any with reference = Some "AnnotationBodies" });
        ("motivation", { any with reference = Some "Motivation" });
        ("selector", { any with reference = Some "AnnotationSelector" });
        ("source", { any with reference = Some "ResourceId" });
      ];
  }

let shape_242 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "resourceId" ];
    members =
      [
        ("_userId", { any with reference = Some "UserId" });
        ("resourceId", { any with reference = Some "ResourceId" });
        ("storageUri", { any with kinds = Some [ String ] });
      ];
  }

let shape_243 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "annotationId"; "resourceId"; "operations" ];
    members =
      [
        ("_userId", { any with reference = Some "UserId" });
        ("annotationId", { any with reference = Some "AnnotationId" });
        ( "operations",
          {
            any with
            kinds = Some [ Array ];
            items = Some { any with reference = Some "BodyOperation" };
          } );
        ("resourceId", { any with reference = Some "ResourceId" });
      ];
  }

let shape_244 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "resourceId"; "currentEntityTypes"; "updatedEntityTypes" ];
    members =
      [
        ("_userId", { any with reference = Some "UserId" });
        ( "currentEntityTypes",
          {
            any with
            kinds = Some [ Array ];
            items = Some { any with kinds = Some [ String ] };
          } );
        ("resourceId", { any with reference = Some "ResourceId" });
        ( "updatedEntityTypes",
          {
            any with
            kinds = Some [ Array ];
            items = Some { any with kinds = Some [ String ] };
          } );
      ];
  }

let shape_245 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "search" ];
    members =
      [
        ("archived", { any with kinds = Some [ Boolean ] });
        ("entityType", { any with kinds = Some [ String ] });
        ( "limit",
          {
            any with
            kinds = Some [ Integer ];
            minimum = Some "1";
            maximum = Some "200";
          } );
        ("offset", { any with kinds = Some [ Integer ]; minimum = Some "0" });
        ("search", { any with kinds = Some [ String ] });
      ];
  }

let shape_246 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "resources"; "total"; "offset"; "limit"; "matchKind" ];
    members =
      [
        ("limit", { any with kinds = Some [ Integer ]; minimum = Some "1" });
        ( "matchKind",
          {
            any with
            kinds = Some [ String ];
            enum = Some [ `Stringlit "\"lexical\""; `Stringlit "\"semantic\"" ];
          } );
        ("offset", { any with kinds = Some [ Integer ]; minimum = Some "0" });
        ( "resources",
          {
            any with
            kinds = Some [ Array ];
            items = Some { any with reference = Some "ResourceDescriptor" };
          } );
        ("total", { any with kinds = Some [ Integer ]; minimum = Some "0" });
      ];
  }

let shape_247 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "response" ];
    members =
      [ ("response", { any with reference = Some "MatchResourcesResponse" }) ];
  }

let shape_248 () =
  {
    any with
    kinds = Some [ Object ];
    all_of =
      [
        { any with reference = Some "CommandError" };
        {
          any with
          kinds = Some [ Object ];
          required = [ "referenceId" ];
          members =
            [ ("referenceId", { any with reference = Some "AnnotationId" }) ];
        };
      ];
  }

let shape_249 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "resourceId"; "referenceId"; "context" ];
    members =
      [
        ("context", { any with reference = Some "GatheredContext" });
        ( "limit",
          {
            any with
            kinds = Some [ Integer ];
            minimum = Some "1";
            maximum = Some "200";
          } );
        ("referenceId", { any with reference = Some "AnnotationId" });
        ("resourceId", { any with reference = Some "ResourceId" });
        ("useSemanticScoring", { any with kinds = Some [ Boolean ] });
      ];
  }

let shape_250 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "referenceId"; "response" ];
    members =
      [
        ("referenceId", { any with reference = Some "AnnotationId" });
        ( "response",
          {
            any with
            kinds = Some [ Array ];
            items = Some { any with reference = Some "ScoredResource" };
          } );
      ];
  }

let shape_251 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "resourceId" ];
    members = [ ("resourceId", { any with reference = Some "ResourceId" }) ];
  }

let shape_252 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "token" ];
    members = [ ("token", { any with kinds = Some [ String ] }) ];
  }

let shape_253 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "type" ];
    members =
      [
        ( "type",
          {
            any with
            kinds = Some [ String ];
            enum = Some [ `Stringlit "\"memory\"" ];
          } );
      ];
    closed = Some [ "type" ];
  }

let shape_254 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "type" ];
    members =
      [
        ( "type",
          {
            any with
            kinds = Some [ String ];
            enum = Some [ `Stringlit "\"memory\"" ];
          } );
      ];
    closed = Some [ "type" ];
  }

let shape_255 () =
  {
    any with
    kinds = Some [ String ];
    enum =
      Some
        [
          `Stringlit "\"assessing\"";
          `Stringlit "\"commenting\"";
          `Stringlit "\"highlighting\"";
          `Stringlit "\"linking\"";
          `Stringlit "\"tagging\"";
        ];
  }

let shape_256 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "type"; "uri"; "username"; "passwordEnv"; "database" ];
    members =
      [
        ("database", { any with kinds = Some [ String ]; min_length = Some 1 });
        ( "passwordEnv",
          { any with kinds = Some [ String ]; min_length = Some 1 } );
        ( "type",
          {
            any with
            kinds = Some [ String ];
            enum = Some [ `Stringlit "\"neo4j\"" ];
          } );
        ("uri", { any with kinds = Some [ String ]; min_length = Some 1 });
        ("username", { any with kinds = Some [ String ]; min_length = Some 1 });
      ];
    closed = Some [ "database"; "passwordEnv"; "type"; "uri"; "username" ];
  }

let shape_257 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "type"; "endpoint"; "port" ];
    members =
      [
        ("endpoint", { any with kinds = Some [ String ]; min_length = Some 1 });
        ( "port",
          {
            any with
            kinds = Some [ Integer ];
            minimum = Some "1";
            maximum = Some "65535";
          } );
        ( "type",
          {
            any with
            kinds = Some [ String ];
            enum = Some [ `Stringlit "\"neptune\"" ];
          } );
      ];
    closed = Some [ "endpoint"; "port"; "type" ];
  }

let shape_258 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "label"; "endpoint"; "did" ];
    members =
      [
        ("did", { any with kinds = Some [ String ] });
        ("endpoint", { any with reference = Some "KbEndpoint" });
        ("label", { any with kinds = Some [ String ] });
        ("lastRead", { any with reference = Some "KbRead" });
      ];
  }

let shape_259 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "mean"; "lowConfidenceWords"; "totalWords" ];
    members =
      [
        ("lowConfidenceWords", { any with kinds = Some [ Integer ] });
        ("mean", { any with kinds = Some [ Number ] });
        ("totalWords", { any with kinds = Some [ Integer ] });
      ];
  }

let shape_260 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "type"; "model"; "baseUrl" ];
    members =
      [
        ("baseUrl", { any with kinds = Some [ String ]; min_length = Some 1 });
        ("model", { any with kinds = Some [ String ]; min_length = Some 1 });
        ( "type",
          {
            any with
            kinds = Some [ String ];
            enum = Some [ `Stringlit "\"ollama\"" ];
          } );
      ];
    closed = Some [ "baseUrl"; "model"; "type" ];
  }

let shape_261 () =
  {
    any with
    kinds = Some [ Object; Array ];
    variants =
      [
        { any with reference = Some "Agent" };
        {
          any with
          kinds = Some [ Array ];
          min_items = Some 1;
          items = Some { any with reference = Some "Agent" };
        };
      ];
  }

let shape_262 () =
  {
    any with
    kinds = Some [ Array; String ];
    variants =
      [
        { any with kinds = Some [ String ] };
        {
          any with
          kinds = Some [ Array ];
          min_items = Some 1;
          items = Some { any with kinds = Some [ String ] };
        };
      ];
  }

let shape_263 () =
  {
    any with
    kinds = Some [ Array; String ];
    variants =
      [
        { any with kinds = Some [ String ] };
        {
          any with
          kinds = Some [ Array ];
          min_items = Some 1;
          items = Some { any with kinds = Some [ String ] };
        };
      ];
  }

let shape_264 () =
  {
    any with
    kinds = Some [ String ];
    enum =
      Some
        [
          `Stringlit "\"A\"";
          `Stringlit "\"B\"";
          `Stringlit "\"C\"";
          `Stringlit "\"D\"";
          `Stringlit "\"E\"";
          `Stringlit "\"F\"";
          `Stringlit "\"G\"";
        ];
  }

let shape_265 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "start"; "end"; "page"; "x"; "y"; "width"; "height" ];
    members =
      [
        ("end", { any with kinds = Some [ Integer ]; minimum = Some "0" });
        ("height", { any with kinds = Some [ Number ] });
        ("page", { any with kinds = Some [ Integer ] });
        ("start", { any with kinds = Some [ Integer ]; minimum = Some "0" });
        ("width", { any with kinds = Some [ Number ] });
        ("x", { any with kinds = Some [ Number ] });
        ("y", { any with kinds = Some [ Number ] });
      ];
  }

let shape_266 () =
  {
    any with
    kinds = Some [ String ];
    pattern =
      Some
        [
          ([ (112, 112) ], 1, Some 1);
          ([ (45, 45) ], 1, Some 1);
          ([ (0, 9); (11, 12); (14, 8231); (8234, 1114111) ], 1, None);
          ([ (45, 45) ], 1, Some 1);
          ([ (48, 57) ], 1, None);
        ];
  }

let shape_267 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "name" ];
    members =
      [
        ("_userId", { any with reference = Some "UserId" });
        ("name", { any with kinds = Some [ String ] });
      ];
  }

let shape_268 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "name" ];
    members = [ ("name", { any with kinds = Some [ String ] }) ];
  }

let shape_269 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "name"; "since" ];
    members =
      [
        ("name", { any with kinds = Some [ String ] });
        ("since", { any with kinds = Some [ String ] });
      ];
    closed = Some [ "name"; "since" ];
  }

let shape_270 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "profiles" ];
    members =
      [
        ( "profiles",
          {
            any with
            kinds = Some [ Object ];
            values = Some { any with reference = Some "Profile" };
          } );
      ];
    closed = Some [ "profiles" ];
  }

let shape_271 () =
  {
    any with
    kinds = Some [ Object ];
    required =
      [ "resource"; "authorization_servers"; "bearer_methods_supported" ];
    members =
      [
        ( "authorization_servers",
          {
            any with
            kinds = Some [ Array ];
            items = Some { any with kinds = Some [ String ] };
          } );
        ( "bearer_methods_supported",
          {
            any with
            kinds = Some [ Array ];
            items =
              Some
                {
                  any with
                  kinds = Some [ String ];
                  enum = Some [ `Stringlit "\"header\"" ];
                };
          } );
        ("resource", { any with kinds = Some [ String ] });
        ("resource_name", { any with kinds = Some [ String ] });
      ];
    closed =
      Some
        [
          "authorization_servers";
          "bearer_methods_supported";
          "resource";
          "resource_name";
        ];
  }

let shape_272 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "type"; "host"; "port"; "tokenEnv" ];
    members =
      [
        ("host", { any with kinds = Some [ String ]; min_length = Some 1 });
        ( "port",
          {
            any with
            kinds = Some [ Integer ];
            minimum = Some "1";
            maximum = Some "65535";
          } );
        ("tokenEnv", { any with kinds = Some [ String ]; min_length = Some 1 });
        ( "type",
          {
            any with
            kinds = Some [ String ];
            enum = Some [ `Stringlit "\"qdrant\"" ];
          } );
      ];
    closed = Some [ "host"; "port"; "tokenEnv"; "type" ];
  }

let shape_273 () =
  {
    any with
    kinds = Some [ String ];
    pattern =
      Some
        [
          ([ (101, 101) ], 1, Some 1);
          ([ (45, 45) ], 1, Some 1);
          ([ (0, 57); (59, 1114111) ], 1, None);
          ([ (58, 58) ], 1, Some 1);
          ([ (0, 57); (59, 1114111) ], 1, None);
          ([ (58, 58) ], 1, Some 1);
          ([ (0, 9); (11, 12); (14, 8231); (8234, 1114111) ], 1, None);
        ];
  }

let shape_274 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "mediaType" ];
    members =
      [
        ("@id", { any with kinds = Some [ String ] });
        ("@type", { any with reference = Some "OneOrMoreStrings" });
        ("byteSize", { any with kinds = Some [ Integer ]; minimum = Some "0" });
        ("checksum", { any with kinds = Some [ String ] });
        ("conformsTo", { any with reference = Some "OneOrMoreUris" });
        ("created", { any with kinds = Some [ String ] });
        ("duration", { any with kinds = Some [ Number ]; minimum = Some "0" });
        ("encoding", { any with kinds = Some [ String ] });
        ("filename", { any with kinds = Some [ String ] });
        ("height", { any with kinds = Some [ Integer ]; minimum = Some "0" });
        ("language", { any with kinds = Some [ String ] });
        ("mediaType", { any with kinds = Some [ String ] });
        ("modified", { any with kinds = Some [ String ] });
        ( "rel",
          {
            any with
            kinds = Some [ String ];
            enum =
              Some
                [
                  `Stringlit "\"original\"";
                  `Stringlit "\"thumbnail\"";
                  `Stringlit "\"preview\"";
                  `Stringlit "\"optimized\"";
                  `Stringlit "\"derived\"";
                  `Stringlit "\"other\"";
                ];
          } );
        ("storageUri", { any with kinds = Some [ String ] });
        ( "tags",
          {
            any with
            kinds = Some [ Array ];
            items = Some { any with kinds = Some [ String ] };
          } );
        ("width", { any with kinds = Some [ Integer ]; minimum = Some "0" });
      ];
  }

let shape_275 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "representation" ];
    members =
      [ ("representation", { any with reference = Some "Representation" }) ];
  }

let shape_276 () =
  {
    any with
    kinds = Some [ Object ];
    all_of =
      [
        { any with reference = Some "ErrorResponse" };
        {
          any with
          kinds = Some [ Object ];
          required = [ "code" ];
          members =
            [
              ( "code",
                {
                  any with
                  kinds = Some [ String ];
                  enum =
                    Some
                      [
                        `Stringlit "\"resource\"";
                        `Stringlit "\"representation\"";
                      ];
                } );
            ];
        };
      ];
  }

let shape_277 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "checksum" ];
    members = [ ("checksum", { any with kinds = Some [ String ] }) ];
  }

let shape_278 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "resourceId"; "annotations"; "version"; "updatedAt" ];
    members =
      [
        ( "annotations",
          {
            any with
            kinds = Some [ Array ];
            items = Some { any with reference = Some "Annotation" };
          } );
        ("resourceId", { any with reference = Some "ResourceId" });
        ("updatedAt", { any with kinds = Some [ String ] });
        ("version", { any with kinds = Some [ Integer ]; minimum = Some "0" });
      ];
    closed = Some [ "annotations"; "resourceId"; "updatedAt"; "version" ];
  }

let shape_279 () =
  {
    any with
    kinds = Some [ Object ];
    members = [ ("reason", { any with kinds = Some [ String ] }) ];
  }

let shape_280 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "name"; "format"; "contentChecksum"; "parentResourceId" ];
    members =
      [
        ("contentByteSize", { any with kinds = Some [ Integer ] });
        ("contentChecksum", { any with kinds = Some [ String ] });
        ("creator", { any with reference = Some "Agent" });
        ( "entityTypes",
          {
            any with
            kinds = Some [ Array ];
            items = Some { any with kinds = Some [ String ] };
          } );
        ("format", { any with reference = Some "ContentFormat" });
        ("language", { any with kinds = Some [ String ] });
        ("name", { any with kinds = Some [ String ] });
        ("parentResourceId", { any with reference = Some "ResourceId" });
        ("storageUri", { any with kinds = Some [ String ] });
        ("wasAttributedTo", { any with reference = Some "OneOrMoreAgents" });
      ];
  }

let shape_281 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "name"; "format"; "contentChecksum" ];
    members =
      [
        ("contentByteSize", { any with kinds = Some [ Integer ] });
        ("contentChecksum", { any with kinds = Some [ String ] });
        ("creator", { any with reference = Some "Agent" });
        ( "entityTypes",
          {
            any with
            kinds = Some [ Array ];
            items = Some { any with kinds = Some [ String ] };
          } );
        ("format", { any with reference = Some "ContentFormat" });
        ( "generatedFrom",
          {
            any with
            kinds = Some [ Object ];
            required = [ "resourceId" ];
            members =
              [
                ("annotationId", { any with reference = Some "AnnotationId" });
                ("resourceId", { any with reference = Some "ResourceId" });
              ];
          } );
        ("generationPrompt", { any with kinds = Some [ String ] });
        ("generator", { any with reference = Some "OneOrMoreAgents" });
        ("isDraft", { any with kinds = Some [ Boolean ] });
        ("jobId", { any with reference = Some "JobId" });
        ("language", { any with kinds = Some [ String ] });
        ("name", { any with kinds = Some [ String ] });
        ("storageUri", { any with kinds = Some [ String ] });
        ("wasAttributedTo", { any with reference = Some "OneOrMoreAgents" });
      ];
  }

let shape_282 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "@context"; "@id"; "name"; "representations" ];
    members =
      [
        ( "@context",
          {
            any with
            kinds = Some [ Object; Array; String ];
            variants =
              [
                { any with kinds = Some [ String ] };
                { any with kinds = Some [ Object ] };
                {
                  any with
                  kinds = Some [ Array ];
                  items =
                    Some
                      {
                        any with
                        kinds = Some [ Object; String ];
                        variants =
                          [
                            { any with kinds = Some [ String ] };
                            { any with kinds = Some [ Object ] };
                          ];
                      };
                };
              ];
          } );
        ("@id", { any with reference = Some "ResourceId" });
        ("@type", { any with reference = Some "OneOrMoreStrings" });
        ("about", { any with reference = Some "OneOrMoreStrings" });
        ("archived", { any with kinds = Some [ Boolean ] });
        ( "availableFormats",
          {
            any with
            kinds = Some [ Array ];
            items = Some { any with kinds = Some [ String ] };
          } );
        ("conformsTo", { any with reference = Some "OneOrMoreUris" });
        ("dateCreated", { any with kinds = Some [ String ] });
        ("dateModified", { any with kinds = Some [ String ] });
        ("description", { any with kinds = Some [ String ] });
        ( "entityTypes",
          {
            any with
            kinds = Some [ Array ];
            items = Some { any with kinds = Some [ String ] };
          } );
        ("generator", { any with reference = Some "OneOrMoreAgents" });
        ( "hasPart",
          {
            any with
            kinds = Some [ Array ];
            items = Some { any with kinds = Some [ String ] };
          } );
        ( "identifier",
          {
            any with
            kinds = Some [ Object; Array; String ];
            variants =
              [
                { any with kinds = Some [ String ] };
                {
                  any with
                  kinds = Some [ Array ];
                  min_items = Some 1;
                  items = Some { any with kinds = Some [ String ] };
                };
                {
                  any with
                  kinds = Some [ Object ];
                  members =
                    [
                      ("@id", { any with kinds = Some [ String ] });
                      ("scheme", { any with kinds = Some [ String ] });
                      ("value", { any with kinds = Some [ String ] });
                    ];
                };
              ];
          } );
        ("isDraft", { any with kinds = Some [ Boolean ] });
        ( "isPartOf",
          {
            any with
            kinds = Some [ Array ];
            items = Some { any with kinds = Some [ String ] };
          } );
        ("license", { any with kinds = Some [ String ] });
        ("name", { any with kinds = Some [ String ] });
        ("originatedFrom", { any with kinds = Some [ String ] });
        ( "representations",
          {
            any with
            kinds = Some [ Object; Array ];
            variants =
              [
                { any with reference = Some "Representation" };
                {
                  any with
                  kinds = Some [ Array ];
                  items = Some { any with reference = Some "Representation" };
                };
              ];
          } );
        ( "sameAs",
          {
            any with
            kinds = Some [ Array ];
            items = Some { any with kinds = Some [ String ] };
          } );
        ("sourceAnnotationId", { any with reference = Some "AnnotationId" });
        ("sourceResourceId", { any with reference = Some "ResourceId" });
        ("version", { any with kinds = Some [ String ] });
        ("wasAttributedTo", { any with reference = Some "OneOrMoreAgents" });
        ( "wasDerivedFrom",
          {
            any with
            kinds = Some [ Array; String ];
            variants =
              [
                { any with reference = Some "ResourceId" };
                {
                  any with
                  kinds = Some [ Array ];
                  items = Some { any with reference = Some "ResourceId" };
                };
              ];
          } );
      ];
  }

let shape_283 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "resourceId"; "message" ];
    members =
      [
        ("message", { any with kinds = Some [ String ] });
        ("resourceId", { any with reference = Some "ResourceId" });
      ];
  }

let shape_284 () =
  {
    any with
    kinds = Some [ String ];
    pattern =
      Some
        [ ([ (45, 45); (48, 57); (65, 90); (95, 95); (97, 122) ], 1, Some 128) ];
  }

let shape_285 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "fromUri"; "toUri" ];
    members =
      [
        ("fromUri", { any with kinds = Some [ String ] });
        ("toUri", { any with kinds = Some [ String ] });
      ];
  }

let shape_286 () = { any with kinds = Some [ Object ] }

let shape_287 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "contentChecksum" ];
    members =
      [
        ("contentByteSize", { any with kinds = Some [ Integer ] });
        ("contentChecksum", { any with kinds = Some [ String ] });
      ];
  }

let shape_288 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "name"; "file"; "format"; "storageUri" ];
    members =
      [
        ("archiveOriginal", { any with kinds = Some [ String ] });
        ("cloneToken", { any with kinds = Some [ String ] });
        ("entityTypes", { any with kinds = Some [ String ] });
        ("file", { any with kinds = Some [ String ] });
        ("format", { any with kinds = Some [ String ] });
        ("generationPrompt", { any with kinds = Some [ String ] });
        ("generator", { any with kinds = Some [ String ] });
        ("isDraft", { any with kinds = Some [ String ] });
        ("jobId", { any with reference = Some "JobId" });
        ("language", { any with kinds = Some [ String ] });
        ("name", { any with kinds = Some [ String ] });
        ("sourceAnnotationId", { any with reference = Some "AnnotationId" });
        ("sourceResourceId", { any with reference = Some "ResourceId" });
        ("storageUri", { any with kinds = Some [ String ] });
      ];
  }

let shape_289 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "resource"; "annotations"; "lastSequence" ];
    members =
      [
        ("annotations", { any with reference = Some "ResourceAnnotations" });
        ( "lastSequence",
          { any with kinds = Some [ Integer ]; minimum = Some "1" } );
        ("resource", { any with reference = Some "ResourceDescriptor" });
      ];
    closed = Some [ "annotations"; "lastSequence"; "resource" ];
  }

let shape_290 () =
  {
    any with
    kinds = Some [ Object ];
    all_of =
      [
        { any with reference = Some "ResourceDescriptor" };
        {
          any with
          kinds = Some [ Object ];
          members =
            [
              ("matchReason", { any with kinds = Some [ String ] });
              ("score", { any with kinds = Some [ Number ] });
            ];
        };
      ];
  }

let shape_291 () =
  {
    any with
    kinds = Some [ Object ];
    variants =
      [
        { any with reference = Some "TextPositionSelector" };
        { any with reference = Some "TextQuoteSelector" };
        { any with reference = Some "SvgSelector" };
        { any with reference = Some "FragmentSelector" };
      ];
    discriminator =
      Some
        ( "type",
          [
            ("TextPositionSelector", 0);
            ("TextQuoteSelector", 1);
            ("SvgSelector", 2);
            ("FragmentSelector", 3);
          ] );
  }

let shape_292 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "text"; "resourceId"; "resourceName"; "score" ];
    members =
      [
        ("annotationId", { any with reference = Some "AnnotationId" });
        ( "entityTypes",
          {
            any with
            kinds = Some [ Array ];
            items = Some { any with kinds = Some [ String ] };
          } );
        ("machineRead", { any with kinds = Some [ Boolean ] });
        ("resourceId", { any with reference = Some "ResourceId" });
        ("resourceName", { any with kinds = Some [ String ] });
        ("score", { any with kinds = Some [ Number ] });
        ("text", { any with kinds = Some [ String ] });
      ];
  }

let shape_293 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "host"; "port" ];
    members =
      [
        ("host", { any with kinds = Some [ String ]; min_length = Some 1 });
        ( "port",
          {
            any with
            kinds = Some [ Integer ];
            minimum = Some "1";
            maximum = Some "65535";
          } );
      ];
    closed = Some [ "host"; "port" ];
  }

let shape_294 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "issuer" ];
    members =
      [ ("issuer", { any with kinds = Some [ String ]; min_length = Some 1 }) ];
    closed = Some [ "issuer" ];
  }

let shape_295 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "participant"; "connectionId" ];
    members =
      [
        ("connectionId", { any with kinds = Some [ String ] });
        ("participant", { any with reference = Some "UserId" });
      ];
  }

let shape_296 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "participant"; "connectionId" ];
    members =
      [
        ("connectionId", { any with kinds = Some [ String ] });
        ("participant", { any with reference = Some "UserId" });
      ];
  }

let shape_297 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "hoverDelayMs" ];
    members = [ ("hoverDelayMs", { any with kinds = Some [ Integer ] }) ];
  }

let shape_298 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "locale" ];
    members = [ ("locale", { any with kinds = Some [ String ] }) ];
  }

let shape_299 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "theme" ];
    members =
      [
        ( "theme",
          {
            any with
            kinds = Some [ String ];
            enum =
              Some
                [
                  `Stringlit "\"light\"";
                  `Stringlit "\"dark\"";
                  `Stringlit "\"system\"";
                ];
          } );
      ];
  }

let shape_300 () =
  {
    any with
    kinds = Some [ Object ];
    members =
      [
        ("_userId", { any with reference = Some "UserId" });
        ("resourceId", { any with reference = Some "ResourceId" });
      ];
  }

let shape_301 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "resourceId"; "contentChecksum"; "outcome" ];
    members =
      [
        ("contentChecksum", { any with kinds = Some [ String ] });
        ( "outcome",
          {
            any with
            kinds = Some [ String ];
            enum = Some [ `Stringlit "\"indexed\""; `Stringlit "\"skipped\"" ];
          } );
        ( "reason",
          {
            any with
            kinds = Some [ String ];
            enum =
              Some
                [
                  `Stringlit "\"no-extractor\"";
                  `Stringlit "\"empty\"";
                  `Stringlit "\"no-text-layer\"";
                  `Stringlit "\"encrypted\"";
                  `Stringlit "\"corrupt\"";
                  `Stringlit "\"too-large\"";
                ];
          } );
        ("resourceId", { any with reference = Some "ResourceId" });
      ];
  }

let shape_302 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "chunkSize"; "overlap" ];
    members =
      [
        ("chunkSize", { any with kinds = Some [ Integer ]; minimum = Some "1" });
        ("overlap", { any with kinds = Some [ Integer ]; minimum = Some "0" });
      ];
    closed = Some [ "chunkSize"; "overlap" ];
  }

let shape_303 () =
  {
    any with
    kinds = Some [ Object ];
    required =
      [
        "kb";
        "gatewayUrl";
        "identity";
        "archivist";
        "embedding";
        "vectors";
        "chunking";
        "pdfsAtOnce";
        "cursorsPath";
        "port";
        "logLevel";
        "logFormat";
      ];
    members =
      [
        ("archivist", { any with reference = Some "ServiceAddress" });
        ("chunking", { any with reference = Some "SmelterChunking" });
        ("cursorsPath", { any with reference = Some "CursorsPath" });
        ("embedding", { any with reference = Some "EmbeddingConfig" });
        ("gatewayUrl", { any with kinds = Some [ String ]; min_length = Some 1 });
        ("identity", { any with reference = Some "ServiceIdentity" });
        ("kb", { any with reference = Some "KbIdentity" });
        ("logFormat", { any with reference = Some "LogFormat" });
        ("logLevel", { any with reference = Some "LogLevel" });
        ("pdfsAtOnce", { any with kinds = Some [ Integer ]; minimum = Some "1" });
        ( "port",
          {
            any with
            kinds = Some [ Integer ];
            minimum = Some "1";
            maximum = Some "65535";
          } );
        ("vectors", { any with reference = Some "VectorsConfig" });
      ];
    closed =
      Some
        [
          "archivist";
          "chunking";
          "cursorsPath";
          "embedding";
          "gatewayUrl";
          "identity";
          "kb";
          "logFormat";
          "logLevel";
          "pdfsAtOnce";
          "port";
          "vectors";
        ];
  }

let shape_304 () =
  {
    any with
    kinds = Some [ Object ];
    required =
      [
        "status";
        "kb";
        "stream";
        "following";
        "eventsProcessed";
        "reconcile";
        "index";
      ];
    members =
      [
        ( "eventsProcessed",
          { any with kinds = Some [ Integer ]; minimum = Some "0" } );
        ( "following",
          {
            any with
            kinds = Some [ Object ];
            required = [ "sweep"; "stopped"; "refused"; "streamDrops" ];
            members =
              [
                ( "refused",
                  { any with kinds = Some [ Integer ]; minimum = Some "0" } );
                ( "stopped",
                  { any with kinds = Some [ Integer ]; minimum = Some "0" } );
                ( "streamDrops",
                  { any with kinds = Some [ Integer ]; minimum = Some "0" } );
                ( "sweep",
                  {
                    any with
                    kinds = Some [ String ];
                    enum =
                      Some
                        [
                          `Stringlit "\"pending\"";
                          `Stringlit "\"running\"";
                          `Stringlit "\"done\"";
                          `Stringlit "\"due\"";
                        ];
                  } );
              ];
            closed = Some [ "refused"; "stopped"; "streamDrops"; "sweep" ];
          } );
        ( "index",
          {
            any with
            kinds = Some [ Object ];
            required = [ "stamp"; "madeAnew" ];
            members =
              [
                ("madeAnew", { any with kinds = Some [ Boolean ] });
                ( "stamp",
                  {
                    any with
                    kinds = Some [ Object ];
                    required = [ "embedding"; "chunking" ];
                    members =
                      [
                        ( "chunking",
                          { any with reference = Some "SmelterChunking" } );
                        ( "embedding",
                          {
                            any with
                            kinds = Some [ Object ];
                            required = [ "type"; "model" ];
                            members =
                              [
                                ( "model",
                                  {
                                    any with
                                    kinds = Some [ String ];
                                    min_length = Some 1;
                                  } );
                                ( "type",
                                  {
                                    any with
                                    kinds = Some [ String ];
                                    min_length = Some 1;
                                  } );
                              ];
                            closed = Some [ "model"; "type" ];
                          } );
                      ];
                    closed = Some [ "chunking"; "embedding" ];
                  } );
              ];
            closed = Some [ "madeAnew"; "stamp" ];
          } );
        ( "kb",
          {
            any with
            kinds = Some [ String ];
            pattern =
              Some
                [
                  ([ (100, 100) ], 1, Some 1);
                  ([ (105, 105) ], 1, Some 1);
                  ([ (100, 100) ], 1, Some 1);
                  ([ (58, 58) ], 1, Some 1);
                  ([ (119, 119) ], 1, Some 1);
                  ([ (101, 101) ], 1, Some 1);
                  ([ (98, 98) ], 1, Some 1);
                  ([ (58, 58) ], 1, Some 1);
                  ( [
                      (0, 8);
                      (14, 31);
                      (33, 159);
                      (161, 5759);
                      (5761, 8191);
                      (8203, 8231);
                      (8234, 8238);
                      (8240, 8286);
                      (8288, 12287);
                      (12289, 65278);
                      (65280, 1114111);
                    ],
                    1,
                    None );
                ];
          } );
        ( "reconcile",
          {
            any with
            kinds = Some [ Object ];
            required = [ "phase" ];
            members =
              [
                ("error", { any with kinds = Some [ String ] });
                ( "phase",
                  {
                    any with
                    kinds = Some [ String ];
                    enum =
                      Some
                        [
                          `Stringlit "\"pending\"";
                          `Stringlit "\"running\"";
                          `Stringlit "\"done\"";
                          `Stringlit "\"failed\"";
                        ];
                  } );
                ( "summary",
                  { any with reference = Some "SmelterReconcileSummary" } );
              ];
            closed = Some [ "error"; "phase"; "summary" ];
          } );
        ( "status",
          {
            any with
            kinds = Some [ String ];
            enum = Some [ `Stringlit "\"ok\"" ];
          } );
        ( "stream",
          {
            any with
            kinds = Some [ String ];
            enum =
              Some
                [
                  `Stringlit "\"initial\"";
                  `Stringlit "\"connecting\"";
                  `Stringlit "\"open\"";
                  `Stringlit "\"reconnecting\"";
                  `Stringlit "\"degraded\"";
                  `Stringlit "\"unauthenticated\"";
                  `Stringlit "\"closed\"";
                ];
          } );
      ];
    closed =
      Some
        [
          "eventsProcessed";
          "following";
          "index";
          "kb";
          "reconcile";
          "status";
          "stream";
        ];
  }

let shape_305 () =
  {
    any with
    kinds = Some [ Object ];
    required =
      [
        "resourcesEmbedded";
        "resourcesSkipped";
        "resourcesUnavailable";
        "resourcesFailed";
        "resourcesRestamped";
        "resourcesReanchored";
        "resourceVectorsDeleted";
        "annotationsEmbedded";
        "annotationsRestamped";
        "annotationVectorsDeleted";
        "resourcesEligible";
        "resourcesIndexed";
      ];
    members =
      [
        ( "annotationVectorsDeleted",
          { any with kinds = Some [ Integer ]; minimum = Some "0" } );
        ( "annotationsEmbedded",
          { any with kinds = Some [ Integer ]; minimum = Some "0" } );
        ( "annotationsRestamped",
          { any with kinds = Some [ Integer ]; minimum = Some "0" } );
        ( "resourceVectorsDeleted",
          { any with kinds = Some [ Integer ]; minimum = Some "0" } );
        ( "resourcesEligible",
          { any with kinds = Some [ Integer ]; minimum = Some "0" } );
        ( "resourcesEmbedded",
          { any with kinds = Some [ Integer ]; minimum = Some "0" } );
        ( "resourcesFailed",
          { any with kinds = Some [ Integer ]; minimum = Some "0" } );
        ( "resourcesIndexed",
          { any with kinds = Some [ Integer ]; minimum = Some "0" } );
        ( "resourcesReanchored",
          { any with kinds = Some [ Integer ]; minimum = Some "0" } );
        ( "resourcesRestamped",
          { any with kinds = Some [ Integer ]; minimum = Some "0" } );
        ( "resourcesSkipped",
          {
            any with
            kinds = Some [ Object ];
            values =
              Some { any with kinds = Some [ Integer ]; minimum = Some "0" };
          } );
        ( "resourcesUnavailable",
          { any with kinds = Some [ Integer ]; minimum = Some "0" } );
      ];
    closed =
      Some
        [
          "annotationVectorsDeleted";
          "annotationsEmbedded";
          "annotationsRestamped";
          "resourceVectorsDeleted";
          "resourcesEligible";
          "resourcesEmbedded";
          "resourcesFailed";
          "resourcesIndexed";
          "resourcesReanchored";
          "resourcesRestamped";
          "resourcesSkipped";
          "resourcesUnavailable";
        ];
  }

let shape_306 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "type"; "source" ];
    members =
      [
        ("purpose", { any with reference = Some "BodyPurpose" });
        ("source", { any with reference = Some "ResourceId" });
        ( "type",
          {
            any with
            kinds = Some [ String ];
            enum = Some [ `Stringlit "\"SpecificResource\"" ];
          } );
      ];
  }

let shape_307 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "status"; "version"; "features"; "message" ];
    members =
      [
        ("authenticatedAs", { any with kinds = Some [ String ] });
        ( "features",
          {
            any with
            kinds = Some [ Object ];
            required = [ "semanticContent"; "collaboration" ];
            members =
              [
                ("collaboration", { any with kinds = Some [ String ] });
                ("semanticContent", { any with kinds = Some [ String ] });
              ];
          } );
        ("message", { any with kinds = Some [ String ] });
        ("status", { any with kinds = Some [ String ] });
        ("version", { any with kinds = Some [ String ] });
      ];
  }

let shape_308 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "uri"; "resourceId" ];
    members =
      [
        ("resourceId", { any with reference = Some "ResourceId" });
        ("uri", { any with kinds = Some [ String ] });
      ];
    closed = Some [ "resourceId"; "uri" ];
  }

let shape_309 () =
  {
    any with
    kinds = Some [ Object ];
    required =
      [ "id"; "type"; "timestamp"; "userId"; "version"; "payload"; "metadata" ];
    members =
      [
        ("id", { any with kinds = Some [ String ] });
        ("metadata", { any with reference = Some "EventMetadata" });
        ("payload", { any with kinds = Some [ Object ] });
        ("resourceId", { any with reference = Some "ResourceId" });
        ("timestamp", { any with kinds = Some [ String ] });
        ("type", { any with kinds = Some [ String ] });
        ("userId", { any with reference = Some "UserId" });
        ("version", { any with kinds = Some [ Integer ] });
      ];
  }

let shape_310 () =
  {
    any with
    kinds = Some [ String ];
    enum =
      Some
        [
          `Stringlit "\"text/plain\"";
          `Stringlit "\"text/markdown\"";
          `Stringlit "\"text/html\"";
          `Stringlit "\"text/css\"";
          `Stringlit "\"text/csv\"";
          `Stringlit "\"text/xml\"";
          `Stringlit "\"application/json\"";
          `Stringlit "\"application/xml\"";
          `Stringlit "\"application/yaml\"";
          `Stringlit "\"application/x-yaml\"";
          `Stringlit "\"application/pdf\"";
          `Stringlit "\"application/msword\"";
          `Stringlit
            "\"application/vnd.openxmlformats-officedocument.wordprocessingml.document\"";
          `Stringlit "\"application/vnd.ms-excel\"";
          `Stringlit
            "\"application/vnd.openxmlformats-officedocument.spreadsheetml.sheet\"";
          `Stringlit "\"application/vnd.ms-powerpoint\"";
          `Stringlit
            "\"application/vnd.openxmlformats-officedocument.presentationml.presentation\"";
          `Stringlit "\"application/zip\"";
          `Stringlit "\"application/gzip\"";
          `Stringlit "\"application/x-tar\"";
          `Stringlit "\"application/x-7z-compressed\"";
          `Stringlit "\"application/octet-stream\"";
          `Stringlit "\"application/wasm\"";
          `Stringlit "\"image/png\"";
          `Stringlit "\"image/jpeg\"";
          `Stringlit "\"image/gif\"";
          `Stringlit "\"image/webp\"";
          `Stringlit "\"image/svg+xml\"";
          `Stringlit "\"image/bmp\"";
          `Stringlit "\"image/tiff\"";
          `Stringlit "\"image/x-icon\"";
          `Stringlit "\"video/mp4\"";
          `Stringlit "\"video/mpeg\"";
          `Stringlit "\"video/webm\"";
          `Stringlit "\"video/ogg\"";
          `Stringlit "\"video/quicktime\"";
          `Stringlit "\"video/x-msvideo\"";
          `Stringlit "\"audio/mpeg\"";
          `Stringlit "\"audio/wav\"";
          `Stringlit "\"audio/ogg\"";
          `Stringlit "\"audio/webm\"";
          `Stringlit "\"audio/aac\"";
          `Stringlit "\"audio/flac\"";
          `Stringlit "\"text/javascript\"";
          `Stringlit "\"application/javascript\"";
          `Stringlit "\"text/x-typescript\"";
          `Stringlit "\"application/typescript\"";
          `Stringlit "\"text/x-python\"";
          `Stringlit "\"text/x-java\"";
          `Stringlit "\"text/x-c\"";
          `Stringlit "\"text/x-c++\"";
          `Stringlit "\"text/x-csharp\"";
          `Stringlit "\"text/x-go\"";
          `Stringlit "\"text/x-rust\"";
          `Stringlit "\"text/x-ruby\"";
          `Stringlit "\"text/x-php\"";
          `Stringlit "\"text/x-swift\"";
          `Stringlit "\"text/x-kotlin\"";
          `Stringlit "\"text/x-shell\"";
          `Stringlit "\"font/woff\"";
          `Stringlit "\"font/woff2\"";
          `Stringlit "\"font/ttf\"";
          `Stringlit "\"font/otf\"";
        ];
  }

let shape_311 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "type"; "value" ];
    members =
      [
        ( "type",
          {
            any with
            kinds = Some [ String ];
            enum = Some [ `Stringlit "\"SvgSelector\"" ];
          } );
        ("value", { any with kinds = Some [ String ] });
      ];
  }

let shape_312 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "name"; "description"; "examples" ];
    members =
      [
        ("description", { any with kinds = Some [ String ] });
        ( "examples",
          {
            any with
            kinds = Some [ Array ];
            items = Some { any with kinds = Some [ String ] };
          } );
        ("name", { any with kinds = Some [ String ] });
      ];
  }

let shape_313 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "id"; "name"; "description"; "domain"; "tags" ];
    members =
      [
        ("description", { any with kinds = Some [ String ] });
        ("domain", { any with kinds = Some [ String ] });
        ("id", { any with kinds = Some [ String ] });
        ("name", { any with kinds = Some [ String ] });
        ( "tags",
          {
            any with
            kinds = Some [ Array ];
            items = Some { any with reference = Some "TagCategory" };
          } );
      ];
  }

let shape_314 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "schema" ];
    members = [ ("schema", { any with reference = Some "TagSchema" }) ];
  }

let shape_315 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "tagSchemas" ];
    members =
      [
        ( "tagSchemas",
          {
            any with
            kinds = Some [ Array ];
            items = Some { any with reference = Some "TagSchema" };
          } );
      ];
    closed = Some [ "tagSchemas" ];
  }

let shape_316 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "motivation"; "schemaId"; "categories" ];
    members =
      [
        ( "categories",
          {
            any with
            kinds = Some [ Array ];
            min_items = Some 1;
            items = Some { any with kinds = Some [ String ] };
          } );
        ("language", { any with kinds = Some [ String ] });
        ( "motivation",
          {
            any with
            kinds = Some [ String ];
            enum = Some [ `Stringlit "\"tagging\"" ];
          } );
        ("schemaId", { any with kinds = Some [ String ]; min_length = Some 1 });
        ("sourceLanguage", { any with kinds = Some [ String ] });
      ];
    closed =
      Some
        [ "categories"; "language"; "motivation"; "schemaId"; "sourceLanguage" ];
  }

let shape_317 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "type"; "start"; "end" ];
    members =
      [
        ("end", { any with kinds = Some [ Integer ]; minimum = Some "0" });
        ("start", { any with kinds = Some [ Integer ]; minimum = Some "0" });
        ( "type",
          {
            any with
            kinds = Some [ String ];
            enum = Some [ `Stringlit "\"TextPositionSelector\"" ];
          } );
      ];
  }

let shape_318 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "type"; "exact" ];
    members =
      [
        ("exact", { any with kinds = Some [ String ] });
        ("prefix", { any with kinds = Some [ String ] });
        ("suffix", { any with kinds = Some [ String ] });
        ( "type",
          {
            any with
            kinds = Some [ String ];
            enum = Some [ `Stringlit "\"TextQuoteSelector\"" ];
          } );
      ];
  }

let shape_319 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "type"; "value" ];
    members =
      [
        ("format", { any with kinds = Some [ String ] });
        ("language", { any with kinds = Some [ String ] });
        ("purpose", { any with reference = Some "BodyPurpose" });
        ( "type",
          {
            any with
            kinds = Some [ String ];
            enum = Some [ `Stringlit "\"TextualBody\"" ];
          } );
        ("value", { any with kinds = Some [ String ] });
      ];
  }

let shape_320 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "next"; "size"; "found"; "emitted"; "errors" ];
    members =
      [
        ("emitted", { any with kinds = Some [ Integer ]; minimum = Some "0" });
        ("errors", { any with kinds = Some [ Integer ]; minimum = Some "0" });
        ("found", { any with kinds = Some [ Integer ]; minimum = Some "0" });
        ("next", { any with kinds = Some [ Integer ]; minimum = Some "0" });
        ("size", { any with kinds = Some [ Integer ]; minimum = Some "1" });
      ];
  }

let shape_321 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "resourceId"; "operations" ];
    members =
      [
        ( "operations",
          {
            any with
            kinds = Some [ Array ];
            min_items = Some 1;
            items = Some { any with reference = Some "BodyOperation" };
          } );
        ("resourceId", { any with reference = Some "ResourceId" });
      ];
  }

let shape_322 () =
  {
    any with
    kinds = Some [ String ];
    pattern =
      Some
        [
          ([ (100, 100) ], 1, Some 1);
          ([ (105, 105) ], 1, Some 1);
          ([ (100, 100) ], 1, Some 1);
          ([ (58, 58) ], 1, Some 1);
          ( [
              (0, 8);
              (14, 31);
              (33, 159);
              (161, 5759);
              (5761, 8191);
              (8203, 8231);
              (8234, 8238);
              (8240, 8286);
              (8288, 12287);
              (12289, 65278);
              (65280, 1114111);
            ],
            1,
            None );
        ];
  }

let shape_323 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "did"; "email"; "name"; "image"; "domain" ];
    members =
      [
        ("did", { any with reference = Some "UserId" });
        ("domain", { any with kinds = Some [ String ] });
        ("email", { any with kinds = Some [ String; Null ] });
        ("image", { any with kinds = Some [ String; Null ] });
        ("name", { any with kinds = Some [ String; Null ] });
      ];
  }

let shape_324 () =
  {
    any with
    kinds = Some [ Object ];
    variants =
      [
        { any with reference = Some "QdrantVectorsConfig" };
        { any with reference = Some "MemoryVectorsConfig" };
      ];
    discriminator = Some ("type", [ ("qdrant", 0); ("memory", 1) ]);
  }

let shape_325 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "type"; "model"; "endpoint"; "apiKeyEnv" ];
    members =
      [
        ("apiKeyEnv", { any with kinds = Some [ String ]; min_length = Some 1 });
        ("endpoint", { any with kinds = Some [ String ]; min_length = Some 1 });
        ("model", { any with kinds = Some [ String ]; min_length = Some 1 });
        ( "type",
          {
            any with
            kinds = Some [ String ];
            enum = Some [ `Stringlit "\"voyage\"" ];
          } );
      ];
    closed = Some [ "apiKeyEnv"; "endpoint"; "model"; "type" ];
  }

let shape_326 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "resourceId"; "sequenceNumber" ];
    members =
      [
        ("resourceId", { any with reference = Some "ResourceId" });
        ("sequenceNumber", { any with kinds = Some [ Integer ] });
      ];
  }

let shape_327 () =
  {
    any with
    kinds = Some [ Object ];
    members =
      [
        ("_userId", { any with reference = Some "UserId" });
        ("resourceId", { any with reference = Some "ResourceId" });
      ];
  }

let shape_328 () =
  {
    any with
    kinds = Some [ Object ];
    required =
      [
        "kb";
        "gatewayUrl";
        "identity";
        "archivist";
        "graph";
        "cursorsPath";
        "port";
        "logLevel";
        "logFormat";
      ];
    members =
      [
        ("archivist", { any with reference = Some "ServiceAddress" });
        ("cursorsPath", { any with reference = Some "CursorsPath" });
        ("gatewayUrl", { any with kinds = Some [ String ]; min_length = Some 1 });
        ("graph", { any with reference = Some "GraphConfig" });
        ("identity", { any with reference = Some "ServiceIdentity" });
        ("kb", { any with reference = Some "KbIdentity" });
        ("logFormat", { any with reference = Some "LogFormat" });
        ("logLevel", { any with reference = Some "LogLevel" });
        ( "port",
          {
            any with
            kinds = Some [ Integer ];
            minimum = Some "1";
            maximum = Some "65535";
          } );
      ];
    closed =
      Some
        [
          "archivist";
          "cursorsPath";
          "gatewayUrl";
          "graph";
          "identity";
          "kb";
          "logFormat";
          "logLevel";
          "port";
        ];
  }

let shape_329 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "status"; "kb"; "following"; "reconcile" ];
    members =
      [
        ( "following",
          {
            any with
            kinds = Some [ Object ];
            required = [ "sweep"; "stopped"; "refused"; "streamDrops" ];
            members =
              [
                ( "refused",
                  { any with kinds = Some [ Integer ]; minimum = Some "0" } );
                ( "stopped",
                  { any with kinds = Some [ Integer ]; minimum = Some "0" } );
                ( "streamDrops",
                  { any with kinds = Some [ Integer ]; minimum = Some "0" } );
                ( "sweep",
                  {
                    any with
                    kinds = Some [ String ];
                    enum =
                      Some
                        [
                          `Stringlit "\"pending\"";
                          `Stringlit "\"running\"";
                          `Stringlit "\"done\"";
                          `Stringlit "\"due\"";
                        ];
                  } );
              ];
            closed = Some [ "refused"; "stopped"; "streamDrops"; "sweep" ];
          } );
        ( "kb",
          {
            any with
            kinds = Some [ String ];
            pattern =
              Some
                [
                  ([ (100, 100) ], 1, Some 1);
                  ([ (105, 105) ], 1, Some 1);
                  ([ (100, 100) ], 1, Some 1);
                  ([ (58, 58) ], 1, Some 1);
                  ([ (119, 119) ], 1, Some 1);
                  ([ (101, 101) ], 1, Some 1);
                  ([ (98, 98) ], 1, Some 1);
                  ([ (58, 58) ], 1, Some 1);
                  ( [
                      (0, 8);
                      (14, 31);
                      (33, 159);
                      (161, 5759);
                      (5761, 8191);
                      (8203, 8231);
                      (8234, 8238);
                      (8240, 8286);
                      (8288, 12287);
                      (12289, 65278);
                      (65280, 1114111);
                    ],
                    1,
                    None );
                ];
          } );
        ( "reconcile",
          {
            any with
            kinds = Some [ Object ];
            required = [ "phase" ];
            members =
              [
                ("error", { any with kinds = Some [ String ] });
                ( "phase",
                  {
                    any with
                    kinds = Some [ String ];
                    enum =
                      Some
                        [
                          `Stringlit "\"pending\"";
                          `Stringlit "\"running\"";
                          `Stringlit "\"done\"";
                          `Stringlit "\"failed\"";
                        ];
                  } );
                ( "summary",
                  {
                    any with
                    kinds = Some [ Object ];
                    required =
                      [
                        "resourcesChecked";
                        "divergent";
                        "healed";
                        "healFailures";
                        "orphaned";
                      ];
                    members =
                      [
                        ( "divergent",
                          {
                            any with
                            kinds = Some [ Integer ];
                            minimum = Some "0";
                          } );
                        ( "healFailures",
                          {
                            any with
                            kinds = Some [ Integer ];
                            minimum = Some "0";
                          } );
                        ( "healed",
                          {
                            any with
                            kinds = Some [ Integer ];
                            minimum = Some "0";
                          } );
                        ( "orphaned",
                          {
                            any with
                            kinds = Some [ Integer ];
                            minimum = Some "0";
                          } );
                        ( "resourcesChecked",
                          {
                            any with
                            kinds = Some [ Integer ];
                            minimum = Some "0";
                          } );
                      ];
                    closed =
                      Some
                        [
                          "divergent";
                          "healFailures";
                          "healed";
                          "orphaned";
                          "resourcesChecked";
                        ];
                  } );
              ];
            closed = Some [ "error"; "phase"; "summary" ];
          } );
        ( "status",
          {
            any with
            kinds = Some [ String ];
            enum = Some [ `Stringlit "\"ok\"" ];
          } );
      ];
    closed = Some [ "following"; "kb"; "reconcile"; "status" ];
  }

let shape_330 () =
  {
    any with
    kinds = Some [ Object ];
    required =
      [ "knowledgeBases"; "modelCatalogue"; "port"; "logLevel"; "logFormat" ];
    members =
      [
        ( "knowledgeBases",
          {
            any with
            kinds = Some [ Array ];
            min_items = Some 1;
            items =
              Some { any with reference = Some "WorkerKnowledgeBaseConfig" };
          } );
        ("logFormat", { any with reference = Some "LogFormat" });
        ("logLevel", { any with reference = Some "LogLevel" });
        ( "modelCatalogue",
          { any with kinds = Some [ String ]; min_length = Some 1 } );
        ( "port",
          {
            any with
            kinds = Some [ Integer ];
            minimum = Some "1";
            maximum = Some "65535";
          } );
      ];
    closed =
      Some
        [ "knowledgeBases"; "logFormat"; "logLevel"; "modelCatalogue"; "port" ];
  }

let shape_331 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "engine"; "jobs"; "baseUrl" ];
    members =
      [
        ("apiKeyEnv", { any with kinds = Some [ String ]; min_length = Some 1 });
        ("baseUrl", { any with kinds = Some [ String ]; min_length = Some 1 });
        ("engine", { any with reference = Some "Engine" });
        ( "jobs",
          {
            any with
            kinds = Some [ Array ];
            min_items = Some 1;
            items = Some { any with reference = Some "JobFilter" };
          } );
      ];
    closed = Some [ "apiKeyEnv"; "baseUrl"; "engine"; "jobs" ];
  }

let shape_332 () =
  {
    any with
    kinds = Some [ Object ];
    required =
      [
        "engine";
        "jobs";
        "lastQueuedEventAt";
        "lastClaimAt";
        "lastFinishedAt";
        "lastActivityAt";
        "activeJob";
        "jobsCompleted";
      ];
    members =
      [
        ( "activeJob",
          {
            any with
            kinds = Some [ Object; Null ];
            required = [ "jobId"; "type"; "since" ];
            members =
              [
                ("jobId", { any with reference = Some "JobId" });
                ("since", { any with kinds = Some [ String ] });
                ("type", { any with reference = Some "JobType" });
              ];
            closed = Some [ "jobId"; "since"; "type" ];
          } );
        ("engine", { any with reference = Some "Engine" });
        ( "jobs",
          {
            any with
            kinds = Some [ Array ];
            min_items = Some 1;
            items = Some { any with reference = Some "JobFilter" };
          } );
        ( "jobsCompleted",
          { any with kinds = Some [ Integer ]; minimum = Some "0" } );
        ("lastActivityAt", { any with kinds = Some [ String; Null ] });
        ("lastClaimAt", { any with kinds = Some [ String; Null ] });
        ("lastFinishedAt", { any with kinds = Some [ String; Null ] });
        ("lastQueuedEventAt", { any with kinds = Some [ String; Null ] });
      ];
    closed =
      Some
        [
          "activeJob";
          "engine";
          "jobs";
          "jobsCompleted";
          "lastActivityAt";
          "lastClaimAt";
          "lastFinishedAt";
          "lastQueuedEventAt";
        ];
  }

let shape_333 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "status"; "knowledgeBases" ];
    members =
      [
        ( "knowledgeBases",
          {
            any with
            kinds = Some [ Array ];
            min_items = Some 1;
            items =
              Some { any with reference = Some "WorkerKnowledgeBaseHealth" };
          } );
        ( "status",
          {
            any with
            kinds = Some [ String ];
            enum = Some [ `Stringlit "\"ok\"" ];
          } );
      ];
    closed = Some [ "knowledgeBases"; "status" ];
  }

let shape_334 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "domain"; "gatewayUrl"; "identity"; "engines" ];
    members =
      [
        ("domain", { any with kinds = Some [ String ]; min_length = Some 1 });
        ( "engines",
          {
            any with
            kinds = Some [ Array ];
            min_items = Some 1;
            items = Some { any with reference = Some "WorkerEngineConfig" };
          } );
        ("gatewayUrl", { any with kinds = Some [ String ]; min_length = Some 1 });
        ( "identity",
          {
            any with
            kinds = Some [ Object ];
            required = [ "issuer"; "clientId" ];
            members =
              [
                ( "clientId",
                  { any with kinds = Some [ String ]; min_length = Some 1 } );
                ( "issuer",
                  { any with kinds = Some [ String ]; min_length = Some 1 } );
              ];
            closed = Some [ "clientId"; "issuer" ];
          } );
      ];
    closed = Some [ "domain"; "engines"; "gatewayUrl"; "identity" ];
  }

let shape_335 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "domain"; "state" ];
    members =
      [
        ("did", { any with kinds = Some [ String ]; min_length = Some 1 });
        ("domain", { any with kinds = Some [ String ]; min_length = Some 1 });
        ( "engines",
          {
            any with
            kinds = Some [ Array ];
            min_items = Some 1;
            items = Some { any with reference = Some "WorkerEngineHealth" };
          } );
        ( "state",
          {
            any with
            kinds = Some [ String ];
            enum =
              Some
                [
                  `Stringlit "\"starting\"";
                  `Stringlit "\"working\"";
                  `Stringlit "\"refused\"";
                ];
          } );
      ];
    closed = Some [ "did"; "domain"; "engines"; "state" ];
  }

let shape_336 () =
  {
    any with
    kinds = Some [ Object ];
    required =
      [ "token"; "name"; "storageUri"; "contentChecksum"; "byteSize"; "format" ];
    members =
      [
        ("_userId", { any with reference = Some "UserId" });
        ("archiveOriginal", { any with kinds = Some [ Boolean ] });
        ("byteSize", { any with kinds = Some [ Integer ] });
        ("contentChecksum", { any with kinds = Some [ String ] });
        ("format", { any with reference = Some "ContentFormat" });
        ("name", { any with kinds = Some [ String ] });
        ("storageUri", { any with kinds = Some [ String ] });
        ("token", { any with kinds = Some [ String ] });
      ];
  }

let shape_337 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "response" ];
    members = [ ("response", { any with reference = Some "YieldedResource" }) ];
  }

let shape_338 () =
  {
    any with
    kinds = Some [ Object ];
    required =
      [
        "name";
        "storageUri";
        "contentChecksum";
        "byteSize";
        "format";
        "parentResourceId";
      ];
    members =
      [
        ("_userId", { any with reference = Some "UserId" });
        ("byteSize", { any with kinds = Some [ Integer ] });
        ("contentChecksum", { any with kinds = Some [ String ] });
        ( "entityTypes",
          {
            any with
            kinds = Some [ Array ];
            items = Some { any with kinds = Some [ String ] };
          } );
        ("format", { any with reference = Some "ContentFormat" });
        ("language", { any with kinds = Some [ String ] });
        ("name", { any with kinds = Some [ String ] });
        ("parentResourceId", { any with reference = Some "ResourceId" });
        ("storageUri", { any with kinds = Some [ String ] });
      ];
  }

let shape_339 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "response" ];
    members = [ ("response", { any with reference = Some "YieldedResource" }) ];
  }

let shape_340 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "token" ];
    members = [ ("token", { any with kinds = Some [ String ] }) ];
  }

let shape_341 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "resourceId" ];
    members = [ ("resourceId", { any with reference = Some "ResourceId" }) ];
  }

let shape_342 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "name"; "storageUri"; "contentChecksum"; "byteSize"; "format" ];
    members =
      [
        ( "_roles",
          {
            any with
            kinds = Some [ Array ];
            items = Some { any with kinds = Some [ String ] };
          } );
        ("_userId", { any with reference = Some "UserId" });
        ("byteSize", { any with kinds = Some [ Integer ] });
        ("contentChecksum", { any with kinds = Some [ String ] });
        ( "entityTypes",
          {
            any with
            kinds = Some [ Array ];
            items = Some { any with kinds = Some [ String ] };
          } );
        ("format", { any with reference = Some "ContentFormat" });
        ( "generatedFrom",
          {
            any with
            kinds = Some [ Object ];
            members =
              [
                ("annotationId", { any with reference = Some "AnnotationId" });
                ("resourceId", { any with reference = Some "ResourceId" });
              ];
          } );
        ("generationPrompt", { any with kinds = Some [ String ] });
        ("generator", { any with reference = Some "OneOrMoreAgents" });
        ("isDraft", { any with kinds = Some [ Boolean ] });
        ("jobId", { any with reference = Some "JobId" });
        ("language", { any with kinds = Some [ String ] });
        ("name", { any with kinds = Some [ String ] });
        ("storageUri", { any with kinds = Some [ String ] });
      ];
  }

let shape_343 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "response" ];
    members = [ ("response", { any with reference = Some "YieldedResource" }) ];
  }

let shape_344 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "resourceId"; "jobId"; "jobType" ];
    members =
      [
        ("_userId", { any with reference = Some "UserId" });
        ("annotationId", { any with reference = Some "AnnotationId" });
        ("attempt", { any with kinds = Some [ Integer ] });
        ("durability", { any with reference = Some "DurabilityEvidence" });
        ("jobId", { any with reference = Some "JobId" });
        ( "jobType",
          {
            any with
            kinds = Some [ String ];
            enum = Some [ `Stringlit "\"yield\"" ];
          } );
        ("resourceId", { any with reference = Some "ResourceId" });
        ("result", { any with reference = Some "YieldJobResult" });
      ];
  }

let shape_345 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "jobType"; "params" ];
    members =
      [
        ( "_roles",
          {
            any with
            kinds = Some [ Array ];
            items = Some { any with kinds = Some [ String ] };
          } );
        ("_userId", { any with reference = Some "UserId" });
        ( "jobType",
          {
            any with
            kinds = Some [ String ];
            enum = Some [ `Stringlit "\"yield\"" ];
          } );
        ("params", { any with reference = Some "GenerationJobParams" });
      ];
    closed = Some [ "_roles"; "_userId"; "jobType"; "params" ];
  }

let shape_346 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "resourceId"; "resourceName"; "truncated" ];
    members =
      [
        ("resourceId", { any with reference = Some "ResourceId" });
        ("resourceName", { any with kinds = Some [ String ] });
        ("truncated", { any with kinds = Some [ Boolean ] });
      ];
    closed = Some [ "resourceId"; "resourceName"; "truncated" ];
  }

let shape_347 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "jobType" ];
    members =
      [
        ( "jobType",
          {
            any with
            kinds = Some [ String ];
            enum = Some [ `Stringlit "\"yield\"" ];
          } );
      ];
    closed = Some [ "jobType" ];
  }

let shape_348 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "jobId"; "jobType"; "resourceId"; "userId"; "params" ];
    members =
      [
        ("jobId", { any with reference = Some "JobId" });
        ( "jobType",
          {
            any with
            kinds = Some [ String ];
            enum = Some [ `Stringlit "\"yield\"" ];
          } );
        ("params", { any with reference = Some "GenerationJobRequest" });
        ("resourceId", { any with reference = Some "ResourceId" });
        ("userId", { any with reference = Some "UserId" });
      ];
  }

let shape_349 () =
  {
    any with
    kinds = Some [ Object ];
    variants =
      [
        { any with reference = Some "YieldJobDone" };
        { any with reference = Some "JobDeclined" };
      ];
  }

let shape_350 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "resourceId"; "storageUri"; "contentChecksum"; "byteSize" ];
    members =
      [
        ("_userId", { any with reference = Some "UserId" });
        ("byteSize", { any with kinds = Some [ Integer ] });
        ("contentChecksum", { any with kinds = Some [ String ] });
        ("resourceId", { any with reference = Some "ResourceId" });
        ("storageUri", { any with kinds = Some [ String ] });
      ];
  }

let shape_351 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "response" ];
    members = [ ("response", { any with reference = Some "YieldedResource" }) ];
  }

let shape_352 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "resourceId" ];
    members = [ ("resourceId", { any with reference = Some "ResourceId" }) ];
  }

let all =
  [
    ("Agent", shape_0);
    ("AgentOrganization", shape_1);
    ("AgentPerson", shape_2);
    ("AgentSoftware", shape_3);
    ("AnchorRect", shape_4);
    ("AnchoredText", shape_5);
    ("AnchoredTextAbsent", shape_6);
    ("AnchoredTextAnswer", shape_7);
    ("AnchoredTextDeclinedEntry", shape_8);
    ("AnchoredTextEntries", shape_9);
    ("AnchoredTextEntry", shape_10);
    ("AnchoredTextExtractedEntry", shape_11);
    ("AnchoredTextStamp", shape_12);
    ("AnchoredTextWrite", shape_13);
    ("Annotation", shape_14);
    ("AnnotationAddedPayload", shape_15);
    ("AnnotationBodies", shape_16);
    ("AnnotationBody", shape_17);
    ("AnnotationBodyUpdatedPayload", shape_18);
    ("AnnotationId", shape_19);
    ("AnnotationRemovedPayload", shape_20);
    ("AnnotationSelector", shape_21);
    ("AnnotationTarget", shape_22);
    ("ArchivistConfig", shape_23);
    ("ArchivistEngines", shape_24);
    ("ArchivistEventsResponse", shape_25);
    ("ArchivistHealth", shape_26);
    ("ArchivistStream", shape_27);
    ("ArchivistStreamsResponse", shape_28);
    ("AssessingJobParams", shape_29);
    ("AttributedEvent", shape_30);
    ("BeckonFocusEvent", shape_31);
    ("BeckonHoverEvent", shape_32);
    ("BeckonSparkleEvent", shape_33);
    ("BindBodyOperation", shape_34);
    ("BindBodyUpdated", shape_35);
    ("BindInitiateCommand", shape_36);
    ("BindUpdateBodyCommand", shape_37);
    ("BodyOperation", shape_38);
    ("BodyOperationAdd", shape_39);
    ("BodyOperationRemove", shape_40);
    ("BodyOperationReplace", shape_41);
    ("BodyPurpose", shape_42);
    ("BrowseAnnotationHistoryRequest", shape_43);
    ("BrowseAnnotationHistoryResult", shape_44);
    ("BrowseAnnotationRequest", shape_45);
    ("BrowseAnnotationResult", shape_46);
    ("BrowseClickEvent", shape_47);
    ("BrowseDirectoryFailed", shape_48);
    ("BrowseDirectoryRequest", shape_49);
    ("BrowseDirectoryResult", shape_50);
    ("BrowseDirectoryResultResponse", shape_51);
    ("BrowseEnginesRequest", shape_52);
    ("BrowseEnginesResult", shape_53);
    ("BrowseEntityTypeClickedEvent", shape_54);
    ("BrowseEntityTypesRequest", shape_55);
    ("BrowseEntityTypesResult", shape_56);
    ("BrowseEventsRequest", shape_57);
    ("BrowseEventsResult", shape_58);
    ("BrowseExternalNavigateEvent", shape_59);
    ("BrowseFilesResponse", shape_60);
    ("BrowseKbRequest", shape_61);
    ("BrowseKbResult", shape_62);
    ("BrowseLinkClickedEvent", shape_63);
    ("BrowsePanelOpenEvent", shape_64);
    ("BrowsePanelToggleEvent", shape_65);
    ("BrowseProfilesRequest", shape_66);
    ("BrowseProfilesResult", shape_67);
    ("BrowseResourceCloseEvent", shape_68);
    ("BrowseResourceOpenEvent", shape_69);
    ("BrowseResourceReorderEvent", shape_70);
    ("BrowseResourceRequest", shape_71);
    ("BrowseResourceResult", shape_72);
    ("BrowseResourceViewedEvent", shape_73);
    ("BrowseResourcesRequest", shape_74);
    ("BrowseResourcesResult", shape_75);
    ("BrowseRouterPushEvent", shape_76);
    ("BrowseTagSchemasRequest", shape_77);
    ("BrowseTagSchemasResult", shape_78);
    ("BusEmitAccepted", shape_79);
    ("BusEmitRequest", shape_80);
    ("BusEventMessage", shape_81);
    ("BusFrame", shape_82);
    ("BusPingMessage", shape_83);
    ("BusResumeGap", shape_84);
    ("BusStreamMessage", shape_85);
    ("BusSubscribeRequest", shape_86);
    ("CloneResourceWithTokenResponse", shape_87);
    ("CommandError", shape_88);
    ("CommentingJobParams", shape_89);
    ("ContentFormat", shape_90);
    ("ContextualSummaryResponse", shape_91);
    ("CreateAnnotationRequest", shape_92);
    ("CreateResourceResponse", shape_93);
    ("CursorsPath", shape_94);
    ("DirEntry", shape_95);
    ("DirectoryEntry", shape_96);
    ("DiscoveredKB", shape_97);
    ("DiscoveryDocument", shape_98);
    ("DispatcherConfig", shape_99);
    ("DispatcherHealth", shape_100);
    ("DurabilityEvidence", shape_101);
    ("EmbeddingConfig", shape_102);
    ("Engine", shape_103);
    ("EngineEntry", shape_104);
    ("EngineLimits", shape_105);
    ("EnrichedResourceEvent", shape_106);
    ("EntityTagChangedPayload", shape_107);
    ("EntityTypeAddedPayload", shape_108);
    ("EntityTypesProjection", shape_109);
    ("EphemeralEventId", shape_110);
    ("ErrorResponse", shape_111);
    ("EventMetadata", shape_112);
    ("ExtractedText", shape_113);
    ("ExtractionDeclined", shape_114);
    ("ExtractionDeclinedReason", shape_115);
    ("ExtractionMethod", shape_116);
    ("ExtractionOutcome", shape_117);
    ("FailureClass", shape_118);
    ("FileEntry", shape_119);
    ("FragmentSelector", shape_120);
    ("FrameAddEntityTypeCommand", shape_121);
    ("FrameAddTagSchemaCommand", shape_122);
    ("GatewayConfig", shape_123);
    ("GatherAnnotationComplete", shape_124);
    ("GatherAnnotationOptions", shape_125);
    ("GatherAnnotationRequest", shape_126);
    ("GatherFailed", shape_127);
    ("GatherReferencedByRequest", shape_128);
    ("GatherReferencedByResult", shape_129);
    ("GatherResourceComplete", shape_130);
    ("GatherResourceFailed", shape_131);
    ("GatherResourceRequest", shape_132);
    ("GatherResourceRequestOptions", shape_133);
    ("GatherSummaryRequest", shape_134);
    ("GatheredContext", shape_135);
    ("GenerationJobParams", shape_136);
    ("GenerationJobRequest", shape_137);
    ("GetAnnotationHistoryResponse", shape_138);
    ("GetAnnotationResponse", shape_139);
    ("GetAnnotationsResponse", shape_140);
    ("GetEntityTypesResponse", shape_141);
    ("GetEventsResponse", shape_142);
    ("GetReferencedByResponse", shape_143);
    ("GetReferencedByResponseReferencedByItem", shape_144);
    ("GetResourceByTokenResponse", shape_145);
    ("GetResourceResponse", shape_146);
    ("GetTagSchemasResponse", shape_147);
    ("GraphAnnotationNode", shape_148);
    ("GraphConfig", shape_149);
    ("GraphResourceNode", shape_150);
    ("HealthResponse", shape_151);
    ("HighlightingJobParams", shape_152);
    ("HttpEndpoint", shape_153);
    ("InferenceLimits", shape_154);
    ("InferenceLimitsRequest", shape_155);
    ("InferenceLimitsResult", shape_156);
    ("JanusGraphConfig", shape_157);
    ("Job", shape_158);
    ("JobAssignCommand", shape_159);
    ("JobAssignedPayload", shape_160);
    ("JobCancelCommand", shape_161);
    ("JobCancelRequest", shape_162);
    ("JobCancelResult", shape_163);
    ("JobCancelled", shape_164);
    ("JobCheckpointCommand", shape_165);
    ("JobClaimCommand", shape_166);
    ("JobClaimedResult", shape_167);
    ("JobComplete", shape_168);
    ("JobCompleteCommand", shape_169);
    ("JobCompletedPayload", shape_170);
    ("JobCreateCommand", shape_171);
    ("JobCreatedResult", shape_172);
    ("JobCreatedResultResponse", shape_173);
    ("JobDeclined", shape_174);
    ("JobFailCommand", shape_175);
    ("JobFailed", shape_176);
    ("JobFailedPayload", shape_177);
    ("JobFilter", shape_178);
    ("JobId", shape_179);
    ("JobMetadata", shape_180);
    ("JobParams", shape_181);
    ("JobPending", shape_182);
    ("JobProgress", shape_183);
    ("JobProgressAnalyzing", shape_184);
    ("JobProgressAnalyzingTags", shape_185);
    ("JobProgressCompleteCreated", shape_186);
    ("JobProgressCompleteGenerated", shape_187);
    ("JobProgressCreatingAnnotations", shape_188);
    ("JobProgressCreatingResource", shape_189);
    ("JobProgressCreatingTagAnnotations", shape_190);
    ("JobProgressDetectingEntities", shape_191);
    ("JobProgressGeneratingResource", shape_192);
    ("JobProgressLoading", shape_193);
    ("JobProgressMessage", shape_194);
    ("JobQueuedEvent", shape_195);
    ("JobRecord", shape_196);
    ("JobReportProgressCommand", shape_197);
    ("JobResult", shape_198);
    ("JobRunning", shape_199);
    ("JobStartCommand", shape_200);
    ("JobStartedPayload", shape_201);
    ("JobStatusRequest", shape_202);
    ("JobStatusResponse", shape_203);
    ("JobStatusResult", shape_204);
    ("JobStoredProgress", shape_205);
    ("JobStoredResult", shape_206);
    ("JobType", shape_207);
    ("KbDescription", shape_208);
    ("KbEndpoint", shape_209);
    ("KbIdentity", shape_210);
    ("KbRead", shape_211);
    ("KbTarget", shape_212);
    ("KnowledgeBase", shape_213);
    ("KnowledgeGraph", shape_214);
    ("LibrarianConfig", shape_215);
    ("LibrarianEngineConfig", shape_216);
    ("LibrarianHealth", shape_217);
    ("LimitRefusal", shape_218);
    ("LinkingJobParams", shape_219);
    ("ListResourcesResponse", shape_220);
    ("LocalEndpoint", shape_221);
    ("LogFormat", shape_222);
    ("LogLevel", shape_223);
    ("MarkArchiveCommand", shape_224);
    ("MarkCommitCommand", shape_225);
    ("MarkCommitOk", shape_226);
    ("MarkCreateOk", shape_227);
    ("MarkCreateOkResponse", shape_228);
    ("MarkCreateRequest", shape_229);
    ("MarkDelegateTimeoutEvent", shape_230);
    ("MarkDeleteCommand", shape_231);
    ("MarkDeleteOk", shape_232);
    ("MarkJobCompleteCommand", shape_233);
    ("MarkJobCreateCommand", shape_234);
    ("MarkJobDone", shape_235);
    ("MarkJobFilter", shape_236);
    ("MarkJobParams", shape_237);
    ("MarkJobQueuedEvent", shape_238);
    ("MarkJobResult", shape_239);
    ("MarkRequestedEvent", shape_240);
    ("MarkSubmitEvent", shape_241);
    ("MarkUnarchiveCommand", shape_242);
    ("MarkUpdateBodyCommand", shape_243);
    ("MarkUpdateEntityTypesCommand", shape_244);
    ("MatchResourcesRequest", shape_245);
    ("MatchResourcesResponse", shape_246);
    ("MatchResourcesResult", shape_247);
    ("MatchSearchFailed", shape_248);
    ("MatchSearchRequest", shape_249);
    ("MatchSearchResult", shape_250);
    ("MediaTokenRequest", shape_251);
    ("MediaTokenResponse", shape_252);
    ("MemoryGraphConfig", shape_253);
    ("MemoryVectorsConfig", shape_254);
    ("Motivation", shape_255);
    ("Neo4jGraphConfig", shape_256);
    ("NeptuneGraphConfig", shape_257);
    ("NewKnowledgeBase", shape_258);
    ("OcrConfidence", shape_259);
    ("OllamaEmbeddingConfig", shape_260);
    ("OneOrMoreAgents", shape_261);
    ("OneOrMoreStrings", shape_262);
    ("OneOrMoreUris", shape_263);
    ("PdfClass", shape_264);
    ("PdfTextItem", shape_265);
    ("PersistedEventId", shape_266);
    ("PrincipalProfileCommand", shape_267);
    ("PrincipalProfiledPayload", shape_268);
    ("Profile", shape_269);
    ("ProfilesProjection", shape_270);
    ("ProtectedResourceMetadata", shape_271);
    ("QdrantVectorsConfig", shape_272);
    ("ReplyEventId", shape_273);
    ("Representation", shape_274);
    ("RepresentationAddedPayload", shape_275);
    ("RepresentationNotFound", shape_276);
    ("RepresentationRemovedPayload", shape_277);
    ("ResourceAnnotations", shape_278);
    ("ResourceArchivedPayload", shape_279);
    ("ResourceClonedPayload", shape_280);
    ("ResourceCreatedPayload", shape_281);
    ("ResourceDescriptor", shape_282);
    ("ResourceErrorEvent", shape_283);
    ("ResourceId", shape_284);
    ("ResourceMovedPayload", shape_285);
    ("ResourceUnarchivedPayload", shape_286);
    ("ResourceUpdatedPayload", shape_287);
    ("ResourceUpload", shape_288);
    ("ResourceView", shape_289);
    ("ScoredResource", shape_290);
    ("Selector", shape_291);
    ("SemanticMatch", shape_292);
    ("ServiceAddress", shape_293);
    ("ServiceIdentity", shape_294);
    ("SessionJoinedEvent", shape_295);
    ("SessionLeftEvent", shape_296);
    ("SettingsHoverDelayChangedEvent", shape_297);
    ("SettingsLocaleChangedEvent", shape_298);
    ("SettingsThemeChangedEvent", shape_299);
    ("SmeltRebuildAnchorsCommand", shape_300);
    ("SmeltSettled", shape_301);
    ("SmelterChunking", shape_302);
    ("SmelterConfig", shape_303);
    ("SmelterHealth", shape_304);
    ("SmelterReconcileSummary", shape_305);
    ("SpecificResource", shape_306);
    ("StatusResponse", shape_307);
    ("StorageUriEntry", shape_308);
    ("StoredEventResponse", shape_309);
    ("SupportedMediaType", shape_310);
    ("SvgSelector", shape_311);
    ("TagCategory", shape_312);
    ("TagSchema", shape_313);
    ("TagSchemaAddedPayload", shape_314);
    ("TagSchemasProjection", shape_315);
    ("TaggingJobParams", shape_316);
    ("TextPositionSelector", shape_317);
    ("TextQuoteSelector", shape_318);
    ("TextualBody", shape_319);
    ("UnitCursor", shape_320);
    ("UpdateAnnotationBodyRequest", shape_321);
    ("UserId", shape_322);
    ("UserResponse", shape_323);
    ("VectorsConfig", shape_324);
    ("VoyageEmbeddingConfig", shape_325);
    ("WeaveApplied", shape_326);
    ("WeaveRebuildCommand", shape_327);
    ("WeaverConfig", shape_328);
    ("WeaverHealth", shape_329);
    ("WorkerConfig", shape_330);
    ("WorkerEngineConfig", shape_331);
    ("WorkerEngineHealth", shape_332);
    ("WorkerHealth", shape_333);
    ("WorkerKnowledgeBaseConfig", shape_334);
    ("WorkerKnowledgeBaseHealth", shape_335);
    ("YieldCloneCreateCommand", shape_336);
    ("YieldCloneCreated", shape_337);
    ("YieldClonePersistCommand", shape_338);
    ("YieldClonePersistOk", shape_339);
    ("YieldCloneResourceRequest", shape_340);
    ("YieldCloneTokenRequest", shape_341);
    ("YieldCreateCommand", shape_342);
    ("YieldCreateOk", shape_343);
    ("YieldJobCompleteCommand", shape_344);
    ("YieldJobCreateCommand", shape_345);
    ("YieldJobDone", shape_346);
    ("YieldJobFilter", shape_347);
    ("YieldJobQueuedEvent", shape_348);
    ("YieldJobResult", shape_349);
    ("YieldUpdateCommand", shape_350);
    ("YieldUpdateOk", shape_351);
    ("YieldedResource", shape_352);
  ]
