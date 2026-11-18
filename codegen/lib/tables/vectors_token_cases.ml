(* specs/src/vectors/token-cases.json *)

type smelter = { access : string }

let smelter =
  Decode.obj (fun o : smelter ->
      { access = Decode.required o "access" Decode.string })

type access_item = { collection : string; access : string }

let access_item =
  Decode.obj (fun o : access_item ->
      {
        collection = Decode.required o "collection" Decode.string;
        access = Decode.required o "access" Decode.string;
      })

type librarian = { access : access_item list }

let librarian =
  Decode.obj (fun o : librarian ->
      { access = Decode.required o "access" (Decode.list access_item) })

type claims = { smelter : smelter; librarian : librarian }

let claims =
  Decode.obj (fun o : claims ->
      {
        smelter = Decode.required o "smelter" smelter;
        librarian = Decode.required o "librarian" librarian;
      })

type case = { why : string; kb : string; claims : claims }

let case =
  Decode.obj (fun o : case ->
      {
        why = Decode.required o "why" Decode.string;
        kb = Decode.required o "kb" Decode.string;
        claims = Decode.required o "claims" claims;
      })

type t = { comment : string; cases : case list }

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        cases = Decode.required o "cases" (Decode.list case);
      })
