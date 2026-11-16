(* specs/src/client/refresh.json *)

type value = { ref : string }

let value =
  Decode.obj (fun o : value -> { ref = Decode.required o "$ref" Decode.string })

type query = {
  name : string;
  per : string option;
  asks : string option;
  persisted : bool option;
  value : value;
  docs : string;
  reads : string option;
}

let query =
  Decode.obj (fun o : query ->
      {
        name = Decode.required o "name" Decode.string;
        per = Decode.optional o "per" Decode.string;
        asks = Decode.optional o "asks" Decode.string;
        persisted = Decode.optional o "persisted" Decode.bool;
        value = Decode.required o "value" value;
        docs = Decode.required o "docs" Decode.string;
        reads = Decode.optional o "reads" Decode.string;
      })

type names = { resource : string option; annotation : string option }

let names =
  Decode.obj (fun o : names ->
      {
        resource = Decode.optional o "resource" Decode.string;
        annotation = Decode.optional o "annotation" Decode.string;
      })

type refresh_item = {
  on : string;
  reach : string option;
  refetches : string list option;
  docs : string;
  names : names option;
  removes : string list option;
  when_ : string option;
  carries : string option;
  writes : string list option;
}

let refresh_item =
  Decode.obj (fun o : refresh_item ->
      {
        on = Decode.required o "on" Decode.string;
        reach = Decode.optional o "reach" Decode.string;
        refetches = Decode.optional o "refetches" (Decode.list Decode.string);
        docs = Decode.required o "docs" Decode.string;
        names = Decode.optional o "names" names;
        removes = Decode.optional o "removes" (Decode.list Decode.string);
        when_ = Decode.optional o "when" Decode.string;
        carries = Decode.optional o "carries" Decode.string;
        writes = Decode.optional o "writes" (Decode.list Decode.string);
      })

type t = { comment : string; queries : query list; refresh : refresh_item list }

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        queries = Decode.required o "queries" (Decode.list query);
        refresh = Decode.required o "refresh" (Decode.list refresh_item);
      })
