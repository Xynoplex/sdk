(* specs/src/session/cache-cases.json *)

type 'value entry = { key : string; value : 'value }

let entry value =
  Decode.obj (fun o : _ entry ->
      {
        key = Decode.required o "key" Decode.string;
        value = Decode.required o "value" value;
      })

type tag = { name : string; description : string; examples : string list }

let tag =
  Decode.obj (fun o : tag ->
      {
        name = Decode.required o "name" Decode.string;
        description = Decode.required o "description" Decode.string;
        examples = Decode.required o "examples" (Decode.list Decode.string);
      })

type kept_value_item_kept_value_item = {
  id : string;
  name : string;
  description : string;
  domain : string;
  tags : tag list;
}

let kept_value_item_kept_value_item =
  Decode.obj (fun o : kept_value_item_kept_value_item ->
      {
        id = Decode.required o "id" Decode.string;
        name = Decode.required o "name" Decode.string;
        description = Decode.required o "description" Decode.string;
        domain = Decode.required o "domain" Decode.string;
        tags = Decode.required o "tags" (Decode.list tag);
      })

type kept_value_item =
  | String of string
  | Object of kept_value_item_kept_value_item

let kept_value_item =
 fun c ->
  match Decode.kind c with
  | Decode.String -> (String (Decode.string c) : kept_value_item)
  | Decode.Object ->
      (Object (kept_value_item_kept_value_item c) : kept_value_item)
  | _ -> Decode.refuse c "expected a string or an object"

type target = { source : string }

let target =
  Decode.obj (fun o : target ->
      { source = Decode.required o "source" Decode.string })

type annotation = {
  context : string;
  type_ : string;
  id : string;
  motivation : string;
  target : target;
  created : string;
}

let annotation =
  Decode.obj (fun o : annotation ->
      {
        context = Decode.required o "@context" Decode.string;
        type_ = Decode.required o "type" Decode.string;
        id = Decode.required o "id" Decode.string;
        motivation = Decode.required o "motivation" Decode.string;
        target = Decode.required o "target" target;
        created = Decode.required o "created" Decode.string;
      })

type kept_value_kept_value_target = { source : string }

let kept_value_kept_value_target =
  Decode.obj (fun o : kept_value_kept_value_target ->
      { source = Decode.required o "source" Decode.string })

type kept_value_kept_value = {
  context : string option;
  id : string option;
  name : string option;
  representations : Decode.nothing list option;
  annotations : annotation list option;
  total : int option;
  type_ : string option;
  dollar_id : string option;
  motivation : string option;
  target : kept_value_kept_value_target option;
  created : string option;
}

let kept_value_kept_value =
  Decode.obj (fun o : kept_value_kept_value ->
      {
        context = Decode.optional o "@context" Decode.string;
        id = Decode.optional o "@id" Decode.string;
        name = Decode.optional o "name" Decode.string;
        representations =
          Decode.optional o "representations" (Decode.list Decode.nothing);
        annotations = Decode.optional o "annotations" (Decode.list annotation);
        total = Decode.optional o "total" Decode.int;
        type_ = Decode.optional o "type" Decode.string;
        dollar_id = Decode.optional o "id" Decode.string;
        motivation = Decode.optional o "motivation" Decode.string;
        target = Decode.optional o "target" kept_value_kept_value_target;
        created = Decode.optional o "created" Decode.string;
      })

type kept_value =
  | Array of kept_value_item list
  | Object of kept_value_kept_value

let kept_value =
 fun c ->
  match Decode.kind c with
  | Decode.Array -> (Array (Decode.list kept_value_item c) : kept_value)
  | Decode.Object -> (Object (kept_value_kept_value c) : kept_value)
  | _ -> Decode.refuse c "expected an array or an object"

type case = {
  name : string;
  query : string;
  stored : Yojson.Safe.t option;
  kept : kept_value entry list;
  stored_text : string option;
}

