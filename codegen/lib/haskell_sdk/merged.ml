(* Every [allOf] the Haskell SDK merges, merged as the generator merges it, for
   the SDK's own Xynolog.Internal.Schema.normalize to be held to: each node
   that states an [allOf], in every schema the SDK validates against, by the
   schema's name and the node's path in it, with what Normalize makes of it as
   the SDK holds a schema (Companions.runtime), or Normalize's refusal. The
   SDK's schema test finds each node in its own schemas, requires its
   normalize to give exactly this, and requires the nodes it finds stating an
   [allOf] to be these. *)

let path = "haskell/sdk/test/fixtures/merged-schemas.json"

(* The nodes of a schema that state an [allOf], each with its path from the
   schema, given the path [at] to the schema reversed, among the schemas the
   SDK's schemas hold: those of properties, additionalProperties, items,
   allOf, anyOf and oneOf. *)
let stating_all_of : Schema.t -> string list -> (string list * Schema.t) list =
  Schema.para
    ~boolean:(fun _ _ -> [])
    ~schema:(fun s at ->
      let below key =
        Option.fold ~none:[] ~some:(fun (_, walk) -> walk (key :: at))
      in
      let each key =
        Option.fold ~none:[] ~some:(fun parts ->
            List.concat
              (List.mapi
                 (fun i (_, walk) -> walk (string_of_int i :: key :: at))
                 parts))
      in
      (if Option.is_some s.all_of then
         [ (List.rev at, Schema.Schema (Schema.map fst s)) ]
       else [])
      @ List.concat_map
          (fun (key, (_, walk)) -> walk (key :: "properties" :: at))
          (Option.value s.properties ~default:[])
      @ below "additionalProperties" s.additional_properties
      @ below "items" s.items @ each "allOf" s.all_of @ each "anyOf" s.any_of
      @ each "oneOf" s.one_of)

let comment =
  String.concat " "
    (Banner.lines ~from_:"protocol/specs/src" __FILE__
    @ [
        "Each node that states an allOf in a schema the Haskell SDK validates \
         against, by the schema's name and the node's path in it, with the \
         generator's merge of it (codegen/lib/haskell_sdk/normalize.ml) as the \
         SDK holds a schema, or the merge's refusal: what the SDK's \
         Xynolog.Internal.Schema.normalize must give.";
      ])

(* [definitions], the schemas the SDK validates against by name, each node
   with an [allOf] merged with its references found among them. *)
let file definitions =
  let find name =
    match List.assoc_opt name definitions with
    | Some s -> Ok s
    | None -> Error ("unknown schema reference: " ^ name)
  in
  let entry name (at, node) =
    `Assoc
      ([
         ("schema", `String name);
         ("at", `List (List.map (fun segment -> `String segment) at));
       ]
      @
      match Normalize.normalize ~find node with
      | Ok merged -> [ ("merged", Companions.runtime (Schema merged)) ]
      | Error refusal -> [ ("refused", `String refusal) ])
  in
  {
    Output.path;
    text =
      Yojson.Safe.pretty_to_string ~std:true
        (`Assoc
           [
             ("$comment", `String comment);
             ( "merged",
               `List
                 (List.concat_map
                    (fun (name, schema) ->
                      List.map (entry name) (stating_all_of schema []))
                    definitions) );
           ])
      ^ "\n";
  }
