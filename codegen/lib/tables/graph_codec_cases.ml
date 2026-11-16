(* specs/src/graph/codec-cases.json *)

type selector_item_text_position_selector = { start : int; end_ : int }

let selector_item_text_position_selector =
  Decode.obj (fun o : selector_item_text_position_selector ->
      Decode.required o "type" (Decode.literal "TextPositionSelector");
      {
        start = Decode.required o "start" Decode.int;
        end_ = Decode.required o "end" Decode.int;
      })

type selector_item_text_quote_selector = { exact : string }

let selector_item_text_quote_selector =
  Decode.obj (fun o : selector_item_text_quote_selector ->
      Decode.required o "type" (Decode.literal "TextQuoteSelector");
      { exact = Decode.required o "exact" Decode.string })

type selector_item =
  | Text_position_selector of selector_item_text_position_selector
  | Text_quote_selector of selector_item_text_quote_selector

let selector_item =
  Decode.variant "type"
    [
      ( "TextPositionSelector",
        fun c ->
          (Text_position_selector (selector_item_text_position_selector c)
            : selector_item) );
      ( "TextQuoteSelector",
        fun c ->
          (Text_quote_selector (selector_item_text_quote_selector c)
            : selector_item) );
    ]

type selector_selector = {
  type_ : string;
  exact : string;
  prefix : string;
  suffix : string;
}

let selector_selector =
  Decode.obj (fun o : selector_selector ->
      {
        type_ = Decode.required o "type" Decode.string;
        exact = Decode.required o "exact" Decode.string;
        prefix = Decode.required o "prefix" Decode.string;
        suffix = Decode.required o "suffix" Decode.string;
      })

type selector = Array of selector_item list | Object of selector_selector

let selector =
 fun c ->
  match Decode.kind c with
  | Decode.Array -> (Array (Decode.list selector_item c) : selector)
  | Decode.Object -> (Object (selector_selector c) : selector)
  | _ -> Decode.refuse c "expected an array or an object"

type target = { source : string; selector : selector option }

let target =
  Decode.obj (fun o : target ->
      {
        source = Decode.required o "source" Decode.string;
        selector = Decode.optional o "selector" selector;
      })

type creator = { type_ : string; id : string; name : string }

let creator =
  Decode.obj (fun o : creator ->
      {
        type_ = Decode.required o "@type" Decode.string;
        id = Decode.required o "@id" Decode.string;
        name = Decode.required o "name" Decode.string;
      })

type body_item_specific_resource = { source : string; purpose : string }

let body_item_specific_resource =
  Decode.obj (fun o : body_item_specific_resource ->
      Decode.required o "type" (Decode.literal "SpecificResource");
      {
        source = Decode.required o "source" Decode.string;
        purpose = Decode.required o "purpose" Decode.string;
      })

type body_item_textual_body = { value : string; purpose : string }

let body_item_textual_body =
  Decode.obj (fun o : body_item_textual_body ->
      Decode.required o "type" (Decode.literal "TextualBody");
      {
        value = Decode.required o "value" Decode.string;
        purpose = Decode.required o "purpose" Decode.string;
      })

type body_item =
  | Specific_resource of body_item_specific_resource
  | Textual_body of body_item_textual_body

