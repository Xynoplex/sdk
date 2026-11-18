(* specs/src/librarian/knowledge-graph-cases.json *)

type representation = { media_type : string }

let representation =
  Decode.obj (fun o : representation ->
      { media_type = Decode.required o "mediaType" Decode.string })

type resource_item = {
  context : string;
  id : string;
  name : string;
  entity_types : string list option;
  representations : representation list;
}

let resource_item =
  Decode.obj (fun o : resource_item ->
      {
        context = Decode.required o "@context" Decode.string;
        id = Decode.required o "@id" Decode.string;
        name = Decode.required o "name" Decode.string;
        entity_types =
          Decode.optional o "entityTypes" (Decode.list Decode.string);
        representations =
          Decode.required o "representations" (Decode.list representation);
      })

type resource_representation = { media_type : string }

let resource_representation =
  Decode.obj (fun o : resource_representation ->
      { media_type = Decode.required o "mediaType" Decode.string })

type resource = {
  context : string;
  id : string;
  name : string;
  entity_types : string list option;
  representations : resource_representation list;
}

let resource =
  Decode.obj (fun o : resource ->
      {
        context = Decode.required o "@context" Decode.string;
        id = Decode.required o "@id" Decode.string;
        name = Decode.required o "name" Decode.string;
        entity_types =
          Decode.optional o "entityTypes" (Decode.list Decode.string);
        representations =
          Decode.required o "representations"
            (Decode.list resource_representation);
      })

type connection = { resource : resource; bidirectional : bool }

let connection =
  Decode.obj (fun o : connection ->
      {
        resource = Decode.required o "resource" resource;
        bidirectional = Decode.required o "bidirectional" Decode.bool;
      })

type target_target = { source : string }

let target_target =
  Decode.obj (fun o : target_target ->
      { source = Decode.required o "source" Decode.string })

type target = String of string | Object of target_target

let target =
 fun c ->
  match Decode.kind c with
  | Decode.String -> (String (Decode.string c) : target)
  | Decode.Object -> (Object (target_target c) : target)
  | _ -> Decode.refuse c "expected a string or an object"

type body_item_textual_body = { value : string; purpose : string }

let body_item_textual_body =
  Decode.obj (fun o : body_item_textual_body ->
      Decode.required o "type" (Decode.literal "TextualBody");
      {
        value = Decode.required o "value" Decode.string;
        purpose = Decode.required o "purpose" Decode.string;
      })

type body_item_specific_resource = { source : string; purpose : string }

let body_item_specific_resource =
  Decode.obj (fun o : body_item_specific_resource ->
      Decode.required o "type" (Decode.literal "SpecificResource");
      {
        source = Decode.required o "source" Decode.string;
        purpose = Decode.required o "purpose" Decode.string;
      })

type body_item =
  | Textual_body of body_item_textual_body
  | Specific_resource of body_item_specific_resource

let body_item =
  Decode.variant "type"
    [
      ( "TextualBody",
        fun c -> (Textual_body (body_item_textual_body c) : body_item) );
      ( "SpecificResource",
        fun c -> (Specific_resource (body_item_specific_resource c) : body_item)
      );
    ]

type body_body = { type_ : string; source : string; purpose : string }

let body_body =
  Decode.obj (fun o : body_body ->
      {
        type_ = Decode.required o "type" Decode.string;
        source = Decode.required o "source" Decode.string;
        purpose = Decode.required o "purpose" Decode.string;
      })

type body = Array of body_item list | Object of body_body

let body =
 fun c ->
  match Decode.kind c with
  | Decode.Array -> (Array (Decode.list body_item c) : body)
  | Decode.Object -> (Object (body_body c) : body)
  | _ -> Decode.refuse c "expected an array or an object"

type referenced_by_item = {
  context : string;
  type_ : string;
  id : string;
  motivation : string;
  target : target;
  body : body option;
  created : string;
}

let referenced_by_item =
  Decode.obj (fun o : referenced_by_item ->
      {
        context = Decode.required o "@context" Decode.string;
        type_ = Decode.required o "type" Decode.string;
        id = Decode.required o "id" Decode.string;
        motivation = Decode.required o "motivation" Decode.string;
        target = Decode.required o "target" target;
        body = Decode.optional o "body" body;
        created = Decode.required o "created" Decode.string;
      })

