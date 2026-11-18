(* specs/src/client/surface.json *)

type shapes = {
  promise : string;
  stream : string;
  delegation : string;
  upload : string;
  cache : string;
  signal : string;
  count : string;
  events : string;
  claims : string;
}

let shapes =
  Decode.obj (fun o : shapes ->
      {
        promise = Decode.required o "promise" Decode.string;
        stream = Decode.required o "stream" Decode.string;
        delegation = Decode.required o "delegation" Decode.string;
        upload = Decode.required o "upload" Decode.string;
        cache = Decode.required o "cache" Decode.string;
        signal = Decode.required o "signal" Decode.string;
        count = Decode.required o "count" Decode.string;
        events = Decode.required o "events" Decode.string;
        claims = Decode.required o "claims" Decode.string;
      })

type via = {
  request : string;
  emit : string;
  local : string;
  content : string;
  gateway : string;
  observes : string;
}

let via =
  Decode.obj (fun o : via ->
      {
        request = Decode.required o "request" Decode.string;
        emit = Decode.required o "emit" Decode.string;
        local = Decode.required o "local" Decode.string;
        content = Decode.required o "content" Decode.string;
        gateway = Decode.required o "gateway" Decode.string;
        observes = Decode.required o "observes" Decode.string;
      })

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

type selector = { type_ : string; exact : string }

let selector =
  Decode.obj (fun o : selector ->
      {
        type_ = Decode.required o "type" Decode.string;
        exact = Decode.required o "exact" Decode.string;
      })

type fixtures = { context : context; selector : selector }

let fixtures =
  Decode.obj (fun o : fixtures ->
      {
        context = Decode.required o "context" context;
        selector = Decode.required o "selector" selector;
      })

type method__via = {
  request : string option;
  content : string option;
  local : string option;
  emit : string option;
  observes : string option;
  gateway : string option;
}

let method__via =
  Decode.obj (fun o : method__via ->
      {
        request = Decode.optional o "request" Decode.string;
        content = Decode.optional o "content" Decode.string;
        local = Decode.optional o "local" Decode.string;
        emit = Decode.optional o "emit" Decode.string;
        observes = Decode.optional o "observes" Decode.string;
        gateway = Decode.optional o "gateway" Decode.string;
      })

type schema = {
  id : string;
  name : string;
  description : string;
  domain : string;
  tags : Decode.nothing list;
}

let schema =
  Decode.obj (fun o : schema ->
      {
        id = Decode.required o "id" Decode.string;
        name = Decode.required o "name" Decode.string;
        description = Decode.required o "description" Decode.string;
        domain = Decode.required o "domain" Decode.string;
        tags = Decode.required o "tags" (Decode.list Decode.nothing);
      })

type filters = {
  archived : bool option;
  entity_type : string option;
  limit : int;
  offset : int option;
}

let filters =
  Decode.obj (fun o : filters ->
      {
        archived = Decode.optional o "archived" Decode.bool;
        entity_type = Decode.optional o "entityType" Decode.string;
        limit = Decode.required o "limit" Decode.int;
        offset = Decode.optional o "offset" Decode.int;
      })

type target = { source : string }

let target =
  Decode.obj (fun o : target ->
      { source = Decode.required o "source" Decode.string })

type input_selector = { fixture : string }

let input_selector =
  Decode.obj (fun o : input_selector ->
      { fixture = Decode.required o "$fixture" Decode.string })

type input_context = { fixture : string }

let input_context =
  Decode.obj (fun o : input_context ->
      { fixture = Decode.required o "$fixture" Decode.string })

type input = {
  motivation : string option;
  target : target option;
  source : string option;
  selector : input_selector option;
  resource_id : string option;
  message : string option;
  annotation_id : string option;
  default_title : string option;
  entity_types : string list option;
  reference_id : string option;
  context : input_context option;
}

