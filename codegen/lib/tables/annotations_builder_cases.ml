(* specs/src/annotations/builder-cases.json *)

type unstated = { cases : string list; resources : string list }

let unstated =
  Decode.obj (fun o : unstated ->
      {
        cases = Decode.required o "cases" (Decode.list Decode.string);
        resources = Decode.required o "resources" (Decode.list Decode.string);
      })

type parameters = { temperature : int; max_tokens : int }

let parameters =
  Decode.obj (fun o : parameters ->
      {
        temperature = Decode.required o "temperature" Decode.int;
        max_tokens = Decode.required o "maxTokens" Decode.int;
      })

type generator = {
  type_ : string;
  id : string;
  name : string;
  provider : string;
  model : string;
  parameters : parameters option;
}

let generator =
  Decode.obj (fun o : generator ->
      {
        type_ = Decode.required o "@type" Decode.string;
        id = Decode.required o "@id" Decode.string;
        name = Decode.required o "name" Decode.string;
        provider = Decode.required o "provider" Decode.string;
        model = Decode.required o "model" Decode.string;
        parameters = Decode.optional o "parameters" parameters;
      })

type span = {
  start : float;
  end_ : int;
  exact : string;
  prefix : string option;
  suffix : string option;
}

let span =
  Decode.obj (fun o : span ->
      {
        start = Decode.required o "start" Decode.number;
        end_ = Decode.required o "end" Decode.int;
        exact = Decode.required o "exact" Decode.string;
        prefix = Decode.optional o "prefix" Decode.string;
        suffix = Decode.optional o "suffix" Decode.string;
      })

type annotation_generator_parameters = { temperature : int; max_tokens : int }

let annotation_generator_parameters =
  Decode.obj (fun o : annotation_generator_parameters ->
      {
        temperature = Decode.required o "temperature" Decode.int;
        max_tokens = Decode.required o "maxTokens" Decode.int;
      })

type annotation_generator = {
  type_ : string;
  id : string;
  name : string;
  provider : string;
  model : string;
  parameters : annotation_generator_parameters option;
}

let annotation_generator =
  Decode.obj (fun o : annotation_generator ->
      {
        type_ = Decode.required o "@type" Decode.string;
        id = Decode.required o "@id" Decode.string;
        name = Decode.required o "name" Decode.string;
        provider = Decode.required o "provider" Decode.string;
        model = Decode.required o "model" Decode.string;
        parameters =
          Decode.optional o "parameters" annotation_generator_parameters;
      })

type selector_item_text_position_selector = { start : int; end_ : int }

let selector_item_text_position_selector =
  Decode.obj (fun o : selector_item_text_position_selector ->
      Decode.required o "type" (Decode.literal "TextPositionSelector");
      {
        start = Decode.required o "start" Decode.int;
        end_ = Decode.required o "end" Decode.int;
      })

type selector_item_text_quote_selector = {
  exact : string;
  prefix : string option;
  suffix : string option;
}

let selector_item_text_quote_selector =
  Decode.obj (fun o : selector_item_text_quote_selector ->
      Decode.required o "type" (Decode.literal "TextQuoteSelector");
      {
        exact = Decode.required o "exact" Decode.string;
        prefix = Decode.optional o "prefix" Decode.string;
        suffix = Decode.optional o "suffix" Decode.string;
      })

type selector_item_fragment_selector = { conforms_to : string; value : string }

let selector_item_fragment_selector =
  Decode.obj (fun o : selector_item_fragment_selector ->
      Decode.required o "type" (Decode.literal "FragmentSelector");
      {
        conforms_to = Decode.required o "conformsTo" Decode.string;
        value = Decode.required o "value" Decode.string;
      })

type selector_item =
  | Text_position_selector of selector_item_text_position_selector
  | Text_quote_selector of selector_item_text_quote_selector
  | Fragment_selector of selector_item_fragment_selector

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
      ( "FragmentSelector",
        fun c ->
          (Fragment_selector (selector_item_fragment_selector c)
            : selector_item) );
    ]

type target = { type_ : string; source : string; selector : selector_item list }

let target =
  Decode.obj (fun o : target ->
      {
        type_ = Decode.required o "type" Decode.string;
        source = Decode.required o "source" Decode.string;
        selector = Decode.required o "selector" (Decode.list selector_item);
      })

type body_item = {
  type_ : string;
  value : string;
  purpose : string;
  format : string;
}

let body_item =
  Decode.obj (fun o : body_item ->
      {
        type_ = Decode.required o "type" Decode.string;
        value = Decode.required o "value" Decode.string;
        purpose = Decode.required o "purpose" Decode.string;
        format = Decode.required o "format" Decode.string;
      })

type body_body_textual_body = { value : string; purpose : string }

let body_body_textual_body =
  Decode.obj (fun o : body_body_textual_body ->
      Decode.required o "type" (Decode.literal "TextualBody");
      {
        value = Decode.required o "value" Decode.string;
        purpose = Decode.required o "purpose" Decode.string;
      })

