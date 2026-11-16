(* specs/src/vectors/payload-cases.json *)

type indexes = { entity_types : string; resource_id : string }

let indexes =
  Decode.obj (fun o : indexes ->
      {
        entity_types = Decode.required o "entityTypes" Decode.string;
        resource_id = Decode.required o "resourceId" Decode.string;
      })

type resources = { distance : string; indexes : indexes }

let resources =
  Decode.obj (fun o : resources ->
      {
        distance = Decode.required o "distance" Decode.string;
        indexes = Decode.required o "indexes" indexes;
      })

type annotations_indexes = { resource_id : string }

let annotations_indexes =
  Decode.obj (fun o : annotations_indexes ->
      { resource_id = Decode.required o "resourceId" Decode.string })

type annotations = { distance : string; indexes : annotations_indexes }

let annotations =
  Decode.obj (fun o : annotations ->
      {
        distance = Decode.required o "distance" Decode.string;
        indexes = Decode.required o "indexes" annotations_indexes;
      })

type declined = { distance : string; size : int; indexes : unit }

let declined =
  Decode.obj (fun o : declined ->
      {
        distance = Decode.required o "distance" Decode.string;
        size = Decode.required o "size" Decode.int;
        indexes = Decode.required o "indexes" (Decode.obj (fun _ -> ()));
      })

type collections = {
  resources : resources;
  annotations : annotations;
  declined : declined;
}

let collections =
  Decode.obj (fun o : collections ->
      {
        resources = Decode.required o "resources" resources;
        annotations = Decode.required o "annotations" annotations;
        declined = Decode.required o "declined" declined;
      })

type chunk = { index : int; text : string; embedding : int list }

let chunk =
  Decode.obj (fun o : chunk ->
      {
        index = Decode.required o "index" Decode.int;
        text = Decode.required o "text" Decode.string;
        embedding = Decode.required o "embedding" (Decode.list Decode.int);
      })

type payload = {
  resource_id : string;
  chunk_index : int;
  text : string;
  content_checksum : string;
  media_type : string;
  entity_types : string list;
  machine_read : bool option;
}

let payload =
  Decode.obj (fun o : payload ->
      {
        resource_id = Decode.required o "resourceId" Decode.string;
        chunk_index = Decode.required o "chunkIndex" Decode.int;
        text = Decode.required o "text" Decode.string;
        content_checksum = Decode.required o "contentChecksum" Decode.string;
        media_type = Decode.required o "mediaType" Decode.string;
        entity_types =
          Decode.required o "entityTypes" (Decode.list Decode.string);
        machine_read = Decode.optional o "machineRead" Decode.bool;
      })

type point_result = {
  score : float;
  resource_id : string;
  text : string;
  entity_types : string list;
  machine_read : bool option;
}

let point_result =
  Decode.obj (fun o : point_result ->
      {
        score = Decode.required o "score" Decode.number;
        resource_id = Decode.required o "resourceId" Decode.string;
        text = Decode.required o "text" Decode.string;
        entity_types =
          Decode.required o "entityTypes" (Decode.list Decode.string);
        machine_read = Decode.optional o "machineRead" Decode.bool;
      })

type point = { qdrant_id : string; payload : payload; result : point_result }

let point =
  Decode.obj (fun o : point ->
      {
        qdrant_id = Decode.required o "qdrantId" Decode.string;
        payload = Decode.required o "payload" payload;
        result = Decode.required o "result" point_result;
      })

type stamp = {
  content_checksum : string;
  media_type : string;
  entity_types : string list;
  machine_read : bool option;
}

let stamp =
  Decode.obj (fun o : stamp ->
      {
        content_checksum = Decode.required o "contentChecksum" Decode.string;
        media_type = Decode.required o "mediaType" Decode.string;
        entity_types =
          Decode.required o "entityTypes" (Decode.list Decode.string);
        machine_read = Decode.optional o "machineRead" Decode.bool;
      })

