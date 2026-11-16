(* specs/src/text/offset-cases.json *)

type span = { exact : string; occurrence : int; start : int; end_ : int }

let span =
  Decode.obj (fun o : span ->
      {
        exact = Decode.required o "exact" Decode.string;
        occurrence = Decode.required o "occurrence" Decode.int;
        start = Decode.required o "start" Decode.int;
        end_ = Decode.required o "end" Decode.int;
      })

type case = {
  why : string;
  text : string;
  code_points : int;
  spans : span list;
}

let case =
  Decode.obj (fun o : case ->
      {
        why = Decode.required o "why" Decode.string;
        text = Decode.required o "text" Decode.string;
        code_points = Decode.required o "codePoints" Decode.int;
        spans = Decode.required o "spans" (Decode.list span);
      })

type t = { comment : string; run_by : Case_table.run_by; cases : case list }

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        run_by = Decode.required o "runBy" Case_table.run_by;
        cases = Decode.required o "cases" (Decode.list case);
      })
