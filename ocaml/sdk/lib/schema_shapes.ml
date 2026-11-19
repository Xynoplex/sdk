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

let shape_5 () =
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

let shape_6 () =
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

let shape_7 () =
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

let shape_8 () =
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

let shape_9 () =
  {
    any with
    kinds = Some [ Object ];
    variants =
      [
        { any with reference = Some "AnchoredTextExtractedEntry" };
        { any with reference = Some "AnchoredTextDeclinedEntry" };
      ];
  }

let shape_10 () =
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

let shape_11 () =
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

let shape_12 () =
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

let shape_13 () =
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

let shape_14 () =
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

let shape_15 () =
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

let shape_16 () =
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

let shape_17 () =
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

let shape_18 () =
  {
    any with
    kinds = Some [ String ];
    pattern =
      Some
        [ ([ (45, 45); (48, 57); (65, 90); (95, 95); (97, 122) ], 1, Some 128) ];
  }

let shape_19 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "annotationId" ];
    members = [ ("annotationId", { any with reference = Some "AnnotationId" }) ];
  }

let shape_20 () =
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

let shape_21 () =
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

let shape_22 () =
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

let shape_23 () =
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

let shape_24 () =
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

let shape_25 () =
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
            items = Some { any with kinds = Some [ String ] };
          } );
        ( "status",
          {
            any with
            kinds = Some [ String ];
            enum = Some [ `Stringlit "\"ok\"" ];
          } );
      ];
  }

let shape_26 () =
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

let shape_27 () =
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

let shape_28 () =
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

let shape_29 () =
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

let shape_30 () =
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

let shape_31 () =
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

let shape_32 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "annotationId" ];
    members = [ ("annotationId", { any with reference = Some "AnnotationId" }) ];
  }

let shape_33 () =
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

let shape_34 () = { any with kinds = Some [ Object ] }

let shape_35 () =
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

let shape_36 () =
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

let shape_37 () =
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

let shape_38 () =
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
            enum = Some [ `Stringlit "\"remove\"" ];
          } );
      ];
  }

let shape_40 () =
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

let shape_41 () =
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

let shape_42 () =
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

let shape_43 () =
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

let shape_44 () =
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

let shape_45 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "response" ];
    members =
      [ ("response", { any with reference = Some "GetAnnotationResponse" }) ];
  }

let shape_46 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "annotationId" ];
    members = [ ("annotationId", { any with reference = Some "AnnotationId" }) ];
  }

let shape_47 () =
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

let shape_48 () =
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

let shape_49 () =
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

let shape_50 () =
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

let shape_51 () = { any with kinds = Some [ Object ] }

let shape_52 () =
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

let shape_53 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "entityType" ];
    members = [ ("entityType", { any with kinds = Some [ String ] }) ];
  }

let shape_54 () = { any with kinds = Some [ Object ] }

let shape_55 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "response" ];
    members =
      [ ("response", { any with reference = Some "GetEntityTypesResponse" }) ];
  }

let shape_56 () =
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

let shape_57 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "response" ];
    members =
      [ ("response", { any with reference = Some "GetEventsResponse" }) ];
  }

let shape_58 () =
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

let shape_59 () =
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

let shape_60 () = { any with kinds = Some [ Object ] }

let shape_61 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "response" ];
    members = [ ("response", { any with reference = Some "KbDescription" }) ];
  }

let shape_62 () =
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

let shape_63 () =
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

let shape_64 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "panel" ];
    members = [ ("panel", { any with kinds = Some [ String ] }) ];
  }

let shape_65 () =
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

let shape_66 () =
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

let shape_67 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "resourceId" ];
    members = [ ("resourceId", { any with reference = Some "ResourceId" }) ];
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
    required = [ "oldIndex"; "newIndex" ];
    members =
      [
        ("newIndex", { any with kinds = Some [ Integer ] });
        ("oldIndex", { any with kinds = Some [ Integer ] });
      ];
  }

let shape_70 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "resourceId" ];
    members = [ ("resourceId", { any with reference = Some "ResourceId" }) ];
  }

let shape_71 () =
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

let shape_72 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "resourceId" ];
    members = [ ("resourceId", { any with reference = Some "ResourceId" }) ];
  }

let shape_73 () =
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

let shape_74 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "response" ];
    members =
      [ ("response", { any with reference = Some "ListResourcesResponse" }) ];
  }

