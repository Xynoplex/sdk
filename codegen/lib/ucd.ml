(* The files of the Unicode Character Database (codegen/ucd), each read
   strictly. A property file, such as DerivedCoreProperties.txt or
   PropList.txt: its first line names it and its version, and every other
   line is blank, a comment, or a code point or a range of them, a property,
   an optional value and a comment. A property with a value is named
   [Property=Value]. Each property's ranges are stated in ascending order,
   and are returned joined where they touch. UnicodeData.txt and
   SpecialCasing.txt are read for their lowercase mappings. *)

(* What a file generated from these carries of their licence, which asks that
   its copyright and permission notice go with every copy of Unicode's data:
   the notice itself, [license] being codegen/ucd/LICENSE's text, as lines. *)
let license_file = "codegen/ucd/LICENSE"

let notice license =
  ("Unicode's data is under this notice (" ^ license_file ^ "):")
  :: ""
  :: List.map
       (fun line ->
         let n = String.length line in
         if n > 0 && line.[n - 1] = '\r' then String.sub line 0 (n - 1)
         else line)
       (String.split_on_char '\n' (String.trim license))

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

(* [each] run on a file's lines, numbered from 1. [each] says by [at] which
   line it reads, and a refusal names that line. *)
let guarded ~file text each =
  let line_number = ref 1 in
  let at number = line_number := number in
  try
    Ok
      (each ~at
         (List.mapi
            (fun i line -> (i + 1, line))
            (String.split_on_char '\n' text)))
  with Refused message ->
    Error
      {
        Decode.file;
        pointer = "";
        message = Printf.sprintf "line %d: %s" !line_number message;
      }

let first_line = function (_, first) :: _ -> first | [] -> ""

(* A line's fields before its comment, [;]-separated and trimmed, or none for
   a blank or comment line. *)
let fields line =
  let line = String.trim line in
  if line = "" || line.[0] = '#' then None
  else
    let data =
      match String.index_opt line '#' with
      | Some hash -> String.sub line 0 hash
      | None -> line
    in
    Some (List.map String.trim (String.split_on_char ';' data))

let code_points text =
  List.map
    (fun point ->
      if not (is_hex point) then refuse "%S is no code point" point;
      code_point point)
    (List.filter (( <> ) "") (String.split_on_char ' ' text))

(* UnicodeData.txt's simple lowercase mappings: each code point, in
   ascending order, with the one its fourteenth field lower-cases it to. Each
   line is a code point of fifteen fields; a range's first and last lines
   map none. The file names no version: it is fetched with the others, of
   theirs (codegen/ucd/README.md). *)
let simple_lowercase ~file text =
  guarded ~file text (fun ~at lines ->
      let previous = ref (-1) in
      List.filter_map
        (fun (number, line) ->
          at number;
          if line = "" then None
          else
            match String.split_on_char ';' line with
            | [ point; _; _; _; _; _; _; _; _; _; _; _; _; lower; _ ] -> (
                if not (is_hex point) then refuse "%S is no code point" point;
                let code = code_point point in
                if code <= !previous then
                  refuse "%s does not follow %04X" point !previous;
                previous := code;
                match lower with
                | "" -> None
                | _ when is_hex lower -> Some (code, code_point lower)
                | _ -> refuse "%S is no code point" lower)
            | _ -> refuse "is no line of fifteen fields")
        lines)

type casing = {
  code : int;
  lower : int list;
  conditions : string list;
      (** A language, a context, or both; none for a mapping that always holds.
      *)
}

(* SpecialCasing.txt's version and its rows: a code point, its lower, title
   and upper mappings, and the conditions that hold each. *)
let special_casing ~file text =
  guarded ~file text (fun ~at lines ->
      let version = version (first_line lines) in
      let row point lower conditions =
        match code_points point with
        | [ code ] ->
            Some
              {
                code;
                lower = code_points lower;
                conditions =
                  List.filter (( <> ) "") (String.split_on_char ' ' conditions);
              }
        | _ -> refuse "%S is no single code point" point
      in
      ( version,
        List.filter_map
          (fun (number, line) ->
            at number;
            if number = 1 then None
            else
              match fields line with
              | None -> None
              | Some [ point; lower; _; _; "" ] -> row point lower ""
              | Some [ point; lower; _; _; conditions; "" ] ->
                  row point lower conditions
              | Some _ ->
                  refuse
                    "is no code point, its lower, title and upper mappings and \
                     conditions")
          lines ))

let read ~file text =
  guarded ~file text (fun ~at lines ->
      let version = version (first_line lines) in
      let found = Hashtbl.create 32 and order = ref [] in
      List.iter
        (fun (number, line) ->
          at number;
          let line = String.trim line in
          if number > 1 && line <> "" && line.[0] <> '#' then
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
                  | [ points; name; value ] when is_name name && is_name value
                    ->
                      (points, name ^ "=" ^ value)
                  | _ ->
                      refuse "is no code point or range, property and comment"
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
      {
        version;
        properties =
          List.rev_map
            (fun property ->
              let latest, earlier = Hashtbl.find found property in
              (property, List.rev (latest :: earlier)))
            !order;
      })
