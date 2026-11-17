(* The refresh table as the Go SDK reads it (go/refresh_gen.go): the queries,
   the type of the value each one's cache holds as a type of package api, the
   triggers, how each channel of them reads a frame (by its typed value in
   package bus), the interface the client's refresher implements, a method per
   query a row acts on each way, and how the client keeps the queries the table
   persists. A query a row comes to act on, or one the table comes to persist,
   is a method or a cache the client lacks, so Go does not compile until it is
   answered. *)

let path = "go/refresh_gen.go"
let name = Bus.Go.name
let query_const name' = "CacheQuery" ^ name name'
let trigger_const on = "CacheRefresh" ^ name on

let queries names =
  "[]CacheQuery{" ^ String.concat ", " (List.map query_const names) ^ "}"

let rec go_type : Table.value_type -> string = function
  | Component name -> "api." ^ name
  | List t -> "[]" ^ go_type t
  | Text -> "string"

let way parts =
  "CacheRefreshWay{" ^ String.concat ", " (List.map Text.quoted parts) ^ "}"

let row (r : Table.row) =
  let said =
    List.concat
      [
        (match r.when_ with
        | Some Enriched -> [ "When: CacheRefreshWhenEnriched" ]
        | Some Unenriched -> [ "When: CacheRefreshWhenUnenriched" ]
        | None -> []);
        [
          (match r.reach with
          | Subject -> "Reach: CacheRefreshReachSubject"
          | Held -> "Reach: CacheRefreshReachHeld");
        ];
        (match
           List.filter_map
             (fun (field, w) -> Option.map (fun w -> field ^ ": " ^ way w) w)
             [ ("Resource", r.resource); ("Annotation", r.annotation) ]
         with
        | [] -> []
        | names ->
            [ "Names: CacheRefreshNames{" ^ String.concat ", " names ^ "}" ]);
        Option.to_list (Option.map (fun w -> "Carries: " ^ way w) r.carries);
        List.filter_map
          (fun (field, qs) ->
            if qs = [] then None else Some (field ^ ": " ^ queries qs))
          [
            ("Refetches", r.refetches);
            ("Writes", r.writes);
            ("Removes", r.removes);
          ];
      ]
  in
  "{" ^ String.concat ", " said ^ "}"

