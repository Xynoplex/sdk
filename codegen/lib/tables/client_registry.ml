(* specs/src/client/registry.json *)

type t = { comment : string; types : (string * Schema.t) list }

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        types = Decode.required o "types" (Decode.map Schema.decode);
      })
