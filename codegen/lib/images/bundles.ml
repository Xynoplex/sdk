(* The bundles group: the documents the Rust services embed
   (packages/rust/core/src/spec.rs), the gateway's API and the Archivist's,
   each whole (Documents), and the gateway's component schemas as JSON
   Schema draft 7, which a service validates a request and a bus payload
   against. The gateway serves its document as it is written here. *)

let directory = "packages/rust/core/src/generated/"
let gateway = "openapi.json"
let archivist = "archivist/openapi.json"

let derive ~root =
  let gateway_document = Documents.document ~root gateway in
  [
    {
      Output.path = directory ^ "openapi.json";
      text = Documents.text gateway_document;
    };
    {
      Output.path = directory ^ "archivist.openapi.json";
      text = Documents.text (Documents.document ~root archivist);
    };
    {
      Output.path = directory ^ "schemas.json";
      text = Documents.text (Documents.definitions gateway gateway_document);
    };
  ]

let files ~root (_ : Spec.t) =
  match derive ~root with
  | files -> Ok files
  | exception Documents.Refused error -> Error [ error ]
