type fault = Schema_codec.fault
type t = { fields : (string * Yojson.Safe.t) list; mutable named : string list }

let start fields = { fields; named = [] }
let ( let* ) = Result.bind
let malformed = Schema_codec.malformed
let string member = function `String value -> Ok value | _ -> malformed member

let integer member = function
  | `Int value -> Ok (Z.of_int value)
  | `Intlit value -> (
      try
        let number = Z.of_string value in
        if Z.to_string number = value || value = "-0" then Ok number
        else malformed member
      with Invalid_argument _ -> malformed member)
  | _ -> malformed member

let integer_at_least minimum member json =
  let* value = integer member json in
  if Z.geq value (Z.of_int minimum) then Ok value else malformed member

let take reader member =
  reader.named <- member :: reader.named;
  List.assoc_opt member reader.fields

let required reader read member =
  match take reader member with
  | None -> Schema_codec.lacks member
  | Some value -> read member value

let optional reader read member =
  match take reader member with
  | None -> Ok None
  | Some value -> Result.map Option.some (read member value)

let rest reader =
  List.filter (fun (name, _) -> not (List.mem name reader.named)) reader.fields

let json_string value = `String value

let json_integer value =
  if Z.fits_int value then `Int (Z.to_int value)
  else `Intlit (Z.to_string value)

let write stated extra =
  `Assoc
    (List.filter_map
       (fun (name, value) -> Option.map (fun value -> (name, value)) value)
       stated
    @ List.filter (fun (name, _) -> not (List.mem_assoc name stated)) extra)