type annotation_target_target = { source : string }

let annotation_target_target =
  Decode.obj (fun o : annotation_target_target ->
      { source = Decode.required o "source" Decode.string })

type annotation_target = String of string | Object of annotation_target_target

let annotation_target =
 fun c ->
  match Decode.kind c with
  | Decode.String -> (String (Decode.string c) : annotation_target)
  | Decode.Object -> (Object (annotation_target_target c) : annotation_target)
  | _ -> Decode.refuse c "expected a string or an object"

type annotation_body_body_item_textual_body = {
  value : string;
  purpose : string;
}

let annotation_body_body_item_textual_body =
  Decode.obj (fun o : annotation_body_body_item_textual_body ->
      Decode.required o "type" (Decode.literal "TextualBody");
      {
        value = Decode.required o "value" Decode.string;
        purpose = Decode.required o "purpose" Decode.string;
      })

type annotation_body_body_item_specific_resource = {
  source : string;
  purpose : string;
}

let annotation_body_body_item_specific_resource =
  Decode.obj (fun o : annotation_body_body_item_specific_resource ->
      Decode.required o "type" (Decode.literal "SpecificResource");
      {
        source = Decode.required o "source" Decode.string;
        purpose = Decode.required o "purpose" Decode.string;
      })

type annotation_body_body_item =
  | Textual_body of annotation_body_body_item_textual_body
  | Specific_resource of annotation_body_body_item_specific_resource

let annotation_body_body_item =
  Decode.variant "type"
    [
      ( "TextualBody",
        fun c ->
          (Textual_body (annotation_body_body_item_textual_body c)
            : annotation_body_body_item) );
      ( "SpecificResource",
        fun c ->
          (Specific_resource (annotation_body_body_item_specific_resource c)
            : annotation_body_body_item) );
    ]

type annotation_body_body_specific_resource = {
  source : string;
  purpose : string;
}

let annotation_body_body_specific_resource =
  Decode.obj (fun o : annotation_body_body_specific_resource ->
      Decode.required o "type" (Decode.literal "SpecificResource");
      {
        source = Decode.required o "source" Decode.string;
        purpose = Decode.required o "purpose" Decode.string;
      })

type annotation_body_body_textual_body = { value : string; purpose : string }

let annotation_body_body_textual_body =
  Decode.obj (fun o : annotation_body_body_textual_body ->
      Decode.required o "type" (Decode.literal "TextualBody");
      {
        value = Decode.required o "value" Decode.string;
        purpose = Decode.required o "purpose" Decode.string;
      })

type annotation_body_body =
  | Specific_resource of annotation_body_body_specific_resource
  | Textual_body of annotation_body_body_textual_body

let annotation_body_body =
  Decode.variant "type"
    [
      ( "SpecificResource",
        fun c ->
          (Specific_resource (annotation_body_body_specific_resource c)
            : annotation_body_body) );
      ( "TextualBody",
        fun c ->
          (Textual_body (annotation_body_body_textual_body c)
            : annotation_body_body) );
    ]

type annotation_body =
  | Array of annotation_body_body_item list
  | Object of annotation_body_body

let annotation_body =
 fun c ->
  match Decode.kind c with
  | Decode.Array ->
      (Array (Decode.list annotation_body_body_item c) : annotation_body)
  | Decode.Object -> (Object (annotation_body_body c) : annotation_body)
  | _ -> Decode.refuse c "expected an array or an object"

type annotation = {
  context : string;
  type_ : string;
  id : string;
  motivation : string;
  target : annotation_target;
  body : annotation_body option;
  created : string;
}

let annotation =
  Decode.obj (fun o : annotation ->
      {
        context = Decode.required o "@context" Decode.string;
        type_ = Decode.required o "type" Decode.string;
        id = Decode.required o "id" Decode.string;
        motivation = Decode.required o "motivation" Decode.string;
        target = Decode.required o "target" annotation_target;
        body = Decode.optional o "body" annotation_body;
        created = Decode.required o "created" Decode.string;
      })

type further_item_connection_resource = {
  context : string;
  id : string;
  name : string;
  entity_types : string list option;
  representations : Decode.nothing list;
}