type resource_stored = {
  resource_id : string;
  chunks : chunk list;
  content_checksum : string;
  media_type : string;
  entity_types : string list;
  points : point list;
  stamp : stamp;
  machine_read : bool option;
}

let resource_stored =
  Decode.obj (fun o : resource_stored ->
      {
        resource_id = Decode.required o "resourceId" Decode.string;
        chunks = Decode.required o "chunks" (Decode.list chunk);
        content_checksum = Decode.required o "contentChecksum" Decode.string;
        media_type = Decode.required o "mediaType" Decode.string;
        entity_types =
          Decode.required o "entityTypes" (Decode.list Decode.string);
        points = Decode.required o "points" (Decode.list point);
        stamp = Decode.required o "stamp" stamp;
        machine_read = Decode.optional o "machineRead" Decode.bool;
      })

type annotation_stored_point_payload = {
  annotation_id : string;
  resource_id : string;
  motivation : string;
  entity_types : string list;
  text : string;
  machine_read : bool option;
}

let annotation_stored_point_payload =
  Decode.obj (fun o : annotation_stored_point_payload ->
      {
        annotation_id = Decode.required o "annotationId" Decode.string;
        resource_id = Decode.required o "resourceId" Decode.string;
        motivation = Decode.required o "motivation" Decode.string;
        entity_types =
          Decode.required o "entityTypes" (Decode.list Decode.string);
        text = Decode.required o "text" Decode.string;
        machine_read = Decode.optional o "machineRead" Decode.bool;
      })

type annotation_stored_point_result = {
  score : float;
  resource_id : string;
  annotation_id : string;
  text : string;
  entity_types : string list;
  machine_read : bool option;
}

let annotation_stored_point_result =
  Decode.obj (fun o : annotation_stored_point_result ->
      {
        score = Decode.required o "score" Decode.number;
        resource_id = Decode.required o "resourceId" Decode.string;
        annotation_id = Decode.required o "annotationId" Decode.string;
        text = Decode.required o "text" Decode.string;
        entity_types =
          Decode.required o "entityTypes" (Decode.list Decode.string);
        machine_read = Decode.optional o "machineRead" Decode.bool;
      })

type annotation_stored_point = {
  qdrant_id : string;
  payload : annotation_stored_point_payload;
  result : annotation_stored_point_result;
}

let annotation_stored_point =
  Decode.obj (fun o : annotation_stored_point ->
      {
        qdrant_id = Decode.required o "qdrantId" Decode.string;
        payload = Decode.required o "payload" annotation_stored_point_payload;
        result = Decode.required o "result" annotation_stored_point_result;
      })

type annotation_stored = {
  annotation_id : string;
  resource_id : string;
  motivation : string;
  entity_types : string list;
  text : string;
  embedding : int list;
  point : annotation_stored_point;
  machine_read : bool option;
}

let annotation_stored =
  Decode.obj (fun o : annotation_stored ->
      {
        annotation_id = Decode.required o "annotationId" Decode.string;
        resource_id = Decode.required o "resourceId" Decode.string;
        motivation = Decode.required o "motivation" Decode.string;
        entity_types =
          Decode.required o "entityTypes" (Decode.list Decode.string);
        text = Decode.required o "text" Decode.string;
        embedding = Decode.required o "embedding" (Decode.list Decode.int);
        point = Decode.required o "point" annotation_stored_point;
        machine_read = Decode.optional o "machineRead" Decode.bool;
      })

type decline_stored_point_payload = {
  resource_id : string;
  content_checksum : string;
  media_type : string;
  reason : string;
}

let decline_stored_point_payload =
  Decode.obj (fun o : decline_stored_point_payload ->
      {
        resource_id = Decode.required o "resourceId" Decode.string;
        content_checksum = Decode.required o "contentChecksum" Decode.string;
        media_type = Decode.required o "mediaType" Decode.string;
        reason = Decode.required o "reason" Decode.string;
      })