let input =
  Decode.obj (fun o : input ->
      {
        motivation = Decode.optional o "motivation" Decode.string;
        target = Decode.optional o "target" target;
        source = Decode.optional o "source" Decode.string;
        selector = Decode.optional o "selector" input_selector;
        resource_id = Decode.optional o "resourceId" Decode.string;
        message = Decode.optional o "message" Decode.string;
        annotation_id = Decode.optional o "annotationId" Decode.string;
        default_title = Decode.optional o "defaultTitle" Decode.string;
        entity_types =
          Decode.optional o "entityTypes" (Decode.list Decode.string);
        reference_id = Decode.optional o "referenceId" Decode.string;
        context = Decode.optional o "context" input_context;
      })

type params_context = { fixture : string }

let params_context =
  Decode.obj (fun o : params_context ->
      { fixture = Decode.required o "$fixture" Decode.string })

type params = {
  motivation : string option;
  entity_types : string list option;
  include_descriptive_references : bool option;
  schema_id : string option;
  categories : string list option;
  language : string option;
  source_language : string option;
  instructions : string option;
  tone : string option;
  density : float option;
  title : string option;
  storage_uri : string option;
  context : params_context option;
  prompt : string option;
  max_tokens : int option;
}

let params =
  Decode.obj (fun o : params ->
      {
        motivation = Decode.optional o "motivation" Decode.string;
        entity_types =
          Decode.optional o "entityTypes" (Decode.list Decode.string);
        include_descriptive_references =
          Decode.optional o "includeDescriptiveReferences" Decode.bool;
        schema_id = Decode.optional o "schemaId" Decode.string;
        categories = Decode.optional o "categories" (Decode.list Decode.string);
        language = Decode.optional o "language" Decode.string;
        source_language = Decode.optional o "sourceLanguage" Decode.string;
        instructions = Decode.optional o "instructions" Decode.string;
        tone = Decode.optional o "tone" Decode.string;
        density = Decode.optional o "density" Decode.number;
        title = Decode.optional o "title" Decode.string;
        storage_uri = Decode.optional o "storageUri" Decode.string;
        context = Decode.optional o "context" params_context;
        prompt = Decode.optional o "prompt" Decode.string;
        max_tokens = Decode.optional o "maxTokens" Decode.int;
      })

type args_selector = { fixture : string }

let args_selector =
  Decode.obj (fun o : args_selector ->
      { fixture = Decode.required o "$fixture" Decode.string })

type operation = { op : string }

let operation =
  Decode.obj (fun o : operation ->
      { op = Decode.required o "op" Decode.string })

type accept_params = { motivation : string }

let accept_params =
  Decode.obj (fun o : accept_params ->
      { motivation = Decode.required o "motivation" Decode.string })

type accept = { job_type : string; params : accept_params option }

let accept =
  Decode.obj (fun o : accept ->
      {
        job_type = Decode.required o "jobType" Decode.string;
        params = Decode.optional o "params" accept_params;
      })

type options = {
  context_window : int option;
  include_source_context : bool option;
  include_target_context : bool option;
  depth : int option;
  max_resources : int option;
  include_content : bool option;
  include_summary : bool option;
  exclude_entity_types : string list option;
  limit : int option;
  use_semantic_scoring : bool option;
  token : string option;
  name : string option;
  content : string option;
  accepts : accept list option;
}

let options =
  Decode.obj (fun o : options ->
      {
        context_window = Decode.optional o "contextWindow" Decode.int;
        include_source_context =
          Decode.optional o "includeSourceContext" Decode.bool;
        include_target_context =
          Decode.optional o "includeTargetContext" Decode.bool;
        depth = Decode.optional o "depth" Decode.int;
        max_resources = Decode.optional o "maxResources" Decode.int;
        include_content = Decode.optional o "includeContent" Decode.bool;
        include_summary = Decode.optional o "includeSummary" Decode.bool;
        exclude_entity_types =
          Decode.optional o "excludeEntityTypes" (Decode.list Decode.string);
        limit = Decode.optional o "limit" Decode.int;
        use_semantic_scoring =
          Decode.optional o "useSemanticScoring" Decode.bool;
        token = Decode.optional o "token" Decode.string;
        name = Decode.optional o "name" Decode.string;
        content = Decode.optional o "content" Decode.string;
        accepts = Decode.optional o "accepts" (Decode.list accept);
      })

