type t = { fields : (string * Yojson.Raw.t) list; mutable named : string list }

let start fields = { fields; named = [] }
let fields_of = function `Assoc fields -> fields | _ -> assert false

let string = function
  | `Stringlit literal -> (
      match Yojson.Safe.from_string literal with
      | `String text -> text
      | _ -> assert false)
  | _ -> assert false

let bool = function `Bool value -> value | _ -> assert false
let raw value = value

let take reader name =
  reader.named <- name :: reader.named;
  List.assoc_opt name reader.fields

let required reader read name = read (Option.get (take reader name))

let optional reader read name =
  match take reader name with
  | None -> Types.Absent
  | Some `Null -> Types.Null
  | Some value -> Types.Present (read value)

let rest reader =
  List.filter (fun (name, _) -> not (List.mem name reader.named)) reader.fields
