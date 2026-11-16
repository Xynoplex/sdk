(* specs/src/annotations/id-cases.json *)

type case = {
  why : string;
  resource_id : string;
  motivation : string;
  anchor : string;
  id : string;
  body : Yojson.Safe.t option;
}

let case =
  Decode.obj (fun o : case ->
      {
        why = Decode.required o "why" Decode.string;
        resource_id = Decode.required o "resourceId" Decode.string;
        motivation = Decode.required o "motivation" Decode.string;
        anchor = Decode.required o "anchor" Decode.string;
        id = Decode.required o "id" Decode.string;
        body = Decode.optional o "body" Decode.json;
      })

type t = { comment : string; run_by : Case_table.run_by; cases : case list }

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        run_by = Decode.required o "runBy" Case_table.run_by;
        cases = Decode.required o "cases" (Decode.list case);
      })