let further_item_connection_resource =
  Decode.obj (fun o : further_item_connection_resource ->
      {
        context = Decode.required o "@context" Decode.string;
        id = Decode.required o "@id" Decode.string;
        name = Decode.required o "name" Decode.string;
        entity_types =
          Decode.optional o "entityTypes" (Decode.list Decode.string);
        representations =
          Decode.required o "representations" (Decode.list Decode.nothing);
      })

type further_item_connection = {
  resource : further_item_connection_resource;
  bidirectional : bool;
}

let further_item_connection =
  Decode.obj (fun o : further_item_connection ->
      {
        resource = Decode.required o "resource" further_item_connection_resource;
        bidirectional = Decode.required o "bidirectional" Decode.bool;
      })

type further_item_referenced_by_item_target = { source : string }

let further_item_referenced_by_item_target =
  Decode.obj (fun o : further_item_referenced_by_item_target ->
      { source = Decode.required o "source" Decode.string })

type further_item_referenced_by_item_body = {
  type_ : string;
  source : string;
  purpose : string;
}

let further_item_referenced_by_item_body =
  Decode.obj (fun o : further_item_referenced_by_item_body ->
      {
        type_ = Decode.required o "type" Decode.string;
        source = Decode.required o "source" Decode.string;
        purpose = Decode.required o "purpose" Decode.string;
      })

type further_item_referenced_by_item = {
  context : string;
  type_ : string;
  id : string;
  motivation : string;
  target : further_item_referenced_by_item_target;
  body : further_item_referenced_by_item_body;
  created : string;
}

let further_item_referenced_by_item =
  Decode.obj (fun o : further_item_referenced_by_item ->
      {
        context = Decode.required o "@context" Decode.string;
        type_ = Decode.required o "type" Decode.string;
        id = Decode.required o "id" Decode.string;
        motivation = Decode.required o "motivation" Decode.string;
        target =
          Decode.required o "target" further_item_referenced_by_item_target;
        body = Decode.required o "body" further_item_referenced_by_item_body;
        created = Decode.required o "created" Decode.string;
      })

type further_item = {
  connections : further_item_connection list;
  referenced_by : further_item_referenced_by_item list;
}

let further_item =
  Decode.obj (fun o : further_item ->
      {
        connections =
          Decode.required o "connections" (Decode.list further_item_connection);
        referenced_by =
          Decode.required o "referencedBy"
            (Decode.list further_item_referenced_by_item);
      })

type graph = {
  resource : resource_item option list;
  connections : connection list;
  referenced_by : referenced_by_item list;
  annotations : annotation list;
  further : (string * further_item) list option;
}

let graph =
  Decode.obj (fun o : graph ->
      {
        resource =
          Decode.required o "resource"
            (Decode.list (Decode.nullable resource_item));
        connections = Decode.required o "connections" (Decode.list connection);
        referenced_by =
          Decode.required o "referencedBy" (Decode.list referenced_by_item);
        annotations = Decode.required o "annotations" (Decode.list annotation);
        further = Decode.optional o "further" (Decode.map further_item);
      })

type view_resource_representation = { media_type : string }

let view_resource_representation =
  Decode.obj (fun o : view_resource_representation ->
      { media_type = Decode.required o "mediaType" Decode.string })

type view_resource = {
  context : string;
  id : string;
  name : string;
  entity_types : string list option;
  representations : view_resource_representation list;
}

let view_resource =
  Decode.obj (fun o : view_resource ->
      {
        context = Decode.required o "@context" Decode.string;
        id = Decode.required o "@id" Decode.string;
        name = Decode.required o "name" Decode.string;
        entity_types =
          Decode.optional o "entityTypes" (Decode.list Decode.string);
        representations =
          Decode.required o "representations"
            (Decode.list view_resource_representation);
      })

type annotations_annotation_target = { source : string }

let annotations_annotation_target =
  Decode.obj (fun o : annotations_annotation_target ->
      { source = Decode.required o "source" Decode.string })

type annotations_annotation_body = {
  type_ : string;
  source : string;
  purpose : string;
}

let annotations_annotation_body =
  Decode.obj (fun o : annotations_annotation_body ->
      {
        type_ = Decode.required o "type" Decode.string;
        source = Decode.required o "source" Decode.string;
        purpose = Decode.required o "purpose" Decode.string;
      })

