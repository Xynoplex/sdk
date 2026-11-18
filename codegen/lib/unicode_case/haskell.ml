(* The tables as the Haskell SDK reads them
   (haskell/sdk/internal/Xynolog/Internal/UnicodeCase.hs): each code point's
   full lower-case mapping, the ones that differ where a word ends, and the
   Cased, Case_Ignorable and White_Space properties as ascending ranges. *)

module H = Haskell_syntax

let path = "haskell/sdk/generated/Xynolog/Internal/Generated/UnicodeCase.hs"

let mappings rows =
  H.Apply
    ( Name "Map.fromDistinctAscList",
      [
        List
          (List.map
             (fun (code, lower) ->
               H.Tuple
                 [
                   Int code;
                   List
                     (List.map (fun c -> H.Apply (Name "chr", [ Int c ])) lower);
                 ])
             rows);
      ] )

let ranges list =
  H.List (List.map (fun (first, last) -> H.Tuple [ Int first; Int last ]) list)

let text ~version ~notice ~cased ~case_ignorable ~white_space ~lowercase
    ~final_lowercase =
  H.text
    {
      banner =
        Banner.lines
          ~from_:
            (Printf.sprintf
               "Unicode %s's UnicodeData.txt, SpecialCasing.txt, \
                DerivedCoreProperties.txt and PropList.txt (codegen/ucd)"
               version)
          __FILE__
        @ ("" :: notice);
      extensions = [];
      name = "Xynolog.Internal.Generated.UnicodeCase";
      imports =
        [
          H.import "Data.Char" ~items:[ Plain "chr" ];
          H.import "Data.IntMap.Strict" ~qualified:"Map";
        ];
      body =
        [
          Values
            {
              about = [];
              type_ = T_apply ("Map.IntMap", [ T_name "String" ]);
              values =
                [
                  ("lowercase", mappings lowercase);
                  ("finalLowercase", mappings final_lowercase);
                ];
            };
          Values
            {
              about = [];
              type_ = T_list (T_tuple [ T_name "Int"; T_name "Int" ]);
              values =
                [
                  ("casedRanges", ranges cased);
                  ("caseIgnorableRanges", ranges case_ignorable);
                  ("whiteSpaceRanges", ranges white_space);
                ];
            };
        ];
    }

let file ~version ~notice ~cased ~case_ignorable ~white_space ~lowercase
    ~final_lowercase =
  {
    Output.path;
    text =
      text ~version ~notice ~cased ~case_ignorable ~white_space ~lowercase
        ~final_lowercase;
  }