let shape_75 () =
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

let shape_76 () = { any with kinds = Some [ Object ] }

let shape_77 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "response" ];
    members =
      [ ("response", { any with reference = Some "GetTagSchemasResponse" }) ];
  }

let shape_78 () =
  {
    any with
    kinds = Some [ Object ];
    members =
      [
        ( "subscribers",
          { any with kinds = Some [ Integer ]; minimum = Some "0" } );
      ];
  }

let shape_79 () =
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

let shape_80 () =
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

let shape_81 () =
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

let shape_82 () =
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

let shape_83 () =
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

let shape_84 () =
  {
    any with
    kinds = Some [ Object ];
    variants =
      [
        { any with reference = Some "BusEventMessage" };
        { any with reference = Some "BusPingMessage" };
      ];
  }

let shape_85 () =
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

let shape_86 () =
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

let shape_87 () =
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

let shape_88 () =
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

let shape_89 () = { any with kinds = Some [ String ] }

let shape_90 () =
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

let shape_91 () =
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

let shape_92 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "resourceId" ];
    members = [ ("resourceId", { any with reference = Some "ResourceId" }) ];
  }

let shape_93 () = { any with kinds = Some [ String ]; min_length = Some 1 }

let shape_94 () =
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

let shape_95 () =
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

let shape_96 () =
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

let shape_97 () =
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

let shape_98 () =
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

let shape_99 () =
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

let shape_100 () =
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

let shape_101 () =
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

let shape_102 () =
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

let shape_103 () =
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

let shape_104 () =
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

let shape_105 () =
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

let shape_106 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "entityType" ];
    members = [ ("entityType", { any with kinds = Some [ String ] }) ];
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

let shape_109 () =
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

let shape_110 () =
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

let shape_111 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "sequenceNumber" ];
    members = [ ("sequenceNumber", { any with kinds = Some [ Integer ] }) ];
  }

let shape_112 () =
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

let shape_113 () =
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

let shape_114 () =
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

let shape_115 () =
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

let shape_116 () =
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

let shape_117 () =
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

let shape_118 () =
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

let shape_119 () =
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

let shape_120 () =
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

let shape_121 () =
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

let shape_122 () =
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

let shape_123 () =
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

let shape_124 () =
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

let shape_125 () =
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

let shape_126 () =
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

let shape_127 () =
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

let shape_128 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "response" ];
    members =
      [ ("response", { any with reference = Some "GetReferencedByResponse" }) ];
  }

let shape_129 () =
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

let shape_130 () =
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

let shape_131 () =
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

let shape_132 () =
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

let shape_133 () =
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

let shape_134 () =
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

let shape_135 () =
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

let shape_136 () =
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

let shape_137 () =
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

let shape_138 () =
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

let shape_139 () =
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

let shape_140 () =
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

let shape_141 () =
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

let shape_142 () =
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

let shape_143 () =
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

let shape_144 () =
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

let shape_145 () =
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

let shape_146 () =
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

let shape_147 () =
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

let shape_148 () =
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

let shape_149 () =
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

let shape_150 () =
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

let shape_151 () =
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

let shape_152 () =
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

let shape_153 () =
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

let shape_154 () = { any with kinds = Some [ Object ] }

let shape_155 () =
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

let shape_156 () =
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

let shape_157 () =
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

let shape_158 () =
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

let shape_159 () =
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

let shape_160 () =
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

let shape_161 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "jobId" ];
    members = [ ("jobId", { any with reference = Some "JobId" }) ];
  }

let shape_162 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "cancelled" ];
    members = [ ("cancelled", { any with kinds = Some [ Boolean ] }) ];
  }

let shape_163 () =
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

let shape_164 () =
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

let shape_165 () =
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

let shape_166 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "response" ];
    members = [ ("response", { any with reference = Some "JobRunning" }) ];
    closed = Some [ "response" ];
  }

let shape_167 () =
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

let shape_168 () =
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

let shape_169 () =
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

let shape_170 () =
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

let shape_171 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "response" ];
    members =
      [ ("response", { any with reference = Some "JobCreatedResultResponse" }) ];
  }

let shape_172 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "jobId" ];
    members = [ ("jobId", { any with reference = Some "JobId" }) ];
  }

let shape_173 () =
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

let shape_174 () =
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

