(* The gateway's HTTP surface as the C# SDK reads it
   (csharp/sdk/src/Xynolog/Generated/GatewayHttp.g.cs), all of it internal
   to the SDK: each operation as a GatewayRoute named for its operationId,
   with its method and path; the media types each sends and answers with,
   stated only where it has a body; each header; an upload's members and a
   bus frame's, by the name each is sent under; and the client secret form,
   its fixed members as they are and the others the account's. *)

module C = Csharp_syntax

let path = "csharp/sdk/src/Xynolog/Generated/GatewayHttp.g.cs"
let route_name (r : Model.route) = Text.pascal r.operation_id
let string = C.T "string"

let header_name h =
  String.concat "" (List.map String.capitalize_ascii (Model.words h))

let constant name value =
  C.Field
    {
      modifiers = [ Internal; Const ];
      type_ = string;
      name;
      value = Some (C.Str value);
    }

let static_class name members =
  C.Type
    {
      attributes = [];
      modifiers = [ Internal; Static ];
      kind = Class;
      name;
      params = None;
      base = None;
      body = Some (C.Packed, members);
    }

let http_method m =
  C.Name
    ("global::System.Net.Http.HttpMethod."
    ^ Text.pascal (String.lowercase_ascii m))

let route (r : Model.route) =
  C.Field
    {
      modifiers = [ Internal; Static; Readonly ];
      type_ = C.T "GatewayRoute";
      name = route_name r;
      value =
        Some
          (C.New
             {
               type_ = None;
               args =
                 Some [ C.Arg (http_method r.method_); C.Arg (C.Str r.path) ];
               init = None;
             });
    }

let routes (m : Model.t) =
  C.Type
    {
      attributes = [];
      modifiers = [ Internal; Sealed ];
      kind = Record;
      name = "GatewayRoute";
      params =
        Some
          [
            {
              by = `Value;
              type_ = C.T "global::System.Net.Http.HttpMethod";
              name = "Method";
            };
            { by = `Value; type_ = string; name = "Path" };
          ];
      base = None;
      body = Some (C.Packed, List.map route m.routes);
    }

let media (m : Model.t) =
  static_class "GatewayMedia"
    (List.concat_map
       (fun (r : Model.route) ->
         List.filter_map Fun.id
           [
             Option.map (constant (route_name r ^ "Sends")) r.sends;
             Option.map (constant (route_name r ^ "Answers")) r.answers;
           ])
       m.routes)

let client_secret_form (m : Model.t) =
  let param name = String.uncapitalize_ascii (Text.pascal name) in
  let filled =
    List.filter_map
      (function Model.Filled name -> Some name | Fixed _ -> None)
      m.client_secret_form
  in
  static_class "GatewayForms"
    [
      C.Method
        {
          modifiers = [ Internal; Static ];
          returns = C.Generic ("Dictionary", [ string; string ]);
          name = "ClientSecret";
          params =
            List.map
              (fun name -> { C.by = `Value; type_ = string; name = param name })
              filled;
          body =
            C.Arrow
              (C.New
                 {
                   type_ = None;
                   args = Some [];
                   init =
                     Some
                       (C.Keyed
                          (List.map
                             (function
                               | Model.Fixed { name; value } ->
                                   (C.Str name, C.Str value)
                               | Filled name -> (C.Str name, C.Name (param name)))
                             m.client_secret_form));
                 });
        };
    ]

let file (m : Model.t) =
  {
    Output.path;
    text =
      C.text
        {
          header =
            Banner.lines ~from_:"protocol/specs/src/openapi.json and its paths"
              __FILE__;
          nullable = false;
          usings = [];
          namespace = "Xynolog.Http";
          decls =
            [
              routes m;
              media m;
              static_class "GatewayHeader"
                (List.map (fun h -> constant (header_name h) h) m.headers);
              static_class "UploadField"
                (List.map
                   (fun (f : Model.upload_field) ->
                     constant (Text.pascal f.field) f.field)
                   m.upload_fields);
              static_class "BusFrameMember"
                (List.map
                   (fun member -> constant (Text.pascal member) member)
                   m.bus_frame);
              client_secret_form m;
            ];
        };
  }
