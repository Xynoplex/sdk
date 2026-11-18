(* The refresh table as the Haskell SDK reads it: each row's acts and the ways
   to what its event names, with the type of the value each query's cache
   holds (Xynolog.Internal.Generated.CacheRefresh); and the queries as the
   live conformance driver reads one (LiveQueries). *)

module H = Haskell_syntax

let path = "haskell/sdk/generated/Xynolog/Internal/Generated/CacheRefresh.hs"
let live_queries_path = "haskell/sdk/conformance/LiveQueries.hs"
let identifier = String.capitalize_ascii

let banner =
  Banner.lines ~from_:("protocol/specs/src/" ^ Table.file) __FILE__

let queries (t : Table.t) = List.map (fun (q : Table.query) -> q.name) t.queries
let names = List.map (fun n -> H.Name (identifier n))

let optional f = function
  | None -> H.Name "Nothing"
  | Some value -> Apply (Name "Just", [ f value ])

let way parts = H.List (List.map (fun p -> H.Str p) parts)

let rec haskell_type : Table.value_type -> H.type_ = function
  | Component name -> T_name name
  | List t -> T_list (haskell_type t)
  | Text -> T_name "Text"

let rec models : Table.value_type -> string list = function
  | Component name -> [ name ]
  | List t -> models t
  | Text -> []

let row on (r : Table.row) =
  H.Apply
    ( Name "Row",
      [
        Str on;
        optional
          (fun w -> H.Str w)
          (Option.map
             (function
               | Tables.Client_refresh.Enriched -> "enriched"
               | Unenriched -> "unenriched")
             r.when_);
        Name (match r.reach with Subject -> "Subject" | Held -> "Held");
        Apply
          ( Name "Ways",
            List.map (optional way) [ r.resource; r.annotation; r.carries ] );
        List (names r.refetches);
        List (names r.writes);
        List (names r.removes);
      ] )

let text (t : Table.t) =
  let text_ = H.T_name "Text" and words = H.T_list (T_name "Text") in
  let deriving = [ "Eq"; "Show" ] in
  H.text
    {
      banner;
      extensions = [ "OverloadedStrings" ];
      name = "Xynolog.Internal.Generated.CacheRefresh";
      imports =
        H.import "Data.Text" ~items:[ Plain "Text" ]
        :: List.map
             (fun name ->
               H.import
                 ("Xynolog.Internal.Generated.Models." ^ name)
                 ~items:[ Plain name ])
             (List.sort_uniq compare
                (List.concat_map
                   (fun (q : Table.query) -> models q.value.type_)
                   t.queries));
      body =
        H.data "Query"
          (List.map (fun n -> H.constructor (identifier n)) (queries t))
          ~deriving:[ "Eq"; "Ord"; "Show"; "Enum"; "Bounded" ]
        :: List.mapi
             (fun i (q : Table.query) ->
               H.alias
                 ~about:
                   (if i = 0 then
                      [
                        "The type of the value each live query's cache holds \
                         for a key: the table's `value`, a component or a \
                         member";
                        "within one.";
                      ]
                    else [])
                 (identifier q.name ^ "Value")
                 (haskell_type q.value.type_))
             t.queries
        @ [
            H.data "Reach"
              [ H.constructor "Subject"; H.constructor "Held" ]
              ~deriving;
            H.data "Ways"
              ~about:
                [
                  "Where in its event a row finds the resource it names, the \
                   annotation it names, and the value it carries.";
                ]
              [
                H.constructor "Ways"
                  ~fields:
                    (List.init 3 (fun _ -> H.T_apply ("Maybe", [ words ])));
              ]
              ~deriving;
            H.data "Row"
              [
                H.constructor "Row"
                  ~fields:
                    [
                      text_;
                      T_apply ("Maybe", [ text_ ]);
                      T_name "Reach";
                      T_name "Ways";
                      T_list (T_name "Query");
                      T_list (T_name "Query");
                      T_list (T_name "Query");
                    ];
              ]
              ~deriving;
            H.value "rows" (T_list (T_name "Row"))
              (List
                 (List.concat_map
                    (fun (trigger : Table.trigger) ->
                      List.map (row trigger.on) trigger.rows)
                    t.triggers));
            H.value "channels" words
              ~about:[ "The triggers that are channels of the bus." ]
              (List
                 (List.filter_map
                    (fun (trigger : Table.trigger) ->
                      match trigger.kind with
                      | Channel _ -> Some (H.Str trigger.on)
                      | Reopened | Unreadable -> None)
                    t.triggers));
            Values
              {
                about = [];
                type_ = text_;
                values =
                  [
                    ("reopened", Str Table.reopened);
                    ("unreadable", Str Table.unreadable);
                  ];
              };
          ];
    }

let live_queries (t : Table.t) =
  H.text
    {
      banner;
      extensions = [ "OverloadedStrings" ];
      name = "LiveQueries";
      imports =
        [ H.import "Data.Aeson" ~items:[ All "FromJSON"; Plain "withText" ] ];
      body =
        [
          H.data "LiveQuery"
            (List.map (fun n -> H.constructor (identifier n)) (queries t))
            ~deriving:[ "Eq"; "Show" ];
          H.instance "FromJSON" (T_name "LiveQuery")
            [
              H.method_ "parseJSON"
                (Dollar
                   ( Apply (Name "withText", [ Str "LiveQuery" ]),
                     Lambda
                       ( "value",
                         Case
                           ( Name "value",
                             List.map
                               (fun n ->
                                 ( H.Literal n,
                                   H.Apply (Name "pure", [ Name (identifier n) ])
                                 ))
                               (queries t)
                             @ [
                                 ( Otherwise,
                                   Apply
                                     (Name "fail", [ Str "unknown live query" ])
                                 );
                               ] ) ) ));
            ];
        ];
    }

let files t =
  [
    { Output.path; text = text t };
    { Output.path = live_queries_path; text = live_queries t };
  ]