let case =
  Decode.obj (fun o : case ->
      {
        name = Decode.required o "name" Decode.string;
        query = Decode.required o "query" Decode.string;
        stored = Decode.optional o "stored" Decode.json;
        kept = Decode.required o "kept" (Decode.list (entry kept_value));
        stored_text = Decode.optional o "storedText" Decode.string;
      })

type held_value_item_held_value_item_tag = {
  name : string;
  description : string;
  examples : string list;
}

let held_value_item_held_value_item_tag =
  Decode.obj (fun o : held_value_item_held_value_item_tag ->
      {
        name = Decode.required o "name" Decode.string;
        description = Decode.required o "description" Decode.string;
        examples = Decode.required o "examples" (Decode.list Decode.string);
      })

type held_value_item_held_value_item = {
  id : string;
  name : string;
  description : string;
  domain : string;
  tags : held_value_item_held_value_item_tag list;
}

let held_value_item_held_value_item =
  Decode.obj (fun o : held_value_item_held_value_item ->
      {
        id = Decode.required o "id" Decode.string;
        name = Decode.required o "name" Decode.string;
        description = Decode.required o "description" Decode.string;
        domain = Decode.required o "domain" Decode.string;
        tags =
          Decode.required o "tags"
            (Decode.list held_value_item_held_value_item_tag);
      })

type held_value_item =
  | String of string
  | Object of held_value_item_held_value_item

let held_value_item =
 fun c ->
  match Decode.kind c with
  | Decode.String -> (String (Decode.string c) : held_value_item)
  | Decode.Object ->
      (Object (held_value_item_held_value_item c) : held_value_item)
  | _ -> Decode.refuse c "expected a string or an object"

type held_value_held_value_annotation_target = { source : string }

let held_value_held_value_annotation_target =
  Decode.obj (fun o : held_value_held_value_annotation_target ->
      { source = Decode.required o "source" Decode.string })

type held_value_held_value_annotation = {
  context : string;
  type_ : string;
  id : string;
  motivation : string;
  target : held_value_held_value_annotation_target;
  created : string;
}

let held_value_held_value_annotation =
  Decode.obj (fun o : held_value_held_value_annotation ->
      {
        context = Decode.required o "@context" Decode.string;
        type_ = Decode.required o "type" Decode.string;
        id = Decode.required o "id" Decode.string;
        motivation = Decode.required o "motivation" Decode.string;
        target =
          Decode.required o "target" held_value_held_value_annotation_target;
        created = Decode.required o "created" Decode.string;
      })

type held_value_held_value_target = { source : string }

let held_value_held_value_target =
  Decode.obj (fun o : held_value_held_value_target ->
      { source = Decode.required o "source" Decode.string })

type held_value_held_value = {
  context : string option;
  id : string option;
  name : string option;
  representations : Decode.nothing list option;
  annotations : held_value_held_value_annotation list option;
  total : int option;
  type_ : string option;
  dollar_id : string option;
  motivation : string option;
  target : held_value_held_value_target option;
  created : string option;
}

let held_value_held_value =
  Decode.obj (fun o : held_value_held_value ->
      {
        context = Decode.optional o "@context" Decode.string;
        id = Decode.optional o "@id" Decode.string;
        name = Decode.optional o "name" Decode.string;
        representations =
          Decode.optional o "representations" (Decode.list Decode.nothing);
        annotations =
          Decode.optional o "annotations"
            (Decode.list held_value_held_value_annotation);
        total = Decode.optional o "total" Decode.int;
        type_ = Decode.optional o "type" Decode.string;
        dollar_id = Decode.optional o "id" Decode.string;
        motivation = Decode.optional o "motivation" Decode.string;
        target = Decode.optional o "target" held_value_held_value_target;
        created = Decode.optional o "created" Decode.string;
      })

type held_value =
  | Array of held_value_item list
  | Object of held_value_held_value

let held_value =
 fun c ->
  match Decode.kind c with
  | Decode.Array -> (Array (Decode.list held_value_item c) : held_value)
  | Decode.Object -> (Object (held_value_held_value c) : held_value)
  | _ -> Decode.refuse c "expected an array or an object"

