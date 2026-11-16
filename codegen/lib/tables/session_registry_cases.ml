(* specs/src/session/registry-cases.json *)

type one_http = { host : string; port : int; protocol : string }

let one_http =
  Decode.obj (fun o : one_http ->
      Decode.required o "kind" (Decode.literal "http");
      {
        host = Decode.required o "host" Decode.string;
        port = Decode.required o "port" Decode.int;
        protocol = Decode.required o "protocol" Decode.string;
      })

type one_local = { kb_id : string }

let one_local =
  Decode.obj (fun o : one_local ->
      Decode.required o "kind" (Decode.literal "local");
      { kb_id = Decode.required o "kbId" Decode.string })

type one = Http of one_http | Local of one_local

let one =
  Decode.variant "kind"
    [
      ("http", fun c -> (Http (one_http c) : one));
      ("local", fun c -> (Local (one_local c) : one));
    ]

type other_http = { host : string; port : int; protocol : string }

let other_http =
  Decode.obj (fun o : other_http ->
      Decode.required o "kind" (Decode.literal "http");
      {
        host = Decode.required o "host" Decode.string;
        port = Decode.required o "port" Decode.int;
        protocol = Decode.required o "protocol" Decode.string;
      })

type other_local = { kb_id : string }

let other_local =
  Decode.obj (fun o : other_local ->
      Decode.required o "kind" (Decode.literal "local");
      { kb_id = Decode.required o "kbId" Decode.string })

type other = Http of other_http | Local of other_local

let other =
  Decode.variant "kind"
    [
      ("http", fun c -> (Http (other_http c) : other));
      ("local", fun c -> (Local (other_local c) : other));
    ]

type case = { why : string; one : one; other : other; same_place : bool }

let case =
  Decode.obj (fun o : case ->
      {
        why = Decode.required o "why" Decode.string;
        one = Decode.required o "one" one;
        other = Decode.required o "other" other;
        same_place = Decode.required o "samePlace" Decode.bool;
      })

type open_item = {
  id : string;
  name : string;
  opened_at : int;
  order : int;
  media_type : string option;
  storage_uri : string option;
}

let open_item =
  Decode.obj (fun o : open_item ->
      {
        id = Decode.required o "id" Decode.string;
        name = Decode.required o "name" Decode.string;
        opened_at = Decode.required o "openedAt" Decode.int;
        order = Decode.required o "order" Decode.int;
        media_type = Decode.optional o "mediaType" Decode.string;
        storage_uri = Decode.optional o "storageUri" Decode.string;
      })

type open_resource_order_item = {
  why : string;
  open_ : open_item list;
  shown : string list;
}

let open_resource_order_item =
  Decode.obj (fun o : open_resource_order_item ->
      {
        why = Decode.required o "why" Decode.string;
        open_ = Decode.required o "open" (Decode.list open_item);
        shown = Decode.required o "shown" (Decode.list Decode.string);
      })

type t = {
  comment : string;
  run_by : Case_table.run_by;
  cases : case list;
  open_resource_order : open_resource_order_item list;
}

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        run_by = Decode.required o "runBy" Case_table.run_by;
        cases = Decode.required o "cases" (Decode.list case);
        open_resource_order =
          Decode.required o "openResourceOrder"
            (Decode.list open_resource_order_item);
      })
