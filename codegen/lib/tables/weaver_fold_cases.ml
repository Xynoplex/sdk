(* specs/src/weaver/fold-cases.json *)

type creator = { type_ : string; id : string }

let creator =
  Decode.obj (fun o : creator ->
      {
        type_ = Decode.required o "@type" Decode.string;
        id = Decode.required o "@id" Decode.string;
      })

type was_attributed_to_item_person = { id : string }

let was_attributed_to_item_person =
  Decode.obj (fun o : was_attributed_to_item_person ->
      Decode.required o "@type" (Decode.literal "Person");
      { id = Decode.required o "@id" Decode.string })

type was_attributed_to_item_software = {
  id : string;
  name : string;
  provider : string;
  model : string;
}

let was_attributed_to_item_software =
  Decode.obj (fun o : was_attributed_to_item_software ->
      Decode.required o "@type" (Decode.literal "Software");
      {
        id = Decode.required o "@id" Decode.string;
        name = Decode.required o "name" Decode.string;
        provider = Decode.required o "provider" Decode.string;
        model = Decode.required o "model" Decode.string;
      })

type was_attributed_to_item =
  | Person of was_attributed_to_item_person
  | Software of was_attributed_to_item_software

let was_attributed_to_item =
  Decode.variant "@type"
    [
      ( "Person",
        fun c ->
          (Person (was_attributed_to_item_person c) : was_attributed_to_item) );
      ( "Software",
        fun c ->
          (Software (was_attributed_to_item_software c)
            : was_attributed_to_item) );
    ]

type was_attributed_to_was_attributed_to = { type_ : string; id : string }

let was_attributed_to_was_attributed_to =
  Decode.obj (fun o : was_attributed_to_was_attributed_to ->
      {
        type_ = Decode.required o "@type" Decode.string;
        id = Decode.required o "@id" Decode.string;
      })

type was_attributed_to =
  | Array of was_attributed_to_item list
  | Object of was_attributed_to_was_attributed_to

let was_attributed_to =
 fun c ->
  match Decode.kind c with
  | Decode.Array ->
      (Array (Decode.list was_attributed_to_item c) : was_attributed_to)
  | Decode.Object ->
      (Object (was_attributed_to_was_attributed_to c) : was_attributed_to)
  | _ -> Decode.refuse c "expected an array or an object"

type selector = { type_ : string; exact : string }

let selector =
  Decode.obj (fun o : selector ->
      {
        type_ = Decode.required o "type" Decode.string;
        exact = Decode.required o "exact" Decode.string;
      })

type target = { source : string; selector : selector option }

let target =
  Decode.obj (fun o : target ->
      {
        source = Decode.required o "source" Decode.string;
        selector = Decode.optional o "selector" selector;
      })

type annotation_creator = { type_ : string; id : string }

let annotation_creator =
  Decode.obj (fun o : annotation_creator ->
      {
        type_ = Decode.required o "@type" Decode.string;
        id = Decode.required o "@id" Decode.string;
      })

type generator = {
  type_ : string;
  id : string;
  name : string;
  provider : string;
  model : string;
}

let generator =
  Decode.obj (fun o : generator ->
      {
        type_ = Decode.required o "@type" Decode.string;
        id = Decode.required o "@id" Decode.string;
        name = Decode.required o "name" Decode.string;
        provider = Decode.required o "provider" Decode.string;
        model = Decode.required o "model" Decode.string;
      })

type annotation_was_attributed_to_item_person = { id : string }

let annotation_was_attributed_to_item_person =
  Decode.obj (fun o : annotation_was_attributed_to_item_person ->
      Decode.required o "@type" (Decode.literal "Person");
      { id = Decode.required o "@id" Decode.string })

type annotation_was_attributed_to_item_software = {
  id : string;
  name : string;
  provider : string;
  model : string;
}

let annotation_was_attributed_to_item_software =
  Decode.obj (fun o : annotation_was_attributed_to_item_software ->
      Decode.required o "@type" (Decode.literal "Software");
      {
        id = Decode.required o "@id" Decode.string;
        name = Decode.required o "name" Decode.string;
        provider = Decode.required o "provider" Decode.string;
        model = Decode.required o "model" Decode.string;
      })

type annotation_was_attributed_to_item =
  | Person of annotation_was_attributed_to_item_person
  | Software of annotation_was_attributed_to_item_software

