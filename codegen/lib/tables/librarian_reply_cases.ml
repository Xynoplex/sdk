(* specs/src/librarian/reply-cases.json *)

type score = { candidate : int; score : float }

let score =
  Decode.obj (fun o : score ->
      {
        candidate = Decode.required o "candidate" Decode.int;
        score = Decode.required o "score" Decode.number;
      })

type case = {
  why : string;
  reader : string;
  elements : Yojson.Safe.t;
  candidates : int option;
  scores : score list option;
  suggestions : string list option option;
}

let case =
  Decode.obj (fun o : case ->
      {
        why = Decode.required o "why" Decode.string;
        reader = Decode.required o "reader" Decode.string;
        elements = Decode.required o "elements" Decode.json;
        candidates = Decode.optional o "candidates" Decode.int;
        scores = Decode.optional o "scores" (Decode.list score);
        suggestions =
          Decode.optional o "suggestions"
            (Decode.nullable (Decode.list Decode.string));
      })

type t = { comment : string; cases : case list }

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        cases = Decode.required o "cases" (Decode.list case);
      })
