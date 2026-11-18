(* The table as the TypeScript SDK's reader of a resource's text reads it
   (typescript/core/src/text-encoding.ts): the platform's TextDecoder has the
   standard's labels and its encodings, and decodes the refused ones all the
   same. *)

module T = Typescript_syntax

let path = "typescript/core/src/refused-encodings.ts"

let text (t : Table.t) =
  T.text
    {
      banner =
        Banner.typescript_lines
          ~authority:[ "protocol/specs/src/text/encoding-cases.json" ]
          __FILE__;
      body =
        [
          T.const "REFUSED_ENCODINGS"
            ~about:
              [
                Doc
                  "The encodings of the Encoding Standard whose labels every \
                   reader of a resource's text refuses, by their names in \
                   lower case.";
              ]
            ~annotation:(T_generic ("ReadonlySet", [ T_name "string" ]))
            (New ("Set", [ T.strings t.refused ]));
        ];
    }

let file t = { Output.path; text = text t }
