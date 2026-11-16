(* specs/src/client/discovery-absent.json *)

type reason = { reason : string; docs : string }

let reason =
  Decode.obj (fun o : reason ->
      {
        reason = Decode.required o "reason" Decode.string;
        docs = Decode.required o "docs" Decode.string;
      })

type t = { comment : string; reasons : reason list }

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        reasons = Decode.required o "reasons" (Decode.list reason);
      })
