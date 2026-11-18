(* The OAuth clients group: the client ids a Xynolog client signs in as, and
   the scope a sign-in asks for (protocol/specs/src/session/oauth.json), for
   the Go, Python, TypeScript, OCaml and Kotlin SDKs. A knowledge base's
   realm registers the clients, so an id restated by hand is a sign-in that
   fails the day the registration changes. A client is named in lowercase
   letters, once. *)

module T = Tables.Session_oauth

let file = "session/oauth.json"

let derive (t : T.t) =
  let refusals =
    List.concat
      (List.mapi
         (fun i (c : T.client) ->
           let refuse message =
             [
               {
                 Decode.file;
                 pointer = Printf.sprintf "/clients/%d/name" i;
                 message;
               };
             ]
           in
           if
             not
               (String.for_all
                  (function 'a' .. 'z' -> true | _ -> false)
                  c.name)
           then
             refuse
               (Printf.sprintf "is %S, which is not lowercase letters" c.name)
           else
             match
               List.find_index (fun (d : T.client) -> d.name = c.name) t.clients
             with
             | Some j when j < i ->
                 refuse
                   (Printf.sprintf "is %s, which /clients/%d states already"
                      c.name j)
             | _ -> [])
         t.clients)
  in
  if refusals = [] then Ok t else Error refusals

let go (t : T.t) =
  let module G = Go_syntax in
  let constant name docs value =
    G.Const (G.spec ~doc:(G.prose (name ^ ": " ^ docs)) name (G.Quoted value))
  in
  let name (c : T.client) = String.capitalize_ascii c.name ^ "ClientID" in
  {
    Output.path = "go/oauthclients_gen.go";
    text =
      G.text
        {
          header =
            G.verbatim
              ("Code generated from protocol/specs/src/session/oauth.json — DO \
                NOT EDIT.\n\n\
                Regenerate: make generate (" ^ Banner.writer __FILE__
             ^ ")\n\
                The TypeScript (typescript/core/src/oauth-clients.ts), Rust\n\
                (rust/sdk/src/generated/oauth_clients.rs) and Python\n\
                (xynolog.oauth_clients) SDKs are generated from the same file."
              );
          package = "xynolog";
          imports = [];
          decls =
            List.map
              (fun (c : T.client) -> constant (name c) c.docs c.id)
              t.clients
            @ [ constant "SignInScope" t.scope.docs t.scope.value ];
        };
  }

let python (t : T.t) =
  let module P = Python_syntax in
  let constant name docs value =
    P.assign ~about:[ Prose docs ] ~annotation:(P.Name "Final")
      ~value:(P.Str value) name
  in
  let name (c : T.client) = String.uppercase_ascii c.name ^ "_CLIENT_ID" in
  {
    Output.path = "python/sdk/src/xynolog/oauth_clients.py";
    text =
      P.text
        {
          header =
            Banner.python_lines ~from_:"protocol/specs/src/session/oauth.json"
              __FILE__;
          doc =
            As_is
              "How a Xynolog client presents itself to the issuer a knowledge \
               base trusts:\n\
               the clients its realm registers, and the scope every sign-in \
               asks for.\n";
          imports = [ [ P.From ("typing", [ "Final" ]) ] ];
          body =
            P.assign "__all__"
              ~value:
                (P.List
                   (P.items ~magic:true
                      (List.map
                         (fun n -> P.item (P.Str n))
                         (List.sort compare
                            ("SIGN_IN_SCOPE" :: List.map name t.clients)))))
            :: List.map
                 (fun (c : T.client) -> constant (name c) c.docs c.id)
                 t.clients
            @ [ constant "SIGN_IN_SCOPE" t.scope.docs t.scope.value ];
        };
  }

let typescript (t : T.t) =
  let module S = Typescript_syntax in
  let constant name docs value = S.const name ~about:[ Doc docs ] (Str value) in
  {
    Output.path = "typescript/core/src/oauth-clients.ts";
    text =
      S.text
        {
          banner =
            Banner.typescript_lines
              ~authority:[ "protocol/specs/src/" ^ file ]
              __FILE__;
          body =
            List.map
              (fun (c : T.client) ->
                constant
                  (String.uppercase_ascii c.name ^ "_CLIENT_ID")
                  c.docs c.id)
              t.clients
            @ [ constant "SIGN_IN_SCOPE" t.scope.docs t.scope.value ];
        };
  }

(* The clients and the scope as the OCaml SDK names them
   (ocaml/sdk/lib/oauth_facts.ml): a client's id by its name, and the scope. *)
let ocaml (t : T.t) =
  let module O = Ocaml_syntax in
  O.implementation ~path:"ocaml/sdk/lib/oauth_facts.ml"
    ~banner:(Banner.ocaml ~from_:file __FILE__)
    (List.map (fun (c : T.client) -> O.let_ c.name (O.string c.id)) t.clients
    @ [ O.let_ "scope" (O.string t.scope.value) ])

let rust (t : T.t) =
  let module R = Rust_syntax in
  let constant name docs value =
    R.Const
      {
        doc = [ docs ];
        attrs = [];
        vis = Pub;
        name;
        ty = R.str_ty;
        value = R.Str value;
      }
  in
  {
    Output.path = "rust/sdk/src/generated/oauth_clients.rs";
    text =
      R.text
        ~header:
          (Banner.lines ~from_:"protocol/specs/src/session/oauth.json" __FILE__)
        (List.map
           (fun (c : T.client) ->
             constant (String.uppercase_ascii c.name ^ "_CLIENT_ID") c.docs c.id)
           t.clients
        @ [ constant "SIGN_IN_SCOPE" t.scope.docs t.scope.value ]);
  }

(* The clients and the scope as the Haskell SDK names them
   (generated/.../OAuth.hs): a client's id by its name and ClientId, and the
   scope. *)
let haskell (t : T.t) =
  let module H = Haskell_syntax in
  {
    Output.path = "haskell/sdk/generated/Xynolog/Internal/Generated/OAuth.hs";
    text =
      H.text
        {
          banner = Banner.lines ~from_:file __FILE__;
          extensions = [ "OverloadedStrings" ];
          name = "Xynolog.Internal.Generated.OAuth";
          imports = [ H.import "Data.Text" ~items:[ Plain "Text" ] ];
          body =
            List.map
              (fun (c : T.client) ->
                H.value (c.name ^ "ClientId") (T_name "Text") (Str c.id))
              t.clients
            @ [ H.value "signInScope" (T_name "Text") (Str t.scope.value) ];
        };
  }

let files ~root:_ (spec : Spec.t) =
  Result.map
    (fun t ->
      [
        go t;
        python t;
        typescript t;
        ocaml t;
        rust t;
        haskell t;
        Kotlin.file ~from_:file t;
      ])
    (derive spec.tables.session_oauth)
