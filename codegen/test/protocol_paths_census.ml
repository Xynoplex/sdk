(* protocol_paths_census.exe SDK PROTOCOL: every sdk path the Protocol
   checkout names is one the sdk checkout has (Protocol_paths). *)

open Xynolog_codegen

let () =
  let named, refusals =
    Protocol_paths.check ~sdk:Sys.argv.(1) ~protocol:Sys.argv.(2)
  in
  List.iter prerr_endline refusals;
  if refusals <> [] then exit 1;
  Printf.printf
    "PASS every sdk path Protocol names is in the SDK checkout: %d named\n"
    named