type args_context = { fixture : string }

let args_context =
  Decode.obj (fun o : args_context ->
      { fixture = Decode.required o "$fixture" Decode.string })

type data = {
  name : string;
  content : string;
  format : string;
  storage_uri : string;
}

let data =
  Decode.obj (fun o : data ->
      {
        name = Decode.required o "name" Decode.string;
        content = Decode.required o "content" Decode.string;
        format = Decode.required o "format" Decode.string;
        storage_uri = Decode.required o "storageUri" Decode.string;
      })

type args = {
  type_ : string option;
  types : string list option;
  schema : schema option;
  resource_id : string option;
  filters : filters option;
  annotation_id : string option option;
  dir_path : string option;
  sort : string option;
  input : input option;
  current : string list option;
  updated : string list option;
  params : params option;
  source : string option;
  selector : args_selector option;
  motivation : string option;
  operations : operation list option;
  options : options option;
  reference_id : string option;
  context : args_context option;
  correlation_id : string option;
  search : string option;
  data : data option;
  stall_deadline_ms : int option;
  token : string option;
  job_id : string option;
}

let args =
  Decode.obj (fun o : args ->
      {
        type_ = Decode.optional o "type" Decode.string;
        types = Decode.optional o "types" (Decode.list Decode.string);
        schema = Decode.optional o "schema" schema;
        resource_id = Decode.optional o "resourceId" Decode.string;
        filters = Decode.optional o "filters" filters;
        annotation_id =
          Decode.optional o "annotationId" (Decode.nullable Decode.string);
        dir_path = Decode.optional o "dirPath" Decode.string;
        sort = Decode.optional o "sort" Decode.string;
        input = Decode.optional o "input" input;
        current = Decode.optional o "current" (Decode.list Decode.string);
        updated = Decode.optional o "updated" (Decode.list Decode.string);
        params = Decode.optional o "params" params;
        source = Decode.optional o "source" Decode.string;
        selector = Decode.optional o "selector" args_selector;
        motivation = Decode.optional o "motivation" Decode.string;
        operations = Decode.optional o "operations" (Decode.list operation);
        options = Decode.optional o "options" options;
        reference_id = Decode.optional o "referenceId" Decode.string;
        context = Decode.optional o "context" args_context;
        correlation_id = Decode.optional o "correlationId" Decode.string;
        search = Decode.optional o "search" Decode.string;
        data = Decode.optional o "data" data;
        stall_deadline_ms = Decode.optional o "stallDeadlineMs" Decode.int;
        token = Decode.optional o "token" Decode.string;
        job_id = Decode.optional o "jobId" Decode.string;
      })

type sends_schema = {
  id : string;
  name : string;
  description : string;
  domain : string;
  tags : Decode.nothing list;
}

let sends_schema =
  Decode.obj (fun o : sends_schema ->
      {
        id = Decode.required o "id" Decode.string;
        name = Decode.required o "name" Decode.string;
        description = Decode.required o "description" Decode.string;
        domain = Decode.required o "domain" Decode.string;
        tags = Decode.required o "tags" (Decode.list Decode.nothing);
      })

type request_target = { source : string }

let request_target =
  Decode.obj (fun o : request_target ->
      { source = Decode.required o "source" Decode.string })

type request = { motivation : string; target : request_target }

let request =
  Decode.obj (fun o : request ->
      {
        motivation = Decode.required o "motivation" Decode.string;
        target = Decode.required o "target" request_target;
      })

type sends_params_context = { fixture : string }

let sends_params_context =
  Decode.obj (fun o : sends_params_context ->
      { fixture = Decode.required o "$fixture" Decode.string })

type sends_params = {
  motivation : string option;
  entity_types : string list option;
  include_descriptive_references : bool option;
  schema_id : string option;
  categories : string list option;
  language : string option;
  source_language : string option;
  instructions : string option;
  tone : string option;
  density : float option;
  title : string option;
  storage_uri : string option;
  context : sends_params_context option;
  prompt : string option;
  max_tokens : int option;
}

