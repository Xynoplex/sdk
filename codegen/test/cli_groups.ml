(* cli_groups.exe ROOT: cli's groups write their files from the Protocol sdk
   pins, and the mcp-tools group refuses a table whose form it does not
   render. ROOT is the sdk checkout; cli's own drift gate holds the files to
   what cli commits. The mcp-tools table here is a small one of its every
   form, not cli's. *)

open Xynolog_codegen

let write path text =
  Out_channel.with_open_bin path (fun out -> Out_channel.output_string out text)

let rec make_directory path =
  if not (Sys.file_exists path) then (
    make_directory (Filename.dirname path);
    Sys.mkdir path 0o755)

let fail fmt =
  Printf.ksprintf
    (fun m ->
      prerr_endline m;
      exit 1)
    fmt

(* A root holding the sdk checkout's Protocol and [table] as cli's. *)
let root_with ~sdk table =
  let root = Filename.temp_dir "cli-groups" "" in
  Unix.symlink
    (Filename.concat sdk "protocol")
    (Filename.concat root "protocol");
  let file = Filename.concat root Cli.Mcp_tools_table.file in
  make_directory (Filename.dirname file);
  write file (Yojson.Safe.to_string table);
  root

let tool ?result arguments : Yojson.Safe.t =
  `Assoc
    ([
       ("name", `String "demo");
       ("title", `String "Demo");
       ("description", `String "A tool of every argument form.");
       ("calls", `List [ `String "browse.resource" ]);
       ("readOnly", `Bool true);
       ("arguments", `List arguments);
     ]
    @ match result with Some r -> [ ("result", r) ] | None -> [])

let table tools : Yojson.Safe.t =
  `Assoc
    [
      ("$comment", `String "A table of every form.");
      ( "kb",
        `Assoc [ ("type", `String "string"); ("description", `String "Which.") ]
      );
      ("tools", `List tools);
      ("leftOut", `Assoc [ ("browse.engines", `String "Not yet asked for.") ]);
    ]

let every_form =
  tool
    ~result:
      (`Assoc
         [
           ( "referencedBy",
             `Assoc
               [
                 ("required", `Bool true);
                 ("from", `String "GetReferencedByResponse");
                 ("member", `String "referencedBy");
               ] );
           ( "annotations",
             `Assoc
               [ ("required", `Bool true); ("listOf", `String "Annotation") ] );
         ])
    [
      `Assoc
        [
          ("from", `String "GetReferencedByResponse");
          ("member", `String "referencedBy");
        ];
      `Assoc
        [
          ("name", `String "resourceId");
          ("schema", `String "ResourceId");
          ("required", `Bool true);
        ];
      `Assoc
        [
          ("name", `String "withText");
          ("required", `Bool false);
          ("own", `Assoc [ ("type", `String "boolean") ]);
        ];
      `Assoc
        [
          ("name", `String "tags");
          ("required", `Bool false);
          ( "listOf",
            `Assoc
              [
                ("from", `String "FrameAddEntityTypeCommand");
                ("member", `String "tag");
              ] );
        ];
    ]

let messages = function
  | Ok _ -> []
  | Error errors -> List.map Decode.error_to_string errors

let () =
  let sdk =
    match Sys.argv with
    | [| _; root |] ->
        if Filename.is_relative root then Filename.concat (Sys.getcwd ()) root
        else root
    | _ -> fail "usage: cli_groups.exe ROOT"
  in
  let spec =
    match Spec.load (Filename.concat sdk "protocol/specs/src") with
    | Ok spec -> spec
    | Error errors ->
        fail "%s" (String.concat "\n" (List.map Decode.error_to_string errors))
  in
  let root = root_with ~sdk (table [ every_form ]) in
  List.iter
    (fun (g : Groups.group) ->
      match g.files ~root spec with
      | Ok [] -> fail "cli's %s group writes no file" g.name
      | Ok _ -> ()
      | Error errors ->
          fail "cli's %s group refused sdk's Protocol:\n%s" g.name
            (String.concat "\n" (List.map Decode.error_to_string errors)))
    (Groups.of_target Cli);
  let refused ~why argument expected =
    let root = root_with ~sdk (table [ tool [ argument ] ]) in
    let found = messages (Cli.Mcp_tools.files ~root spec) in
    if found <> [ expected ] then
      fail "A table that %s was not refused with\n  %s\nbut with\n  %s" why
        expected
        (String.concat "\n  " found)
  in
  let file = Cli.Mcp_tools_table.file in
  refused ~why:"gives an argument the gateway's member"
    (`Assoc [ ("from", `String "CommandError"); ("member", `String "_trace") ])
    (file
   ^ ": /: demo's arguments: CommandError._trace is the gateway's, never an \
      argument");
  refused ~why:"refers to a schema from its own"
    (`Assoc
       [
         ("name", `String "x");
         ("required", `Bool true);
         ("own", `Assoc [ ("$ref", `String "./ResourceId.json") ]);
       ])
    (file ^ ": /: demo's arguments, x refers to a schema from its own");
  refused ~why:"states two forms"
    (`Assoc
       [
         ("name", `String "x");
         ("required", `Bool true);
         ("schema", `String "ResourceId");
         ("listOf", `String "ResourceId");
       ])
    (file
   ^ ": /tools/0/arguments/0: states other than one of schema, listOf and own");
  refused ~why:"states a member no form has"
    (`Assoc
       [
         ("name", `String "x");
         ("required", `Bool true);
         ("schema", `String "ResourceId");
         ("hint", `String "?");
       ])
    (file ^ ": /tools/0/arguments/0/hint: an unknown member")
