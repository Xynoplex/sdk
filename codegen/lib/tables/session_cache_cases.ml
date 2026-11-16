(* specs/src/session/cache-cases.json *)

type tag = { name : string; description : string; examples : string list }

let tag =
  Decode.obj (fun o : tag ->
      {
        name = Decode.required o "name" Decode.string;
        description = Decode.required o "description" Decode.string;
        examples = Decode.required o "examples" (Decode.list Decode.string);
      })

type kept_item_1_item_kept_item_1_item = {
  id : string;
  name : string;
  description : string;
  domain : string;
  tags : tag list;
}

let kept_item_1_item_kept_item_1_item =
  Decode.obj (fun o : kept_item_1_item_kept_item_1_item ->
      {
        id = Decode.required o "id" Decode.string;
        name = Decode.required o "name" Decode.string;
        description = Decode.required o "description" Decode.string;
        domain = Decode.required o "domain" Decode.string;
        tags = Decode.required o "tags" (Decode.list tag);
      })

type kept_item_1_item =
  | String of string
  | Object of kept_item_1_item_kept_item_1_item

let kept_item_1_item =
 fun c ->
  match Decode.kind c with
  | Decode.String -> (String (Decode.string c) : kept_item_1_item)
  | Decode.Object ->
      (Object (kept_item_1_item_kept_item_1_item c) : kept_item_1_item)
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

type kept_item_1_kept_item_1_target = { source : string }

let kept_item_1_kept_item_1_target =
  Decode.obj (fun o : kept_item_1_kept_item_1_target ->
      { source = Decode.required o "source" Decode.string })

type kept_item_1_kept_item_1 = {
  context : string option;
  id : string option;
  name : string option;
  representations : Decode.nothing list option;
  annotations : annotation list option;
  total : int option;
  type_ : string option;
  dollar_id : string option;
  motivation : string option;
  target : kept_item_1_kept_item_1_target option;
  created : string option;
}

let kept_item_1_kept_item_1 =
  Decode.obj (fun o : kept_item_1_kept_item_1 ->
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
        target = Decode.optional o "target" kept_item_1_kept_item_1_target;
        created = Decode.optional o "created" Decode.string;
      })

type kept_item_1 =
  | Array of kept_item_1_item list
  | Object of kept_item_1_kept_item_1

let kept_item_1 =
 fun c ->
  match Decode.kind c with
  | Decode.Array -> (Array (Decode.list kept_item_1_item c) : kept_item_1)
  | Decode.Object -> (Object (kept_item_1_kept_item_1 c) : kept_item_1)
  | _ -> Decode.refuse c "expected an array or an object"

type case = {
  name : string;
  query : string;
  stored : Yojson.Safe.t option;
  kept : (string * kept_item_1) list;
  stored_text : string option;
}

let case =
  Decode.obj (fun o : case ->
      {
        name = Decode.required o "name" Decode.string;
        query = Decode.required o "query" Decode.string;
        stored = Decode.optional o "stored" Decode.json;
        kept =
          Decode.required o "kept"
            (Decode.list (Decode.pair Decode.string kept_item_1));
        stored_text = Decode.optional o "storedText" Decode.string;
      })

type held_item_1_item_held_item_1_item_tag = {
  name : string;
  description : string;
  examples : string list;
}

let held_item_1_item_held_item_1_item_tag =
  Decode.obj (fun o : held_item_1_item_held_item_1_item_tag ->
      {
        name = Decode.required o "name" Decode.string;
        description = Decode.required o "description" Decode.string;
        examples = Decode.required o "examples" (Decode.list Decode.string);
      })

type held_item_1_item_held_item_1_item = {
  id : string;
  name : string;
  description : string;
  domain : string;
  tags : held_item_1_item_held_item_1_item_tag list;
}

let held_item_1_item_held_item_1_item =
  Decode.obj (fun o : held_item_1_item_held_item_1_item ->
      {
        id = Decode.required o "id" Decode.string;
        name = Decode.required o "name" Decode.string;
        description = Decode.required o "description" Decode.string;
        domain = Decode.required o "domain" Decode.string;
        tags =
          Decode.required o "tags"
            (Decode.list held_item_1_item_held_item_1_item_tag);
      })

type held_item_1_item =
  | String of string
  | Object of held_item_1_item_held_item_1_item

let held_item_1_item =
 fun c ->
  match Decode.kind c with
  | Decode.String -> (String (Decode.string c) : held_item_1_item)
  | Decode.Object ->
      (Object (held_item_1_item_held_item_1_item c) : held_item_1_item)
  | _ -> Decode.refuse c "expected a string or an object"

type held_item_1_held_item_1_annotation_target = { source : string }

let held_item_1_held_item_1_annotation_target =
  Decode.obj (fun o : held_item_1_held_item_1_annotation_target ->
      { source = Decode.required o "source" Decode.string })

type held_item_1_held_item_1_annotation = {
  context : string;
  type_ : string;
  id : string;
  motivation : string;
  target : held_item_1_held_item_1_annotation_target;
  created : string;
}

