(* The OAuth clients group: the client ids a Xynolog client signs in as, and
   the scope a sign-in asks for (protocol/specs/src/session/oauth.json), for
   the Go, Python and TypeScript SDKs. A knowledge base's realm registers the
   clients, so an id restated by hand is a sign-in that fails the day the
   registration changes. A client is named in lowercase letters, once. *)

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

let quoted = Text.quoted

let go (t : T.t) =
  let constant name docs value =
    Text.go_comment ~indent:"" (name ^ ": " ^ docs)
    ^ "\nconst " ^ name ^ " = " ^ quoted value ^ "\n"
  in
  let name (c : T.client) = String.capitalize_ascii c.name ^ "ClientID" in
  {
    Output.path = "go/oauthclients_gen.go";
    text =
      String.concat ""
        [
          {|// Code generated from protocol/specs/src/session/oauth.json — DO NOT EDIT.
//
// Regenerate: make generate (|};
          Banner.writer __FILE__;
          {|)
// The TypeScript (typescript/core/src/oauth-clients.ts), Rust
// (rust/sdk/build.rs) and Python (xynolog.oauth_clients) SDKs generate
// from the same file.

package xynolog

|};
          String.concat "\n"
            (List.map
               (fun (c : T.client) -> constant (name c) c.docs c.id)
               t.clients);
          "\n";
          constant "SignInScope" t.scope.docs t.scope.value;
        ];
  }

let python (t : T.t) =
  let constant name docs value =
    Text.python_comment ~indent:"" docs
    ^ "\n" ^ name ^ ": Final = " ^ quoted value ^ "\n"
  in
  let name (c : T.client) = String.uppercase_ascii c.name ^ "_CLIENT_ID" in
  {
    Output.path = "python/sdk/src/xynolog/oauth_clients.py";
    text =
      String.concat ""
        [
          Banner.python ~from_:"protocol/specs/src/session/oauth.json" __FILE__;
          {|
"""How a Xynolog client presents itself to the issuer a knowledge base trusts:
the clients its realm registers, and the scope every sign-in asks for.
"""

from typing import Final

__all__ = [
|};
          String.concat ""
            (List.map
               (fun n -> "    " ^ quoted n ^ ",\n")
               (List.sort compare ("SIGN_IN_SCOPE" :: List.map name t.clients)));
          "]\n\n";
          String.concat "\n"
            (List.map
               (fun (c : T.client) -> constant (name c) c.docs c.id)
               t.clients);
          "\n";
          constant "SIGN_IN_SCOPE" t.scope.docs t.scope.value;
        ];
  }

let typescript (t : T.t) =
  {
    Output.path = "typescript/core/src/oauth-clients.ts";
    text =
      String.concat ""
        [
          {|// ⚠ GENERATED FILE — do not edit.
//
// Authority:   protocol/specs/src/session/oauth.json
// Regenerate:  make generate  (|};
          Banner.writer __FILE__;
          ")\n\n";
          String.concat "\n"
            (List.map
               (fun (c : T.client) ->
                 Text.doc_comment c.docs ^ "\nexport const "
                 ^ String.uppercase_ascii c.name
                 ^ "_CLIENT_ID = " ^ quoted c.id ^ ";\n")
               t.clients);
          "\n";
          Text.doc_comment t.scope.docs;
          "\nexport const SIGN_IN_SCOPE = " ^ quoted t.scope.value ^ ";\n";
        ];
  }

(* The clients and the scope as the OCaml SDK names them
   (ocaml/sdk/lib/oauth_facts.ml): a client's id by its name, and the scope. *)
let ocaml (t : T.t) =
  {
    Output.path = "ocaml/sdk/lib/oauth_facts.ml";
    text =
      Banner.ocaml ~from_:file __FILE__
      ^ String.concat ""
          (List.map
             (fun (c : T.client) ->
               "let " ^ c.name ^ " = " ^ Text.ocaml_quoted c.id ^ "\n")
             t.clients)
      ^ "let scope = " ^ Text.ocaml_quoted t.scope.value ^ "\n";
  }

let files ~root:_ (spec : Spec.t) =
  Result.map
    (fun t -> [ go t; python t; typescript t; ocaml t ])
    (derive spec.tables.session_oauth)
