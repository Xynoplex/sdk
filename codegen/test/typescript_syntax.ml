(* What the TypeScript printer writes for what a writer states, and what it
   refuses to write. *)

open Xynolog_codegen
module T = Typescript_syntax

let case name test = Alcotest.test_case name `Quick test
let writes expected text () = Alcotest.(check string) "text" expected (text ())

let refuses text () =
  match text () with
  | written -> Alcotest.failf "wrote %S" written
  | exception Invalid_argument _ -> ()

let expr e () = T.expr ~depth:0 e
let decl d () = T.decl d
let name n = T.Name n

let cases =
  [
    case "a string is quoted as it is stated"
      (writes {|['it\'s', "say \"hi\""]|}
         (expr
            (T.Array
               {
                 layout = Inline;
                 elements =
                   [
                     T.element (Str (Single, "it's"));
                     T.element (Str (Double, "say \"hi\""));
                   ];
               })));
    case "packed has no space after a comma"
      (writes {|["a","b"]|}
         (expr (T.strings ~quote:Double Packed [ "a"; "b" ])));
    case "a name that is none is refused" (refuses (expr (name "a-b")));
    case "an operand that binds tighter is bare"
      (writes {|a === undefined || f(a)|}
         (expr
            (Binary
               ( Binary (name "a", Strict_eq, Undefined),
                 Or,
                 Call (name "f", [ name "a" ]) ))));
    case "an operand as tight and on the left is bare"
      (writes {|"x" + owner + "y"|}
         (expr
            (Binary
               ( Binary (Str (Double, "x"), Plus, name "owner"),
                 Plus,
                 Str (Double, "y") ))));
    case "an operand as tight and on the right is refused"
      (refuses
         (expr (Binary (name "a", Plus, Binary (name "b", Plus, name "c")))));
    case "an operand that binds looser is refused"
      (refuses (expr (Binary (Binary (name "a", Or, name "b"), And, name "c"))));
    case "a chain puts each operand after the first on a line of its own"
      (writes "a\n  && (b || c)\n  && d"
         (expr
            (Chain
               ( And,
                 [ name "a"; Paren (Binary (name "b", Or, name "c")); name "d" ]
               ))));
    case "a doc comment is one line"
      (refuses (decl (T.Comment [ Doc "two\nlines" ])));
    case "a block closes what its line would"
      (writes "/**\n * a *\\/ b\n *\n */"
         (decl (T.Comment [ Block [ "a */ b"; "" ] ])));
    case "a comment has no place in one line"
      (refuses
         (expr
            (T.Object
               {
                 layout = Inline;
                 column = None;
                 entries = [ T.entry ~about:[ Doc "x" ] (Ident "a") (Int 1) ];
               })));
    case "a row's inline value aligns its second entry"
      (writes "{\n  'a':   { x: 1,   y: 2 },\n}"
         (expr
            (T.rows ~column:9
               [
                 T.entry
                   (Quoted (Single, "a"))
                   (Object
                      {
                        layout = Inline;
                        column = Some 19;
                        entries =
                          [
                            T.entry (Ident "x") (Int 1);
                            T.entry (Ident "y") (Int 2);
                          ];
                      });
               ])));
    case "an inline object's column is a row's"
      (refuses
         (expr
            (T.Object
               {
                 layout = Inline;
                 column = Some 4;
                 entries = [ T.entry (Ident "a") (Int 1) ];
               })));
    case "a conditional in rows opens on a line of its own"
      (writes
         "type If<K extends string> =\n  K extends 'a'\n    ? never\n    : K;"
         (decl
            (T.type_alias "If" ~export:false
               ~params:[ { param = "K"; bound = Some (T_name "string") } ]
               (T_conditional
                  {
                    layout = Rows;
                    check = T_name "K";
                    extends = T_str (Single, "a");
                    then_ = T_name "never";
                    else_ = T_name "K";
                  }))));
    case "a trailing comment follows its member"
      (writes "type M = {\n  a: string; // why\n};"
         (decl
            (T.type_alias "M" ~export:false
               (T_object
                  ( Rows,
                    [
                      T.member ~trailing:"// why" (Ident "a") (T_name "string");
                    ] )))));
    case "hexadecimal digits are refused when they are none"
      (refuses (expr (Hex "0x40")));
  ]

let () = Alcotest.run "typescript_syntax" [ ("the printer", cases) ]