let shape_175 () =
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

let shape_176 () =
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

let shape_177 () =
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

let shape_178 () =
  {
    any with
    kinds = Some [ String ];
    pattern =
      Some
        [ ([ (45, 45); (48, 57); (65, 90); (95, 95); (97, 122) ], 1, Some 128) ];
  }

let shape_179 () =
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

let shape_180 () =
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

let shape_181 () =
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

let shape_182 () =
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

let shape_183 () =
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
            enum = Some [ `Stringlit "\"analyzing-tags\"" ];
          } );
      ];
  }

let shape_185 () =
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

let shape_186 () =
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

let shape_187 () =
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

let shape_188 () =
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

let shape_189 () =
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

let shape_190 () =
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

let shape_191 () =
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
            enum = Some [ `Stringlit "\"loading\"" ];
          } );
      ];
  }

let shape_193 () =
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

let shape_194 () =
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

let shape_195 () =
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

let shape_196 () =
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

let shape_197 () =
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

let shape_198 () =
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

let shape_199 () =
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

let shape_200 () =
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

let shape_201 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "jobId" ];
    members = [ ("jobId", { any with reference = Some "JobId" }) ];
  }

let shape_202 () =
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

let shape_203 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "response" ];
    members =
      [ ("response", { any with reference = Some "JobStatusResponse" }) ];
  }

let shape_204 () =
  {
    any with
    kinds = Some [ Object ];
    variants =
      [
        { any with reference = Some "JobProgress" };
        { any with kinds = Some [ Object ]; closed = Some [] };
      ];
  }

let shape_205 () =
  {
    any with
    kinds = Some [ Object ];
    variants =
      [
        { any with reference = Some "JobResult" };
        { any with kinds = Some [ Object ]; closed = Some [] };
      ];
  }

let shape_206 () =
  {
    any with
    kinds = Some [ String ];
    enum = Some [ `Stringlit "\"mark\""; `Stringlit "\"yield\"" ];
  }

let shape_207 () =
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

let shape_208 () =
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

let shape_209 () =
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

let shape_210 () =
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

let shape_211 () =
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

let shape_212 () =
  {
    any with
    kinds = Some [ Object ];
    all_of =
      [
        { any with reference = Some "KbTarget" };
        { any with reference = Some "NewKnowledgeBase" };
      ];
  }

let shape_213 () =
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

let shape_214 () =
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

let shape_215 () =
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

let shape_216 () =
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

let shape_217 () =
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

let shape_218 () =
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

let shape_219 () =
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

let shape_220 () =
  {
    any with
    kinds = Some [ String ];
    enum = Some [ `Stringlit "\"json\""; `Stringlit "\"simple\"" ];
  }

let shape_221 () =
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

let shape_222 () =
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

let shape_223 () =
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

let shape_224 () =
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

let shape_225 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "response" ];
    members =
      [ ("response", { any with reference = Some "MarkCreateOkResponse" }) ];
  }

let shape_226 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "annotationId" ];
    members = [ ("annotationId", { any with reference = Some "AnnotationId" }) ];
  }

let shape_227 () =
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

let shape_228 () =
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

let shape_229 () =
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

let shape_230 () =
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

let shape_231 () =
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

let shape_232 () =
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

let shape_233 () =
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

let shape_234 () =
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

let shape_235 () =
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

let shape_236 () =
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

let shape_237 () =
  {
    any with
    kinds = Some [ Object ];
    variants =
      [
        { any with reference = Some "MarkJobDone" };
        { any with reference = Some "JobDeclined" };
      ];
  }

let shape_238 () =
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

let shape_239 () =
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

let shape_240 () =
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

let shape_241 () =
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

let shape_242 () =
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

let shape_243 () =
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

let shape_244 () =
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

let shape_245 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "response" ];
    members =
      [ ("response", { any with reference = Some "MatchResourcesResponse" }) ];
  }

let shape_246 () =
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

let shape_247 () =
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

let shape_248 () =
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

let shape_249 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "resourceId" ];
    members = [ ("resourceId", { any with reference = Some "ResourceId" }) ];
  }

let shape_250 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "token" ];
    members = [ ("token", { any with kinds = Some [ String ] }) ];
  }

let shape_251 () =
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

let shape_252 () =
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

let shape_253 () =
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

let shape_254 () =
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

let shape_255 () =
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

