(* specs/src/jobs/retry-cases.json *)

type case = {
  why : string;
  retry_count : int;
  max_retries : int;
  failure_class : string option;
  retries : bool;
}

let case =
  Decode.obj (fun o : case ->
      {
        why = Decode.required o "why" Decode.string;
        retry_count = Decode.required o "retryCount" Decode.int;
        max_retries = Decode.required o "maxRetries" Decode.int;
        failure_class = Decode.optional o "failureClass" Decode.string;
        retries = Decode.required o "retries" Decode.bool;
      })

type t = { comment : string; cases : case list }

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        cases = Decode.required o "cases" (Decode.list case);
      })
