open Xynolog_codegen

let usage =
  "usage: xynolog-codegen read ROOT\n\
  \       xynolog-codegen generate TARGET ROOT [GROUP ...]\n\n\
   ROOT is a checkout whose protocol/specs/src the model reads. read reads it \
   and writes nothing; generate writes each of TARGET's groups' files under \
   ROOT, every group of TARGET when none is named, and names each file it \
   writes. The targets and their groups: "
  ^ String.concat "; "
      (List.map
         (fun (name, target) ->
           name ^ ": "
           ^ String.concat ", "
               (List.map
                  (fun (g : Groups.group) -> g.name)
                  (Groups.of_target target)))
         Groups.targets)

let refused errors =
  List.iter (fun error -> prerr_endline (Decode.error_to_string error)) errors;
  Printf.eprintf "%d refusals\n" (List.length errors);
  exit 1

let bad_usage () =
  prerr_endline usage;
  exit 2

let load root =
  let specs = Filename.concat root "protocol/specs/src" in
  match Spec.load specs with Ok spec -> spec | Error errors -> refused errors

let groups target names =
  let all =
    match List.assoc_opt target Groups.targets with
    | Some target -> Groups.of_target target
    | None ->
        Printf.eprintf "no target is named %s\n" target;
        bad_usage ()
  in
  match names with
  | [] -> all
  | names ->
      List.map
        (fun name ->
          match List.find_opt (fun (g : Groups.group) -> g.name = name) all with
          | Some group -> group
          | None ->
              Printf.eprintf "%s has no group named %s\n" target name;
              bad_usage ())
        names

let files target root names =
  let groups = groups target names in
  let spec = load root in
  let collected =
    List.fold_right
      (fun (g : Groups.group) collected ->
        match (g.files ~root spec, collected) with
        | Ok files, Ok rest -> Ok (files @ rest)
        | Ok _, Error errors | Error errors, Ok _ -> Error errors
        | Error errors, Error rest -> Error (errors @ rest))
      groups (Ok [])
  in
  match collected with Ok files -> files | Error errors -> refused errors

let () =
  match Array.to_list Sys.argv with
  | [ _; "read"; root ] ->
      let spec = load root in
      Printf.printf
        "Protocol read: 2 OpenAPI documents, %d path items, %d responses, %d \
         JSON Schemas, and its tables\n"
        (List.length spec.path_items)
        (List.length spec.responses)
        (List.length spec.schemas)
  | _ :: "generate" :: target :: root :: names ->
      Output.write ~root (files target root names)
  | _ -> bad_usage ()
