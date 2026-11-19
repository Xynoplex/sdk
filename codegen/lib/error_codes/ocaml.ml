(* The vocabularies of codes the OCaml SDK says (ocaml/sdk/lib/error_codes.ml):
   a module per vocabulary it says a code of, a value per code named by the
   code's last segment ([bus.not-found] is [Bus_request.not_found]). Which
   vocabularies those are is the SDK's choice, each named here by its type
   name; one the table no longer states is refused. *)

let said =
  [
    ("Bus_request", "BusRequestErrorCode");
    ("Transport", "TransportErrorCode");
    ("Job", "JobErrorCode");
    ("Session", "XynologSessionErrorCode");
    ("Sign_in", "SignInErrorCode");
    ("Kb_identity", "IdentityUnverifiableReason");
  ]

let value_name code =
  let last = List.hd (List.rev (String.split_on_char '.' code)) in
  String.map (function '-' -> '_' | c -> c) last

let is_value name =
  name <> ""
  && (match name.[0] with 'a' .. 'z' -> true | _ -> false)
  && String.for_all
       (function 'a' .. 'z' | '0' .. '9' | '_' -> true | _ -> false)
       name

let file (t : Table.t) =
  let refusals = ref [] in
  let refuse message =
    refusals := { Decode.file = Table.file; pointer = ""; message } :: !refusals
  in
  let vocabularies = t.bus :: t.transport :: t.others in
  let modules =
    List.concat_map
      (fun (module_, name) ->
        match
          List.find_opt
            (fun (v : Table.vocabulary) -> v.name = name)
            vocabularies
        with
        | None ->
            refuse
              (Printf.sprintf
                 "states no vocabulary %s, which the OCaml SDK says as %s" name
                 module_);
            []
        | Some v ->
            let named = Hashtbl.create 16 in
            [
              Ocaml_syntax.module_ module_
                (List.map
                   (fun (c : Table.code) ->
                     let n = value_name c.code in
                     if not (is_value n) then
                       refuse (Printf.sprintf "%s names no OCaml value" c.code);
                     if Hashtbl.mem named n then
                       refuse
                         (Printf.sprintf "two of %s's codes are both named %s"
                            module_ n);
                     Hashtbl.replace named n ();
                     Ocaml_syntax.let_ n (Ocaml_syntax.string c.code))
                   v.codes);
            ])
      said
  in
  match List.rev !refusals with
  | [] ->
      Ok
        (Ocaml_syntax.implementation ~path:"ocaml/sdk/lib/error_codes.ml"
           ~banner:
             (Banner.ocaml ~from_:("protocol/specs/src/" ^ Table.file) __FILE__)
           modules)
  | errors -> Error errors
