(* specs/src/librarian/search-cases.json *)

type filters = {
  search : string;
  limit : int option;
  archived : bool option;
  entity_type : string option;
  offset : int option;
}

let filters =
  Decode.obj (fun o : filters ->
      {
        search = Decode.required o "search" Decode.string;
        limit = Decode.optional o "limit" Decode.int;
        archived = Decode.optional o "archived" Decode.bool;
        entity_type = Decode.optional o "entityType" Decode.string;
        offset = Decode.optional o "offset" Decode.int;
      })

type resource = {
  context : string;
  id : string;
  name : string;
  representations : Decode.nothing list;
  entity_types : string list option;
  archived : bool option;
  content : string option;
  date_created : string option;
}

let resource =
  Decode.obj (fun o : resource ->
      {
        context = Decode.required o "@context" Decode.string;
        id = Decode.required o "@id" Decode.string;
        name = Decode.required o "name" Decode.string;
        representations =
          Decode.required o "representations" (Decode.list Decode.nothing);
        entity_types =
          Decode.optional o "entityTypes" (Decode.list Decode.string);
        archived = Decode.optional o "archived" Decode.bool;
        content = Decode.optional o "content" Decode.string;
        date_created = Decode.optional o "dateCreated" Decode.string;
      })

type page = { resources : resource list; total : int; match_kind : string }

let page =
  Decode.obj (fun o : page ->
      {
        resources = Decode.required o "resources" (Decode.list resource);
        total = Decode.required o "total" Decode.int;
        match_kind = Decode.required o "matchKind" Decode.string;
      })

type asked = {
  search : string;
  offset : int;
  limit : int;
  archived : bool option;
  entity_types : string list option;
}

let asked =
  Decode.obj (fun o : asked ->
      {
        search = Decode.required o "search" Decode.string;
        offset = Decode.required o "offset" Decode.int;
        limit = Decode.required o "limit" Decode.int;
        archived = Decode.optional o "archived" Decode.bool;
        entity_types =
          Decode.optional o "entityTypes" (Decode.list Decode.string);
      })

type answers_resource = {
  context : string;
  id : string;
  name : string;
  representations : Decode.nothing list;
  entity_types : string list option;
  archived : bool option;
}

let answers_resource =
  Decode.obj (fun o : answers_resource ->
      {
        context = Decode.required o "@context" Decode.string;
        id = Decode.required o "@id" Decode.string;
        name = Decode.required o "name" Decode.string;
        representations =
          Decode.required o "representations" (Decode.list Decode.nothing);
        entity_types =
          Decode.optional o "entityTypes" (Decode.list Decode.string);
        archived = Decode.optional o "archived" Decode.bool;
      })

type answers = { resources : answers_resource list; total : int }

let answers =
  Decode.obj (fun o : answers ->
      {
        resources = Decode.required o "resources" (Decode.list answers_resource);
        total = Decode.required o "total" Decode.int;
      })

type graph = { asked : asked; answers : answers option; fails : bool option }

let graph =
  Decode.obj (fun o : graph ->
      {
        asked = Decode.required o "asked" asked;
        answers = Decode.optional o "answers" answers;
        fails = Decode.optional o "fails" Decode.bool;
      })

type embedding = {
  asked : string;
  answers : float list option;
  fails : bool option;
}

let embedding =
  Decode.obj (fun o : embedding ->
      {
        asked = Decode.required o "asked" Decode.string;
        answers = Decode.optional o "answers" (Decode.list Decode.number);
        fails = Decode.optional o "fails" Decode.bool;
      })

type index_asked = {
  embedding : float list;
  limit : int;
  entity_types : string list option;
}

let index_asked =
  Decode.obj (fun o : index_asked ->
      {
        embedding = Decode.required o "embedding" (Decode.list Decode.number);
        limit = Decode.required o "limit" Decode.int;
        entity_types =
          Decode.optional o "entityTypes" (Decode.list Decode.string);
      })

type answer = {
  id : string;
  resource_id : string;
  score : float;
  text : string;
}

let answer =
  Decode.obj (fun o : answer ->
      {
        id = Decode.required o "id" Decode.string;
        resource_id = Decode.required o "resourceId" Decode.string;
        score = Decode.required o "score" Decode.number;
        text = Decode.required o "text" Decode.string;
      })

type index = {
  asked : index_asked;
  answers : answer list option;
  fails : bool option;
}

let index =
  Decode.obj (fun o : index ->
      {
        asked = Decode.required o "asked" index_asked;
        answers = Decode.optional o "answers" (Decode.list answer);
        fails = Decode.optional o "fails" Decode.bool;
      })

type hydrated_item_graph_answers = {
  context : string;
  id : string;
  name : string;
  representations : Decode.nothing list;
  entity_types : string list option;
  date_created : string option;
}

let hydrated_item_graph_answers =
  Decode.obj (fun o : hydrated_item_graph_answers ->
      {
        context = Decode.required o "@context" Decode.string;
        id = Decode.required o "@id" Decode.string;
        name = Decode.required o "name" Decode.string;
        representations =
          Decode.required o "representations" (Decode.list Decode.nothing);
        entity_types =
          Decode.optional o "entityTypes" (Decode.list Decode.string);
        date_created = Decode.optional o "dateCreated" Decode.string;
      })

