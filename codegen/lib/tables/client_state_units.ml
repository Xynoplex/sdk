(* specs/src/client/state-units.json *)

type representation = { media_type : string }

let representation =
  Decode.obj (fun o : representation ->
      { media_type = Decode.required o "mediaType" Decode.string })

type resource = {
  context : string;
  id : string;
  name : string;
  representations : representation list;
}

let resource =
  Decode.obj (fun o : resource ->
      {
        context = Decode.required o "@context" Decode.string;
        id = Decode.required o "@id" Decode.string;
        name = Decode.required o "name" Decode.string;
        representations =
          Decode.required o "representations" (Decode.list representation);
      })

type focus = { kind : string; resource : resource }

let focus =
  Decode.obj (fun o : focus ->
      {
        kind = Decode.required o "kind" Decode.string;
        resource = Decode.required o "resource" resource;
      })

type graph = { nodes : Decode.nothing list; edges : Decode.nothing list }

let graph =
  Decode.obj (fun o : graph ->
      {
        nodes = Decode.required o "nodes" (Decode.list Decode.nothing);
        edges = Decode.required o "edges" (Decode.list Decode.nothing);
      })

type context = { focus : focus; graph : graph; metadata : unit }

let context =
  Decode.obj (fun o : context ->
      {
        focus = Decode.required o "focus" focus;
        graph = Decode.required o "graph" graph;
        metadata = Decode.required o "metadata" (Decode.obj (fun _ -> ()));
      })

type generation_context = { fixture : string }

let generation_context =
  Decode.obj (fun o : generation_context ->
      { fixture = Decode.required o "$fixture" Decode.string })

type generation = {
  title : string;
  storage_uri : string;
  context : generation_context;
}

let generation =
  Decode.obj (fun o : generation ->
      {
        title = Decode.required o "title" Decode.string;
        storage_uri = Decode.required o "storageUri" Decode.string;
        context = Decode.required o "context" generation_context;
      })

type fixtures = { context : context; generation : generation }

let fixtures =
  Decode.obj (fun o : fixtures ->
      {
        context = Decode.required o "context" context;
        generation = Decode.required o "generation" generation;
      })

type reply_item = { annotation_id : string option; job_id : string option }

let reply_item =
  Decode.obj (fun o : reply_item ->
      {
        annotation_id = Decode.optional o "annotationId" Decode.string;
        job_id = Decode.optional o "jobId" Decode.string;
      })

type transport = {
  answers : string;
  replies : (string * reply_item list) list option;
  delay_ms : int option;
}

let transport =
  Decode.obj (fun o : transport ->
      {
        answers = Decode.required o "answers" Decode.string;
        replies =
          Decode.optional o "replies" (Decode.map (Decode.list reply_item));
        delay_ms = Decode.optional o "delayMs" Decode.int;
      })

type delay_ms = { timing : string }

let delay_ms =
  Decode.obj (fun o : delay_ms ->
      { timing = Decode.required o "timing" Decode.string })

type made_unit = {
  resource_id : string option;
  delay_ms : delay_ms option;
  debounce_ms : int option;
  initial_query : string option;
  locale : string option;
}

let made_unit =
  Decode.obj (fun o : made_unit ->
      {
        resource_id = Decode.optional o "resourceId" Decode.string;
        delay_ms = Decode.optional o "delayMs" delay_ms;
        debounce_ms = Decode.optional o "debounceMs" Decode.int;
        initial_query = Decode.optional o "initialQuery" Decode.string;
        locale = Decode.optional o "locale" Decode.string;
      })

type first = { resource_id : string }

let first =
  Decode.obj (fun o : first ->
      { resource_id = Decode.required o "resourceId" Decode.string })

type second = { resource_id : string }

let second =
  Decode.obj (fun o : second ->
      { resource_id = Decode.required o "resourceId" Decode.string })

type made = {
  unit : made_unit option;
  first : first option;
  second : second option;
}

let made =
  Decode.obj (fun o : made ->
      {
        unit = Decode.optional o "unit" made_unit;
        first = Decode.optional o "first" first;
        second = Decode.optional o "second" second;
      })

type step_step_nothing_sent = { nothing_sent : bool }

let step_step_nothing_sent =
  Decode.obj (fun o : step_step_nothing_sent ->
      { nothing_sent = Decode.required o "nothingSent" Decode.bool })

type payload_context = { fixture : string }

let payload_context =
  Decode.obj (fun o : payload_context ->
      { fixture = Decode.required o "$fixture" Decode.string })

type progress = { percentage : int }

let progress =
  Decode.obj (fun o : progress ->
      { percentage = Decode.required o "percentage" Decode.int })

type payload_result = {
  resource_id : string;
  resource_name : string;
  truncated : bool;
}