let sends_params =
  Decode.obj (fun o : sends_params ->
      {
        motivation = Decode.optional o "motivation" Decode.string;
        entity_types =
          Decode.optional o "entityTypes" (Decode.list Decode.string);
        include_descriptive_references =
          Decode.optional o "includeDescriptiveReferences" Decode.bool;
        schema_id = Decode.optional o "schemaId" Decode.string;
        categories = Decode.optional o "categories" (Decode.list Decode.string);
        language = Decode.optional o "language" Decode.string;
        source_language = Decode.optional o "sourceLanguage" Decode.string;
        instructions = Decode.optional o "instructions" Decode.string;
        tone = Decode.optional o "tone" Decode.string;
        density = Decode.optional o "density" Decode.number;
        title = Decode.optional o "title" Decode.string;
        storage_uri = Decode.optional o "storageUri" Decode.string;
        context = Decode.optional o "context" sends_params_context;
        prompt = Decode.optional o "prompt" Decode.string;
        max_tokens = Decode.optional o "maxTokens" Decode.int;
      })

type sends_selector = { fixture : string }

let sends_selector =
  Decode.obj (fun o : sends_selector ->
      { fixture = Decode.required o "$fixture" Decode.string })

type sends_operation = { op : string }

let sends_operation =
  Decode.obj (fun o : sends_operation ->
      { op = Decode.required o "op" Decode.string })

type sends_options = {
  context_window : int option;
  include_source_context : bool option;
  include_target_context : bool option;
  depth : int option;
  max_resources : int option;
  include_content : bool option;
  include_summary : bool option;
  exclude_entity_types : string list option;
}

let sends_options =
  Decode.obj (fun o : sends_options ->
      {
        context_window = Decode.optional o "contextWindow" Decode.int;
        include_source_context =
          Decode.optional o "includeSourceContext" Decode.bool;
        include_target_context =
          Decode.optional o "includeTargetContext" Decode.bool;
        depth = Decode.optional o "depth" Decode.int;
        max_resources = Decode.optional o "maxResources" Decode.int;
        include_content = Decode.optional o "includeContent" Decode.bool;
        include_summary = Decode.optional o "includeSummary" Decode.bool;
        exclude_entity_types =
          Decode.optional o "excludeEntityTypes" (Decode.list Decode.string);
      })

type sends_context = { fixture : string }

let sends_context =
  Decode.obj (fun o : sends_context ->
      { fixture = Decode.required o "$fixture" Decode.string })

type sends_accept_params = { motivation : string }

let sends_accept_params =
  Decode.obj (fun o : sends_accept_params ->
      { motivation = Decode.required o "motivation" Decode.string })

type sends_accept = { job_type : string; params : sends_accept_params option }

let sends_accept =
  Decode.obj (fun o : sends_accept ->
      {
        job_type = Decode.required o "jobType" Decode.string;
        params = Decode.optional o "params" sends_accept_params;
      })

type sends = {
  tag : string option;
  schema : sends_schema option;
  resource_id : string option;
  limit : int option;
  offset : int option;
  archived : bool option;
  entity_type : string option;
  annotation_id : string option option;
  path : string option;
  sort : string option;
  request : request option;
  current_entity_types : string list option;
  updated_entity_types : string list option;
  job_type : string option;
  params : sends_params option;
  source : string option;
  selector : sends_selector option;
  motivation : string option;
  message : string option;
  operations : sends_operation list option;
  default_title : string option;
  entity_types : string list option;
  options : sends_options option;
  reference_id : string option;
  context : sends_context option;
  use_semantic_scoring : bool option;
  search : string option;
  name : string option;
  content : string option;
  format : string option;
  storage_uri : string option;
  token : string option;
  job_id : string option;
  user_id : string option;
  percentage : float option;
  error : string option;
  accepts : sends_accept list option;
}

