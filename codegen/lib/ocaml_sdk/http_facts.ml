(* What the OCaml SDK's HTTP transport says of a failure
   (ocaml/sdk/lib/http_facts.ml): the transport code each status becomes,
   and the bus code each of CommandError's codes becomes. The gateway's
   routes, media types, headers and upload members are the gateway HTTP
   group's (ocaml/sdk/lib/gateway_http.ml). *)

module O = Ocaml_syntax

let file (codes : Error_codes.Table.t) =
  let refusals = ref [] in
  let refuse file pointer message =
    refusals := { Decode.file; pointer; message } :: !refusals
  in
  let status_code =
    List.map
      (fun (status, (c : Error_codes.Table.code)) ->
        O.case (O.Pattern.int status) (O.string c.code))
      codes.exact
    @ (match codes.from with
      | None -> []
      | Some (status, c) ->
          [
            O.case (O.Pattern.var "status")
              ~guard:(O.infix ">=" (O.ident "status") (O.int status))
              (O.string c.code);
          ])
    @ [ O.case O.Pattern.any (O.string codes.unclassified.code) ]
  in
  let failures =
    List.map
      (fun (wire, (c : Error_codes.Table.code)) ->
        let constructor =
          String.capitalize_ascii
            (String.map (function '-' -> '_' | x -> x) wire)
        in
        if
          (match constructor.[0] with 'A' .. 'Z' -> false | _ -> true)
          || not
               (String.for_all
                  (function
                    | 'a' .. 'z' | '0' .. '9' | '_' -> true | _ -> false)
                  (String.sub constructor 1 (String.length constructor - 1)))
        then
          refuse "components/schemas/CommandError.json" "/properties/code/enum"
            (Printf.sprintf "states %s, which names no OCaml constructor" wire);
        (wire, c.code, constructor))
      codes.wire
  in
  let failure_code =
    O.module_ "Failure_code"
      [
        O.type_item
          (O.type_declaration "t"
             (Variant (List.map (fun (_, _, c) -> O.constructor c) failures)));
        O.let_ "of_wire"
          (O.function_
             (List.map
                (fun (w, _, c) -> O.case (O.Pattern.string w) (O.construct c))
                failures
             @ [
                 O.case (O.Pattern.var "code")
                   (O.apply (O.ident "invalid_arg")
                      [
                        O.infix "^"
                          (O.string "a failure's code \"")
                          (O.infix "^" (O.ident "code")
                             (O.string
                                "\" is none of CommandError's: the reader \
                                 leaves such a code out"));
                      ]);
               ]));
      ]
  in
  let bus_failure =
    O.let_ "bus_failure"
      (O.function_
         (O.case (O.Pattern.construct "None") (O.string codes.unrecognized.code)
         :: List.map
              (fun (_, code, c) ->
                O.case
                  (O.Pattern.construct "Some"
                     ~arg:(O.Pattern.construct ("Failure_code." ^ c)))
                  (O.string code))
              failures))
  in
  let items =
    [
      O.let_ "status_code" (O.function_ status_code); failure_code; bus_failure;
    ]
  in
  match List.rev !refusals with
  | [] ->
      Ok
        (O.implementation ~path:"ocaml/sdk/lib/http_facts.ml"
           ~banner:(Banner.ocaml ~from_:"error codes" __FILE__)
           items)
  | errors -> Error errors
