(* How the Rust SDK's writer of the sign-in store keeps its directory and
   its files to their owner (rust/sdk/src/sign_in_store.rs): the modes, on a
   system that has modes, and the access list Windows gives the directory,
   made for the user whose SID goes where the file's list says [{owner}]. *)

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
          R.Fn
            (R.fn_
               ~doc:[ o.directory_access_list.docs ]
               ~attrs:[ cfg "windows" ]
               "owner_only_access_list"
               ~params:[ R.Param ("owner", R.str_ty) ]
               ~ret:(R.named "String")
               [
                 R.Tail
                   (R.Method
                      ( R.Array
                          [
                            R.Str o.directory_access_list.before;
                            R.p "owner";
                            R.Str o.directory_access_list.after;
                          ],
                        "concat",
                        [] ));
               ]);
        ];
  }