let body_item =
  Decode.variant "type"
    [
      ( "SpecificResource",
        fun c -> (Specific_resource (body_item_specific_resource c) : body_item)
      );
      ( "TextualBody",
        fun c -> (Textual_body (body_item_textual_body c) : body_item) );
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

type was_attributed_to_item = { type_ : string; id : string; name : string }

let was_attributed_to_item =
  Decode.obj (fun o : was_attributed_to_item ->
      {
        type_ = Decode.required o "@type" Decode.string;
        id = Decode.required o "@id" Decode.string;
        name = Decode.required o "name" Decode.string;
      })

type generator = { type_ : string; id : string; name : string }

let generator =
  Decode.obj (fun o : generator ->
      {
        type_ = Decode.required o "@type" Decode.string;
        id = Decode.required o "@id" Decode.string;
        name = Decode.required o "name" Decode.string;
      })

type annotation = {
  context : string;
  type_ : string;
  id : string;
  motivation : string;
  target : target;
  creator : creator;
  created : string;
  body : body option;
  was_attributed_to : was_attributed_to_item list option;
  modified : string option;
  generator : generator option;
}

let annotation =
  Decode.obj (fun o : annotation ->
      {
        context = Decode.required o "@context" Decode.string;
        type_ = Decode.required o "type" Decode.string;
        id = Decode.required o "id" Decode.string;
        motivation = Decode.required o "motivation" Decode.string;
        target = Decode.required o "target" target;
        creator = Decode.required o "creator" creator;
        created = Decode.required o "created" Decode.string;
        body = Decode.optional o "body" body;
        was_attributed_to =
          Decode.optional o "wasAttributedTo"
            (Decode.list was_attributed_to_item);
        modified = Decode.optional o "modified" Decode.string;
        generator = Decode.optional o "generator" generator;
      })

type properties_textual_body = {
  id : string;
  resource_id : string;
  motivation : string;
  created : string;
  exact : string;
}

let properties_textual_body =
  Decode.obj (fun o : properties_textual_body ->
      Decode.required o "type" (Decode.literal "TextualBody");
      {
        id = Decode.required o "id" Decode.string;
        resource_id = Decode.required o "resourceId" Decode.string;
        motivation = Decode.required o "motivation" Decode.string;
        created = Decode.required o "created" Decode.string;
        exact = Decode.required o "exact" Decode.string;
      })

type properties_specific_resource = {
  id : string;
  resource_id : string;
  motivation : string;
  created : string;
  source : string option;
  modified : string option;
}

let properties_specific_resource =
  Decode.obj (fun o : properties_specific_resource ->
      Decode.required o "type" (Decode.literal "SpecificResource");
      {
        id = Decode.required o "id" Decode.string;
        resource_id = Decode.required o "resourceId" Decode.string;
        motivation = Decode.required o "motivation" Decode.string;
        created = Decode.required o "created" Decode.string;
        source = Decode.optional o "source" Decode.string;
        modified = Decode.optional o "modified" Decode.string;
      })

type properties =
  | Textual_body of properties_textual_body
  | Specific_resource of properties_specific_resource

let properties =
  Decode.variant "type"
    [
      ( "TextualBody",
        fun c -> (Textual_body (properties_textual_body c) : properties) );
      ( "SpecificResource",
        fun c ->
          (Specific_resource (properties_specific_resource c) : properties) );
    ]

type json_creator = { type_ : string; id : string }

let json_creator =
  Decode.obj (fun o : json_creator ->
      {
        type_ = Decode.required o "@type" Decode.string;
        id = Decode.required o "@id" Decode.string;
      })

type json_selector_selector_item_text_position_selector = {
  start : int;
  end_ : int;
}

let json_selector_selector_item_text_position_selector =
  Decode.obj (fun o : json_selector_selector_item_text_position_selector ->
      Decode.required o "type" (Decode.literal "TextPositionSelector");
      {
        start = Decode.required o "start" Decode.int;
        end_ = Decode.required o "end" Decode.int;
      })

type json_selector_selector_item_text_quote_selector = { exact : string }

let json_selector_selector_item_text_quote_selector =
  Decode.obj (fun o : json_selector_selector_item_text_quote_selector ->
      Decode.required o "type" (Decode.literal "TextQuoteSelector");
      { exact = Decode.required o "exact" Decode.string })

type json_selector_selector_item =
  | Text_position_selector of json_selector_selector_item_text_position_selector
  | Text_quote_selector of json_selector_selector_item_text_quote_selector

let json_selector_selector_item =
  Decode.variant "type"
    [
      ( "TextPositionSelector",
        fun c ->
          (Text_position_selector
             (json_selector_selector_item_text_position_selector c)
            : json_selector_selector_item) );
      ( "TextQuoteSelector",
        fun c ->
          (Text_quote_selector
             (json_selector_selector_item_text_quote_selector c)
            : json_selector_selector_item) );
    ]

type json_selector_selector = {
  type_ : string;
  exact : string;
  prefix : string;
  suffix : string;
}

let json_selector_selector =
  Decode.obj (fun o : json_selector_selector ->
      {
        type_ = Decode.required o "type" Decode.string;
        exact = Decode.required o "exact" Decode.string;
        prefix = Decode.required o "prefix" Decode.string;
        suffix = Decode.required o "suffix" Decode.string;
      })

type json_selector =
  | Array of json_selector_selector_item list
  | Object of json_selector_selector

let json_selector =
 fun c ->
  match Decode.kind c with
  | Decode.Array ->
      (Array (Decode.list json_selector_selector_item c) : json_selector)
  | Decode.Object -> (Object (json_selector_selector c) : json_selector)
  | _ -> Decode.refuse c "expected an array or an object"

type json_generator = { type_ : string; id : string; name : string }

let json_generator =
  Decode.obj (fun o : json_generator ->
      {
        type_ = Decode.required o "@type" Decode.string;
        id = Decode.required o "@id" Decode.string;
        name = Decode.required o "name" Decode.string;
      })

type json = {
  creator : json_creator;
  selector : json_selector option;
  generator : json_generator option;
}

let json =
  Decode.obj (fun o : json ->
      {
        creator = Decode.required o "creator" json_creator;
        selector = Decode.optional o "selector" json_selector;
        generator = Decode.optional o "generator" json_generator;
      })

type holds_target_selector_selector_item_text_position_selector = {
  start : int;
  end_ : int;
}

let holds_target_selector_selector_item_text_position_selector =
  Decode.obj
    (fun o : holds_target_selector_selector_item_text_position_selector ->
      Decode.required o "type" (Decode.literal "TextPositionSelector");
      {
        start = Decode.required o "start" Decode.int;
        end_ = Decode.required o "end" Decode.int;
      })

type holds_target_selector_selector_item_text_quote_selector = {
  exact : string;
}

let holds_target_selector_selector_item_text_quote_selector =
  Decode.obj (fun o : holds_target_selector_selector_item_text_quote_selector ->
      Decode.required o "type" (Decode.literal "TextQuoteSelector");
      { exact = Decode.required o "exact" Decode.string })

type holds_target_selector_selector_item =
  | Text_position_selector of
      holds_target_selector_selector_item_text_position_selector
  | Text_quote_selector of
      holds_target_selector_selector_item_text_quote_selector

let holds_target_selector_selector_item =
  Decode.variant "type"
    [
      ( "TextPositionSelector",
        fun c ->
          (Text_position_selector
             (holds_target_selector_selector_item_text_position_selector c)
            : holds_target_selector_selector_item) );
      ( "TextQuoteSelector",
        fun c ->
          (Text_quote_selector
             (holds_target_selector_selector_item_text_quote_selector c)
            : holds_target_selector_selector_item) );
    ]

type holds_target_selector_selector = {
  type_ : string;
  exact : string;
  prefix : string;
  suffix : string;
}

let holds_target_selector_selector =
  Decode.obj (fun o : holds_target_selector_selector ->
      {
        type_ = Decode.required o "type" Decode.string;
        exact = Decode.required o "exact" Decode.string;
        prefix = Decode.required o "prefix" Decode.string;
        suffix = Decode.required o "suffix" Decode.string;
      })

type holds_target_selector =
  | Array of holds_target_selector_selector_item list
  | Object of holds_target_selector_selector

let holds_target_selector =
 fun c ->
  match Decode.kind c with
  | Decode.Array ->
      (Array (Decode.list holds_target_selector_selector_item c)
        : holds_target_selector)
  | Decode.Object ->
      (Object (holds_target_selector_selector c) : holds_target_selector)
  | _ -> Decode.refuse c "expected an array or an object"

type holds_target = { source : string; selector : holds_target_selector option }

let holds_target =
  Decode.obj (fun o : holds_target ->
      {
        source = Decode.required o "source" Decode.string;
        selector = Decode.optional o "selector" holds_target_selector;
      })

type holds_creator = { type_ : string; id : string }

let holds_creator =
  Decode.obj (fun o : holds_creator ->
      {
        type_ = Decode.required o "@type" Decode.string;
        id = Decode.required o "@id" Decode.string;
      })

type holds_body_item_specific_resource = { source : string; purpose : string }

let holds_body_item_specific_resource =
  Decode.obj (fun o : holds_body_item_specific_resource ->
      Decode.required o "type" (Decode.literal "SpecificResource");
      {
        source = Decode.required o "source" Decode.string;
        purpose = Decode.required o "purpose" Decode.string;
      })

type holds_body_item_textual_body = { value : string; purpose : string }

let holds_body_item_textual_body =
  Decode.obj (fun o : holds_body_item_textual_body ->
      Decode.required o "type" (Decode.literal "TextualBody");
      {
        value = Decode.required o "value" Decode.string;
        purpose = Decode.required o "purpose" Decode.string;
      })

type holds_body_item =
  | Specific_resource of holds_body_item_specific_resource
  | Textual_body of holds_body_item_textual_body

let holds_body_item =
  Decode.variant "type"
    [
      ( "SpecificResource",
        fun c ->
          (Specific_resource (holds_body_item_specific_resource c)
            : holds_body_item) );
      ( "TextualBody",
        fun c ->
          (Textual_body (holds_body_item_textual_body c) : holds_body_item) );
    ]

type holds_generator = { type_ : string; id : string; name : string }

let holds_generator =
  Decode.obj (fun o : holds_generator ->
      {
        type_ = Decode.required o "@type" Decode.string;
        id = Decode.required o "@id" Decode.string;
        name = Decode.required o "name" Decode.string;
      })

type holds = {
  context : string;
  type_ : string;
  id : string;
  motivation : string;
  target : holds_target;
  creator : holds_creator;
  created : string;
  body : holds_body_item list option;
  modified : string option;
  generator : holds_generator option;
}

let holds =
  Decode.obj (fun o : holds ->
      {
        context = Decode.required o "@context" Decode.string;
        type_ = Decode.required o "type" Decode.string;
        id = Decode.required o "id" Decode.string;
        motivation = Decode.required o "motivation" Decode.string;
        target = Decode.required o "target" holds_target;
        creator = Decode.required o "creator" holds_creator;
        created = Decode.required o "created" Decode.string;
        body = Decode.optional o "body" (Decode.list holds_body_item);
        modified = Decode.optional o "modified" Decode.string;
        generator = Decode.optional o "generator" holds_generator;
      })

type annotation_stored = {
  annotation : annotation;
  properties : properties;
  json : json;
  tags : string list;
  links_to : string option;
  holds : holds;
}

let annotation_stored =
  Decode.obj (fun o : annotation_stored ->
      {
        annotation = Decode.required o "annotation" annotation;
        properties = Decode.required o "properties" properties;
        json = Decode.required o "json" json;
        tags = Decode.required o "tags" (Decode.list Decode.string);
        links_to = Decode.required o "linksTo" (Decode.nullable Decode.string);
        holds = Decode.required o "holds" holds;
      })

type annotation_read_properties = {
  id : string option;
  resource_id : string option;
  type_ : string;
  motivation : string option;
  created : string option;
  source : string option;
  selector : string option;
  exact : string option;
  creator : string option;
}

let annotation_read_properties =
  Decode.obj (fun o : annotation_read_properties ->
      {
        id = Decode.optional o "id" Decode.string;
        resource_id = Decode.optional o "resourceId" Decode.string;
        type_ = Decode.required o "type" Decode.string;
        motivation = Decode.optional o "motivation" Decode.string;
        created = Decode.optional o "created" Decode.string;
        source = Decode.optional o "source" Decode.string;
        selector = Decode.optional o "selector" Decode.string;
        exact = Decode.optional o "exact" Decode.string;
        creator = Decode.optional o "creator" Decode.string;
      })

type annotation_read_annotation_target_selector = {
  type_ : string;
  exact : string;
  prefix : string;
  suffix : string;
}

let annotation_read_annotation_target_selector =
  Decode.obj (fun o : annotation_read_annotation_target_selector ->
      {
        type_ = Decode.required o "type" Decode.string;
        exact = Decode.required o "exact" Decode.string;
        prefix = Decode.required o "prefix" Decode.string;
        suffix = Decode.required o "suffix" Decode.string;
      })

type annotation_read_annotation_target = {
  source : string;
  selector : annotation_read_annotation_target_selector option;
}

let annotation_read_annotation_target =
  Decode.obj (fun o : annotation_read_annotation_target ->
      {
        source = Decode.required o "source" Decode.string;
        selector =
          Decode.optional o "selector"
            annotation_read_annotation_target_selector;
      })

type annotation_read_annotation_creator = { type_ : string; id : string }

let annotation_read_annotation_creator =
  Decode.obj (fun o : annotation_read_annotation_creator ->
      {
        type_ = Decode.required o "@type" Decode.string;
        id = Decode.required o "@id" Decode.string;
      })

type annotation_read_annotation_body_item_textual_body = {
  value : string;
  purpose : string;
}

let annotation_read_annotation_body_item_textual_body =
  Decode.obj (fun o : annotation_read_annotation_body_item_textual_body ->
      Decode.required o "type" (Decode.literal "TextualBody");
      {
        value = Decode.required o "value" Decode.string;
        purpose = Decode.required o "purpose" Decode.string;
      })

type annotation_read_annotation_body_item_specific_resource = {
  source : string;
  purpose : string;
}

let annotation_read_annotation_body_item_specific_resource =
  Decode.obj (fun o : annotation_read_annotation_body_item_specific_resource ->
      Decode.required o "type" (Decode.literal "SpecificResource");
      {
        source = Decode.required o "source" Decode.string;
        purpose = Decode.required o "purpose" Decode.string;
      })

type annotation_read_annotation_body_item =
  | Textual_body of annotation_read_annotation_body_item_textual_body
  | Specific_resource of annotation_read_annotation_body_item_specific_resource

let annotation_read_annotation_body_item =
  Decode.variant "type"
    [
      ( "TextualBody",
        fun c ->
          (Textual_body (annotation_read_annotation_body_item_textual_body c)
            : annotation_read_annotation_body_item) );
      ( "SpecificResource",
        fun c ->
          (Specific_resource
             (annotation_read_annotation_body_item_specific_resource c)
            : annotation_read_annotation_body_item) );
    ]

type annotation_read_annotation = {
  context : string;
  type_ : string;
  id : string;
  motivation : string;
  target : annotation_read_annotation_target;
  creator : annotation_read_annotation_creator;
  created : string;
  body : annotation_read_annotation_body_item list;
}

let annotation_read_annotation =
  Decode.obj (fun o : annotation_read_annotation ->
      {
        context = Decode.required o "@context" Decode.string;
        type_ = Decode.required o "type" Decode.string;
        id = Decode.required o "id" Decode.string;
        motivation = Decode.required o "motivation" Decode.string;
        target = Decode.required o "target" annotation_read_annotation_target;
        creator = Decode.required o "creator" annotation_read_annotation_creator;
        created = Decode.required o "created" Decode.string;
        body =
          Decode.required o "body"
            (Decode.list annotation_read_annotation_body_item);
      })

type annotation_read = {
  properties : annotation_read_properties;
  tags : string list;
  annotation : annotation_read_annotation option;
  refused : string option;
}

let annotation_read =
  Decode.obj (fun o : annotation_read ->
      {
        properties = Decode.required o "properties" annotation_read_properties;
        tags = Decode.required o "tags" (Decode.list Decode.string);
        annotation = Decode.optional o "annotation" annotation_read_annotation;
        refused = Decode.optional o "refused" Decode.string;
      })

type current_target_selector = {
  type_ : string;
  exact : string;
  prefix : string;
  suffix : string;
}

let current_target_selector =
  Decode.obj (fun o : current_target_selector ->
      {
        type_ = Decode.required o "type" Decode.string;
        exact = Decode.required o "exact" Decode.string;
        prefix = Decode.required o "prefix" Decode.string;
        suffix = Decode.required o "suffix" Decode.string;
      })

type current_target = { source : string; selector : current_target_selector }

let current_target =
  Decode.obj (fun o : current_target ->
      {
        source = Decode.required o "source" Decode.string;
        selector = Decode.required o "selector" current_target_selector;
      })

type current_creator = { type_ : string; id : string }

let current_creator =
  Decode.obj (fun o : current_creator ->
      {
        type_ = Decode.required o "@type" Decode.string;
        id = Decode.required o "@id" Decode.string;
      })

type current_body_item_textual_body = { value : string; purpose : string }

let current_body_item_textual_body =
  Decode.obj (fun o : current_body_item_textual_body ->
      Decode.required o "type" (Decode.literal "TextualBody");
      {
        value = Decode.required o "value" Decode.string;
        purpose = Decode.required o "purpose" Decode.string;
      })

type current_body_item_specific_resource = { source : string; purpose : string }

let current_body_item_specific_resource =
  Decode.obj (fun o : current_body_item_specific_resource ->
      Decode.required o "type" (Decode.literal "SpecificResource");
      {
        source = Decode.required o "source" Decode.string;
        purpose = Decode.required o "purpose" Decode.string;
      })

type current_body_item =
  | Textual_body of current_body_item_textual_body
  | Specific_resource of current_body_item_specific_resource

let current_body_item =
  Decode.variant "type"
    [
      ( "TextualBody",
        fun c ->
          (Textual_body (current_body_item_textual_body c) : current_body_item)
      );
      ( "SpecificResource",
        fun c ->
          (Specific_resource (current_body_item_specific_resource c)
            : current_body_item) );
    ]

type current = {
  context : string;
  type_ : string;
  id : string;
  motivation : string;
  target : current_target;
  creator : current_creator;
  created : string;
  body : current_body_item list;
}

let current =
  Decode.obj (fun o : current ->
      {
        context = Decode.required o "@context" Decode.string;
        type_ = Decode.required o "type" Decode.string;
        id = Decode.required o "id" Decode.string;
        motivation = Decode.required o "motivation" Decode.string;
        target = Decode.required o "target" current_target;
        creator = Decode.required o "creator" current_creator;
        created = Decode.required o "created" Decode.string;
        body = Decode.required o "body" (Decode.list current_body_item);
      })

type updates_body_item_textual_body = { value : string; purpose : string }

let updates_body_item_textual_body =
  Decode.obj (fun o : updates_body_item_textual_body ->
      Decode.required o "type" (Decode.literal "TextualBody");
      {
        value = Decode.required o "value" Decode.string;
        purpose = Decode.required o "purpose" Decode.string;
      })

type updates_body_item_specific_resource = { source : string; purpose : string }

let updates_body_item_specific_resource =
  Decode.obj (fun o : updates_body_item_specific_resource ->
      Decode.required o "type" (Decode.literal "SpecificResource");
      {
        source = Decode.required o "source" Decode.string;
        purpose = Decode.required o "purpose" Decode.string;
      })

type updates_body_item =
  | Textual_body of updates_body_item_textual_body
  | Specific_resource of updates_body_item_specific_resource

let updates_body_item =
  Decode.variant "type"
    [
      ( "TextualBody",
        fun c ->
          (Textual_body (updates_body_item_textual_body c) : updates_body_item)
      );
      ( "SpecificResource",
        fun c ->
          (Specific_resource (updates_body_item_specific_resource c)
            : updates_body_item) );
    ]

type updates_target_selector = { type_ : string; exact : string }

let updates_target_selector =
  Decode.obj (fun o : updates_target_selector ->
      {
        type_ = Decode.required o "type" Decode.string;
        exact = Decode.required o "exact" Decode.string;
      })

type updates_target = {
  source : string;
  selector : updates_target_selector option;
}

let updates_target =
  Decode.obj (fun o : updates_target ->
      {
        source = Decode.required o "source" Decode.string;
        selector = Decode.optional o "selector" updates_target_selector;
      })

type updates = {
  body : updates_body_item list option;
  modified : string option;
  target : updates_target option;
  id : string option;
}

let updates =
  Decode.obj (fun o : updates ->
      {
        body = Decode.optional o "body" (Decode.list updates_body_item);
        modified = Decode.optional o "modified" Decode.string;
        target = Decode.optional o "target" updates_target;
        id = Decode.optional o "id" Decode.string;
      })

type annotation_updated_annotation_target_selector = {
  type_ : string;
  exact : string;
  prefix : string option;
  suffix : string option;
}

let annotation_updated_annotation_target_selector =
  Decode.obj (fun o : annotation_updated_annotation_target_selector ->
      {
        type_ = Decode.required o "type" Decode.string;
        exact = Decode.required o "exact" Decode.string;
        prefix = Decode.optional o "prefix" Decode.string;
        suffix = Decode.optional o "suffix" Decode.string;
      })

type annotation_updated_annotation_target = {
  source : string;
  selector : annotation_updated_annotation_target_selector;
}

let annotation_updated_annotation_target =
  Decode.obj (fun o : annotation_updated_annotation_target ->
      {
        source = Decode.required o "source" Decode.string;
        selector =
          Decode.required o "selector"
            annotation_updated_annotation_target_selector;
      })

type annotation_updated_annotation_creator = { type_ : string; id : string }

let annotation_updated_annotation_creator =
  Decode.obj (fun o : annotation_updated_annotation_creator ->
      {
        type_ = Decode.required o "@type" Decode.string;
        id = Decode.required o "@id" Decode.string;
      })

type annotation_updated_annotation_body_item_textual_body = {
  value : string;
  purpose : string;
}

let annotation_updated_annotation_body_item_textual_body =
  Decode.obj (fun o : annotation_updated_annotation_body_item_textual_body ->
      Decode.required o "type" (Decode.literal "TextualBody");
      {
        value = Decode.required o "value" Decode.string;
        purpose = Decode.required o "purpose" Decode.string;
      })

type annotation_updated_annotation_body_item_specific_resource = {
  source : string;
  purpose : string;
}

let annotation_updated_annotation_body_item_specific_resource =
  Decode.obj
    (fun o : annotation_updated_annotation_body_item_specific_resource ->
      Decode.required o "type" (Decode.literal "SpecificResource");
      {
        source = Decode.required o "source" Decode.string;
        purpose = Decode.required o "purpose" Decode.string;
      })

type annotation_updated_annotation_body_item =
  | Textual_body of annotation_updated_annotation_body_item_textual_body
  | Specific_resource of
      annotation_updated_annotation_body_item_specific_resource

let annotation_updated_annotation_body_item =
  Decode.variant "type"
    [
      ( "TextualBody",
        fun c ->
          (Textual_body (annotation_updated_annotation_body_item_textual_body c)
            : annotation_updated_annotation_body_item) );
      ( "SpecificResource",
        fun c ->
          (Specific_resource
             (annotation_updated_annotation_body_item_specific_resource c)
            : annotation_updated_annotation_body_item) );
    ]

type annotation_updated_annotation = {
  context : string;
  type_ : string;
  id : string;
  motivation : string;
  target : annotation_updated_annotation_target;
  creator : annotation_updated_annotation_creator;
  created : string;
  body : annotation_updated_annotation_body_item list option;
  modified : string option;
}

let annotation_updated_annotation =
  Decode.obj (fun o : annotation_updated_annotation ->
      {
        context = Decode.required o "@context" Decode.string;
        type_ = Decode.required o "type" Decode.string;
        id = Decode.required o "id" Decode.string;
        motivation = Decode.required o "motivation" Decode.string;
        target = Decode.required o "target" annotation_updated_annotation_target;
        creator =
          Decode.required o "creator" annotation_updated_annotation_creator;
        created = Decode.required o "created" Decode.string;
        body =
          Decode.optional o "body"
            (Decode.list annotation_updated_annotation_body_item);
        modified = Decode.optional o "modified" Decode.string;
      })

type annotation_updated = {
  current : current;
  updates : updates;
  annotation : annotation_updated_annotation option;
  refused : string option;
}

let annotation_updated =
  Decode.obj (fun o : annotation_updated ->
      {
        current = Decode.required o "current" current;
        updates = Decode.required o "updates" updates;
        annotation =
          Decode.optional o "annotation" annotation_updated_annotation;
        refused = Decode.optional o "refused" Decode.string;
      })

type reference_resolved_current_target_selector = {
  type_ : string;
  exact : string;
  prefix : string;
  suffix : string;
}

let reference_resolved_current_target_selector =
  Decode.obj (fun o : reference_resolved_current_target_selector ->
      {
        type_ = Decode.required o "type" Decode.string;
        exact = Decode.required o "exact" Decode.string;
        prefix = Decode.required o "prefix" Decode.string;
        suffix = Decode.required o "suffix" Decode.string;
      })

type reference_resolved_current_target = {
  source : string;
  selector : reference_resolved_current_target_selector option;
}

let reference_resolved_current_target =
  Decode.obj (fun o : reference_resolved_current_target ->
      {
        source = Decode.required o "source" Decode.string;
        selector =
          Decode.optional o "selector"
            reference_resolved_current_target_selector;
      })

type reference_resolved_current_creator = { type_ : string; id : string }

let reference_resolved_current_creator =
  Decode.obj (fun o : reference_resolved_current_creator ->
      {
        type_ = Decode.required o "@type" Decode.string;
        id = Decode.required o "@id" Decode.string;
      })

type reference_resolved_current_body_item_textual_body = {
  value : string;
  purpose : string;
}

let reference_resolved_current_body_item_textual_body =
  Decode.obj (fun o : reference_resolved_current_body_item_textual_body ->
      Decode.required o "type" (Decode.literal "TextualBody");
      {
        value = Decode.required o "value" Decode.string;
        purpose = Decode.required o "purpose" Decode.string;
      })

type reference_resolved_current_body_item_specific_resource = {
  source : string;
  purpose : string;
}

let reference_resolved_current_body_item_specific_resource =
  Decode.obj (fun o : reference_resolved_current_body_item_specific_resource ->
      Decode.required o "type" (Decode.literal "SpecificResource");
      {
        source = Decode.required o "source" Decode.string;
        purpose = Decode.required o "purpose" Decode.string;
      })

type reference_resolved_current_body_item =
  | Textual_body of reference_resolved_current_body_item_textual_body
  | Specific_resource of reference_resolved_current_body_item_specific_resource

let reference_resolved_current_body_item =
  Decode.variant "type"
    [
      ( "TextualBody",
        fun c ->
          (Textual_body (reference_resolved_current_body_item_textual_body c)
            : reference_resolved_current_body_item) );
      ( "SpecificResource",
        fun c ->
          (Specific_resource
             (reference_resolved_current_body_item_specific_resource c)
            : reference_resolved_current_body_item) );
    ]

type reference_resolved_current = {
  context : string;
  type_ : string;
  id : string;
  motivation : string;
  target : reference_resolved_current_target;
  creator : reference_resolved_current_creator;
  created : string;
  body : reference_resolved_current_body_item list option;
}

let reference_resolved_current =
  Decode.obj (fun o : reference_resolved_current ->
      {
        context = Decode.required o "@context" Decode.string;
        type_ = Decode.required o "type" Decode.string;
        id = Decode.required o "id" Decode.string;
        motivation = Decode.required o "motivation" Decode.string;
        target = Decode.required o "target" reference_resolved_current_target;
        creator = Decode.required o "creator" reference_resolved_current_creator;
        created = Decode.required o "created" Decode.string;
        body =
          Decode.optional o "body"
            (Decode.list reference_resolved_current_body_item);
      })

type reference_resolved_body_item_textual_body = {
  value : string;
  purpose : string;
}

let reference_resolved_body_item_textual_body =
  Decode.obj (fun o : reference_resolved_body_item_textual_body ->
      Decode.required o "type" (Decode.literal "TextualBody");
      {
        value = Decode.required o "value" Decode.string;
        purpose = Decode.required o "purpose" Decode.string;
      })

type reference_resolved_body_item_specific_resource = {
  source : string;
  purpose : string;
}

let reference_resolved_body_item_specific_resource =
  Decode.obj (fun o : reference_resolved_body_item_specific_resource ->
      Decode.required o "type" (Decode.literal "SpecificResource");
      {
        source = Decode.required o "source" Decode.string;
        purpose = Decode.required o "purpose" Decode.string;
      })

type reference_resolved_body_item =
  | Textual_body of reference_resolved_body_item_textual_body
  | Specific_resource of reference_resolved_body_item_specific_resource

let reference_resolved_body_item =
  Decode.variant "type"
    [
      ( "TextualBody",
        fun c ->
          (Textual_body (reference_resolved_body_item_textual_body c)
            : reference_resolved_body_item) );
      ( "SpecificResource",
        fun c ->
          (Specific_resource (reference_resolved_body_item_specific_resource c)
            : reference_resolved_body_item) );
    ]

type reference_resolved = {
  current : reference_resolved_current;
  source : string;
  body : reference_resolved_body_item list;
}

let reference_resolved =
  Decode.obj (fun o : reference_resolved ->
      {
        current = Decode.required o "current" reference_resolved_current;
        source = Decode.required o "source" Decode.string;
        body =
          Decode.required o "body" (Decode.list reference_resolved_body_item);
      })

type representation = {
  media_type : string;
  checksum : string option;
  rel : string;
  storage_uri : string option;
  byte_size : int option;
}

let representation =
  Decode.obj (fun o : representation ->
      {
        media_type = Decode.required o "mediaType" Decode.string;
        checksum = Decode.optional o "checksum" Decode.string;
        rel = Decode.required o "rel" Decode.string;
        storage_uri = Decode.optional o "storageUri" Decode.string;
        byte_size = Decode.optional o "byteSize" Decode.int;
      })

type was_attributed_to_was_attributed_to_item = {
  type_ : string;
  id : string;
  name : string;
}

let was_attributed_to_was_attributed_to_item =
  Decode.obj (fun o : was_attributed_to_was_attributed_to_item ->
      {
        type_ = Decode.required o "@type" Decode.string;
        id = Decode.required o "@id" Decode.string;
        name = Decode.required o "name" Decode.string;
      })

type was_attributed_to_was_attributed_to = {
  type_ : string;
  id : string;
  name : string;
}

let was_attributed_to_was_attributed_to =
  Decode.obj (fun o : was_attributed_to_was_attributed_to ->
      {
        type_ = Decode.required o "@type" Decode.string;
        id = Decode.required o "@id" Decode.string;
        name = Decode.required o "name" Decode.string;
      })

type was_attributed_to =
  | Array of was_attributed_to_was_attributed_to_item list
  | Object of was_attributed_to_was_attributed_to

let was_attributed_to =
 fun c ->
  match Decode.kind c with
  | Decode.Array ->
      (Array (Decode.list was_attributed_to_was_attributed_to_item c)
        : was_attributed_to)
  | Decode.Object ->
      (Object (was_attributed_to_was_attributed_to c) : was_attributed_to)
  | _ -> Decode.refuse c "expected an array or an object"

type resource = {
  context : string;
  id : string;
  name : string;
  entity_types : string list option;
  representations : representation list;
  archived : bool option;
  date_created : string option;
  was_attributed_to : was_attributed_to option;
  description : string option;
  date_modified : string option;
  is_draft : bool option;
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
          Decode.required o "representations" (Decode.list representation);
        archived = Decode.optional o "archived" Decode.bool;
        date_created = Decode.optional o "dateCreated" Decode.string;
        was_attributed_to =
          Decode.optional o "wasAttributedTo" was_attributed_to;
        description = Decode.optional o "description" Decode.string;
        date_modified = Decode.optional o "dateModified" Decode.string;
        is_draft = Decode.optional o "isDraft" Decode.bool;
      })

