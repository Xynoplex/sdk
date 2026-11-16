open Xynolog_codegen

let usage =
  "usage: xynolog-codegen read ROOT\n\
  \       xynolog-codegen generate ROOT [GROUP ...]\n\
  \       xynolog-codegen check ROOT [GROUP ...]\n\n\
   ROOT is the sdk checkout, whose protocol/specs/src the model reads. read \
   reads it and writes nothing; generate writes each group's files under ROOT, \
   every group when none is named; check compares them with the committed \
   files and writes nothing. The groups: "
  ^ String.concat ", " (List.map (fun (g : Groups.group) -> g.name) Groups.all)

let refused errors =
  List.iter (fun error -> prerr_endline (Decode.error_to_string error)) errors;
  Printf.eprintf "%d refusals\n" (List.length errors);
  exit 1

let bad_usage () =
  prerr_endline usage;
  exit 2

let load root =
  let specs = Filename.concat root "protocol/specs/src" in
  match Spec.load specs with
  | Ok spec -> (specs, spec)
  | Error errors -> refused errors

let groups = function
  | [] -> Groups.all
  | names ->
      List.map
        (fun name ->
          match
            List.find_opt (fun (g : Groups.group) -> g.name = name) Groups.all
          with
          | Some group -> group
          | None ->
              Printf.eprintf "no group is named %s\n" name;
              bad_usage ())
        names

let files root names =
  let groups = groups names in
  let specs, spec = load root in
  let collected =
    List.fold_right
      (fun (g : Groups.group) collected ->
        match (g.files ~specs spec, collected) with
        | Ok files, Ok rest -> Ok (files @ rest)
        | Ok _, Error errors | Error errors, Ok _ -> Error errors
        | Error errors, Error rest -> Error (errors @ rest))
      groups (Ok [])
  in
  match collected with Ok files -> files | Error errors -> refused errors

let () =
  match Array.to_list Sys.argv with
  | [ _; "read"; root ] ->
      let _, spec = load root in
      Printf.printf
        "Protocol read: 2 OpenAPI documents, %d path items, %d responses, %d \
         JSON Schemas, and its tables\n"
        (List.length spec.path_items)
        (List.length spec.responses)
        (List.length spec.schemas)
  | _ :: "generate" :: root :: names -> Output.write ~root (files root names)
  | _ :: "check" :: root :: names -> (
      match Output.check ~root (files root names) with
      | [] -> ()
      | drifted ->
          Printf.eprintf
            "%d generated files differ from what their generators write: run \
             make generate\n"
            (List.length drifted);
          exit 1)
  | _ -> bad_usage ()
