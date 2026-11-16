open Xynolog_codegen

let usage = "usage: xynolog-codegen --check SPECS (SPECS: Protocol's specs/src)"

let () =
  match Array.to_list Sys.argv with
  | [ _; "--check"; specs ] -> (
      match Spec.load specs with
      | Ok spec ->
          Printf.printf
            "Protocol read: 2 OpenAPI documents, %d path items, %d responses, \
             %d JSON Schemas, and its tables\n"
            (List.length spec.path_items)
            (List.length spec.responses)
            (List.length spec.schemas)
      | Error errors ->
          List.iter
            (fun error -> prerr_endline (Decode.error_to_string error))
            errors;
          Printf.eprintf "%d refusals\n" (List.length errors);
          exit 1)
  | _ ->
      prerr_endline usage;
      exit 2
