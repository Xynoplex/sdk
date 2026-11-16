(* specs/src/control/methods.json *)

type method_ = {
  name : string;
  params : string;
  result : string;
  exclusive : bool;
  sends : string list;
  docs : string;
}

let method_ =
  Decode.obj (fun o : method_ ->
      {
        name = Decode.required o "name" Decode.string;
        params = Decode.required o "params" Decode.string;
        result = Decode.required o "result" Decode.string;
        exclusive = Decode.required o "exclusive" Decode.bool;
        sends = Decode.required o "sends" (Decode.list Decode.string);
        docs = Decode.required o "docs" Decode.string;
      })

type notification = {
  name : string;
  from : string;
  params : string;
  docs : string;
}

let notification =
  Decode.obj (fun o : notification ->
      {
        name = Decode.required o "name" Decode.string;
        from = Decode.required o "from" Decode.string;
        params = Decode.required o "params" Decode.string;
        docs = Decode.required o "docs" Decode.string;
      })

type t = {
  comment : string;
  api_version : string;
  error_data : string;
  methods : method_ list;
  notifications : notification list;
}

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        api_version = Decode.required o "apiVersion" Decode.string;
        error_data = Decode.required o "errorData" Decode.string;
        methods = Decode.required o "methods" (Decode.list method_);
        notifications =
          Decode.required o "notifications" (Decode.list notification);
      })
