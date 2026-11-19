(* The Encoding Standard as the readers of a resource's text that have no
   decoder of their own read it: the encoding each label names, the 256
   characters of each single-byte encoding, and the encodings whose labels
   are refused. *)

let file = "text/encoding-cases.json"

module T = Tables.Text_encoding_cases

(* What every case states alike: the encoding and its labels. *)
let encoding : T.cases_item -> string = function
  | Every_byte { encoding; _ } | Bytes { encoding; _ } | Refused { encoding; _ }
    ->
      encoding

let labels : T.cases_item -> string list = function
  | Every_byte { labels; _ } | Bytes { labels; _ } | Refused { labels; _ } ->
      labels

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
    (fun i (c : Tables.Text_encoding_cases.cases_item) ->
      let at = Printf.sprintf "/cases/%d" i in
      if not (List.mem (encoding c) (labels c)) then
        refuse (at ^ "/labels") ("lacks the case's own encoding, " ^ encoding c);
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
          | None -> Hashtbl.replace named label (encoding c, i))
        (labels c);
      match c with
      | Every_byte { every_byte; _ } ->
          let n = Text.length every_byte in
          if n <> 256 then
            refuse (at ^ "/everyByte")
              (Printf.sprintf "states %d characters, not 256" n)
      | Bytes _ | Refused _ -> ())
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
              (fun (c : Tables.Text_encoding_cases.cases_item) ->
                match c with
                | Every_byte { every_byte; _ } -> Some (encoding c, every_byte)
                | Bytes _ | Refused _ -> None)
              table.cases;
          refused =
            List.sort compare
              (List.filter_map
                 (fun (c : Tables.Text_encoding_cases.cases_item) ->
                   match c with
                   | Refused _ -> Some (encoding c)
                   | Bytes _ | Every_byte _ -> None)
                 table.cases);
          decoded =
            List.filter_map
              (fun (c : Tables.Text_encoding_cases.cases_item) ->
                match c with
                | Bytes _ -> Some (encoding c)
                | Every_byte _ | Refused _ -> None)
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