let sends =
  Decode.obj (fun o : sends ->
      {
        tag = Decode.optional o "tag" Decode.string;
        schema = Decode.optional o "schema" sends_schema;
        resource_id = Decode.optional o "resourceId" Decode.string;
        limit = Decode.optional o "limit" Decode.int;
        offset = Decode.optional o "offset" Decode.int;
        archived = Decode.optional o "archived" Decode.bool;
        entity_type = Decode.optional o "entityType" Decode.string;
        annotation_id =
          Decode.optional o "annotationId" (Decode.nullable Decode.string);
        path = Decode.optional o "path" Decode.string;
        sort = Decode.optional o "sort" Decode.string;
        request = Decode.optional o "request" request;
        current_entity_types =
          Decode.optional o "currentEntityTypes" (Decode.list Decode.string);
        updated_entity_types =
          Decode.optional o "updatedEntityTypes" (Decode.list Decode.string);
        job_type = Decode.optional o "jobType" Decode.string;
        params = Decode.optional o "params" sends_params;
        source = Decode.optional o "source" Decode.string;
        selector = Decode.optional o "selector" sends_selector;
        motivation = Decode.optional o "motivation" Decode.string;
        message = Decode.optional o "message" Decode.string;
        operations =
          Decode.optional o "operations" (Decode.list sends_operation);
        default_title = Decode.optional o "defaultTitle" Decode.string;
        entity_types =
          Decode.optional o "entityTypes" (Decode.list Decode.string);
        options = Decode.optional o "options" sends_options;
        reference_id = Decode.optional o "referenceId" Decode.string;
        context = Decode.optional o "context" sends_context;
        use_semantic_scoring =
          Decode.optional o "useSemanticScoring" Decode.bool;
        search = Decode.optional o "search" Decode.string;
        name = Decode.optional o "name" Decode.string;
        content = Decode.optional o "content" Decode.string;
        format = Decode.optional o "format" Decode.string;
        storage_uri = Decode.optional o "storageUri" Decode.string;
        token = Decode.optional o "token" Decode.string;
        job_id = Decode.optional o "jobId" Decode.string;
        user_id = Decode.optional o "userId" Decode.string;
        percentage = Decode.optional o "percentage" Decode.number;
        error = Decode.optional o "error" Decode.string;
        accepts = Decode.optional o "accepts" (Decode.list sends_accept);
      })

type source_resource_representation = { media_type : string }

let source_resource_representation =
  Decode.obj (fun o : source_resource_representation ->
      { media_type = Decode.required o "mediaType" Decode.string })

type source_resource = {
  context : string;
  id : string;
  name : string;
  representations : source_resource_representation list;
}

let source_resource =
  Decode.obj (fun o : source_resource ->
      {
        context = Decode.required o "@context" Decode.string;
        id = Decode.required o "@id" Decode.string;
        name = Decode.required o "name" Decode.string;
        representations =
          Decode.required o "representations"
            (Decode.list source_resource_representation);
      })

type answers = { source_resource : source_resource; expires_at : string }

let answers =
  Decode.obj (fun o : answers ->
      {
        source_resource = Decode.required o "sourceResource" source_resource;
        expires_at = Decode.required o "expiresAt" Decode.string;
      })

type then_item_sends = {
  tag : string option;
  name : string option;
  content : string option;
  format : string option;
  storage_uri : string option;
  clone_token : string option;
}

let then_item_sends =
  Decode.obj (fun o : then_item_sends ->
      {
        tag = Decode.optional o "tag" Decode.string;
        name = Decode.optional o "name" Decode.string;
        content = Decode.optional o "content" Decode.string;
        format = Decode.optional o "format" Decode.string;
        storage_uri = Decode.optional o "storageUri" Decode.string;
        clone_token = Decode.optional o "cloneToken" Decode.string;
      })

type then_item = {
  request : string option;
  sends : then_item_sends;
  content : string option;
}

let then_item =
  Decode.obj (fun o : then_item ->
      {
        request = Decode.optional o "request" Decode.string;
        sends = Decode.required o "sends" then_item_sends;
        content = Decode.optional o "content" Decode.string;
      })

