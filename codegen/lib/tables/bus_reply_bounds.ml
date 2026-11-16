(* specs/src/bus/reply-bounds.json *)

type reply_item = { grows : string option; by : string option }

let reply_item =
  Decode.obj (fun o : reply_item ->
      {
        grows = Decode.optional o "grows" Decode.string;
        by = Decode.optional o "by" Decode.string;
      })

type t = {
  comment : string;
  replies : (string * (string * reply_item) list) list;
}

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        replies =
          Decode.required o "replies" (Decode.map (Decode.map reply_item));
      })
