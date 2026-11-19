(* The bundles group: the documents the Rust services embed
   (packages/rust/core/src/spec.rs), the gateway's API and the Archivist's,
   each as the reader bundles it ([Bundle.document]), and the gateway's
   component schemas and the services' own ([Bundle.services]) as JSON Schema
   draft 7, which a service validates a request, a bus payload and its
   configuration against. The gateway serves its document as it is written
   here. *)

let directory = "packages/rust/core/src/generated/"
let gateway = "openapi.json"
let archivist = "archivist/openapi.json"

let bundled = function
  | Ok json -> json
  | Error error -> raise (Documents.Refused error)

let derive ~root =
  let specs = Documents.specs ~root in
  let document file = bundled (Bundle.document ~specs file) in
  let gateway_document = document gateway in
  [
    {
      Output.path = directory ^ "openapi.json";
      text = Documents.text gateway_document;
    };
    {
      Output.path = directory ^ "archivist.openapi.json";
      text = Documents.text (document archivist);
    };
    {
      Output.path = directory ^ "schemas.json";
      text =
        Documents.text
          (Documents.definitions
             [
               (gateway, gateway_document);
               ("services.json", bundled (Bundle.services ~specs));
             ]);
    };
  ]

let files ~root (_ : Spec.t) =
  match derive ~root with
  | files -> Ok files
  | exception Documents.Refused error -> Error [ error ]
