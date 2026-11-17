(* The refresh table as the Python SDK reads it (python/sdk/src/xynolog): the
   queries, the triggers, those that are channels, and each trigger's rows,
   with where in its event a row finds what it names. Which queries a client
   keeps for its person is stored.py's KEPT_QUERIES. *)

module P = Python_syntax

let path = "python/sdk/src/xynolog/refresh.py"

let row (r : Table.row) =
  P.call "CacheRefresh"
    (List.concat
       [
         [
           P.keyword "reach"
             (P.Str (match r.reach with Subject -> "subject" | Held -> "held"));
         ];
         List.filter_map
           (fun (name, w) ->
             Option.map (fun w -> P.keyword name (P.strings w)) w)
           [
             ("names_resource", r.resource);
             ("names_annotation", r.annotation);
             ("carries", r.carries);
           ];
         List.filter_map
           (fun (name, qs) ->
             if qs = [] then None else Some (P.keyword name (P.strings qs)))
           [
             ("refetches", r.refetches);
             ("writes", r.writes);
             ("removes", r.removes);
           ];
         (match r.when_ with
         | Some Enriched -> [ P.keyword "when" (P.Str "enriched") ]
         | Some Unenriched -> [ P.keyword "when" (P.Str "unenriched") ]
         | None -> []);
       ])

let literal ?about name values =
  P.alias ?about name
    (P.sub ~magic:true "Literal" (List.map (fun v -> P.item (P.Str v)) values))

let names ~of_ =
  P.sub "Final"
    [ P.item (P.sub "tuple" [ P.item (P.Name of_); P.item P.Ellipsis ]) ]

let optional type_ = P.Binary (type_, P.Or, P.Name "None")
let queries = P.sub "tuple" [ P.item (P.Name "CacheQuery"); P.item P.Ellipsis ]

let text (t : Table.t) =
  let channels =
    List.filter_map
      (fun (trigger : Table.trigger) ->
        match trigger.kind with
        | Channel _ -> Some trigger.on
        | Reopened | Unreadable -> None)
      t.triggers
  in
  let way = P.Name "CacheRefreshWay" in
  P.text
    {
      header =
        Banner.python_lines ~from_:"protocol/specs/src/client/refresh.json"
          __FILE__;
      doc =
        As_is
          "What a Xynolog client asks again for, and when.\n\n\
           A client's live queries answer from a cache. This table says what \
           each event\n\
           on the bus, the reopening of a dropped stream, and an event that \
           cannot be\n\
           read, does to it: which queries are asked for again, which are \
           written with\n\
           what the event carries, and which are gone. And it says where in an \
           event its\n\
           row finds the resource and the annotation it names, and the value \
           it carries.\n";
      imports =
        [
          [
            P.From ("collections.abc", [ "Mapping" ]);
            P.From ("dataclasses", [ "dataclass" ]);
            P.From ("types", [ "MappingProxyType" ]);
            P.From ("typing", [ "Final"; "Literal"; "final" ]);
          ];
        ];
      body =
        [
          P.assign "__all__"
            ~value:
              (P.List
                 (P.items ~magic:true
                    (List.map
                       (fun n -> P.item (P.Str n))
                       [
                         "CACHE_QUERIES";
                         "CACHE_REFRESH";
                         "CACHE_REFRESH_CHANNELS";
                         "CacheQuery";
                         "CacheRefresh";
                         "CacheRefreshChannel";
                         "CacheRefreshReach";
                         "CacheRefreshTrigger";
                         "CacheRefreshWay";
                         "CacheRefreshWhen";
                       ])));
          P.alias
            ~about:[ Line "The live queries a client's cache answers." ]
            "CacheQuery"
            (P.sub ~magic:true "Literal"
               (List.map
                  (fun (q : Table.query) ->
                    P.element ~about:[ Prose q.docs ] (P.Str q.name))
                  t.queries));
          P.assign "CACHE_QUERIES" ~annotation:(names ~of_:"CacheQuery")
            ~value:
              (P.strings ~magic:true
                 (List.map (fun (q : Table.query) -> q.name) t.queries));
          P.alias
            ~about:
              [
                Line
                  "Which of a split channel's two kinds of event a row is for.";
              ]
            "CacheRefreshWhen"
            (P.sub "Literal"
               [ P.item (P.Str "enriched"); P.item (P.Str "unenriched") ]);
          P.alias
            ~about:
              [
                Line
                  "`subject`: the keys the event names. `held`: every key the \
                   client holds.";
              ]
            "CacheRefreshReach"
            (P.sub "Literal"
               [ P.item (P.Str "subject"); P.item (P.Str "held") ]);
          literal
            ~about:
              (P.verbatim
                 "What each trigger is: a channel whose events are it; \
                  `reopened`, the\n\
                  stream open again after a drop; or `unreadable`, an event on \
                  one of the\n\
                  table's channels that cannot be read.")
            "CacheRefreshTrigger"
            (List.map (fun (trigger : Table.trigger) -> trigger.on) t.triggers);
          literal
            ~about:[ Line "The triggers that are channels of the bus." ]
            "CacheRefreshChannel" channels;
          P.assign "CACHE_REFRESH_CHANNELS"
            ~annotation:(names ~of_:"CacheRefreshChannel")
            ~value:(P.strings ~magic:true channels);
          P.alias
            ~about:
              (P.verbatim
                 "A way to a member of an event (the frame's payload): the \
                  names of the\n\
                  members it is within, and its own.")
            "CacheRefreshWay"
            (P.sub "tuple" [ P.item (P.Name "str"); P.item P.Ellipsis ]);
          P.frozen_dataclass "CacheRefresh"
            "What one trigger does to the cache."
            [
              P.field "reach" (P.Name "CacheRefreshReach");
              P.field "names_resource" (optional way) ~default:(P.Name "None")
                ~doc:
                  "The way to the resource a `subject` row reaches (a \
                   ResourceId).";
              P.field "names_annotation" (optional way) ~default:(P.Name "None")
                ~doc:
                  "The way to the annotation a `subject` row reaches (an \
                   AnnotationId).";
              P.field "carries" (optional way) ~default:(P.Name "None")
                ~doc:
                  "The way to the value the row writes (an Annotation). On a \
                   split channel, its presence is what makes an event \
                   enriched.";
              P.field "refetches" queries ~default:(P.tuple [])
                ~doc:"Asked for again, the value shown meanwhile.";
              P.field "writes" queries ~default:(P.tuple [])
                ~doc:"Written with the value the event carries.";
              P.field "removes" queries ~default:(P.tuple [])
                ~doc:"Gone: the key fails as `bus.not-found`.";
              P.field "when"
                (optional (P.Name "CacheRefreshWhen"))
                ~default:(P.Name "None");
            ];
          P.assign "CACHE_REFRESH"
            ~annotation:
              (P.sub "Final"
                 [
                   P.item
                     (P.sub "Mapping"
                        [
                          P.item (P.Name "CacheRefreshTrigger");
                          P.item
                            (P.sub "tuple"
                               [
                                 P.item (P.Name "CacheRefresh");
                                 P.item P.Ellipsis;
                               ]);
                        ]);
                 ])
            ~value:
              (P.call "MappingProxyType"
                 [
                   P.item
                     (P.Dict
                        (P.items ~magic:true
                           (List.map
                              (fun (trigger : Table.trigger) ->
                                P.element ~about:[ Prose trigger.docs ]
                                  ~label:(Key (P.Str trigger.on))
                                  (P.tuple ~magic:true
                                     (List.map
                                        (fun r -> P.item (row r))
                                        trigger.rows)))
                              t.triggers)));
                 ]);
        ];
    }

let file t = { Output.path; text = text t }
