(* specs/src/librarian/derive-views-cases.json *)

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

type target = { source : string }

let target =
  Decode.obj (fun o : target ->
      { source = Decode.required o "source" Decode.string })

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

type body_body = { type_ : string; value : string; purpose : string }

let body_body =
  Decode.obj (fun o : body_body ->
      {
        type_ = Decode.required o "type" Decode.string;
        value = Decode.required o "value" Decode.string;
        purpose = Decode.required o "purpose" Decode.string;
      })

type body = Array of body_item list | Object of body_body

let body =
 fun c ->
  match Decode.kind c with
  | Decode.Array -> (Array (Decode.list body_item c) : body)
  | Decode.Object -> (Object (body_body c) : body)
  | _ -> Decode.refuse c "expected an array or an object"

type annotation = {
  context : string;
  type_ : string;
  id : string;
  motivation : string;
  target : target;
  body : body option;
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
        body = Decode.optional o "body" body;
        created = Decode.required o "created" Decode.string;
      })

type node_annotation = {
  id : string;
  label : string;
  entity_types : string list option;
  annotation : annotation;
}

let node_annotation =
  Decode.obj (fun o : node_annotation ->
      Decode.required o "type" (Decode.literal "annotation");
      {
        id = Decode.required o "id" Decode.string;
        label = Decode.required o "label" Decode.string;
        entity_types =
          Decode.optional o "entityTypes" (Decode.list Decode.string);
        annotation = Decode.required o "annotation" annotation;
      })

type node = Resource of node_resource | Annotation of node_annotation

let node =
  Decode.variant "type"
    [
      ("resource", fun c -> (Resource (node_resource c) : node));
      ("annotation", fun c -> (Annotation (node_annotation c) : node));
    ]

type edge_mentions = { source : string; target : string; bidirectional : bool }

let edge_mentions =
  Decode.obj (fun o : edge_mentions ->
      Decode.required o "type" (Decode.literal "mentions");
      {
        source = Decode.required o "source" Decode.string;
        target = Decode.required o "target" Decode.string;
        bidirectional = Decode.required o "bidirectional" Decode.bool;
      })

type edge_link = { source : string; target : string }

let edge_link =
  Decode.obj (fun o : edge_link ->
      Decode.required o "type" (Decode.literal "link");
      {
        source = Decode.required o "source" Decode.string;
        target = Decode.required o "target" Decode.string;
      })

type edge_cites = {
  source : string;
  target : string;
  bidirectional : bool option;
}

let edge_cites =
  Decode.obj (fun o : edge_cites ->
      Decode.required o "type" (Decode.literal "cites");
      {
        source = Decode.required o "source" Decode.string;
        target = Decode.required o "target" Decode.string;
        bidirectional = Decode.optional o "bidirectional" Decode.bool;
      })

type edge_describes = { source : string; target : string; bidirectional : bool }

let edge_describes =
  Decode.obj (fun o : edge_describes ->
      Decode.required o "type" (Decode.literal "describes");
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

type edge =
  | Mentions of edge_mentions
  | Link of edge_link
  | Cites of edge_cites
  | Describes of edge_describes
  | Annotation_of of edge_annotation_of

let edge =
  Decode.variant "type"
    [
      ("mentions", fun c -> (Mentions (edge_mentions c) : edge));
      ("link", fun c -> (Link (edge_link c) : edge));
      ("cites", fun c -> (Cites (edge_cites c) : edge));
      ("describes", fun c -> (Describes (edge_describes c) : edge));
      ("annotation-of", fun c -> (Annotation_of (edge_annotation_of c) : edge));
    ]

type graph = { nodes : node list; edges : edge list }

let graph =
  Decode.obj (fun o : graph ->
      {
        nodes = Decode.required o "nodes" (Decode.list node);
        edges = Decode.required o "edges" (Decode.list edge);
      })

type connection = {
  resource_id : string;
  resource_name : string;
  entity_types : string list;
  bidirectional : bool;
}

let connection =
  Decode.obj (fun o : connection ->
      {
        resource_id = Decode.required o "resourceId" Decode.string;
        resource_name = Decode.required o "resourceName" Decode.string;
        entity_types =
          Decode.required o "entityTypes" (Decode.list Decode.string);
        bidirectional = Decode.required o "bidirectional" Decode.bool;
      })

type cited_by_item = { resource_id : string; resource_name : string }

let cited_by_item =
  Decode.obj (fun o : cited_by_item ->
      {
        resource_id = Decode.required o "resourceId" Decode.string;
        resource_name = Decode.required o "resourceName" Decode.string;
      })

type views = {
  connections : connection list;
  cited_by : cited_by_item list;
  cited_by_count : int;
  sibling_entity_types : string list;
}

let views =
  Decode.obj (fun o : views ->
      {
        connections = Decode.required o "connections" (Decode.list connection);
        cited_by = Decode.required o "citedBy" (Decode.list cited_by_item);
        cited_by_count = Decode.required o "citedByCount" Decode.int;
        sibling_entity_types =
          Decode.required o "siblingEntityTypes" (Decode.list Decode.string);
      })

type case = {
  why : string;
  graph : graph;
  resource : string;
  views : views;
  annotation : string option;
}

let case =
  Decode.obj (fun o : case ->
      {
        why = Decode.required o "why" Decode.string;
        graph = Decode.required o "graph" graph;
        resource = Decode.required o "resource" Decode.string;
        views = Decode.required o "views" views;
        annotation = Decode.optional o "annotation" Decode.string;
      })

type t = { comment : string; run_by : Case_table.run_by; cases : case list }

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        run_by = Decode.required o "runBy" Case_table.run_by;
        cases = Decode.required o "cases" (Decode.list case);
      })
