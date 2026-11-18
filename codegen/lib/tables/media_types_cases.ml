(* specs/src/media-types/cases.json *)

type clone_format_item = {
  why : string;
  source : string option;
  format : string;
}

let clone_format_item =
  Decode.obj (fun o : clone_format_item ->
      {
        why = Decode.required o "why" Decode.string;
        source = Decode.required o "source" (Decode.nullable Decode.string);
        format = Decode.required o "format" Decode.string;
      })

type storage_file_name_item = {
  why : string;
  name : string;
  format : string;
  file_name : string;
}

let storage_file_name_item =
  Decode.obj (fun o : storage_file_name_item ->
      {
        why = Decode.required o "why" Decode.string;
        name = Decode.required o "name" Decode.string;
        format = Decode.required o "format" Decode.string;
        file_name = Decode.required o "fileName" Decode.string;
      })

type text_source_item = {
  why : string;
  format : string;
  text_source : string;
  yields_geometry : bool;
  derives_text : bool;
}

let text_source_item =
  Decode.obj (fun o : text_source_item ->
      {
        why = Decode.required o "why" Decode.string;
        format = Decode.required o "format" Decode.string;
        text_source = Decode.required o "textSource" Decode.string;
        yields_geometry = Decode.required o "yieldsGeometry" Decode.bool;
        derives_text = Decode.required o "derivesText" Decode.bool;
      })

type t = {
  comment : string;
  clone_format : clone_format_item list;
  storage_file_name : storage_file_name_item list;
  text_source : text_source_item list;
}

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        clone_format =
          Decode.required o "cloneFormat" (Decode.list clone_format_item);
        storage_file_name =
          Decode.required o "storageFileName"
            (Decode.list storage_file_name_item);
        text_source =
          Decode.required o "textSource" (Decode.list text_source_item);
      })
