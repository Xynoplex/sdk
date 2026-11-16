(* specs/src/identifiers/kinds.json *)

type accept = { id : string; why : string }

let accept =
  Decode.obj (fun o : accept ->
      {
        id = Decode.required o "id" Decode.string;
        why = Decode.required o "why" Decode.string;
      })

type refuse = { id : string; why : string }

let refuse =
  Decode.obj (fun o : refuse ->
      {
        id = Decode.required o "id" Decode.string;
        why = Decode.required o "why" Decode.string;
      })

type kind = {
  schema : string;
  properties : string list;
  accepts : accept list;
  refuses : refuse list;
}

let kind =
  Decode.obj (fun o : kind ->
      {
        schema = Decode.required o "schema" Decode.string;
        properties = Decode.required o "properties" (Decode.list Decode.string);
        accepts = Decode.required o "accepts" (Decode.list accept);
        refuses = Decode.required o "refuses" (Decode.list refuse);
      })

type other = { property : string; docs : string }

let other =
  Decode.obj (fun o : other ->
      {
        property = Decode.required o "property" Decode.string;
        docs = Decode.required o "docs" Decode.string;
      })

type t = { comment : string; kinds : kind list; others : other list }

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        kinds = Decode.required o "kinds" (Decode.list kind);
        others = Decode.required o "others" (Decode.list other);
      })
