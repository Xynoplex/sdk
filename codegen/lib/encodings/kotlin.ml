(* The Encoding Standard as the Kotlin SDK's reader of a resource's text reads
   it (xynolog.resources): the encoding each label names, the text each
   single-byte encoding's 256 bytes are, and the encodings no text is read
   under; every string with all but printable ASCII escaped, so each
   character can be seen. *)

module K = Kotlin_syntax

let map ~about name pairs =
  K.property ~about:(K.Doc about) ~visibility:K.Internal
    ~type_:(K.Generic ("Map", [ K.Type "String"; K.Type "String" ]))
    ~value:
      (K.Same_line
         (K.call ~layout:K.Lines (K.Name "mapOf")
            (List.map
               (fun (a, b) -> K.Binary (K.Ascii a, K.To, K.Ascii b))
               pairs)))
    name

let file (t : Table.t) =
  Kotlin_sdk.table ~from_:Table.file __FILE__ ~package:"xynolog.resources"
    ~name:"Encodings" ~imports:[]
    [
      map
        ~about:
          (Printf.sprintf
             "Every label of the Encoding Standard, with the encoding it \
              names: %d of them."
             (List.length t.labels))
        "ENCODING_OF_LABEL" t.labels;
      map
        ~about:
          "Each single-byte encoding: the text its 256 bytes are, in order, \
           one character to a byte, and U+FFFD where it gives a byte none."
        "SINGLE_BYTE" t.single_byte;
      K.property
        ~about:
          (K.Doc
             "The encodings the standard reads no text under: every label of \
              each is refused.")
        ~visibility:K.Internal
        ~type_:(K.Generic ("Set", [ K.Type "String" ]))
        ~value:
          (K.Same_line
             (K.call (K.Name "setOf") (List.map (fun e -> K.Ascii e) t.refused)))
        "REFUSED";
    ]
