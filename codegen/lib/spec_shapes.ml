(* Protocol's spec as the generators read it: each schema file's schema
   without the [$schema] and [$id] that identify the file. A generator reads
   what a schema admits, and which file a reference names is [Spec.t]'s
   [ids] to say; so no generator sees identification, and none merges one
   schema's [$id] into another ([Normalize]). *)

let shape : Schema.t -> Schema.t = function
  | Schema.Schema s -> Schema.Schema { s with schema = None; id = None }
  | Boolean_schema _ as b -> b

let load specs =
  Result.map
    (fun (spec : Spec.t) ->
      {
        spec with
        schemas = List.map (fun (file, s) -> (file, shape s)) spec.schemas;
      })
    (Spec.load specs)
