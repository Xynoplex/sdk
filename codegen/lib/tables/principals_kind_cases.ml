(* specs/src/principals/kind-cases.json *)

type case = { why : string; did : string; kind : string }

let case =
  Decode.obj (fun o : case ->
      {
        why = Decode.required o "why" Decode.string;
        did = Decode.required o "did" Decode.string;
        kind = Decode.required o "kind" Decode.string;
      })

type t = { comment : string; cases : case list }

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        cases = Decode.required o "cases" (Decode.list case);
      })
