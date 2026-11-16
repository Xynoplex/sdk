(* specs/src/media-types/registry.json *)

type media_type = {
  media_type : string;
  extension : string;
  label : string;
  render : string;
  anchoring : string;
  text_source : string;
  authorable : bool;
  uploadable : bool;
  generatable : bool;
}

let media_type =
  Decode.obj (fun o : media_type ->
      {
        media_type = Decode.required o "mediaType" Decode.string;
        extension = Decode.required o "extension" Decode.string;
        label = Decode.required o "label" Decode.string;
        render = Decode.required o "render" Decode.string;
        anchoring = Decode.required o "anchoring" Decode.string;
        text_source = Decode.required o "textSource" Decode.string;
        authorable = Decode.required o "authorable" Decode.bool;
        uploadable = Decode.required o "uploadable" Decode.bool;
        generatable = Decode.required o "generatable" Decode.bool;
      })

type t = {
  comment : string;
  render : string list;
  anchoring : string list;
  text_source : string list;
  extension_aliases : (string * string) list;
  media_types : media_type list;
}

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        render = Decode.required o "render" (Decode.list Decode.string);
        anchoring = Decode.required o "anchoring" (Decode.list Decode.string);
        text_source = Decode.required o "textSource" (Decode.list Decode.string);
        extension_aliases =
          Decode.required o "extensionAliases" (Decode.map Decode.string);
        media_types = Decode.required o "mediaTypes" (Decode.list media_type);
      })