let shape_256 () =
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

let shape_257 () =
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

let shape_258 () =
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

let shape_259 () =
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

let shape_260 () =
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

let shape_261 () =
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

let shape_262 () =
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

let shape_263 () =
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

let shape_264 () =
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

let shape_265 () =
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

let shape_266 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "name" ];
    members = [ ("name", { any with kinds = Some [ String ] }) ];
  }

let shape_267 () =
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

let shape_268 () =
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

let shape_269 () =
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

let shape_270 () =
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

let shape_271 () =
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

let shape_272 () =
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

let shape_273 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "representation" ];
    members =
      [ ("representation", { any with reference = Some "Representation" }) ];
  }

let shape_274 () =
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

let shape_275 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "checksum" ];
    members = [ ("checksum", { any with kinds = Some [ String ] }) ];
  }

let shape_276 () =
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

let shape_277 () =
  {
    any with
    kinds = Some [ Object ];
    members = [ ("reason", { any with kinds = Some [ String ] }) ];
  }

let shape_278 () =
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

let shape_279 () =
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

let shape_280 () =
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

let shape_281 () =
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

let shape_282 () =
  {
    any with
    kinds = Some [ String ];
    pattern =
      Some
        [ ([ (45, 45); (48, 57); (65, 90); (95, 95); (97, 122) ], 1, Some 128) ];
  }

let shape_283 () =
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

let shape_284 () = { any with kinds = Some [ Object ] }

let shape_285 () =
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

let shape_286 () =
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

let shape_287 () =
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

let shape_288 () =
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

let shape_289 () =
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

let shape_290 () =
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

let shape_291 () =
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

let shape_292 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "issuer" ];
    members =
      [ ("issuer", { any with kinds = Some [ String ]; min_length = Some 1 }) ];
    closed = Some [ "issuer" ];
  }

let shape_293 () =
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

let shape_294 () =
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

let shape_295 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "hoverDelayMs" ];
    members = [ ("hoverDelayMs", { any with kinds = Some [ Integer ] }) ];
  }

let shape_296 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "locale" ];
    members = [ ("locale", { any with kinds = Some [ String ] }) ];
  }

let shape_297 () =
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

let shape_298 () =
  {
    any with
    kinds = Some [ Object ];
    members =
      [
        ("_userId", { any with reference = Some "UserId" });
        ("resourceId", { any with reference = Some "ResourceId" });
      ];
  }

let shape_299 () =
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

let shape_300 () =
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
        ( "chunking",
          {
            any with
            kinds = Some [ Object ];
            required = [ "chunkSize"; "overlap" ];
            members =
              [
                ( "chunkSize",
                  { any with kinds = Some [ Integer ]; minimum = Some "1" } );
                ( "overlap",
                  { any with kinds = Some [ Integer ]; minimum = Some "0" } );
              ];
            closed = Some [ "chunkSize"; "overlap" ];
          } );
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

let shape_301 () =
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

let shape_302 () =
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

let shape_303 () =
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

let shape_304 () =
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

let shape_305 () =
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

let shape_306 () =
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

let shape_307 () =
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

let shape_308 () =
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

let shape_309 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "schema" ];
    members = [ ("schema", { any with reference = Some "TagSchema" }) ];
  }

let shape_310 () =
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

let shape_311 () =
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

let shape_312 () =
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

let shape_313 () =
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

let shape_314 () =
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

let shape_315 () =
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

let shape_316 () =
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

let shape_317 () =
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

let shape_318 () =
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

let shape_319 () =
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

let shape_320 () =
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

let shape_321 () =
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

let shape_322 () =
  {
    any with
    kinds = Some [ Object ];
    members =
      [
        ("_userId", { any with reference = Some "UserId" });
        ("resourceId", { any with reference = Some "ResourceId" });
      ];
  }

let shape_323 () =
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

let shape_324 () =
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

let shape_325 () =
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

let shape_326 () =
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

let shape_327 () =
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

let shape_328 () =
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

let shape_329 () =
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

let shape_330 () =
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

let shape_331 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "response" ];
    members = [ ("response", { any with reference = Some "YieldedResource" }) ];
  }

let shape_332 () =
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

let shape_333 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "response" ];
    members = [ ("response", { any with reference = Some "YieldedResource" }) ];
  }

