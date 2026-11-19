(* The bundles group: the documents the Rust services embed
   (packages/rust/core/src/spec.rs), the gateway's API and the Archivist's,
   each whole (Documents), and the gateway's component schemas and every
   service's own ([Spec.services]) as JSON Schema draft 7, which a service
   validates a request, a bus payload and its configuration against. The
   gateway serves its document as it is written here. *)

let directory = "packages/rust/core/src/generated/"
let gateway = "openapi.json"
let archivist = "archivist/openapi.json"

let derive ~root (spec : Spec.t) =
  [
    {
      Output.path = directory ^ "openapi.json";
      text = Documents.text (Documents.document ~root ~beside:[] gateway);
    };
    {
      Output.path = directory ^ "archivist.openapi.json";
      text = Documents.text (Documents.document ~root ~beside:[] archivist);
    };
    {
      Output.path = directory ^ "schemas.json";
      text =
        Documents.text
          (Documents.definitions gateway
             (Documents.document ~root ~beside:spec.services gateway));
    };
  ]

let files ~root spec =
  match derive ~root spec with
  | files -> Ok files
  | exception Documents.Refused error -> Error [ error ]