let held_item_1_held_item_1_annotation =
  Decode.obj (fun o : held_item_1_held_item_1_annotation ->
      {
        context = Decode.required o "@context" Decode.string;
        type_ = Decode.required o "type" Decode.string;
        id = Decode.required o "id" Decode.string;
        motivation = Decode.required o "motivation" Decode.string;
        target =
          Decode.required o "target" held_item_1_held_item_1_annotation_target;
        created = Decode.required o "created" Decode.string;
      })

type held_item_1_held_item_1_target = { source : string }

let held_item_1_held_item_1_target =
  Decode.obj (fun o : held_item_1_held_item_1_target ->
      { source = Decode.required o "source" Decode.string })

type held_item_1_held_item_1 = {
  context : string option;
  id : string option;
  name : string option;
  representations : Decode.nothing list option;
  annotations : held_item_1_held_item_1_annotation list option;
  total : int option;
  type_ : string option;
  dollar_id : string option;
  motivation : string option;
  target : held_item_1_held_item_1_target option;
  created : string option;
}

let held_item_1_held_item_1 =
  Decode.obj (fun o : held_item_1_held_item_1 ->
      {
        context = Decode.optional o "@context" Decode.string;
        id = Decode.optional o "@id" Decode.string;
        name = Decode.optional o "name" Decode.string;
        representations =
          Decode.optional o "representations" (Decode.list Decode.nothing);
        annotations =
          Decode.optional o "annotations"
            (Decode.list held_item_1_held_item_1_annotation);
        total = Decode.optional o "total" Decode.int;
        type_ = Decode.optional o "type" Decode.string;
        dollar_id = Decode.optional o "id" Decode.string;
        motivation = Decode.optional o "motivation" Decode.string;
        target = Decode.optional o "target" held_item_1_held_item_1_target;
        created = Decode.optional o "created" Decode.string;
      })

type held_item_1 =
  | Array of held_item_1_item list
  | Object of held_item_1_held_item_1

let held_item_1 =
 fun c ->
  match Decode.kind c with
  | Decode.Array -> (Array (Decode.list held_item_1_item c) : held_item_1)
  | Decode.Object -> (Object (held_item_1_held_item_1 c) : held_item_1)
  | _ -> Decode.refuse c "expected an array or an object"

type entry_1_item_entry_1_item_tag = {
  name : string;
  description : string;
  examples : string list;
}

let entry_1_item_entry_1_item_tag =
  Decode.obj (fun o : entry_1_item_entry_1_item_tag ->
      {
        name = Decode.required o "name" Decode.string;
        description = Decode.required o "description" Decode.string;
        examples = Decode.required o "examples" (Decode.list Decode.string);
      })

type entry_1_item_entry_1_item = {
  id : string;
  name : string;
  description : string;
  domain : string;
  tags : entry_1_item_entry_1_item_tag list;
}

let entry_1_item_entry_1_item =
  Decode.obj (fun o : entry_1_item_entry_1_item ->
      {
        id = Decode.required o "id" Decode.string;
        name = Decode.required o "name" Decode.string;
        description = Decode.required o "description" Decode.string;
        domain = Decode.required o "domain" Decode.string;
        tags =
          Decode.required o "tags" (Decode.list entry_1_item_entry_1_item_tag);
      })

type entry_1_item = String of string | Object of entry_1_item_entry_1_item

let entry_1_item =
 fun c ->
  match Decode.kind c with
  | Decode.String -> (String (Decode.string c) : entry_1_item)
  | Decode.Object -> (Object (entry_1_item_entry_1_item c) : entry_1_item)
  | _ -> Decode.refuse c "expected a string or an object"

type entry_1_entry_1_annotation_target = { source : string }

let entry_1_entry_1_annotation_target =
  Decode.obj (fun o : entry_1_entry_1_annotation_target ->
      { source = Decode.required o "source" Decode.string })

type entry_1_entry_1_annotation = {
  context : string;
  type_ : string;
  id : string;
  motivation : string;
  target : entry_1_entry_1_annotation_target;
  created : string;
}

let entry_1_entry_1_annotation =
  Decode.obj (fun o : entry_1_entry_1_annotation ->
      {
        context = Decode.required o "@context" Decode.string;
        type_ = Decode.required o "type" Decode.string;
        id = Decode.required o "id" Decode.string;
        motivation = Decode.required o "motivation" Decode.string;
        target = Decode.required o "target" entry_1_entry_1_annotation_target;
        created = Decode.required o "created" Decode.string;
      })

type entry_1_entry_1_target = { source : string }

let entry_1_entry_1_target =
  Decode.obj (fun o : entry_1_entry_1_target ->
      { source = Decode.required o "source" Decode.string })

type entry_1_entry_1 = {
  context : string option;
  id : string option;
  name : string option;
  representations : Decode.nothing list option;
  annotations : entry_1_entry_1_annotation list option;
  total : int option;
  type_ : string option;
  dollar_id : string option;
  motivation : string option;
  target : entry_1_entry_1_target option;
  created : string option;
}

