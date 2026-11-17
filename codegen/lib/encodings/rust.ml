(* The Encoding Standard as the Rust SDK's reader of a resource's text reads
   it (rust/sdk/src/resources.rs): UTF-8's labels, which tell it a charset is
   UTF-8 when it decodes UTF-8 alone, and the encodings whose labels it
   refuses, each in the table's order. *)

module R = Rust_syntax
module T = Tables.Text_encoding_cases

let from_ = "protocol/specs/src/text/encoding-cases.json"

let constant ~path ~doc name values =
  {
    Output.path;
    text =
      R.text
        ~header:(Banner.rust_lines ~from_ __FILE__)
        [
          R.Const
            {
              doc = [ doc ];
              attrs = [];
              vis = Private;
              name;
              ty = R.Ref (None, R.Slice R.str_ty);
              value = R.Ref_of (R.Array (List.map (fun v -> R.Str v) values));
            };
        ];
  }

(* UTF-8 is a case of the table, and replacement one whose labels are
   refused: the reader decodes UTF-8 itself, and refuses what the Encoding
   Standard maps to replacement. [Table.derive] holds each case to name
   itself among its labels. *)
let files (table : T.t) =
  let refuse message =
    Error [ { Decode.file = Table.file; pointer = "/cases"; message } ]
  in
  let refused =
    List.filter_map
      (fun (c : T.case) ->
        match c.kind with Refused -> Some c.encoding | _ -> None)
      table.cases
  in
  match
    List.find_opt (fun (c : T.case) -> c.encoding = "utf-8") table.cases
  with
  | None -> refuse "states no case of utf-8"
  | Some _ when not (List.mem "replacement" refused) ->
      refuse "does not refuse replacement"
  | Some utf8 ->
      Ok
        [
          constant ~path:"rust/sdk/src/generated/utf8_labels.rs"
            ~doc:"Every label of UTF-8 in the Encoding Standard, in lower case."
            "UTF_8_LABELS" utf8.labels;
          constant ~path:"rust/sdk/src/generated/refused_encodings.rs"
            ~doc:
              "Every encoding of the Encoding Standard whose labels are \
               refused, by its name in lower case."
            "REFUSED_ENCODINGS" refused;
        ]
