(* What the C# printer writes for what a writer states, laid out as dotnet
   format leaves it, and what it refuses to write. *)

open Xynolog_codegen
module C = Csharp_syntax

let case name test = Alcotest.test_case name `Quick test
let writes expected text () = Alcotest.(check string) "text" expected (text ())

let refuses text () =
  match text () with
  | written -> Alcotest.failf "wrote %S" written
  | exception Invalid_argument _ -> ()

(* A UTF-16 unit's escape: a backslash, [u] and its hex. *)
let u hex = "\\" ^ "u" ^ hex
let expr e () = String.concat "\n" (C.expr ~depth:0 e)
let stmt s () = String.concat "\n" (C.stmt ~depth:0 s)
let decl d () = String.concat "\n" (C.decl ~depth:0 d)

let record ?(modifiers = [ C.Public; Sealed ]) ?(spacing = C.Packed) name
    members =
  C.Type
    {
      attributes = [];
      modifiers;
      kind = Record;
      name;
      params = None;
      base = None;
      body = Some (spacing, members);
    }

let property name =
  C.Property
    {
      modifiers = [ Public ];
      type_ = T "string";
      name;
      accessors = [ Get; Init ];
      value = None;
    }

let cases =
  [
    case "a string literal escapes what is not printable ASCII"
      (writes
         ({|"a\"\\\n\t|} ^ u "00E9" ^ u "D83D" ^ u "DE00" ^ u "0085" ^ {|"|})
         (expr (Str "a\"\\\n\t\195\169\240\159\152\128\194\133")));
    case "a char literal is a UTF-16 code unit"
      (writes ("'" ^ u "FEFF" ^ "'") (expr (Char 0xFEFF)));
    case "a quote char is escaped" (writes {|'\''|} (expr (Char 0x27)));
    case "a char beyond UTF-16's units is refused"
      (refuses (expr (Char 0x10000)));
    case "a name may be qualified, from global:: on"
      (writes "global::System.Text.Json.JsonElement"
         (expr (Name "global::System.Text.Json.JsonElement")));
    case "a keyword is no name" (refuses (expr (Name "class")));
    case "a name that is none is refused" (refuses (expr (Name "not-a-name")));
    case "an unsigned constant is hexadecimal digits"
      (writes "0x40000000U" (expr (Uint_hex "40000000")));
    case "an unsigned constant of no hexadecimal digits is refused"
      (refuses (expr (Uint_hex "4G")));
    case "an operand that binds less tightly than its place is refused"
      (refuses
         (expr
            (Binary (Conditional (Name "a", Name "b", Name "c"), And, Name "d"))));
    case "a conditional's arms may be a cast null and a call"
      (writes "a ? (long?)null : f(a)"
         (expr
            (Conditional
               ( Name "a",
                 Cast (Nullable (T "long"), Null),
                 Call (Name "f", [], [ Arg (Name "a") ]) ))));
    case "a call's type arguments and out variable"
      (writes
         "x.TryRead<global::Xynolog.Types.Stated<string?>>(\"k\", out var p0)"
         (expr
            (Call
               ( Member (Name "x", "TryRead"),
                 [
                   Generic
                     ("global::Xynolog.Types.Stated", [ Nullable (T "string") ]);
                 ],
                 [ Arg (Str "k"); Out_var "p0" ] ))));
    case "a switch expression's arms are a line each, its braces at its line's"
      (writes
         "code switch\n\
          {\n\
         \    \"a\" => A.B,\n\
         \    null => \"none\",\n\
         \    _ => throw new global::System.Exception(\"no\"),\n\
          }"
         (expr
            (Switch
               ( Name "code",
                 [
                   (Value (Str "a"), Name "A.B");
                   (Value Null, Str "none");
                   ( Discard,
                     Throw
                       (New
                          {
                            type_ = Some (T "global::System.Exception");
                            args = Some [ Arg (Str "no") ];
                            init = None;
                          }) );
                 ] ))));
    case "an object initializer assigns a member a line"
      (writes "new X\n{\n    A = 1,\n    B = \"b\",\n}"
         (expr
            (New
               {
                 type_ = Some (T "X");
                 args = None;
                 init = Some (Assigns [ ("A", Int 1); ("B", Str "b") ]);
               })));
    case "an array is made on one line"
      (writes "new string[] { \"a\", \"b\" }"
         (expr (Array_new (T "string", [ Str "a"; Str "b" ]))));
    case "an if's block is braced on lines of its own"
      (writes "if (value.A is not null)\n{\n    return true;\n}"
         (stmt
            (If
               (Is_not_null (Member (Name "value", "A")), [ Return (Bool true) ]))));
    case "a foreach of one statement is one line"
      (writes "foreach (var pair in xs) { f(pair); }"
         (stmt
            (Foreach
               {
                 name = "pair";
                 over = Name "xs";
                 body = Do (Call (Name "f", [], [ Arg (Name "pair") ]));
               })));
    case "a switch statement's cases are a line each"
      (writes
         "switch (value)\n\
          {\n\
         \    case X.ACase selected: f(selected); break;\n\
         \    default: throw new E();\n\
          }"
         (stmt
            (Switch_stmt
               {
                 on = Name "value";
                 cases =
                   [
                     ( T "X.ACase",
                       "selected",
                       Do (Call (Name "f", [], [ Arg (Name "selected") ])) );
                   ];
                 default =
                   Throw_stmt
                     (New { type_ = Some (T "E"); args = Some []; init = None });
               })));
    case "a statement that only reads is refused"
      (refuses (stmt (Do (Name "x"))));
    case "a packed type's members are a line each, its braces Allman's"
      (writes
         "public sealed record R\n\
          {\n\
         \    public string A { get; init; }\n\
         \    public string B => \"b\";\n\
          }"
         (decl
            (record "R"
               [
                 property "A";
                 Expression_property
                   {
                     modifiers = [ Public ];
                     type_ = T "string";
                     name = "B";
                     value = Str "b";
                   };
               ])));
    case "a spaced type's members are apart"
      (writes
         "public sealed record R\n\
          {\n\
         \    public string A { get; init; }\n\n\
         \    public string B { get; init; }\n\
          }"
         (decl (record ~spacing:Spaced "R" [ property "A"; property "B" ])));
    case "a record of a primary constructor and no body"
      (writes "public sealed record ACase(long Value) : U;"
         (decl
            (Type
               {
                 attributes = [];
                 modifiers = [ Public; Sealed ];
                 kind = Record;
                 name = "ACase";
                 params =
                   Some [ { by = `Value; type_ = T "long"; name = "Value" } ];
                 base = Some (T "U");
                 body = None;
               })));
    case "an enum's members are a line each, an attribute above it"
      (writes
         "[global::System.Text.Json.Serialization.JsonConverter(typeof(KJsonConverter))]\n\
          public enum K\n\
          {\n\
         \    A,\n\
         \    B,\n\
          }"
         (decl
            (Enum
               {
                 attributes =
                   [
                     {
                       name =
                         "global::System.Text.Json.Serialization.JsonConverter";
                       args = [ Typeof (T "KJsonConverter") ];
                     };
                   ];
                 modifiers = [ Public ];
                 name = "K";
                 members = [ "A"; "B" ];
               })));
    case "a file opens auto-generated, its header after, and ends a line"
      (writes
         "// <auto-generated/>\n\
          // Generated from x; do not edit.\n\
          #nullable enable\n\
          namespace Xynolog.Types;\n\n\
          public sealed record R\n\
          {\n\
         \    public string A { get; init; }\n\
          }\n" (fun () ->
           C.text
             {
               header = [ "Generated from x; do not edit." ];
               nullable = true;
               usings = [];
               namespace = "Xynolog.Types";
               decls = [ record "R" [ property "A" ] ];
             }));
  ]

let () = Alcotest.run "csharp_syntax" [ ("the printer", cases) ]
