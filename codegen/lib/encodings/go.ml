(* The table as the Go SDK's reader of a resource's text reads it
   (go/resources.go): Go's standard library has neither the standard's labels
   nor its single-byte encodings. *)

module G = Go_syntax

let path = "go/encodings_gen.go"

let pairs ~names rows =
  G.lines
    ~of_:(G.Slice (G.Struct_type [ (names, G.Named "string") ]))
    (List.map
       (fun (a, b) ->
         G.item (G.inline [ G.item (G.Ascii a); G.item (G.Ascii b) ]))
       rows)

let text (t : Table.t) =
  G.text
    {
      header =
        G.verbatim
          "Code generated from protocol/specs/src/text/encoding-cases.json; DO \
           NOT EDIT.\n\n\
           Regenerate: make generate (codegen/lib/encodings/go.ml)";
      package = "xynolog";
      imports = [];
      decls =
        [
          G.Var
            (G.spec
               ~doc:
                 (G.prose
                    (Printf.sprintf
                       "labelsOfEncodings is every label of the Encoding \
                        Standard, %d of them, each with the encoding it names. \
                        A label is matched in lower case, with no white space \
                        around it.%s"
                       (List.length t.labels)
                       (Table.undecoded t ~single_byte:"singleByteEncodings"
                          ~refused:"refusedEncodings")))
               "labelsOfEncodings"
               (pairs ~names:[ "label"; "encoding" ] t.labels));
          G.Var
            (G.spec
               ~doc:
                 (G.prose
                    "singleByteEncodings is, for each single-byte encoding, \
                     the 256 characters its bytes are: the one at n is the \
                     byte n's.")
               "singleByteEncodings"
               (pairs ~names:[ "encoding"; "everyByte" ] t.single_byte));
          G.Var
            (G.spec
               ~doc:
                 (G.prose
                    "refusedEncodings is the encodings whose labels are \
                     refused: no text is read under them.")
               "refusedEncodings"
               (G.inline ~of_:(G.Slice (G.Named "string"))
                  (List.map (fun e -> G.item (G.Ascii e)) t.refused)));
        ];
    }

let file t = { Output.path; text = text t }
