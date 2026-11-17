(* The refresh table as the TypeScript SDK reads it (typescript/core/src):
   the queries and those persisted, what each is asked for per, what each one's
   cache holds at run time and as a type, and each trigger's rows. *)

let path = "typescript/core/src/cache-refresh.ts"

let list names =
  "[" ^ String.concat ", " (List.map (fun n -> "'" ^ n ^ "'") names) ^ "]"

let row (r : Table.row) =
  let names =
    List.filter_map
      (fun (slot, w) -> Option.map (fun w -> slot ^ ": " ^ list w) w)
      [ ("resource", r.resource); ("annotation", r.annotation) ]
  in
  String.concat ""
    [
      "{ ";
      (match r.when_ with
      | Some Enriched -> "when: 'enriched', "
      | Some Unenriched -> "when: 'unenriched', "
      | None -> "");
      (match r.reach with
      | Subject -> "reach: 'subject', "
      | Held -> "reach: 'held', ");
      "names: {";
      (match names with [] -> "" | _ -> " " ^ String.concat ", " names ^ " ");
      "}, ";
      Option.fold ~none:""
        ~some:(fun w -> "carries: " ^ list w ^ ", ")
        r.carries;
      "refetches: " ^ list r.refetches;
      ", writes: " ^ list r.writes;
      ", removes: " ^ list r.removes;
      " }";
    ]

let text (t : Table.t) =
  let names = List.map (fun (q : Table.query) -> q.name) t.queries in
  let each f = String.concat "" (List.map f t.queries) in
  String.concat ""
    [
      {|// ⚠ GENERATED FILE — do not edit.
//
// Authority:   protocol/specs/src/client/refresh.json
// Regenerate:  make generate  (codegen/lib/cache_refresh/typescript.ml)

import type { components } from './types';

/** The live queries a client's cache answers. */
export const CACHE_QUERIES = |};
      list names;
      {| as const;
export type CacheQuery = (typeof CACHE_QUERIES)[number];

/** The live queries whose answers a client keeps across its lives, for the person signed in. */
export const PERSISTED_QUERIES = |};
      list
        (List.filter_map
           (fun (q : Table.query) -> if q.persisted then Some q.name else None)
           t.queries);
      {| as const;
export type PersistedQuery = (typeof PERSISTED_QUERIES)[number];

/** What each live query is asked for per: a resource, an annotation, or the filters it is asked with; `whole` for one asked for whole, whose one answer is kept under `wholeKey`. */
export interface CachePer {
|};
      each (fun (q : Table.query) ->
          Printf.sprintf "  '%s': '%s';\n" q.name
            (match q.per with
            | Some Resource -> "resource"
            | Some Annotation -> "annotation"
            | Some Filters -> "filters"
            | None -> "whole"));
      {|}

/** What each live query's cache holds, its `value`: the component, and the members within it the value is, outermost first. */
export const CACHE_VALUES = {
|};
      each (fun (q : Table.query) ->
          Printf.sprintf "  '%s': { component: '%s', members: %s },\n" q.name
            q.value.component (list q.value.members));
      {|} as const satisfies { readonly [Q in CacheQuery]: { readonly component: keyof components['schemas']; readonly members: readonly string[] } };

/** The type of what each live query's cache holds: `CACHE_VALUES`'s component, member within member. */
export interface CacheValues {
|};
      each (fun (q : Table.query) ->
          Printf.sprintf "  '%s': components['schemas']['%s']%s;\n" q.name
            q.value.component
            (String.concat ""
               (List.map (fun m -> "['" ^ m ^ "']") q.value.members)));
      {|}

/** Which of a split channel's two kinds of event a row is for. */
export type CacheRefreshWhen = 'enriched' | 'unenriched';

/** A way to a member of an event: the names of the members it is within, and its own. */
export type CacheRefreshWay = readonly string[];

/** What one trigger does to the cache. */
export interface CacheRefresh {
  readonly when?: CacheRefreshWhen;
  /** `subject`: the keys the event names. `held`: every key the client holds. */
  readonly reach: 'subject' | 'held';
  /** Where in the event the keys a `subject` row reaches are: the way to the resource it names (a ResourceId), and to the annotation (an AnnotationId). */
  readonly names: { readonly resource?: CacheRefreshWay; readonly annotation?: CacheRefreshWay };
  /** The way to the value the row writes (an Annotation). On a split channel, its presence is what makes an event enriched. */
  readonly carries?: CacheRefreshWay;
  /** Asked for again, the value shown meanwhile. */
  readonly refetches: readonly CacheQuery[];
  /** Written with the value the event carries. */
  readonly writes: readonly CacheQuery[];
  /** Gone: the key fails as `bus.not-found`. */
  readonly removes: readonly CacheQuery[];
}

/** What each trigger does: a channel's events; `reopened`, the stream open again after a drop; or `unreadable`, an event on one of these channels that cannot be read. */
export const CACHE_REFRESH = {
|};
      String.concat ""
        (List.map
           (fun (trigger : Table.trigger) ->
             Printf.sprintf "  %s\n  '%s': [%s],\n"
               (Text.doc_comment trigger.docs)
               trigger.on
               (String.concat ", " (List.map row trigger.rows)))
           t.triggers);
      {|} as const satisfies Record<string, readonly CacheRefresh[]>;

export type CacheRefreshTrigger = keyof typeof CACHE_REFRESH;

/** The triggers that are channels of the bus. */
export const CACHE_REFRESH_CHANNELS = |};
      list
        (List.filter_map
           (fun (trigger : Table.trigger) ->
             match trigger.kind with
             | Channel _ -> Some trigger.on
             | Reopened | Unreadable -> None)
           t.triggers);
      {| as const;
export type CacheRefreshChannel = (typeof CACHE_REFRESH_CHANNELS)[number];
|};
    ]

let file t = { Output.path; text = text t }
