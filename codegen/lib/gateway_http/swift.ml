(* The gateway's HTTP surface as the Swift SDK reads it
   (swift/sdk/Sources/Xynolog/Generated/GatewayHTTP.swift): each operation
   as a GatewayRoute named for its operationId, with its method and path;
   the media types each sends and answers with, stated only where it has a
   body; each header; an upload's members, by the name each is sent under;
   and the client secret form, its fixed members as they are and the others
   the account's. *)

module S = Swift_syntax

let path = "swift/sdk/Sources/Xynolog/Generated/GatewayHTTP.swift"
let decl ?(doc = []) modifiers body = { S.doc; modifiers; body }
let docs text = Text.wrapped ~lead:"/// " ~width:100 text
let member_docs text = Text.wrapped ~lead:"  /// " ~width:100 text
let uncapitalized = String.uncapitalize_ascii
let route_name (r : Model.route) = uncapitalized (Text.pascal r.operation_id)

let header_name h =
  uncapitalized
    (String.concat "" (List.map String.capitalize_ascii (Model.words h)))

let constant ?(doc = []) name value =
  decl ~doc [ "static" ]
    (S.Property { var = false; name; type_ = None; value = Some value })

let route (r : Model.route) =
  constant
    ~doc:(member_docs ("`" ^ r.operation_id ^ "`."))
    (route_name r)
    (S.Call
       ( S.Name "GatewayRoute",
         [
           { label = Some "method"; value = S.String r.method_ };
           { label = Some "path"; value = S.String r.path };
         ] ))

let routes (m : Model.t) =
  decl
    ~doc:
      (docs
         "An operation of the gateway: its method, and its path, a `{name}` \
          for each parameter, which the caller fills.")
    []
    (S.Struct
       {
         name = "GatewayRoute";
         generics = [];
         inherits = [ S.Named "Sendable" ];
         layout = S.Lines;
         members =
           [
             decl []
               (S.Property
                  {
                    var = false;
                    name = "method";
                    type_ = Some (S.Named "String");
                    value = None;
                  });
             decl []
               (S.Property
                  {
                    var = false;
                    name = "path";
                    type_ = Some (S.Named "String");
                    value = None;
                  });
           ]
           @ List.map route m.routes;
       })

let namespace ~doc name members =
  decl ~doc:(docs doc) []
    (S.Enum { name; inherits = []; layout = S.Lines; members })

let media (m : Model.t) =
  namespace
    ~doc:
      "The media type each operation sends and answers with, where it has a \
       body."
    "GatewayMedia"
    (List.concat_map
       (fun (r : Model.route) ->
         List.filter_map Fun.id
           [
             Option.map
               (fun media -> constant (route_name r ^ "Sends") (S.String media))
               r.sends;
             Option.map
               (fun media ->
                 constant (route_name r ^ "Answers") (S.String media))
               r.answers;
           ])
       m.routes)

let headers (m : Model.t) =
  namespace ~doc:"Each header the gateway's operations name, asked or answered."
    "GatewayHeader"
    (List.map (fun h -> constant (header_name h) (S.String h)) m.headers)

let upload_fields (m : Model.t) =
  decl
    ~doc:
      (docs
         "A member of an upload (`ResourceUpload`), by the name it is sent \
          under.")
    []
    (S.Enum
       {
         name = "UploadField";
         inherits =
           [ S.Named "String"; S.Named "Sendable"; S.Named "CaseIterable" ];
         layout = S.Lines;
         members =
           List.map
             (fun (f : Model.upload_field) ->
               let name = Swift_sdk.Models.enum_case f.field in
               decl []
                 (S.Case
                    {
                      name;
                      value =
                        (if name = f.field then S.Bare
                         else S.Raw (S.String f.field));
                    }))
             m.upload_fields;
       })

(* A form member's name as a Swift parameter's: [client_id] is [clientId]. *)
let param name = uncapitalized (Text.pascal name)

let client_secret_form (m : Model.t) =
  let filled =
    List.filter_map
      (function Model.Filled name -> Some name | Fixed _ -> None)
      m.client_secret_form
  in
  decl
    ~doc:
      (docs
         "The form a service account posts with a client secret, each member \
          by its name, in the schema's order.")
    []
    (S.Func
       {
         name = "clientSecretForm";
         generics = [];
         params =
           List.map
             (fun name ->
               {
                 S.label = None;
                 name = param name;
                 type_ = S.Named "String";
                 default = None;
               })
             filled;
         throws = false;
         result =
           Some (S.Array_of (S.Tuple_of [ S.Named "String"; S.Named "String" ]));
         body =
           {
             layout = S.Lines;
             stmts =
               [
                 S.Return
                   (Some
                      (S.Array
                         ( S.Inline,
                           List.map
                             (function
                               | Model.Fixed { name; value } ->
                                   S.Tuple [ S.String name; S.String value ]
                               | Filled name ->
                                   S.Tuple
                                     [ S.String name; S.Name (param name) ])
                             m.client_secret_form )));
               ];
           };
       })

let file (m : Model.t) =
  {
    Output.path;
    text =
      S.print
        {
          S.banner =
            Banner.lines ~from_:"protocol/specs/src/openapi.json and its paths"
              __FILE__;
          imports = [ { S.module_ = "Foundation"; testable = false } ];
          decls =
            List.map
              (fun d -> (S.Blank, d))
              [
                routes m;
                media m;
                headers m;
                upload_fields m;
                client_secret_form m;
              ];
        };
  }
