(* specs/src/worker/failure-class-cases.json *)

type status = Int of int | String of string

let status =
 fun c ->
  match Decode.kind c with
  | Decode.Int -> (Int (Decode.int c) : status)
  | Decode.String -> (String (Decode.string c) : status)
  | _ -> Decode.refuse c "expected an integer or a string"

type failure_failure = {
  name : string option;
  stop_reason : string option;
  aborted : bool option;
  status : status option;
}

let failure_failure =
  Decode.obj (fun o : failure_failure ->
      {
        name = Decode.optional o "name" Decode.string;
        stop_reason = Decode.optional o "stopReason" Decode.string;
        aborted = Decode.optional o "aborted" Decode.bool;
        status = Decode.optional o "status" status;
      })

type failure = String of string | Object of failure_failure

let failure =
 fun c ->
  match Decode.kind c with
  | Decode.String -> (String (Decode.string c) : failure)
  | Decode.Object -> (Object (failure_failure c) : failure)
  | _ -> Decode.refuse c "expected a string or an object"

type case = {
  why : string;
  failure : failure option;
  failure_class : string option;
}

let case =
  Decode.obj (fun o : case ->
      {
        why = Decode.required o "why" Decode.string;
        failure = Decode.required o "failure" (Decode.nullable failure);
        failure_class =
          Decode.required o "failureClass" (Decode.nullable Decode.string);
      })

type t = { comment : string; cases : case list }

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        cases = Decode.required o "cases" (Decode.list case);
      })
