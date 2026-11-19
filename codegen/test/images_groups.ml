(* images_groups.exe ROOT: images' groups write their files from the Protocol
   sdk pins, and the service-types group refuses a table that names no
   root ([Roots]), names one twice, or names one the Rust SDK declares. ROOT is
   the sdk checkout; images' own drift gate holds the files to what images
   commits. The table here is a small one, not images'. *)

open Xynolog_codegen

let fail fmt =
  Printf.ksprintf
    (fun m ->
      prerr_endline m;
      exit 1)
    fmt

let rec make_directory path =
  if not (Sys.file_exists path) then (
    make_directory (Filename.dirname path);
    Sys.mkdir path 0o755)

(* A root holding the sdk checkout's Protocol and a service-types table of
   [names]. *)
let root_with ~sdk names =
  let root = Filename.temp_dir "images-groups" "" in
  Unix.symlink
    (Filename.concat sdk "protocol")
    (Filename.concat root "protocol");
  let file = Filename.concat root Images.Service_types.table in
  make_directory (Filename.dirname file);
  Out_channel.with_open_bin file (fun out ->
      Out_channel.output_string out
        (Yojson.Safe.to_string
           (`Assoc
              [
                ("$comment", `String "A table of two.");
                ("schemas", `List (List.map (fun n -> `String n) names));
              ])));
  root

let messages = function
  | Ok _ -> []
  | Error errors -> List.map Decode.error_to_string errors

let () =
  let sdk =
    match Sys.argv with
    | [| _; root |] ->
        if Filename.is_relative root then Filename.concat (Sys.getcwd ()) root
        else root
    | _ -> fail "usage: images_groups.exe ROOT"
  in
  let spec =
    match Spec_shapes.load (Filename.concat sdk "protocol/specs/src") with
    | Ok spec -> spec
    | Error errors ->
        fail "%s" (String.concat "\n" (List.map Decode.error_to_string errors))
  in
  let root = root_with ~sdk [ "ResourceView"; "JobRecord" ] in
  List.iter
    (fun (g : Groups.group) ->
      match g.files ~root spec with
      | Ok [] -> fail "images' %s group writes no file" g.name
      | Ok _ -> ()
      | Error errors ->
          fail "images' %s group refused sdk's Protocol:\n%s" g.name
            (String.concat "\n" (List.map Decode.error_to_string errors)))
    (Groups.of_target Images);
  let refused ~why names expected =
    let root = root_with ~sdk names in
    let found = messages (Images.Service_types.files ~root spec) in
    if found <> [ expected ] then
      fail "A table that %s was not refused with\n  %s\nbut with\n  %s" why
        expected
        (String.concat "\n  " found)
  in
  let file = Images.Service_types.table in
  refused ~why:"names no root" [ "NoSuchSchema" ]
    (file ^ ": /: NoSuchSchema is no schema a generation roots ([Roots])");
  refused ~why:"names one twice"
    [ "JobRecord"; "JobRecord" ]
    (file ^ ": /: names a schema twice");
  refused ~why:"names one the Rust SDK declares" [ "ResourceId" ]
    "openapi.json: /: ResourceId is a root, and the Rust SDK declares it"
