(* The Encoding Standard as the readers of a resource's text that have no
   decoder of their own read it: the encoding each label names, the 256
   characters of each single-byte encoding, and the encodings whose labels
   are refused. *)

let file = "text/encoding-cases.json"

type t = {
  labels : (string * string) list;
      (** Each label and the encoding it names, by label. *)
  single_byte : (string * string) list;
      (** Each single-byte encoding and its 256 characters, the one at [n] the
          byte [n]'s, in the table's order. *)
  refused : string list;
      (** The encodings whose labels are refused, by name. *)
  decoded : string list;
      (** The encodings no table here decodes, in the table's order. *)
}

(* The white space a reader takes from around a label before it matches it:
   ASCII's (go/resources.go, python/sdk/src/xynolog/resources.py). *)
let is_white_space = function
  | '\t' | '\n' | '\012' | '\r' | ' ' -> true
  | _ -> false

(* Whether a reader can match the label: it lower-cases what is stated and
   takes the white space from around it, so a label in upper case, or with
   white space around it, is matched by none. *)
let matched label =
  label <> ""
  && String.lowercase_ascii label = label
  && (not (is_white_space label.[0]))
  && not (is_white_space label.[String.length label - 1])

let derive (table : Tables.Text_encoding_cases.t) =
  let refusals = ref [] in
  let refuse pointer message =
    refusals := { Decode.file; pointer; message } :: !refusals
  in
  let named = Hashtbl.create 256 in
  List.iteri
    (fun i (c : Tables.Text_encoding_cases.case) ->
      let at = Printf.sprintf "/cases/%d" i in
      if not (List.mem c.encoding c.labels) then
        refuse (at ^ "/labels") ("lacks the case's own encoding, " ^ c.encoding);
      List.iteri
        (fun j label ->
          let at = Printf.sprintf "%s/labels/%d" at j in
          if not (matched label) then
            refuse at
              "is matched by no reader: a label is in lower case, with no \
               white space around it";
          match Hashtbl.find_opt named label with
          | Some (encoding, case) ->
              refuse at
                (Printf.sprintf "is a label of %s (/cases/%d) already" encoding
                   case)
          | None -> Hashtbl.replace named label (c.encoding, i))
        c.labels;
      match c.kind with
      | Single_byte { every_byte } ->
          let n = Text.length every_byte in
          if n <> 256 then
            refuse (at ^ "/everyByte")
              (Printf.sprintf "states %d characters, not 256" n)
      | Decoded _ | Refused -> ())
    table.cases;
  match List.rev !refusals with
  | [] ->
      Ok
        {
          labels =
            List.sort compare
              (Hashtbl.fold
                 (fun label (encoding, _) labels -> (label, encoding) :: labels)
                 named []);
          single_byte =
            List.filter_map
              (fun (c : Tables.Text_encoding_cases.case) ->
                match c.kind with
                | Single_byte { every_byte } -> Some (c.encoding, every_byte)
                | Decoded _ | Refused -> None)
              table.cases;
          refused =
            List.sort compare
              (List.filter_map
                 (fun (c : Tables.Text_encoding_cases.case) ->
                   match c.kind with
                   | Refused -> Some c.encoding
                   | Decoded _ | Single_byte _ -> None)
                 table.cases);
          decoded =
            List.filter_map
              (fun (c : Tables.Text_encoding_cases.case) ->
                match c.kind with
                | Decoded _ -> Some c.encoding
                | Single_byte _ | Refused -> None)
              table.cases;
        }
  | refusals -> Error refusals

(* The sentence that names the encodings no table here decodes, the tables
   of the other two named as [single_byte] and [refused]; none where there
   are none. *)
let undecoded t ~single_byte ~refused =
  match List.rev t.decoded with
  | [] -> ""
  | last :: rest ->
      Printf.sprintf
        " An encoding that is neither in %s nor in %s is %s, which no table \
         here decodes."
        single_byte refused
        (match rest with
        | [] -> last
        | _ -> String.concat ", " (List.rev rest) ^ " or " ^ last)
