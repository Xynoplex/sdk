(* specs/src/vectors/store-cases.json *)

type chunk = { index : int; text : string; embedding : int list }

let chunk =
  Decode.obj (fun o : chunk ->
      {
        index = Decode.required o "index" Decode.int;
        text = Decode.required o "text" Decode.string;
        embedding = Decode.required o "embedding" (Decode.list Decode.int);
      })

type write_resource_put = {
  resource_id : string;
  chunks : chunk list;
  content_checksum : string;
  media_type : string;
  entity_types : string list;
  machine_read : bool option;
}

let write_resource_put =
  Decode.obj (fun o : write_resource_put ->
      Decode.required o "write" (Decode.literal "resourcePut");
      {
        resource_id = Decode.required o "resourceId" Decode.string;
        chunks = Decode.required o "chunks" (Decode.list chunk);
        content_checksum = Decode.required o "contentChecksum" Decode.string;
        media_type = Decode.required o "mediaType" Decode.string;
        entity_types =
          Decode.required o "entityTypes" (Decode.list Decode.string);
        machine_read = Decode.optional o "machineRead" Decode.bool;
      })

type write_annotation_put = {
  annotation_id : string;
  resource_id : string;
  motivation : string;
  entity_types : string list;
  text : string;
  embedding : int list;
  machine_read : bool option;
}

let write_annotation_put =
  Decode.obj (fun o : write_annotation_put ->
      Decode.required o "write" (Decode.literal "annotationPut");
      {
        annotation_id = Decode.required o "annotationId" Decode.string;
        resource_id = Decode.required o "resourceId" Decode.string;
        motivation = Decode.required o "motivation" Decode.string;
        entity_types =
          Decode.required o "entityTypes" (Decode.list Decode.string);
        text = Decode.required o "text" Decode.string;
        embedding = Decode.required o "embedding" (Decode.list Decode.int);
        machine_read = Decode.optional o "machineRead" Decode.bool;
      })

type write_entity_types_rewritten = {
  resource_id : string;
  entity_types : string list;
}

let write_entity_types_rewritten =
  Decode.obj (fun o : write_entity_types_rewritten ->
      Decode.required o "write" (Decode.literal "entityTypesRewritten");
      {
        resource_id = Decode.required o "resourceId" Decode.string;
        entity_types =
          Decode.required o "entityTypes" (Decode.list Decode.string);
      })

type write_annotation_entity_types_rewritten = {
  annotation_id : string;
  entity_types : string list;
}

let write_annotation_entity_types_rewritten =
  Decode.obj (fun o : write_annotation_entity_types_rewritten ->
      Decode.required o "write"
        (Decode.literal "annotationEntityTypesRewritten");
      {
        annotation_id = Decode.required o "annotationId" Decode.string;
        entity_types =
          Decode.required o "entityTypes" (Decode.list Decode.string);
      })

type write_resource_deleted = { resource_id : string }

let write_resource_deleted =
  Decode.obj (fun o : write_resource_deleted ->
      Decode.required o "write" (Decode.literal "resourceDeleted");
      { resource_id = Decode.required o "resourceId" Decode.string })

type write_annotation_deleted = { annotation_id : string }

let write_annotation_deleted =
  Decode.obj (fun o : write_annotation_deleted ->
      Decode.required o "write" (Decode.literal "annotationDeleted");
      { annotation_id = Decode.required o "annotationId" Decode.string })

type write_annotations_of_resource_deleted = { resource_id : string }

let write_annotations_of_resource_deleted =
  Decode.obj (fun o : write_annotations_of_resource_deleted ->
      Decode.required o "write" (Decode.literal "annotationsOfResourceDeleted");
      { resource_id = Decode.required o "resourceId" Decode.string })

type write_resource_declined = {
  resource_id : string;
  content_checksum : string;
  media_type : string;
  reason : string;
}

let write_resource_declined =
  Decode.obj (fun o : write_resource_declined ->
      Decode.required o "write" (Decode.literal "resourceDeclined");
      {
        resource_id = Decode.required o "resourceId" Decode.string;
        content_checksum = Decode.required o "contentChecksum" Decode.string;
        media_type = Decode.required o "mediaType" Decode.string;
        reason = Decode.required o "reason" Decode.string;
      })

type model = { provider : string; name : string }

let model =
  Decode.obj (fun o : model ->
      {
        provider = Decode.required o "provider" Decode.string;
        name = Decode.required o "name" Decode.string;
      })

type chunking = { size : int; overlap : int option }

let chunking =
  Decode.obj (fun o : chunking ->
      {
        size = Decode.required o "size" Decode.int;
        overlap = Decode.optional o "overlap" Decode.int;
      })

type stamp = {
  model : model;
  chunking : chunking;
  reads : string list option;
  revision : int option;
  exact : bool option;
}

