(* specs/src/resources/reader-cases.json *)

type primary_representation = {
  media_type : string;
  storage_uri : string option;
  byte_size : int option;
  checksum : string option;
  language : string option;
  rel : string option;
  width : int option;
  height : int option;
}

let primary_representation =
  Decode.obj (fun o : primary_representation ->
      {
        media_type = Decode.required o "mediaType" Decode.string;
        storage_uri = Decode.optional o "storageUri" Decode.string;
        byte_size = Decode.optional o "byteSize" Decode.int;
        checksum = Decode.optional o "checksum" Decode.string;
        language = Decode.optional o "language" Decode.string;
        rel = Decode.optional o "rel" Decode.string;
        width = Decode.optional o "width" Decode.int;
        height = Decode.optional o "height" Decode.int;
      })

type case = {
  why : string;
  resource : Yojson.Safe.t;
  primary_representation : primary_representation option;
  primary_media_type : string option;
  entity_types : string list option;
  refused : bool option;
  member : string option;
  reason : string option;
}

let case =
  Decode.obj (fun o : case ->
      {
        why = Decode.required o "why" Decode.string;
        resource = Decode.required o "resource" Decode.json;
        primary_representation =
          Decode.optional o "primaryRepresentation" primary_representation;
        primary_media_type = Decode.optional o "primaryMediaType" Decode.string;
        entity_types =
          Decode.optional o "entityTypes" (Decode.list Decode.string);
        refused = Decode.optional o "refused" Decode.bool;
        member = Decode.optional o "member" Decode.string;
        reason = Decode.optional o "reason" Decode.string;
      })

type t = { comment : string; run_by : Case_table.run_by; cases : case list }

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        run_by = Decode.required o "runBy" Case_table.run_by;
        cases = Decode.required o "cases" (Decode.list case);
      })
