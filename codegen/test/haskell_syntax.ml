(* What the Haskell printer writes for what a writer states, and what it
   refuses to write. *)

open Xynolog_codegen
module H = Haskell_syntax

let case name test = Alcotest.test_case name `Quick test
let writes expected text () = Alcotest.(check string) "text" expected (text ())

let refuses text () =
  match text () with
  | written -> Alcotest.failf "wrote %S" written
  | exception Invalid_argument _ -> ()

let expr e () = H.expr ~depth:0 e
let decl d () = String.concat "\n" (H.decl d)

let cases =
  [
    case "a string literal escapes what is not printable ASCII"
      (writes {|"a\"\\\xe9\&\x1f600\&\xa\&"|}
         (expr (Str "a\"\\\195\169\240\159\152\128\n")));
    case "an application's argument that is one is parenthesised"
      (writes {|Row "x" (Just ["a"]) Nothing|}
         (expr
            (Apply
               ( Name "Row",
                 [
                   Str "x";
                   Apply (Name "Just", [ List [ Str "a" ] ]);
                   Name "Nothing";
                 ] ))));
    case "a name that is none is refused" (refuses (expr (Name "not-a-name")));
    case "a type's argument that is applied is parenthesised"
      (writes "x :: Map.Map Text (Vector.Vector Int)\nx = y"
         (decl
            (H.value "x"
               (T_apply
                  ( "Map.Map",
                    [
                      T_name "Text"; T_apply ("Vector.Vector", [ T_name "Int" ]);
                    ] ))
               (Name "y"))));
    case
      "a function's clauses are a line each, a constructor's held patterns \
       bracketed with it"
      (writes
         "name :: Kind -> Text\n\
          name A = \"a\"\n\
          name (C _ \"x\") = \"c\"\n\
          name B = \"b\""
         (decl
            (Value
               {
                 about = [];
                 name = "name";
                 type_ = T_fun (T_name "Kind", T_name "Text");
                 clauses =
                   [
                     { patterns = [ Constructor ("A", []) ]; body = Str "a" };
                     {
                       patterns =
                         [ Constructor ("C", [ Otherwise; Literal "x" ]) ];
                       body = Str "c";
                     };
                     { patterns = [ Constructor ("B", []) ]; body = Str "b" };
                   ];
               })));
    case "an instance of one line is written on its own line"
      (writes "instance ToJSON K where toJSON = String . name"
         (decl
            (H.instance "ToJSON" (T_name "K")
               [ H.method_ "toJSON" (Compose (Name "String", Name "name")) ])));
    case "a case puts each alternative on a line of its own"
      (writes
         "instance FromJSON K where\n\
         \  parseJSON = withText \"K\" $ \\value -> case value of\n\
         \    \"a\" -> pure A\n\
         \    _ -> fail \"no\""
         (decl
            (H.instance "FromJSON" (T_name "K")
               [
                 H.method_ "parseJSON"
                   (Dollar
                      ( Apply (Name "withText", [ Str "K" ]),
                        Lambda
                          ( "value",
                            Case
                              ( Name "value",
                                [
                                  ( Literal "a",
                                    Apply (Name "pure", [ Name "A" ]) );
                                  (Otherwise, Apply (Name "fail", [ Str "no" ]));
                                ] ) ) ));
               ])));
    case
      "an instance's context and head come before its clauses, a method's \
       patterns after its name"
      (writes
         "instance ToJSON c => ToJSON (Event c) where\n\
         \  toJSON (Done v) = object [\"kind\" .= (\"done\" :: Text), \"data\" \
          .= v]\n\
         \  toJSON Begun = object []"
         (decl
            (H.instance
               ~context:[ ("ToJSON", "c") ]
               "ToJSON"
               (T_apply ("Event", [ T_name "c" ]))
               [
                 ( "toJSON",
                   {
                     patterns = [ Constructor ("Done", [ Var "v" ]) ];
                     body =
                       Apply
                         ( Name "object",
                           [
                             List
                               [
                                 Infix
                                   ( Str "kind",
                                     [
                                       (".=", Typed (Str "done", T_name "Text"));
                                     ] );
                                 Infix (Str "data", [ (".=", Name "v") ]);
                               ];
                           ] );
                   } );
                 ( "toJSON",
                   {
                     patterns = [ Constructor ("Begun", []) ];
                     body = Apply (Name "object", [ List [] ]);
                   } );
               ])));
    case "an operand that is an operation is parenthesised"
      (writes {|R <$> (o .: "a") <*> (o .: "b")|}
         (expr
            (Infix
               ( Name "R",
                 [
                   ("<$>", Infix (Name "o", [ (".:", Str "a") ]));
                   ("<*>", Infix (Name "o", [ (".:", Str "b") ]));
                 ] ))));
    case "an operator that is none is refused"
      (refuses (expr (Infix (Name "a", [ ("plus", Name "b") ]))));
    case "a record writes a field a line, under its type's variables"
      (writes
         "data State v = State\n\
         \  { stateResults :: [v]\n\
         \  , stateBusy :: Bool\n\
         \  } deriving (Eq, Show)"
         (decl
            (H.record "State" ~params:[ "v" ] ~deriving:[ "Eq"; "Show" ]
               [
                 ("stateResults", T_list (T_name "v"));
                 ("stateBusy", T_name "Bool");
               ])));
    case "a record of no fields is refused"
      (refuses (decl (H.record "Empty" [])));
    case "a doc comment's line is one line"
      (refuses (decl (H.alias ~about:[ "two\nlines" ] "A" (T_name "B"))));
    case "a module exports what it declares, in order"
      (writes
         "-- Generated from x; do not edit.\n\
          {-# LANGUAGE OverloadedStrings #-}\n\
          module M (K(..), k) where\n\
          import Data.Text (Text)\n\
          data K = A deriving (Eq)\n\
          k :: Text\n\
          k = \"a\"\n" (fun () ->
           H.text
             {
               banner = [ "Generated from x; do not edit." ];
               extensions = [ "OverloadedStrings" ];
               name = "M";
               imports = [ H.import "Data.Text" ~items:[ Plain "Text" ] ];
               body =
                 [
                   H.data "K" [ H.constructor "A" ] ~deriving:[ "Eq" ];
                   H.value "k" (T_name "Text") (Str "a");
                 ];
             }));
  ]

let () = Alcotest.run "haskell_syntax" [ ("the printer", cases) ]