let stamp =
  Decode.obj (fun o : stamp ->
      {
        model = Decode.required o "model" model;
        chunking = Decode.required o "chunking" chunking;
        reads = Decode.optional o "reads" (Decode.list Decode.string);
        revision = Decode.optional o "revision" Decode.int;
        exact = Decode.optional o "exact" Decode.bool;
      })

type write_made_anew = { stamp : stamp }

let write_made_anew =
  Decode.obj (fun o : write_made_anew ->
      Decode.required o "write" (Decode.literal "madeAnew");
      { stamp = Decode.required o "stamp" stamp })

type write =
  | Resource_put of write_resource_put
  | Annotation_put of write_annotation_put
  | Entity_types_rewritten of write_entity_types_rewritten
  | Annotation_entity_types_rewritten of write_annotation_entity_types_rewritten
  | Resource_deleted of write_resource_deleted
  | Annotation_deleted of write_annotation_deleted
  | Annotations_of_resource_deleted of write_annotations_of_resource_deleted
  | Resource_declined of write_resource_declined
  | Made_anew of write_made_anew

let write =
  Decode.variant "write"
    [
      ("resourcePut", fun c -> (Resource_put (write_resource_put c) : write));
      ( "annotationPut",
        fun c -> (Annotation_put (write_annotation_put c) : write) );
      ( "entityTypesRewritten",
        fun c ->
          (Entity_types_rewritten (write_entity_types_rewritten c) : write) );
      ( "annotationEntityTypesRewritten",
        fun c ->
          (Annotation_entity_types_rewritten
             (write_annotation_entity_types_rewritten c)
            : write) );
      ( "resourceDeleted",
        fun c -> (Resource_deleted (write_resource_deleted c) : write) );
      ( "annotationDeleted",
        fun c -> (Annotation_deleted (write_annotation_deleted c) : write) );
      ( "annotationsOfResourceDeleted",
        fun c ->
          (Annotations_of_resource_deleted
             (write_annotations_of_resource_deleted c)
            : write) );
      ( "resourceDeclined",
        fun c -> (Resource_declined (write_resource_declined c) : write) );
      ("madeAnew", fun c -> (Made_anew (write_made_anew c) : write));
    ]

type answer = {
  score : float;
  resource_id : string;
  text : string;
  entity_types : string list;
  machine_read : bool option;
}

let answer =
  Decode.obj (fun o : answer ->
      {
        score = Decode.required o "score" Decode.number;
        resource_id = Decode.required o "resourceId" Decode.string;
        text = Decode.required o "text" Decode.string;
        entity_types =
          Decode.required o "entityTypes" (Decode.list Decode.string);
        machine_read = Decode.optional o "machineRead" Decode.bool;
      })

type filter = {
  entity_types : string list option;
  exclude_entity_types : string list option;
  resource_id : string option;
  exclude_resource_id : string option;
}

let filter =
  Decode.obj (fun o : filter ->
      {
        entity_types =
          Decode.optional o "entityTypes" (Decode.list Decode.string);
        exclude_entity_types =
          Decode.optional o "excludeEntityTypes" (Decode.list Decode.string);
        resource_id = Decode.optional o "resourceId" Decode.string;
        exclude_resource_id =
          Decode.optional o "excludeResourceId" Decode.string;
      })

type read_resources_searched = {
  embedding : int list;
  limit : int;
  answers : answer list;
  filter : filter option;
  score_threshold : float option;
}

let read_resources_searched =
  Decode.obj (fun o : read_resources_searched ->
      Decode.required o "read" (Decode.literal "resourcesSearched");
      {
        embedding = Decode.required o "embedding" (Decode.list Decode.int);
        limit = Decode.required o "limit" Decode.int;
        answers = Decode.required o "answers" (Decode.list answer);
        filter = Decode.optional o "filter" filter;
        score_threshold = Decode.optional o "scoreThreshold" Decode.number;
      })

type read_annotations_searched_answer = {
  score : float;
  resource_id : string;
  annotation_id : string;
  text : string;
  entity_types : string list;
  machine_read : bool option;
}

let read_annotations_searched_answer =
  Decode.obj (fun o : read_annotations_searched_answer ->
      {
        score = Decode.required o "score" Decode.number;
        resource_id = Decode.required o "resourceId" Decode.string;
        annotation_id = Decode.required o "annotationId" Decode.string;
        text = Decode.required o "text" Decode.string;
        entity_types =
          Decode.required o "entityTypes" (Decode.list Decode.string);
        machine_read = Decode.optional o "machineRead" Decode.bool;
      })

type read_annotations_searched_filter = {
  motivation : string option;
  entity_types : string list option;
  resource_id : string option;
  exclude_resource_id : string option;
}

