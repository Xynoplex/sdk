(* The gateway's HTTP surface as the Kotlin SDK reads it
   (kotlin/sdk/src/generated/kotlin/xynolog/http/GatewayHttp.kt), all of it
   internal to the SDK: each operation as a GatewayRoute named for its
   operationId, with its method and path; the media types each sends and
   answers with, stated only where it has a body; each header; an upload's
   members, an entry each, with the name each is sent under and whether
   every upload sends it, in the schema's order; a bus frame's members, by
   name; and the client secret form, its fixed members as they are and the
   others the account's. *)

module K = Kotlin_syntax

let package = "xynolog.http"
let route_name (r : Model.route) = Text.upper_snake r.operation_id

let header_name h =
  String.uppercase_ascii (String.concat "_" (String.split_on_char '-' h))

let string = K.Type "String"
let doc text = Some (K.Doc text)

let constant ?about name value =
  K.property ?about ~visibility:K.Internal ~const:true
    ~value:(K.Same_line value) name

let route (r : Model.route) =
  K.property
    ~about:(K.Doc ("`" ^ r.operation_id ^ "`."))
    ~visibility:K.Internal
    ~value:
      (K.Same_line
         (K.named_call (K.Name "GatewayRoute")
            [ ("method", K.Str r.method_); ("path", K.Str r.path) ]))
    (route_name r)

let media (m : Model.t) =
  K.Packed
    (List.concat_map
       (fun (r : Model.route) ->
         List.filter_map Fun.id
           [
             Option.map
               (fun media -> constant (route_name r ^ "_SENDS") (K.Str media))
               r.sends;
             Option.map
               (fun media -> constant (route_name r ^ "_ANSWERS") (K.Str media))
               r.answers;
           ])
       m.routes)

let bound = K.Bound { visibility = K.Default; mutable_ = false }

let upload_fields (m : Model.t) =
  K.class_
    ?about:
      (doc "A member of an upload (`ResourceUpload`), in the schema's order.")
    ~visibility:K.Internal
    ~constructor:
      (K.constructor ~layout:K.Inline
         [
           K.param ~binding:bound "wire" string;
           K.param ~binding:bound "required" (K.Type "Boolean");
         ])
    ~entries:
      (List.map
         (fun (f : Model.upload_field) ->
           K.entry
             ~args:[ K.Str f.field; K.Bool f.required ]
             (Kotlin_sdk.Names.variant_of f.field))
         m.upload_fields)
    K.Enum_class "UploadField"

let client_secret_form (m : Model.t) =
  let param name = String.uncapitalize_ascii (Text.pascal name) in
  let filled =
    List.filter_map
      (function Model.Filled name -> Some name | Fixed _ -> None)
      m.client_secret_form
  in
  K.function_
    ?about:
      (doc
         "The form a service account posts with a client secret, each member \
          by its name, in the schema's order.")
    ~visibility:K.Internal
    ~params:(List.map (fun name -> (param name, string)) filled)
    ~returns:(K.Generic ("List", [ K.Generic ("Pair", [ string; string ]) ]))
    "clientSecretForm"
    (K.Same_line
       (K.call (K.Name "listOf")
          (List.map
             (function
               | Model.Fixed { name; value } ->
                   K.Binary (K.Str name, K.To, K.Str value)
               | Filled name -> K.Binary (K.Str name, K.To, K.Name (param name)))
             m.client_secret_form)))

let file (m : Model.t) =
  Kotlin_sdk.data_file
    ~banner:
      (Banner.lines ~from_:"protocol/specs/src/openapi.json and its paths"
         __FILE__)
    ~package ~name:"GatewayHttp" ~imports:[]
    ([
       K.class_
         ?about:
           (doc
              "An operation of the gateway: its method, and its path, a \
               `{name}` for each parameter, which the caller fills.")
         ~visibility:K.Internal
         ~constructor:
           (K.constructor ~layout:K.Inline
              [
                K.param ~binding:bound "method" string;
                K.param ~binding:bound "path" string;
              ])
         K.Data_class "GatewayRoute";
     ]
    @ List.map route m.routes
    @ [
        media m;
        K.Packed
          (List.map (fun h -> constant (header_name h) (K.Str h)) m.headers);
        upload_fields m;
        K.Packed
          (List.map
             (fun member ->
               constant ("BUS_FRAME_" ^ Text.upper_snake member) (K.Str member))
             m.bus_frame);
        client_secret_form m;
      ])