type resource_stored_properties = {
  id : string;
  name : string;
  entity_types : string list;
  format : string;
  archived : bool;
  created : string;
  content_checksum : string;
  storage_uri : string option;
}

let resource_stored_properties =
  Decode.obj (fun o : resource_stored_properties ->
      {
        id = Decode.required o "id" Decode.string;
        name = Decode.required o "name" Decode.string;
        entity_types =
          Decode.required o "entityTypes" (Decode.list Decode.string);
        format = Decode.required o "format" Decode.string;
        archived = Decode.required o "archived" Decode.bool;
        created = Decode.required o "created" Decode.string;
        content_checksum = Decode.required o "contentChecksum" Decode.string;
        storage_uri = Decode.optional o "storageUri" Decode.string;
      })

type creator_item = { type_ : string; id : string; name : string }

let creator_item =
  Decode.obj (fun o : creator_item ->
      {
        type_ = Decode.required o "@type" Decode.string;
        id = Decode.required o "@id" Decode.string;
        name = Decode.required o "name" Decode.string;
      })

type resource_stored_json_creator_creator = {
  type_ : string;
  id : string;
  name : string;
}

let resource_stored_json_creator_creator =
  Decode.obj (fun o : resource_stored_json_creator_creator ->
      {
        type_ = Decode.required o "@type" Decode.string;
        id = Decode.required o "@id" Decode.string;
        name = Decode.required o "name" Decode.string;
      })

