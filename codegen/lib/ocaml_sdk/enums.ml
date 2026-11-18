(* Every component that is a string enum (protocol/specs/src/components/
   schemas), as a module of the OCaml SDK (ocaml/sdk/lib/enums.ml): a variant
   per member, and its name both ways. A member is a letter and then letters,
   digits and . / + -, so it names a constructor; no two name the same one. *)

let source = "protocol/specs/src/components/schemas"
let prefix = "components/schemas/"

type enum = { module_ : string; variants : (string * string) list }
(** Each variant: its constructor, and its member. *)

let is_member value =
  value <> ""
  && (match value.[0] with 'a' .. 'z' | 'A' .. 'Z' -> true | _ -> false)
  && String.for_all
       (function
         | 'a' .. 'z' | 'A' .. 'Z' | '0' .. '9' | '.' | '/' | '+' | '-' -> true
         | _ -> false)
       value

let constructor value =
  String.capitalize_ascii
    (String.map
       (function '.' | '/' | '-' -> '_' | c -> c)
       (Text.replace_all ~sub:"+" ~by:"_plus" value))

let derive (spec : Spec.t) =
  let refusals = ref [] in
  let enums =
    List.filter_map
      (fun (file, schema) ->
        match schema with
        | Schema.Schema { type_ = Some [ String ]; enum = Some members; _ }
          when String.starts_with ~prefix file
               && not
                    (String.contains
                       (String.sub file (String.length prefix)
                          (String.length file - String.length prefix))
                       '/') ->
            let stem =
              Filename.remove_extension
                (String.sub file (String.length prefix)
                   (String.length file - String.length prefix))
            in
            let refuse pointer message =
              refusals := { Decode.file; pointer; message } :: !refusals
            in
            let variants =
              List.concat
                (List.mapi
                   (fun i (member : Schema.literal) ->
                     match member with
                     | String_literal value when is_member value ->
                         [ (constructor value, value) ]
                     | _ ->
                         refuse
                           (Printf.sprintf "/enum/%d" i)
                           "is no member an OCaml constructor can name";
                         [])
                   members)
            in
            let constructors = List.map fst variants in
            if
              variants = []
              || List.length (List.sort_uniq compare constructors)
                 <> List.length constructors
            then refuse "/enum" "is empty, or two members name one constructor";
            Some
              { module_ = String.capitalize_ascii (Text.snake stem); variants }
        | _ -> None)
      (List.sort (fun (a, _) (b, _) -> compare a b) spec.schemas)
  in
  match List.rev !refusals with [] -> Ok enums | errors -> Error errors

module O = Ocaml_syntax

let banner = Banner.ocaml ~from_:("string enums in " ^ source) __FILE__

let t e =
  O.type_declaration "t"
    (Variant (List.map (fun (c, _) -> O.constructor c) e.variants))

let impl e =
  O.module_ e.module_
    [
      O.type_item (t e);
      O.let_ "to_string"
        (O.function_
           (List.map
              (fun (c, member) ->
                O.case (O.Pattern.construct c) (O.string member))
              e.variants));
      O.let_ "of_string"
        (O.function_
           (List.map
              (fun (c, member) ->
                O.case (O.Pattern.string member) (O.some (O.construct c)))
              e.variants
           @ [ O.case O.Pattern.any O.none ]));
    ]

(* Each enum's members, encoded and decoded, and an unknown value refused,
   with [rest] after. *)
let test e rest =
  let check kind name actual expected =
    O.apply (O.ident "Alcotest.check")
      [ O.ident ("Alcotest." ^ kind); O.string name; actual; expected ]
  in
  let model c = O.construct ("Model." ^ c) in
  let of_string member =
    O.apply (O.ident "Model.of_string") [ O.string member ]
  in
  O.let_module "Model"
    ("Xynolog.Enums." ^ e.module_)
    (O.sequence
       (List.concat_map
          (fun (c, member) ->
            [
              check "string" (e.module_ ^ " encode") (O.string member)
                (O.apply (O.ident "Model.to_string") [ model c ]);
              check "bool" (e.module_ ^ " decode") (O.bool true)
                (O.infix "=" (of_string member) (O.some (model c)));
            ])
          e.variants
       @ [
           check "bool"
             (e.module_ ^ " rejects unknown values")
             (O.bool true)
             (O.infix "=" (of_string "") O.none);
           rest;
         ]))

let files enums =
  [
    O.implementation ~path:"ocaml/sdk/lib/enums.ml" ~banner
      (List.map impl enums);
    O.implementation ~path:"ocaml/sdk/test/enums_cases.ml" ~banner
      [ O.let_unit (List.fold_right test enums O.unit) ];
  ]
