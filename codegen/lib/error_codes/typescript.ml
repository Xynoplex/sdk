(* The vocabularies as the TypeScript SDK reads them (typescript/core/src): a
   union type per vocabulary, the bus code each wire code becomes, and the
   transport code an HTTP status becomes. *)

let path = "typescript/core/src/error-codes.ts"

let union (v : Table.vocabulary) =
  Printf.sprintf "%s\nexport type %s =\n%s;\n" (Text.doc_comment v.docs) v.name
    (String.concat "\n"
       (List.map
          (fun (c : Table.code) ->
            Printf.sprintf "%s\n  | %s"
              ("  " ^ Text.doc_comment c.docs)
              (Text.quoted c.code))
          v.codes))

let text (t : Table.t) =
  String.concat ""
    [
      {|// ⚠ GENERATED FILE — do not edit.
//
// Authority:   protocol/specs/src/errors/codes.json
// Regenerate:  make generate  (codegen/lib/error_codes/typescript.ml)

|};
      union t.bus;
      {|
/** The bus code a failure's own wire code (`CommandError.code`) becomes. */
export const busRequestCodeByWireCode = {
|};
      String.concat ""
        (List.map
           (fun (wire, (c : Table.code)) ->
             Printf.sprintf "  %s: %s,\n" (Text.quoted wire)
               (Text.quoted c.code))
           t.wire);
      Printf.sprintf
        {|} as const;

/** What a failure becomes when it states no code, or one CommandError does not list, which is read as none. */
export const unrecognizedFailureCode = %s as const;

|}
        (Text.quoted t.unrecognized.code);
      union t.transport;
      Printf.sprintf
        {|
/** The transport code an HTTP status becomes. */
export function transportErrorCodeForStatus(status: number): %s {
  switch (status) {
|}
        t.transport.name;
      String.concat ""
        (List.map
           (fun (status, (c : Table.code)) ->
             Printf.sprintf "    case %d: return %s;\n" status
               (Text.quoted c.code))
           t.exact);
      "  }\n";
      String.concat ""
        (List.map
           (fun (status, (c : Table.code)) ->
             Printf.sprintf "  if (status >= %d) return %s;\n" status
               (Text.quoted c.code))
           (Option.to_list t.from));
      Printf.sprintf "  return %s;\n}\n\n" (Text.quoted t.unclassified.code);
      String.concat "\n" (List.map union t.others);
    ]

let file t = { Output.path; text = text t }