type resource_stored_json_creator =
  | Array of creator_item list
  | Object of resource_stored_json_creator_creator

let resource_stored_json_creator =
 fun c ->
  match Decode.kind c with
  | Decode.Array ->
      (Array (Decode.list creator_item c) : resource_stored_json_creator)
  | Decode.Object ->
      (Object (resource_stored_json_creator_creator c)
        : resource_stored_json_creator)
  | _ -> Decode.refuse c "expected an array or an object"

type resource_stored_json = { creator : resource_stored_json_creator }

let resource_stored_json =
  Decode.obj (fun o : resource_stored_json ->
      { creator = Decode.required o "creator" resource_stored_json_creator })

type resource_stored_holds_representation = {
  media_type : string;
  checksum : string;
  rel : string;
  storage_uri : string option;
}

let resource_stored_holds_representation =
  Decode.obj (fun o : resource_stored_holds_representation ->
      {
        media_type = Decode.required o "mediaType" Decode.string;
        checksum = Decode.required o "checksum" Decode.string;
        rel = Decode.required o "rel" Decode.string;
        storage_uri = Decode.optional o "storageUri" Decode.string;
      })

type resource_stored_holds_was_attributed_to_was_attributed_to_item = {
  type_ : string;
  id : string;
  name : string;
}