type hydrated_item_graph = {
  answers : hydrated_item_graph_answers option option;
  fails : bool option;
}

let hydrated_item_graph =
  Decode.obj (fun o : hydrated_item_graph ->
      {
        answers =
          Decode.optional o "answers"
            (Decode.nullable hydrated_item_graph_answers);
        fails = Decode.optional o "fails" Decode.bool;
      })

type view_answers_resource = {
  context : string;
  id : string;
  name : string;
  representations : Decode.nothing list;
}

let view_answers_resource =
  Decode.obj (fun o : view_answers_resource ->
      {
        context = Decode.required o "@context" Decode.string;
        id = Decode.required o "@id" Decode.string;
        name = Decode.required o "name" Decode.string;
        representations =
          Decode.required o "representations" (Decode.list Decode.nothing);
      })

type annotations = {
  resource_id : string;
  annotations : Decode.nothing list;
  version : int;
  updated_at : string;
}

let annotations =
  Decode.obj (fun o : annotations ->
      {
        resource_id = Decode.required o "resourceId" Decode.string;
        annotations =
          Decode.required o "annotations" (Decode.list Decode.nothing);
        version = Decode.required o "version" Decode.int;
        updated_at = Decode.required o "updatedAt" Decode.string;
      })

type view_answers = {
  resource : view_answers_resource;
  annotations : annotations;
  last_sequence : int;
}

let view_answers =
  Decode.obj (fun o : view_answers ->
      {
        resource = Decode.required o "resource" view_answers_resource;
        annotations = Decode.required o "annotations" annotations;
        last_sequence = Decode.required o "lastSequence" Decode.int;
      })

type view = { answers : view_answers option option; fails : bool option }

let view =
  Decode.obj (fun o : view ->
      {
        answers = Decode.optional o "answers" (Decode.nullable view_answers);
        fails = Decode.optional o "fails" Decode.bool;
      })

type hydrated_item = {
  resource : string;
  graph : hydrated_item_graph;
  view : view option;
}

let hydrated_item =
  Decode.obj (fun o : hydrated_item ->
      {
        resource = Decode.required o "resource" Decode.string;
        graph = Decode.required o "graph" hydrated_item_graph;
        view = Decode.optional o "view" view;
      })

type search = {
  filters : filters;
  semantic_floor : float;
  page : page option;
  graph : graph option;
  embedding : embedding option;
  index : index option;
  hydrated : hydrated_item list option;
  fails : bool option;
}

let search =
  Decode.obj (fun o : search ->
      {
        filters = Decode.required o "filters" filters;
        semantic_floor = Decode.required o "semanticFloor" Decode.number;
        page = Decode.optional o "page" page;
        graph = Decode.optional o "graph" graph;
        embedding = Decode.optional o "embedding" embedding;
        index = Decode.optional o "index" index;
        hydrated = Decode.optional o "hydrated" (Decode.list hydrated_item);
        fails = Decode.optional o "fails" Decode.bool;
      })

type representation = {
  media_type : string;
  storage_uri : string option;
  checksum : string;
  rel : string;
}

let representation =
  Decode.obj (fun o : representation ->
      {
        media_type = Decode.required o "mediaType" Decode.string;
        storage_uri = Decode.optional o "storageUri" Decode.string;
        checksum = Decode.required o "checksum" Decode.string;
        rel = Decode.required o "rel" Decode.string;
      })

type preview_resource = {
  context : string;
  id : string;
  name : string;
  representations : representation list;
}

let preview_resource =
  Decode.obj (fun o : preview_resource ->
      {
        context = Decode.required o "@context" Decode.string;
        id = Decode.required o "@id" Decode.string;
        name = Decode.required o "name" Decode.string;
        representations =
          Decode.required o "representations" (Decode.list representation);
      })

type served_item = {
  text : string option;
  content_type : string option;
  fails : bool option;
}

let served_item =
  Decode.obj (fun o : served_item ->
      {
        text = Decode.optional o "text" Decode.string;
        content_type = Decode.optional o "contentType" Decode.string;
        fails = Decode.optional o "fails" Decode.bool;
      })

type preview = {
  resources : preview_resource list;
  served : (string * served_item) list;
  previews : string list;
}

let preview =
  Decode.obj (fun o : preview ->
      {
        resources = Decode.required o "resources" (Decode.list preview_resource);
        served = Decode.required o "served" (Decode.map served_item);
        previews = Decode.required o "previews" (Decode.list Decode.string);
      })

type case = { why : string; search : search option; preview : preview option }

let case =
  Decode.obj (fun o : case ->
      {
        why = Decode.required o "why" Decode.string;
        search = Decode.optional o "search" search;
        preview = Decode.optional o "preview" preview;
      })

type t = { comment : string; cases : case list }

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        cases = Decode.required o "cases" (Decode.list case);
      })
