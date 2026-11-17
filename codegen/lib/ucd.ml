(* A property file of the Unicode Character Database (codegen/ucd), such as
   DerivedCoreProperties.txt, read strictly: its first line names it and its
   version, and every other line is blank, a comment, or a code point or a
   range of them, a property, an optional value and a comment. A property
   with a value is named [Property=Value]. Each property's ranges are stated
   in ascending order, and are returned joined where they touch. *)

type t = { version : string; properties : (string * (int * int) list) list }

let ranges t property = List.assoc_opt property t.properties

exception Refused of string

let refuse fmt = Printf.ksprintf (fun message -> raise (Refused message)) fmt
let last_code_point = 0x10FFFF

let is_hex text =
  let n = String.length text in
  n >= 4 && n <= 6
  && String.for_all
       (function '0' .. '9' | 'A' .. 'F' -> true | _ -> false)
       text

let is_name text =
  text <> ""
  && String.for_all
       (function
         | 'A' .. 'Z' | 'a' .. 'z' | '0' .. '9' | '_' -> true | _ -> false)
       text

let code_point text =
  let n = int_of_string ("0x" ^ text) in
  if n > last_code_point then refuse "%s is past the last code point" text;
  n

let range text =
  match String.split_on_char '.' text with
  | [ single ] when is_hex single ->
      let n = code_point single in
      (n, n)
  | [ first; ""; last ] when is_hex first && is_hex last ->
      let first' = code_point first and last' = code_point last in
      if last' < first' then refuse "%s is a backward range" text;
      (first', last')
  | _ -> refuse "is no code point or range, property and comment"

(* The version a UCD file's first line names: # <name>-<version>.txt *)
let version first =
  let name =
    if String.starts_with ~prefix:"# " first then
      String.sub first 2 (String.length first - 2)
    else ""
  in
  let stem =
    if Filename.check_suffix name ".txt" then Filename.chop_suffix name ".txt"
    else ""
  in
  match String.rindex_opt stem '-' with
  | Some i
    when let v = String.sub stem (i + 1) (String.length stem - i - 1) in
         v <> ""
         && String.for_all (function '0' .. '9' | '.' -> true | _ -> false) v ->
      String.sub stem (i + 1) (String.length stem - i - 1)
  | _ ->
      refuse
        "names no version: a UCD file's first line is its name, \
         <name>-<version>.txt"

let shown (first, last) =
  if first = last then Printf.sprintf "%04X" first
  else Printf.sprintf "%04X..%04X" first last

let read ~file text =
  let line_number = ref 1 in
  try
    let lines = String.split_on_char '\n' text in
    let version = version (match lines with first :: _ -> first | [] -> "") in
    let found = Hashtbl.create 32 and order = ref [] in
    List.iteri
      (fun i line ->
        line_number := i + 1;
        let line = String.trim line in
        if i > 0 && line <> "" && line.[0] <> '#' then
          match String.index_opt line '#' with
          | None -> refuse "is no code point or range, property and comment"
          | Some hash -> (
              let fields =
                List.map String.trim
                  (String.split_on_char ';' (String.sub line 0 hash))
              in
              let points, property =
                match fields with
                | [ points; name ] when is_name name -> (points, name)
                | [ points; name; value ] when is_name name && is_name value ->
                    (points, name ^ "=" ^ value)
                | _ -> refuse "is no code point or range, property and comment"
              in
              let ((first, last) as next) = range points in
              (* A property's last range, and the ranges before it, latest
                 first. *)
              match Hashtbl.find_opt found property with
              | None ->
                  order := property :: !order;
                  Hashtbl.replace found property (next, [])
              | Some (((before, upto) as latest), earlier) ->
                  if first <= upto then
                    refuse "%s does not follow %s's last range, %s" points
                      property (shown latest);
                  Hashtbl.replace found property
                    (if first = upto + 1 then ((before, last), earlier)
                     else (next, latest :: earlier))))
      lines;
    Ok
      {
        version;
        properties =
          List.rev_map
            (fun property ->
              let latest, earlier = Hashtbl.find found property in
              (property, List.rev (latest :: earlier)))
            !order;
      }
  with Refused message ->
    Error
      {
        Decode.file;
        pointer = "";
        message = Printf.sprintf "line %d: %s" !line_number message;
      }