let resource_stored_holds_was_attributed_to_was_attributed_to_item =
  Decode.obj
    (fun o : resource_stored_holds_was_attributed_to_was_attributed_to_item ->
      {
        type_ = Decode.required o "@type" Decode.string;
        id = Decode.required o "@id" Decode.string;
        name = Decode.required o "name" Decode.string;
      })

type resource_stored_holds_was_attributed_to_was_attributed_to = {
  type_ : string;
  id : string;
  name : string;
}

let resource_stored_holds_was_attributed_to_was_attributed_to =
  Decode.obj
    (fun o : resource_stored_holds_was_attributed_to_was_attributed_to ->
      {
        type_ = Decode.required o "@type" Decode.string;
        id = Decode.required o "@id" Decode.string;
        name = Decode.required o "name" Decode.string;
      })

type resource_stored_holds_was_attributed_to =
  | Array of resource_stored_holds_was_attributed_to_was_attributed_to_item list
  | Object of resource_stored_holds_was_attributed_to_was_attributed_to

let resource_stored_holds_was_attributed_to =
 fun c ->
  match Decode.kind c with
  | Decode.Array ->
      (Array
         (Decode.list
            resource_stored_holds_was_attributed_to_was_attributed_to_item c)
        : resource_stored_holds_was_attributed_to)
  | Decode.Object ->
      (Object (resource_stored_holds_was_attributed_to_was_attributed_to c)
        : resource_stored_holds_was_attributed_to)
  | _ -> Decode.refuse c "expected an array or an object"