let shape_334 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "token" ];
    members = [ ("token", { any with kinds = Some [ String ] }) ];
  }

let shape_335 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "resourceId" ];
    members = [ ("resourceId", { any with reference = Some "ResourceId" }) ];
  }

let shape_336 () =
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

let shape_339 () =
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

let shape_340 () =
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

let shape_341 () =
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

let shape_342 () =
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

let shape_343 () =
  {
    any with
    kinds = Some [ Object ];
    variants =
      [
        { any with reference = Some "YieldJobDone" };
        { any with reference = Some "JobDeclined" };
      ];
  }

let shape_344 () =
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

let shape_345 () =
  {
    any with
    kinds = Some [ Object ];
    required = [ "response" ];
    members = [ ("response", { any with reference = Some "YieldedResource" }) ];
  }

let shape_346 () =
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
    ("AnchoredText", shape_4);
    ("AnchoredTextAbsent", shape_5);
    ("AnchoredTextAnswer", shape_6);
    ("AnchoredTextDeclinedEntry", shape_7);
    ("AnchoredTextEntries", shape_8);
    ("AnchoredTextEntry", shape_9);
    ("AnchoredTextExtractedEntry", shape_10);
    ("AnchoredTextStamp", shape_11);
    ("AnchoredTextWrite", shape_12);
    ("Annotation", shape_13);
    ("AnnotationAddedPayload", shape_14);
    ("AnnotationBodies", shape_15);
    ("AnnotationBody", shape_16);
    ("AnnotationBodyUpdatedPayload", shape_17);
    ("AnnotationId", shape_18);
    ("AnnotationRemovedPayload", shape_19);
    ("AnnotationSelector", shape_20);
    ("AnnotationTarget", shape_21);
    ("ArchivistConfig", shape_22);
    ("ArchivistEngines", shape_23);
    ("ArchivistEventsResponse", shape_24);
    ("ArchivistHealth", shape_25);
    ("ArchivistStream", shape_26);
    ("ArchivistStreamsResponse", shape_27);
    ("AssessingJobParams", shape_28);
    ("AttributedEvent", shape_29);
    ("BeckonFocusEvent", shape_30);
    ("BeckonHoverEvent", shape_31);
    ("BeckonSparkleEvent", shape_32);
    ("BindBodyOperation", shape_33);
    ("BindBodyUpdated", shape_34);
    ("BindInitiateCommand", shape_35);
    ("BindUpdateBodyCommand", shape_36);
    ("BodyOperation", shape_37);
    ("BodyOperationAdd", shape_38);
    ("BodyOperationRemove", shape_39);
    ("BodyOperationReplace", shape_40);
    ("BodyPurpose", shape_41);
    ("BrowseAnnotationHistoryRequest", shape_42);
    ("BrowseAnnotationHistoryResult", shape_43);
    ("BrowseAnnotationRequest", shape_44);
    ("BrowseAnnotationResult", shape_45);
    ("BrowseClickEvent", shape_46);
    ("BrowseDirectoryFailed", shape_47);
    ("BrowseDirectoryRequest", shape_48);
    ("BrowseDirectoryResult", shape_49);
    ("BrowseDirectoryResultResponse", shape_50);
    ("BrowseEnginesRequest", shape_51);
    ("BrowseEnginesResult", shape_52);
    ("BrowseEntityTypeClickedEvent", shape_53);
    ("BrowseEntityTypesRequest", shape_54);
    ("BrowseEntityTypesResult", shape_55);
    ("BrowseEventsRequest", shape_56);
    ("BrowseEventsResult", shape_57);
    ("BrowseExternalNavigateEvent", shape_58);
    ("BrowseFilesResponse", shape_59);
    ("BrowseKbRequest", shape_60);
    ("BrowseKbResult", shape_61);
    ("BrowseLinkClickedEvent", shape_62);
    ("BrowsePanelOpenEvent", shape_63);
    ("BrowsePanelToggleEvent", shape_64);
    ("BrowseProfilesRequest", shape_65);
    ("BrowseProfilesResult", shape_66);
    ("BrowseResourceCloseEvent", shape_67);
    ("BrowseResourceOpenEvent", shape_68);
    ("BrowseResourceReorderEvent", shape_69);
    ("BrowseResourceRequest", shape_70);
    ("BrowseResourceResult", shape_71);
    ("BrowseResourceViewedEvent", shape_72);
    ("BrowseResourcesRequest", shape_73);
    ("BrowseResourcesResult", shape_74);
    ("BrowseRouterPushEvent", shape_75);
    ("BrowseTagSchemasRequest", shape_76);
    ("BrowseTagSchemasResult", shape_77);
    ("BusEmitAccepted", shape_78);
    ("BusEmitRequest", shape_79);
    ("BusEventMessage", shape_80);
    ("BusFrame", shape_81);
    ("BusPingMessage", shape_82);
    ("BusResumeGap", shape_83);
    ("BusStreamMessage", shape_84);
    ("BusSubscribeRequest", shape_85);
    ("CloneResourceWithTokenResponse", shape_86);
    ("CommandError", shape_87);
    ("CommentingJobParams", shape_88);
    ("ContentFormat", shape_89);
    ("ContextualSummaryResponse", shape_90);
    ("CreateAnnotationRequest", shape_91);
    ("CreateResourceResponse", shape_92);
    ("CursorsPath", shape_93);
    ("DirEntry", shape_94);
    ("DirectoryEntry", shape_95);
    ("DiscoveredKB", shape_96);
    ("DiscoveryDocument", shape_97);
    ("DispatcherConfig", shape_98);
    ("DispatcherHealth", shape_99);
    ("DurabilityEvidence", shape_100);
    ("EmbeddingConfig", shape_101);
    ("Engine", shape_102);
    ("EngineEntry", shape_103);
    ("EngineLimits", shape_104);
    ("EnrichedResourceEvent", shape_105);
    ("EntityTagChangedPayload", shape_106);
    ("EntityTypeAddedPayload", shape_107);
    ("EntityTypesProjection", shape_108);
    ("EphemeralEventId", shape_109);
    ("ErrorResponse", shape_110);
    ("EventMetadata", shape_111);
    ("ExtractedText", shape_112);
    ("ExtractionDeclined", shape_113);
    ("ExtractionDeclinedReason", shape_114);
    ("ExtractionMethod", shape_115);
    ("ExtractionOutcome", shape_116);
    ("FailureClass", shape_117);
    ("FileEntry", shape_118);
    ("FragmentSelector", shape_119);
    ("FrameAddEntityTypeCommand", shape_120);
    ("FrameAddTagSchemaCommand", shape_121);
    ("GatewayConfig", shape_122);
    ("GatherAnnotationComplete", shape_123);
    ("GatherAnnotationOptions", shape_124);
    ("GatherAnnotationRequest", shape_125);
    ("GatherFailed", shape_126);
    ("GatherReferencedByRequest", shape_127);
    ("GatherReferencedByResult", shape_128);
    ("GatherResourceComplete", shape_129);
    ("GatherResourceFailed", shape_130);
    ("GatherResourceRequest", shape_131);
    ("GatherResourceRequestOptions", shape_132);
    ("GatherSummaryRequest", shape_133);
    ("GatheredContext", shape_134);
    ("GenerationJobParams", shape_135);
    ("GenerationJobRequest", shape_136);
    ("GetAnnotationHistoryResponse", shape_137);
    ("GetAnnotationResponse", shape_138);
    ("GetAnnotationsResponse", shape_139);
    ("GetEntityTypesResponse", shape_140);
    ("GetEventsResponse", shape_141);
    ("GetReferencedByResponse", shape_142);
    ("GetReferencedByResponseReferencedByItem", shape_143);
    ("GetResourceByTokenResponse", shape_144);
    ("GetResourceResponse", shape_145);
    ("GetTagSchemasResponse", shape_146);
    ("GraphAnnotationNode", shape_147);
    ("GraphConfig", shape_148);
    ("GraphResourceNode", shape_149);
    ("HealthResponse", shape_150);
    ("HighlightingJobParams", shape_151);
    ("HttpEndpoint", shape_152);
    ("InferenceLimits", shape_153);
    ("InferenceLimitsRequest", shape_154);
    ("InferenceLimitsResult", shape_155);
    ("JanusGraphConfig", shape_156);
    ("Job", shape_157);
    ("JobAssignCommand", shape_158);
    ("JobAssignedPayload", shape_159);
    ("JobCancelCommand", shape_160);
    ("JobCancelRequest", shape_161);
    ("JobCancelResult", shape_162);
    ("JobCancelled", shape_163);
    ("JobCheckpointCommand", shape_164);
    ("JobClaimCommand", shape_165);
    ("JobClaimedResult", shape_166);
    ("JobComplete", shape_167);
    ("JobCompleteCommand", shape_168);
    ("JobCompletedPayload", shape_169);
    ("JobCreateCommand", shape_170);
    ("JobCreatedResult", shape_171);
    ("JobCreatedResultResponse", shape_172);
    ("JobDeclined", shape_173);
    ("JobFailCommand", shape_174);
    ("JobFailed", shape_175);
    ("JobFailedPayload", shape_176);
    ("JobFilter", shape_177);
    ("JobId", shape_178);
    ("JobMetadata", shape_179);
    ("JobParams", shape_180);
    ("JobPending", shape_181);
    ("JobProgress", shape_182);
    ("JobProgressAnalyzing", shape_183);
    ("JobProgressAnalyzingTags", shape_184);
    ("JobProgressCompleteCreated", shape_185);
    ("JobProgressCompleteGenerated", shape_186);
    ("JobProgressCreatingAnnotations", shape_187);
    ("JobProgressCreatingResource", shape_188);
    ("JobProgressCreatingTagAnnotations", shape_189);
    ("JobProgressDetectingEntities", shape_190);
    ("JobProgressGeneratingResource", shape_191);
    ("JobProgressLoading", shape_192);
    ("JobProgressMessage", shape_193);
    ("JobQueuedEvent", shape_194);
    ("JobRecord", shape_195);
    ("JobReportProgressCommand", shape_196);
    ("JobResult", shape_197);
    ("JobRunning", shape_198);
    ("JobStartCommand", shape_199);
    ("JobStartedPayload", shape_200);
    ("JobStatusRequest", shape_201);
    ("JobStatusResponse", shape_202);
    ("JobStatusResult", shape_203);
    ("JobStoredProgress", shape_204);
    ("JobStoredResult", shape_205);
    ("JobType", shape_206);
    ("KbDescription", shape_207);
    ("KbEndpoint", shape_208);
    ("KbIdentity", shape_209);
    ("KbRead", shape_210);
    ("KbTarget", shape_211);
    ("KnowledgeBase", shape_212);
    ("KnowledgeGraph", shape_213);
    ("LibrarianConfig", shape_214);
    ("LibrarianEngineConfig", shape_215);
    ("LimitRefusal", shape_216);
    ("LinkingJobParams", shape_217);
    ("ListResourcesResponse", shape_218);
    ("LocalEndpoint", shape_219);
    ("LogFormat", shape_220);
    ("LogLevel", shape_221);
    ("MarkArchiveCommand", shape_222);
    ("MarkCommitCommand", shape_223);
    ("MarkCommitOk", shape_224);
    ("MarkCreateOk", shape_225);
    ("MarkCreateOkResponse", shape_226);
    ("MarkCreateRequest", shape_227);
    ("MarkDelegateTimeoutEvent", shape_228);
    ("MarkDeleteCommand", shape_229);
    ("MarkDeleteOk", shape_230);
    ("MarkJobCompleteCommand", shape_231);
    ("MarkJobCreateCommand", shape_232);
    ("MarkJobDone", shape_233);
    ("MarkJobFilter", shape_234);
    ("MarkJobParams", shape_235);
    ("MarkJobQueuedEvent", shape_236);
    ("MarkJobResult", shape_237);
    ("MarkRequestedEvent", shape_238);
    ("MarkSubmitEvent", shape_239);
    ("MarkUnarchiveCommand", shape_240);
    ("MarkUpdateBodyCommand", shape_241);
    ("MarkUpdateEntityTypesCommand", shape_242);
    ("MatchResourcesRequest", shape_243);
    ("MatchResourcesResponse", shape_244);
    ("MatchResourcesResult", shape_245);
    ("MatchSearchFailed", shape_246);
    ("MatchSearchRequest", shape_247);
    ("MatchSearchResult", shape_248);
    ("MediaTokenRequest", shape_249);
    ("MediaTokenResponse", shape_250);
    ("MemoryGraphConfig", shape_251);
    ("MemoryVectorsConfig", shape_252);
    ("Motivation", shape_253);
    ("Neo4jGraphConfig", shape_254);
    ("NeptuneGraphConfig", shape_255);
    ("NewKnowledgeBase", shape_256);
    ("OcrConfidence", shape_257);
    ("OllamaEmbeddingConfig", shape_258);
    ("OneOrMoreAgents", shape_259);
    ("OneOrMoreStrings", shape_260);
    ("OneOrMoreUris", shape_261);
    ("PdfClass", shape_262);
    ("PdfTextItem", shape_263);
    ("PersistedEventId", shape_264);
    ("PrincipalProfileCommand", shape_265);
    ("PrincipalProfiledPayload", shape_266);
    ("Profile", shape_267);
    ("ProfilesProjection", shape_268);
    ("ProtectedResourceMetadata", shape_269);
    ("QdrantVectorsConfig", shape_270);
    ("ReplyEventId", shape_271);
    ("Representation", shape_272);
    ("RepresentationAddedPayload", shape_273);
    ("RepresentationNotFound", shape_274);
    ("RepresentationRemovedPayload", shape_275);
    ("ResourceAnnotations", shape_276);
    ("ResourceArchivedPayload", shape_277);
    ("ResourceClonedPayload", shape_278);
    ("ResourceCreatedPayload", shape_279);
    ("ResourceDescriptor", shape_280);
    ("ResourceErrorEvent", shape_281);
    ("ResourceId", shape_282);
    ("ResourceMovedPayload", shape_283);
    ("ResourceUnarchivedPayload", shape_284);
    ("ResourceUpdatedPayload", shape_285);
    ("ResourceUpload", shape_286);
    ("ResourceView", shape_287);
    ("ScoredResource", shape_288);
    ("Selector", shape_289);
    ("SemanticMatch", shape_290);
    ("ServiceAddress", shape_291);
    ("ServiceIdentity", shape_292);
    ("SessionJoinedEvent", shape_293);
    ("SessionLeftEvent", shape_294);
    ("SettingsHoverDelayChangedEvent", shape_295);
    ("SettingsLocaleChangedEvent", shape_296);
    ("SettingsThemeChangedEvent", shape_297);
    ("SmeltRebuildAnchorsCommand", shape_298);
    ("SmeltSettled", shape_299);
    ("SmelterConfig", shape_300);
    ("SpecificResource", shape_301);
    ("StatusResponse", shape_302);
    ("StorageUriEntry", shape_303);
    ("StoredEventResponse", shape_304);
    ("SupportedMediaType", shape_305);
    ("SvgSelector", shape_306);
    ("TagCategory", shape_307);
    ("TagSchema", shape_308);
    ("TagSchemaAddedPayload", shape_309);
    ("TagSchemasProjection", shape_310);
    ("TaggingJobParams", shape_311);
    ("TextPositionSelector", shape_312);
    ("TextQuoteSelector", shape_313);
    ("TextualBody", shape_314);
    ("UnitCursor", shape_315);
    ("UpdateAnnotationBodyRequest", shape_316);
    ("UserId", shape_317);
    ("UserResponse", shape_318);
    ("VectorsConfig", shape_319);
    ("VoyageEmbeddingConfig", shape_320);
    ("WeaveApplied", shape_321);
    ("WeaveRebuildCommand", shape_322);
    ("WeaverConfig", shape_323);
    ("WorkerConfig", shape_324);
    ("WorkerEngineConfig", shape_325);
    ("WorkerEngineHealth", shape_326);
    ("WorkerHealth", shape_327);
    ("WorkerKnowledgeBaseConfig", shape_328);
    ("WorkerKnowledgeBaseHealth", shape_329);
    ("YieldCloneCreateCommand", shape_330);
    ("YieldCloneCreated", shape_331);
    ("YieldClonePersistCommand", shape_332);
    ("YieldClonePersistOk", shape_333);
    ("YieldCloneResourceRequest", shape_334);
    ("YieldCloneTokenRequest", shape_335);
    ("YieldCreateCommand", shape_336);
    ("YieldCreateOk", shape_337);
    ("YieldJobCompleteCommand", shape_338);
    ("YieldJobCreateCommand", shape_339);
    ("YieldJobDone", shape_340);
    ("YieldJobFilter", shape_341);
    ("YieldJobQueuedEvent", shape_342);
    ("YieldJobResult", shape_343);
    ("YieldUpdateCommand", shape_344);
    ("YieldUpdateOk", shape_345);
    ("YieldedResource", shape_346);
  ]
