(* specs/src/bus/frame-cases.json *)

type read = {
  message : string;
  details : string option;
  annotation_id : string option;
}

let read =
  Decode.obj (fun o : read ->
      {
        message = Decode.required o "message" Decode.string;
        details = Decode.optional o "details" Decode.string;
        annotation_id = Decode.optional o "annotationId" Decode.string;
      })

type case = {
  why : string;
  frame : Yojson.Safe.t option;
  refused : bool option;
  member : string option;
  reason : string option;
  told : string option;
  data : string option;
  correlation_id : string option;
  request : string option;
  read : read option;
}

let case =
  Decode.obj (fun o : case ->
      {
        why = Decode.required o "why" Decode.string;
        frame = Decode.optional o "frame" Decode.json;
        refused = Decode.optional o "refused" Decode.bool;
        member = Decode.optional o "member" Decode.string;
        reason = Decode.optional o "reason" Decode.string;
        told = Decode.optional o "told" Decode.string;
        data = Decode.optional o "data" Decode.string;
        correlation_id = Decode.optional o "correlationId" Decode.string;
        request = Decode.optional o "request" Decode.string;
        read = Decode.optional o "read" read;
      })

type t = { comment : string; cases : case list }

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        cases = Decode.required o "cases" (Decode.list case);
      })
