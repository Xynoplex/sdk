(* census.exe SPECS: the pinned Protocol reads, Swift's table values are its
   own, and swift-sdk refuses a copy of it whose failure channels Swift cannot
   model. SPECS is Protocol's specs/src; that the reader refuses a copy of it
   with what it does not know is Protocol's own census. *)

open Xynolog_codegen

let rec copy source target =
  if Sys.is_directory source then (
    Sys.mkdir target 0o755;
    Array.iter
      (fun name ->
        copy (Filename.concat source name) (Filename.concat target name))
      (Sys.readdir source))
  else
    Out_channel.with_open_bin target (fun out ->
        Out_channel.output_string out
          (In_channel.with_open_bin source In_channel.input_all))

let write path text =
  Out_channel.with_open_bin path (fun out -> Out_channel.output_string out text)

let messages = function
  | Ok _ -> []
  | Error errors -> List.map Decode.error_to_string errors

(* A copy of the specs, changed, that the model reads must be refused by the
   swift-sdk group with this refusal. *)
let swift_refused specs ~why change expected =
  let copied = Filename.concat (Filename.temp_dir "census" "") "src" in
  copy specs copied;
  change copied;
  let found =
    match Spec_shapes.load copied with
    | Error errors ->
        List.iter (fun e -> prerr_endline (Decode.error_to_string e)) errors;
        Printf.eprintf "A copy that %s was not read\n" why;
        exit 1
    | Ok spec -> messages (Swift_sdk.files ~root:"" spec)
  in
  if found <> [ expected ] then (
    Printf.eprintf
      "A copy that %s was not refused by swift-sdk with:\n  %s\nbut with:\n" why
      expected;
    List.iter (Printf.eprintf "  %s\n") found;
    exit 1)

let rewrite path change =
  write path (Yojson.Safe.to_string (change (Yojson.Safe.from_file path)))

let members f = function
  | `Assoc members -> `Assoc (f members)
  | _ -> failwith "not an object"

(* Each value of a table Swift's models hold as written, Spec_values', is the
   table's own member as Protocol has it. *)
let swift_values_are_the_tables specs (spec : Spec.t) =
  List.iter
    (fun (file, key, _, value) ->
      let raw =
        match Yojson.Safe.from_file (Filename.concat specs file) with
        | `Assoc members -> List.assoc key members
        | _ -> failwith (file ^ " is not an object")
      in
      if not (Yojson.Safe.equal raw value) then (
        Printf.eprintf "Swift's %s of %s is not Protocol's:\n  %s\n" key file
          (Yojson.Safe.to_string value);
        exit 1))
    (Swift_sdk.Spec_values.all spec.tables)

let () =
  let specs =
    match Sys.argv with
    | [| _; specs |] -> specs
    | _ ->
        prerr_endline "usage: census.exe SPECS";
        exit 2
  in
  (match Spec_shapes.load specs with
  | Ok spec -> swift_values_are_the_tables specs spec
  | Error errors ->
      List.iter (fun e -> prerr_endline (Decode.error_to_string e)) errors;
      Printf.eprintf "The pinned Protocol has %d refusals\n"
        (List.length errors);
      exit 1);
  let command_error copied change =
    rewrite
      (Filename.concat copied "components/schemas/CommandError.json")
      (members change)
  in
  swift_refused specs ~why:"gives a failure channel no schema"
    (fun copied ->
      rewrite
        (Filename.concat copied "bus/registry.json")
        (members
           (List.map (function
             | "channels", `List channels ->
                 ( "channels",
                   `List
                     (List.map
                        (members (fun row ->
                             if
                               List.assoc_opt "schema" row
                               = Some (`String "CommandError")
                             then
                               List.filter_map
                                 (function
                                   | "schema", _ -> None
                                   | "shape", _ ->
                                       Some ("shape", `String "empty")
                                   | "validate", _ -> Some ("validate", `Null)
                                   | member -> Some member)
                                 row
                             else row))
                        channels) )
             | member -> member))))
    "openapi.json: /: failure channel has no schema";
  swift_refused specs ~why:"makes a failure's message optional"
    (fun copied ->
      command_error copied
        (List.map (function
          | "required", _ -> ("required", `List [])
          | member -> member)))
    "openapi.json: /: failure message must be a required string";
  swift_refused specs ~why:"makes a failure's message no string"
    (fun copied ->
      command_error copied
        (List.map (function
          | "properties", properties ->
              ( "properties",
                members
                  (List.map (function
                    | "message", _ ->
                        ("message", `Assoc [ ("type", `String "integer") ])
                    | member -> member))
                  properties )
          | member -> member)))
    "openapi.json: /: failure message must be a required string";
  print_endline
    "The pinned Protocol reads; Swift's table values are Protocol's, and \
     swift-sdk refuses a failure channel without a required string message"
