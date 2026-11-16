(* A generated file, by its path from the sdk checkout's root, and the drift
   gate: a check compares each file with the committed one, and a write
   replaces each that differs. *)

type file = { path : string; text : string }

let committed ~root file =
  let path = Filename.concat root file.path in
  if Sys.file_exists path then
    Some (In_channel.with_open_bin path In_channel.input_all)
  else None

(* The files that differ from the committed ones, each reported. *)
let check ~root files =
  List.filter
    (fun file ->
      match committed ~root file with
      | Some text when text = file.text ->
          Printf.printf "ok     %s\n" file.path;
          false
      | Some _ ->
          Printf.printf "DRIFT  %s\n" file.path;
          true
      | None ->
          Printf.printf "absent %s\n" file.path;
          true)
    files

let rec make_directory path =
  if not (Sys.file_exists path) then (
    make_directory (Filename.dirname path);
    Sys.mkdir path 0o755)

let write ~root files =
  List.iter
    (fun file ->
      match committed ~root file with
      | Some text when text = file.text -> Printf.printf "ok     %s\n" file.path
      | _ ->
          let path = Filename.concat root file.path in
          make_directory (Filename.dirname path);
          Out_channel.with_open_bin path (fun out ->
              Out_channel.output_string out file.text);
          Printf.printf "wrote  %s\n" file.path)
    files
