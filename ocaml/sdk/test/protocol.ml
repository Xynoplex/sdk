(* The pinned Protocol's tables, read where the checkout holds them
   (protocol/specs/src), as every SDK's tests read them: a test holds the SDK
   to the table itself, not to a copy of it. The checkout is the nearest
   directory above the test's that has protocol/specs/src; a test run outside
   one fails. *)

let specs = Filename.concat "protocol" (Filename.concat "specs" "src")

let root =
  let rec up dir =
    if Sys.file_exists (Filename.concat dir specs) then dir
    else
      let parent = Filename.dirname dir in
      if parent = dir then
        failwith ("no directory above " ^ Sys.getcwd () ^ " holds " ^ specs)
      else up parent
  in
  up (Sys.getcwd ())

(* The table at [path] within protocol/specs/src. *)
let table path =
  Yojson.Safe.from_file (Filename.concat (Filename.concat root specs) path)

(* The member [name] of the table at [path]. *)
let member path name = Yojson.Safe.Util.member name (table path)

(* client/timing.json's entries as one object, each value by its name. *)
let timing () =
  `Assoc
    (List.map
       (fun entry ->
         Yojson.Safe.Util.(to_string (member "name" entry), member "value" entry))
       (Yojson.Safe.Util.to_list (member "client/timing.json" "timing")))
