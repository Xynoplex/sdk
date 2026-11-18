(* A generated file, by its path from the sdk checkout's root, and its
   write: each file that differs from the committed one is replaced. A
   TypeScript file is written as printed, for Prettier to lay out after the
   run; make check-generated runs both into a copy of the checkout and
   compares every file the run names with the committed one. *)

type file = { path : string; text : string }

let committed ~root file =
  let path = Filename.concat root file.path in
  if Sys.file_exists path then
    Some (In_channel.with_open_bin path In_channel.input_all)
  else None

(* A file Prettier lays out, which the run writes as printed. *)
let prettier file = Filename.check_suffix file.path ".ts"

let rec make_directory path =
  if not (Sys.file_exists path) then (
    make_directory (Filename.dirname path);
    Sys.mkdir path 0o755)

(* Each file written, reported as [ok] when the committed one is the same,
   [wrote] when it was replaced, and [format] when Prettier lays it out. *)
let write ~root files =
  List.iter
    (fun file ->
      let replace () =
        let path = Filename.concat root file.path in
        make_directory (Filename.dirname path);
        Out_channel.with_open_bin path (fun out ->
            Out_channel.output_string out file.text)
      in
      if prettier file then (
        replace ();
        Printf.printf "format %s\n" file.path)
      else
        match committed ~root file with
        | Some text when text = file.text ->
            Printf.printf "ok     %s\n" file.path
        | _ ->
            replace ();
            Printf.printf "wrote  %s\n" file.path)
    files

(* A file in [directory] that no run writes: one there that [files] does not
   name. It is refused rather than removed, so the run that stops writing a
   file names it, to be deleted with the change that drops it. *)
let stale ~root ~directory files =
  let on_disk =
    match Sys.readdir (Filename.concat root directory) with
    | names -> List.sort String.compare (Array.to_list names)
    | exception Sys_error _ -> []
  in
  List.filter_map
    (fun name ->
      let path = directory ^ "/" ^ name in
      if List.exists (fun file -> file.path = path) files then None
      else
        Some
          {
            Decode.file = path;
            pointer = "";
            message = "is a generated file no run writes: delete it";
          })
    on_disk
