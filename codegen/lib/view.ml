(* What a writer of types reads of a schema in [Definitions]' view, whatever
   language it writes: the schema a [$ref] names, a union's members, the one
   value a schema admits, the schema without its [null], and an [allOf] as
   one object. *)

module D = Definitions

let refuse = D.refuse
let reference (s : D.t) = match s with D.Ref name -> Some name | _ -> None

let union (s : D.t) =
  match s with
  | D.Node { one_of = Some members; _ } -> Some members
  | D.Node { any_of = Some members; _ } -> Some members
  | _ -> None

let node (s : D.t) = match s with D.Node n -> Some n | _ -> None

let refuse_const what (s : D.t) =
  match s with
  | D.Node { const = true; _ } ->
      refuse
        "%s: `const` is not OpenAPI 3.0: state the one value as an `enum` of \
         one"
        what
  | _ -> ()

(* The one string a schema admits, when it admits exactly one. *)
let only_value (s : D.t) =
  match s with
  | D.Node { enum = Some [ Schema.String_literal v ]; _ } -> Some v
  | _ -> None

(* A schema that also admits null, as the schema without it. *)
let without_null (s : D.t) =
  match union s with
  | Some members -> (
      let others = List.filter (fun m -> m <> D.Null) members in
      if List.length others = List.length members then None
      else
        match others with
        | [ only ] -> Some only
        | _ -> Some (D.Node { (D.node [ "anyOf" ]) with any_of = Some others }))
  | None -> (
      match s with
      | D.Node ({ type_ = Some (D.Or_null t); _ } as n) ->
          Some (D.Node { n with type_ = Some (D.One t) })
      | _ -> None)

(* The single value an object's discriminating property takes: the first of
   its properties that admits exactly one string. *)
let discriminant (s : D.t) =
  match s with
  | D.Node { properties = Some ps; _ } ->
      List.find_map (fun (_, p) -> only_value p) ps
  | _ -> None

(* [s], or the component schema it names. *)
let resolved (definitions : D.definitions) (s : D.t) =
  match reference s with Some name -> definitions.schema name | None -> s

(* Whether a schema is a string, following [$ref]s and unions of strings. *)
let rec is_string definitions (s : D.t) =
  match reference s with
  | Some _ -> is_string definitions (resolved definitions s)
  | None -> (
      match union s with
      | Some members -> List.for_all (is_string definitions) members
      | None -> (
          match s with
          | D.Node { type_ = Some (D.One String); enum = None; _ } -> true
          | _ -> false))

(* An [allOf]'s members as one object: the properties of each, a later
   member's refining an earlier's in its place, every member's requirements,
   and closed or open where a member is. *)
let merged definitions name members =
  let properties = ref [] in
  let required = ref [] in
  let closed = ref false in
  let open_ = ref false in
  List.iter
    (fun member ->
      match resolved definitions member with
      | D.Node ({ type_ = Some (D.One Object); _ } as m) -> (
          List.iter
            (fun (k, v) ->
              if List.mem_assoc k !properties then
                properties :=
                  List.map
                    (fun (k', v') -> if k' = k then (k, v) else (k', v'))
                    !properties
              else properties := !properties @ [ (k, v) ])
            (Option.value m.properties ~default:[]);
          let before = !required in
          required :=
            before
            @ List.filter
                (fun r -> not (List.mem r before))
                (Option.value m.required ~default:[]);
          match m.additional_properties with
          | Some (D.Bool false) -> closed := true
          | Some (D.Bool true) -> open_ := true
          | _ -> ())
      | _ -> refuse "%s: an allOf member that is not an object" name)
    members;
  let additional_properties =
    match (!closed, !open_) with
    | true, true ->
        refuse "%s: one allOf member is closed and another open" name
    | true, false -> Some (D.Bool false)
    | false, true -> Some (D.Bool true)
    | false, false -> None
  in
  D.Node
    {
      (D.node
         ([ "type"; "properties"; "required" ]
         @
         if additional_properties = None then [] else [ "additionalProperties" ]
         ))
      with
      type_ = Some (D.One Object);
      properties = Some !properties;
      required = Some !required;
      additional_properties;
    }

(* The value of [property] each member of a union states, when every member
   is an object that must state it, each admits one value, and no two admit
   the same: the property then says which member a value is. *)
let tags definitions property members =
  let rec go acc = function
    | [] -> Some (List.rev acc)
    | member :: rest -> (
        match resolved definitions member with
        | D.Node { required = Some required; properties = Some ps; _ }
          when List.mem property required -> (
            match Option.bind (List.assoc_opt property ps) only_value with
            | Some tag when not (List.mem tag acc) -> go (tag :: acc) rest
            | _ -> None)
        | _ -> None)
  in
  go [] members
