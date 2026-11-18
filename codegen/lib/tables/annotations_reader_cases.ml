(* specs/src/annotations/reader-cases.json *)

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
  prefix : string;
  suffix : string;
}

let selector_item_text_quote_selector =
  Decode.obj (fun o : selector_item_text_quote_selector ->
      Decode.required o "type" (Decode.literal "TextQuoteSelector");
      {
        exact = Decode.required o "exact" Decode.string;
        prefix = Decode.required o "prefix" Decode.string;
        suffix = Decode.required o "suffix" Decode.string;
      })

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

type selector_selector_text_quote_selector = {
  exact : string;
  prefix : string;
  suffix : string;
}

let selector_selector_text_quote_selector =
  Decode.obj (fun o : selector_selector_text_quote_selector ->
      Decode.required o "type" (Decode.literal "TextQuoteSelector");
      {
        exact = Decode.required o "exact" Decode.string;
        prefix = Decode.required o "prefix" Decode.string;
        suffix = Decode.required o "suffix" Decode.string;
      })

type selector_selector_fragment_selector = {
  value : string;
  conforms_to : string;
}

let selector_selector_fragment_selector =
  Decode.obj (fun o : selector_selector_fragment_selector ->
      Decode.required o "type" (Decode.literal "FragmentSelector");
      {
        value = Decode.required o "value" Decode.string;
        conforms_to = Decode.required o "conformsTo" Decode.string;
      })

type selector_selector =
  | Text_quote_selector of selector_selector_text_quote_selector
  | Fragment_selector of selector_selector_fragment_selector

let selector_selector =
  Decode.variant "type"
    [
      ( "TextQuoteSelector",
        fun c ->
          (Text_quote_selector (selector_selector_text_quote_selector c)
            : selector_selector) );
      ( "FragmentSelector",
        fun c ->
          (Fragment_selector (selector_selector_fragment_selector c)
            : selector_selector) );
    ]

type selector = Array of selector_item list | Object of selector_selector

let selector =
 fun c ->
  match Decode.kind c with
  | Decode.Array -> (Array (Decode.list selector_item c) : selector)
  | Decode.Object -> (Object (selector_selector c) : selector)
  | _ -> Decode.refuse c "expected an array or an object"

type target_target = { source : string; selector : selector }

let target_target =
  Decode.obj (fun o : target_target ->
      {
        source = Decode.required o "source" Decode.string;
        selector = Decode.required o "selector" selector;
      })

type target = String of string | Object of target_target

let target =
 fun c ->
  match Decode.kind c with
  | Decode.String -> (String (Decode.string c) : target)
  | Decode.Object -> (Object (target_target c) : target)
  | _ -> Decode.refuse c "expected a string or an object"

type body_item_textual_body = { value : string; purpose : string option }

let body_item_textual_body =
  Decode.obj (fun o : body_item_textual_body ->
      Decode.required o "type" (Decode.literal "TextualBody");
      {
        value = Decode.required o "value" Decode.string;
        purpose = Decode.optional o "purpose" Decode.string;
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
  target : target;
  created : string;
  body : body option;
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
        body = Decode.optional o "body" body;
      })

type target_selector_item_text_position_selector = { start : int; end_ : int }

let target_selector_item_text_position_selector =
  Decode.obj (fun o : target_selector_item_text_position_selector ->
      Decode.required o "type" (Decode.literal "TextPositionSelector");
      {
        start = Decode.required o "start" Decode.int;
        end_ = Decode.required o "end" Decode.int;
      })

type target_selector_item_text_quote_selector = {
  exact : string;
  prefix : string;
  suffix : string;
}

let target_selector_item_text_quote_selector =
  Decode.obj (fun o : target_selector_item_text_quote_selector ->
      Decode.required o "type" (Decode.literal "TextQuoteSelector");
      {
        exact = Decode.required o "exact" Decode.string;
        prefix = Decode.required o "prefix" Decode.string;
        suffix = Decode.required o "suffix" Decode.string;
      })

type target_selector_item =
  | Text_position_selector of target_selector_item_text_position_selector
  | Text_quote_selector of target_selector_item_text_quote_selector

let target_selector_item =
  Decode.variant "type"
    [
      ( "TextPositionSelector",
        fun c ->
          (Text_position_selector
             (target_selector_item_text_position_selector c)
            : target_selector_item) );
      ( "TextQuoteSelector",
        fun c ->
          (Text_quote_selector (target_selector_item_text_quote_selector c)
            : target_selector_item) );
    ]

type target_selector_target_selector_text_quote_selector = {
  exact : string;
  prefix : string;
  suffix : string;
}