let read_annotations_searched_filter =
  Decode.obj (fun o : read_annotations_searched_filter ->
      {
        motivation = Decode.optional o "motivation" Decode.string;
        entity_types =
          Decode.optional o "entityTypes" (Decode.list Decode.string);
        resource_id = Decode.optional o "resourceId" Decode.string;
        exclude_resource_id =
          Decode.optional o "excludeResourceId" Decode.string;
      })

type read_annotations_searched = {
  embedding : int list;
  limit : int;
  answers : read_annotations_searched_answer list;
  filter : read_annotations_searched_filter option;
}

let read_annotations_searched =
  Decode.obj (fun o : read_annotations_searched ->
      Decode.required o "read" (Decode.literal "annotationsSearched");
      {
        embedding = Decode.required o "embedding" (Decode.list Decode.int);
        limit = Decode.required o "limit" Decode.int;
        answers =
          Decode.required o "answers"
            (Decode.list read_annotations_searched_answer);
        filter = Decode.optional o "filter" read_annotations_searched_filter;
      })

type read_searched_by_resource_answer = {
  score : float;
  resource_id : string;
  text : string;
  entity_types : string list;
}

let read_searched_by_resource_answer =
  Decode.obj (fun o : read_searched_by_resource_answer ->
      {
        score = Decode.required o "score" Decode.number;
        resource_id = Decode.required o "resourceId" Decode.string;
        text = Decode.required o "text" Decode.string;
        entity_types =
          Decode.required o "entityTypes" (Decode.list Decode.string);
      })

type read_searched_by_resource_filter = {
  exclude_entity_types : string list option;
  entity_types : string list option;
}

let read_searched_by_resource_filter =
  Decode.obj (fun o : read_searched_by_resource_filter ->
      {
        exclude_entity_types =
          Decode.optional o "excludeEntityTypes" (Decode.list Decode.string);
        entity_types =
          Decode.optional o "entityTypes" (Decode.list Decode.string);
      })

type read_searched_by_resource = {
  resource_id : string;
  limit : int;
  answers : read_searched_by_resource_answer list;
  filter : read_searched_by_resource_filter option;
  score_threshold : float option;
}

let read_searched_by_resource =
  Decode.obj (fun o : read_searched_by_resource ->
      Decode.required o "read" (Decode.literal "searchedByResource");
      {
        resource_id = Decode.required o "resourceId" Decode.string;
        limit = Decode.required o "limit" Decode.int;
        answers =
          Decode.required o "answers"
            (Decode.list read_searched_by_resource_answer);
        filter = Decode.optional o "filter" read_searched_by_resource_filter;
        score_threshold = Decode.optional o "scoreThreshold" Decode.number;
      })

type read_counted = { answers : int }

let read_counted =
  Decode.obj (fun o : read_counted ->
      Decode.required o "read" (Decode.literal "counted");
      { answers = Decode.required o "answers" Decode.int })

type read_stamps_listed_answer = {
  content_checksum : string;
  media_type : string;
  entity_types : string list;
}

let read_stamps_listed_answer =
  Decode.obj (fun o : read_stamps_listed_answer ->
      {
        content_checksum = Decode.required o "contentChecksum" Decode.string;
        media_type = Decode.required o "mediaType" Decode.string;
        entity_types =
          Decode.required o "entityTypes" (Decode.list Decode.string);
      })

type read_stamps_listed = {
  answers : (string * read_stamps_listed_answer) list;
}

let read_stamps_listed =
  Decode.obj (fun o : read_stamps_listed ->
      Decode.required o "read" (Decode.literal "stampsListed");
      {
        answers =
          Decode.required o "answers" (Decode.map read_stamps_listed_answer);
      })

type read_stamp_read_answer =
  | Bool of bool
  | String of string
  | Array of string list

let read_stamp_read_answer =
 fun c ->
  match Decode.kind c with
  | Decode.Bool -> (Bool (Decode.bool c) : read_stamp_read_answer)
  | Decode.String -> (String (Decode.string c) : read_stamp_read_answer)
  | Decode.Array ->
      (Array (Decode.list Decode.string c) : read_stamp_read_answer)
  | _ -> Decode.refuse c "expected a boolean, a string or an array"

type read_stamp_read = {
  resource_id : string;
  answers : (string * read_stamp_read_answer) list option;
}

let read_stamp_read =
  Decode.obj (fun o : read_stamp_read ->
      Decode.required o "read" (Decode.literal "stampRead");
      {
        resource_id = Decode.required o "resourceId" Decode.string;
        answers =
          Decode.optional o "answers" (Decode.map read_stamp_read_answer);
      })

type read_annotation_stamps_listed_answer = {
  resource_id : string;
  entity_types : string list;
}

