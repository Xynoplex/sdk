(* specs/src/text/encoding-cases.json *)

type case = {
  encoding : string;
  labels : string list;
  bytes : string option;
  text : string option;
  every_byte : string option;
  refused : bool option;
}

let case =
  Decode.obj (fun o : case ->
      {
        encoding = Decode.required o "encoding" Decode.string;
        labels = Decode.required o "labels" (Decode.list Decode.string);
        bytes = Decode.optional o "bytes" Decode.string;
        text = Decode.optional o "text" Decode.string;
        every_byte = Decode.optional o "everyByte" Decode.string;
        refused = Decode.optional o "refused" Decode.bool;
      })

type t = { comment : string; run_by : Case_table.run_by; cases : case list }

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        run_by = Decode.required o "runBy" Case_table.run_by;
        cases = Decode.required o "cases" (Decode.list case);
      })
