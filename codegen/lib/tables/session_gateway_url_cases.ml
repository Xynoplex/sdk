(* specs/src/session/gateway-url-cases.json *)

type endpoint = { kind : string; host : string; port : int; protocol : string }

let endpoint =
  Decode.obj (fun o : endpoint ->
      {
        kind = Decode.required o "kind" Decode.string;
        host = Decode.required o "host" Decode.string;
        port = Decode.required o "port" Decode.int;
        protocol = Decode.required o "protocol" Decode.string;
      })

type case = { why : string; endpoint : endpoint; origin : string option }

let case =
  Decode.obj (fun o : case ->
      {
        why = Decode.required o "why" Decode.string;
        endpoint = Decode.required o "endpoint" endpoint;
        origin = Decode.required o "origin" (Decode.nullable Decode.string);
      })

type t = { comment : string; run_by : Case_table.run_by; cases : case list }

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        run_by = Decode.required o "runBy" Case_table.run_by;
        cases = Decode.required o "cases" (Decode.list case);
      })
