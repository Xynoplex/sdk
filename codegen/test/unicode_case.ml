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

let go =
  [
    case "a range table, split at the Basic Multilingual Plane" (fun () ->
        Alcotest.(check string)
          "table"
          "var demo = &unicode.RangeTable{\n\
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
          (Unicode_case.Go.range_table "demo"
             [
               (0x41, 0x5A);
               (0xC0, 0xFF);
               (0x101, 0x102);
               (0xFFF0, 0x10010);
               (0x1F600, 0x1F64F);
             ]));
  ]

let json =
  [
    case "the JSON copy" (fun () ->
        Alcotest.(check string)
          "text"
          ("{\n  \"$comment\": "
          ^ Yojson.Safe.to_string
              (`String (Unicode_case.Json.comment ~version:"17.0.0"))
          ^ ",\n\
            \  \"cased\": [[65,90],[97,122]],\n\
            \  \"caseIgnorable\": [[768,879]]\n\
             }\n")
          (Unicode_case.Json.text ~version:"17.0.0"
             ~cased:[ (65, 90); (97, 122) ]
             ~case_ignorable:[ (768, 879) ]));
  ]

let () =
  Alcotest.run "unicode-case"
    [ ("the UCD", reading); ("Go", go); ("JSON", json) ]