type decline_stored_point = {
  qdrant_id : string;
  payload : decline_stored_point_payload;
}

let decline_stored_point =
  Decode.obj (fun o : decline_stored_point ->
      {
        qdrant_id = Decode.required o "qdrantId" Decode.string;
        payload = Decode.required o "payload" decline_stored_point_payload;
      })

type decline_stored = {
  resource_id : string;
  content_checksum : string;
  media_type : string;
  reason : string;
  point : decline_stored_point;
}

let decline_stored =
  Decode.obj (fun o : decline_stored ->
      {
        resource_id = Decode.required o "resourceId" Decode.string;
        content_checksum = Decode.required o "contentChecksum" Decode.string;
        media_type = Decode.required o "mediaType" Decode.string;
        reason = Decode.required o "reason" Decode.string;
        point = Decode.required o "point" decline_stored_point;
      })

type stamp_read_payload = {
  resource_id : string option;
  chunk_index : int;
  text : string;
  content_checksum : string option;
  media_type : string option;
  entity_types : string list option;
  machine_read : bool option;
}

let stamp_read_payload =
  Decode.obj (fun o : stamp_read_payload ->
      {
        resource_id = Decode.optional o "resourceId" Decode.string;
        chunk_index = Decode.required o "chunkIndex" Decode.int;
        text = Decode.required o "text" Decode.string;
        content_checksum = Decode.optional o "contentChecksum" Decode.string;
        media_type = Decode.optional o "mediaType" Decode.string;
        entity_types =
          Decode.optional o "entityTypes" (Decode.list Decode.string);
        machine_read = Decode.optional o "machineRead" Decode.bool;
      })

type stamp_read_stamp = {
  content_checksum : string option;
  media_type : string option;
  entity_types : string list;
  machine_read : bool option;
}

let stamp_read_stamp =
  Decode.obj (fun o : stamp_read_stamp ->
      {
        content_checksum = Decode.optional o "contentChecksum" Decode.string;
        media_type = Decode.optional o "mediaType" Decode.string;
        entity_types =
          Decode.required o "entityTypes" (Decode.list Decode.string);
        machine_read = Decode.optional o "machineRead" Decode.bool;
      })

type stamp_read = {
  payload : stamp_read_payload;
  stamp : stamp_read_stamp option;
}

let stamp_read =
  Decode.obj (fun o : stamp_read ->
      {
        payload = Decode.required o "payload" stamp_read_payload;
        stamp = Decode.optional o "stamp" stamp_read_stamp;
      })

type annotation_stamp_read_payload = {
  annotation_id : string option;
  resource_id : string option;
  motivation : string;
  entity_types : string list option;
  text : string;
  machine_read : bool option;
}

let annotation_stamp_read_payload =
  Decode.obj (fun o : annotation_stamp_read_payload ->
      {
        annotation_id = Decode.optional o "annotationId" Decode.string;
        resource_id = Decode.optional o "resourceId" Decode.string;
        motivation = Decode.required o "motivation" Decode.string;
        entity_types =
          Decode.optional o "entityTypes" (Decode.list Decode.string);
        text = Decode.required o "text" Decode.string;
        machine_read = Decode.optional o "machineRead" Decode.bool;
      })

type annotation_stamp_read_stamp = {
  resource_id : string option;
  entity_types : string list;
}

let annotation_stamp_read_stamp =
  Decode.obj (fun o : annotation_stamp_read_stamp ->
      {
        resource_id = Decode.optional o "resourceId" Decode.string;
        entity_types =
          Decode.required o "entityTypes" (Decode.list Decode.string);
      })

type annotation_stamp_read = {
  payload : annotation_stamp_read_payload;
  stamp : annotation_stamp_read_stamp option;
}

