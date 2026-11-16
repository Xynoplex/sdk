(* specs/src/sign-in-store/owner-only.json *)

type directory_mode = { value : string; docs : string }

let directory_mode =
  Decode.obj (fun o : directory_mode ->
      {
        value = Decode.required o "value" Decode.string;
        docs = Decode.required o "docs" Decode.string;
      })

type file_mode = { value : string; docs : string }

let file_mode =
  Decode.obj (fun o : file_mode ->
      {
        value = Decode.required o "value" Decode.string;
        docs = Decode.required o "docs" Decode.string;
      })

type access_list = { value : string; docs : string }

let access_list =
  Decode.obj (fun o : access_list ->
      {
        value = Decode.required o "value" Decode.string;
        docs = Decode.required o "docs" Decode.string;
      })

type t = {
  comment : string;
  directory_mode : directory_mode;
  file_mode : file_mode;
  access_list : access_list;
}

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        directory_mode = Decode.required o "directoryMode" directory_mode;
        file_mode = Decode.required o "fileMode" file_mode;
        access_list = Decode.required o "accessList" access_list;
      })