let entry_1_entry_1 =
  Decode.obj (fun o : entry_1_entry_1 ->
      {
        context = Decode.optional o "@context" Decode.string;
        id = Decode.optional o "@id" Decode.string;
        name = Decode.optional o "name" Decode.string;
        representations =
          Decode.optional o "representations" (Decode.list Decode.nothing);
        annotations =
          Decode.optional o "annotations"
            (Decode.list entry_1_entry_1_annotation);
        total = Decode.optional o "total" Decode.int;
        type_ = Decode.optional o "type" Decode.string;
        dollar_id = Decode.optional o "id" Decode.string;
        motivation = Decode.optional o "motivation" Decode.string;
        target = Decode.optional o "target" entry_1_entry_1_target;
        created = Decode.optional o "created" Decode.string;
      })

type entry_1 = Array of entry_1_item list | Object of entry_1_entry_1

let entry_1 =
 fun c ->
  match Decode.kind c with
  | Decode.Array -> (Array (Decode.list entry_1_item c) : entry_1)
  | Decode.Object -> (Object (entry_1_entry_1 c) : entry_1)
  | _ -> Decode.refuse c "expected an array or an object"

type written = { version : int; entries : (string * entry_1) list }

let written =
  Decode.obj (fun o : written ->
      {
        version = Decode.required o "version" Decode.int;
        entries =
          Decode.required o "entries"
            (Decode.list (Decode.pair Decode.string entry_1));
      })

type write = {
  name : string;
  query : string;
  held : (string * held_item_1) list;
  written : written;
}

let write =
  Decode.obj (fun o : write ->
      {
        name = Decode.required o "name" Decode.string;
        query = Decode.required o "query" Decode.string;
        held =
          Decode.required o "held"
            (Decode.list (Decode.pair Decode.string held_item_1));
        written = Decode.required o "written" written;
      })

type refused_write_held_item_1_held_item_1 = {
  context : string;
  id : string;
  name : string;
  representations : Decode.nothing list;
}

let refused_write_held_item_1_held_item_1 =
  Decode.obj (fun o : refused_write_held_item_1_held_item_1 ->
      {
        context = Decode.required o "@context" Decode.string;
        id = Decode.required o "@id" Decode.string;
        name = Decode.required o "name" Decode.string;
        representations =
          Decode.required o "representations" (Decode.list Decode.nothing);
      })

type refused_write_held_item_1 =
  | Array of string list
  | Object of refused_write_held_item_1_held_item_1

let refused_write_held_item_1 =
 fun c ->
  match Decode.kind c with
  | Decode.Array ->
      (Array (Decode.list Decode.string c) : refused_write_held_item_1)
  | Decode.Object ->
      (Object (refused_write_held_item_1_held_item_1 c)
        : refused_write_held_item_1)
  | _ -> Decode.refuse c "expected an array or an object"

type refused_write_written_entry_1_entry_1 = {
  context : string;
  id : string;
  name : string;
  representations : Decode.nothing list;
}

let refused_write_written_entry_1_entry_1 =
  Decode.obj (fun o : refused_write_written_entry_1_entry_1 ->
      {
        context = Decode.required o "@context" Decode.string;
        id = Decode.required o "@id" Decode.string;
        name = Decode.required o "name" Decode.string;
        representations =
          Decode.required o "representations" (Decode.list Decode.nothing);
      })

type refused_write_written_entry_1 =
  | Array of string list
  | Object of refused_write_written_entry_1_entry_1

let refused_write_written_entry_1 =
 fun c ->
  match Decode.kind c with
  | Decode.Array ->
      (Array (Decode.list Decode.string c) : refused_write_written_entry_1)
  | Decode.Object ->
      (Object (refused_write_written_entry_1_entry_1 c)
        : refused_write_written_entry_1)
  | _ -> Decode.refuse c "expected an array or an object"

type refused_write_written = {
  version : int;
  entries : (string * refused_write_written_entry_1) list;
}

let refused_write_written =
  Decode.obj (fun o : refused_write_written ->
      {
        version = Decode.required o "version" Decode.int;
        entries =
          Decode.required o "entries"
            (Decode.list
               (Decode.pair Decode.string refused_write_written_entry_1));
      })

type refused_write = {
  name : string;
  query : string;
  held : (string * refused_write_held_item_1) list;
  written : refused_write_written;
}

let refused_write =
  Decode.obj (fun o : refused_write ->
      {
        name = Decode.required o "name" Decode.string;
        query = Decode.required o "query" Decode.string;
        held =
          Decode.required o "held"
            (Decode.list (Decode.pair Decode.string refused_write_held_item_1));
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
  run_by : Case_table.run_by;
  not_yet_reached : Case_table.explanations;
  cases : case list;
  writes : write list;
  refused_writes : refused_write list;
  places : place list;
}

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        run_by = Decode.required o "runBy" Case_table.run_by;
        not_yet_reached =
          Decode.required o "notYetReached" Case_table.explanations;
        cases = Decode.required o "cases" (Decode.list case);
        writes = Decode.required o "writes" (Decode.list write);
        refused_writes =
          Decode.required o "refusedWrites" (Decode.list refused_write);
        places = Decode.required o "places" (Decode.list place);
      })
