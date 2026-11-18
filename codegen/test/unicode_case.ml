open Xynolog_codegen

let case name test = Alcotest.test_case name `Quick test
let file = "codegen/ucd/DerivedCoreProperties.txt"
let header = "# DerivedCoreProperties-17.0.0.txt\n# Date: 2025-07-30\n\n"
let read text = Ucd.read ~file text
let ranges = Alcotest.(list (pair int int))

let property t name =
  match Ucd.ranges t name with
  | Some ranges -> ranges
  | None -> Alcotest.failf "no property %s" name

let refuses text expected () =
  match read text with
  | Ok _ -> Alcotest.failf "expected the refusal\n  %s\nand none came" expected
  | Error error ->
      Alcotest.(check string) "refusal" expected (Decode.error_to_string error)

let reading =
  [
    case "its version, from its first line" (fun () ->
        Alcotest.(check (result string string))
          "version" (Ok "17.0.0")
          (Result.map
             (fun (t : Ucd.t) -> t.version)
             (Result.map_error Decode.error_to_string (read header))));
    case "a property's ranges, ascending and joined where they touch" (fun () ->
        match
          read
            (header
           ^ "# Derived Property:   Cased (Cased)\n\
              0041..005A    ; Cased # L&  [26] LATIN CAPITAL LETTER A..Z\n\
              0061..007A    ; Cased # L&  [26] LATIN SMALL LETTER A..Z\n\
              007B          ; Cased # Lo       A LETTER\n\
              00AA          ; Cased # Lo       FEMININE ORDINAL INDICATOR\n\n\
              # Total code points: 54\n\
              0300..036F    ; Case_Ignorable # Mn [112] COMBINING\n\
              094D          ; InCB; Linker # Mn       DEVANAGARI SIGN VIRAMA\n\
              10000..1000B  ; Cased # Lo  [12] LINEAR B\n")
        with
        | Error error -> Alcotest.fail (Decode.error_to_string error)
        | Ok t ->
            Alcotest.check ranges "Cased"
              [ (0x41, 0x5A); (0x61, 0x7B); (0xAA, 0xAA); (0x10000, 0x1000B) ]
              (property t "Cased");
            Alcotest.check ranges "Case_Ignorable"
              [ (0x300, 0x36F) ]
              (property t "Case_Ignorable");
            Alcotest.check ranges "InCB=Linker"
              [ (0x94D, 0x94D) ]
              (property t "InCB=Linker");
            Alcotest.(check bool) "absent" true (Ucd.ranges t "Math" = None));
    case "a file that names no version is refused"
      (refuses "# Derived Property: Math\n"
         (file
        ^ ": /: line 1: names no version: a UCD file's first line is its name, \
           <name>-<version>.txt"));
    case "an empty version is refused"
      (refuses "# DerivedCoreProperties-.txt\n"
         (file
        ^ ": /: line 1: names no version: a UCD file's first line is its name, \
           <name>-<version>.txt"));
    case "a code point of fewer than four digits is refused"
      (refuses
         (header ^ "41 ; Cased # x\n")
         (file ^ ": /: line 4: is no code point or range, property and comment"));
    case "a line of no form is refused"
      (refuses (header ^ "0041 Cased\n")
         (file ^ ": /: line 4: is no code point or range, property and comment"));
    case "a backward range is refused"
      (refuses
         (header ^ "005A..0041 ; Cased # x\n")
         (file ^ ": /: line 4: 005A..0041 is a backward range"));
    case "a code point past Unicode's is refused"
      (refuses
         (header ^ "110000 ; Cased # x\n")
         (file ^ ": /: line 4: 110000 is past the last code point"));
    case "a range out of order is refused"
      (refuses
         (header ^ "0061 ; Cased # x\n0041 ; Cased # x\n")
         (file ^ ": /: line 5: 0041 does not follow Cased's last range, 0061"));
  ]

let unicode_data_file = "codegen/ucd/UnicodeData.txt"
let special_file = "codegen/ucd/SpecialCasing.txt"
let special_header = "# SpecialCasing-17.0.0.txt\n# Date: 2025-07-30\n\n"

let unicode_data_line ?(lower = "") point =
  Printf.sprintf "%s;NAME;Lu;0;L;;;;;N;;;;%s;\n" point lower

let refused expected = function
  | Ok _ -> Alcotest.failf "expected the refusal\n  %s\nand none came" expected
  | Error error ->
      Alcotest.(check string) "refusal" expected (Decode.error_to_string error)

let mappings = Alcotest.(list (pair int (list int)))

let casing =
  Alcotest.testable
    (fun f { Ucd.code; lower; conditions } ->
      Format.fprintf f "%04X -> [%s] if [%s]" code
        (String.concat " " (List.map string_of_int lower))
        (String.concat " " conditions))
    ( = )

let special text =
  match Ucd.special_casing ~file:special_file text with
  | Ok (_, rows) -> rows
  | Error error -> Alcotest.fail (Decode.error_to_string error)

let mapping_files =
  [
    case "UnicodeData's simple lowercase mappings, by the fourteenth field"
      (fun () ->
        Alcotest.(check (result (list (pair int int)) string))
          "mappings"
          (Ok [ (0x41, 0x61); (0x130, 0x69) ])
          (Result.map_error Decode.error_to_string
             (Ucd.simple_lowercase ~file:unicode_data_file
                (unicode_data_line ~lower:"0061" "0041"
                ^ unicode_data_line "0061"
                ^ unicode_data_line ~lower:"0069" "0130"))));
    case "a UnicodeData line of other than fifteen fields is refused" (fun () ->
        refused
          (unicode_data_file ^ ": /: line 2: is no line of fifteen fields")
          (Ucd.simple_lowercase ~file:unicode_data_file
             (unicode_data_line "0041" ^ "0042;NAME;Lu\n")));
    case "UnicodeData out of order is refused" (fun () ->
        refused
          (unicode_data_file ^ ": /: line 2: 0041 does not follow 0042")
          (Ucd.simple_lowercase ~file:unicode_data_file
             (unicode_data_line "0042" ^ unicode_data_line "0041")));
    case "SpecialCasing's rows, with and without conditions" (fun () ->
        Alcotest.(check (list casing))
          "rows"
          [
            { code = 0xDF; lower = [ 0xDF ]; conditions = [] };
            { code = 0x3A3; lower = [ 0x3C2 ]; conditions = [ "Final_Sigma" ] };
            { code = 0x307; lower = []; conditions = [ "tr"; "After_I" ] };
          ]
          (special
             (special_header
            ^ "00DF; 00DF; 0053 0073; 0053 0053; # LATIN SMALL LETTER SHARP S\n\
               03A3; 03C2; 03A3; 03A3; Final_Sigma; # GREEK CAPITAL LETTER SIGMA\n\
               0307; ; 0307; 0307; tr After_I; # COMBINING DOT ABOVE\n")));
    case "a SpecialCasing row of no form is refused" (fun () ->
        refused
          (special_file
         ^ ": /: line 4: is no code point, its lower, title and upper mappings \
            and conditions")
          (Ucd.special_casing ~file:special_file
             (special_header ^ "00DF; 00DF; 0053 0073 # no fourth\n")));
    case
      "the full mappings: SpecialCasing's that always hold, else \
       UnicodeData's, where each changes the code point" (fun () ->
        Alcotest.check mappings "lowercase"
          [ (0x41, [ 0x61 ]); (0x130, [ 0x69; 0x307 ]) ]
          (Unicode_case.lowercase
             ~simple:[ (0x41, 0x61); (0x130, 0x69) ]
             ~special:
               (special
                  (special_header
                 ^ "00DF; 00DF; 0053 0073; 0053 0053; # SHARP S\n\
                    0130; 0069 0307; 0130; 0130; # I WITH DOT ABOVE\n\
                    0130; 0069; 0130; 0130; tr; # I WITH DOT ABOVE\n"))));
    case "the final mappings: Final_Sigma's, where they differ" (fun () ->
        Alcotest.(check (result mappings string))
          "final"
          (Ok [ (0x3A3, [ 0x3C2 ]) ])
          (Result.map_error
             (fun errors ->
               String.concat "; " (List.map Decode.error_to_string errors))
             (Unicode_case.final_lowercase
                ~lowercase:[ (0x3A3, [ 0x3C3 ]); (0x41, [ 0x61 ]) ]
                ~special:
                  (special
                     (special_header
                    ^ "03A3; 03C2; 03A3; 03A3; Final_Sigma; # SIGMA\n\
                       0041; 0061; 0041; 0041; Final_Sigma; # A\n\
                       0049; 0131; 0049; 0049; tr Not_Before_Dot; # I\n")))));
    case "a context no language decides but Final_Sigma is refused" (fun () ->
        match
          Unicode_case.final_lowercase ~lowercase:[]
            ~special:
              (special
                 (special_header ^ "0307; 0307; ; ; After_Soft_Dotted; # DOT\n"))
        with
        | Ok _ -> Alcotest.fail "accepted a context the SDKs do not implement"
        | Error errors ->
            Alcotest.(check (list string))
              "refusal"
              [
                special_file
                ^ ": /: 0307 lower-cases by After_Soft_Dotted, a context no \
                   language decides that the SDKs do not implement";
              ]
              (List.map Decode.error_to_string errors));
  ]

let haskell =
  [
    case "the Haskell tables" (fun () ->
        let text =
          Unicode_case.Haskell.text ~version:"17.0.0" ~notice:[ "N." ]
            ~cased:[ (65, 90) ]
            ~case_ignorable:[ (39, 39) ]
            ~white_space:[ (9, 13); (32, 32) ]
            ~lowercase:[ (65, [ 97 ]); (304, [ 105; 775 ]) ]
            ~final_lowercase:[ (931, [ 962 ]) ]
        in
        let body =
          String.concat "\n"
            (List.filter
               (fun l -> not (String.starts_with ~prefix:"--" l))
               (String.split_on_char '\n' text))
        in
        Alcotest.(check string)
          "module"
          "module Xynolog.Internal.Generated.UnicodeCase (lowercase, \
           finalLowercase, casedRanges, caseIgnorableRanges, whiteSpaceRanges) \
           where\n\n\
           import Data.Char (chr)\n\
           import Data.IntMap.Strict qualified as Map\n\n\
           lowercase, finalLowercase :: Map.IntMap String\n\
           lowercase = Map.fromDistinctAscList [(65, [chr 97]), (304, [chr \
           105, chr 775])]\n\
           finalLowercase = Map.fromDistinctAscList [(931, [chr 962])]\n\n\
           casedRanges, caseIgnorableRanges, whiteSpaceRanges :: [(Int, Int)]\n\
           casedRanges = [(65, 90)]\n\
           caseIgnorableRanges = [(39, 39)]\n\
           whiteSpaceRanges = [(9, 13), (32, 32)]\n"
          body);
  ]

let go =
  [
    case "a range table, split at the Basic Multilingual Plane" (fun () ->
        Alcotest.(check string)
          "table"
          "&unicode.RangeTable{\n\
           \tR16: []unicode.Range16{\n\
           \t\t{0x0041, 0x005a, 1},\n\
           \t\t{0x00c0, 0x00ff, 1},\n\
           \t\t{0x0101, 0x0102, 1},\n\
           \t\t{0xfff0, 0xffff, 1},\n\
           \t},\n\
           \tR32: []unicode.Range32{\n\
           \t\t{0x10000, 0x10010, 1},\n\
           \t\t{0x1f600, 0x1f64f, 1},\n\
           \t},\n\
           \tLatinOffset: 2,\n\
           }"
          (Go_syntax.expr ~depth:0
             (Unicode_case.Go.range_table
                [
                  (0x41, 0x5A);
                  (0xC0, 0xFF);
                  (0x101, 0x102);
                  (0xFFF0, 0x10010);
                  (0x1F600, 0x1F64F);
                ])));
  ]

let json =
  [
    case "the JSON copy" (fun () ->
        Alcotest.(check string)
          "text"
          ("{\n  \"$comment\": "
          ^ Yojson.Safe.to_string
              (`String
                 (Unicode_case.Json.comment ~version:"17.0.0" ~notice:[ "N." ]))
          ^ ",\n\
            \  \"cased\": [[65,90],[97,122]],\n\
            \  \"caseIgnorable\": [[768,879]]\n\
             }\n")
          (Unicode_case.Json.text ~version:"17.0.0" ~notice:[ "N." ]
             ~cased:[ (65, 90); (97, 122) ]
             ~case_ignorable:[ (768, 879) ]));
  ]

let () =
  Alcotest.run "unicode-case"
    [
      ("the UCD", reading);
      ("the case mappings", mapping_files);
      ("Haskell", haskell);
      ("Go", go);
      ("JSON", json);
    ]
