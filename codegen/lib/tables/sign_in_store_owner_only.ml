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

type directory_access_list = { value : string; docs : string }

let directory_access_list =
  Decode.obj (fun o : directory_access_list ->
      {
        value = Decode.required o "value" Decode.string;
        docs = Decode.required o "docs" Decode.string;
      })

type file_access_list = { value : string; docs : string }

let file_access_list =
  Decode.obj (fun o : file_access_list ->
      {
        value = Decode.required o "value" Decode.string;
        docs = Decode.required o "docs" Decode.string;
      })

type t = {
  comment : string;
  directory_mode : directory_mode;
  file_mode : file_mode;
  directory_access_list : directory_access_list;
  file_access_list : file_access_list;
}

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        directory_mode = Decode.required o "directoryMode" directory_mode;
        file_mode = Decode.required o "fileMode" file_mode;
        directory_access_list =
          Decode.required o "directoryAccessList" directory_access_list;
        file_access_list = Decode.required o "fileAccessList" file_access_list;
      })
