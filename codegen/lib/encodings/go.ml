(* The table as the Go SDK's reader of a resource's text reads it
   (go/resources.go): Go's standard library has neither the standard's labels
   nor its single-byte encodings. *)

let path = "go/encodings_gen.go"

let text (t : Table.t) =
  let rows pairs =
    String.concat ""
      (List.map
         (fun (a, b) ->
           Printf.sprintf "\t{%s, %s},\n" (Text.ascii_quoted a)
             (Text.ascii_quoted b))
         pairs)
  in
  String.concat ""
    [
      "// Code generated from protocol/specs/src/text/encoding-cases.json; DO \
       NOT EDIT.\n\
       //\n\
       // Regenerate: make generate (codegen/lib/encodings/go.ml)\n\n\
       package xynolog\n\n";
      Text.go_comment ~indent:""
        (Printf.sprintf
           "labelsOfEncodings is every label of the Encoding Standard, %d of \
            them, each with the encoding it names. A label is matched in lower \
            case, with no white space around it.%s"
           (List.length t.labels)
           (Table.undecoded t ~single_byte:"singleByteEncodings"
              ~refused:"refusedEncodings"));
      "\nvar labelsOfEncodings = []struct{ label, encoding string }{\n";
      rows t.labels;
      "}\n\n";
      Text.go_comment ~indent:""
        "singleByteEncodings is, for each single-byte encoding, the 256 \
         characters its bytes are: the one at n is the byte n's.";
      "\nvar singleByteEncodings = []struct{ encoding, everyByte string }{\n";
      rows t.single_byte;
      "}\n\n";
      Text.go_comment ~indent:""
        "refusedEncodings is the encodings whose labels are refused: no text \
         is read under them.";
      "\nvar refusedEncodings = []string{";
      String.concat ", " (List.map Text.ascii_quoted t.refused);
      "}\n";
    ]

let file t = { Output.path; text = text t }