(* The queries some row acts on: by [act], in the table's order. *)
let acted (t : Table.t) act =
  List.filter_map
    (fun (q : Table.query) ->
      if
        List.exists
          (fun (trigger : Table.trigger) ->
            List.exists (fun r -> List.mem q.name (act r)) trigger.rows)
          t.triggers
      then Some q.name
      else None)
    t.queries

let refetched t = acted t (fun (r : Table.row) -> r.refetches)
let written t = acted t (fun (r : Table.row) -> r.writes)
let removed t = acted t (fun (r : Table.row) -> r.removes)

let cases verb ~reach names =
  String.concat ""
    (List.map
       (fun q ->
         Printf.sprintf "\t\tcase %s:\n\t\t\tacts.%s%s(%ssubject)\n"
           (query_const q) verb (name q)
           (if reach then "row.Reach, " else ""))
       names)

let text (t : Table.t) =
  let channels =
    List.filter_map
      (fun (trigger : Table.trigger) ->
        match trigger.kind with
        | Channel { scoped } -> Some (trigger.on, scoped)
        | Reopened | Unreadable -> None)
      t.triggers
  in
  let persisted =
    List.filter_map
      (fun (q : Table.query) -> if q.persisted then Some q.name else None)
      t.queries
  in
  String.concat ""
    [
      {|// Code generated from protocol/specs/src/client/refresh.json; DO NOT EDIT.
//
// Regenerate: make generate (codegen/lib/cache_refresh/go.ml)

package xynolog

import (
	"github.com/xynolog/sdk/go/api"
	"github.com/xynolog/sdk/go/bus"
)

// CacheQuery is a live query a client's cache answers.
type CacheQuery string

// The live queries a client's cache answers.
const (
|};
      String.concat "\n\n"
        (List.map
           (fun (q : Table.query) ->
             Printf.sprintf "%s\n\t%s CacheQuery = %s"
               (Text.go_comment ~indent:"\t" q.docs)
               (query_const q.name) (Text.quoted q.name))
           t.queries);
      {|
)

// CacheQueries is every live query, in the table's order.
var CacheQueries = |};
      queries (List.map (fun (q : Table.query) -> q.name) t.queries);
      {|

// PersistedCacheQueries is every live query a client keeps in its storage,
// in the table's order: each under its name (CacheKey).
var PersistedCacheQueries = |};
      queries persisted;
      {|

// The type of the value each live query's cache holds for a key: the table's
// `value`, a component or a member within one.
type (
|};
      Bus.Go.aligned
        (List.map
           (fun (q : Table.query) ->
             (q.name ^ "Value", "= " ^ go_type q.value.type_))
           t.queries);
      {|
)

// CacheRefreshTrigger is what refreshes a client's cache: a channel of the
// bus, the stream open again after a drop, or an event on one of the table's
// channels that cannot be read.
type CacheRefreshTrigger string

// The triggers of the table.
const (
|};
      Bus.Go.aligned
        (List.map
           (fun (trigger : Table.trigger) ->
             ( trigger_const trigger.on,
               "CacheRefreshTrigger = " ^ Text.quoted trigger.on ))
           t.triggers);
      {|
)

// CacheRefreshChannels is each trigger of the table that is a channel of the
// bus, in the table's order.
var CacheRefreshChannels = []CacheRefreshTrigger{|};
      String.concat ", " (List.map (fun (on, _) -> trigger_const on) channels);
      {|}

// CacheRefreshReach is which keys a row acts on: those the event names
// (subject), or every key the client holds (held).
type CacheRefreshReach string

// The reaches of a row.
const (
	CacheRefreshReachSubject CacheRefreshReach = "subject"
	CacheRefreshReachHeld    CacheRefreshReach = "held"
)

// CacheRefreshWhen splits a channel whose events come two ways: enriched
// with the annotation's new value, or unenriched without. A row of a channel
// whose events come one way states none ("").
type CacheRefreshWhen string

// The two ways a split channel's events come.
const (
	CacheRefreshWhenEnriched   CacheRefreshWhen = "enriched"
	CacheRefreshWhenUnenriched CacheRefreshWhen = "unenriched"
)

// CacheRefreshWay is a way to a member of an event: the names of the members
// it is within, and its own. Nil where a row states none.
type CacheRefreshWay []string

// CacheRefreshNames is where in its event a row that reaches its subject
// finds it: the way to the resource it names (a ResourceId), and to the
// annotation (an AnnotationId).
type CacheRefreshNames struct {
	Resource   CacheRefreshWay
	Annotation CacheRefreshWay
}

// CacheRefresh is one row of the table: where its event names what it
// reaches; the way to the value it writes (an Annotation); the queries a
// trigger asks again for, keeping the value shown meanwhile; those whose new
// value its event carries; and those whose entity its event says is gone.
type CacheRefresh struct {
	When      CacheRefreshWhen
	Reach     CacheRefreshReach
	Names     CacheRefreshNames
	Carries   CacheRefreshWay
	Refetches []CacheQuery
	Writes    []CacheQuery
	Removes   []CacheQuery
}

// CacheRefreshTable is each trigger's rows.
var CacheRefreshTable = map[CacheRefreshTrigger][]CacheRefresh{
|};
      String.concat "\n"
        (List.map
           (fun (trigger : Table.trigger) ->
             Printf.sprintf "%s\n\t%s: {\n%s\t},\n"
               (Text.go_comment ~indent:"\t" trigger.docs)
               (trigger_const trigger.on)
               (String.concat ""
                  (List.map (fun r -> "\t\t" ^ row r ^ ",\n") trigger.rows)))
           t.triggers);
      {|}

// cacheRefreshReadings is how each channel of the table reads a frame:
// whether its payload is one of the channel's.
var cacheRefreshReadings = map[CacheRefreshTrigger]func(Frame) bool{
|};
      Bus.Go.aligned
        (List.map
           (fun (on, scoped) ->
             ( trigger_const on ^ ":",
               Printf.sprintf "%s(bus.%s),"
                 (if scoped then "scopedReadingOf" else "readingOf")
                 (name on) ))
           channels);
      {|
}

// cacheActs is what the client's refresher does to each live query a row acts
// on. A query a row comes to act on is a method it lacks.
type cacheActs interface {
|};
      String.concat ""
        (List.concat
           [
             List.map
               (fun q ->
                 Printf.sprintf
                   "\trefetch%s(reach CacheRefreshReach, subject cacheSubject)\n"
                   (name q))
               (refetched t);
             List.map
               (fun q ->
                 Printf.sprintf "\twrite%s(subject cacheSubject)\n" (name q))
               (written t);
             List.map
               (fun q ->
                 Printf.sprintf "\tremove%s(subject cacheSubject)\n" (name q))
               (removed t);
           ]);
      {|}

// applyRefresh applies row to what subject names, by acts: its writes, its
// removes, then its refetches.
func applyRefresh(acts cacheActs, row CacheRefresh, subject cacheSubject) {
	for _, query := range row.Writes {
		switch query {
|};
      cases "write" ~reach:false (written t);
      {|		}
	}
	for _, query := range row.Removes {
		switch query {
|};
      cases "remove" ~reach:false (removed t);
      {|		}
	}
	for _, query := range row.Refetches {
		switch query {
|};
      cases "refetch" ~reach:true (refetched t);
      {|		}
	}
}

// attach has the caches of the queries the table persists keep their values
// in persistence from now on, each beginning with what it kept.
func (v *live) attach(persistence *CachePersistence) {
|};
      String.concat ""
        (List.map
           (fun q ->
             Printf.sprintf "\tkeepIn(v.%s, persistence, %s, v.links.timing)\n"
               q (query_const q))
           persisted);
      "}\n";
    ]

let file t = { Output.path; text = text t }
