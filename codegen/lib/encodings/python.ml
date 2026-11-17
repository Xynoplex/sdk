(* The table as the Python SDK's reader of a resource's text reads it
   (python/sdk/src/xynolog/resources.py): Python's codecs have other labels
   and, for some bytes, other characters. *)

module P = Python_syntax

let path = "python/sdk/src/xynolog/_encodings.py"

let mapping =
  P.sub "Final"
    [
      P.item (P.sub "Mapping" [ P.item (P.Name "str"); P.item (P.Name "str") ]);
    ]

let rows pairs =
  P.Dict
    (P.items ~magic:true
       (List.map (fun (a, b) -> P.entry (P.Ascii a) (P.Ascii b)) pairs))

let text (t : Table.t) =
  P.text
    {
      header =
        Banner.python_lines ~from_:"protocol/specs/src/text/encoding-cases.json"
          __FILE__;
      doc =
        As_is
          "The Encoding Standard as the reader of a resource's text needs it: \
           the encoding each label names, and each single-byte encoding byte \
           by byte.";
      imports =
        [
          [
            P.From ("collections.abc", [ "Mapping" ]);
            P.From ("typing", [ "Final" ]);
          ];
        ];
      body =
        [
          P.assign "__all__"
            ~value:
              (P.List
                 (P.items
                    (List.map
                       (fun n -> P.item (P.Str n))
                       [ "ENCODING_OF_LABEL"; "REFUSED"; "SINGLE_BYTE" ])));
          P.assign
            ~about:
              [
                Line
                  (Printf.sprintf "Every label of the standard: %d of them."
                     (List.length t.labels));
              ]
            ~annotation:mapping ~value:(rows t.labels)
            ~doc:
              (As_is
                 ("The encoding each label of the standard names. A label is \
                   matched in lower case, with no white space around it."
                 ^ Table.undecoded t ~single_byte:"`SINGLE_BYTE`"
                     ~refused:"`REFUSED`"))
            "ENCODING_OF_LABEL";
          P.assign ~annotation:mapping ~value:(rows t.single_byte)
            ~doc:
              (As_is
                 "For each single-byte encoding, the 256 characters its bytes \
                  are: the one at `n` is the byte `n`'s.")
            "SINGLE_BYTE";
          P.assign ~annotation:(P.Name "Final")
            ~value:
              (P.call "frozenset"
                 [
                   P.item
                     (P.Set
                        (P.items
                           (List.map (fun e -> P.item (P.Ascii e)) t.refused)));
                 ])
            ~doc:
              (As_is
                 "The encodings whose labels are refused: no text is read \
                  under them.")
            "REFUSED";
        ];
    }

let file t = { Output.path; text = text t }
