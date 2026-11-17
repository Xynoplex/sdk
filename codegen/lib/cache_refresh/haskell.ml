(* The refresh table as the Haskell SDK reads it: each row's acts and the ways
   to what its event names, with the type of the value each query's cache
   holds (Xynolog.Internal.Generated.CacheRefresh); and the queries as the
   live conformance driver reads one (LiveQueries). *)

let path = "haskell/sdk/generated/Xynolog/Internal/Generated/CacheRefresh.hs"
let live_queries_path = "haskell/sdk/conformance/LiveQueries.hs"
let identifier = String.capitalize_ascii
let list items = "[" ^ String.concat ", " items ^ "]"

let optional f = function
  | None -> "Nothing"
  | Some value -> "(Just " ^ f value ^ ")"

let way parts = list (List.map Text.quoted parts)

let rec haskell_type : Table.value_type -> string = function
  | Component name -> name
  | List t -> "[" ^ haskell_type t ^ "]"
  | Text -> "Text"

let rec models : Table.value_type -> string list = function
  | Component name -> [ name ]
  | List t -> models t
  | Text -> []

let row on (r : Table.row) =
  String.concat " "
    [
      "Row";
      Text.quoted on;
      optional Text.quoted
        (Option.map
           (function
             | Tables.Client_refresh.Enriched -> "enriched"
             | Unenriched -> "unenriched")
           r.when_);
      (match r.reach with Subject -> "Subject" | Held -> "Held");
      "(Ways "
      ^ String.concat " "
          (List.map (optional way) [ r.resource; r.annotation; r.carries ])
      ^ ")";
      list (List.map identifier r.refetches);
      list (List.map identifier r.writes);
      list (List.map identifier r.removes);
    ]

let text (t : Table.t) =
  let names = List.map (fun (q : Table.query) -> q.name) t.queries in
  String.concat ""
    [
      {|-- Generated from protocol/specs/src/client/refresh.json; do not edit.
-- Regenerate: make generate (codegen/lib/cache_refresh/haskell.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.CacheRefresh (Query(..), |};
      String.concat ", " (List.map (fun n -> identifier n ^ "Value") names);
      {|, Reach(..), Ways(..), Row(..), rows, channels, reopened, unreadable) where
import Data.Text (Text)
|};
      String.concat ""
        (List.map
           (fun name ->
             Printf.sprintf "import Xynolog.Internal.Generated.Models.%s (%s)\n"
               name name)
           (List.sort_uniq compare
              (List.concat_map
                 (fun (q : Table.query) -> models q.value.type_)
                 t.queries)));
      "data Query = ";
      String.concat " | " (List.map identifier names);
      {| deriving (Eq, Ord, Show, Enum, Bounded)
-- | The type of the value each live query's cache holds for a key: the table's `value`, a component or a member
-- within one.
|};
      String.concat ""
        (List.map
           (fun (q : Table.query) ->
             Printf.sprintf "type %sValue = %s\n" (identifier q.name)
               (haskell_type q.value.type_))
           t.queries);
      {|data Reach = Subject | Held deriving (Eq, Show)
-- | Where in its event a row finds the resource it names, the annotation it names, and the value it carries.
data Ways = Ways (Maybe [Text]) (Maybe [Text]) (Maybe [Text]) deriving (Eq, Show)
data Row = Row Text (Maybe Text) Reach Ways [Query] [Query] [Query] deriving (Eq, Show)
rows :: [Row]
rows = |};
      list
        (List.concat_map
           (fun (trigger : Table.trigger) ->
             List.map (row trigger.on) trigger.rows)
           t.triggers);
      {|
-- | The triggers that are channels of the bus.
channels :: [Text]
channels = |};
      list
        (List.filter_map
           (fun (trigger : Table.trigger) ->
             match trigger.kind with
             | Channel _ -> Some (Text.quoted trigger.on)
             | Reopened | Unreadable -> None)
           t.triggers);
      Printf.sprintf
        {|
reopened, unreadable :: Text
reopened = %s
unreadable = %s
|}
        (Text.quoted Table.reopened)
        (Text.quoted Table.unreadable);
    ]

let live_queries (t : Table.t) =
  let names = List.map (fun (q : Table.query) -> q.name) t.queries in
  String.concat ""
    [
      {|-- Generated from protocol/specs/src/client/refresh.json; do not edit.
-- Regenerate: make generate (codegen/lib/cache_refresh/haskell.ml)
{-# LANGUAGE OverloadedStrings #-}
module LiveQueries (LiveQuery(..)) where
import Data.Aeson (FromJSON(..), withText)
data LiveQuery = |};
      String.concat " | " (List.map identifier names);
      {| deriving (Eq, Show)
instance FromJSON LiveQuery where
  parseJSON = withText "LiveQuery" $ \value -> case value of
|};
      String.concat ""
        (List.map
           (fun name ->
             Printf.sprintf "    %s -> pure %s\n" (Text.quoted name)
               (identifier name))
           names);
      {|    _ -> fail "unknown live query"
|};
    ]

let files t =
  [
    { Output.path; text = text t };
    { Output.path = live_queries_path; text = live_queries t };
  ]