type resource_stored_holds = {
  context : string;
  id : string;
  name : string;
  entity_types : string list;
  representations : resource_stored_holds_representation list;
  archived : bool;
  date_created : string;
  was_attributed_to : resource_stored_holds_was_attributed_to;
}

let resource_stored_holds =
  Decode.obj (fun o : resource_stored_holds ->
      {
        context = Decode.required o "@context" Decode.string;
        id = Decode.required o "@id" Decode.string;
        name = Decode.required o "name" Decode.string;
        entity_types =
          Decode.required o "entityTypes" (Decode.list Decode.string);
        representations =
          Decode.required o "representations"
            (Decode.list resource_stored_holds_representation);
        archived = Decode.required o "archived" Decode.bool;
        date_created = Decode.required o "dateCreated" Decode.string;
        was_attributed_to =
          Decode.required o "wasAttributedTo"
            resource_stored_holds_was_attributed_to;
      })

type resource_stored = {
  resource : resource;
  properties : resource_stored_properties option;
  json : resource_stored_json option;
  holds : resource_stored_holds option;
  refused : string option;
}

let resource_stored =
  Decode.obj (fun o : resource_stored ->
      {
        resource = Decode.required o "resource" resource;
        properties = Decode.optional o "properties" resource_stored_properties;
        json = Decode.optional o "json" resource_stored_json;
        holds = Decode.optional o "holds" resource_stored_holds;
        refused = Decode.optional o "refused" Decode.string;
      })

