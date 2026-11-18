(* specs/src/text/chunk-cases.json *)

type defaults = { chunk_size : int; overlap : int }

let defaults =
  Decode.obj (fun o : defaults ->
      {
        chunk_size = Decode.required o "chunkSize" Decode.int;
        overlap = Decode.required o "overlap" Decode.int;
      })

type chunking = { chunk_size : int; overlap : int }

let chunking =
  Decode.obj (fun o : chunking ->
      {
        chunk_size = Decode.required o "chunkSize" Decode.int;
        overlap = Decode.required o "overlap" Decode.int;
      })

type cut = { at : int; piece : string; next : int }

let cut =
  Decode.obj (fun o : cut ->
      {
        at = Decode.required o "at" Decode.int;
        piece = Decode.required o "piece" Decode.string;
        next = Decode.required o "next" Decode.int;
      })

type case = {
  why : string;
  text : string;
  estimated_tokens : int;
  chunking : chunking;
  chunks : string list;
  cuts : cut list;
}

let case =
  Decode.obj (fun o : case ->
      {
        why = Decode.required o "why" Decode.string;
        text = Decode.required o "text" Decode.string;
        estimated_tokens = Decode.required o "estimatedTokens" Decode.int;
        chunking = Decode.required o "chunking" chunking;
        chunks = Decode.required o "chunks" (Decode.list Decode.string);
        cuts = Decode.required o "cuts" (Decode.list cut);
      })

type refused_item_chunking = { chunk_size : int; overlap : int }

let refused_item_chunking =
  Decode.obj (fun o : refused_item_chunking ->
      {
        chunk_size = Decode.required o "chunkSize" Decode.int;
        overlap = Decode.required o "overlap" Decode.int;
      })

type refused_item = { why : string; chunking : refused_item_chunking }

let refused_item =
  Decode.obj (fun o : refused_item ->
      {
        why = Decode.required o "why" Decode.string;
        chunking = Decode.required o "chunking" refused_item_chunking;
      })

type t = {
  comment : string;
  defaults : defaults;
  cases : case list;
  refused : refused_item list;
}

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        defaults = Decode.required o "defaults" defaults;
        cases = Decode.required o "cases" (Decode.list case);
        refused = Decode.required o "refused" (Decode.list refused_item);
      })
