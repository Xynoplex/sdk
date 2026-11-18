(* specs/src/jobs/filter-cases.json *)

type params = { motivation : string }

let params =
  Decode.obj (fun o : params ->
      { motivation = Decode.required o "motivation" Decode.string })

type filter = { job_type : string; params : params option }

let filter =
  Decode.obj (fun o : filter ->
      {
        job_type = Decode.required o "jobType" Decode.string;
        params = Decode.optional o "params" params;
      })

type job_params = {
  motivation : string option;
  schema_id : string option;
  categories : string list option;
  title : string option;
  storage_uri : string option;
  output_media_type : string option;
  tone : string option;
  language : string option;
  entity_types : string list option;
  resource_id : string option;
}

let job_params =
  Decode.obj (fun o : job_params ->
      {
        motivation = Decode.optional o "motivation" Decode.string;
        schema_id = Decode.optional o "schemaId" Decode.string;
        categories = Decode.optional o "categories" (Decode.list Decode.string);
        title = Decode.optional o "title" Decode.string;
        storage_uri = Decode.optional o "storageUri" Decode.string;
        output_media_type = Decode.optional o "outputMediaType" Decode.string;
        tone = Decode.optional o "tone" Decode.string;
        language = Decode.optional o "language" Decode.string;
        entity_types =
          Decode.optional o "entityTypes" (Decode.list Decode.string);
        resource_id = Decode.optional o "resourceId" Decode.string;
      })

type job = { job_type : string; params : job_params }

let job =
  Decode.obj (fun o : job ->
      {
        job_type = Decode.required o "jobType" Decode.string;
        params = Decode.required o "params" job_params;
      })

type case = { why : string; filter : filter; job : job; matches : bool }

let case =
  Decode.obj (fun o : case ->
      {
        why = Decode.required o "why" Decode.string;
        filter = Decode.required o "filter" filter;
        job = Decode.required o "job" job;
        matches = Decode.required o "matches" Decode.bool;
      })

type t = { comment : string; cases : case list }

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        cases = Decode.required o "cases" (Decode.list case);
      })
