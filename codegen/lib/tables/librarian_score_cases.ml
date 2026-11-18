(* specs/src/librarian/score-cases.json *)

type target = { source : string }

let target =
  Decode.obj (fun o : target ->
      { source = Decode.required o "source" Decode.string })

type annotation = {
  context : string;
  type_ : string;
  id : string;
  motivation : string;
  target : target;
  created : string;
}

let annotation =
  Decode.obj (fun o : annotation ->
      {
        context = Decode.required o "@context" Decode.string;
        type_ = Decode.required o "type" Decode.string;
        id = Decode.required o "id" Decode.string;
        motivation = Decode.required o "motivation" Decode.string;
        target = Decode.required o "target" target;
        created = Decode.required o "created" Decode.string;
      })

type representation = { media_type : string; checksum : string; rel : string }

let representation =
  Decode.obj (fun o : representation ->
      {
        media_type = Decode.required o "mediaType" Decode.string;
        checksum = Decode.required o "checksum" Decode.string;
        rel = Decode.required o "rel" Decode.string;
      })

type source_resource = {
  context : string;
  id : string;
  name : string;
  representations : representation list;
  date_created : string;
}

let source_resource =
  Decode.obj (fun o : source_resource ->
      {
        context = Decode.required o "@context" Decode.string;
        id = Decode.required o "@id" Decode.string;
        name = Decode.required o "name" Decode.string;
        representations =
          Decode.required o "representations" (Decode.list representation);
        date_created = Decode.required o "dateCreated" Decode.string;
      })

type selected = { text : string; before : string option; after : string option }

let selected =
  Decode.obj (fun o : selected ->
      {
        text = Decode.required o "text" Decode.string;
        before = Decode.optional o "before" Decode.string;
        after = Decode.optional o "after" Decode.string;
      })

type focus_annotation = {
  annotation : annotation;
  source_resource : source_resource;
  selected : selected option;
  user_hint : string option;
}

let focus_annotation =
  Decode.obj (fun o : focus_annotation ->
      Decode.required o "kind" (Decode.literal "annotation");
      {
        annotation = Decode.required o "annotation" annotation;
        source_resource = Decode.required o "sourceResource" source_resource;
        selected = Decode.optional o "selected" selected;
        user_hint = Decode.optional o "userHint" Decode.string;
      })

type resource_representation = {
  media_type : string;
  checksum : string;
  rel : string;
}

let resource_representation =
  Decode.obj (fun o : resource_representation ->
      {
        media_type = Decode.required o "mediaType" Decode.string;
        checksum = Decode.required o "checksum" Decode.string;
        rel = Decode.required o "rel" Decode.string;
      })

type resource = {
  context : string;
  id : string;
  name : string;
  representations : resource_representation list;
  date_created : string;
}

let resource =
  Decode.obj (fun o : resource ->
      {
        context = Decode.required o "@context" Decode.string;
        id = Decode.required o "@id" Decode.string;
        name = Decode.required o "name" Decode.string;
        representations =
          Decode.required o "representations"
            (Decode.list resource_representation);
        date_created = Decode.required o "dateCreated" Decode.string;
      })

type focus_resource = { resource : resource }

let focus_resource =
  Decode.obj (fun o : focus_resource ->
      Decode.required o "kind" (Decode.literal "resource");
      { resource = Decode.required o "resource" resource })

type focus = Annotation of focus_annotation | Resource of focus_resource

let focus =
  Decode.variant "kind"
    [
      ("annotation", fun c -> (Annotation (focus_annotation c) : focus));
      ("resource", fun c -> (Resource (focus_resource c) : focus));
    ]

type node_resource = {
  id : string;
  label : string;
  entity_types : string list option;
}

let node_resource =
  Decode.obj (fun o : node_resource ->
      Decode.required o "type" (Decode.literal "resource");
      {
        id = Decode.required o "id" Decode.string;
        label = Decode.required o "label" Decode.string;
        entity_types =
          Decode.optional o "entityTypes" (Decode.list Decode.string);
      })

type node_annotation_annotation_target = { source : string }

let node_annotation_annotation_target =
  Decode.obj (fun o : node_annotation_annotation_target ->
      { source = Decode.required o "source" Decode.string })

type body = { type_ : string; source : string }

