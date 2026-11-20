(* The member a gateway stamps a payload's emitter under: the one property of
   the UserId kind (protocol/specs/src/identifiers/kinds.json) whose name
   begins with "_", as a stamp's does. *)

let file = "identifiers/kinds.json"

let about =
  "The member a gateway stamps a payload's emitter under: no part of what was \
   asked."

let field (kinds : Tables.Identifiers_kinds.t) =
  let refuse pointer message = Error [ { Decode.file; pointer; message } ] in
  match
    List.find_mapi
      (fun i (k : Tables.Identifiers_kinds.kinds_item) ->
        if k.schema = "UserId" then Some (i, k.properties) else None)
      kinds.kinds
  with
  | None -> refuse "/kinds" "has no UserId kind"
  | Some (i, properties) -> (
      match List.filter (String.starts_with ~prefix:"_") properties with
      | [ field ] -> Ok field
      | _ ->
          refuse
            (Printf.sprintf "/kinds/%d/properties" i)
            "names no stamp, or more than one: a property beginning with \"_\"")
