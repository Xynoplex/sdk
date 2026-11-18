(* The two properties as the C# SDK reads them as it builds. *)

let paths = [ "csharp/sdk/generators/Xynolog.Generator/unicode-case.json" ]

let comment ~version ~notice =
  Printf.sprintf
    "Generated from Unicode %s's DerivedCoreProperties.txt (codegen/ucd); do \
     not edit. Regenerate: make generate (codegen/lib/unicode_case). The code \
     points Unicode gives the Cased and the Case_Ignorable property, each as \
     ascending ranges of a first and a last code point: what decides whether a \
     capital sigma ends a word \
     (protocol/specs/src/annotations/reconcile-cases.json).\n\n\
     %s"
    version
    (String.concat "\n" notice)

let ranges list =
  Yojson.Safe.to_string
    (`List
       (List.map (fun (first, last) -> `List [ `Int first; `Int last ]) list))

let text ~version ~notice ~cased ~case_ignorable =
  "{\n  \"$comment\": "
  ^ Yojson.Safe.to_string (`String (comment ~version ~notice))
  ^ ",\n  \"cased\": " ^ ranges cased ^ ",\n  \"caseIgnorable\": "
  ^ ranges case_ignorable ^ "\n}\n"

let files ~version ~notice ~cased ~case_ignorable =
  let text = text ~version ~notice ~cased ~case_ignorable in
  List.map (fun path -> { Output.path; text }) paths
