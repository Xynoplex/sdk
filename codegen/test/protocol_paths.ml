(* Protocol_paths over a seeded sdk checkout and Protocol checkout: which
   paths a file names, how braces and stars read, and each refusal by its
   file and line. *)

open Xynolog_codegen

let case name test = Alcotest.test_case name `Quick test

let rec make_directory path =
  if not (Sys.file_exists path) then (
    make_directory (Filename.dirname path);
    Sys.mkdir path 0o755)

let write root (path, text) =
  let full = Filename.concat root path in
  make_directory (Filename.dirname full);
  Out_channel.with_open_bin full (fun out -> Out_channel.output_string out text)

let tree files =
  let root = Filename.temp_dir "protocol-paths" "" in
  List.iter (write root) files;
  root

let named () =
  let sdk =
    tree
      [
        ("rust/sdk/src/lib.rs", "");
        ("rust/sdk/Cargo.toml", "");
        ("go/api/types.go", "");
      ]
  in
  let protocol =
    tree
      [
        ( "README.md",
          "Held by sdk/rust/sdk/src/lib.rs.\n\
           Written as sdk/rust/{sdk,cli}/Cargo.toml and sdk/rust/sdk/src/*.rs\n\
           Its own sdk/wire/cases.json, and notsdk/rust/absent.\n\
           See https://github.com/xynolog/sdk/blob/main/go/api/absent.go.\n\
           and [it](https://github.com/xynolog/sdk/tree/main/go/api/).\n" );
        ("nested/.git/HEAD", "");
        ("nested/README.md", "sdk/rust/absent\n");
        (".git/HEAD", "sdk/rust/absent\n");
      ]
  in
  let named, refusals = Protocol_paths.check ~sdk ~protocol in
  Alcotest.(check int) "each reference, not each expansion" 5 named;
  Alcotest.(check (list string))
    "each absent expansion, by its file and line"
    [
      "protocol/README.md:4: sdk/go/api/absent.go is not in the SDK checkout";
      "protocol/README.md:2: sdk/rust/cli/Cargo.toml is not in the SDK checkout";
    ]
    refusals

let () = Alcotest.run "protocol_paths" [ ("paths", [ case "named" named ]) ]
