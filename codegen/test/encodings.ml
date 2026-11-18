open Xynolog_codegen

let case name test = Alcotest.test_case name `Quick test
let file = "text/encoding-cases.json"

(* The 256 characters of a single-byte encoding: [lead] and then the
   characters of Latin-1 after it. *)
let every_byte lead =
  let out = Buffer.create 512 in
  Buffer.add_string out lead;
  for byte = Text.length lead to 255 do
    Buffer.add_utf_8_uchar out (Uchar.of_int byte)
  done;
  Buffer.contents out

let table cases =
  Printf.sprintf {|{"$comment":"c","runBy":{"ocaml":["test"]},"cases":[%s]}|}
    (String.concat "," cases)

let decoded encoding labels =
  Printf.sprintf {|{"encoding":%s,"labels":[%s],"bytes":"","text":""}|}
    (Text.quoted encoding)
    (String.concat "," (List.map Text.quoted labels))

let single_byte ?(characters = every_byte "") encoding labels =
  Printf.sprintf {|{"encoding":%s,"labels":[%s],"everyByte":%s}|}
    (Text.quoted encoding)
    (String.concat "," (List.map Text.quoted labels))
    (Text.quoted characters)

let refused encoding labels =
  Printf.sprintf {|{"encoding":%s,"labels":[%s],"refused":true}|}
    (Text.quoted encoding)
    (String.concat "," (List.map Text.quoted labels))

let decode text =
  Decode.run ~file
    (Yojson.Safe.from_string text)
    Tables.Text_encoding_cases.decode

let model text =
  match decode text with
  | Ok (t, _) -> t
  | Error error -> Alcotest.fail (Decode.error_to_string error)

let derive text = Encodings.Table.derive (model text)

let derived text =
  match derive text with
  | Ok t -> t
  | Error errors ->
      Alcotest.fail
        (String.concat "\n" (List.map Decode.error_to_string errors))

let refuses text expected () =
  match derive text with
  | Ok _ ->
      Alcotest.failf "expected the refusals\n  %s\nand none came"
        (String.concat "\n  " expected)
  | Error errors ->
      Alcotest.(check (list string))
        "refusals" expected
        (List.map Decode.error_to_string errors)

let model_refuses text expected () =
  match decode text with
  | Ok _ -> Alcotest.failf "expected the refusal\n  %s\nand none came" expected
  | Error error ->
      Alcotest.(check string) "refusal" expected (Decode.error_to_string error)

let the_model =
  [
    case "a case of each kind" (fun () ->
        let t =
          model
            (table
               [
                 decoded "utf-8" [ "utf-8" ];
                 single_byte "ibm866" [ "ibm866" ];
                 refused "big5" [ "big5" ];
               ])
        in
        Alcotest.(check (list string))
          "kinds"
          [ "decoded"; "single byte"; "refused" ]
          (List.map
             (fun (c : Tables.Text_encoding_cases.case) ->
               match c.kind with
               | Decoded _ -> "decoded"
               | Single_byte _ -> "single byte"
               | Refused -> "refused")
             t.cases));
    case "a refusal that is false is refused"
      (model_refuses
         (table [ {|{"encoding":"big5","labels":["big5"],"refused":false}|} ])
         (file ^ ": /cases/0/refused: a flag is true, or absent"));
    case "a case of two kinds is refused"
      (model_refuses
         (table
            [
              {|{"encoding":"big5","labels":["big5"],"refused":true,"bytes":"","text":""}|};
            ])
         (file ^ ": /cases/0/bytes: an unknown member"));
    case "a case of no kind is refused"
      (model_refuses
         (table [ {|{"encoding":"utf-8","labels":["utf-8"]}|} ])
         (file
        ^ ": /cases/0: is a case of no kind: it states bytes and their text, \
           everyByte, or refused"));
    case "a decoded case without its text is refused"
      (model_refuses
         (table [ {|{"encoding":"utf-8","labels":["utf-8"],"bytes":""}|} ])
         (file ^ ": /cases/0: lacks the member \"text\""));
  ]

let rules =
  [
    case
      "the labels, by label; the single-byte encodings, in the table's order; \
       the refused, by name; the decoded, in the table's order" (fun () ->
        let t =
          derived
            (table
               [
                 decoded "utf-8" [ "utf8"; "utf-8" ];
                 single_byte "koi8-r" [ "koi8-r"; "cskoi8r" ];
                 refused "gbk" [ "gbk" ];
                 single_byte "ibm866" [ "866"; "ibm866" ];
                 refused "big5" [ "big5" ];
                 decoded "utf-16le" [ "utf-16le" ];
               ])
        in
        Alcotest.(check (list (pair string string)))
          "labels"
          [
            ("866", "ibm866");
            ("big5", "big5");
            ("cskoi8r", "koi8-r");
            ("gbk", "gbk");
            ("ibm866", "ibm866");
            ("koi8-r", "koi8-r");
            ("utf-16le", "utf-16le");
            ("utf-8", "utf-8");
            ("utf8", "utf-8");
          ]
          t.labels;
        Alcotest.(check (list string))
          "single byte" [ "koi8-r"; "ibm866" ]
          (List.map fst t.single_byte);
        Alcotest.(check (list string)) "refused" [ "big5"; "gbk" ] t.refused;
        Alcotest.(check (list string))
          "decoded" [ "utf-8"; "utf-16le" ] t.decoded);
    case "an encoding not among its own labels is refused"
      (refuses
         (table [ refused "big5" [ "big5-hkscs" ] ])
         [ file ^ ": /cases/0/labels: lacks the case's own encoding, big5" ]);
    case "a label of two encodings is refused"
      (refuses
         (table
            [ refused "big5" [ "big5"; "x" ]; refused "gbk" [ "gbk"; "x" ] ])
         [ file ^ ": /cases/1/labels/1: is a label of big5 (/cases/0) already" ]);
    case "a label named twice in one case is refused"
      (refuses
         (table [ refused "big5" [ "big5"; "big5" ] ])
         [ file ^ ": /cases/0/labels/1: is a label of big5 (/cases/0) already" ]);
    case "a label in upper case is refused"
      (refuses
         (table [ refused "big5" [ "big5"; "Big5" ] ])
         [
           file
           ^ ": /cases/0/labels/1: is matched by no reader: a label is in \
              lower case, with no white space around it";
         ]);
    case "a label with white space around it is refused"
      (refuses
         (table [ refused "big5" [ "big5"; " x"; "y\012"; "a b" ] ])
         [
           file
           ^ ": /cases/0/labels/1: is matched by no reader: a label is in \
              lower case, with no white space around it";
           file
           ^ ": /cases/0/labels/2: is matched by no reader: a label is in \
              lower case, with no white space around it";
         ]);
    case "an empty label is refused"
      (refuses
         (table [ refused "big5" [ "big5"; "" ] ])
         [
           file
           ^ ": /cases/0/labels/1: is matched by no reader: a label is in \
              lower case, with no white space around it";
         ]);
    case "a single-byte encoding of 257 characters is refused"
      (refuses
         (table
            [
              single_byte
                ~characters:(every_byte "" ^ "x")
                "ibm866" [ "ibm866" ];
            ])
         [ file ^ ": /cases/0/everyByte: states 257 characters, not 256" ]);
    case "a single-byte encoding of other than 256 characters is refused"
      (refuses
         (table
            [
              single_byte
                ~characters:
                  (let all = every_byte "" in
                   (* U+00FF, the last, is two bytes. *)
                   String.sub all 0 (String.length all - 2))
                "ibm866" [ "ibm866" ];
            ])
         [ file ^ ": /cases/0/everyByte: states 255 characters, not 256" ]);
    case "256 characters, not 256 bytes" (fun () ->
        let t =
          derived
            (table
               [ single_byte ~characters:(every_byte "\u{1F600}é") "x" [ "x" ] ])
        in
        Alcotest.(check int)
          "characters" 256
          (Text.length (snd (List.hd t.single_byte))));
    case "every rule's refusal, in the table's order"
      (refuses
         (table
            [
              refused "big5" [ "x" ];
              single_byte ~characters:"" "gbk" [ "gbk"; "x" ];
            ])
         [
           file ^ ": /cases/0/labels: lacks the case's own encoding, big5";
           file ^ ": /cases/1/labels/1: is a label of big5 (/cases/0) already";
           file ^ ": /cases/1/everyByte: states 0 characters, not 256";
         ]);
  ]

let literals =
  [
    case "a string as printable ASCII, every other character escaped" (fun () ->
        Alcotest.(check string)
          "literal"
          {|"a\"\\ \b\t\n\u000b\f\r\u001f\u007f\u00e9\u20ac\uffff\U00010000\U0001f600"|}
          (Text.ascii_quoted
             "a\"\\ \b\t\n\011\012\r\031\127é€\u{FFFF}\u{10000}\u{1F600}"));
  ]

let small =
  table
    [
      decoded "utf-8" [ "utf-8"; "utf8" ];
      single_byte ~characters:(every_byte "\u{20AC}") "x-1" [ "x-1" ];
      refused "gbk" [ "gbk" ];
      decoded "utf-16le" [ "utf-16le" ];
      refused "big5" [ "big5" ];
    ]

let latin_1_after_the_first =
  let out = Buffer.create 2048 in
  for byte = 1 to 255 do
    Buffer.add_string out
      (if byte >= 0x20 && byte < 0x7F && byte <> 0x22 && byte <> 0x5C then
         String.make 1 (Char.chr byte)
       else
         match byte with
         | 0x22 -> "\\\""
         | 0x5C -> "\\\\"
         | 0x08 -> "\\b"
         | 0x09 -> "\\t"
         | 0x0A -> "\\n"
         | 0x0C -> "\\f"
         | 0x0D -> "\\r"
         | _ -> Printf.sprintf "\\u%04x" byte)
  done;
  Buffer.contents out

let every_byte_literal = "\"\\u20ac" ^ latin_1_after_the_first ^ "\""

let writers =
  [
    case "Go's table" (fun () ->
        Alcotest.(check string)
          "text"
          ("// Code generated from \
            protocol/specs/src/text/encoding-cases.json; DO NOT EDIT.\n\
            //\n\
            // Regenerate: make generate (codegen/lib/encodings/go.ml)\n\n\
            package xynolog\n\n\
            // labelsOfEncodings is every label of the Encoding Standard, 6 of \
            them, each\n\
            // with the encoding it names. A label is matched in lower case, \
            with no white\n\
            // space around it. An encoding that is neither in \
            singleByteEncodings nor in\n\
            // refusedEncodings is utf-8 or utf-16le, which no table here \
            decodes.\n\
            var labelsOfEncodings = []struct{ label, encoding string }{\n\
            \t{\"big5\", \"big5\"},\n\
            \t{\"gbk\", \"gbk\"},\n\
            \t{\"utf-16le\", \"utf-16le\"},\n\
            \t{\"utf-8\", \"utf-8\"},\n\
            \t{\"utf8\", \"utf-8\"},\n\
            \t{\"x-1\", \"x-1\"},\n\
            }\n\n\
            // singleByteEncodings is, for each single-byte encoding, the 256 \
            characters\n\
            // its bytes are: the one at n is the byte n's.\n\
            var singleByteEncodings = []struct{ encoding, everyByte string }{\n\
            \t{\"x-1\", " ^ every_byte_literal
         ^ "},\n\
            }\n\n\
            // refusedEncodings is the encodings whose labels are refused: no \
            text is read\n\
            // under them.\n\
            var refusedEncodings = []string{\"big5\", \"gbk\"}\n")
          (Encodings.Go.text (derived small)));
    case "Python's table" (fun () ->
        Alcotest.(check string)
          "text"
          ("# Generated from protocol/specs/src/text/encoding-cases.json; do \
            not edit.\n\
            # Regenerate: make generate (codegen/lib/encodings/python.ml)\n\
            # ruff: noqa: E501, I001, RUF002, RUF022, RUF100\n\n\
            \"\"\"The Encoding Standard as the reader of a resource's text \
            needs it: the encoding each label names, and each single-byte \
            encoding byte by byte.\"\"\"\n\n\
            from collections.abc import Mapping\n\
            from typing import Final\n\n\
            __all__ = [\"ENCODING_OF_LABEL\", \"REFUSED\", \"SINGLE_BYTE\"]\n\n\
            # Every label of the standard: 6 of them.\n\
            ENCODING_OF_LABEL: Final[Mapping[str, str]] = {\n\
           \    \"big5\": \"big5\",\n\
           \    \"gbk\": \"gbk\",\n\
           \    \"utf-16le\": \"utf-16le\",\n\
           \    \"utf-8\": \"utf-8\",\n\
           \    \"utf8\": \"utf-8\",\n\
           \    \"x-1\": \"x-1\",\n\
            }\n\
            \"\"\"The encoding each label of the standard names. A label is \
            matched in lower case, with no white space around it. An encoding \
            that is neither in `SINGLE_BYTE` nor in `REFUSED` is utf-8 or \
            utf-16le, which no table here decodes.\"\"\"\n\n\
            SINGLE_BYTE: Final[Mapping[str, str]] = {\n\
           \    \"x-1\": " ^ every_byte_literal
         ^ ",\n\
            }\n\
            \"\"\"For each single-byte encoding, the 256 characters its bytes \
            are: the one at `n` is the byte `n`'s.\"\"\"\n\n\
            REFUSED: Final = frozenset({\"big5\", \"gbk\"})\n\
            \"\"\"The encodings whose labels are refused: no text is read \
            under them.\"\"\"\n")
          (Encodings.Python.text (derived small)));
    case "TypeScript's table" (fun () ->
        Alcotest.(check string)
          "text"
          "// ⚠ GENERATED FILE — do not edit.\n\
           //\n\
           // Authority:   protocol/specs/src/text/encoding-cases.json\n\
           // Regenerate:  make generate  \
           (codegen/lib/encodings/typescript.ml)\n\n\
           /** The encodings of the Encoding Standard whose labels every \
           reader of a resource's text refuses, by their names in lower case. \
           */\n\
           export const REFUSED_ENCODINGS: ReadonlySet<string> = new Set([\n\
          \  'big5',\n\
          \  'gbk',\n\
           ]);\n"
          (Encodings.Typescript.text (derived small)));
    case "the decoded encodings, as a series, and none where there are none"
      (fun () ->
        let sentence cases =
          Encodings.Table.undecoded
            (derived (table cases))
            ~single_byte:"s" ~refused:"r"
        in
        Alcotest.(check (list string))
          "sentences"
          [
            "";
            " An encoding that is neither in s nor in r is utf-8, which no \
             table here decodes.";
            " An encoding that is neither in s nor in r is utf-8, utf-16be or \
             utf-16le, which no table here decodes.";
          ]
          [
            sentence [ refused "big5" [ "big5" ] ];
            sentence [ decoded "utf-8" [ "utf-8" ] ];
            sentence
              [
                decoded "utf-8" [ "utf-8" ];
                decoded "utf-16be" [ "utf-16be" ];
                decoded "utf-16le" [ "utf-16le" ];
              ];
          ]);
  ]

let () =
  Alcotest.run "encodings"
    [
      ("the model", the_model);
      ("the rules", rules);
      ("literals", literals);
      ("the writers", writers);
    ]
