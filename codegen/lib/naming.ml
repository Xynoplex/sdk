(* The name of a type a writer declares for a schema written in place: the
   [owner]'s name and the [part]'s in Pascal case ([property], [property]Item
   for an array's items, [property]Value for a map's values), and [Value]
   after them for as long as [defined] says a component schema already has
   that name. *)
let inline ~defined owner part =
  let rec free name = if defined name then free (name ^ "Value") else name in
  free (owner ^ Text.pascal part)

(* The name of an enumeration's value, after its type's: the value in Pascal
   case. A [+] is part of what a value says ([text/x-c++] is not [text/x-c]),
   so it is spelled rather than dropped. *)
let variant value =
  Text.pascal (String.concat " plus " (String.split_on_char '+' value))