type entry_value_item_entry_value_item_tag = {
  name : string;
  description : string;
  examples : string list;
}

let entry_value_item_entry_value_item_tag =
  Decode.obj (fun o : entry_value_item_entry_value_item_tag ->
      {
        name = Decode.required o "name" Decode.string;
        description = Decode.required o "description" Decode.string;
        examples = Decode.required o "examples" (Decode.list Decode.string);
      })

type entry_value_item_entry_value_item = {
  id : string;
  name : string;
  description : string;
  domain : string;
  tags : entry_value_item_entry_value_item_tag list;
}

let entry_value_item_entry_value_item =
  Decode.obj (fun o : entry_value_item_entry_value_item ->
      {
        id = Decode.required o "id" Decode.string;
        name = Decode.required o "name" Decode.string;
        description = Decode.required o "description" Decode.string;
        domain = Decode.required o "domain" Decode.string;
        tags =
          Decode.required o "tags"
            (Decode.list entry_value_item_entry_value_item_tag);
      })

type entry_value_item =
  | String of string
  | Object of entry_value_item_entry_value_item

let entry_value_item =
 fun c ->
  match Decode.kind c with
  | Decode.String -> (String (Decode.string c) : entry_value_item)
  | Decode.Object ->
      (Object (entry_value_item_entry_value_item c) : entry_value_item)
  | _ -> Decode.refuse c "expected a string or an object"

type entry_value_entry_value_annotation_target = { source : string }

let entry_value_entry_value_annotation_target =
  Decode.obj (fun o : entry_value_entry_value_annotation_target ->
      { source = Decode.required o "source" Decode.string })

type entry_value_entry_value_annotation = {
  context : string;
  type_ : string;
  id : string;
  motivation : string;
  target : entry_value_entry_value_annotation_target;
  created : string;
}

let entry_value_entry_value_annotation =
  Decode.obj (fun o : entry_value_entry_value_annotation ->
      {
        context = Decode.required o "@context" Decode.string;
        type_ = Decode.required o "type" Decode.string;
        id = Decode.required o "id" Decode.string;
        motivation = Decode.required o "motivation" Decode.string;
        target =
          Decode.required o "target" entry_value_entry_value_annotation_target;
        created = Decode.required o "created" Decode.string;
      })

type entry_value_entry_value_target = { source : string }

let entry_value_entry_value_target =
  Decode.obj (fun o : entry_value_entry_value_target ->
      { source = Decode.required o "source" Decode.string })

type entry_value_entry_value = {
  context : string option;
  id : string option;
  name : string option;
  representations : Decode.nothing list option;
  annotations : entry_value_entry_value_annotation list option;
  total : int option;
  type_ : string option;
  dollar_id : string option;
  motivation : string option;
  target : entry_value_entry_value_target option;
  created : string option;
}

let entry_value_entry_value =
  Decode.obj (fun o : entry_value_entry_value ->
      {
        context = Decode.optional o "@context" Decode.string;
        id = Decode.optional o "@id" Decode.string;
        name = Decode.optional o "name" Decode.string;
        representations =
          Decode.optional o "representations" (Decode.list Decode.nothing);
        annotations =
          Decode.optional o "annotations"
            (Decode.list entry_value_entry_value_annotation);
        total = Decode.optional o "total" Decode.int;
        type_ = Decode.optional o "type" Decode.string;
        dollar_id = Decode.optional o "id" Decode.string;
        motivation = Decode.optional o "motivation" Decode.string;
        target = Decode.optional o "target" entry_value_entry_value_target;
        created = Decode.optional o "created" Decode.string;
      })

type entry_value =
  | Array of entry_value_item list
  | Object of entry_value_entry_value

let entry_value =
 fun c ->
  match Decode.kind c with
  | Decode.Array -> (Array (Decode.list entry_value_item c) : entry_value)
  | Decode.Object -> (Object (entry_value_entry_value c) : entry_value)
  | _ -> Decode.refuse c "expected an array or an object"

type written = { version : int; entries : entry_value entry list }

