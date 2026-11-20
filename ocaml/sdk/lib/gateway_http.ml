(* Generated from protocol/specs/src/openapi.json and its paths. Do not edit.
   Regenerate: make generate (codegen/lib/gateway_http/ocaml.ml) *)

let get_health = ("GET", "/api/health")
let get_health_at_root = ("GET", "/")
let get_open_api_document = ("GET", "/api/openapi.json")

let get_protected_resource_metadata =
  ("GET", "/.well-known/oauth-protected-resource")

let create_media_token = ("POST", "/api/tokens/media")
let get_current_user = ("GET", "/api/users/me")
let get_status = ("GET", "/api/status")
let subscribe_to_bus = ("POST", "/bus/subscribe")
let emit_on_bus = ("POST", "/bus/emit")
let upload_resource = ("POST", "/resources")
let get_resource_representation = ("GET", "/resources/{id}")
let get_resource_json_ld = ("GET", "/resources/{id}/jsonld")
let get_resource_annotations = ("GET", "/resources/{id}/annotations")
let get_resource_anchored_text = ("GET", "/resources/{id}/anchored-text")
let get_resource_representation_with_media_token = ("GET", "/api/resources/{id}")

module Media = struct
  let get_health_answers = "application/json"
  let get_health_at_root_answers = "application/json"
  let get_open_api_document_answers = "application/json"
  let get_protected_resource_metadata_answers = "application/json"
  let create_media_token_sends = "application/json"
  let create_media_token_answers = "application/json"
  let get_current_user_answers = "application/json"
  let get_status_answers = "application/json"
  let subscribe_to_bus_sends = "application/json"
  let subscribe_to_bus_answers = "text/event-stream"
  let emit_on_bus_sends = "application/json"
  let emit_on_bus_answers = "application/json"
  let upload_resource_sends = "multipart/form-data"
  let upload_resource_answers = "application/json"
  let get_resource_representation_answers = "*/*"
  let get_resource_json_ld_answers = "application/ld+json"
  let get_resource_annotations_answers = "application/json"
  let get_resource_anchored_text_answers = "application/json"
  let get_resource_representation_with_media_token_answers = "*/*"
end

module Header = struct
  let cache_control = "Cache-Control"
  let idempotency_key = "Idempotency-Key"
  let link = "Link"
  let retry_after = "Retry-After"
  let www_authenticate = "WWW-Authenticate"
end

module Upload_field = struct
  let name = "name"
  let file = "file"
  let format = "format"
  let storage_uri = "storageUri"
  let language = "language"
  let entity_types = "entityTypes"
  let source_annotation_id = "sourceAnnotationId"
  let source_resource_id = "sourceResourceId"
  let generation_prompt = "generationPrompt"
  let generator = "generator"
  let job_id = "jobId"
  let is_draft = "isDraft"
  let clone_token = "cloneToken"
  let archive_original = "archiveOriginal"

  let all =
    [
      name;
      file;
      format;
      storage_uri;
      language;
      entity_types;
      source_annotation_id;
      source_resource_id;
      generation_prompt;
      generator;
      job_id;
      is_draft;
      clone_token;
      archive_original;
    ]
end

module Bus_frame = struct
  let channel = "channel"
  let correlation_id = "correlationId"
  let payload = "payload"
  let scope = "scope"
end

let client_secret_form ~client_id ~client_secret =
  [
    ("grant_type", "client_credentials");
    ("client_id", client_id);
    ("client_secret", client_secret);
  ]