type case = {
  args : args;
  sends : sends;
  why : string option;
  answers : answers option option;
  then_ : then_item list option;
  correlation_id : string option;
}

let case =
  Decode.obj (fun o : case ->
      {
        args = Decode.required o "args" args;
        sends = Decode.required o "sends" sends;
        why = Decode.optional o "why" Decode.string;
        answers = Decode.optional o "answers" (Decode.nullable answers);
        then_ = Decode.optional o "then" (Decode.list then_item);
        correlation_id = Decode.optional o "correlationId" Decode.string;
      })

type method_ = {
  method_ : string;
  shape : string;
  via : method__via;
  cases : case list;
}

let method_ =
  Decode.obj (fun o : method_ ->
      {
        method_ = Decode.required o "method" Decode.string;
        shape = Decode.required o "shape" Decode.string;
        via = Decode.required o "via" method__via;
        cases = Decode.required o "cases" (Decode.list case);
      })

type namespace = { namespace : string; docs : string; methods : method_ list }

let namespace =
  Decode.obj (fun o : namespace ->
      {
        namespace = Decode.required o "namespace" Decode.string;
        docs = Decode.required o "docs" Decode.string;
        methods = Decode.required o "methods" (Decode.list method_);
      })

type go = { name : string; why : string }

let go =
  Decode.obj (fun o : go ->
      {
        name = Decode.required o "name" Decode.string;
        why = Decode.required o "why" Decode.string;
      })

type python = { name : string; why : string }

let python =
  Decode.obj (fun o : python ->
      {
        name = Decode.required o "name" Decode.string;
        why = Decode.required o "why" Decode.string;
      })

type named = { go : go; python : python option }

let named =
  Decode.obj (fun o : named ->
      {
        go = Decode.required o "go" go;
        python = Decode.optional o "python" python;
      })

type takes = { mark : string; yield : string }

let takes =
  Decode.obj (fun o : takes ->
      {
        mark = Decode.required o "mark" Decode.string;
        yield = Decode.required o "yield" Decode.string;
      })

type member = { member : string; named : named option; takes : takes option }

let member =
  Decode.obj (fun o : member ->
      {
        member = Decode.required o "member" Decode.string;
        named = Decode.optional o "named" named;
        takes = Decode.optional o "takes" takes;
      })

type worker_item = { handed : string; docs : string; members : member list }

let worker_item =
  Decode.obj (fun o : worker_item ->
      {
        handed = Decode.required o "handed" Decode.string;
        docs = Decode.required o "docs" Decode.string;
        members = Decode.required o "members" (Decode.list member);
      })

type made = {
  ocaml : string;
  csharp : string;
  typescript : string;
  rust : string;
  python : string;
  go : string;
  kotlin : string;
  swift : string;
  haskell : string;
}

let made =
  Decode.obj (fun o : made ->
      {
        ocaml = Decode.required o "ocaml" Decode.string;
        csharp = Decode.required o "csharp" Decode.string;
        typescript = Decode.required o "typescript" Decode.string;
        rust = Decode.required o "rust" Decode.string;
        python = Decode.required o "python" Decode.string;
        go = Decode.required o "go" Decode.string;
        kotlin = Decode.required o "kotlin" Decode.string;
        swift = Decode.required o "swift" Decode.string;
        haskell = Decode.required o "haskell" Decode.string;
      })

type made_by = {
  typescript : string option;
  go : string;
  haskell : string;
  kotlin : string option;
  swift : string option;
  csharp : string option;
}

let made_by =
  Decode.obj (fun o : made_by ->
      {
        typescript = Decode.optional o "typescript" Decode.string;
        go = Decode.required o "go" Decode.string;
        haskell = Decode.required o "haskell" Decode.string;
        kotlin = Decode.optional o "kotlin" Decode.string;
        swift = Decode.optional o "swift" Decode.string;
        csharp = Decode.optional o "csharp" Decode.string;
      })

type state_unit_member = { member : string }

let state_unit_member =
  Decode.obj (fun o : state_unit_member ->
      { member = Decode.required o "member" Decode.string })

