(* census.exe SPECS: the model reads every file the pinned Protocol has, and
   refuses a copy of it that has what the model does not know or lacks what it
   names. SPECS is Protocol's specs/src. *)

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

(* A copy of the specs, changed, must be refused with this refusal among
   those it gives. *)
let refused specs ~why change expected =
  let copied = Filename.concat (Filename.temp_dir "census" "") "src" in
  copy specs copied;
  change copied;
  let found = messages (Spec.load copied) in
  if not (List.mem expected found) then (
    Printf.eprintf "A copy that %s was not refused with:\n  %s\nbut with:\n" why
      expected;
    List.iter (Printf.eprintf "  %s\n") found;
    exit 1)

let () =
  let specs =
    match Sys.argv with
    | [| _; specs |] -> specs
    | _ ->
        prerr_endline "usage: census.exe SPECS";
        exit 2
  in
  (match Spec.load specs with
  | Ok _ -> ()
  | Error errors ->
      List.iter (fun e -> prerr_endline (Decode.error_to_string e)) errors;
      Printf.eprintf "The pinned Protocol has %d refusals\n"
        (List.length errors);
      exit 1);
  refused specs ~why:"has a file the model does not know"
    (fun copied -> write (Filename.concat copied "retry/notes.txt") "")
    "retry/notes.txt: /: a file the model does not know";
  refused specs ~why:"lacks a table the model names"
    (fun copied -> Sys.remove (Filename.concat copied "retry/cases.json"))
    "retry/cases.json: /: the model reads this file, and Protocol has none";
  refused specs ~why:"has a reference naming nothing"
    (fun copied ->
      write
        (Filename.concat copied "components/schemas/Dangling.json")
        {|{"$ref":"Nowhere.json"}|})
    "components/schemas/Dangling.json: /$ref: names Nowhere.json, which \
     Protocol does not have";
  refused specs ~why:"has a schema with a keyword the model does not know"
    (fun copied ->
      write
        (Filename.concat copied "components/schemas/Unknown.json")
        {|{"type":"string","contentEncoding":"base64"}|})
    "components/schemas/Unknown.json: /contentEncoding: an unknown member";
  refused specs ~why:"lacks a path item a document names"
    (fun copied -> Sys.remove (Filename.concat copied "paths/api_health.json"))
    "openapi.json: /paths/~1api~1health/$ref: names paths/api_health.json, \
     which Protocol does not have";
  print_endline
    "The model reads every file of the pinned Protocol, and refuses a copy \
     with a stray file, a missing table, a dangling reference, an unknown \
     keyword or a missing path item"
