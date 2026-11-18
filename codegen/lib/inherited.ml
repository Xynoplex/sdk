(* Which schema states each property an [allOf] merges. A type a writer
   declares in place for a property is named after that schema, so a parent's
   property reached again through a child is the parent's one type, not a
   copy under the child's name. *)

type part =
  | Component of string  (** A member that is a [$ref] to this schema. *)
  | Stated of string list  (** A member written in place, by its properties. *)

(* Each property [members] state, with the schema that states the one the
   merge keeps: the last member to state it. A property a [Component] states
   is owned by whatever owns it in that schema's own [parts], and one a
   [Stated] member states by [owner], the schema the [allOf] is. A property
   asked after that no member states is refused by name. *)
let owners ~parts owner members =
  let rec go owner members =
    List.fold_left
      (fun owned part ->
        let stated =
          match part with
          | Stated properties -> List.map (fun p -> (p, owner)) properties
          | Component name -> go name (parts name)
        in
        List.fold_left
          (fun owned (p, o) -> List.remove_assoc p owned @ [ (p, o) ])
          owned stated)
      [] members
  in
  let owned = go owner members in
  fun property ->
    match List.assoc_opt property owned with
    | Some o -> o
    | None -> failwith (owner ^ ": no member of it states " ^ property)

(* [owners] for [name]'s schema [s], as a writer that reads [Schema] has it:
   a schema's parts are its [$ref], or its [allOf]'s members and then its own
   properties. [find] is a component schema by its name, and [referenced]
   the name of the component a [$ref] is. *)
let of_schemas ~find ~referenced name (s : Schema.t) =
  let stated = function
    | Schema.Schema { properties; _ } ->
        Stated (List.map fst (Option.value ~default:[] properties))
    | Boolean_schema _ -> Stated []
  in
  let parts = function
    | Schema.Schema { ref_ = Some r; _ } -> [ Component (referenced r) ]
    | Schema.Schema { all_of; _ } as s ->
        List.map
          (function
            | Schema.Schema { ref_ = Some r; _ } -> Component (referenced r)
            | m -> stated m)
          (Option.value ~default:[] all_of)
        @ [ stated s ]
    | Boolean_schema _ as s -> [ stated s ]
  in
  owners ~parts:(fun n -> parts (find n)) name (parts s)
