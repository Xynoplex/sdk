(* specs/src/worker/parser-cases.json *)

type reply = {
  elements : Yojson.Safe.t option;
  stop_reason : string;
  text : string option;
}

let reply =
  Decode.obj (fun o : reply ->
      {
        elements = Decode.optional o "elements" Decode.json;
        stop_reason = Decode.required o "stopReason" Decode.string;
        text = Decode.optional o "text" Decode.string;
      })

type item = {
  exact : string;
  start : int option;
  end_ : int option;
  prefix : string option;
  suffix : string option;
  comment : string option;
  assessment : string option;
  category : string option;
  entity_type : string option;
}

let item =
  Decode.obj (fun o : item ->
      {
        exact = Decode.required o "exact" Decode.string;
        start = Decode.optional o "start" Decode.int;
        end_ = Decode.optional o "end" Decode.int;
        prefix = Decode.optional o "prefix" Decode.string;
        suffix = Decode.optional o "suffix" Decode.string;
        comment = Decode.optional o "comment" Decode.string;
        assessment = Decode.optional o "assessment" Decode.string;
        category = Decode.optional o "category" Decode.string;
        entity_type = Decode.optional o "entityType" Decode.string;
      })

type under_reported_item = { found : int; counted : int; piece_chars : int }

let under_reported_item =
  Decode.obj (fun o : under_reported_item ->
      {
        found = Decode.required o "found" Decode.int;
        counted = Decode.required o "counted" Decode.int;
        piece_chars = Decode.required o "pieceChars" Decode.int;
      })

type read = {
  items : item list;
  dropped : int;
  counted : int list option;
  under_reported : under_reported_item list option;
  unchecked : int option;
}

let read =
  Decode.obj (fun o : read ->
      {
        items = Decode.required o "items" (Decode.list item);
        dropped = Decode.required o "dropped" Decode.int;
        counted = Decode.optional o "counted" (Decode.list Decode.int);
        under_reported =
          Decode.optional o "underReported" (Decode.list under_reported_item);
        unchecked = Decode.optional o "unchecked" Decode.int;
      })

type refused = { name : string; stop_reason : string option }

let refused =
  Decode.obj (fun o : refused ->
      {
        name = Decode.required o "name" Decode.string;
        stop_reason = Decode.optional o "stopReason" Decode.string;
      })

type count = {
  elements : Yojson.Safe.t option;
  stop_reason : string option;
  text : string option;
  fails : bool option;
}

let count =
  Decode.obj (fun o : count ->
      {
        elements = Decode.optional o "elements" Decode.json;
        stop_reason = Decode.optional o "stopReason" Decode.string;
        text = Decode.optional o "text" Decode.string;
        fails = Decode.optional o "fails" Decode.bool;
      })

type case = {
  why : string;
  motivation : string;
  text : string;
  reply : reply;
  calls : int;
  read : read option;
  category : string option;
  refused : refused option;
  entity_type : string option;
  count_calls : int option;
  count : count option;
}

let case =
  Decode.obj (fun o : case ->
      {
        why = Decode.required o "why" Decode.string;
        motivation = Decode.required o "motivation" Decode.string;
        text = Decode.required o "text" Decode.string;
        reply = Decode.required o "reply" reply;
        calls = Decode.required o "calls" Decode.int;
        read = Decode.optional o "read" read;
        category = Decode.optional o "category" Decode.string;
        refused = Decode.optional o "refused" refused;
        entity_type = Decode.optional o "entityType" Decode.string;
        count_calls = Decode.optional o "countCalls" Decode.int;
        count = Decode.optional o "count" count;
      })

type t = { comment : string; cases : case list }

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        cases = Decode.required o "cases" (Decode.list case);
      })