let payload_result =
  Decode.obj (fun o : payload_result ->
      {
        resource_id = Decode.required o "resourceId" Decode.string;
        resource_name = Decode.required o "resourceName" Decode.string;
        truncated = Decode.required o "truncated" Decode.bool;
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

type selector_item_svg_selector = { value : string }

let selector_item_svg_selector =
  Decode.obj (fun o : selector_item_svg_selector ->
      Decode.required o "type" (Decode.literal "SvgSelector");
      { value = Decode.required o "value" Decode.string })

type selector_item_fragment_selector = { value : string; conforms_to : string }

let selector_item_fragment_selector =
  Decode.obj (fun o : selector_item_fragment_selector ->
      Decode.required o "type" (Decode.literal "FragmentSelector");
      {
        value = Decode.required o "value" Decode.string;
        conforms_to = Decode.required o "conformsTo" Decode.string;
      })

type selector_item =
  | Text_position_selector of selector_item_text_position_selector
  | Text_quote_selector of selector_item_text_quote_selector
  | Svg_selector of selector_item_svg_selector
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
      ( "SvgSelector",
        fun c -> (Svg_selector (selector_item_svg_selector c) : selector_item)
      );
      ( "FragmentSelector",
        fun c ->
          (Fragment_selector (selector_item_fragment_selector c)
            : selector_item) );
    ]

type selector_selector = { type_ : string; exact : string }

let selector_selector =
  Decode.obj (fun o : selector_selector ->
      {
        type_ = Decode.required o "type" Decode.string;
        exact = Decode.required o "exact" Decode.string;
      })

type selector = Array of selector_item list | Object of selector_selector

let selector =
 fun c ->
  match Decode.kind c with
  | Decode.Array -> (Array (Decode.list selector_item c) : selector)
  | Decode.Object -> (Object (selector_selector c) : selector)
  | _ -> Decode.refuse c "expected an array or an object"

type body_item = { type_ : string; value : string; purpose : string }

let body_item =
  Decode.obj (fun o : body_item ->
      {
        type_ = Decode.required o "type" Decode.string;
        value = Decode.required o "value" Decode.string;
        purpose = Decode.required o "purpose" Decode.string;
      })

type payload = {
  resource_id : string option;
  reference_id : string option;
  context : payload_context option;
  annotation_id : string option option;
  job_id : string option;
  job_type : string option;
  percentage : int option;
  progress : progress option;
  result : payload_result option;
  error : string option;
  will_retry : bool option;
  source : string option;
  selector : selector option;
  motivation : string option;
  body : body_item list option;
}

let payload =
  Decode.obj (fun o : payload ->
      {
        resource_id = Decode.optional o "resourceId" Decode.string;
        reference_id = Decode.optional o "referenceId" Decode.string;
        context = Decode.optional o "context" payload_context;
        annotation_id =
          Decode.optional o "annotationId" (Decode.nullable Decode.string);
        job_id = Decode.optional o "jobId" Decode.string;
        job_type = Decode.optional o "jobType" Decode.string;
        percentage = Decode.optional o "percentage" Decode.int;
        progress = Decode.optional o "progress" progress;
        result = Decode.optional o "result" payload_result;
        error = Decode.optional o "error" Decode.string;
        will_retry = Decode.optional o "willRetry" Decode.bool;
        source = Decode.optional o "source" Decode.string;
        selector = Decode.optional o "selector" selector;
        motivation = Decode.optional o "motivation" Decode.string;
        body = Decode.optional o "body" (Decode.list body_item);
      })

type step_step_say = {
  say : string;
  correlation_id : string option;
  payload : payload;
}

let step_step_say =
  Decode.obj (fun o : step_step_say ->
      {
        say = Decode.required o "say" Decode.string;
        correlation_id = Decode.optional o "correlationId" Decode.string;
        payload = Decode.required o "payload" payload;
      })

type options = {
  context_window : int;
  include_source_context : bool option;
  include_target_context : bool option;
}

let options =
  Decode.obj (fun o : options ->
      {
        context_window = Decode.required o "contextWindow" Decode.int;
        include_source_context =
          Decode.optional o "includeSourceContext" Decode.bool;
        include_target_context =
          Decode.optional o "includeTargetContext" Decode.bool;
      })

type params_has = { language : string }

let params_has =
  Decode.obj (fun o : params_has ->
      { language = Decode.required o "language" Decode.string })

type params_context = { fixture : string }

let params_context =
  Decode.obj (fun o : params_context ->
      { fixture = Decode.required o "$fixture" Decode.string })

type params = {
  has : params_has option;
  title : string option;
  storage_uri : string option;
  context : params_context option;
  language : string option;
  max_tokens : int option;
  motivation : string option;
  tone : string option;
  entity_types : string list option;
  schema_id : string option;
  categories : string list option;
}

let params =
  Decode.obj (fun o : params ->
      {
        has = Decode.optional o "$has" params_has;
        title = Decode.optional o "title" Decode.string;
        storage_uri = Decode.optional o "storageUri" Decode.string;
        context = Decode.optional o "context" params_context;
        language = Decode.optional o "language" Decode.string;
        max_tokens = Decode.optional o "maxTokens" Decode.int;
        motivation = Decode.optional o "motivation" Decode.string;
        tone = Decode.optional o "tone" Decode.string;
        entity_types =
          Decode.optional o "entityTypes" (Decode.list Decode.string);
        schema_id = Decode.optional o "schemaId" Decode.string;
        categories = Decode.optional o "categories" (Decode.list Decode.string);
      })

type has = {
  reference_id : string option;
  resource_id : string option;
  options : options option;
  job_type : string option;
  params : params option;
}

let has =
  Decode.obj (fun o : has ->
      {
        reference_id = Decode.optional o "referenceId" Decode.string;
        resource_id = Decode.optional o "resourceId" Decode.string;
        options = Decode.optional o "options" options;
        job_type = Decode.optional o "jobType" Decode.string;
        params = Decode.optional o "params" params;
      })

type step_step_sent_payload_options = { context_window : int }

let step_step_sent_payload_options =
  Decode.obj (fun o : step_step_sent_payload_options ->
      { context_window = Decode.required o "contextWindow" Decode.int })

type target_selector = { type_ : string; exact : string }

let target_selector =
  Decode.obj (fun o : target_selector ->
      {
        type_ = Decode.required o "type" Decode.string;
        exact = Decode.required o "exact" Decode.string;
      })

type target = { source : string; selector : target_selector }

let target =
  Decode.obj (fun o : target ->
      {
        source = Decode.required o "source" Decode.string;
        selector = Decode.required o "selector" target_selector;
      })

type request_body_item = { type_ : string; value : string; purpose : string }

let request_body_item =
  Decode.obj (fun o : request_body_item ->
      {
        type_ = Decode.required o "type" Decode.string;
        value = Decode.required o "value" Decode.string;
        purpose = Decode.required o "purpose" Decode.string;
      })

type request = {
  motivation : string;
  target : target;
  body : request_body_item list;
}

let request =
  Decode.obj (fun o : request ->
      {
        motivation = Decode.required o "motivation" Decode.string;
        target = Decode.required o "target" target;
        body = Decode.required o "body" (Decode.list request_body_item);
      })

type step_step_sent_payload_params = {
  motivation : string;
  instructions : string;
  tone : string;
  density : int;
  language : string;
}

let step_step_sent_payload_params =
  Decode.obj (fun o : step_step_sent_payload_params ->
      {
        motivation = Decode.required o "motivation" Decode.string;
        instructions = Decode.required o "instructions" Decode.string;
        tone = Decode.required o "tone" Decode.string;
        density = Decode.required o "density" Decode.int;
        language = Decode.required o "language" Decode.string;
      })

type step_step_sent_payload = {
  has : has option;
  annotation_id : string option;
  resource_id : string option;
  options : step_step_sent_payload_options option;
  request : request option;
  job_type : string option;
  params : step_step_sent_payload_params option;
}

let step_step_sent_payload =
  Decode.obj (fun o : step_step_sent_payload ->
      {
        has = Decode.optional o "$has" has;
        annotation_id = Decode.optional o "annotationId" Decode.string;
        resource_id = Decode.optional o "resourceId" Decode.string;
        options = Decode.optional o "options" step_step_sent_payload_options;
        request = Decode.optional o "request" request;
        job_type = Decode.optional o "jobType" Decode.string;
        params = Decode.optional o "params" step_step_sent_payload_params;
      })

type step_step_sent = {
  sent : string;
  payloads : step_step_sent_payload list option;
  count : int option;
}

let step_step_sent =
  Decode.obj (fun o : step_step_sent ->
      {
        sent = Decode.required o "sent" Decode.string;
        payloads =
          Decode.optional o "payloads" (Decode.list step_step_sent_payload);
        count = Decode.optional o "count" Decode.int;
      })

type response_response = { fixture : string option; job_id : string option }

let response_response =
  Decode.obj (fun o : response_response ->
      {
        fixture = Decode.optional o "$fixture" Decode.string;
        job_id = Decode.optional o "jobId" Decode.string;
      })

type response = Array of Decode.nothing list | Object of response_response

let response =
 fun c ->
  match Decode.kind c with
  | Decode.Array -> (Array (Decode.list Decode.nothing c) : response)
  | Decode.Object -> (Object (response_response c) : response)
  | _ -> Decode.refuse c "expected an array or an object"

type step_step_answer_payload = {
  reference_id : string option;
  response : response option;
  message : string option;
  annotation_id : string option;
  resource_id : string option;
}

let step_step_answer_payload =
  Decode.obj (fun o : step_step_answer_payload ->
      {
        reference_id = Decode.optional o "referenceId" Decode.string;
        response = Decode.optional o "response" response;
        message = Decode.optional o "message" Decode.string;
        annotation_id = Decode.optional o "annotationId" Decode.string;
        resource_id = Decode.optional o "resourceId" Decode.string;
      })

type step_step_answer = {
  answer : string;
  nth : int;
  reply : string;
  payload : step_step_answer_payload;
}

let step_step_answer =
  Decode.obj (fun o : step_step_answer ->
      {
        answer = Decode.required o "answer" Decode.string;
        nth = Decode.required o "nth" Decode.int;
        reply = Decode.required o "reply" Decode.string;
        payload = Decode.required o "payload" step_step_answer_payload;
      })

type correlation_id_correlation_id = { sent : string; nth : int }

let correlation_id_correlation_id =
  Decode.obj (fun o : correlation_id_correlation_id ->
      {
        sent = Decode.required o "sent" Decode.string;
        nth = Decode.required o "nth" Decode.int;
      })

type correlation_id =
  | String of string
  | Object of correlation_id_correlation_id

let correlation_id =
 fun c ->
  match Decode.kind c with
  | Decode.String -> (String (Decode.string c) : correlation_id)
  | Decode.Object -> (Object (correlation_id_correlation_id c) : correlation_id)
  | _ -> Decode.refuse c "expected a string or an object"

type heard_item_payload_has = {
  reference_id : string option;
  resource_id : string option;
}

let heard_item_payload_has =
  Decode.obj (fun o : heard_item_payload_has ->
      {
        reference_id = Decode.optional o "referenceId" Decode.string;
        resource_id = Decode.optional o "resourceId" Decode.string;
      })

type heard_item_payload = {
  reference_id : string option;
  response : Decode.nothing list option;
  message : string option;
  has : heard_item_payload_has option;
  annotation_id : string option option;
  resource_id : string option;
  motivation : string option;
}

let heard_item_payload =
  Decode.obj (fun o : heard_item_payload ->
      {
        reference_id = Decode.optional o "referenceId" Decode.string;
        response = Decode.optional o "response" (Decode.list Decode.nothing);
        message = Decode.optional o "message" Decode.string;
        has = Decode.optional o "$has" heard_item_payload_has;
        annotation_id =
          Decode.optional o "annotationId" (Decode.nullable Decode.string);
        resource_id = Decode.optional o "resourceId" Decode.string;
        motivation = Decode.optional o "motivation" Decode.string;
      })

type heard_item = {
  channel : string;
  correlation_id : correlation_id option;
  payload : heard_item_payload;
}

let heard_item =
  Decode.obj (fun o : heard_item ->
      {
        channel = Decode.required o "channel" Decode.string;
        correlation_id = Decode.optional o "correlationId" correlation_id;
        payload = Decode.required o "payload" heard_item_payload;
      })

type step_step_heard = { heard : heard_item list }

let step_step_heard =
  Decode.obj (fun o : step_step_heard ->
      { heard = Decode.required o "heard" (Decode.list heard_item) })

type pass_pass = { timing : string; plus_ms : int option; times : float option }

let pass_pass =
  Decode.obj (fun o : pass_pass ->
      {
        timing = Decode.required o "timing" Decode.string;
        plus_ms = Decode.optional o "plusMs" Decode.int;
        times = Decode.optional o "times" Decode.number;
      })

type pass = Int of int | Object of pass_pass

let pass =
 fun c ->
  match Decode.kind c with
  | Decode.Int -> (Int (Decode.int c) : pass)
  | Decode.Object -> (Object (pass_pass c) : pass)
  | _ -> Decode.refuse c "expected an integer or an object"

type step_step_pass = { pass : pass }

let step_step_pass =
  Decode.obj (fun o : step_step_pass ->
      { pass = Decode.required o "pass" pass })

type step_step_dispose = { dispose : string }

let step_step_dispose =
  Decode.obj (fun o : step_step_dispose ->
      { dispose = Decode.required o "dispose" Decode.string })

type step_step_bus_destroyed = { bus_destroyed : bool }

let step_step_bus_destroyed =
  Decode.obj (fun o : step_step_bus_destroyed ->
      { bus_destroyed = Decode.required o "busDestroyed" Decode.bool })

type expect_unit_context = { fixture : string }

let expect_unit_context =
  Decode.obj (fun o : expect_unit_context ->
      { fixture = Decode.required o "$fixture" Decode.string })

type error = { message : string option; code : string option }

let error =
  Decode.obj (fun o : error ->
      {
        message = Decode.optional o "message" Decode.string;
        code = Decode.optional o "code" Decode.string;
      })

type resource_context = { fixture : string }

let resource_context =
  Decode.obj (fun o : resource_context ->
      { fixture = Decode.required o "$fixture" Decode.string })

type resource_error = { message : string }

let resource_error =
  Decode.obj (fun o : resource_error ->
      { message = Decode.required o "message" Decode.string })

type state = { results : string list; is_searching : bool }

let state =
  Decode.obj (fun o : state ->
      {
        results = Decode.required o "results" (Decode.list Decode.string);
        is_searching = Decode.required o "isSearching" Decode.bool;
      })

type expect_unit_progress = { percentage : int }

let expect_unit_progress =
  Decode.obj (fun o : expect_unit_progress ->
      { percentage = Decode.required o "percentage" Decode.int })

type outcome = {
  resource_id : string;
  resource_name : string;
  truncated : bool;
}

let outcome =
  Decode.obj (fun o : outcome ->
      {
        resource_id = Decode.required o "resourceId" Decode.string;
        resource_name = Decode.required o "resourceName" Decode.string;
        truncated = Decode.required o "truncated" Decode.bool;
      })

type failure = { code : string; message : string option }

let failure =
  Decode.obj (fun o : failure ->
      {
        code = Decode.required o "code" Decode.string;
        message = Decode.optional o "message" Decode.string;
      })

type pending_annotation_selector_selector_item_text_position_selector = {
  start : int;
  end_ : int;
}

let pending_annotation_selector_selector_item_text_position_selector =
  Decode.obj
    (fun o : pending_annotation_selector_selector_item_text_position_selector ->
      Decode.required o "type" (Decode.literal "TextPositionSelector");
      {
        start = Decode.required o "start" Decode.int;
        end_ = Decode.required o "end" Decode.int;
      })

type pending_annotation_selector_selector_item_text_quote_selector = {
  exact : string;
  prefix : string;
  suffix : string;
}

let pending_annotation_selector_selector_item_text_quote_selector =
  Decode.obj
    (fun o : pending_annotation_selector_selector_item_text_quote_selector ->
      Decode.required o "type" (Decode.literal "TextQuoteSelector");
      {
        exact = Decode.required o "exact" Decode.string;
        prefix = Decode.required o "prefix" Decode.string;
        suffix = Decode.required o "suffix" Decode.string;
      })

type pending_annotation_selector_selector_item_svg_selector = { value : string }

let pending_annotation_selector_selector_item_svg_selector =
  Decode.obj (fun o : pending_annotation_selector_selector_item_svg_selector ->
      Decode.required o "type" (Decode.literal "SvgSelector");
      { value = Decode.required o "value" Decode.string })

type pending_annotation_selector_selector_item_fragment_selector = {
  value : string;
  conforms_to : string;
}

let pending_annotation_selector_selector_item_fragment_selector =
  Decode.obj
    (fun o : pending_annotation_selector_selector_item_fragment_selector ->
      Decode.required o "type" (Decode.literal "FragmentSelector");
      {
        value = Decode.required o "value" Decode.string;
        conforms_to = Decode.required o "conformsTo" Decode.string;
      })

type pending_annotation_selector_selector_item =
  | Text_position_selector of
      pending_annotation_selector_selector_item_text_position_selector
  | Text_quote_selector of
      pending_annotation_selector_selector_item_text_quote_selector
  | Svg_selector of pending_annotation_selector_selector_item_svg_selector
  | Fragment_selector of
      pending_annotation_selector_selector_item_fragment_selector

let pending_annotation_selector_selector_item =
  Decode.variant "type"
    [
      ( "TextPositionSelector",
        fun c ->
          (Text_position_selector
             (pending_annotation_selector_selector_item_text_position_selector c)
            : pending_annotation_selector_selector_item) );
      ( "TextQuoteSelector",
        fun c ->
          (Text_quote_selector
             (pending_annotation_selector_selector_item_text_quote_selector c)
            : pending_annotation_selector_selector_item) );
      ( "SvgSelector",
        fun c ->
          (Svg_selector
             (pending_annotation_selector_selector_item_svg_selector c)
            : pending_annotation_selector_selector_item) );
      ( "FragmentSelector",
        fun c ->
          (Fragment_selector
             (pending_annotation_selector_selector_item_fragment_selector c)
            : pending_annotation_selector_selector_item) );
    ]

type pending_annotation_selector_selector = { type_ : string; exact : string }

let pending_annotation_selector_selector =
  Decode.obj (fun o : pending_annotation_selector_selector ->
      {
        type_ = Decode.required o "type" Decode.string;
        exact = Decode.required o "exact" Decode.string;
      })

type pending_annotation_selector =
  | Array of pending_annotation_selector_selector_item list
  | Object of pending_annotation_selector_selector

let pending_annotation_selector =
 fun c ->
  match Decode.kind c with
  | Decode.Array ->
      (Array (Decode.list pending_annotation_selector_selector_item c)
        : pending_annotation_selector)
  | Decode.Object ->
      (Object (pending_annotation_selector_selector c)
        : pending_annotation_selector)
  | _ -> Decode.refuse c "expected an array or an object"

type pending_annotation = {
  selector : pending_annotation_selector;
  motivation : string;
}

let pending_annotation =
  Decode.obj (fun o : pending_annotation ->
      {
        selector = Decode.required o "selector" pending_annotation_selector;
        motivation = Decode.required o "motivation" Decode.string;
      })

type session_ended = { reason : string }

let session_ended =
  Decode.obj (fun o : session_ended ->
      { reason = Decode.required o "reason" Decode.string })

type permission_denied = { detail : string option }

let permission_denied =
  Decode.obj (fun o : permission_denied ->
      { detail = Decode.required o "detail" (Decode.nullable Decode.string) })

type kb_identity_conflict = { expected_did : string; observed_did : string }

let kb_identity_conflict =
  Decode.obj (fun o : kb_identity_conflict ->
      {
        expected_did = Decode.required o "expectedDid" Decode.string;
        observed_did = Decode.required o "observedDid" Decode.string;
      })

type expect_unit = {
  hovered_annotation_id : string option option;
  context : expect_unit_context option option;
  loading : bool option;
  error : error option option;
  annotation_id : string option option;
  resource_context : resource_context option option;
  resource_loading : bool option;
  resource_error : resource_error option option;
  query : string option;
  state : state option;
  is_generating : bool option;
  progress : expect_unit_progress option option;
  outcome : outcome option option;
  job_id : string option option;
  failure : failure option option;
  pending_annotation : pending_annotation option option;
  delegating_motivation : string option option;
  progress_motivation : string option option;
  session_ended : session_ended option option;
  permission_denied : permission_denied option option;
  kb_identity_conflict : kb_identity_conflict option option;
}

let expect_unit =
  Decode.obj (fun o : expect_unit ->
      {
        hovered_annotation_id =
          Decode.optional o "hoveredAnnotationId"
            (Decode.nullable Decode.string);
        context =
          Decode.optional o "context" (Decode.nullable expect_unit_context);
        loading = Decode.optional o "loading" Decode.bool;
        error = Decode.optional o "error" (Decode.nullable error);
        annotation_id =
          Decode.optional o "annotationId" (Decode.nullable Decode.string);
        resource_context =
          Decode.optional o "resourceContext" (Decode.nullable resource_context);
        resource_loading = Decode.optional o "resourceLoading" Decode.bool;
        resource_error =
          Decode.optional o "resourceError" (Decode.nullable resource_error);
        query = Decode.optional o "query" Decode.string;
        state = Decode.optional o "state" state;
        is_generating = Decode.optional o "isGenerating" Decode.bool;
        progress =
          Decode.optional o "progress" (Decode.nullable expect_unit_progress);
        outcome = Decode.optional o "outcome" (Decode.nullable outcome);
        job_id = Decode.optional o "jobId" (Decode.nullable Decode.string);
        failure = Decode.optional o "failure" (Decode.nullable failure);
        pending_annotation =
          Decode.optional o "pendingAnnotation"
            (Decode.nullable pending_annotation);
        delegating_motivation =
          Decode.optional o "delegatingMotivation"
            (Decode.nullable Decode.string);
        progress_motivation =
          Decode.optional o "progressMotivation" (Decode.nullable Decode.string);
        session_ended =
          Decode.optional o "sessionEnded" (Decode.nullable session_ended);
        permission_denied =
          Decode.optional o "permissionDenied"
            (Decode.nullable permission_denied);
        kb_identity_conflict =
          Decode.optional o "kbIdentityConflict"
            (Decode.nullable kb_identity_conflict);
      })

type expect_first_pending_annotation_selector = {
  type_ : string;
  exact : string;
}

let expect_first_pending_annotation_selector =
  Decode.obj (fun o : expect_first_pending_annotation_selector ->
      {
        type_ = Decode.required o "type" Decode.string;
        exact = Decode.required o "exact" Decode.string;
      })

type expect_first_pending_annotation = {
  selector : expect_first_pending_annotation_selector;
  motivation : string;
}

let expect_first_pending_annotation =
  Decode.obj (fun o : expect_first_pending_annotation ->
      {
        selector =
          Decode.required o "selector" expect_first_pending_annotation_selector;
        motivation = Decode.required o "motivation" Decode.string;
      })

type expect_first = {
  pending_annotation : expect_first_pending_annotation option;
  delegating_motivation : string option;
  progress_motivation : string option;
}

let expect_first =
  Decode.obj (fun o : expect_first ->
      {
        pending_annotation =
          Decode.optional o "pendingAnnotation" expect_first_pending_annotation;
        delegating_motivation =
          Decode.optional o "delegatingMotivation" Decode.string;
        progress_motivation =
          Decode.optional o "progressMotivation" Decode.string;
      })

type expect_second = {
  pending_annotation : unit option;
  delegating_motivation : unit option;
  progress_motivation : unit option;
}

let expect_second =
  Decode.obj (fun o : expect_second ->
      {
        pending_annotation = Decode.optional o "pendingAnnotation" Decode.null;
        delegating_motivation =
          Decode.optional o "delegatingMotivation" Decode.null;
        progress_motivation = Decode.optional o "progressMotivation" Decode.null;
      })

type expect = {
  unit : expect_unit option;
  first : expect_first option;
  second : expect_second option;
}

let expect =
  Decode.obj (fun o : expect ->
      {
        unit = Decode.optional o "unit" expect_unit;
        first = Decode.optional o "first" expect_first;
        second = Decode.optional o "second" expect_second;
      })

type step_step_expect = { expect : expect }

let step_step_expect =
  Decode.obj (fun o : step_step_expect ->
      { expect = Decode.required o "expect" expect })

type step_step_deliver_payload_response = { annotation_id : string }

let step_step_deliver_payload_response =
  Decode.obj (fun o : step_step_deliver_payload_response ->
      { annotation_id = Decode.required o "annotationId" Decode.string })

type step_step_deliver_payload = {
  annotation_id : string option;
  response : step_step_deliver_payload_response option;
  resource_id : string option;
  job_id : string option;
  job_type : string option;
}

let step_step_deliver_payload =
  Decode.obj (fun o : step_step_deliver_payload ->
      {
        annotation_id = Decode.optional o "annotationId" Decode.string;
        response =
          Decode.optional o "response" step_step_deliver_payload_response;
        resource_id = Decode.optional o "resourceId" Decode.string;
        job_id = Decode.optional o "jobId" Decode.string;
        job_type = Decode.optional o "jobType" Decode.string;
      })

type step_step_deliver = {
  deliver : string;
  payload : step_step_deliver_payload;
  correlation_id : string option;
}

let step_step_deliver =
  Decode.obj (fun o : step_step_deliver ->
      {
        deliver = Decode.required o "deliver" Decode.string;
        payload = Decode.required o "payload" step_step_deliver_payload;
        correlation_id = Decode.optional o "correlationId" Decode.string;
      })

type args_params_context = { fixture : string }

let args_params_context =
  Decode.obj (fun o : args_params_context ->
      { fixture = Decode.required o "$fixture" Decode.string })

type args_params = {
  fixture : string option;
  title : string option;
  storage_uri : string option;
  context : args_params_context option;
  language : string option;
  max_tokens : int option;
  motivation : string option;
  instructions : string option;
  tone : string option;
  density : int option;
  entity_types : string list option;
  schema_id : string option;
  categories : string list option;
}

let args_params =
  Decode.obj (fun o : args_params ->
      {
        fixture = Decode.optional o "$fixture" Decode.string;
        title = Decode.optional o "title" Decode.string;
        storage_uri = Decode.optional o "storageUri" Decode.string;
        context = Decode.optional o "context" args_params_context;
        language = Decode.optional o "language" Decode.string;
        max_tokens = Decode.optional o "maxTokens" Decode.int;
        motivation = Decode.optional o "motivation" Decode.string;
        instructions = Decode.optional o "instructions" Decode.string;
        tone = Decode.optional o "tone" Decode.string;
        density = Decode.optional o "density" Decode.int;
        entity_types =
          Decode.optional o "entityTypes" (Decode.list Decode.string);
        schema_id = Decode.optional o "schemaId" Decode.string;
        categories = Decode.optional o "categories" (Decode.list Decode.string);
      })

type conflict = { expected_did : string; observed_did : string }

let conflict =
  Decode.obj (fun o : conflict ->
      {
        expected_did = Decode.required o "expectedDid" Decode.string;
        observed_did = Decode.required o "observedDid" Decode.string;
      })

type args = {
  annotation_id : string option;
  context_window : int option;
  include_source_context : bool option;
  include_target_context : bool option;
  resource_id : string option;
  value : string option;
  params : args_params option;
  stall_deadline_ms : int option;
  reason : string option;
  detail : string option option;
  conflict : conflict option;
}

let args =
  Decode.obj (fun o : args ->
      {
        annotation_id = Decode.optional o "annotationId" Decode.string;
        context_window = Decode.optional o "contextWindow" Decode.int;
        include_source_context =
          Decode.optional o "includeSourceContext" Decode.bool;
        include_target_context =
          Decode.optional o "includeTargetContext" Decode.bool;
        resource_id = Decode.optional o "resourceId" Decode.string;
        value = Decode.optional o "value" Decode.string;
        params = Decode.optional o "params" args_params;
        stall_deadline_ms = Decode.optional o "stallDeadlineMs" Decode.int;
        reason = Decode.optional o "reason" Decode.string;
        detail = Decode.optional o "detail" (Decode.nullable Decode.string);
        conflict = Decode.optional o "conflict" conflict;
      })

type step_step_invoke = { invoke : string; of_ : string; args : args }

let step_step_invoke =
  Decode.obj (fun o : step_step_invoke ->
      {
        invoke = Decode.required o "invoke" Decode.string;
        of_ = Decode.required o "of" Decode.string;
        args = Decode.required o "args" args;
      })

type ended = { unit : string list }

let ended =
  Decode.obj (fun o : ended ->
      { unit = Decode.required o "unit" (Decode.list Decode.string) })

type step_step_ended = { ended : ended }

let step_step_ended =
  Decode.obj (fun o : step_step_ended ->
      { ended = Decode.required o "ended" ended })

type step_step_searched = { searched : string list }

let step_step_searched =
  Decode.obj (fun o : step_step_searched ->
      { searched = Decode.required o "searched" (Decode.list Decode.string) })

type step_step_answer_search = {
  answer_search : int;
  results : string list option;
}

let step_step_answer_search =
  Decode.obj (fun o : step_step_answer_search ->
      {
        answer_search = Decode.required o "answerSearch" Decode.int;
        results =
          Decode.required o "results"
            (Decode.nullable (Decode.list Decode.string));
      })

type step_step_queue_reply_response = {
  job_id : string;
  type_ : string;
  status : string;
  user_id : string;
  created : string;
}

let step_step_queue_reply_response =
  Decode.obj (fun o : step_step_queue_reply_response ->
      {
        job_id = Decode.required o "jobId" Decode.string;
        type_ = Decode.required o "type" Decode.string;
        status = Decode.required o "status" Decode.string;
        user_id = Decode.required o "userId" Decode.string;
        created = Decode.required o "created" Decode.string;
      })

type step_step_queue_reply = {
  queue_reply : string;
  response : step_step_queue_reply_response;
}

let step_step_queue_reply =
  Decode.obj (fun o : step_step_queue_reply ->
      {
        queue_reply = Decode.required o "queueReply" Decode.string;
        response = Decode.required o "response" step_step_queue_reply_response;
      })

type step_step =
  | Nothing_sent of step_step_nothing_sent
  | Say of step_step_say
  | Sent of step_step_sent
  | Answer of step_step_answer
  | Heard of step_step_heard
  | Pass of step_step_pass
  | Dispose of step_step_dispose
  | Bus_destroyed of step_step_bus_destroyed
  | Expect of step_step_expect
  | Deliver of step_step_deliver
  | Invoke of step_step_invoke
  | Ended of step_step_ended
  | Searched of step_step_searched
  | Answer_search of step_step_answer_search
  | Queue_reply of step_step_queue_reply

let step_step =
  Decode.keyed
    [
      ( "nothingSent",
        fun c -> (Nothing_sent (step_step_nothing_sent c) : step_step) );
      ("say", fun c -> (Say (step_step_say c) : step_step));
      ("sent", fun c -> (Sent (step_step_sent c) : step_step));
      ("answer", fun c -> (Answer (step_step_answer c) : step_step));
      ("heard", fun c -> (Heard (step_step_heard c) : step_step));
      ("pass", fun c -> (Pass (step_step_pass c) : step_step));
      ("dispose", fun c -> (Dispose (step_step_dispose c) : step_step));
      ( "busDestroyed",
        fun c -> (Bus_destroyed (step_step_bus_destroyed c) : step_step) );
      ("expect", fun c -> (Expect (step_step_expect c) : step_step));
      ("deliver", fun c -> (Deliver (step_step_deliver c) : step_step));
      ("invoke", fun c -> (Invoke (step_step_invoke c) : step_step));
      ("ended", fun c -> (Ended (step_step_ended c) : step_step));
      ("searched", fun c -> (Searched (step_step_searched c) : step_step));
      ( "answerSearch",
        fun c -> (Answer_search (step_step_answer_search c) : step_step) );
      ( "queueReply",
        fun c -> (Queue_reply (step_step_queue_reply c) : step_step) );
    ]

type step = String of string | Object of step_step

let step =
 fun c ->
  match Decode.kind c with
  | Decode.String -> (String (Decode.string c) : step)
  | Decode.Object -> (Object (step_step c) : step)
  | _ -> Decode.refuse c "expected a string or an object"

type case = {
  unit : string;
  case : string;
  transport : transport;
  made : made;
  listen : string list option;
  steps : step list;
}

let case =
  Decode.obj (fun o : case ->
      {
        unit = Decode.required o "unit" Decode.string;
        case = Decode.required o "case" Decode.string;
        transport = Decode.required o "transport" transport;
        made = Decode.required o "made" made;
        listen = Decode.optional o "listen" (Decode.list Decode.string);
        steps = Decode.required o "steps" (Decode.list step);
      })

type t = {
  comment : string;
  notices : (string * Schema.t) list;
  fixtures : fixtures;
  cases : case list;
}

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        notices = Decode.required o "notices" (Decode.map Schema.decode);
        fixtures = Decode.required o "fixtures" fixtures;
        cases = Decode.required o "cases" (Decode.list case);
      })
