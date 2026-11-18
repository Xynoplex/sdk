(* The two properties as the Kotlin SDK's hand-written [cased] and
   [caseIgnorable] read them (xynolog.annotations): each as the firsts and
   the lasts of its ascending ranges, in two arrays. *)

module K = Kotlin_syntax

let arrays name ranges =
  let rec ascend after = function
    | [] -> ()
    | (first, last) :: rest ->
        if last < first || first <= after then
          Kotlin_sdk.Names.refuse "the ranges of %s do not ascend at %d..%d"
            name first last;
        ascend last rest
  in
  if ranges = [] then Kotlin_sdk.Names.refuse "the ranges of %s are none" name;
  ascend (-1) ranges;
  let array suffix points =
    K.property ~visibility:K.Internal
      ~value:
        (K.Same_line
           (K.call (K.Name "intArrayOf") (List.map (fun p -> K.Int p) points)))
      (name ^ "_" ^ suffix)
  in
  [ array "FIRSTS" (List.map fst ranges); array "LASTS" (List.map snd ranges) ]

let file ~version ~notice ~cased ~case_ignorable =
  Kotlin_sdk.data_file
    ~banner:
      (Banner.kotlin_lines
         ~from_:
           ("Unicode " ^ version ^ "'s DerivedCoreProperties.txt (codegen/ucd)")
         __FILE__
      @ ("" :: notice))
    ~package:"xynolog.annotations" ~name:"UnicodeCase" ~imports:[]
    (arrays "CASED" cased @ arrays "CASE_IGNORABLE" case_ignorable)
