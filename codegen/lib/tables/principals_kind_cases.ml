(* specs/src/principals/kind-cases.json *)

type case = { why : string; did : string; kind : string }

let case =
  Decode.obj (fun o : case ->
      {
        why = Decode.required o "why" Decode.string;
        did = Decode.required o "did" Decode.string;
        kind = Decode.required o "kind" Decode.string;
      })

type t = {
  comment : string;
  run_by : Case_table.run_by;
  absent : Case_table.explanations;
  cases : case list;
}

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        run_by = Decode.required o "runBy" Case_table.run_by;
        absent = Decode.required o "absent" Case_table.explanations;
        cases = Decode.required o "cases" (Decode.list case);
      })
