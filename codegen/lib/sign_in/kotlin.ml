(* How a writer keeps the sign-in store to its owner, as the Kotlin SDK reads
   it (xynolog.signin): each mode as the permissions a POSIX file system
   names it, and the access lists Windows gives the directory and a file, each
   made for the user whose SID is [owner]. *)

module K = Kotlin_syntax

(* "700" as "rwx------". *)
let permissions octal =
  String.concat ""
    (List.map
       (fun digit ->
         let bits = Char.code digit - Char.code '0' in
         let flag bit c = if bits land bit <> 0 then c else "-" in
         flag 4 "r" ^ flag 2 "w" ^ flag 1 "x")
       (List.init (String.length octal) (String.get octal)))

let mode name (m : Owner_only.mode) =
  K.property ~about:(K.Block m.docs) ~visibility:K.Internal ~const:true
    ~type_:(K.Type "String")
    ~value:(K.Same_line (K.Str (permissions m.octal)))
    name

let access_list name (l : Owner_only.access_list) =
  K.function_ ~about:(K.Block l.docs) ~visibility:K.Internal
    ~params:[ ("owner", K.Type "String") ]
    ~returns:(K.Type "String") name
    (K.Same_line
       (K.Binary
          ( K.Binary (K.Str l.before, K.Plus, K.Name "owner"),
            K.Plus,
            K.Str l.after )))

let file (o : Owner_only.t) =
  Kotlin_sdk.table ~from_:Owner_only.file __FILE__ ~package:"xynolog.signin"
    ~name:"OwnerOnlyTable" ~imports:[]
    [
      mode "OWNER_ONLY_DIRECTORY_PERMISSIONS" o.directory;
      mode "OWNER_ONLY_FILE_PERMISSIONS" o.file;
      access_list "ownerOnlyDirectoryAccessList" o.directory_access_list;
      access_list "ownerOnlyFileAccessList" o.file_access_list;
    ]