type annotations_annotation = {
  context : string;
  type_ : string;
  id : string;
  motivation : string;
  target : annotations_annotation_target;
  body : annotations_annotation_body option;
  created : string;
}

let annotations_annotation =
  Decode.obj (fun o : annotations_annotation ->
      {
        context = Decode.required o "@context" Decode.string;
        type_ = Decode.required o "type" Decode.string;
        id = Decode.required o "id" Decode.string;
        motivation = Decode.required o "motivation" Decode.string;
        target = Decode.required o "target" annotations_annotation_target;
        body = Decode.optional o "body" annotations_annotation_body;
        created = Decode.required o "created" Decode.string;
      })

type annotations = {
  resource_id : string;
  annotations : annotations_annotation list;
  version : int;
  updated_at : string;
}

let annotations =
  Decode.obj (fun o : annotations ->
      {
        resource_id = Decode.required o "resourceId" Decode.string;
        annotations =
          Decode.required o "annotations" (Decode.list annotations_annotation);
        version = Decode.required o "version" Decode.int;
        updated_at = Decode.required o "updatedAt" Decode.string;
      })

type view = {
  resource : view_resource;
  annotations : annotations;
  last_sequence : int;
}

let view =
  Decode.obj (fun o : view ->
      {
        resource = Decode.required o "resource" view_resource;
        annotations = Decode.required o "annotations" annotations;
        last_sequence = Decode.required o "lastSequence" Decode.int;
      })

type node_resource = { id : string; label : string; entity_types : string list }

let node_resource =
  Decode.obj (fun o : node_resource ->
      Decode.required o "type" (Decode.literal "resource");
      {
        id = Decode.required o "id" Decode.string;
        label = Decode.required o "label" Decode.string;
        entity_types =
          Decode.required o "entityTypes" (Decode.list Decode.string);
      })

type node_annotation_annotation_target_target = { source : string }

let node_annotation_annotation_target_target =
  Decode.obj (fun o : node_annotation_annotation_target_target ->
      { source = Decode.required o "source" Decode.string })

type node_annotation_annotation_target =
  | String of string
  | Object of node_annotation_annotation_target_target

let node_annotation_annotation_target =
 fun c ->
  match Decode.kind c with
  | Decode.String ->
      (String (Decode.string c) : node_annotation_annotation_target)
  | Decode.Object ->
      (Object (node_annotation_annotation_target_target c)
        : node_annotation_annotation_target)
  | _ -> Decode.refuse c "expected a string or an object"

type node_annotation_annotation_body_body_item_textual_body = {
  value : string;
  purpose : string;
}

let node_annotation_annotation_body_body_item_textual_body =
  Decode.obj (fun o : node_annotation_annotation_body_body_item_textual_body ->
      Decode.required o "type" (Decode.literal "TextualBody");
      {
        value = Decode.required o "value" Decode.string;
        purpose = Decode.required o "purpose" Decode.string;
      })

type node_annotation_annotation_body_body_item_specific_resource = {
  source : string;
  purpose : string;
}

let node_annotation_annotation_body_body_item_specific_resource =
  Decode.obj
    (fun o : node_annotation_annotation_body_body_item_specific_resource ->
      Decode.required o "type" (Decode.literal "SpecificResource");
      {
        source = Decode.required o "source" Decode.string;
        purpose = Decode.required o "purpose" Decode.string;
      })

type node_annotation_annotation_body_body_item =
  | Textual_body of node_annotation_annotation_body_body_item_textual_body
  | Specific_resource of
      node_annotation_annotation_body_body_item_specific_resource

let node_annotation_annotation_body_body_item =
  Decode.variant "type"
    [
      ( "TextualBody",
        fun c ->
          (Textual_body
             (node_annotation_annotation_body_body_item_textual_body c)
            : node_annotation_annotation_body_body_item) );
      ( "SpecificResource",
        fun c ->
          (Specific_resource
             (node_annotation_annotation_body_body_item_specific_resource c)
            : node_annotation_annotation_body_body_item) );
    ]

type node_annotation_annotation_body_body_specific_resource = {
  source : string;
  purpose : string;
}

let node_annotation_annotation_body_body_specific_resource =
  Decode.obj (fun o : node_annotation_annotation_body_body_specific_resource ->
      Decode.required o "type" (Decode.literal "SpecificResource");
      {
        source = Decode.required o "source" Decode.string;
        purpose = Decode.required o "purpose" Decode.string;
      })

