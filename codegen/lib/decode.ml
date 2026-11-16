type error = { file : string; pointer : string; message : string }

let error_to_string { file; pointer; message } =
  Printf.sprintf "%s: %s: %s" file
    (if pointer = "" then "/" else pointer)
    message

type reference = { target : string; file : string; pointer : string }

type cursor = {
  file : string;
  tokens : string list;
  json : Yojson.Safe.t;
  references : reference list ref;
}

exception Refused of error

let escape token =
  let buffer = Buffer.create (String.length token) in
  String.iter
    (function
      | '~' -> Buffer.add_string buffer "~0"
      | '/' -> Buffer.add_string buffer "~1"
      | c -> Buffer.add_char buffer c)
    token;
  Buffer.contents buffer

let unescape token =
  let buffer = Buffer.create (String.length token) in
  let rec go i =
    if i < String.length token then
      match
        (token.[i], if i + 1 < String.length token then token.[i + 1] else ' ')
      with
      | '~', '0' ->
          Buffer.add_char buffer '~';
          go (i + 2)
      | '~', '1' ->
          Buffer.add_char buffer '/';
          go (i + 2)
      | c, _ ->
          Buffer.add_char buffer c;
          go (i + 1)
  in
  go 0;
  Buffer.contents buffer

let pointer (cursor : cursor) =
  String.concat ""
    (List.rev_map (fun token -> "/" ^ escape token) cursor.tokens)

let refuse (cursor : cursor) message =
  raise (Refused { file = cursor.file; pointer = pointer cursor; message })

let run ~file json decoder =
  let references = ref [] in
  match decoder { file; tokens = []; json; references } with
  | value -> Ok (value, List.rev !references)
  | exception Refused error -> Error error

let parse_file ~root relative =
  match
    Yojson.Safe.from_file ~fname:relative (Filename.concat root relative)
  with
  | json -> Ok json
  | exception Yojson.Json_error message ->
      Error { file = relative; pointer = ""; message }

let at_pointer pointer json =
  match String.split_on_char '/' pointer with
  | [ "" ] -> Some json
  | "" :: tokens ->
      List.fold_left
        (fun found token ->
          match (found, unescape token) with
          | Some (`Assoc members), name -> List.assoc_opt name members
          | Some (`List items), index -> (
              match int_of_string_opt index with
              | Some i when i >= 0 && i < List.length items ->
                  Some (List.nth items i)
              | _ -> None)
          | _ -> None)
        (Some json) tokens
  | _ -> None

type kind = Null | Bool | Int | Number | String | Array | Object

let kind cursor =
  match cursor.json with
  | `Null -> Null
  | `Bool _ -> Bool
  | `Int _ | `Intlit _ -> Int
  | `Float _ -> Number
  | `String _ -> String
  | `List _ -> Array
  | `Assoc _ -> Object

let kind_name = function
  | Null -> "null"
  | Bool -> "a boolean"
  | Int -> "an integer"
  | Number -> "a number"
  | String -> "a string"
  | Array -> "an array"
  | Object -> "an object"

let expected cursor what =
  refuse cursor
    (Printf.sprintf "expected %s, found %s" what (kind_name (kind cursor)))

let json cursor = cursor.json

let has_member name cursor =
  match cursor.json with
  | `Assoc members -> List.mem_assoc name members
  | _ -> false

let string cursor =
  match cursor.json with `String s -> s | _ -> expected cursor "a string"

let non_empty_string cursor =
  match string cursor with
  | "" -> refuse cursor "expected a non-empty string"
  | s -> s

let bool cursor =
  match cursor.json with `Bool b -> b | _ -> expected cursor "a boolean"

let int cursor =
  match cursor.json with
  | `Int i -> i
  | `Intlit _ -> refuse cursor "an integer beyond OCaml's int"
  | _ -> expected cursor "an integer"

let number cursor =
  match cursor.json with
  | `Int i -> float_of_int i
  | `Float f when Float.is_finite f -> f
  | `Float _ -> refuse cursor "expected a finite number"
  | _ -> expected cursor "a number"

