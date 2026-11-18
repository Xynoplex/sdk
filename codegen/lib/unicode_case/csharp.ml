(* The two properties as C# range tables, in Xynolog.Annotations' partial
   UnicodeCase: .NET gives neither. Whether a code point lies in one is the
   SDK's own (Annotations/UnicodeCase.cs). *)

module C = Csharp_syntax

let path = "csharp/sdk/src/Xynolog/Generated/UnicodeCase.g.cs"

(* A table's first or last code points, as the span the SDK searches. *)
let span name points =
  C.Expression_property
    {
      modifiers = [ Private; Static ];
      type_ = C.Generic ("global::System.ReadOnlySpan", [ C.T "int" ]);
      name;
      value = C.Collection (List.map (fun p -> C.Int p) points);
    }

let text ~version ~notice ~cased ~case_ignorable =
  let tables =
    List.concat_map
      (fun (name, ranges) ->
        [
          span (name ^ "Firsts") (List.map fst ranges);
          span (name ^ "Lasts") (List.map snd ranges);
        ])
      [ ("Cased", cased); ("CaseIgnorable", case_ignorable) ]
  in
  C.text
    {
      header =
        Banner.lines
          ~from_:
            (Printf.sprintf
               "Unicode %s's DerivedCoreProperties.txt (codegen/ucd)" version)
          __FILE__
        @ ("" :: notice);
      nullable = false;
      usings = [];
      namespace = "Xynolog.Annotations";
      decls =
        [
          C.Type
            {
              attributes = [];
              modifiers = [ Internal; Static; Partial ];
              kind = Class;
              name = "UnicodeCase";
              params = None;
              base = None;
              body = Some (Spaced, tables);
            };
        ];
    }

let file ~version ~notice ~cased ~case_ignorable =
  { Output.path; text = text ~version ~notice ~cased ~case_ignorable }
