(* The Swift printer: what it writes is swift-format 6.4.2's fixed point
   under swift/sdk/.swift-format (each expected text here was checked to be
   one), a keyword is backticked where it names and not as a label, a string
   is escaped, a number grouped; and a name that is none is refused. *)

open Xynolog_codegen
module S = Swift_syntax

let case name test = Alcotest.test_case name `Quick test
let decl ?(doc = []) modifiers body = { S.doc; modifiers; body }

let file decls =
  {
    S.banner = [ "Banner." ];
    imports = [ { S.module_ = "Foundation"; testable = false } ];
    decls;
  }

let snippets =
  [
    ( "keywords",
      file
        [
          ( S.Blank,
            decl [ "public" ]
              (S.Enum
                 {
                   name = "Mode";
                   inherits = [ S.Named "String"; S.Named "Sendable" ];
                   layout = S.Lines;
                   members =
                     [
                       decl []
                         (S.Case
                            {
                              name = "default";
                              value = S.Raw (S.String "default");
                            });
                       decl []
                         (S.Case { name = "in"; value = S.Raw (S.String "in") });
                       decl []
                         (S.Case
                            {
                              name = "plain";
                              value = S.Raw (S.String "pl\"ain\\\n");
                            });
                     ];
                 }) );
          ( S.Blank,
            decl [ "public" ]
              (S.Func
                 {
                   name = "pick";
                   generics = [];
                   params =
                     [
                       {
                         label = Some "for";
                         name = "mode";
                         type_ = S.Named "Mode";
                         default = None;
                       };
                     ];
                   throws = false;
                   result = Some (S.Named "Int");
                   body =
                     {
                       layout = S.Lines;
                       stmts =
                         [
                           S.Switch
                             {
                               subject = S.Name "mode";
                               layout = S.Lines;
                               cases =
                                 [
                                   {
                                     patterns =
                                       [
                                         S.Implicit_member "default";
                                         S.Implicit_member "in";
                                       ];
                                     body =
                                       [ S.Return (Some (S.Int 1_234_567)) ];
                                   };
                                   {
                                     patterns = [];
                                     body = [ S.Return (Some (S.Int 0)) ];
                                   };
                                 ];
                             };
                         ];
                     };
                 }) );
          ( S.Line,
            decl [ "internal" ]
              (S.Property
                 {
                   var = false;
                   name = "picked";
                   type_ = None;
                   value =
                     Some
                       (S.Call
                          ( S.Name "pick",
                            [
                              {
                                label = Some "for";
                                value = S.Implicit_member "default";
                              };
                            ] ));
                 }) );
        ] );
    ( "wrapping",
      file
        [
          ( S.Blank,
            decl [ "internal" ]
              (S.Property
                 {
                   var = false;
                   name = "rows";
                   type_ =
                     Some
                       (S.Array_of
                          (S.Dictionary_of (S.Named "String", S.Named "Int")));
                   value =
                     Some
                       (S.Array
                          ( S.Lines,
                            [
                              S.Dictionary
                                ( S.Inline,
                                  List.init 9 (fun i ->
                                      ( S.String (Printf.sprintf "member-%d" i),
                                        S.Int (i * 1000) )) );
                              S.Dictionary
                                (S.Inline, [ (S.String "one", S.Int 1) ]);
                            ] ));
                 }) );
          ( S.Blank,
            decl [ "internal" ]
              (S.Property
                 {
                   var = false;
                   name = "call";
                   type_ = None;
                   value =
                     Some
                       (S.Try
                          (S.Call
                             ( S.Member (S.Name "decoder", "decode"),
                               [
                                 {
                                   label = None;
                                   value =
                                     S.Member
                                       (S.Name "SomeLongModelName", "self");
                                 };
                                 {
                                   label = Some "from";
                                   value =
                                     S.Call
                                       ( S.Member
                                           (S.Name "JSONSerialization", "data"),
                                         [
                                           {
                                             label = Some "withJSONObject";
                                             value = S.Name "object";
                                           };
                                           {
                                             label = Some "options";
                                             value = S.Array (S.Inline, []);
                                           };
                                         ] );
                                 };
                               ] )));
                 }) );
          ( S.Line,
            decl [ "internal" ]
              (S.Property
                 {
                   var = false;
                   name = "ratio";
                   type_ = Some (S.Named "Double");
                   value = Some (S.Float 1.0);
                 }) );
        ] );
    ( "guard",
      file
        [
          ( S.Blank,
            decl []
              (S.Func
                 {
                   name = "check";
                   generics = [];
                   params =
                     [
                       {
                         label = Some "_";
                         name = "text";
                         type_ = S.Named "String";
                         default = None;
                       };
                     ];
                   throws = true;
                   result = None;
                   body =
                     {
                       layout = S.Lines;
                       stmts =
                         [
                           S.Guard
                             {
                               conditions =
                                 [
                                   S.Is
                                     (S.Not
                                        (S.Member (S.Name "text", "isEmpty")));
                                   S.Let_bound
                                     ("first", S.Member (S.Name "text", "first"));
                                 ];
                               else_ =
                                 {
                                   layout = S.Lines;
                                   stmts =
                                     [ S.Throw (S.Call (S.Name "Failure", [])) ];
                                 };
                             };
                           S.Expr
                             (S.Call
                                ( S.Name "print",
                                  [ { label = None; value = S.Name "first" } ]
                                ));
                         ];
                     };
                 }) );
        ] );
  ]

let expected =
  [
    ( "keywords",
      {|// Banner.
import Foundation

public enum Mode: String, Sendable {
  case `default` = "default"
  case `in` = "in"
  case plain = "pl\"ain\\\u{a}"
}

public func pick(for mode: Mode) -> Int {
  switch mode {
  case .`default`, .`in`: return 1_234_567
  default: return 0
  }
}
internal let picked = pick(for: .`default`)
|}
    );
    ( "wrapping",
      {|// Banner.
import Foundation

internal let rows: [[String: Int]] = [
  [
    "member-0": 0, "member-1": 1000, "member-2": 2000, "member-3": 3000, "member-4": 4000,
    "member-5": 5000, "member-6": 6000, "member-7": 7000, "member-8": 8000,
  ],
  ["one": 1],
]

internal let call = try decoder.decode(
  SomeLongModelName.self, from: JSONSerialization.data(withJSONObject: object, options: []))
internal let ratio: Double = 1.0
|}
    );
    ( "guard",
      {|// Banner.
import Foundation

func check(_ text: String) throws {
  guard !text.isEmpty, let first = text.first else {
    throw Failure()
  }
  print(first)
}
|}
    );
  ]

let printed (n, tree) =
  case n (fun () ->
      Alcotest.(check string) n (List.assoc n expected) (S.print tree))

let refused what f =
  case what (fun () ->
      match f () with
      | exception Invalid_argument _ -> ()
      | _ -> Alcotest.failf "%s was printed" what)

let property name value =
  file
    [
      ( S.Blank,
        decl [ "internal" ]
          (S.Property { var = false; name; type_ = None; value = Some value })
      );
    ]

let () =
  Alcotest.run "swift_syntax"
    [
      ("layout", List.map printed snippets);
      ( "names",
        [
          refused "a name with a hyphen" (fun () ->
              S.print (property "a-b" (S.Int 1)));
          refused "a name opening with a digit" (fun () ->
              S.print (property "1a" (S.Int 1)));
          refused "a label that is no name" (fun () ->
              S.print
                (property "x"
                   (S.Call
                      (S.Name "f", [ { label = Some "a b"; value = S.Nil } ]))));
        ] );
    ]
