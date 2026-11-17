(* The refresh table as the Python SDK reads it (python/sdk/src/xynolog): the
   queries, the triggers, those that are channels, and each trigger's rows,
   with where in its event a row finds what it names. Which queries a client
   keeps for its person is generate-stored-python.mjs's KEPT_QUERIES. *)

let path = "python/sdk/src/xynolog/refresh.py"

(* A tuple of strings, as Python writes one: [("a",)], never [("a")]. *)
let tuple = function
  | [] -> "()"
  | [ one ] -> "(" ^ Text.quoted one ^ ",)"
  | many -> "(" ^ String.concat ", " (List.map Text.quoted many) ^ ")"

let row (r : Table.row) =
  let said =
    List.concat
      [
        [
          (match r.reach with
          | Subject -> {|reach="subject"|}
          | Held -> {|reach="held"|});
        ];
        List.filter_map
          (fun (field, w) -> Option.map (fun w -> field ^ "=" ^ tuple w) w)
          [
            ("names_resource", r.resource);
            ("names_annotation", r.annotation);
            ("carries", r.carries);
          ];
        List.filter_map
          (fun (field, qs) ->
            if qs = [] then None else Some (field ^ "=" ^ tuple qs))
          [
            ("refetches", r.refetches);
            ("writes", r.writes);
            ("removes", r.removes);
          ];
        (match r.when_ with
        | Some Enriched -> [ {|when="enriched"|} ]
        | Some Unenriched -> [ {|when="unenriched"|} ]
        | None -> []);
      ]
  in
  "CacheRefresh(" ^ String.concat ", " said ^ ")"

let lines names =
  String.concat ""
    (List.map (fun name -> "    " ^ Text.quoted name ^ ",\n") names)

let text (t : Table.t) =
  let channels =
    List.filter_map
      (fun (trigger : Table.trigger) ->
        match trigger.kind with
        | Channel _ -> Some trigger.on
        | Reopened | Unreadable -> None)
      t.triggers
  in
  String.concat ""
    [
      {|# Generated from protocol/specs/src/client/refresh.json; do not edit.
# Regenerate: make generate (codegen/lib/cache_refresh/python.ml)

"""What a Xynolog client asks again for, and when.

A client's live queries answer from a cache. This table says what each event
on the bus, the reopening of a dropped stream, and an event that cannot be
read, does to it: which queries are asked for again, which are written with
what the event carries, and which are gone. And it says where in an event its
row finds the resource and the annotation it names, and the value it carries.
"""

from collections.abc import Mapping
from dataclasses import dataclass
from types import MappingProxyType
from typing import Final, Literal, final

__all__ = [
    "CACHE_QUERIES",
    "CACHE_REFRESH",
    "CACHE_REFRESH_CHANNELS",
    "CacheQuery",
    "CacheRefresh",
    "CacheRefreshChannel",
    "CacheRefreshReach",
    "CacheRefreshTrigger",
    "CacheRefreshWay",
    "CacheRefreshWhen",
]

# The live queries a client's cache answers.
type CacheQuery = Literal[
|};
      String.concat ""
        (List.map
           (fun (q : Table.query) ->
             Printf.sprintf "%s\n    %s,\n"
               (Text.python_comment ~indent:"    " q.docs)
               (Text.quoted q.name))
           t.queries);
      {|]

CACHE_QUERIES: Final[tuple[CacheQuery, ...]] = (
|};
      lines (List.map (fun (q : Table.query) -> q.name) t.queries);
      {|)

# Which of a split channel's two kinds of event a row is for.
type CacheRefreshWhen = Literal["enriched", "unenriched"]

# `subject`: the keys the event names. `held`: every key the client holds.
type CacheRefreshReach = Literal["subject", "held"]

# What each trigger is: a channel whose events are it; `reopened`, the
# stream open again after a drop; or `unreadable`, an event on one of the
# table's channels that cannot be read.
type CacheRefreshTrigger = Literal[
|};
      lines (List.map (fun (trigger : Table.trigger) -> trigger.on) t.triggers);
      {|]

# The triggers that are channels of the bus.
type CacheRefreshChannel = Literal[
|};
      lines channels;
      {|]

CACHE_REFRESH_CHANNELS: Final[tuple[CacheRefreshChannel, ...]] = (
|};
      lines channels;
      {|)

# A way to a member of an event (the frame's payload): the names of the
# members it is within, and its own.
type CacheRefreshWay = tuple[str, ...]


@final
@dataclass(frozen=True, slots=True, kw_only=True)
class CacheRefresh:
    """What one trigger does to the cache."""

    reach: CacheRefreshReach
    names_resource: CacheRefreshWay | None = None
    """The way to the resource a `subject` row reaches (a ResourceId)."""
    names_annotation: CacheRefreshWay | None = None
    """The way to the annotation a `subject` row reaches (an AnnotationId)."""
    carries: CacheRefreshWay | None = None
    """The way to the value the row writes (an Annotation). On a split channel, its presence is what makes an event enriched."""
    refetches: tuple[CacheQuery, ...] = ()
    """Asked for again, the value shown meanwhile."""
    writes: tuple[CacheQuery, ...] = ()
    """Written with the value the event carries."""
    removes: tuple[CacheQuery, ...] = ()
    """Gone: the key fails as `bus.not-found`."""
    when: CacheRefreshWhen | None = None


CACHE_REFRESH: Final[Mapping[CacheRefreshTrigger, tuple[CacheRefresh, ...]]] = MappingProxyType(
    {
|};
      String.concat ""
        (List.map
           (fun (trigger : Table.trigger) ->
             Printf.sprintf "%s\n        %s: (\n%s        ),\n"
               (Text.python_comment ~indent:"        " trigger.docs)
               (Text.quoted trigger.on)
               (String.concat ""
                  (List.map
                     (fun r -> "            " ^ row r ^ ",\n")
                     trigger.rows)))
           t.triggers);
      "    }\n)\n";
    ]

let file t = { Output.path; text = text t }