let null cursor =
  match cursor.json with `Null -> () | _ -> expected cursor "null"

let literal wanted cursor =
  let text = string cursor in
  if text <> wanted then
    refuse cursor (Printf.sprintf "expected %S, found %S" wanted text)

let reference cursor =
  let found =
    {
      target = non_empty_string cursor;
      file = cursor.file;
      pointer = pointer cursor;
    }
  in
  cursor.references := found :: !(cursor.references);
  found

let resolve { target; file; _ } =
  let path, fragment =
    match String.index_opt target '#' with
    | None -> (target, "")
    | Some i ->
        ( String.sub target 0 i,
          String.sub target (i + 1) (String.length target - i - 1) )
  in
  let segments =
    if path = "" then String.split_on_char '/' file
    else
      String.split_on_char '/' (Filename.dirname file)
      @ String.split_on_char '/' path
  in
  let normal =
    List.fold_left
      (fun kept segment ->
        match (segment, kept) with
        | ("." | ""), _ -> kept
        | "..", _ :: rest -> rest
        | _ -> segment :: kept)
      [] segments
  in
  (String.concat "/" (List.rev normal), fragment)

let child cursor token json =
  { cursor with tokens = token :: cursor.tokens; json }

let list decoder cursor =
  match cursor.json with
  | `List items ->
      List.mapi
        (fun i item -> decoder (child cursor (string_of_int i) item))
        items
  | _ -> expected cursor "an array"

let non_empty_list decoder cursor =
  match list decoder cursor with
  | [] -> refuse cursor "expected a non-empty array"
  | items -> items

let nullable decoder cursor =
  match cursor.json with `Null -> None | _ -> Some (decoder cursor)

let members_of cursor =
  match cursor.json with
  | `Assoc members ->
      let seen = Hashtbl.create (List.length members) in
      List.iter
        (fun (name, json) ->
          if Hashtbl.mem seen name then
            refuse (child cursor name json) "a duplicate member"
          else Hashtbl.replace seen name ())
        members;
      members
  | _ -> expected cursor "an object"

let map decoder cursor =
  List.map
    (fun (name, json) -> (name, decoder (child cursor name json)))
    (members_of cursor)

let names cases = String.concat ", " (List.map fst cases)

let enum cases cursor =
  let text = string cursor in
  match List.assoc_opt text cases with
  | Some value -> value
  | None -> refuse cursor (Printf.sprintf "%S is none of %s" text (names cases))

let wrong_length count cursor =
  match cursor.json with
  | `List items ->
      refuse cursor
        (Printf.sprintf "expected %d elements, found %d" count
           (List.length items))
  | _ -> expected cursor "an array"

let pair first second cursor =
  match cursor.json with
  | `List [ a; b ] -> (first (child cursor "0" a), second (child cursor "1" b))
  | _ -> wrong_length 2 cursor

let triple first second third cursor =
  match cursor.json with
  | `List [ a; b; c ] ->
      ( first (child cursor "0" a),
        second (child cursor "1" b),
        third (child cursor "2" c) )
  | _ -> wrong_length 3 cursor

type nothing = |

let nothing cursor = refuse cursor "a value where the model knows none"

let variant member cases cursor =
  let fields = members_of cursor in
  match List.assoc_opt member fields with
  | None -> refuse cursor (Printf.sprintf "lacks the member %S" member)
  | Some json -> (
      let tag = child cursor member json in
      let name = string tag in
      match List.assoc_opt name cases with
      | Some decoder -> decoder cursor
      | None ->
          refuse tag (Printf.sprintf "%S is none of %s" name (names cases)))

let keyed cases cursor =
  let fields = members_of cursor in
  match List.filter (fun (name, _) -> List.mem_assoc name fields) cases with
  | [ (_, decoder) ] -> decoder cursor
  | [] -> refuse cursor (Printf.sprintf "has none of %s" (names cases))
  | present ->
      refuse cursor (Printf.sprintf "has more than one of %s" (names present))

type members = {
  cursor : cursor;
  fields : (string * Yojson.Safe.t) list;
  read : (string, unit) Hashtbl.t;
}

let obj decoder cursor =
  let fields = members_of cursor in
  let members = { cursor; fields; read = Hashtbl.create 8 } in
  let value = decoder members in
  List.iter
    (fun (name, json) ->
      if not (Hashtbl.mem members.read name) then
        refuse (child cursor name json) "an unknown member")
    fields;
  value

let optional members name decoder =
  Hashtbl.replace members.read name ();
  Option.map
    (fun json -> decoder (child members.cursor name json))
    (List.assoc_opt name members.fields)

let required members name decoder =
  match optional members name decoder with
  | Some value -> value
  | None -> refuse members.cursor (Printf.sprintf "lacks the member %S" name)

let at members = members.cursor