type body_body_specific_resource = { source : string; purpose : string }

let body_body_specific_resource =
  Decode.obj (fun o : body_body_specific_resource ->
      Decode.required o "type" (Decode.literal "SpecificResource");
      {
        source = Decode.required o "source" Decode.string;
        purpose = Decode.required o "purpose" Decode.string;
      })

type body_body =
  | Textual_body of body_body_textual_body
  | Specific_resource of body_body_specific_resource

let body_body =
  Decode.variant "type"
    [
      ( "TextualBody",
        fun c -> (Textual_body (body_body_textual_body c) : body_body) );
      ( "SpecificResource",
        fun c -> (Specific_resource (body_body_specific_resource c) : body_body)
      );
    ]

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
  generator : annotation_generator;
  target : target;
  body : body option;
}

let annotation =
  Decode.obj (fun o : annotation ->
      {
        context = Decode.required o "@context" Decode.string;
        type_ = Decode.required o "type" Decode.string;
        id = Decode.required o "id" Decode.string;
        motivation = Decode.required o "motivation" Decode.string;
        generator = Decode.required o "generator" annotation_generator;
        target = Decode.required o "target" target;
        body = Decode.optional o "body" body;
      })

type case_body_body_item = {
  type_ : string;
  value : string;
  purpose : string;
  format : string;
}

let case_body_body_item =
  Decode.obj (fun o : case_body_body_item ->
      {
        type_ = Decode.required o "type" Decode.string;
        value = Decode.required o "value" Decode.string;
        purpose = Decode.required o "purpose" Decode.string;
        format = Decode.required o "format" Decode.string;
      })

type case_body_body_textual_body = { value : string; purpose : string }

let case_body_body_textual_body =
  Decode.obj (fun o : case_body_body_textual_body ->
      Decode.required o "type" (Decode.literal "TextualBody");
      {
        value = Decode.required o "value" Decode.string;
        purpose = Decode.required o "purpose" Decode.string;
      })

type case_body_body_specific_resource = { source : string; purpose : string }

let case_body_body_specific_resource =
  Decode.obj (fun o : case_body_body_specific_resource ->
      Decode.required o "type" (Decode.literal "SpecificResource");
      {
        source = Decode.required o "source" Decode.string;
        purpose = Decode.required o "purpose" Decode.string;
      })

type case_body_body =
  | Textual_body of case_body_body_textual_body
  | Specific_resource of case_body_body_specific_resource

let case_body_body =
  Decode.variant "type"
    [
      ( "TextualBody",
        fun c -> (Textual_body (case_body_body_textual_body c) : case_body_body)
      );
      ( "SpecificResource",
        fun c ->
          (Specific_resource (case_body_body_specific_resource c)
            : case_body_body) );
    ]

type case_body = Array of case_body_body_item list | Object of case_body_body

let case_body =
 fun c ->
  match Decode.kind c with
  | Decode.Array -> (Array (Decode.list case_body_body_item c) : case_body)
  | Decode.Object -> (Object (case_body_body c) : case_body)
  | _ -> Decode.refuse c "expected an array or an object"

type item = {
  start : int;
  end_ : int;
  page : int;
  x : int;
  y : int;
  width : int;
  height : int;
}

let item =
  Decode.obj (fun o : item ->
      {
        start = Decode.required o "start" Decode.int;
        end_ = Decode.required o "end" Decode.int;
        page = Decode.required o "page" Decode.int;
        x = Decode.required o "x" Decode.int;
        y = Decode.required o "y" Decode.int;
        width = Decode.required o "width" Decode.int;
        height = Decode.required o "height" Decode.int;
      })

type anchored = { text : string; items : item list }

let anchored =
  Decode.obj (fun o : anchored ->
      {
        text = Decode.required o "text" Decode.string;
        items = Decode.required o "items" (Decode.list item);
      })

type case = {
  why : string;
  text : string option;
  resource_id : string;
  generator : generator;
  motivation : string;
  span : span;
  annotation : annotation option;
  body : case_body option;
  refused : string option;
  anchored : anchored option;
}

let case =
  Decode.obj (fun o : case ->
      {
        why = Decode.required o "why" Decode.string;
        text = Decode.optional o "text" Decode.string;
        resource_id = Decode.required o "resourceId" Decode.string;
        generator = Decode.required o "generator" generator;
        motivation = Decode.required o "motivation" Decode.string;
        span = Decode.required o "span" span;
        annotation = Decode.optional o "annotation" annotation;
        body = Decode.optional o "body" case_body;
        refused = Decode.optional o "refused" Decode.string;
        anchored = Decode.optional o "anchored" anchored;
      })

type resource_generator = {
  type_ : string;
  id : string;
  name : string;
  provider : string;
  model : string;
}

