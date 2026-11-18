(* How the Rust SDK's writer of the sign-in store keeps its directory and
   its files to their owner (rust/sdk/src/sign_in_store.rs): the modes, on a
   system that has modes, and the access lists Windows gives the directory
   and a file, each made for the user whose SID goes where the list says
   [{owner}]. *)

module R = Rust_syntax

let path = "rust/sdk/src/generated/owner_only.rs"
let cfg system = R.List ([ "cfg" ], [ R.Word [ system ] ])

let mode name (m : Owner_only.mode) =
  R.Const
    {
      doc = [ m.docs ];
      attrs = [ cfg "unix" ];
      vis = Private;
      name;
      ty = R.named "u32";
      value = R.Octal (int_of_string ("0o" ^ m.octal));
    }

let access_list ~attrs name (l : Owner_only.access_list) =
  R.Fn
    (R.fn_ ~doc:[ l.docs ] ~attrs:(cfg "windows" :: attrs) name
       ~params:[ R.Param ("owner", R.str_ty) ]
       ~ret:(R.named "String")
       [
         R.Tail
           (R.Method
              ( R.Array [ R.Str l.before; R.p "owner"; R.Str l.after ],
                "concat",
                [] ));
       ])

let file (o : Owner_only.t) =
  {
    Output.path;
    text =
      R.text
        ~header:
          (Banner.lines
             ~from_:"protocol/specs/src/sign-in-store/owner-only.json" __FILE__)
        [
          mode "OWNER_ONLY_DIRECTORY_MODE" o.directory;
          mode "OWNER_ONLY_FILE_MODE" o.file;
          access_list ~attrs:[] "owner_only_directory_access_list"
            o.directory_access_list;
          access_list "owner_only_file_access_list" o.file_access_list
            ~attrs:
              [
                R.List
                  ( [ "expect" ],
                    [
                      R.Word [ "dead_code" ];
                      R.Name_value
                        ( "reason",
                          R.Str
                            "the store's files inherit the directory's list; \
                             only the launcher gives a file its own" );
                    ] );
              ];
        ];
  }
