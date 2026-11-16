(* specs/src/archivist/shard-cases.json *)

type case = { why : string; key : string; shard : string }

let case =
  Decode.obj (fun o : case ->
      {
        why = Decode.required o "why" Decode.string;
        key = Decode.required o "key" Decode.string;
        shard = Decode.required o "shard" Decode.string;
      })

type t = { comment : string; run_by : Case_table.run_by; cases : case list }

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        run_by = Decode.required o "runBy" Case_table.run_by;
        cases = Decode.required o "cases" (Decode.list case);
      })
