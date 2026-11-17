(* The client types group: the shapes an SDK hands its callers that no wire
   message carries (protocol/specs/src/client/types), and the form a service
   account posts with a client secret (session/ClientSecretForm.json), for the
   Haskell SDK. *)

module Model = Model
module Haskell = Haskell

let files ~root:_ (spec : Spec.t) =
  Result.bind (Model.derive spec) (fun t ->
      let shape = Model.shape t in
      Result.map List.concat
        (Haskell.all
           [
             Result.map
               (fun file -> [ file ])
               (Haskell.pending_annotation ~shape);
             Result.map (fun file -> [ file ]) (Haskell.search_state ~shape);
             Result.map
               (fun file -> [ file ])
               (Haskell.operation_reports ~shape);
             Result.map
               (fun file -> [ file ])
               (Haskell.service_proof ~grant_type:t.grant_type t.form);
           ]))
