(* boundary_census.exe SDK: in TypeScript's core and in Python's SDK, each
   base module a generated one imports stays below it (Boundary). The
   generated modules are those the generator's groups write. SDK is the
   checkout's root. *)

open Xynolog_codegen

let root = Sys.argv.(1)

let refused errors =
  List.iter (fun e -> prerr_endline (Decode.error_to_string e)) errors;
  exit 1

let generated =
  let spec =
    match Spec.load (Filename.concat root "protocol/specs/src") with
    | Ok spec -> spec
    | Error errors -> refused errors
  in
  List.concat_map
    (fun (g : Groups.group) ->
      match g.files ~root spec with
      | Ok files -> List.map (fun (f : Output.file) -> f.path) files
      | Error errors -> refused errors)
    Groups.all

let () =
  let checked =
    List.map
      (fun (l : Boundary.language) ->
        (l.label, Boundary.check ~root ~generated l))
      Boundary.languages
  in
  let refusals = List.concat_map (fun (_, (_, r)) -> r) checked in
  List.iter prerr_endline refusals;
  if refusals <> [] then exit 1;
  Printf.printf
    "PASS each base module a generated one imports stays below it: %s\n"
    (String.concat ", "
       (List.map
          (fun (label, (generated, _)) ->
            Printf.sprintf "%d %s" (List.length generated) label)
          checked))
