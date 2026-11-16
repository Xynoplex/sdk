(* specs/src/session/open-resource-cases.json *)

type case = {
  why : string;
  kb : string;
  open_ : string list;
  resources : (string * string) list;
  asked : string list;
  still_open : string list;
}

let case =
  Decode.obj (fun o : case ->
      {
        why = Decode.required o "why" Decode.string;
        kb = Decode.required o "kb" Decode.string;
        open_ = Decode.required o "open" (Decode.list Decode.string);
        resources = Decode.required o "resources" (Decode.map Decode.string);
        asked = Decode.required o "asked" (Decode.list Decode.string);
        still_open = Decode.required o "stillOpen" (Decode.list Decode.string);
      })

type t = {
  comment : string;
  run_by : Case_table.run_by;
  not_yet_reached : Case_table.explanations;
  cases : case list;
}

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        run_by = Decode.required o "runBy" Case_table.run_by;
        not_yet_reached =
          Decode.required o "notYetReached" Case_table.explanations;
        cases = Decode.required o "cases" (Decode.list case);
      })