let body =
  Decode.obj (fun o : body ->
      {
        type_ = Decode.required o "type" Decode.string;
        source = Decode.required o "source" Decode.string;
      })

type node_annotation_annotation = {
  context : string;
  type_ : string;
  id : string;
  motivation : string;
  target : node_annotation_annotation_target;
  body : body;
  created : string;
}

let node_annotation_annotation =
  Decode.obj (fun o : node_annotation_annotation ->
      {
        context = Decode.required o "@context" Decode.string;
        type_ = Decode.required o "type" Decode.string;
        id = Decode.required o "id" Decode.string;
        motivation = Decode.required o "motivation" Decode.string;
        target = Decode.required o "target" node_annotation_annotation_target;
        body = Decode.required o "body" body;
        created = Decode.required o "created" Decode.string;
      })

type node_annotation = {
  id : string;
  label : string;
  annotation : node_annotation_annotation;
}

let node_annotation =
  Decode.obj (fun o : node_annotation ->
      Decode.required o "type" (Decode.literal "annotation");
      {
        id = Decode.required o "id" Decode.string;
        label = Decode.required o "label" Decode.string;
        annotation = Decode.required o "annotation" node_annotation_annotation;
      })

type node = Resource of node_resource | Annotation of node_annotation

let node =
  Decode.variant "type"
    [
      ("resource", fun c -> (Resource (node_resource c) : node));
      ("annotation", fun c -> (Annotation (node_annotation c) : node));
    ]

type edge_link = { source : string; target : string; bidirectional : bool }

let edge_link =
  Decode.obj (fun o : edge_link ->
      Decode.required o "type" (Decode.literal "link");
      {
        source = Decode.required o "source" Decode.string;
        target = Decode.required o "target" Decode.string;
        bidirectional = Decode.required o "bidirectional" Decode.bool;
      })

type edge_annotation_of = { source : string; target : string }

let edge_annotation_of =
  Decode.obj (fun o : edge_annotation_of ->
      Decode.required o "type" (Decode.literal "annotation-of");
      {
        source = Decode.required o "source" Decode.string;
        target = Decode.required o "target" Decode.string;
      })

type edge_cites = { source : string; target : string }

let edge_cites =
  Decode.obj (fun o : edge_cites ->
      Decode.required o "type" (Decode.literal "cites");
      {
        source = Decode.required o "source" Decode.string;
        target = Decode.required o "target" Decode.string;
      })

type edge =
  | Link of edge_link
  | Annotation_of of edge_annotation_of
  | Cites of edge_cites

let edge =
  Decode.variant "type"
    [
      ("link", fun c -> (Link (edge_link c) : edge));
      ("annotation-of", fun c -> (Annotation_of (edge_annotation_of c) : edge));
      ("cites", fun c -> (Cites (edge_cites c) : edge));
    ]

type graph = { nodes : node list; edges : edge list }

let graph =
  Decode.obj (fun o : graph ->
      {
        nodes = Decode.required o "nodes" (Decode.list node);
        edges = Decode.required o "edges" (Decode.list edge);
      })

type metadata = {
  entity_types : string list option;
  entity_type_frequencies : (string * int) list option;
}

let metadata =
  Decode.obj (fun o : metadata ->
      {
        entity_types =
          Decode.optional o "entityTypes" (Decode.list Decode.string);
        entity_type_frequencies =
          Decode.optional o "entityTypeFrequencies" (Decode.map Decode.int);
      })

type context = { focus : focus; graph : graph; metadata : metadata }

let context =
  Decode.obj (fun o : context ->
      {
        focus = Decode.required o "focus" focus;
        graph = Decode.required o "graph" graph;
        metadata = Decode.required o "metadata" metadata;
      })

type request = {
  resource_id : string;
  reference_id : string;
  use_semantic_scoring : bool option;
  context : context;
  limit : int option;
}

let request =
  Decode.obj (fun o : request ->
      {
        resource_id = Decode.required o "resourceId" Decode.string;
        reference_id = Decode.required o "referenceId" Decode.string;
        use_semantic_scoring =
          Decode.optional o "useSemanticScoring" Decode.bool;
        context = Decode.required o "context" context;
        limit = Decode.optional o "limit" Decode.int;
      })

