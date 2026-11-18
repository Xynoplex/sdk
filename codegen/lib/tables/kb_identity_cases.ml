(* specs/src/kb-identity/cases.json *)

type case = {
  why : string;
  dir : string;
  config : string option;
  refused : bool;
  name : string option;
  domain : string option;
  did : string option;
  resource : string option;
}

let case =
  Decode.obj (fun o : case ->
      {
        why = Decode.required o "why" Decode.string;
        dir = Decode.required o "dir" Decode.string;
        config = Decode.required o "config" (Decode.nullable Decode.string);
        refused = Decode.required o "refused" Decode.bool;
        name = Decode.required o "name" (Decode.nullable Decode.string);
        domain = Decode.required o "domain" (Decode.nullable Decode.string);
        did = Decode.required o "did" (Decode.nullable Decode.string);
        resource = Decode.required o "resource" (Decode.nullable Decode.string);
      })

type t = { comment : string; cases : case list }

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        cases = Decode.required o "cases" (Decode.list case);
      })
