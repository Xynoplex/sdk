(* specs/src/client/refresh.json *)

type per = Resource | Annotation | Filters
type source = Asks of string | Reads of string

type query = {
  name : string;
  per : per option; (* Absent, the knowledge base has one. *)
  source : source;
  persisted : bool;
  value : Decode.reference;
  docs : string;
}

let persisted cursor =
  if not (Decode.bool cursor) then
    Decode.refuse cursor "is false: a query not persisted states no persisted"

let query =
  Decode.obj (fun o : query ->
      let name = Decode.required o "name" Decode.string in
      let per =
        Decode.optional o "per"
          (Decode.enum
             [
               ("resource", Resource);
               ("annotation", Annotation);
               ("filters", Filters);
             ])
      in
      let cursor = Decode.at o in
      let source =
        match
          (Decode.has_member "asks" cursor, Decode.has_member "reads" cursor)
        with
        | true, true ->
            Decode.refuse cursor
              "asks an operation and reads a GET: a query does one"
        | true, false -> Asks (Decode.required o "asks" Decode.string)
        | false, true -> Reads (Decode.required o "reads" Decode.string)
        | false, false ->
            Decode.refuse cursor
              "neither asks an operation nor reads a GET: a query does one"
      in
      let persisted =
        Option.is_some (Decode.optional o "persisted" persisted)
      in
      let value =
        Decode.required o "value"
          (Decode.obj (fun v -> Decode.required v "$ref" Decode.reference))
      in
      let docs = Decode.required o "docs" Decode.non_empty_string in
      { name; per; source; persisted; value; docs })

type names = { resource : string option; annotation : string option }

let names =
  Decode.obj (fun o : names ->
      let resource = Decode.optional o "resource" Decode.string in
      let annotation = Decode.optional o "annotation" Decode.string in
      { resource; annotation })

type reach = Subject | Held
type when_ = Enriched | Unenriched
type stream = Reopened | Unreadable
type trigger = On of string | Stream of stream

let streams = [ ("reopened", Reopened); ("unreadable", Unreadable) ]
let stream_name stream = fst (List.find (fun (_, s) -> s = stream) streams)

(* A channel's trigger is named by its channel, the stream's by what befalls
   it. *)
let trigger_name = function On channel -> channel | Stream s -> stream_name s

type refresh_item = {
  trigger : trigger;
  when_ : when_ option;
  reach : reach option;
  names : names option;
  carries : string option;
  refetches : string list option;
  writes : string list option;
  removes : string list option;
  docs : string;
}

let refresh_item =
  Decode.obj (fun o : refresh_item ->
      let cursor = Decode.at o in
      let trigger =
        match
          (Decode.has_member "on" cursor, Decode.has_member "stream" cursor)
        with
        | true, true ->
            Decode.refuse cursor
              "is on a channel and of the stream: a row has one trigger"
        | true, false -> On (Decode.required o "on" Decode.string)
        | false, true ->
            Stream (Decode.required o "stream" (Decode.enum streams))
        | false, false ->
            Decode.refuse cursor
              "is neither on a channel nor of the stream: a row has one trigger"
      in
      let when_ =
        Decode.optional o "when"
          (Decode.enum [ ("enriched", Enriched); ("unenriched", Unenriched) ])
      in
      let reach =
        Decode.optional o "reach"
          (Decode.enum [ ("subject", Subject); ("held", Held) ])
      in
      let names = Decode.optional o "names" names in
      let carries = Decode.optional o "carries" Decode.string in
      let act name =
        Decode.optional o name (Decode.non_empty_list Decode.string)
      in
      let refetches = act "refetches" in
      let writes = act "writes" in
      let removes = act "removes" in
      let docs = Decode.required o "docs" Decode.non_empty_string in
      {
        trigger;
        when_;
        reach;
        names;
        carries;
        refetches;
        writes;
        removes;
        docs;
      })

type t = { comment : string; queries : query list; refresh : refresh_item list }

let decode =
  Decode.obj (fun o : t ->
      let comment = Decode.required o "$comment" Decode.string in
      let queries = Decode.required o "queries" (Decode.non_empty_list query) in
      let refresh =
        Decode.required o "refresh" (Decode.non_empty_list refresh_item)
      in
      { comment; queries; refresh })
