(* The gateway's HTTP surface as the TypeScript SDK reads it
   (typescript/core/src/gateway-http.ts): each operation by its operationId,
   with its method, path and media types; each header by its name in camel
   case; each credential the gateway takes as a key, where it goes and its
   name there; and the client secret form as a type, which the form a service
   account posts satisfies. An upload's members are ResourceUpload's, which
   the generated types already name. *)

module S = Typescript_syntax

let path = "typescript/core/src/gateway-http.ts"

let camel header =
  match Model.words header with
  | first :: rest ->
      String.concat "" (first :: List.map String.capitalize_ascii rest)
  | [] -> header

let route (r : Model.route) =
  let media key = Option.map (fun m -> S.entry (Ident key) (Str m)) in
  S.entry (Ident r.operation_id)
    (Object
       {
         layout = Inline;
         entries =
           [
             S.entry (Ident "method") (Str r.method_);
             S.entry (Ident "path") (Str r.path);
           ]
           @ List.filter_map Fun.id
               [ media "sends" r.sends; media "answers" r.answers ];
       })

let api_key (scheme, (k : Model.api_key)) =
  let in_ =
    match k.in_ with Path -> "path" | Query -> "query" | Header -> "header"
  in
  S.entry (Ident scheme)
    (Object
       {
         layout = Inline;
         entries =
           [
             S.entry (Ident "in") (Str in_); S.entry (Ident "name") (Str k.name);
           ];
       })

let form_member = function
  | Model.Fixed { name; value } -> S.member (Ident name) (T_str value)
  | Filled name -> S.member (Ident name) (T_name "string")

let file (m : Model.t) =
  {
    Output.path;
    text =
      S.text
        {
          banner =
            Banner.typescript_lines
              ~authority:
                [
                  "protocol/specs/src/openapi.json and its paths";
                  "protocol/specs/src/session/ClientSecretForm.json";
                ]
              __FILE__;
          body =
            [
              S.const
                ~about:
                  [
                    Doc
                      "Each operation of the gateway, by its operationId: its \
                       method, its path (a `{name}` for each parameter, which \
                       the caller fills), and the media types it sends and \
                       answers with.";
                  ]
                ~as_const:true "gatewayRoutes"
                (S.rows (List.map route m.routes));
              S.const
                ~about:
                  [
                    Doc
                      "Each header the gateway's operations name, asked or \
                       answered.";
                  ]
                ~as_const:true "gatewayHeaders"
                (S.rows
                   (List.map
                      (fun h -> S.entry (Ident (camel h)) (Str h))
                      m.headers));
              S.const
                ~about:
                  [
                    Doc
                      "Each credential the gateway takes as a key, by its \
                       security scheme: where it goes, and its name there.";
                  ]
                ~as_const:true "gatewayApiKeys"
                (S.rows (List.map api_key m.api_keys));
              S.type_alias
                ~about:
                  [
                    Doc "The form a service account posts with a client secret.";
                  ]
                "ClientSecretForm"
                (T_object (Rows, List.map form_member m.client_secret_form));
            ];
        };
  }