let annotation_stamp_read =
  Decode.obj (fun o : annotation_stamp_read ->
      {
        payload = Decode.required o "payload" annotation_stamp_read_payload;
        stamp = Decode.optional o "stamp" annotation_stamp_read_stamp;
      })

type result_read_payload = {
  resource_id : string;
  chunk_index : int option;
  text : string;
  content_checksum : string option;
  media_type : string option;
  entity_types : string list;
  annotation_id : string option;
  motivation : string option;
  machine_read : bool option;
}

let result_read_payload =
  Decode.obj (fun o : result_read_payload ->
      {
        resource_id = Decode.required o "resourceId" Decode.string;
        chunk_index = Decode.optional o "chunkIndex" Decode.int;
        text = Decode.required o "text" Decode.string;
        content_checksum = Decode.optional o "contentChecksum" Decode.string;
        media_type = Decode.optional o "mediaType" Decode.string;
        entity_types =
          Decode.required o "entityTypes" (Decode.list Decode.string);
        annotation_id = Decode.optional o "annotationId" Decode.string;
        motivation = Decode.optional o "motivation" Decode.string;
        machine_read = Decode.optional o "machineRead" Decode.bool;
      })

type result_read_result = {
  score : float;
  resource_id : string;
  text : string;
  entity_types : string list;
  annotation_id : string option;
  machine_read : bool option;
}

let result_read_result =
  Decode.obj (fun o : result_read_result ->
      {
        score = Decode.required o "score" Decode.number;
        resource_id = Decode.required o "resourceId" Decode.string;
        text = Decode.required o "text" Decode.string;
        entity_types =
          Decode.required o "entityTypes" (Decode.list Decode.string);
        annotation_id = Decode.optional o "annotationId" Decode.string;
        machine_read = Decode.optional o "machineRead" Decode.bool;
      })

type result_read = {
  collection : string;
  payload : result_read_payload;
  score : float;
  result : result_read_result;
}

let result_read =
  Decode.obj (fun o : result_read ->
      {
        collection = Decode.required o "collection" Decode.string;
        payload = Decode.required o "payload" result_read_payload;
        score = Decode.required o "score" Decode.number;
        result = Decode.required o "result" result_read_result;
      })

type names = { resources : string; annotations : string; declined : string }

let names =
  Decode.obj (fun o : names ->
      {
        resources = Decode.required o "resources" Decode.string;
        annotations = Decode.required o "annotations" Decode.string;
        declined = Decode.required o "declined" Decode.string;
      })

type collections_named = { kb : string; names : names }

let collections_named =
  Decode.obj (fun o : collections_named ->
      {
        kb = Decode.required o "kb" Decode.string;
        names = Decode.required o "names" names;
      })

type case = {
  why : string;
  resource_stored : resource_stored option;
  annotation_stored : annotation_stored option;
  decline_stored : decline_stored option;
  stamp_read : stamp_read option;
  annotation_stamp_read : annotation_stamp_read option;
  result_read : result_read option;
  collections_named : collections_named option;
}

let case =
  Decode.obj (fun o : case ->
      {
        why = Decode.required o "why" Decode.string;
        resource_stored = Decode.optional o "resourceStored" resource_stored;
        annotation_stored =
          Decode.optional o "annotationStored" annotation_stored;
        decline_stored = Decode.optional o "declineStored" decline_stored;
        stamp_read = Decode.optional o "stampRead" stamp_read;
        annotation_stamp_read =
          Decode.optional o "annotationStampRead" annotation_stamp_read;
        result_read = Decode.optional o "resultRead" result_read;
        collections_named =
          Decode.optional o "collectionsNamed" collections_named;
      })

type t = {
  comment : string;
  run_by : Case_table.run_by;
  collections : collections;
  cases : case list;
}

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        run_by = Decode.required o "runBy" Case_table.run_by;
        collections = Decode.required o "collections" collections;
        cases = Decode.required o "cases" (Decode.list case);
      })
