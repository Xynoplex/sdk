(* The schema a JSON pointer names inside [s]: each segment a member of
   [properties], or [items], [additionalProperties], [not], or an index into
   [allOf], [anyOf] or [oneOf]. *)
let schema s pointer =
  let index list i = Option.bind list (fun l -> List.nth_opt l i) in
  let rec walk s = function
    | [] -> Some s
    | key :: rest -> (
        match s with
        | Schema.Boolean_schema _ -> None
        | Schema (layer : Schema.schema) -> (
            let next =
              match (key, rest) with
              | "properties", name :: rest ->
                  Option.map
                    (fun p -> (p, rest))
                    (Option.bind layer.properties
                       (List.assoc_opt (Decode.unescape name)))
              | "items", rest -> Option.map (fun p -> (p, rest)) layer.items
              | "additionalProperties", rest ->
                  Option.map (fun p -> (p, rest)) layer.additional_properties
              | "not", rest -> Option.map (fun p -> (p, rest)) layer.not_
              | (("allOf" | "anyOf" | "oneOf") as k), i :: rest -> (
                  let list =
                    match k with
                    | "allOf" -> layer.all_of
                    | "anyOf" -> layer.any_of
                    | _ -> layer.one_of
                  in
                  match int_of_string_opt i with
                  | Some i -> Option.map (fun p -> (p, rest)) (index list i)
                  | None -> None)
              | _ -> None
            in
            match next with Some (p, rest) -> walk p rest | None -> None))
  in
  match String.split_on_char '/' pointer with
  | "" :: segments -> walk s segments
  | _ -> None
