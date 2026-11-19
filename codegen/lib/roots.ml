(* The schemas a generation is rooted on, by name: every component schema of
   the gateway's document, and every service's own ([Spec.services]), named
   by its file's stem, its reference the file's to itself.
   [Definitions.bundle] refuses two of one name. *)

let services (spec : Spec.t) =
  List.map
    (fun file ->
      ( Filename.remove_extension (Filename.basename file),
        { Decode.target = Filename.basename file; file; pointer = "" } ))
    spec.services

let all (spec : Spec.t) = spec.gateway.components.schemas @ services spec