let annotation_was_attributed_to_item =
  Decode.variant "@type"
    [
      ( "Person",
        fun c ->
          (Person (annotation_was_attributed_to_item_person c)
            : annotation_was_attributed_to_item) );
      ( "Software",
        fun c ->
          (Software (annotation_was_attributed_to_item_software c)
            : annotation_was_attributed_to_item) );
    ]

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

type annotation = {
  context : string;
  type_ : string;
  id : string;
  motivation : string;
  target : target;
  creator : annotation_creator option;
  created : string;
  generator : generator option;
  was_attributed_to : annotation_was_attributed_to_item list option;
  body : body_item list option;
}

let annotation =
  Decode.obj (fun o : annotation ->
      {
        context = Decode.required o "@context" Decode.string;
        type_ = Decode.required o "type" Decode.string;
        id = Decode.required o "id" Decode.string;
        motivation = Decode.required o "motivation" Decode.string;
        target = Decode.required o "target" target;
        creator = Decode.optional o "creator" annotation_creator;
        created = Decode.required o "created" Decode.string;
        generator = Decode.optional o "generator" generator;
        was_attributed_to =
          Decode.optional o "wasAttributedTo"
            (Decode.list annotation_was_attributed_to_item);
        body = Decode.optional o "body" (Decode.list body_item);
      })

type item_specific_resource = { source : string; purpose : string }

let item_specific_resource =
  Decode.obj (fun o : item_specific_resource ->
      Decode.required o "type" (Decode.literal "SpecificResource");
      {
        source = Decode.required o "source" Decode.string;
        purpose = Decode.required o "purpose" Decode.string;
      })

type item_textual_body = { value : string; purpose : string }

let item_textual_body =
  Decode.obj (fun o : item_textual_body ->
      Decode.required o "type" (Decode.literal "TextualBody");
      {
        value = Decode.required o "value" Decode.string;
        purpose = Decode.required o "purpose" Decode.string;
      })

type item =
  | Specific_resource of item_specific_resource
  | Textual_body of item_textual_body

let item =
  Decode.variant "type"
    [
      ( "SpecificResource",
        fun c -> (Specific_resource (item_specific_resource c) : item) );
      ("TextualBody", fun c -> (Textual_body (item_textual_body c) : item));
    ]

type old_item = { type_ : string; source : string; purpose : string }

let old_item =
  Decode.obj (fun o : old_item ->
      {
        type_ = Decode.required o "type" Decode.string;
        source = Decode.required o "source" Decode.string;
        purpose = Decode.required o "purpose" Decode.string;
      })

type new_item = { type_ : string; source : string; purpose : string }

let new_item =
  Decode.obj (fun o : new_item ->
      {
        type_ = Decode.required o "type" Decode.string;
        source = Decode.required o "source" Decode.string;
        purpose = Decode.required o "purpose" Decode.string;
      })

type operation = {
  op : string;
  item : item option;
  old_item : old_item option;
  new_item : new_item option;
}

let operation =
  Decode.obj (fun o : operation ->
      {
        op = Decode.required o "op" Decode.string;
        item = Decode.optional o "item" item;
        old_item = Decode.optional o "oldItem" old_item;
        new_item = Decode.optional o "newItem" new_item;
      })

type payload = {
  name : string option;
  format : string option;
  content_checksum : string option;
  creator : creator option;
  was_attributed_to : was_attributed_to option;
  entity_types : string list option;
  storage_uri : string option;
  reason : string option;
  annotation : annotation option;
  annotation_id : string option;
  operations : operation list option;
  entity_type : string option;
}

let payload =
  Decode.obj (fun o : payload ->
      {
        name = Decode.optional o "name" Decode.string;
        format = Decode.optional o "format" Decode.string;
        content_checksum = Decode.optional o "contentChecksum" Decode.string;
        creator = Decode.optional o "creator" creator;
        was_attributed_to =
          Decode.optional o "wasAttributedTo" was_attributed_to;
        entity_types =
          Decode.optional o "entityTypes" (Decode.list Decode.string);
        storage_uri = Decode.optional o "storageUri" Decode.string;
        reason = Decode.optional o "reason" Decode.string;
        annotation = Decode.optional o "annotation" annotation;
        annotation_id = Decode.optional o "annotationId" Decode.string;
        operations = Decode.optional o "operations" (Decode.list operation);
        entity_type = Decode.optional o "entityType" Decode.string;
      })

type metadata = { sequence_number : int }

let metadata =
  Decode.obj (fun o : metadata ->
      { sequence_number = Decode.required o "sequenceNumber" Decode.int })