type case_resource_representation = {
  media_type : string;
  checksum : string;
  rel : string;
}

let case_resource_representation =
  Decode.obj (fun o : case_resource_representation ->
      {
        media_type = Decode.required o "mediaType" Decode.string;
        checksum = Decode.required o "checksum" Decode.string;
        rel = Decode.required o "rel" Decode.string;
      })

type case_resource = {
  context : string;
  id : string;
  name : string;
  representations : case_resource_representation list;
  date_created : string option;
  entity_types : string list option;
}

let case_resource =
  Decode.obj (fun o : case_resource ->
      {
        context = Decode.required o "@context" Decode.string;
        id = Decode.required o "@id" Decode.string;
        name = Decode.required o "name" Decode.string;
        representations =
          Decode.required o "representations"
            (Decode.list case_resource_representation);
        date_created = Decode.optional o "dateCreated" Decode.string;
        entity_types =
          Decode.optional o "entityTypes" (Decode.list Decode.string);
      })

type by_name_by_name = { fails : string }

let by_name_by_name =
  Decode.obj (fun o : by_name_by_name ->
      { fails = Decode.required o "fails" Decode.string })

type by_name = Array of string list | Object of by_name_by_name

let by_name =
 fun c ->
  match Decode.kind c with
  | Decode.Array -> (Array (Decode.list Decode.string c) : by_name)
  | Decode.Object -> (Object (by_name_by_name c) : by_name)
  | _ -> Decode.refuse c "expected an array or an object"

type case_graph = {
  by_name : by_name option;
  by_id : (string * string) list option;
  by_entity_type : string list option;
}

let case_graph =
  Decode.obj (fun o : case_graph ->
      {
        by_name = Decode.optional o "byName" by_name;
        by_id = Decode.optional o "byId" (Decode.map Decode.string);
        by_entity_type =
          Decode.optional o "byEntityType" (Decode.list Decode.string);
      })

type hit = { resource_id : string; score : float }

let hit =
  Decode.obj (fun o : hit ->
      {
        resource_id = Decode.required o "resourceId" Decode.string;
        score = Decode.required o "score" Decode.number;
      })

type vectors = { hits : hit list option; fails : bool option }

let vectors =
  Decode.obj (fun o : vectors ->
      {
        hits = Decode.optional o "hits" (Decode.list hit);
        fails = Decode.optional o "fails" Decode.bool;
      })

type case_result = { id : string; score : float; match_reason : string }

let case_result =
  Decode.obj (fun o : case_result ->
      {
        id = Decode.required o "id" Decode.string;
        score = Decode.required o "score" Decode.number;
        match_reason = Decode.required o "matchReason" Decode.string;
      })

type answer = { candidate : int; score : float }

let answer =
  Decode.obj (fun o : answer ->
      {
        candidate = Decode.required o "candidate" Decode.int;
        score = Decode.required o "score" Decode.number;
      })

type model = {
  shown : string list;
  answers : answer list option;
  fails : bool option;
}

let model =
  Decode.obj (fun o : model ->
      {
        shown = Decode.required o "shown" (Decode.list Decode.string);
        answers = Decode.optional o "answers" (Decode.list answer);
        fails = Decode.optional o "fails" Decode.bool;
      })

type case = {
  why : string;
  now : string;
  request : request;
  resources : case_resource list;
  graph : case_graph;
  vectors : vectors option;
  term : string option;
  results : case_result list option;
  views : (string * string) list option;
  model : model option;
  failed : string option;
}

let case =
  Decode.obj (fun o : case ->
      {
        why = Decode.required o "why" Decode.string;
        now = Decode.required o "now" Decode.string;
        request = Decode.required o "request" request;
        resources = Decode.required o "resources" (Decode.list case_resource);
        graph = Decode.required o "graph" case_graph;
        vectors = Decode.optional o "vectors" vectors;
        term = Decode.optional o "term" Decode.string;
        results = Decode.optional o "results" (Decode.list case_result);
        views = Decode.optional o "views" (Decode.map Decode.string);
        model = Decode.optional o "model" model;
        failed = Decode.optional o "failed" Decode.string;
      })

type t = { comment : string; cases : case list }

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        cases = Decode.required o "cases" (Decode.list case);
      })
