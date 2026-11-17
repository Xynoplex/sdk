(* The two properties as Go range tables, in package annotations: Go's
   unicode package gives neither. *)

module G = Go_syntax

let path = "go/annotations/unicodecase_gen.go"

(* [ranges] as a [*unicode.RangeTable]: the ranges of the Basic
   Multilingual Plane as 16-bit ones, those beyond it as 32-bit ones, and a
   range that crosses from the one to the other split in two. *)
let range_table ranges =
  let r16 =
    List.filter_map
      (fun (first, last) ->
        if first <= 0xFFFF then Some (first, min last 0xFFFF) else None)
      ranges
  and r32 =
    List.filter_map
      (fun (first, last) ->
        if last > 0xFFFF then Some (max first 0x10000, last) else None)
      ranges
  in
  let rows type_ pairs =
    G.lines ~of_:(G.Slice (G.Named type_))
      (List.map
         (fun (first, last) ->
           G.item
             (G.inline
                [ G.item (G.Hex first); G.item (G.Hex last); G.item (G.Int 1) ]))
         pairs)
  in
  G.Unary
    ( "&",
      G.lines ~of_:(G.Named "unicode.RangeTable")
        [
          G.keyed "R16" (rows "unicode.Range16" r16);
          G.keyed "R32" (rows "unicode.Range32" r32);
          G.keyed "LatinOffset"
            (G.Int
               (List.length (List.filter (fun (_, last) -> last <= 0xFF) r16)));
        ] )

let table ~doc name ranges =
  G.Var (G.spec ~doc:[ G.Line doc ] name (range_table ranges))

let text ~version ~cased ~case_ignorable =
  G.text
    {
      header =
        G.verbatim
          (Printf.sprintf
             "Code generated from Unicode %s's DerivedCoreProperties.txt \
              (codegen/ucd); DO NOT EDIT.\n\n\
              Regenerate: make generate (codegen/lib/unicode_case/go.ml)\n\
              C#'s and Kotlin's copies of the two properties are generated \
              from the same data."
             version);
      package = "annotations";
      imports = [ [ "unicode" ] ];
      decls =
        [
          table
            ~doc:"cased is the code points Unicode gives the Cased property."
            "cased" cased;
          table
            ~doc:
              "caseIgnorable is the code points Unicode gives the \
               Case_Ignorable property."
            "caseIgnorable" case_ignorable;
        ];
    }

let file ~version ~cased ~case_ignorable =
  { Output.path; text = text ~version ~cased ~case_ignorable }