type state_unit = {
  unit : string;
  docs : string;
  made : made;
  made_by : made_by;
  members : state_unit_member list;
}

let state_unit =
  Decode.obj (fun o : state_unit ->
      {
        unit = Decode.required o "unit" Decode.string;
        docs = Decode.required o "docs" Decode.string;
        made = Decode.required o "made" made;
        made_by = Decode.required o "madeBy" made_by;
        members = Decode.required o "members" (Decode.list state_unit_member);
      })

type wire_made = {
  ocaml : string;
  haskell : string;
  csharp : string;
  swift : string;
  typescript : string;
  rust : string;
  python : string;
  go : string;
  kotlin : string;
}

let wire_made =
  Decode.obj (fun o : wire_made ->
      {
        ocaml = Decode.required o "ocaml" Decode.string;
        haskell = Decode.required o "haskell" Decode.string;
        csharp = Decode.required o "csharp" Decode.string;
        swift = Decode.required o "swift" Decode.string;
        typescript = Decode.required o "typescript" Decode.string;
        rust = Decode.required o "rust" Decode.string;
        python = Decode.required o "python" Decode.string;
        go = Decode.required o "go" Decode.string;
        kotlin = Decode.required o "kotlin" Decode.string;
      })

type wire_member = { member : string }

let wire_member =
  Decode.obj (fun o : wire_member ->
      { member = Decode.required o "member" Decode.string })

type wire = { docs : string; made : wire_made; members : wire_member list }

let wire =
  Decode.obj (fun o : wire ->
      {
        docs = Decode.required o "docs" Decode.string;
        made = Decode.required o "made" wire_made;
        members = Decode.required o "members" (Decode.list wire_member);
      })

type storage_made = {
  ocaml : string;
  haskell : string;
  csharp : string;
  typescript : string;
  rust : string;
  python : string;
  go : string;
  kotlin : string;
  swift : string;
}

let storage_made =
  Decode.obj (fun o : storage_made ->
      {
        ocaml = Decode.required o "ocaml" Decode.string;
        haskell = Decode.required o "haskell" Decode.string;
        csharp = Decode.required o "csharp" Decode.string;
        typescript = Decode.required o "typescript" Decode.string;
        rust = Decode.required o "rust" Decode.string;
        python = Decode.required o "python" Decode.string;
        go = Decode.required o "go" Decode.string;
        kotlin = Decode.required o "kotlin" Decode.string;
        swift = Decode.required o "swift" Decode.string;
      })

type storage_member = { member : string }

let storage_member =
  Decode.obj (fun o : storage_member ->
      { member = Decode.required o "member" Decode.string })

type storage = {
  docs : string;
  made : storage_made;
  members : storage_member list;
}

let storage =
  Decode.obj (fun o : storage ->
      {
        docs = Decode.required o "docs" Decode.string;
        made = Decode.required o "made" storage_made;
        members = Decode.required o "members" (Decode.list storage_member);
      })

type where = {
  ocaml : string list option;
  haskell : string list;
  csharp : string list;
  swift : string list;
  typescript : string list;
  rust : string list;
  python : string list;
  go : string list;
  kotlin : string list;
}

let where =
  Decode.obj (fun o : where ->
      {
        ocaml = Decode.optional o "ocaml" (Decode.list Decode.string);
        haskell = Decode.required o "haskell" (Decode.list Decode.string);
        csharp = Decode.required o "csharp" (Decode.list Decode.string);
        swift = Decode.required o "swift" (Decode.list Decode.string);
        typescript = Decode.required o "typescript" (Decode.list Decode.string);
        rust = Decode.required o "rust" (Decode.list Decode.string);
        python = Decode.required o "python" (Decode.list Decode.string);
        go = Decode.required o "go" (Decode.list Decode.string);
        kotlin = Decode.required o "kotlin" (Decode.list Decode.string);
      })

type module_member_reader = { member : string }

let module_member_reader =
  Decode.obj (fun o : module_member_reader ->
      Decode.required o "kind" (Decode.literal "reader");
      { member = Decode.required o "member" Decode.string })

