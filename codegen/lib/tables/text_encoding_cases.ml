(* specs/src/text/encoding-cases.json *)

(* What a case states of its encoding: the text some bytes decode to, the 256
   characters of a single-byte encoding, or that its labels are refused. *)
type kind =
  | Decoded of { bytes : string; text : string }
  | Single_byte of { every_byte : string }
  | Refused

type case = { encoding : string; labels : string list; kind : kind }

let kind o =
  let cursor = Decode.at o in
  if Decode.has_member "everyByte" cursor then
    Single_byte { every_byte = Decode.required o "everyByte" Decode.string }
  else if Decode.has_member "refused" cursor then (
    Decode.required o "refused" (fun cursor ->
        if not (Decode.bool cursor) then
          Decode.refuse cursor "a flag is true, or absent");
    Refused)
  else if Decode.has_member "bytes" cursor then
    let bytes = Decode.required o "bytes" Decode.string in
    let text = Decode.required o "text" Decode.string in
    Decoded { bytes; text }
  else
    Decode.refuse cursor
      "is a case of no kind: it states bytes and their text, everyByte, or \
       refused"

let case =
  Decode.obj (fun o : case ->
      let encoding = Decode.required o "encoding" Decode.string in
      let labels = Decode.required o "labels" (Decode.list Decode.string) in
      let kind = kind o in
      { encoding; labels; kind })

type t = { comment : string; cases : case list }

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        cases = Decode.required o "cases" (Decode.list case);
      })