type history_item = {
  id : string;
  type_ : string;
  timestamp : string;
  user_id : string;
  resource_id : string;
  version : int;
  payload : payload;
  metadata : metadata;
}

let history_item =
  Decode.obj (fun o : history_item ->
      {
        id = Decode.required o "id" Decode.string;
        type_ = Decode.required o "type" Decode.string;
        timestamp = Decode.required o "timestamp" Decode.string;
        user_id = Decode.required o "userId" Decode.string;
        resource_id = Decode.required o "resourceId" Decode.string;
        version = Decode.required o "version" Decode.int;
        payload = Decode.required o "payload" payload;
        metadata = Decode.required o "metadata" metadata;
      })

type representation = {
  media_type : string;
  checksum : string;
  rel : string;
  storage_uri : string option;
}

let representation =
  Decode.obj (fun o : representation ->
      {
        media_type = Decode.required o "mediaType" Decode.string;
        checksum = Decode.required o "checksum" Decode.string;
        rel = Decode.required o "rel" Decode.string;
        storage_uri = Decode.optional o "storageUri" Decode.string;
      })

type resource_was_attributed_to_was_attributed_to_item_person = { id : string }

let resource_was_attributed_to_was_attributed_to_item_person =
  Decode.obj
    (fun o : resource_was_attributed_to_was_attributed_to_item_person ->
      Decode.required o "@type" (Decode.literal "Person");
      { id = Decode.required o "@id" Decode.string })

type resource_was_attributed_to_was_attributed_to_item_software = {
  id : string;
  name : string;
  provider : string;
  model : string;
}

let resource_was_attributed_to_was_attributed_to_item_software =
  Decode.obj
    (fun o : resource_was_attributed_to_was_attributed_to_item_software ->
      Decode.required o "@type" (Decode.literal "Software");
      {
        id = Decode.required o "@id" Decode.string;
        name = Decode.required o "name" Decode.string;
        provider = Decode.required o "provider" Decode.string;
        model = Decode.required o "model" Decode.string;
      })

type resource_was_attributed_to_was_attributed_to_item =
  | Person of resource_was_attributed_to_was_attributed_to_item_person
  | Software of resource_was_attributed_to_was_attributed_to_item_software

let resource_was_attributed_to_was_attributed_to_item =
  Decode.variant "@type"
    [
      ( "Person",
        fun c ->
          (Person (resource_was_attributed_to_was_attributed_to_item_person c)
            : resource_was_attributed_to_was_attributed_to_item) );
      ( "Software",
        fun c ->
          (Software
             (resource_was_attributed_to_was_attributed_to_item_software c)
            : resource_was_attributed_to_was_attributed_to_item) );
    ]

type resource_was_attributed_to_was_attributed_to = {
  type_ : string;
  id : string;
}

let resource_was_attributed_to_was_attributed_to =
  Decode.obj (fun o : resource_was_attributed_to_was_attributed_to ->
      {
        type_ = Decode.required o "@type" Decode.string;
        id = Decode.required o "@id" Decode.string;
      })

type resource_was_attributed_to =
  | Array of resource_was_attributed_to_was_attributed_to_item list
  | Object of resource_was_attributed_to_was_attributed_to

let resource_was_attributed_to =
 fun c ->
  match Decode.kind c with
  | Decode.Array ->
      (Array (Decode.list resource_was_attributed_to_was_attributed_to_item c)
        : resource_was_attributed_to)
  | Decode.Object ->
      (Object (resource_was_attributed_to_was_attributed_to c)
        : resource_was_attributed_to)
  | _ -> Decode.refuse c "expected an array or an object"

type resource = {
  context : string;
  id : string;
  name : string;
  entity_types : string list;
  representations : representation list;
  archived : bool;
  date_created : string;
  was_attributed_to : resource_was_attributed_to;
}

let resource =
  Decode.obj (fun o : resource ->
      {
        context = Decode.required o "@context" Decode.string;
        id = Decode.required o "@id" Decode.string;
        name = Decode.required o "name" Decode.string;
        entity_types =
          Decode.required o "entityTypes" (Decode.list Decode.string);
        representations =
          Decode.required o "representations" (Decode.list representation);
        archived = Decode.required o "archived" Decode.bool;
        date_created = Decode.required o "dateCreated" Decode.string;
        was_attributed_to =
          Decode.required o "wasAttributedTo" resource_was_attributed_to;
      })

type graph_annotation_target_selector = { type_ : string; exact : string }