let read_annotation_stamps_listed_answer =
  Decode.obj (fun o : read_annotation_stamps_listed_answer ->
      {
        resource_id = Decode.required o "resourceId" Decode.string;
        entity_types =
          Decode.required o "entityTypes" (Decode.list Decode.string);
      })

type read_annotation_stamps_listed = {
  answers : (string * read_annotation_stamps_listed_answer) list;
}

let read_annotation_stamps_listed =
  Decode.obj (fun o : read_annotation_stamps_listed ->
      Decode.required o "read" (Decode.literal "annotationStampsListed");
      {
        answers =
          Decode.required o "answers"
            (Decode.map read_annotation_stamps_listed_answer);
      })

type read_declined_listed_answer = {
  content_checksum : string;
  media_type : string;
  reason : string;
}

let read_declined_listed_answer =
  Decode.obj (fun o : read_declined_listed_answer ->
      {
        content_checksum = Decode.required o "contentChecksum" Decode.string;
        media_type = Decode.required o "mediaType" Decode.string;
        reason = Decode.required o "reason" Decode.string;
      })

type read_declined_listed = {
  answers : (string * read_declined_listed_answer) list;
}

let read_declined_listed =
  Decode.obj (fun o : read_declined_listed ->
      Decode.required o "read" (Decode.literal "declinedListed");
      {
        answers =
          Decode.required o "answers" (Decode.map read_declined_listed_answer);
      })

type read_index_stamp_read_answer_answer = {
  provider : string option;
  name : string option;
  size : int option;
  overlap : int option;
}

let read_index_stamp_read_answer_answer =
  Decode.obj (fun o : read_index_stamp_read_answer_answer ->
      {
        provider = Decode.optional o "provider" Decode.string;
        name = Decode.optional o "name" Decode.string;
        size = Decode.optional o "size" Decode.int;
        overlap = Decode.optional o "overlap" Decode.int;
      })

type read_index_stamp_read_answer =
  | Bool of bool
  | Int of int
  | Array of string list
  | Object of read_index_stamp_read_answer_answer

let read_index_stamp_read_answer =
 fun c ->
  match Decode.kind c with
  | Decode.Bool -> (Bool (Decode.bool c) : read_index_stamp_read_answer)
  | Decode.Int -> (Int (Decode.int c) : read_index_stamp_read_answer)
  | Decode.Array ->
      (Array (Decode.list Decode.string c) : read_index_stamp_read_answer)
  | Decode.Object ->
      (Object (read_index_stamp_read_answer_answer c)
        : read_index_stamp_read_answer)
  | _ -> Decode.refuse c "expected a boolean, an integer, an array or an object"

type read_index_stamp_read = {
  answers : (string * read_index_stamp_read_answer) list option;
}

let read_index_stamp_read =
  Decode.obj (fun o : read_index_stamp_read ->
      Decode.required o "read" (Decode.literal "indexStampRead");
      {
        answers =
          Decode.optional o "answers" (Decode.map read_index_stamp_read_answer);
      })

type read =
  | Resources_searched of read_resources_searched
  | Annotations_searched of read_annotations_searched
  | Searched_by_resource of read_searched_by_resource
  | Counted of read_counted
  | Stamps_listed of read_stamps_listed
  | Stamp_read of read_stamp_read
  | Annotation_stamps_listed of read_annotation_stamps_listed
  | Declined_listed of read_declined_listed
  | Index_stamp_read of read_index_stamp_read

let read =
  Decode.variant "read"
    [
      ( "resourcesSearched",
        fun c -> (Resources_searched (read_resources_searched c) : read) );
      ( "annotationsSearched",
        fun c -> (Annotations_searched (read_annotations_searched c) : read) );
      ( "searchedByResource",
        fun c -> (Searched_by_resource (read_searched_by_resource c) : read) );
      ("counted", fun c -> (Counted (read_counted c) : read));
      ("stampsListed", fun c -> (Stamps_listed (read_stamps_listed c) : read));
      ("stampRead", fun c -> (Stamp_read (read_stamp_read c) : read));
      ( "annotationStampsListed",
        fun c ->
          (Annotation_stamps_listed (read_annotation_stamps_listed c) : read) );
      ( "declinedListed",
        fun c -> (Declined_listed (read_declined_listed c) : read) );
      ( "indexStampRead",
        fun c -> (Index_stamp_read (read_index_stamp_read c) : read) );
    ]

type case = { why : string; writes : write list; reads : read list }

let case =
  Decode.obj (fun o : case ->
      {
        why = Decode.required o "why" Decode.string;
        writes = Decode.required o "writes" (Decode.list write);
        reads = Decode.required o "reads" (Decode.list read);
      })

type t = { comment : string; cases : case list }

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        cases = Decode.required o "cases" (Decode.list case);
      })
