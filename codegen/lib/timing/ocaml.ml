(* The timing as the OCaml SDK reads it (ocaml/sdk/lib/client_timing.ml): a
   value per entry under its name in snake case, a duration or a count as an
   int and a retry budget as a record. *)

let header =
  Banner.ocaml ~from_:("protocol/specs/src/" ^ Table.file) __FILE__ ^ "\n"

let retry =
  "type retry = { attempts : int; initial_delay_ms : int; max_delay_ms : int }"

let files (t : Table.t) =
  let lines body = header ^ String.concat "\n" (retry :: body) ^ "\n" in
  [
    {
      Output.path = "ocaml/sdk/lib/client_timing.ml";
      text =
        lines
          (List.map
             (fun (e : Table.entry) ->
               "let " ^ Text.snake e.name ^ " = "
               ^
               match e.value with
               | Duration n | Count n -> string_of_int n
               | Budget b ->
                   Printf.sprintf
                     "{ attempts = %d; initial_delay_ms = %d; max_delay_ms = \
                      %d }"
                     b.attempts b.initial_delay_ms b.max_delay_ms)
             t);
    };
    {
      Output.path = "ocaml/sdk/lib/client_timing.mli";
      text =
        lines
          (List.map
             (fun (e : Table.entry) ->
               "val " ^ Text.snake e.name ^ " : "
               ^ match e.value with Budget _ -> "retry" | _ -> "int")
             t);
    };
  ]
