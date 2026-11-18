(* specs/src/librarian/prompt-cases.json *)

type candidate = { id : string; name : string; entity_types : string list }

let candidate =
  Decode.obj (fun o : candidate ->
      {
        id = Decode.required o "id" Decode.string;
        name = Decode.required o "name" Decode.string;
        entity_types =
          Decode.required o "entityTypes" (Decode.list Decode.string);
      })

type content_item_content_item = { repeat : string; times : int }

let content_item_content_item =
  Decode.obj (fun o : content_item_content_item ->
      {
        repeat = Decode.required o "repeat" Decode.string;
        times = Decode.required o "times" Decode.int;
      })

type content_item = String of string | Object of content_item_content_item

let content_item =
 fun c ->
  match Decode.kind c with
  | Decode.String -> (String (Decode.string c) : content_item)
  | Decode.Object -> (Object (content_item_content_item c) : content_item)
  | _ -> Decode.refuse c "expected a string or an object"

type content = String of string | Array of content_item list

let content =
 fun c ->
  match Decode.kind c with
  | Decode.String -> (String (Decode.string c) : content)
  | Decode.Array -> (Array (Decode.list content_item c) : content)
  | _ -> Decode.refuse c "expected a string or an array"

type stub_item_stub_item = { repeat : string; times : int }

let stub_item_stub_item =
  Decode.obj (fun o : stub_item_stub_item ->
      {
        repeat = Decode.required o "repeat" Decode.string;
        times = Decode.required o "times" Decode.int;
      })

type stub_item = String of string | Object of stub_item_stub_item

let stub_item =
 fun c ->
  match Decode.kind c with
  | Decode.String -> (String (Decode.string c) : stub_item)
  | Decode.Object -> (Object (stub_item_stub_item c) : stub_item)
  | _ -> Decode.refuse c "expected a string or an object"

type stub = String of string | Array of stub_item list

let stub =
 fun c ->
  match Decode.kind c with
  | Decode.String -> (String (Decode.string c) : stub)
  | Decode.Array -> (Array (Decode.list stub_item c) : stub)
  | _ -> Decode.refuse c "expected a string or an array"

type before_item_before_item = { repeat : string; times : int }

let before_item_before_item =
  Decode.obj (fun o : before_item_before_item ->
      {
        repeat = Decode.required o "repeat" Decode.string;
        times = Decode.required o "times" Decode.int;
      })

type before_item = String of string | Object of before_item_before_item

let before_item =
 fun c ->
  match Decode.kind c with
  | Decode.String -> (String (Decode.string c) : before_item)
  | Decode.Object -> (Object (before_item_before_item c) : before_item)
  | _ -> Decode.refuse c "expected a string or an object"

type before = String of string | Array of before_item list

let before =
 fun c ->
  match Decode.kind c with
  | Decode.String -> (String (Decode.string c) : before)
  | Decode.Array -> (Array (Decode.list before_item c) : before)
  | _ -> Decode.refuse c "expected a string or an array"

type after_item_after_item = { repeat : string; times : int }

let after_item_after_item =
  Decode.obj (fun o : after_item_after_item ->
      {
        repeat = Decode.required o "repeat" Decode.string;
        times = Decode.required o "times" Decode.int;
      })

type after_item = String of string | Object of after_item_after_item

let after_item =
 fun c ->
  match Decode.kind c with
  | Decode.String -> (String (Decode.string c) : after_item)
  | Decode.Object -> (Object (after_item_after_item c) : after_item)
  | _ -> Decode.refuse c "expected a string or an object"

type after = String of string | Array of after_item list

let after =
 fun c ->
  match Decode.kind c with
  | Decode.String -> (String (Decode.string c) : after)
  | Decode.Array -> (Array (Decode.list after_item c) : after)
  | _ -> Decode.refuse c "expected a string or an array"

type from = {
  selected : string option;
  motivation : string option;
  source : string option;
  entity_types : string list option;
  connected : string list option;
  candidates : candidate list option;
  hint : string option;
  body : string option;
  relationship : string option;
  passage : string option;
  cited_by : string list option;
  sibling_entity_types : string list option;
  name : string option;
  content : content option;
  title : string option;
  entity_type : string option;
  stub : stub option;
  resource : string option;
  before : before option;
  after : after option;
}

let from =
  Decode.obj (fun o : from ->
      {
        selected = Decode.optional o "selected" Decode.string;
        motivation = Decode.optional o "motivation" Decode.string;
        source = Decode.optional o "source" Decode.string;
        entity_types =
          Decode.optional o "entityTypes" (Decode.list Decode.string);
        connected = Decode.optional o "connected" (Decode.list Decode.string);
        candidates = Decode.optional o "candidates" (Decode.list candidate);
        hint = Decode.optional o "hint" Decode.string;
        body = Decode.optional o "body" Decode.string;
        relationship = Decode.optional o "relationship" Decode.string;
        passage = Decode.optional o "passage" Decode.string;
        cited_by = Decode.optional o "citedBy" (Decode.list Decode.string);
        sibling_entity_types =
          Decode.optional o "siblingEntityTypes" (Decode.list Decode.string);
        name = Decode.optional o "name" Decode.string;
        content = Decode.optional o "content" content;
        title = Decode.optional o "title" Decode.string;
        entity_type = Decode.optional o "entityType" Decode.string;
        stub = Decode.optional o "stub" stub;
        resource = Decode.optional o "resource" Decode.string;
        before = Decode.optional o "before" before;
        after = Decode.optional o "after" after;
      })

type text_item_text_item = { repeat : string; times : int }

let text_item_text_item =
  Decode.obj (fun o : text_item_text_item ->
      {
        repeat = Decode.required o "repeat" Decode.string;
        times = Decode.required o "times" Decode.int;
      })

type text_item = String of string | Object of text_item_text_item

let text_item =
 fun c ->
  match Decode.kind c with
  | Decode.String -> (String (Decode.string c) : text_item)
  | Decode.Object -> (Object (text_item_text_item c) : text_item)
  | _ -> Decode.refuse c "expected a string or an object"

type text = String of string | Array of text_item list

let text =
 fun c ->
  match Decode.kind c with
  | Decode.String -> (String (Decode.string c) : text)
  | Decode.Array -> (Array (Decode.list text_item c) : text)
  | _ -> Decode.refuse c "expected a string or an array"

type case = {
  why : string;
  prompt : string;
  from : from;
  text : text;
  max_tokens : int;
  temperature : float;
}

let case =
  Decode.obj (fun o : case ->
      {
        why = Decode.required o "why" Decode.string;
        prompt = Decode.required o "prompt" Decode.string;
        from = Decode.required o "from" from;
        text = Decode.required o "text" text;
        max_tokens = Decode.required o "maxTokens" Decode.int;
        temperature = Decode.required o "temperature" Decode.number;
      })

type t = {
  comment : string;
  elements : (string * Schema.t) list;
  cases : case list;
}

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        elements = Decode.required o "elements" (Decode.map Schema.decode);
        cases = Decode.required o "cases" (Decode.list case);
      })
