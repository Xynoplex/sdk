(* specs/src/principals/naming-cases.json *)

type profile = { name : string; since : string }

let profile =
  Decode.obj (fun o : profile ->
      {
        name = Decode.required o "name" Decode.string;
        since = Decode.required o "since" Decode.string;
      })

type case = {
  why : string;
  reply : Yojson.Safe.t;
  profiles : (string * profile) list;
  named : Yojson.Safe.t;
}

let case =
  Decode.obj (fun o : case ->
      {
        why = Decode.required o "why" Decode.string;
        reply = Decode.required o "reply" Decode.json;
        profiles = Decode.required o "profiles" (Decode.map profile);
        named = Decode.required o "named" Decode.json;
      })

type t = { comment : string; run_by : Case_table.run_by; cases : case list }

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        run_by = Decode.required o "runBy" Case_table.run_by;
        cases = Decode.required o "cases" (Decode.list case);
      })
