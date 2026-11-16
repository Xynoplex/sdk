(* specs/src/jobs/storage.json *)

type stream = { name : string; subject_root : string }

let stream =
  Decode.obj (fun o : stream ->
      {
        name = Decode.required o "name" Decode.string;
        subject_root = Decode.required o "subjectRoot" Decode.string;
      })

type consumer = { durable_name : string }

let consumer =
  Decode.obj (fun o : consumer ->
      { durable_name = Decode.required o "durableName" Decode.string })

type bucket = { name : string; record : string }

let bucket =
  Decode.obj (fun o : bucket ->
      {
        name = Decode.required o "name" Decode.string;
        record = Decode.required o "record" Decode.string;
      })

type t = {
  comment : string;
  stream : stream;
  consumer : consumer;
  bucket : bucket;
}

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        stream = Decode.required o "stream" stream;
        consumer = Decode.required o "consumer" consumer;
        bucket = Decode.required o "bucket" bucket;
      })