type resource_read_properties = {
  id : string option;
  name : string option;
  entity_types : string list option;
  format : string option;
  archived : bool option;
  created : string option;
  content_checksum : string option;
  storage_uri : string;
  creator : string option;
}

let resource_read_properties =
  Decode.obj (fun o : resource_read_properties ->
      {
        id = Decode.optional o "id" Decode.string;
        name = Decode.optional o "name" Decode.string;
        entity_types =
          Decode.optional o "entityTypes" (Decode.list Decode.string);
        format = Decode.optional o "format" Decode.string;
        archived = Decode.optional o "archived" Decode.bool;
        created = Decode.optional o "created" Decode.string;
        content_checksum = Decode.optional o "contentChecksum" Decode.string;
        storage_uri = Decode.required o "storageUri" Decode.string;
        creator = Decode.optional o "creator" Decode.string;
      })

type resource_read_resource_representation = {
  media_type : string;
  checksum : string;
  rel : string;
  storage_uri : string;
}

let resource_read_resource_representation =
  Decode.obj (fun o : resource_read_resource_representation ->
      {
        media_type = Decode.required o "mediaType" Decode.string;
        checksum = Decode.required o "checksum" Decode.string;
        rel = Decode.required o "rel" Decode.string;
        storage_uri = Decode.required o "storageUri" Decode.string;
      })

