(* What the OCaml printer writes for what a writer states: Pprintast's
   printing laid out as the SDK's ocamlformat lays it out, behind the
   module's banner, and refused when it is not OCaml. *)

open Xynolog_codegen
module O = Ocaml_syntax

let case name test = Alcotest.test_case name `Quick test
let banner = "(* A banner. *)"

let writes expected (file : Output.file) () =
  Alcotest.(check string) "text" (banner ^ "\n\n" ^ expected) file.text

let ml items = O.implementation ~path:"x.ml" ~banner items
let mli items = O.interface ~path:"x.mli" ~banner items

(* The string a file's one [let x = "..."] binds, as OCaml reads it. *)
let bound (file : Output.file) =
  match Parse.implementation (Lexing.from_string file.text) with
  | [
   {
     pstr_desc =
       Pstr_value
         ( _,
           [
             {
               pvb_expr =
                 {
                   pexp_desc =
                     Pexp_constant { pconst_desc = Pconst_string (s, _, _); _ };
                   _;
                 };
               _;
             };
           ] );
     _;
   };
  ] ->
      s
  | _ -> Alcotest.fail "binds no one string"

let every_byte = String.init 256 Char.chr

let cases =
  [
    case "a value is a line behind the banner"
      (writes "let x = 1\n" (ml [ O.let_ "x" (O.int 1) ]));
    case "a string literal is every byte it holds" (fun () ->
        Alcotest.(check string)
          "bytes" every_byte
          (bound (ml [ O.let_ "x" (O.string every_byte) ])));
    case "an integer is spelled as the writer spells it"
      (writes "let mode = 0o700\n" (ml [ O.let_ "mode" (O.integer "0o700") ]));
    case "a function of cases is one binding"
      (writes "let f x = function `A -> x | _ -> assert false\n"
         (ml
            [
              O.let_ "f"
                (O.fun_function
                   [ O.Pattern.var "x" ]
                   [
                     O.case (O.Pattern.variant "A") (O.ident "x");
                     O.case O.Pattern.any O.assert_false;
                   ]);
            ]));
    case "a record may be another with fields in place"
      (writes "let r = { any with kinds = Some [ Object ] }\n"
         (ml
            [
              O.let_ "r"
                (O.record ~with_:(O.ident "any")
                   [ ("kinds", O.some (O.list [ O.construct "Object" ])) ]);
            ]));
    case "a module and its signature hold a type and values"
      (writes
         "module M : sig\n\
         \  type t = A | B\n\n\
         \  val to_string : t -> string\n\
          end\n"
         (mli
            [
              O.module_spec "M"
                [
                  O.type_spec
                    (O.type_declaration "t"
                       (Variant [ O.constructor "A"; O.constructor "B" ]));
                  O.val_ "to_string" (O.arrow (O.type_ "t") (O.type_ "string"));
                ];
            ]));
    case "a GADT's constructor states its result"
      (writes "type packed = Packed : 'a box -> packed\n"
         (ml
            [
              O.type_item
                (O.type_declaration "packed"
                   (Variant
                      [
                        O.constructor "Packed"
                          ~args:[ O.type_ "box" ~args:[ O.type_var "a" ] ]
                          ~result:(O.type_ "packed");
                      ]));
            ]));
    case "an optional parameter is passed on by its name"
      (writes "let f client ?scope payload = g client ?scope payload\n"
         (ml
            [
              O.let_ "f"
                (O.fun_labeled
                   [
                     (Nolabel, O.Pattern.var "client");
                     (Optional "scope", O.Pattern.var "scope");
                     (Nolabel, O.Pattern.var "payload");
                   ]
                   (Ast_helper.Exp.apply (O.ident "g")
                      [
                        (Nolabel, O.ident "client");
                        (Optional "scope", O.ident "scope");
                        (Nolabel, O.ident "payload");
                      ]));
            ]));
    case "a module bound in an expression scopes what follows it"
      (writes "let () =\n  let module M = N in\n  f M.x;\n  ()\n"
         (ml
            [
              O.let_unit
                (O.let_module "M" "N"
                   (O.sequence
                      [ O.apply (O.ident "f") [ O.ident "M.x" ]; O.unit ]));
            ]));
    case "a sequence of nothing is refused" (fun () ->
        match O.sequence [] with
        | _ -> Alcotest.fail "wrote a sequence of nothing"
        | exception Invalid_argument _ -> ());
    case "a text that is not OCaml is refused" (fun () ->
        match
          O.format ~syntax:Ocamlformat_lib.Syntax.Structure ~path:"x.ml" ~banner
            "let = 1"
        with
        | _ -> Alcotest.fail "formatted what is not OCaml"
        | exception Invalid_argument _ -> ());
  ]

let () = Alcotest.run "ocaml_syntax" [ ("the printer", cases) ]
