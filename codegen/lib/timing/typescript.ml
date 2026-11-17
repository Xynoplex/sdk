(* The timing as the TypeScript SDK reads it (typescript/core/src): a constant
   per entry under its name in upper case. *)

let path = "typescript/core/src/client-timing.ts"

(* [text] as a one-line doc comment, which a [*/] in it would end early. *)
let doc text =
  Printf.sprintf "/** %s */" (Text.replace_all ~sub:"*/" ~by:"*\\/" text)

let text (t : Table.t) =
  String.concat ""
    [
      {|// ⚠ GENERATED FILE — do not edit.
//
// Authority:   protocol/specs/src/client/timing.json
// Regenerate:  make generate  (codegen/lib/timing/typescript.ml)

import type { RetryPolicy } from './retry';

|};
      String.concat "\n"
        (List.map
           (fun (e : Table.entry) ->
             Printf.sprintf "%s\nexport const %s;\n" (doc e.docs)
               (match e.value with
               | Duration n | Count n ->
                   Printf.sprintf "%s = %d" (Text.upper_snake e.name) n
               | Budget { attempts; initial_delay_ms; max_delay_ms } ->
                   Printf.sprintf
                     "%s: RetryPolicy = { attempts: %d, initialDelayMs: %d, \
                      maxDelayMs: %d }"
                     (Text.upper_snake e.name) attempts initial_delay_ms
                     max_delay_ms))
           t);
    ]

let file t = { Output.path; text = text t }