type resource_read_resource_was_attributed_to_item = {
  type_ : string;
  id : string;
  name : string;
}

let resource_read_resource_was_attributed_to_item =
  Decode.obj (fun o : resource_read_resource_was_attributed_to_item ->
      {
        type_ = Decode.required o "@type" Decode.string;
        id = Decode.required o "@id" Decode.string;
        name = Decode.required o "name" Decode.string;
      })

type resource_read_resource = {
  context : string;
  id : string;
  name : string;
  entity_types : string list;
  representations : resource_read_resource_representation list;
  archived : bool;
  date_created : string;
  was_attributed_to : resource_read_resource_was_attributed_to_item list;
}

let resource_read_resource =
  Decode.obj (fun o : resource_read_resource ->
      {
        context = Decode.required o "@context" Decode.string;
        id = Decode.required o "@id" Decode.string;
        name = Decode.required o "name" Decode.string;
        entity_types =
          Decode.required o "entityTypes" (Decode.list Decode.string);
        representations =
          Decode.required o "representations"
            (Decode.list resource_read_resource_representation);
        archived = Decode.required o "archived" Decode.bool;
        date_created = Decode.required o "dateCreated" Decode.string;
        was_attributed_to =
          Decode.required o "wasAttributedTo"
            (Decode.list resource_read_resource_was_attributed_to_item);
      })

type resource_read = {
  properties : resource_read_properties;
  resource : resource_read_resource option;
  refused : string option;
}

let resource_read =
  Decode.obj (fun o : resource_read ->
      {
        properties = Decode.required o "properties" resource_read_properties;
        resource = Decode.optional o "resource" resource_read_resource;
        refused = Decode.optional o "refused" Decode.string;
      })

type case = {
  why : string;
  annotation_stored : annotation_stored option;
  annotation_read : annotation_read option;
  annotation_updated : annotation_updated option;
  reference_resolved : reference_resolved option;
  resource_stored : resource_stored option;
  resource_read : resource_read option;
}

let case =
  Decode.obj (fun o : case ->
      {
        why = Decode.required o "why" Decode.string;
        annotation_stored =
          Decode.optional o "annotationStored" annotation_stored;
        annotation_read = Decode.optional o "annotationRead" annotation_read;
        annotation_updated =
          Decode.optional o "annotationUpdated" annotation_updated;
        reference_resolved =
          Decode.optional o "referenceResolved" reference_resolved;
        resource_stored = Decode.optional o "resourceStored" resource_stored;
        resource_read = Decode.optional o "resourceRead" resource_read;
      })

type t = { comment : string; run_by : Case_table.run_by; cases : case list }

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        run_by = Decode.required o "runBy" Case_table.run_by;
        cases = Decode.required o "cases" (Decode.list case);
      })