let target_selector_target_selector_text_quote_selector =
  Decode.obj (fun o : target_selector_target_selector_text_quote_selector ->
      Decode.required o "type" (Decode.literal "TextQuoteSelector");
      {
        exact = Decode.required o "exact" Decode.string;
        prefix = Decode.required o "prefix" Decode.string;
        suffix = Decode.required o "suffix" Decode.string;
      })

type target_selector_target_selector_fragment_selector = {
  value : string;
  conforms_to : string;
}

let target_selector_target_selector_fragment_selector =
  Decode.obj (fun o : target_selector_target_selector_fragment_selector ->
      Decode.required o "type" (Decode.literal "FragmentSelector");
      {
        value = Decode.required o "value" Decode.string;
        conforms_to = Decode.required o "conformsTo" Decode.string;
      })

type target_selector_target_selector =
  | Text_quote_selector of target_selector_target_selector_text_quote_selector
  | Fragment_selector of target_selector_target_selector_fragment_selector

let target_selector_target_selector =
  Decode.variant "type"
    [
      ( "TextQuoteSelector",
        fun c ->
          (Text_quote_selector
             (target_selector_target_selector_text_quote_selector c)
            : target_selector_target_selector) );
      ( "FragmentSelector",
        fun c ->
          (Fragment_selector
             (target_selector_target_selector_fragment_selector c)
            : target_selector_target_selector) );
    ]

type target_selector =
  | Array of target_selector_item list
  | Object of target_selector_target_selector

let target_selector =
 fun c ->
  match Decode.kind c with
  | Decode.Array ->
      (Array (Decode.list target_selector_item c) : target_selector)
  | Decode.Object ->
      (Object (target_selector_target_selector c) : target_selector)
  | _ -> Decode.refuse c "expected an array or an object"

type text_quote_selector = {
  type_ : string;
  exact : string;
  prefix : string;
  suffix : string;
}

let text_quote_selector =
  Decode.obj (fun o : text_quote_selector ->
      {
        type_ = Decode.required o "type" Decode.string;
        exact = Decode.required o "exact" Decode.string;
        prefix = Decode.required o "prefix" Decode.string;
        suffix = Decode.required o "suffix" Decode.string;
      })

type reads = {
  body_source : string option;
  is_body_resolved : bool;
  is_highlight : bool;
  is_reference : bool;
  is_assessment : bool;
  is_comment : bool;
  is_tag : bool;
  comment_text : string option;
  is_stub_reference : bool;
  is_resolved_reference : bool;
  entity_types : string list;
  tag_category : string option;
  tag_schema_id : string option;
  target_source : string;
  target_selector : target_selector option;
  exact_text : string;
  annotation_exact_text : string;
  text_quote_selector : text_quote_selector option option;
}

let reads =
  Decode.obj (fun o : reads ->
      {
        body_source =
          Decode.required o "bodySource" (Decode.nullable Decode.string);
        is_body_resolved = Decode.required o "isBodyResolved" Decode.bool;
        is_highlight = Decode.required o "isHighlight" Decode.bool;
        is_reference = Decode.required o "isReference" Decode.bool;
        is_assessment = Decode.required o "isAssessment" Decode.bool;
        is_comment = Decode.required o "isComment" Decode.bool;
        is_tag = Decode.required o "isTag" Decode.bool;
        comment_text =
          Decode.required o "commentText" (Decode.nullable Decode.string);
        is_stub_reference = Decode.required o "isStubReference" Decode.bool;
        is_resolved_reference =
          Decode.required o "isResolvedReference" Decode.bool;
        entity_types =
          Decode.required o "entityTypes" (Decode.list Decode.string);
        tag_category =
          Decode.required o "tagCategory" (Decode.nullable Decode.string);
        tag_schema_id =
          Decode.required o "tagSchemaId" (Decode.nullable Decode.string);
        target_source = Decode.required o "targetSource" Decode.string;
        target_selector =
          Decode.required o "targetSelector" (Decode.nullable target_selector);
        exact_text = Decode.required o "exactText" Decode.string;
        annotation_exact_text =
          Decode.required o "annotationExactText" Decode.string;
        text_quote_selector =
          Decode.optional o "textQuoteSelector"
            (Decode.nullable text_quote_selector);
      })

type case = { why : string; annotation : annotation; reads : reads }

let case =
  Decode.obj (fun o : case ->
      {
        why = Decode.required o "why" Decode.string;
        annotation = Decode.required o "annotation" annotation;
        reads = Decode.required o "reads" reads;
      })

type t = { comment : string; readers : string list; cases : case list }

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        readers = Decode.required o "readers" (Decode.list Decode.string);
        cases = Decode.required o "cases" (Decode.list case);
      })
