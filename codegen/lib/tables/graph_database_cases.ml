(* specs/src/graph/database-cases.json *)

type case = { why : string; kb : string; database : string }

let case =
  Decode.obj (fun o : case ->
      {
        why = Decode.required o "why" Decode.string;
        kb = Decode.required o "kb" Decode.string;
        database = Decode.required o "database" Decode.string;
      })

type t = { comment : string; cases : case list }

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        cases = Decode.required o "cases" (Decode.list case);
      })
