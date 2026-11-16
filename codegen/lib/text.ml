(* Text as the generated files measure and spell it. The files were first
   written by JavaScript, so a width is in UTF-16 code units, a string literal
   is JSON's, and a word ends at what JavaScript's \s matches. *)

let fold_uchars f init text =
  let rec go acc i =
    if i >= String.length text then acc
    else
      let decoded = String.get_utf_8_uchar text i in
      go
        (f acc (Uchar.utf_decode_uchar decoded))
        (i + Uchar.utf_decode_length decoded)
  in
  go init 0

let length text =
  fold_uchars (fun n u -> n + if Uchar.to_int u >= 0x10000 then 2 else 1) 0 text

(* [head] padded with spaces out to column [col]; a head that reaches it gets a
   single space. *)
let pad head col =
  let n = length head in
  head ^ if n < col then String.make (col - n) ' ' else " "

let is_space u =
  match Uchar.to_int u with
  | 0x09 | 0x0A | 0x0B | 0x0C | 0x0D | 0x20 | 0xA0 | 0x1680 | 0x2028 | 0x2029
  | 0x202F | 0x205F | 0x3000 | 0xFEFF ->
      true
  | c -> c >= 0x2000 && c <= 0x200A

let words text =
  let word = Buffer.create 16 in
  let flush acc =
    if Buffer.length word = 0 then acc
    else
      let w = Buffer.contents word in
      Buffer.clear word;
      w :: acc
  in
  List.rev
    (flush
       (fold_uchars
          (fun acc u ->
            if is_space u then flush acc
            else (
              Buffer.add_utf_8_uchar word u;
              acc))
          [] text))

(* [text] as comment lines behind [indent ^ marker], each as many words as fit
   within [width]. A word longer than the width has a line of its own. *)
let comment ~marker ~indent ~width text =
  let lead = indent ^ marker in
  let lines, last =
    List.fold_left
      (fun (lines, line) word ->
        if line <> "" && length (lead ^ line ^ " " ^ word) > width then
          (line :: lines, word)
        else (lines, if line = "" then word else line ^ " " ^ word))
      ([], "") (words text)
  in
  let lines = List.rev (if last = "" then lines else last :: lines) in
  String.concat "\n" (List.map (fun line -> lead ^ line) lines)

let replace_all ~sub ~by text =
  let n = String.length sub and length = String.length text in
  let out = Buffer.create length in
  let rec go i =
    if i > length - n then
      Buffer.add_string out (String.sub text i (length - i))
    else if String.sub text i n = sub then (
      Buffer.add_string out by;
      go (i + n))
    else (
      Buffer.add_char out text.[i];
      go (i + 1))
  in
  go 0;
  Buffer.contents out

(* A string as JSON writes it: quoted, with a quote, a backslash and the
   control characters escaped, and every other character as itself. *)
let quoted text =
  let out = Buffer.create (String.length text + 2) in
  Buffer.add_char out '"';
  String.iter
    (function
      | '"' -> Buffer.add_string out "\\\""
      | '\\' -> Buffer.add_string out "\\\\"
      | '\b' -> Buffer.add_string out "\\b"
      | '\012' -> Buffer.add_string out "\\f"
      | '\n' -> Buffer.add_string out "\\n"
      | '\r' -> Buffer.add_string out "\\r"
      | '\t' -> Buffer.add_string out "\\t"
      | c when Char.code c < 0x20 ->
          Buffer.add_string out (Printf.sprintf "\\u%04x" (Char.code c))
      | c -> Buffer.add_char out c)
    text;
  Buffer.add_char out '"';
  Buffer.contents out

(* A JSON value as JavaScript's JSON.stringify(value, null, 2) writes it, and
   a trailing newline: the form a hand-authored file of Protocol is kept in.
   A number with a fraction or beyond an int is refused: JavaScript would spell
   it in a way this does not reproduce. *)
let rec json indent (value : Yojson.Safe.t) =
  let inner = indent ^ "  " in
  let block opening closing items =
    match items with
    | [] -> Ok (opening ^ closing)
    | _ ->
        Result.map
          (fun items ->
            opening ^ "\n" ^ inner
            ^ String.concat (",\n" ^ inner) items
            ^ "\n" ^ indent ^ closing)
          (List.fold_right
             (fun item rest ->
               Result.bind item (fun item ->
                   Result.map (fun rest -> item :: rest) rest))
             items (Ok []))
  in
  match value with
  | `Null -> Ok "null"
  | `Bool b -> Ok (string_of_bool b)
  | `Int n -> Ok (string_of_int n)
  | `String s -> Ok (quoted s)
  | `Intlit _ | `Float _ -> Error "a number that is not an int"
  | `List items -> block "[" "]" (List.map (json inner) items)
  | `Assoc members ->
      block "{" "}"
        (List.map
           (fun (name, value) ->
             Result.map
               (fun value -> quoted name ^ ": " ^ value)
               (json inner value))
           members)

let stringified value = Result.map (fun text -> text ^ "\n") (json "" value)
