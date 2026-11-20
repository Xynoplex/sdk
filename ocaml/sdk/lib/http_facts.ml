(* Generated from error codes. Do not edit.
   Regenerate: make generate (codegen/lib/ocaml_sdk/http_facts.ml) *)

let status_code = function
  | 401 -> "unauthorized"
  | 403 -> "forbidden"
  | 404 -> "not-found"
  | 409 -> "conflict"
  | 400 -> "bad-request"
  | 422 -> "unprocessable"
  | 429 -> "rate-limited"
  | status when status >= 500 -> "unavailable"
  | _ -> "error"

module Failure_code = struct
  type t = Not_found | Peer_unavailable | Unauthorized | None_pending

  let of_wire = function
    | "not-found" -> Not_found
    | "peer-unavailable" -> Peer_unavailable
    | "unauthorized" -> Unauthorized
    | "none-pending" -> None_pending
    | code ->
        invalid_arg
          ("a failure's code \"" ^ code
         ^ "\" is none of CommandError's: the reader leaves such a code out")
end

let bus_failure = function
  | None -> "bus.rejected"
  | Some Failure_code.Not_found -> "bus.not-found"
  | Some Failure_code.Peer_unavailable -> "bus.peer-unavailable"
  | Some Failure_code.Unauthorized -> "bus.unauthorized"
  | Some Failure_code.None_pending -> "bus.none-pending"