type node_annotation_annotation_body_body_textual_body = {
  value : string;
  purpose : string;
}

let node_annotation_annotation_body_body_textual_body =
  Decode.obj (fun o : node_annotation_annotation_body_body_textual_body ->
      Decode.required o "type" (Decode.literal "TextualBody");
      {
        value = Decode.required o "value" Decode.string;
        purpose = Decode.required o "purpose" Decode.string;
      })

type node_annotation_annotation_body_body =
  | Specific_resource of node_annotation_annotation_body_body_specific_resource
  | Textual_body of node_annotation_annotation_body_body_textual_body

let node_annotation_annotation_body_body =
  Decode.variant "type"
    [
      ( "SpecificResource",
        fun c ->
          (Specific_resource
             (node_annotation_annotation_body_body_specific_resource c)
            : node_annotation_annotation_body_body) );
      ( "TextualBody",
        fun c ->
          (Textual_body (node_annotation_annotation_body_body_textual_body c)
            : node_annotation_annotation_body_body) );
    ]

type node_annotation_annotation_body =
  | Array of node_annotation_annotation_body_body_item list
  | Object of node_annotation_annotation_body_body

let node_annotation_annotation_body =
 fun c ->
  match Decode.kind c with
  | Decode.Array ->
      (Array (Decode.list node_annotation_annotation_body_body_item c)
        : node_annotation_annotation_body)
  | Decode.Object ->
      (Object (node_annotation_annotation_body_body c)
        : node_annotation_annotation_body)
  | _ -> Decode.refuse c "expected an array or an object"

type node_annotation_annotation = {
  context : string;
  type_ : string;
  id : string;
  motivation : string;
  target : node_annotation_annotation_target;
  body : node_annotation_annotation_body option;
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
        body = Decode.optional o "body" node_annotation_annotation_body;
        created = Decode.required o "created" Decode.string;
      })

type node_annotation = {
  id : string;
  label : string;
  entity_types : string list;
  annotation : node_annotation_annotation;
}

let node_annotation =
  Decode.obj (fun o : node_annotation ->
      Decode.required o "type" (Decode.literal "annotation");
      {
        id = Decode.required o "id" Decode.string;
        label = Decode.required o "label" Decode.string;
        entity_types =
          Decode.required o "entityTypes" (Decode.list Decode.string);
        annotation = Decode.required o "annotation" node_annotation_annotation;
      })

type node = Resource of node_resource | Annotation of node_annotation

let node =
  Decode.variant "type"
    [
      ("resource", fun c -> (Resource (node_resource c) : node));
      ("annotation", fun c -> (Annotation (node_annotation c) : node));
    ]

type edge_link = {
  source : string;
  target : string;
  bidirectional : bool option;
}

let edge_link =
  Decode.obj (fun o : edge_link ->
      Decode.required o "type" (Decode.literal "link");
      {
        source = Decode.required o "source" Decode.string;
        target = Decode.required o "target" Decode.string;
        bidirectional = Decode.optional o "bidirectional" Decode.bool;
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

type knowledge_graph = { nodes : node list; edges : edge list }

let knowledge_graph =
  Decode.obj (fun o : knowledge_graph ->
      {
        nodes = Decode.required o "nodes" (Decode.list node);
        edges = Decode.required o "edges" (Decode.list edge);
      })

type case = {
  why : string;
  resource : string;
  graph : graph;
  views : (string * view) list;
  applied : bool;
  knowledge_graph : knowledge_graph option;
  waited : int;
  fails : string option;
  depth : int option;
}

let case =
  Decode.obj (fun o : case ->
      {
        why = Decode.required o "why" Decode.string;
        resource = Decode.required o "resource" Decode.string;
        graph = Decode.required o "graph" graph;
        views = Decode.required o "views" (Decode.map view);
        applied = Decode.required o "applied" Decode.bool;
        knowledge_graph = Decode.optional o "knowledgeGraph" knowledge_graph;
        waited = Decode.required o "waited" Decode.int;
        fails = Decode.optional o "fails" Decode.string;
        depth = Decode.optional o "depth" Decode.int;
      })

type t = { comment : string; cases : case list }

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        cases = Decode.required o "cases" (Decode.list case);
      })
