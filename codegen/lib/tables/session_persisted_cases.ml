(* specs/src/session/persisted-cases.json *)

type jo = { did : string; person_key : string }

let jo =
  Decode.obj (fun o : jo ->
      {
        did = Decode.required o "did" Decode.string;
        person_key = Decode.required o "personKey" Decode.string;
      })

type ann = { did : string; person_key : string }

let ann =
  Decode.obj (fun o : ann ->
      {
        did = Decode.required o "did" Decode.string;
        person_key = Decode.required o "personKey" Decode.string;
      })

type people = { jo : jo; ann : ann }

let people =
  Decode.obj (fun o : people ->
      { jo = Decode.required o "jo" jo; ann = Decode.required o "ann" ann })

type cache_keys = {
  resource : string;
  annotations : string;
  annotation : string;
  entity_types : string;
  tag_schemas : string;
}

let cache_keys =
  Decode.obj (fun o : cache_keys ->
      {
        resource = Decode.required o "resource" Decode.string;
        annotations = Decode.required o "annotations" Decode.string;
        annotation = Decode.required o "annotation" Decode.string;
        entity_types = Decode.required o "entityTypes" Decode.string;
        tag_schemas = Decode.required o "tagSchemas" Decode.string;
      })

type key = {
  why : string;
  kb_id : string;
  did : string;
  person_key : string;
  last_event_id_key : string;
  cache_keys : cache_keys;
}

let key =
  Decode.obj (fun o : key ->
      {
        why = Decode.required o "why" Decode.string;
        kb_id = Decode.required o "kbId" Decode.string;
        did = Decode.required o "did" Decode.string;
        person_key = Decode.required o "personKey" Decode.string;
        last_event_id_key = Decode.required o "lastEventIdKey" Decode.string;
        cache_keys = Decode.required o "cacheKeys" cache_keys;
      })

type forget_item = {
  why : string;
  by : string;
  signed_in : string;
  open_ : bool;
  removes : string;
  stored : string option;
}

let forget_item =
  Decode.obj (fun o : forget_item ->
      {
        why = Decode.required o "why" Decode.string;
        by = Decode.required o "by" Decode.string;
        signed_in = Decode.required o "signedIn" Decode.string;
        open_ = Decode.required o "open" Decode.bool;
        removes = Decode.required o "removes" Decode.string;
        stored = Decode.optional o "stored" Decode.string;
      })

type who_am_i = {
  did : string;
  email : string;
  name : string;
  image : unit;
  domain : string;
}

let who_am_i =
  Decode.obj (fun o : who_am_i ->
      {
        did = Decode.required o "did" Decode.string;
        email = Decode.required o "email" Decode.string;
        name = Decode.required o "name" Decode.string;
        image = Decode.required o "image" Decode.null;
        domain = Decode.required o "domain" Decode.string;
      })

type startup_item = {
  why : string;
  signed_in : string;
  gateway : string;
  first : string;
  then_ : string;
  recorded : string option;
  place : string option;
  untouched : bool option;
}

let startup_item =
  Decode.obj (fun o : startup_item ->
      {
        why = Decode.required o "why" Decode.string;
        signed_in = Decode.required o "signedIn" Decode.string;
        gateway = Decode.required o "gateway" Decode.string;
        first = Decode.required o "first" Decode.string;
        then_ = Decode.required o "then" Decode.string;
        recorded = Decode.required o "recorded" (Decode.nullable Decode.string);
        place = Decode.required o "place" (Decode.nullable Decode.string);
        untouched = Decode.optional o "untouched" Decode.bool;
      })

type stored = { person_key : string option }

let stored =
  Decode.obj (fun o : stored ->
      {
        person_key =
          Decode.required o "personKey" (Decode.nullable Decode.string);
      })

type cross_tab_item = { why : string; stored : stored option; saved : bool }

let cross_tab_item =
  Decode.obj (fun o : cross_tab_item ->
      {
        why = Decode.required o "why" Decode.string;
        stored = Decode.required o "stored" (Decode.nullable stored);
        saved = Decode.required o "saved" Decode.bool;
      })

type in_process_item_stored = { person_key : string option }

let in_process_item_stored =
  Decode.obj (fun o : in_process_item_stored ->
      {
        person_key =
          Decode.required o "personKey" (Decode.nullable Decode.string);
      })

type in_process_item = {
  why : string;
  stored : in_process_item_stored option;
  saved : bool;
}

let in_process_item =
  Decode.obj (fun o : in_process_item ->
      {
        why = Decode.required o "why" Decode.string;
        stored =
          Decode.required o "stored" (Decode.nullable in_process_item_stored);
        saved = Decode.required o "saved" Decode.bool;
      })

type resume_from_item = {
  why : string;
  frames : string list;
  resumes : string option;
}

let resume_from_item =
  Decode.obj (fun o : resume_from_item ->
      {
        why = Decode.required o "why" Decode.string;
        frames = Decode.required o "frames" (Decode.list Decode.string);
        resumes = Decode.required o "resumes" (Decode.nullable Decode.string);
      })

type t = {
  comment : string;
  people : people;
  keys : key list;
  forget_storage : (string * string) list;
  forget : forget_item list;
  who_am_i : who_am_i;
  startup_storage : (string * string) list;
  startup : startup_item list;
  cross_tab : cross_tab_item list;
  in_process : in_process_item list;
  resume_from : resume_from_item list;
}

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        people = Decode.required o "people" people;
        keys = Decode.required o "keys" (Decode.list key);
        forget_storage =
          Decode.required o "forgetStorage" (Decode.map Decode.string);
        forget = Decode.required o "forget" (Decode.list forget_item);
        who_am_i = Decode.required o "whoAmI" who_am_i;
        startup_storage =
          Decode.required o "startupStorage" (Decode.map Decode.string);
        startup = Decode.required o "startup" (Decode.list startup_item);
        cross_tab = Decode.required o "crossTab" (Decode.list cross_tab_item);
        in_process = Decode.required o "inProcess" (Decode.list in_process_item);
        resume_from =
          Decode.required o "resumeFrom" (Decode.list resume_from_item);
      })
