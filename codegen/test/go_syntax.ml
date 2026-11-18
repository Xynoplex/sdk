(* How the Go printer lays out what gofmt lays out by width: a func's body on
   its signature's line, the bodies of adjacent ones aligned, and a struct on
   one line. Each expected text is gofmt's own layout of it. *)

open Xynolog_codegen
module G = Go_syntax

let case name test = Alcotest.test_case name `Quick test
let check = Alcotest.(check string)
let text decl = G.decl decl

(* A func of no receiver whose one statement returns [text], the two
   together [width] columns. *)
let returning width =
  let signature = "func f() string" in
  let text =
    String.make
      (width - String.length signature - String.length "return \"\"")
      'a'
  in
  G.func ~results:(G.Unnamed [ G.Named "string" ]) "f"
    (G.One_line (G.Return [ G.Quoted text ]))

let marker ?(doc = []) member =
  G.func ~doc ~receiver:("", G.Named member) "memberOfU" G.Empty

let told member =
  G.func ~receiver:("", G.Named member)
    ~results:(G.Unnamed [ G.Named "string"; G.Named "string" ])
    "told"
    (G.One_line (G.Return [ G.Quoted "kind"; G.Quoted member ]))

let cases =
  [
    case "a body stays on its signature's line under 100 columns" (fun () ->
        check "one line"
          ("func f() string { return \"" ^ String.make 75 'a' ^ "\" }")
          (text (returning 99)));
    case "a body of 100 columns with its signature goes below it" (fun () ->
        check "below"
          ("func f() string {\n\treturn \"" ^ String.make 76 'a' ^ "\"\n}")
          (text (returning 100)));
    case "an empty body too wide for the line opens and closes below" (fun () ->
        let param = String.make 85 'a' in
        check "below"
          ("func f(" ^ param ^ " string) {\n}")
          (text (G.func ~params:[ (param, G.Named "string") ] "f" G.Empty)));
    case "adjacent one-line funcs align their bodies" (fun () ->
        check "aligned"
          "func (Ab) memberOfU()             {}\n\
           func (Ab) told() (string, string) { return \"kind\", \"Ab\" }\n\
           func (C) memberOfU()              {}"
          (text (G.Adjacent [ marker "Ab"; told "Ab"; marker "C" ])));
    case "a func with a comment begins a run of its own" (fun () ->
        check "two runs"
          "func (Ab) told() (string, string) { return \"kind\", \"Ab\" }\n\
           // C is the last.\n\
           func (C) memberOfU() {}"
          (text
             (G.Adjacent
                [ told "Ab"; marker ~doc:(G.verbatim "C is the last.") "C" ])));
    case "a func written over several lines ends a run" (fun () ->
        check "apart"
          ("func (Ab) memberOfU() {}\n"
          ^ text (returning 100)
          ^ "\nfunc (C) memberOfU() {}")
          (text (G.Adjacent [ marker "Ab"; returning 100; marker "C" ])));
    case "a struct of no fields is on one line" (fun () ->
        check "empty" "type E struct{}"
          (text
             (G.Type
                {
                  doc = [];
                  name = "E";
                  def = G.Struct { fields = []; spacing = G.Packed };
                })));
    case "a struct of one field 30 columns wide is on one line" (fun () ->
        check "one line"
          ("type T struct{ x " ^ String.make 29 'a' ^ " }")
          (text
             (G.Type
                {
                  doc = [];
                  name = "T";
                  def =
                    G.Is (G.Struct_type ([ "x" ], G.Named (String.make 29 'a')));
                })));
    case "a struct of one field wider than gofmt keeps on a line is refused"
      (fun () ->
        Alcotest.check_raises "refused"
          (Invalid_argument
             ("Go_syntax: struct{ " ^ String.make 30 'a'
            ^ " } is too wide for gofmt to keep on a line"))
          (fun () ->
            ignore
              (G.type_text
                 (G.Struct_type ([ "x" ], G.Named (String.make 30 'a'))))));
  ]

let () = Alcotest.run "go_syntax" [ ("layout", cases) ]
