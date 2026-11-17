(* The two properties as Go range tables, in package annotations: Go's
   unicode package gives neither. *)

let path = "go/annotations/unicodecase_gen.go"
let hex code = Printf.sprintf "0x%04x" code

(* [ranges] as the [*unicode.RangeTable] named [name]: the ranges of the Basic
   Multilingual Plane as 16-bit ones, those beyond it as 32-bit ones, and a
   range that crosses from the one to the other split in two. *)
let range_table name ranges =
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
  let rows pairs =
    String.concat "\n"
      (List.map
         (fun (first, last) ->
           Printf.sprintf "\t\t{%s, %s, 1}," (hex first) (hex last))
         pairs)
  in
  Printf.sprintf
    "var %s = &unicode.RangeTable{\n\
     \tR16: []unicode.Range16{\n\
     %s\n\
     \t},\n\
     \tR32: []unicode.Range32{\n\
     %s\n\
     \t},\n\
     \tLatinOffset: %d,\n\
     }"
    name (rows r16) (rows r32)
    (List.length (List.filter (fun (_, last) -> last <= 0xFF) r16))

let text ~version ~cased ~case_ignorable =
  Printf.sprintf
    "// Code generated from Unicode %s's DerivedCoreProperties.txt \
     (codegen/ucd); DO NOT EDIT.\n\
     //\n\
     // Regenerate: make generate (codegen/lib/unicode_case/go.ml)\n\
     // C#'s and Kotlin's copies of the two properties are generated from the \
     same data.\n\n\
     package annotations\n\n\
     import \"unicode\"\n\n\
     // cased is the code points Unicode gives the Cased property.\n\
     %s\n\n\
     // caseIgnorable is the code points Unicode gives the Case_Ignorable \
     property.\n\
     %s\n"
    version
    (range_table "cased" cased)
    (range_table "caseIgnorable" case_ignorable)

let file ~version ~cased ~case_ignorable =
  { Output.path; text = text ~version ~cased ~case_ignorable }
