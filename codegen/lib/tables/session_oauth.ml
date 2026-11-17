(* specs/src/session/oauth.json *)

type client = { name : string; id : string; docs : string }

let client =
  Decode.obj (fun o : client ->
      {
        name = Decode.required o "name" Decode.non_empty_string;
        id = Decode.required o "id" Decode.non_empty_string;
        docs = Decode.required o "docs" Decode.non_empty_string;
      })

type scope = { value : string; docs : string }

let scope =
  Decode.obj (fun o : scope ->
      {
        value = Decode.required o "value" Decode.non_empty_string;
        docs = Decode.required o "docs" Decode.non_empty_string;
      })

type t = { comment : string; clients : client list; scope : scope }

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        clients = Decode.required o "clients" (Decode.non_empty_list client);
        scope = Decode.required o "scope" scope;
      })
