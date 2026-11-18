(* The Encoding Standard's tables as the OCaml SDK reads them
   (ocaml/sdk/lib/encoding_facts.ml), in the table's order: each label and the
   encoding it names, each single-byte encoding's 256 characters, and the
   encodings whose labels are refused. Table.derive holds the table to its
   rules first. *)

module T = Tables.Text_encoding_cases
module O = Ocaml_syntax

let file (table : T.t) =
  let pair (a, b) = O.tuple [ O.string a; O.string b ] in
  O.implementation ~path:"ocaml/sdk/lib/encoding_facts.ml"
    ~banner:(Banner.ocaml ~from_:"text/encoding-cases.json" __FILE__)
    [
      O.let_ "labels"
        (O.list
           (List.concat_map
              (fun (c : T.case) ->
                List.map (fun label -> pair (label, c.encoding)) c.labels)
              table.cases));
      O.let_ "single_byte"
        (O.list
           (List.filter_map
              (fun (c : T.case) ->
                match c.kind with
                | Single_byte { every_byte } ->
                    Some (pair (c.encoding, every_byte))
                | _ -> None)
              table.cases));
      O.let_ "refused"
        (O.list
           (List.filter_map
              (fun (c : T.case) ->
                match c.kind with
                | Refused -> Some (O.string c.encoding)
                | _ -> None)
              table.cases));
    ]
