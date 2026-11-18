(* specs/src/bus/log-cases.json *)

type case = {
  why : string;
  channel : string option;
  payload : Yojson.Safe.t;
  shown : Yojson.Safe.t;
}

let case =
  Decode.obj (fun o : case ->
      {
        why = Decode.required o "why" Decode.string;
        channel = Decode.optional o "channel" Decode.string;
        payload = Decode.required o "payload" Decode.json;
        shown = Decode.required o "shown" Decode.json;
      })

type t = { comment : string; names : string list; cases : case list }

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        names = Decode.required o "names" (Decode.list Decode.string);
        cases = Decode.required o "cases" (Decode.list case);
      })
