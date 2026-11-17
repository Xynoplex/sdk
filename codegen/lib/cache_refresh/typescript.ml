(* The refresh table as the TypeScript SDK reads it (typescript/core/src):
   the queries and those persisted, what each is asked for per, what each one's
   cache holds at run time and as a type, and each trigger's rows. *)

module T = Typescript_syntax

let path = "typescript/core/src/cache-refresh.ts"
let list = T.strings Inline
let str text = T.T_str (Single, text)
let readonly_array t = T.T_readonly (T_array t)
let inline entries = T.Object { layout = Inline; column = None; entries }

let row (r : Table.row) =
  let field name value = T.entry (Ident name) value in
  let word w = T.Str (Single, w) in
  inline
    (Option.to_list
       (Option.map
          (fun (w : Tables.Client_refresh.when_) ->
            field "when"
              (word
                 (match w with
                 | Enriched -> "enriched"
                 | Unenriched -> "unenriched")))
          r.when_)
    @ [
        field "reach"
          (word (match r.reach with Subject -> "subject" | Held -> "held"));
        field "names"
          (inline
             (List.filter_map
                (fun (slot, w) -> Option.map (fun w -> field slot (list w)) w)
                [ ("resource", r.resource); ("annotation", r.annotation) ]));
      ]
    @ Option.to_list (Option.map (fun w -> field "carries" (list w)) r.carries)
    @ [
        field "refetches" (list r.refetches);
        field "writes" (list r.writes);
        field "removes" (list r.removes);
      ])

(* A list of words, as a constant, beside the type of one of them. *)
let words ~about name type_name values =
  T.Adjacent
    [
      T.const name ~as_const:true ~about:[ Doc about ] (list values);
      T.type_alias type_name
        (T_index (T_paren (T_typeof name), T_name "number"));
    ]

let spelled (per : Tables.Client_refresh.per option) =
  match per with
  | Some Resource -> "resource"
  | Some Annotation -> "annotation"
  | Some Filters -> "filters"
  | None -> "whole"

let per (q : Table.query) = spelled q.per

let pers =
  List.map spelled [ Some Resource; Some Annotation; Some Filters; None ]

let interface ~about name members =
  T.Interface { about = [ Doc about ]; export = true; name; members }

let text (t : Table.t) =
  let names = List.map (fun (q : Table.query) -> q.name) t.queries in
  let each f = List.map f t.queries in
  let readonly = true in
  T.text
    {
      banner =
        Banner.typescript_lines
          ~authority:[ "protocol/specs/src/client/refresh.json" ]
          __FILE__;
      body =
        [
          T.import ~type_only:true [ "components" ] "./types";
          words ~about:"The live queries a client's cache answers."
            "CACHE_QUERIES" "CacheQuery" names;
          words
            ~about:
              "The live queries whose answers a client keeps across its lives, \
               for the person signed in."
            "PERSISTED_QUERIES" "PersistedQuery"
            (List.filter_map
               (fun (q : Table.query) ->
                 if q.persisted then Some q.name else None)
               t.queries);
          T.Adjacent
            [
              T.const "CACHE_PER" ~as_const:true
                ~about:
                  [
                    Doc
                      "What each live query is asked for per: a resource, an \
                       annotation, or the filters it is asked with; `whole` \
                       for one asked for whole, whose one answer is kept under \
                       `wholeKey`.";
                  ]
                ~satisfies:
                  (T_mapped
                     {
                       layout = Inline;
                       readonly = true;
                       key = "Q";
                       in_ = T_name "CacheQuery";
                       value = T_union (List.map str pers);
                     })
                (T.rows
                   (each (fun (q : Table.query) ->
                        T.entry (Quoted (Single, q.name)) (Str (Single, per q)))));
              T.type_alias "CachePer" (T_typeof "CACHE_PER");
            ];
          T.const "CACHE_VALUES" ~as_const:true
            ~about:
              [
                Doc
                  "What each live query's cache holds, its `value`: the \
                   component, and the members within it the value is, \
                   outermost first.";
              ]
            ~satisfies:
              (T_mapped
                 {
                   layout = Inline;
                   readonly = true;
                   key = "Q";
                   in_ = T_name "CacheQuery";
                   value =
                     T_object
                       ( Inline,
                         [
                           T.member ~readonly (Ident "component")
                             (T_keyof
                                (T_index (T_name "components", str "schemas")));
                           T.member ~readonly (Ident "members")
                             (readonly_array (T_name "string"));
                         ] );
                 })
            (T.rows
               (each (fun (q : Table.query) ->
                    T.entry
                      (Quoted (Single, q.name))
                      (inline
                         [
                           T.entry (Ident "component")
                             (Str (Single, q.value.component));
                           T.entry (Ident "members") (list q.value.members);
                         ]))));
          interface
            ~about:
              "The type of what each live query's cache holds: \
               `CACHE_VALUES`'s component, member within member."
            "CacheValues"
            (each (fun (q : Table.query) ->
                 T.member
                   (Quoted (Single, q.name))
                   (List.fold_left
                      (fun t m -> T.T_index (t, str m))
                      (T.schema q.value.component)
                      q.value.members)));
          T.type_alias "CacheRefreshWhen"
            ~about:
              [
                Doc
                  "Which of a split channel's two kinds of event a row is for.";
              ]
            (T_union [ str "enriched"; str "unenriched" ]);
          T.type_alias "CacheRefreshWay"
            ~about:
              [
                Doc
                  "A way to a member of an event: the names of the members it \
                   is within, and its own.";
              ]
            (readonly_array (T_name "string"));
          interface ~about:"What one trigger does to the cache." "CacheRefresh"
            [
              T.member ~readonly ~optional:true (Ident "when")
                (T_name "CacheRefreshWhen");
              T.member ~readonly (Ident "reach")
                ~about:
                  [
                    Doc
                      "`subject`: the keys the event names. `held`: every key \
                       the client holds.";
                  ]
                (T_union [ str "subject"; str "held" ]);
              T.member ~readonly (Ident "names")
                ~about:
                  [
                    Doc
                      "Where in the event the keys a `subject` row reaches \
                       are: the way to the resource it names (a ResourceId), \
                       and to the annotation (an AnnotationId).";
                  ]
                (T_object
                   ( Inline,
                     [
                       T.member ~readonly ~optional:true (Ident "resource")
                         (T_name "CacheRefreshWay");
                       T.member ~readonly ~optional:true (Ident "annotation")
                         (T_name "CacheRefreshWay");
                     ] ));
              T.member ~readonly ~optional:true (Ident "carries")
                ~about:
                  [
                    Doc
                      "The way to the value the row writes (an Annotation). On \
                       a split channel, its presence is what makes an event \
                       enriched.";
                  ]
                (T_name "CacheRefreshWay");
              T.member ~readonly (Ident "refetches")
                ~about:[ Doc "Asked for again, the value shown meanwhile." ]
                (readonly_array (T_name "CacheQuery"));
              T.member ~readonly (Ident "writes")
                ~about:[ Doc "Written with the value the event carries." ]
                (readonly_array (T_name "CacheQuery"));
              T.member ~readonly (Ident "removes")
                ~about:[ Doc "Gone: the key fails as `bus.not-found`." ]
                (readonly_array (T_name "CacheQuery"));
            ];
          T.const "CACHE_REFRESH" ~as_const:true
            ~about:
              [
                Doc
                  "What each trigger does: a channel's events; `reopened`, the \
                   stream open again after a drop; or `unreadable`, an event \
                   on one of these channels that cannot be read.";
              ]
            ~satisfies:
              (T_generic
                 ( "Record",
                   [ T_name "string"; readonly_array (T_name "CacheRefresh") ]
                 ))
            (T.rows
               (List.map
                  (fun (trigger : Table.trigger) ->
                    T.entry ~about:[ Doc trigger.docs ]
                      (Quoted (Single, trigger.on))
                      (T.array Inline (List.map row trigger.rows)))
                  t.triggers));
          T.type_alias "CacheRefreshTrigger"
            (T_keyof (T_typeof "CACHE_REFRESH"));
          words ~about:"The triggers that are channels of the bus."
            "CACHE_REFRESH_CHANNELS" "CacheRefreshChannel"
            (List.filter_map
               (fun (trigger : Table.trigger) ->
                 match trigger.kind with
                 | Channel _ -> Some trigger.on
                 | Reopened | Unreadable -> None)
               t.triggers);
        ];
    }

let file t = { Output.path; text = text t }
