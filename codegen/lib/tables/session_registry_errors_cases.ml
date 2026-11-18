(* specs/src/session/registry-errors-cases.json *)

type said_item = {
  own : string option;
  transport : string option;
  message : string option;
}

let said_item =
  Decode.obj (fun o : said_item ->
      {
        own = Decode.optional o "own" Decode.string;
        transport = Decode.optional o "transport" Decode.string;
        message = Decode.optional o "message" Decode.string;
      })

type case = {
  why : string;
  while_ : string;
  said : said_item list;
  registry_errors : string list;
  permission_denied : string option;
}

let case =
  Decode.obj (fun o : case ->
      {
        why = Decode.required o "why" Decode.string;
        while_ = Decode.required o "while" Decode.string;
        said = Decode.required o "said" (Decode.list said_item);
        registry_errors =
          Decode.required o "registryErrors" (Decode.list Decode.string);
        permission_denied = Decode.optional o "permissionDenied" Decode.string;
      })

type closing_item = { why : string; owed : bool; registry_errors : string list }

let closing_item =
  Decode.obj (fun o : closing_item ->
      {
        why = Decode.required o "why" Decode.string;
        owed = Decode.required o "owed" Decode.bool;
        registry_errors =
          Decode.required o "registryErrors" (Decode.list Decode.string);
      })

type t = { comment : string; cases : case list; closing : closing_item list }

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        cases = Decode.required o "cases" (Decode.list case);
        closing = Decode.required o "closing" (Decode.list closing_item);
      })