let written =
  Decode.obj (fun o : written ->
      {
        version = Decode.required o "version" Decode.int;
        entries = Decode.required o "entries" (Decode.list (entry entry_value));
      })

type write = {
  name : string;
  query : string;
  held : held_value entry list;
  written : written;
}

let write =
  Decode.obj (fun o : write ->
      {
        name = Decode.required o "name" Decode.string;
        query = Decode.required o "query" Decode.string;
        held = Decode.required o "held" (Decode.list (entry held_value));
        written = Decode.required o "written" written;
      })

type refused_write_held_value_held_value = {
  context : string;
  id : string;
  name : string;
  representations : Decode.nothing list;
}

let refused_write_held_value_held_value =
  Decode.obj (fun o : refused_write_held_value_held_value ->
      {
        context = Decode.required o "@context" Decode.string;
        id = Decode.required o "@id" Decode.string;
        name = Decode.required o "name" Decode.string;
        representations =
          Decode.required o "representations" (Decode.list Decode.nothing);
      })

type refused_write_held_value =
  | Array of string list
  | Object of refused_write_held_value_held_value

let refused_write_held_value =
 fun c ->
  match Decode.kind c with
  | Decode.Array ->
      (Array (Decode.list Decode.string c) : refused_write_held_value)
  | Decode.Object ->
      (Object (refused_write_held_value_held_value c)
        : refused_write_held_value)
  | _ -> Decode.refuse c "expected an array or an object"

type refused_write_written_entry_value_entry_value = {
  context : string;
  id : string;
  name : string;
  representations : Decode.nothing list;
}

let refused_write_written_entry_value_entry_value =
  Decode.obj (fun o : refused_write_written_entry_value_entry_value ->
      {
        context = Decode.required o "@context" Decode.string;
        id = Decode.required o "@id" Decode.string;
        name = Decode.required o "name" Decode.string;
        representations =
          Decode.required o "representations" (Decode.list Decode.nothing);
      })

type refused_write_written_entry_value =
  | Array of string list
  | Object of refused_write_written_entry_value_entry_value

let refused_write_written_entry_value =
 fun c ->
  match Decode.kind c with
  | Decode.Array ->
      (Array (Decode.list Decode.string c) : refused_write_written_entry_value)
  | Decode.Object ->
      (Object (refused_write_written_entry_value_entry_value c)
        : refused_write_written_entry_value)
  | _ -> Decode.refuse c "expected an array or an object"

type refused_write_written = {
  version : int;
  entries : refused_write_written_entry_value entry list;
}

let refused_write_written =
  Decode.obj (fun o : refused_write_written ->
      {
        version = Decode.required o "version" Decode.int;
        entries =
          Decode.required o "entries"
            (Decode.list (entry refused_write_written_entry_value));
      })

type refused_write = {
  name : string;
  query : string;
  held : refused_write_held_value entry list;
  written : refused_write_written;
}

let refused_write =
  Decode.obj (fun o : refused_write ->
      {
        name = Decode.required o "name" Decode.string;
        query = Decode.required o "query" Decode.string;
        held =
          Decode.required o "held"
            (Decode.list (entry refused_write_held_value));
        written = Decode.required o "written" refused_write_written;
      })

type place = {
  name : string;
  stored : Yojson.Safe.t option;
  kept : (string * string) list;
  stored_text : string option;
}

let place =
  Decode.obj (fun o : place ->
      {
        name = Decode.required o "name" Decode.string;
        stored = Decode.optional o "stored" Decode.json;
        kept = Decode.required o "kept" (Decode.map Decode.string);
        stored_text = Decode.optional o "storedText" Decode.string;
      })

type t = {
  comment : string;
  cases : case list;
  writes : write list;
  refused_writes : refused_write list;
  places : place list;
}

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        cases = Decode.required o "cases" (Decode.list case);
        writes = Decode.required o "writes" (Decode.list write);
        refused_writes =
          Decode.required o "refusedWrites" (Decode.list refused_write);
        places = Decode.required o "places" (Decode.list place);
      })