let resource_generator =
  Decode.obj (fun o : resource_generator ->
      {
        type_ = Decode.required o "@type" Decode.string;
        id = Decode.required o "@id" Decode.string;
        name = Decode.required o "name" Decode.string;
        provider = Decode.required o "provider" Decode.string;
        model = Decode.required o "model" Decode.string;
      })

type resource_body_body_item = {
  type_ : string;
  value : string;
  purpose : string;
}

let resource_body_body_item =
  Decode.obj (fun o : resource_body_body_item ->
      {
        type_ = Decode.required o "type" Decode.string;
        value = Decode.required o "value" Decode.string;
        purpose = Decode.required o "purpose" Decode.string;
      })

type resource_body_body = { type_ : string; source : string; purpose : string }

let resource_body_body =
  Decode.obj (fun o : resource_body_body ->
      {
        type_ = Decode.required o "type" Decode.string;
        source = Decode.required o "source" Decode.string;
        purpose = Decode.required o "purpose" Decode.string;
      })

type resource_body =
  | Array of resource_body_body_item list
  | Object of resource_body_body

let resource_body =
 fun c ->
  match Decode.kind c with
  | Decode.Array ->
      (Array (Decode.list resource_body_body_item c) : resource_body)
  | Decode.Object -> (Object (resource_body_body c) : resource_body)
  | _ -> Decode.refuse c "expected an array or an object"

type resource_annotation_generator = {
  type_ : string;
  id : string;
  name : string;
  provider : string;
  model : string;
}

let resource_annotation_generator =
  Decode.obj (fun o : resource_annotation_generator ->
      {
        type_ = Decode.required o "@type" Decode.string;
        id = Decode.required o "@id" Decode.string;
        name = Decode.required o "name" Decode.string;
        provider = Decode.required o "provider" Decode.string;
        model = Decode.required o "model" Decode.string;
      })

type resource_annotation_target = { source : string }

let resource_annotation_target =
  Decode.obj (fun o : resource_annotation_target ->
      { source = Decode.required o "source" Decode.string })

type resource_annotation_body_body_item = {
  type_ : string;
  value : string;
  purpose : string;
}

let resource_annotation_body_body_item =
  Decode.obj (fun o : resource_annotation_body_body_item ->
      {
        type_ = Decode.required o "type" Decode.string;
        value = Decode.required o "value" Decode.string;
        purpose = Decode.required o "purpose" Decode.string;
      })

type resource_annotation_body_body = {
  type_ : string;
  source : string;
  purpose : string;
}

let resource_annotation_body_body =
  Decode.obj (fun o : resource_annotation_body_body ->
      {
        type_ = Decode.required o "type" Decode.string;
        source = Decode.required o "source" Decode.string;
        purpose = Decode.required o "purpose" Decode.string;
      })

type resource_annotation_body =
  | Array of resource_annotation_body_body_item list
  | Object of resource_annotation_body_body

let resource_annotation_body =
 fun c ->
  match Decode.kind c with
  | Decode.Array ->
      (Array (Decode.list resource_annotation_body_body_item c)
        : resource_annotation_body)
  | Decode.Object ->
      (Object (resource_annotation_body_body c) : resource_annotation_body)
  | _ -> Decode.refuse c "expected an array or an object"

type resource_annotation = {
  context : string;
  type_ : string;
  id : string;
  motivation : string;
  generator : resource_annotation_generator option;
  target : resource_annotation_target;
  body : resource_annotation_body option;
}

let resource_annotation =
  Decode.obj (fun o : resource_annotation ->
      {
        context = Decode.required o "@context" Decode.string;
        type_ = Decode.required o "type" Decode.string;
        id = Decode.required o "id" Decode.string;
        motivation = Decode.required o "motivation" Decode.string;
        generator = Decode.optional o "generator" resource_annotation_generator;
        target = Decode.required o "target" resource_annotation_target;
        body = Decode.optional o "body" resource_annotation_body;
      })

type resource = {
  why : string;
  resource_id : string;
  motivation : string;
  generator : resource_generator option;
  body : resource_body option;
  annotation : resource_annotation;
}

let resource =
  Decode.obj (fun o : resource ->
      {
        why = Decode.required o "why" Decode.string;
        resource_id = Decode.required o "resourceId" Decode.string;
        motivation = Decode.required o "motivation" Decode.string;
        generator = Decode.optional o "generator" resource_generator;
        body = Decode.optional o "body" resource_body;
        annotation = Decode.required o "annotation" resource_annotation;
      })

type t = {
  comment : string;
  run_by : Case_table.run_by;
  unstated : unstated;
  builders : string list;
  cases : case list;
  resources : resource list;
}

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        run_by = Decode.required o "runBy" Case_table.run_by;
        unstated = Decode.required o "unstated" unstated;
        builders = Decode.required o "builders" (Decode.list Decode.string);
        cases = Decode.required o "cases" (Decode.list case);
        resources = Decode.required o "resources" (Decode.list resource);
      })
