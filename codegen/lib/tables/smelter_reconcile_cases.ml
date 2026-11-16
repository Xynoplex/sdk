(* specs/src/smelter/reconcile-cases.json *)

type resource = {
  id : string;
  checksum : string option;
  media_type : string option;
  entity_types : string list;
}

let resource =
  Decode.obj (fun o : resource ->
      {
        id = Decode.required o "id" Decode.string;
        checksum = Decode.optional o "checksum" Decode.string;
        media_type = Decode.optional o "mediaType" Decode.string;
        entity_types =
          Decode.required o "entityTypes" (Decode.list Decode.string);
      })

type declined_item = { id : string; checksum : string; media_type : string }

let declined_item =
  Decode.obj (fun o : declined_item ->
      {
        id = Decode.required o "id" Decode.string;
        checksum = Decode.required o "checksum" Decode.string;
        media_type = Decode.required o "mediaType" Decode.string;
      })

type annotation = { id : string; entity_types : string list }

let annotation =
  Decode.obj (fun o : annotation ->
      {
        id = Decode.required o "id" Decode.string;
        entity_types =
          Decode.required o "entityTypes" (Decode.list Decode.string);
      })

type index = {
  resources : resource list;
  declined : declined_item list;
  annotations : annotation list;
}

let index =
  Decode.obj (fun o : index ->
      {
        resources = Decode.required o "resources" (Decode.list resource);
        declined = Decode.required o "declined" (Decode.list declined_item);
        annotations = Decode.required o "annotations" (Decode.list annotation);
      })

type catalog_item_annotation = {
  id : string;
  quote : string;
  entity_types : string list;
}

let catalog_item_annotation =
  Decode.obj (fun o : catalog_item_annotation ->
      {
        id = Decode.required o "id" Decode.string;
        quote = Decode.required o "quote" Decode.string;
        entity_types =
          Decode.required o "entityTypes" (Decode.list Decode.string);
      })

type catalog_item = {
  id : string;
  media_type : string option;
  checksum : string option;
  entity_types : string list;
  annotations : catalog_item_annotation list;
}

let catalog_item =
  Decode.obj (fun o : catalog_item ->
      {
        id = Decode.required o "id" Decode.string;
        media_type = Decode.optional o "mediaType" Decode.string;
        checksum = Decode.optional o "checksum" Decode.string;
        entity_types =
          Decode.required o "entityTypes" (Decode.list Decode.string);
        annotations =
          Decode.required o "annotations" (Decode.list catalog_item_annotation);
      })

type work_item_embed = { resource : string }

let work_item_embed =
  Decode.obj (fun o : work_item_embed ->
      Decode.required o "kind" (Decode.literal "embed");
      { resource = Decode.required o "resource" Decode.string })

type work_item_restamp = { resource : string }

let work_item_restamp =
  Decode.obj (fun o : work_item_restamp ->
      Decode.required o "kind" (Decode.literal "restamp");
      { resource = Decode.required o "resource" Decode.string })

type work_item_reanchor = { resource : string }

let work_item_reanchor =
  Decode.obj (fun o : work_item_reanchor ->
      Decode.required o "kind" (Decode.literal "reanchor");
      { resource = Decode.required o "resource" Decode.string })

type work_item_purge = { resource : string }

let work_item_purge =
  Decode.obj (fun o : work_item_purge ->
      Decode.required o "kind" (Decode.literal "purge");
      { resource = Decode.required o "resource" Decode.string })

type work_item_embed_annotation = { annotation : string; resource : string }

let work_item_embed_annotation =
  Decode.obj (fun o : work_item_embed_annotation ->
      Decode.required o "kind" (Decode.literal "embed-annotation");
      {
        annotation = Decode.required o "annotation" Decode.string;
        resource = Decode.required o "resource" Decode.string;
      })

type work_item_purge_annotation = { annotation : string }

let work_item_purge_annotation =
  Decode.obj (fun o : work_item_purge_annotation ->
      Decode.required o "kind" (Decode.literal "purge-annotation");
      { annotation = Decode.required o "annotation" Decode.string })

type work_item_restamp_annotation = { annotation : string; resource : string }

let work_item_restamp_annotation =
  Decode.obj (fun o : work_item_restamp_annotation ->
      Decode.required o "kind" (Decode.literal "restamp-annotation");
      {
        annotation = Decode.required o "annotation" Decode.string;
        resource = Decode.required o "resource" Decode.string;
      })

type work_item =
  | Embed of work_item_embed
  | Restamp of work_item_restamp
  | Reanchor of work_item_reanchor
  | Purge of work_item_purge
  | Embed_annotation of work_item_embed_annotation
  | Purge_annotation of work_item_purge_annotation
  | Restamp_annotation of work_item_restamp_annotation

let work_item =
  Decode.variant "kind"
    [
      ("embed", fun c -> (Embed (work_item_embed c) : work_item));
      ("restamp", fun c -> (Restamp (work_item_restamp c) : work_item));
      ("reanchor", fun c -> (Reanchor (work_item_reanchor c) : work_item));
      ("purge", fun c -> (Purge (work_item_purge c) : work_item));
      ( "embed-annotation",
        fun c -> (Embed_annotation (work_item_embed_annotation c) : work_item)
      );
      ( "purge-annotation",
        fun c -> (Purge_annotation (work_item_purge_annotation c) : work_item)
      );
      ( "restamp-annotation",
        fun c ->
          (Restamp_annotation (work_item_restamp_annotation c) : work_item) );
    ]

type case = {
  why : string;
  index : index;
  anchored : string list;
  catalog : catalog_item list;
  work : work_item list;
}

let case =
  Decode.obj (fun o : case ->
      {
        why = Decode.required o "why" Decode.string;
        index = Decode.required o "index" index;
        anchored = Decode.required o "anchored" (Decode.list Decode.string);
        catalog = Decode.required o "catalog" (Decode.list catalog_item);
        work = Decode.required o "work" (Decode.list work_item);
      })

type t = { comment : string; run_by : Case_table.run_by; cases : case list }

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        run_by = Decode.required o "runBy" Case_table.run_by;
        cases = Decode.required o "cases" (Decode.list case);
      })