let graph_annotation_target_selector =
  Decode.obj (fun o : graph_annotation_target_selector ->
      {
        type_ = Decode.required o "type" Decode.string;
        exact = Decode.required o "exact" Decode.string;
      })

type graph_annotation_target = {
  source : string;
  selector : graph_annotation_target_selector option;
}

let graph_annotation_target =
  Decode.obj (fun o : graph_annotation_target ->
      {
        source = Decode.required o "source" Decode.string;
        selector = Decode.optional o "selector" graph_annotation_target_selector;
      })

type graph_annotation_creator = { type_ : string; id : string }

let graph_annotation_creator =
  Decode.obj (fun o : graph_annotation_creator ->
      {
        type_ = Decode.required o "@type" Decode.string;
        id = Decode.required o "@id" Decode.string;
      })

type graph_annotation_generator = {
  type_ : string;
  id : string;
  name : string;
  provider : string;
  model : string;
}

let graph_annotation_generator =
  Decode.obj (fun o : graph_annotation_generator ->
      {
        type_ = Decode.required o "@type" Decode.string;
        id = Decode.required o "@id" Decode.string;
        name = Decode.required o "name" Decode.string;
        provider = Decode.required o "provider" Decode.string;
        model = Decode.required o "model" Decode.string;
      })

type graph_annotation_body_item_specific_resource = {
  source : string;
  purpose : string;
}

let graph_annotation_body_item_specific_resource =
  Decode.obj (fun o : graph_annotation_body_item_specific_resource ->
      Decode.required o "type" (Decode.literal "SpecificResource");
      {
        source = Decode.required o "source" Decode.string;
        purpose = Decode.required o "purpose" Decode.string;
      })

type graph_annotation_body_item_textual_body = {
  value : string;
  purpose : string;
}

let graph_annotation_body_item_textual_body =
  Decode.obj (fun o : graph_annotation_body_item_textual_body ->
      Decode.required o "type" (Decode.literal "TextualBody");
      {
        value = Decode.required o "value" Decode.string;
        purpose = Decode.required o "purpose" Decode.string;
      })

type graph_annotation_body_item =
  | Specific_resource of graph_annotation_body_item_specific_resource
  | Textual_body of graph_annotation_body_item_textual_body

let graph_annotation_body_item =
  Decode.variant "type"
    [
      ( "SpecificResource",
        fun c ->
          (Specific_resource (graph_annotation_body_item_specific_resource c)
            : graph_annotation_body_item) );
      ( "TextualBody",
        fun c ->
          (Textual_body (graph_annotation_body_item_textual_body c)
            : graph_annotation_body_item) );
    ]

type graph_annotation = {
  context : string;
  type_ : string;
  id : string;
  motivation : string;
  target : graph_annotation_target;
  creator : graph_annotation_creator;
  created : string;
  generator : graph_annotation_generator option;
  body : graph_annotation_body_item list option;
  modified : string option;
}

let graph_annotation =
  Decode.obj (fun o : graph_annotation ->
      {
        context = Decode.required o "@context" Decode.string;
        type_ = Decode.required o "type" Decode.string;
        id = Decode.required o "id" Decode.string;
        motivation = Decode.required o "motivation" Decode.string;
        target = Decode.required o "target" graph_annotation_target;
        creator = Decode.required o "creator" graph_annotation_creator;
        created = Decode.required o "created" Decode.string;
        generator = Decode.optional o "generator" graph_annotation_generator;
        body = Decode.optional o "body" (Decode.list graph_annotation_body_item);
        modified = Decode.optional o "modified" Decode.string;
      })

type graph = { resources : resource list; annotations : graph_annotation list }

let graph =
  Decode.obj (fun o : graph ->
      {
        resources = Decode.required o "resources" (Decode.list resource);
        annotations =
          Decode.required o "annotations" (Decode.list graph_annotation);
      })

type case = {
  why : string;
  history : history_item list;
  graph : graph;
  applied : (string * int) list;
  refused : int option;
}

let case =
  Decode.obj (fun o : case ->
      {
        why = Decode.required o "why" Decode.string;
        history = Decode.required o "history" (Decode.list history_item);
        graph = Decode.required o "graph" graph;
        applied = Decode.required o "applied" (Decode.map Decode.int);
        refused = Decode.optional o "refused" Decode.int;
      })

type t = { comment : string; cases : case list }

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        cases = Decode.required o "cases" (Decode.list case);
      })
