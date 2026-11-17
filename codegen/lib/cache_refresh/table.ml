(* The refresh table (protocol/specs/src/client/refresh.json) as every SDK
   writes it: its queries, what each one's cache holds, and what each trigger
   does to them, held to the registry, the gateway's API, how each trigger is
   delivered and the shape of each channel's events. *)

module T = Tables.Client_refresh
module Shape = Required.Shape

let file = "client/refresh.json"

(* What a query's cache holds, as each language names its type. *)
type value_type = Component of string | List of value_type | Text

type value = {
  component : string;
  members : string list; (* Within the component, outermost first. *)
  type_ : value_type;
}

type query = {
  name : string;
  docs : string;
  per : T.per option;
  persisted : bool;
  value : value;
}

type way = string list (* The names of the members it is within, and its own. *)

type row = {
  when_ : T.when_ option;
  reach : T.reach;
  resource : way option;
  annotation : way option;
  carries : way option;
  refetches : string list;
  writes : string list;
  removes : string list;
}

type kind = Reopened | Unreadable | Channel of { scoped : bool }

type trigger = {
  on : string;
  kind : kind;
  docs : string; (* A split trigger's rows' docs, each behind its split. *)
  rows : row list;
}

type t = { queries : query list; triggers : trigger list }

(* A channel of the registry as the table reads its events. *)
type channel = {
  event : Shape.shape;
  payload : string option;
      (* A recorded event's payload component, which its envelope leaves
         open. *)
  enriched : bool;
  system : bool; (* Its events are the knowledge base's, of no resource. *)
  scoped : bool; (* A resource's scope carries it. *)
  passing : bool; (* Nothing replays a frame of it that a client missed. *)
}

type context = {
  requests : string list; (* The registry's operations' requests. *)
  reads : string list; (* Each GET of the gateway's API: "GET /template". *)
  channels : (string * channel) list;
  shapes : (string * Shape.shape) list;
  components : (string * string * Schema.t) list;
      (* Each component's name, its file and its schema. *)
}

let reopened = "reopened"
let unreadable = "unreadable"

(* The gateway writes it itself, on the stream whose subscription it is
   about: it cannot be missed, though nothing replays it. *)
let resume_gap = "bus:resume-gap"
let all p text = String.for_all p text
let letter = function 'a' .. 'z' | 'A' .. 'Z' -> true | _ -> false

let query_name name =
  name <> ""
  && (match name.[0] with 'a' .. 'z' -> true | _ -> false)
  && all letter name

let way_part part =
  part <> ""
  && (match part.[0] with 'a' .. 'z' | 'A' .. 'Z' | '_' -> true | _ -> false)
  && all (function '0' .. '9' | '_' -> true | c -> letter c) part

(* A fragment naming members one within another: "/properties/a/properties/b"
   is [a; b]. *)
let members_of fragment =
  let rec go = function
    | [] -> Some []
    | "properties" :: name :: rest
      when name <> ""
           && all (function '0' .. '9' -> true | c -> letter c) name ->
        Option.map (fun names -> name :: names) (go rest)
    | _ -> None
  in
  match String.split_on_char '/' fragment with
  | [ "" ] -> Some []
  | "" :: parts -> go parts
  | _ -> None

let rec member_of shapes (shape : Shape.shape) name =
  match shape with
  | Ref ref_ ->
      Option.bind (List.assoc_opt ref_ shapes) (fun shape ->
          member_of shapes shape name)
  | Shape body -> (
      match List.assoc_opt name body.members with
      | Some member -> Some member
      | None ->
          List.find_map (fun part -> member_of shapes part name) body.all_of)

let derive context (table : T.t) =
  let refusals = ref [] in
  let refuse pointer message =
    refusals := { Decode.file; pointer; message } :: !refusals
  in
  let component_at (reference : Decode.reference) =
    let target, fragment = Decode.resolve reference in
    if fragment <> "" then None
    else
      List.find_map
        (fun (name, file, schema) ->
          if file = target then Some (name, schema) else None)
        context.components
  in
  let rec type_of : Schema.t -> value_type option = function
    | Schema { ref_ = Some reference; _ } ->
        Option.map (fun (name, _) -> Component name) (component_at reference)
    | Schema { type_ = Some [ Array ]; items = Some items; _ } ->
        Option.map (fun t -> List t) (type_of items)
    | Schema { type_ = Some [ String ]; _ } -> Some Text
    | _ -> None
  in
  let value ~persisted (reference : Decode.reference) =
    let refuse message =
      refuse reference.pointer
        (Printf.sprintf "names %s, %s" reference.target message)
    in
    let file, fragment = Decode.resolve reference in
    match
      List.find_opt
        (fun (_, component, _) -> component = file)
        context.components
    with
    | None ->
        refuse "which is no component";
        None
    | Some (component, _, schema) -> (
        match members_of fragment with
        | None ->
            refuse
              "which is neither a component nor a member within one, named \
               member by member (#/properties/...)";
            None
        | Some [] ->
            Some { component; members = []; type_ = Component component }
        | Some members ->
            let rec walk holder (schema : Schema.t) = function
              | [] -> None
              | member :: rest -> (
                  let body =
                    match schema with
                    | Schema body -> Some body
                    | Boolean_schema _ -> None
                  in
                  let properties =
                    Option.bind body (fun (body : Schema.schema) ->
                        body.properties)
                  in
                  match Option.bind properties (List.assoc_opt member) with
                  | None ->
                      refuse
                        (Printf.sprintf "and %s has no member %s" holder member);
                      None
                  | Some inner -> (
                      let required =
                        Option.bind body (fun (body : Schema.schema) ->
                            body.required)
                      in
                      if persisted && required <> Some [ member ] then
                        refuse
                          (Printf.sprintf
                             "and %s requires %s: a persisted query's value is \
                              a member only where it is all its holder \
                              requires"
                             holder
                             (match required with
                             | None | Some [] -> "nothing"
                             | Some names -> String.concat ", " names));
                      match rest with
                      | [] -> (
                          match type_of inner with
                          | Some t -> Some t
                          | None ->
                              refuse
                                "which is of no type the writers write: a \
                                 component, a list of one, or text";
                              None)
                      | _ ->
                          let holder, schema =
                            match inner with
                            | Schema { ref_ = Some r; _ } -> (
                                match component_at r with
                                | Some (name, schema) -> (name, schema)
                                | None -> (holder ^ "." ^ member, inner))
                            | _ -> (holder ^ "." ^ member, inner)
                          in
                          walk holder schema rest))
            in
            Option.map
              (fun type_ -> { component; members; type_ })
              (walk component schema members))
  in
  let seen = Hashtbl.create 16 in
  let queries =
    List.filter_map
      (fun (i, (q : T.query)) ->
        let at = Printf.sprintf "/queries/%d" i in
        if not (query_name q.name) then
          refuse (at ^ "/name")
            (Printf.sprintf
               "is %s, which is not a query's name: a lower-case letter, then \
                letters"
               (Text.quoted q.name));
        (match Hashtbl.find_opt seen q.name with
        | Some j ->
            refuse (at ^ "/name")
              (Printf.sprintf "is %s, which /queries/%d states already" q.name j)
        | None -> Hashtbl.replace seen q.name i);
        (match q.source with
        | Asks request ->
            if not (List.mem request context.requests) then
              refuse (at ^ "/asks")
                (Printf.sprintf "is %s, which is no operation of the registry"
                   (Text.quoted request))
        | Reads route ->
            if not (List.mem route context.reads) then
              refuse (at ^ "/reads")
                (Printf.sprintf "is %s, which is no GET of the gateway's API"
                   (Text.quoted route)));
        if q.persisted && q.per = Some Filters then
          refuse (at ^ "/persisted")
            "is true of a query per filters, which is not kept";
        Option.map
          (fun value ->
            {
              name = q.name;
              docs = q.docs;
              per = q.per;
              persisted = q.persisted;
              value;
            })
          (value ~persisted:q.persisted q.value))
      (List.mapi (fun i q -> (i, q)) table.queries)
  in
  let is_query name = Hashtbl.mem seen name in
  (* The component the way [text] ends at, in an event of [channel]. *)
  let way ~at ~on (channel : channel) text ~ends =
    let parts = String.split_on_char '.' text in
    if not (List.for_all way_part parts) then (
      refuse at
        (Printf.sprintf
           "is %s, which is no way to a member: the names of the members it is \
            within and its own, joined by dots"
           (Text.quoted text));
      None)
    else
      let rec walk shape passed = function
        | [] -> Some shape
        | name :: rest -> (
            let member =
              match (passed, channel.payload) with
              | [], Some payload when name = "payload" ->
                  Some (Shape.Ref payload)
              | _ -> member_of context.shapes shape name
            in
            match member with
            | Some member -> walk member (passed @ [ name ]) rest
            | None ->
                refuse at
                  (Printf.sprintf "is %s, and %s has no member %s" text
                     (match passed with
                     | [] -> on ^ "'s event"
                     | _ -> String.concat "." passed)
                     name);
                None)
      in
      Option.map
        (fun (shape : Shape.shape) ->
          match shape with
          | Ref name when name = ends -> parts
          | _ ->
              refuse at
                (Printf.sprintf "is %s, which ends at %s, not at %s" text
                   (match shape with
                   | Ref name -> name
                   | Shape _ -> "no component")
                   ends);
              parts)
        (walk channel.event [] parts)
  in
  let stated = Hashtbl.create 32 in
  let rows =
    List.filter_map
      (fun (i, (r : T.refresh_item)) ->
        let at = Printf.sprintf "/refresh/%d" i in
        let channel = List.assoc_opt r.on context.channels in
        (* A row that states no reach reaches its subject, as Node's
           generators read it; the table's own comment does not say. *)
        let reach : T.reach =
          match r.reach with Some reach -> reach | None -> Subject
        in
        let kind =
          match channel with
          | Some c -> Some (Channel { scoped = c.scoped })
          | None when r.on = reopened -> Some Reopened
          | None when r.on = unreadable -> Some Unreadable
          | None ->
              refuse (at ^ "/on")
                (Printf.sprintf
                   "is %s, which is neither a channel of the registry nor \
                    reopened nor unreadable"
                   (Text.quoted r.on));
              None
        in
        let no_event () = Option.is_some kind && Option.is_none channel in
        if no_event () && reach <> Held then
          refuse at
            (Printf.sprintf
               "is on %s, which is no event: it names no subject and reaches \
                what is held"
               r.on);
        (match r.when_ with
        | Some _
          when not
                 (Option.fold ~none:false
                    ~some:(fun (c : channel) -> c.enriched)
                    channel) ->
            refuse (at ^ "/when")
              (Printf.sprintf
                 "splits %s, which the registry does not say is enriched" r.on)
        | _ -> ());
        let named slot text ~ends =
          Option.bind text (fun text ->
              Option.bind channel (fun c ->
                  way ~at:(at ^ "/names/" ^ slot) ~on:r.on c text ~ends))
        in
        let resource, annotation =
          match r.names with
          | None -> (None, None)
          | Some names ->
              if no_event () then
                refuse (at ^ "/names")
                  (Printf.sprintf
                     "is on %s, which is no event, so it names no subject" r.on)
              else if reach = Held then
                refuse (at ^ "/names")
                  "names a subject, on a row that reaches what is held";
              (match (names.resource, channel) with
              | Some _, Some c when c.system ->
                  refuse (at ^ "/names/resource")
                    (Printf.sprintf
                       "names a resource, and the registry says %s's events \
                        are the knowledge base's, of no resource"
                       r.on)
              | _ -> ());
              ( named "resource" names.resource ~ends:"ResourceId",
                named "annotation" names.annotation ~ends:"AnnotationId" )
        in
        let carries =
          Option.bind r.carries (fun text ->
              match channel with
              | None ->
                  if no_event () then
                    refuse (at ^ "/carries")
                      (Printf.sprintf
                         "is on %s, which is no event, so it carries no value"
                         r.on);
                  None
              | Some c ->
                  way ~at:(at ^ "/carries") ~on:r.on c text ~ends:"Annotation")
        in
        let list = Option.value ~default:[] in
        if Option.is_some r.carries <> Option.is_some r.writes then
          refuse at
            "writes what its event carries, so it states both writes and \
             carries, or neither";
        (match r.when_ with
        | Some Enriched when Option.is_none r.carries ->
            refuse (at ^ "/when")
              "is enriched, so it carries the value that makes it so"
        | Some Unenriched when Option.is_some r.carries ->
            refuse (at ^ "/when") "is unenriched, so it carries nothing"
        | _ -> ());
        let key = (r.on, r.when_) in
        (match Hashtbl.find_opt stated key with
        | Some j ->
            refuse at
              (Printf.sprintf
                 "is on %s%s again, which /refresh/%d states already" r.on
                 (match r.when_ with
                 | Some Enriched -> " (enriched)"
                 | Some Unenriched -> " (unenriched)"
                 | None -> "")
                 j)
        | None -> Hashtbl.replace stated key i);
        let acted = Hashtbl.create 8 in
        List.iter
          (fun (act, queries) ->
            List.iteri
              (fun j query ->
                let at = Printf.sprintf "%s/%s/%d" at act j in
                if not (is_query query) then
                  refuse at (Printf.sprintf "is %s, which is no query" query)
                else if Hashtbl.mem acted query then
                  refuse at
                    (Printf.sprintf "is %s, which the row acts on already" query)
                else Hashtbl.replace acted query ())
              (list queries))
          [
            ("refetches", r.refetches);
            ("writes", r.writes);
            ("removes", r.removes);
          ];
        if r.refetches = None && r.writes = None && r.removes = None then
          refuse at
            "does nothing: it refetches, writes or removes a query at least";
        Option.map
          (fun kind ->
            ( i,
              r,
              kind,
              {
                when_ = r.when_;
                reach;
                resource;
                annotation;
                carries;
                refetches = list r.refetches;
                writes = list r.writes;
                removes = list r.removes;
              } ))
          kind)
      (List.mapi (fun i r -> (i, r)) table.refresh)
  in
  let row_of on =
    List.find_opt (fun (_, (r : T.refresh_item), _, _) -> r.on = on) rows
  in
  if Option.is_none (row_of reopened) then
    refuse "/refresh" "has no row for reopened";
  if Option.is_none (row_of unreadable) then
    refuse "/refresh" "has no row for unreadable";
  (* What a row may do follows from how its trigger is delivered
     (protocol/contract/TRANSPORT-CONTRACT.md § Delivery): a passing frame is
     lost while the stream is down, so a row it triggers only refetches, and
     reopened refetches the same, which repairs the miss. *)
  List.iter
    (fun (i, (r : T.refresh_item), _, row) ->
      match List.assoc_opt r.on context.channels with
      | Some c when c.passing && r.on <> resume_gap ->
          let at = Printf.sprintf "/refresh/%d" i in
          List.iter
            (fun (act, queries) ->
              if queries <> [] then
                refuse
                  (at ^ "/" ^ act)
                  (Printf.sprintf
                     "%s %s, and %s's frames are passing: one lost must leave \
                      the cache right"
                     act
                     (String.concat ", " queries)
                     r.on))
            [ ("writes", row.writes); ("removes", row.removes) ];
          Option.iter
            (fun (_, _, _, repairing) ->
              match
                List.filter
                  (fun q -> not (List.mem q repairing.refetches))
                  row.refetches
              with
              | [] -> ()
              | unrepaired ->
                  let named = String.concat ", " unrepaired in
                  refuse (at ^ "/refetches")
                    (Printf.sprintf
                       "refetches %s, which nothing replays to a client whose \
                        stream was down: reopened must refetch %s too"
                       named named))
            (row_of reopened)
      | _ -> ())
    rows;
  let triggers =
    List.filter_map
      (fun (i, (r : T.refresh_item), kind, _) ->
        match row_of r.on with
        | Some (first, _, _, _) when first = i ->
            let mine =
              List.filter
                (fun (_, (s : T.refresh_item), _, _) -> s.on = r.on)
                rows
            in
            let splits =
              List.sort_uniq compare
                (List.map (fun (_, (s : T.refresh_item), _, _) -> s.when_) mine)
            in
            if
              splits <> [ None ]
              && splits <> [ Some T.Enriched; Some Unenriched ]
            then
              refuse
                (Printf.sprintf "/refresh/%d" i)
                (Printf.sprintf
                   "splits %s, so it has a row for each of enriched and \
                    unenriched and no other"
                   r.on);
            let docs =
              match mine with
              | [ (_, (s : T.refresh_item), _, _) ] -> s.docs
              | _ ->
                  String.concat " "
                    (List.map
                       (fun (_, (s : T.refresh_item), _, _) ->
                         (match s.when_ with
                           | Some Enriched -> "enriched: "
                           | Some Unenriched -> "unenriched: "
                           | None -> "")
                         ^ s.docs)
                       mine)
            in
            Some
              {
                on = r.on;
                kind;
                docs;
                rows = List.map (fun (_, _, _, row) -> row) mine;
              }
        | _ -> None)
      rows
  in
  match List.rev !refusals with
  | [] -> Ok { queries; triggers }
  | refusals -> Error refusals
