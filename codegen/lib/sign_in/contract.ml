(* What the sign-in store's contract (sign-in-store/README.md) names in its
   prose: the document's name in the state home, its lock's, and the high
   word of the offset of the byte a Windows writer locks. The C# SDK's
   generator reads the same three. Each must be named one way only. *)

let file = "sign-in-store/README.md"

(* [offset_high] is in hexadecimal digits. *)
type t = { document : string; lock : string; offset_high : string }

(* Where each [prefix] in [text] ends. *)
let ends ~prefix text =
  let n = String.length prefix and length = String.length text in
  let rec go i found =
    if i > length - n then List.rev found
    else if String.sub text i n = prefix then go (i + n) ((i + n) :: found)
    else go (i + 1) found
  in
  go 0 []

(* The run of [allowed] characters in [text] from [i], and where it ends. *)
let run allowed text i =
  let j = ref i in
  while !j < String.length text && allowed text.[!j] do
    incr j
  done;
  (String.sub text i (!j - i), !j)

let starts_at ~prefix text i =
  i + String.length prefix <= String.length text
  && String.sub text i (String.length prefix) = prefix

let read ~root =
  let text =
    In_channel.with_open_bin
      (Filename.concat root ("protocol/specs/src/" ^ file))
      In_channel.input_all
  in
  let refusals = ref [] in
  let one what candidates =
    match List.sort_uniq compare candidates with
    | [ value ] -> value
    | distinct ->
        refusals :=
          {
            Decode.file;
            pointer = "";
            message =
              Printf.sprintf "names %s %s" what
                (if distinct = [] then "nowhere"
                 else "more than one way: " ^ String.concat ", " distinct);
          }
          :: !refusals;
        ""
  in
  (* <stateDir>/name.json, the name lowercase letters and hyphens. *)
  let in_state_home suffix =
    List.filter_map
      (fun i ->
        let name, j =
          run (function 'a' .. 'z' | '-' -> true | _ -> false) text i
        in
        if name <> "" && starts_at ~prefix:suffix text j then
          Some (name ^ suffix)
        else None)
      (ends ~prefix:"<stateDir>/" text)
  in
  (* OffsetHigh: 0x…, in hex digits. *)
  let offsets =
    List.filter_map
      (fun i ->
        let _, j =
          run (function ' ' | '\t' | '\n' | '\r' -> true | _ -> false) text i
        in
        if starts_at ~prefix:"0x" text j then
          let digits, _ = run Text.is_hex_digit text (j + 2) in
          if digits = "" then None else Some digits
        else None)
      (ends ~prefix:"OffsetHigh:" text)
  in
  let document = one "the document" (in_state_home ".json") in
  let lock = one "the lock" (in_state_home ".lock") in
  let offset_high = one "the Windows lock's offset" offsets in
  (* A writer locks one byte, as a native binding is told. *)
  if ends ~prefix:"on one byte of the lock file" text = [] then
    refusals :=
      {
        Decode.file;
        pointer = "";
        message = "no longer says the lock is on one byte of the lock file";
      }
      :: !refusals;
  match List.rev !refusals with
  | [] -> Ok { document; lock; offset_high }
  | errors -> Error errors
