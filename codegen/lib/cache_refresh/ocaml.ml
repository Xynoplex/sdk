(* The refresh table as the OCaml SDK reads it (ocaml/sdk/lib/live_facts.ml):
   each query that asks an operation, with the request it asks, and each row
   of the table in its order, with the place in an event each of its names is
   found as the segments of its way. Table.derive holds the table to its
   rules first; this writes the rows as the table states them. *)

module T = Tables.Client_refresh

let string = Text.ocaml_quoted
let strings values = "[" ^ String.concat "; " (List.map string values) ^ "]"

let way = function
  | None -> "[]"
  | Some value -> strings (String.split_on_char '.' value)

let file (table : T.t) =
  let queries =
    List.filter_map
      (fun (q : T.query) ->
        match q.source with
        | Asks request -> Some (Printf.sprintf "  (%s, %s);" (string q.name) (string request))
        | Reads _ -> None)
      table.queries
  in
  let rows =
    List.map
      (fun (r : T.refresh_item) ->
        let names = Option.value ~default:{ T.resource = None; annotation = None } r.names in
        let list = function None -> "[]" | Some values -> strings values in
        Printf.sprintf "  (%s, %s, %b, %s, %s, %s, %s, %s, %s);" (string r.on)
          (match r.when_ with
          | None -> "None"
          | Some Enriched -> "Some " ^ string "enriched"
          | Some Unenriched -> "Some " ^ string "unenriched")
          (r.reach = Some Held) (way names.resource) (way names.annotation)
          (way r.carries) (list r.refetches) (list r.writes) (list r.removes))
      table.refresh
  in
  {
    Output.path = "ocaml/sdk/lib/live_facts.ml";
    text =
      String.concat "\n"
        ([ Banner.ocaml ~from_:Table.file __FILE__; "let queries = [" ]
        @ queries
        @ [ "]"; "let refresh = [" ]
        @ rows @ [ "]"; "" ]);
  }
