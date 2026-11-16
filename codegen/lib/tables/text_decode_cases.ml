(* specs/src/text/decode-cases.json *)

type case = {
  why : string;
  content_type : string;
  bytes : string;
  text : string option;
  refused : string option;
}

let case =
  Decode.obj (fun o : case ->
      {
        why = Decode.required o "why" Decode.string;
        content_type = Decode.required o "contentType" Decode.string;
        bytes = Decode.required o "bytes" Decode.string;
        text = Decode.optional o "text" Decode.string;
        refused = Decode.optional o "refused" Decode.string;
      })

type t = { comment : string; run_by : Case_table.run_by; cases : case list }

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        run_by = Decode.required o "runBy" Case_table.run_by;
        cases = Decode.required o "cases" (Decode.list case);
      })
