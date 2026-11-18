(* The clients and the scope as the Kotlin SDK names them
   (xynolog.signin): a client's id as [<NAME>_CLIENT_ID], and the scope as
   [SIGN_IN_SCOPE]. [from_] is the table's file. *)

module K = Kotlin_syntax
module T = Tables.Session_oauth

let constant ~docs name value =
  K.property ~about:(K.Block docs)
    ~annotations:[ K.annotation "Generated" ]
    ~visibility:K.Public ~const:true ~type_:(K.Type "String")
    ~value:(K.Same_line (K.Str value)) name

let file ~from_ (t : T.t) =
  Kotlin_sdk.table ~from_ __FILE__ ~package:"xynolog.signin"
    ~name:"OAuthClients" ~imports:[ "xynolog.Generated" ]
    (List.map
       (fun (c : T.clients_item) ->
         constant ~docs:c.docs
           (Kotlin_sdk.Names.constant_name c.name ^ "_CLIENT_ID")
           c.id)
       t.clients
    @ [ constant ~docs:t.scopes.docs "SIGN_IN_SCOPE" t.scopes.value ])
