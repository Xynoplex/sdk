(* specs/src/worker/citation-cases.json *)

type citation = {
  resource_id : string;
  start : int;
  end_ : int;
  exact : string;
  annotation_id : string option;
}

let citation =
  Decode.obj (fun o : citation ->
      {
        resource_id = Decode.required o "resourceId" Decode.string;
        start = Decode.required o "start" Decode.int;
        end_ = Decode.required o "end" Decode.int;
        exact = Decode.required o "exact" Decode.string;
        annotation_id = Decode.optional o "annotationId" Decode.string;
      })

type resolved = { text : string; citations : citation list }

let resolved =
  Decode.obj (fun o : resolved ->
      {
        text = Decode.required o "text" Decode.string;
        citations = Decode.required o "citations" (Decode.list citation);
      })

type case = {
  why : string;
  text : string;
  format : string;
  context_resource_ids : string list;
  context_annotation_ids : string list;
  context_names : (string * string) list;
  resolved : resolved;
  dropped : string list;
}

let case =
  Decode.obj (fun o : case ->
      {
        why = Decode.required o "why" Decode.string;
        text = Decode.required o "text" Decode.string;
        format = Decode.required o "format" Decode.string;
        context_resource_ids =
          Decode.required o "contextResourceIds" (Decode.list Decode.string);
        context_annotation_ids =
          Decode.required o "contextAnnotationIds" (Decode.list Decode.string);
        context_names =
          Decode.required o "contextNames" (Decode.map Decode.string);
        resolved = Decode.required o "resolved" resolved;
        dropped = Decode.required o "dropped" (Decode.list Decode.string);
      })

type resource = {
  context : string;
  id : string;
  name : string;
  representations : Decode.nothing list;
}

let resource =
  Decode.obj (fun o : resource ->
      {
        context = Decode.required o "@context" Decode.string;
        id = Decode.required o "@id" Decode.string;
        name = Decode.required o "name" Decode.string;
        representations =
          Decode.required o "representations" (Decode.list Decode.nothing);
      })

type content = { main : string; related : (string * string) list }

let content =
  Decode.obj (fun o : content ->
      {
        main = Decode.required o "main" Decode.string;
        related = Decode.required o "related" (Decode.map Decode.string);
      })

type focus_resource = { resource : resource; content : content option }

let focus_resource =
  Decode.obj (fun o : focus_resource ->
      Decode.required o "kind" (Decode.literal "resource");
      {
        resource = Decode.required o "resource" resource;
        content = Decode.optional o "content" content;
      })

type target = { source : string }

let target =
  Decode.obj (fun o : target ->
      { source = Decode.required o "source" Decode.string })

type annotation = {
  context : string;
  type_ : string;
  id : string;
  motivation : string;
  created : string;
  target : target;
}

let annotation =
  Decode.obj (fun o : annotation ->
      {
        context = Decode.required o "@context" Decode.string;
        type_ = Decode.required o "type" Decode.string;
        id = Decode.required o "id" Decode.string;
        motivation = Decode.required o "motivation" Decode.string;
        created = Decode.required o "created" Decode.string;
        target = Decode.required o "target" target;
      })

type source_resource = {
  context : string;
  id : string;
  name : string;
  representations : Decode.nothing list;
}

let source_resource =
  Decode.obj (fun o : source_resource ->
      {
        context = Decode.required o "@context" Decode.string;
        id = Decode.required o "@id" Decode.string;
        name = Decode.required o "name" Decode.string;
        representations =
          Decode.required o "representations" (Decode.list Decode.nothing);
      })

type focus_annotation = {
  annotation : annotation;
  source_resource : source_resource;
}

let focus_annotation =
  Decode.obj (fun o : focus_annotation ->
      Decode.required o "kind" (Decode.literal "annotation");
      {
        annotation = Decode.required o "annotation" annotation;
        source_resource = Decode.required o "sourceResource" source_resource;
      })

type focus = Resource of focus_resource | Annotation of focus_annotation

let focus =
  Decode.variant "kind"
    [
      ("resource", fun c -> (Resource (focus_resource c) : focus));
      ("annotation", fun c -> (Annotation (focus_annotation c) : focus));
    ]

type node_resource = { id : string; label : string }

let node_resource =
  Decode.obj (fun o : node_resource ->
      Decode.required o "type" (Decode.literal "resource");
      {
        id = Decode.required o "id" Decode.string;
        label = Decode.required o "label" Decode.string;
      })

type node_annotation_annotation_target = { source : string }

let node_annotation_annotation_target =
  Decode.obj (fun o : node_annotation_annotation_target ->
      { source = Decode.required o "source" Decode.string })

type node_annotation_annotation = {
  context : string;
  type_ : string;
  id : string;
  motivation : string;
  created : string;
  target : node_annotation_annotation_target;
}

let node_annotation_annotation =
  Decode.obj (fun o : node_annotation_annotation ->
      {
        context = Decode.required o "@context" Decode.string;
        type_ = Decode.required o "type" Decode.string;
        id = Decode.required o "id" Decode.string;
        motivation = Decode.required o "motivation" Decode.string;
        created = Decode.required o "created" Decode.string;
        target = Decode.required o "target" node_annotation_annotation_target;
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

type graph = { nodes : node list; edges : Decode.nothing list }

let graph =
  Decode.obj (fun o : graph ->
      {
        nodes = Decode.required o "nodes" (Decode.list node);
        edges = Decode.required o "edges" (Decode.list Decode.nothing);
      })

type similar_item = {
  text : string;
  resource_id : string;
  resource_name : string;
  score : float;
  annotation_id : string option;
}

let similar_item =
  Decode.obj (fun o : similar_item ->
      {
        text = Decode.required o "text" Decode.string;
        resource_id = Decode.required o "resourceId" Decode.string;
        resource_name = Decode.required o "resourceName" Decode.string;
        score = Decode.required o "score" Decode.number;
        annotation_id = Decode.optional o "annotationId" Decode.string;
      })

type semantic_context = { similar : similar_item list }

let semantic_context =
  Decode.obj (fun o : semantic_context ->
      { similar = Decode.required o "similar" (Decode.list similar_item) })

type context_context = {
  focus : focus;
  graph : graph;
  semantic_context : semantic_context option;
  metadata : unit;
}

let context_context =
  Decode.obj (fun o : context_context ->
      {
        focus = Decode.required o "focus" focus;
        graph = Decode.required o "graph" graph;
        semantic_context = Decode.optional o "semanticContext" semantic_context;
        metadata = Decode.required o "metadata" (Decode.obj (fun _ -> ()));
      })

type context = {
  why : string;
  context : context_context option;
  resource_ids : string list;
  annotation_ids : string list;
  names : (string * string) list;
}

let context =
  Decode.obj (fun o : context ->
      {
        why = Decode.required o "why" Decode.string;
        context = Decode.required o "context" (Decode.nullable context_context);
        resource_ids =
          Decode.required o "resourceIds" (Decode.list Decode.string);
        annotation_ids =
          Decode.required o "annotationIds" (Decode.list Decode.string);
        names = Decode.required o "names" (Decode.map Decode.string);
      })

type t = {
  comment : string;
  run_by : Case_table.run_by;
  cases : case list;
  contexts : context list;
}

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        run_by = Decode.required o "runBy" Case_table.run_by;
        cases = Decode.required o "cases" (Decode.list case);
        contexts = Decode.required o "contexts" (Decode.list context);
      })
