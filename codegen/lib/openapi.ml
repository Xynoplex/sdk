(* OpenAPI 3.0 as Protocol writes it: its two documents, their path items and
   their shared responses, with only the objects and members Protocol uses. *)

(* OpenAPI's Reference Object, in the places one stands for what it names: an
   object with "$ref" is a reference and nothing else. *)
type 'a or_ref = Ref of Decode.reference | Inline of 'a

let reference_only =
  Decode.obj (fun o -> Decode.required o "$ref" Decode.reference)

let or_ref decoder cursor =
  if Decode.has_member "$ref" cursor then Ref (reference_only cursor)
  else Inline (decoder cursor)

(* x-xynolog-limits: named limits, each a count, "unlimited", or a group of
   limits by name. *)
type limit = Count of int | Unlimited | Limits of limits
and limits = (string * limit) list

let rec limit cursor =
  match Decode.kind cursor with
  | Decode.Int -> Count (Decode.int cursor)
  | Decode.String ->
      Decode.literal "unlimited" cursor;
      Unlimited
  | _ -> Limits (limits cursor)

and limits cursor = Decode.map limit cursor

type location = Path | Query | Header

type parameter = {
  name : string;
  in_ : location;
  required : bool;
  description : string option;
  schema : Schema.t;
}

let parameter =
  Decode.obj (fun o ->
      let name = Decode.required o "name" Decode.non_empty_string in
      let in_ =
        Decode.required o "in"
          (Decode.enum [ ("path", Path); ("query", Query); ("header", Header) ])
      in
      let required = Decode.required o "required" Decode.bool in
      let description = Decode.optional o "description" Decode.string in
      let schema = Decode.required o "schema" Schema.decode in
      { name; in_; required; description; schema })

type media_type = { schema : Schema.t }

let media_type =
  Decode.obj (fun o ->
      let schema = Decode.required o "schema" Schema.decode in
      { schema })

let content = Decode.map media_type

type header = { description : string; schema : Schema.t }

let header =
  Decode.obj (fun o ->
      let description = Decode.required o "description" Decode.string in
      let schema = Decode.required o "schema" Schema.decode in
      { description; schema })

type response = {
  description : string;
  headers : (string * header) list option;
  content : (string * media_type) list option;
}

let response =
  Decode.obj (fun o ->
      let description = Decode.required o "description" Decode.string in
      let headers = Decode.optional o "headers" (Decode.map header) in
      let content = Decode.optional o "content" content in
      { description; headers; content })

type request_body = { required : bool; content : (string * media_type) list }

let request_body =
  Decode.obj (fun o ->
      let required = Decode.required o "required" Decode.bool in
      let content = Decode.required o "content" content in
      { required; content })

(* A security requirement: the schemes it names, each with its scopes. *)
type security_requirement = (string * string list) list

let security_requirement = Decode.map (Decode.list Decode.string)

type operation = {
  operation_id : string;
  summary : string;
  description : string;
  tags : string list option;
  security : security_requirement list;
  parameters : parameter list option;
  request_body : request_body option;
  responses : (string * response or_ref) list;
  limits : limits option;
}

let operation =
  Decode.obj (fun o ->
      let operation_id =
        Decode.required o "operationId" Decode.non_empty_string
      in
      let summary = Decode.required o "summary" Decode.string in
      let description = Decode.required o "description" Decode.string in
      let tags = Decode.optional o "tags" (Decode.list Decode.string) in
      let security =
        Decode.required o "security" (Decode.list security_requirement)
      in
      let parameters = Decode.optional o "parameters" (Decode.list parameter) in
      let request_body = Decode.optional o "requestBody" request_body in
      let responses =
        Decode.required o "responses" (Decode.map (or_ref response))
      in
      let limits = Decode.optional o "x-xynolog-limits" limits in
      {
        operation_id;
        summary;
        description;
        tags;
        security;
        parameters;
        request_body;
        responses;
        limits;
      })

type path_item = {
  get : operation option;
  put : operation option;
  post : operation option;
}

let path_item =
  Decode.obj (fun o ->
      let get = Decode.optional o "get" operation in
      let put = Decode.optional o "put" operation in
      let post = Decode.optional o "post" operation in
      if get = None && put = None && post = None then
        Decode.refuse (Decode.at o) "a path item with no operation";
      { get; put; post })

type license = { name : string; url : string }

let license =
  Decode.obj (fun o ->
      let name = Decode.required o "name" Decode.string in
      let url = Decode.required o "url" Decode.string in
      { name; url })

type info = {
  title : string;
  version : string;
  description : string;
  license : license;
}

let info =
  Decode.obj (fun o ->
      let title = Decode.required o "title" Decode.string in
      let version = Decode.required o "version" Decode.string in
      let description = Decode.required o "description" Decode.string in
      let license = Decode.required o "license" license in
      { title; version; description; license })

type server_variable = { default : string }

let server_variable =
  Decode.obj (fun o ->
      let default = Decode.required o "default" Decode.string in
      { default })

type server = {
  url : string;
  description : string;
  variables : (string * server_variable) list;
}

let server =
  Decode.obj (fun o ->
      let url = Decode.required o "url" Decode.string in
      let description = Decode.required o "description" Decode.string in
      let variables =
        Decode.required o "variables" (Decode.map server_variable)
      in
      { url; description; variables })

type security_scheme =
  | Http of {
      scheme : string;
      bearer_format : string;
      description : string option;
      limits : limits option;
    }
  | Api_key of { in_ : location; name : string; description : string }

let security_scheme =
  Decode.obj (fun o ->
      match
        Decode.required o "type"
          (Decode.enum [ ("http", `Http); ("apiKey", `Api_key) ])
      with
      | `Http ->
          let scheme = Decode.required o "scheme" Decode.string in
          let bearer_format = Decode.required o "bearerFormat" Decode.string in
          let description = Decode.optional o "description" Decode.string in
          let limits = Decode.optional o "x-xynolog-limits" limits in
          Http { scheme; bearer_format; description; limits }
      | `Api_key ->
          let in_ =
            Decode.required o "in"
              (Decode.enum [ ("query", Query); ("header", Header) ])
          in
          let name = Decode.required o "name" Decode.string in
          let description = Decode.required o "description" Decode.string in
          Api_key { in_; name; description })

type components = {
  security_schemes : (string * security_scheme) list;
  responses : (string * Decode.reference) list option;
  schemas : (string * Decode.reference) list;
}

let components =
  Decode.obj (fun o ->
      let security_schemes =
        Decode.required o "securitySchemes" (Decode.map security_scheme)
      in
      let responses =
        Decode.optional o "responses" (Decode.map reference_only)
      in
      let schemas = Decode.required o "schemas" (Decode.map reference_only) in
      { security_schemes; responses; schemas })

type document = {
  info : info;
  servers : server list;
  limits : limits;
  paths : (string * Decode.reference) list;
  components : components;
}

let document =
  Decode.obj (fun o ->
      Decode.required o "openapi" (Decode.literal "3.0.0");
      let info = Decode.required o "info" info in
      let servers =
        Decode.required o "servers" (Decode.non_empty_list server)
      in
      let limits = Decode.required o "x-xynolog-limits" limits in
      let paths = Decode.required o "paths" (Decode.map reference_only) in
      let components = Decode.required o "components" components in
      { info; servers; limits; paths; components })