type module_member_function = {
  member : string;
  named : (string * string) list option;
}

let module_member_function =
  Decode.obj (fun o : module_member_function ->
      Decode.required o "kind" (Decode.literal "function");
      {
        member = Decode.required o "member" Decode.string;
        named = Decode.optional o "named" (Decode.map Decode.string);
      })

type fields_named_go = { kb_id : string }

let fields_named_go =
  Decode.obj (fun o : fields_named_go ->
      { kb_id = Decode.required o "kbId" Decode.string })

type fields_named = { go : fields_named_go }

let fields_named =
  Decode.obj (fun o : fields_named ->
      { go = Decode.required o "go" fields_named_go })

type module_member_type = {
  member : string;
  named : (string * string) list option;
  fields_named : fields_named option;
  fields : string list option;
}

let module_member_type =
  Decode.obj (fun o : module_member_type ->
      Decode.required o "kind" (Decode.literal "type");
      {
        member = Decode.required o "member" Decode.string;
        named = Decode.optional o "named" (Decode.map Decode.string);
        fields_named = Decode.optional o "fieldsNamed" fields_named;
        fields = Decode.optional o "fields" (Decode.list Decode.string);
      })

type module_member_constant = {
  member : string;
  named : (string * string) list option;
}

let module_member_constant =
  Decode.obj (fun o : module_member_constant ->
      Decode.required o "kind" (Decode.literal "constant");
      {
        member = Decode.required o "member" Decode.string;
        named = Decode.optional o "named" (Decode.map Decode.string);
      })

type module__member =
  | Reader of module_member_reader
  | Function of module_member_function
  | Type of module_member_type
  | Constant of module_member_constant

let module__member =
  Decode.variant "kind"
    [
      ("reader", fun c -> (Reader (module_member_reader c) : module__member));
      ( "function",
        fun c -> (Function (module_member_function c) : module__member) );
      ("type", fun c -> (Type (module_member_type c) : module__member));
      ( "constant",
        fun c -> (Constant (module_member_constant c) : module__member) );
    ]

type module_ = {
  module_ : string;
  docs : string;
  where : where;
  whole : string list option;
  members : module__member list;
}

let module_ =
  Decode.obj (fun o : module_ ->
      {
        module_ = Decode.required o "module" Decode.string;
        docs = Decode.required o "docs" Decode.string;
        where = Decode.required o "where" where;
        whole = Decode.optional o "whole" (Decode.list Decode.string);
        members = Decode.required o "members" (Decode.list module__member);
      })

type clock_item = {
  source : string;
  docs : string;
  type_words : string list;
  outside : (string * string) list;
  takes : (string * (string * string list) list) list;
}

let clock_item =
  Decode.obj (fun o : clock_item ->
      {
        source = Decode.required o "source" Decode.string;
        docs = Decode.required o "docs" Decode.string;
        type_words = Decode.required o "typeWords" (Decode.list Decode.string);
        outside = Decode.required o "outside" (Decode.map Decode.string);
        takes =
          Decode.required o "takes"
            (Decode.map (Decode.map (Decode.list Decode.string)));
      })

type t = {
  comment : string;
  shapes : shapes;
  via : via;
  fixtures : fixtures;
  namespaces : namespace list;
  worker : worker_item list;
  state_units : state_unit list;
  wire : wire;
  storage : storage;
  modules : module_ list;
  clock : clock_item list;
}

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        shapes = Decode.required o "shapes" shapes;
        via = Decode.required o "via" via;
        fixtures = Decode.required o "fixtures" fixtures;
        namespaces = Decode.required o "namespaces" (Decode.list namespace);
        worker = Decode.required o "worker" (Decode.list worker_item);
        state_units = Decode.required o "stateUnits" (Decode.list state_unit);
        wire = Decode.required o "wire" wire;
        storage = Decode.required o "storage" storage;
        modules = Decode.required o "modules" (Decode.list module_);
        clock = Decode.required o "clock" (Decode.list clock_item);
      })
