(* The refresh table as the Kotlin SDK's cache reads it (xynolog.cache): the
   live queries; those a client with a storage keeps, each with what its
   entries' keys are (its per) and its values (its value, typed as the Kotlin
   types type it), and the caches a client keeps them in, each by its query's
   name; the triggers, each one's rows; and the triggers that are channels,
   each with its channel's reading. The rows' types are hand-written
   (kotlin/sdk/src/main/kotlin/xynolog/cache/Refresh.kt). *)

module K = Kotlin_syntax
module Names = Kotlin_sdk.Names
module Types = Kotlin_sdk.Types

let query name = K.Member (K.Name "CacheQuery", Names.variant_of name)
let trigger on = K.Member (K.Name "CacheRefreshTrigger", Names.variant_of on)
let list items = K.call (K.Name "listOf") items
let wire_param = K.param ~about:(K.Doc "The query as the table names it.") ~binding:(K.Bound { visibility = K.Default; mutable_ = false }) "wire" (K.Type "String")

(* A query a client with a storage keeps: its key's type and the serializer
   that reads a key, and its value's type. *)
type kept = { kept : Table.query; key : K.type_; keyed : K.expr; value : K.type_ }

let kept ~(types : Types.spec) (q : Table.query) =
  let key, keyed =
    match q.per with
    (* A query per nothing keeps its one entry under the whole key, and reads
       that key as nothing else. *)
    | None -> (K.Type "String", K.Name "WholeKeySerializer")
    | Some Resource -> (K.Type "ResourceId", K.call (K.Name "ResourceId.serializer") [])
    | Some Annotation -> (K.Type "AnnotationId", K.call (K.Name "AnnotationId.serializer") [])
    | Some Filters ->
        Names.refuse "%s is persisted, and kept per filters: a persisted query is kept per a resource, an annotation or nothing"
          q.name
  in
  let member =
    match q.value.members with
    | [] -> None
    | [ member ] -> Some member
    | members ->
        Names.refuse "%s is persisted, and its value %s names no one member of %s" q.name
          (String.concat "." members) q.value.component
  in
  { kept = q; key; keyed; value = Types.value_type_of types ~component:q.value.component ~member }

let row (r : Table.row) =
  let way = function None -> K.Null | Some parts -> list (List.map (fun p -> K.Str p) parts) in
  let queries names = list (List.map query names) in
  K.call (K.Name "CacheRefresh")
    [
      K.Member (K.Name "CacheRefreshReach", (match r.reach with Subject -> "Subject" | Held -> "Held"));
      K.call (K.Name "CacheRefreshNames") [ way r.resource; way r.annotation ];
      way r.carries;
      queries r.refetches;
      queries r.writes;
      queries r.removes;
      (match r.when_ with
      | None -> K.Null
      | Some Enriched -> K.Name "CacheRefreshWhen.Enriched"
      | Some Unenriched -> K.Name "CacheRefreshWhen.Unenriched");
    ]

let file ~(types : Types.spec) (t : Table.t) =
  let kept = List.map (kept ~types) (List.filter (fun (q : Table.query) -> q.persisted) t.queries) in
  let channels = List.filter (fun (tr : Table.trigger) -> match tr.kind with Channel _ -> true | Reopened | Unreadable -> false) t.triggers in
  let imports =
    [ "xynolog.registry.KeptQuery" ]
    @ (if kept = [] then [] else [ "kotlinx.serialization.serializer" ])
    @ (if channels = [] then [] else [ "xynolog.bus.decoded"; "xynolog.channels.Channels" ])
    @ List.concat_map
        (fun k ->
          (match k.kept.per with None -> [ "xynolog.registry.WholeKeySerializer" ] | Some _ -> [])
          @ Types.imports_of types k.key @ Types.imports_of types k.value)
        kept
  in
  Kotlin_sdk.table ~from_:Table.file __FILE__ ~package:"xynolog.cache" ~name:"CacheRefresh"
    ~imports:(List.sort_uniq String.compare imports)
    [
      K.class_ ~about:(K.Doc "The live queries a client's cache answers.") ~visibility:K.Internal
        ~constructor:(K.constructor [ wire_param ])
        ~entries:
          (List.map
             (fun (q : Table.query) -> K.entry ~about:(K.Block q.docs) ~args:[ K.Str q.name ] (Names.variant_of q.name))
             t.queries)
        K.Enum_class "CacheQuery";
      K.class_
        ~about:
          (K.Doc
             "The caches a client keeps the queries it keeps in, each by its query's name, holding for each key what \
              the query's `value` says.")
        ~visibility:K.Internal
        ~members:
          (List.map
             (fun k -> K.property ~about:(K.Block k.kept.docs) ~type_:(K.Generic ("Cache", [ k.key; k.value ])) k.kept.name)
             kept)
        K.Interface "KeptCaches";
      K.property
        ~about:
          (K.Doc
             "The queries whose answers a client with a storage keeps, in the table's order: each with what its \
              entries' keys and values are, and its cache.")
        ~visibility:K.Internal
        ~type_:(K.Generic ("List", [ K.Generic ("KeptQuery", [ K.Star; K.Star ]) ]))
        ~value:
          (K.Same_line
             (K.call ~layout:K.Lines (K.Name "listOf")
                (List.map
                   (fun k ->
                     K.call (K.Name "KeptQuery")
                       [
                         query k.kept.name;
                         k.keyed;
                         K.call ~types:[ k.value ] (K.Name "serializer") [];
                         K.Reference ("KeptCaches", k.kept.name);
                       ])
                   kept)))
        "PERSISTED_QUERIES";
      K.class_
        ~about:
          (K.Doc
             "What each trigger is: a channel whose events are it; `reopened`, the stream open again after a drop; or \
              `unreadable`, an event on one of the table's channels that cannot be read.")
        ~visibility:K.Internal
        ~constructor:(K.constructor [ { wire_param with about = Some (K.Doc "The trigger as the table names it.") } ])
        ~entries:(List.map (fun (tr : Table.trigger) -> K.entry ~args:[ K.Str tr.on ] (Names.variant_of tr.on)) t.triggers)
        K.Enum_class "CacheRefreshTrigger";
      K.property ~about:(K.Doc "Each trigger's rows: one, or one for each kind of event of a split channel.")
        ~visibility:K.Internal
        ~type_:(K.Generic ("Map", [ K.Type "CacheRefreshTrigger"; K.Generic ("List", [ K.Type "CacheRefresh" ]) ]))
        ~value:
          (K.Same_line
             (K.call ~layout:K.Lines (K.Name "mapOf")
                (List.map
                   (fun (tr : Table.trigger) ->
                     K.Binary (trigger tr.on, K.To, K.call ~layout:K.Lines (K.Name "listOf") (List.map row tr.rows)))
                   t.triggers)))
        "CACHE_REFRESH";
      K.property ~about:(K.Doc "The triggers that are channels of the bus, by the channel's name, in the table's order.")
        ~visibility:K.Internal
        ~type_:(K.Generic ("Map", [ K.Type "String"; K.Type "CacheRefreshChannel" ]))
        ~value:
          (K.Same_line
             (K.call ~layout:K.Lines (K.Name "mapOf")
                (List.map
                   (fun (tr : Table.trigger) ->
                     K.Binary
                       ( K.Str tr.on,
                         K.To,
                         K.call
                           ~lambda:
                             (K.Lambda
                                ([], K.call (K.Name "decoded") [ K.Name ("Channels." ^ Names.constant_name tr.on); K.Name "it" ]))
                           (K.Name "CacheRefreshChannel") [ trigger tr.on ] ))
                   channels)))
        "CACHE_REFRESH_CHANNELS";
    ]
