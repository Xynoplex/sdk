(* The refresh table as the OCaml SDK reads it (ocaml/sdk/lib/live_facts.ml):
   each query's name, as a value of [Query] named by it in snake case
   ([referencedBy] is [Query.referenced_by]); each query that asks an
   operation, with the request it asks; and each row of the table in its
   order, with the place in an event each of its names is found as the
   segments of its way. Table.derive holds the table to its rules first; this
   writes the rows as the table states them. *)

module T = Tables.Client_refresh
module O = Ocaml_syntax

let strings values = O.list (List.map O.string values)

let way = function
  | None -> O.list []
  | Some value -> strings (String.split_on_char '.' value)

let file (table : T.t) =
  let names =
    O.module_ "Query"
      (List.map
         (fun (q : T.query) -> O.let_ (Text.snake q.name) (O.string q.name))
         table.queries)
  in
  let queries =
    List.filter_map
      (fun (q : T.query) ->
        match q.source with
        | Asks request -> Some (O.tuple [ O.string q.name; O.string request ])
        | Reads _ -> None)
      table.queries
  in
  let rows =
    List.map
      (fun (r : T.refresh_item) ->
        let names =
          Option.value ~default:{ T.resource = None; annotation = None } r.names
        in
        let list = function
          | None -> O.list []
          | Some values -> strings values
        in
        O.tuple
          [
            O.string (T.trigger_name r.trigger);
            (match r.when_ with
            | None -> O.none
            | Some Enriched -> O.some (O.string "enriched")
            | Some Unenriched -> O.some (O.string "unenriched"));
            O.bool (r.reach = Some Held);
            way names.resource;
            way names.annotation;
            way r.carries;
            list r.refetches;
            list r.writes;
            list r.removes;
          ])
      table.refresh
  in
  O.implementation ~path:"ocaml/sdk/lib/live_facts.ml"
    ~banner:(Banner.ocaml ~from_:Table.file __FILE__)
    [ names; O.let_ "queries" (O.list queries); O.let_ "refresh" (O.list rows) ]
