(* The swift-sdk group: the Swift SDK's models of every component schema and
   the sign-in store's entry, with the tables as typed values
   (swift/sdk/Sources/Xynolog/Generated/Models.swift), and its test bridge
   (swift/sdk/Tests/XynologTests/Generated/TestBridge.swift). Models declares
   the schemas, Table_decls the tables, Test_bridge the bridge. *)

module Models = Models
module Spec_values = Spec_values
module Table_decls = Table_decls
module Test_bridge = Test_bridge
module S = Swift_syntax
module D = Definitions

let models_path = "swift/sdk/Sources/Xynolog/Generated/Models.swift"
let bridge_path = "swift/sdk/Tests/XynologTests/Generated/TestBridge.swift"
let sign_in_file = "sign-in-store/SignIn.json"
let banner = Banner.swift_lines ~from_:"protocol/specs/src" __FILE__
let import module_ = { S.module_; testable = false }

(* The two files, as Swift. *)
let swift_files (spec : Spec.t) =
  let ( let* ) = Result.bind in
  let* derivation = Required.derive spec in
  let* timing = Timing.Table.derive spec.tables.client_timing in
  let* wire_codes = Error_codes.Table.wire_codes spec in
  let* codes = Error_codes.Table.derive ~wire_codes spec.tables.errors_codes in
  match
    let bundle = D.bundle spec in
    let sign_in =
      match List.assoc_opt sign_in_file spec.schemas with
      | Some s -> bundle.view s
      | None -> D.refuse "Protocol has no %s" sign_in_file
    in
    let definitions =
      {
        D.names = List.sort String.compare ("SignIn" :: bundle.definitions.names);
        schema =
          (fun n ->
            if n = "SignIn" then sign_in else bundle.definitions.schema n);
      }
    in
    let identifiers =
      List.sort String.compare
        (List.map
           (fun (k : Tables.Identifiers_kinds.kind) -> k.schema)
           spec.tables.identifiers_kinds.kinds)
    in
    let models = Models.create definitions ~identifiers in
    let tables =
      Table_decls.declarations models ~spec ~view:bundle.view
        ~shapes:derivation.shapes ~timing ~codes ~wire_codes
    in
    Models.generate models;
    let models_file =
      {
        S.banner;
        imports = [ import "Foundation" ];
        decls =
          List.map (fun d -> (S.Blank, d)) (Models.declarations models)
          @ List.mapi
              (fun i d -> ((if i = 0 then S.Blank else S.Line), d))
              tables;
      }
    in
    let bridge =
      {
        S.banner;
        imports =
          [
            import "Foundation";
            import "Testing";
            { module_ = "Xynolog"; testable = true };
          ];
        decls = Test_bridge.decls ~names:definitions.names ~identifiers;
      }
    in
    [ (models_path, models_file); (bridge_path, bridge) ]
  with
  | files -> Ok files
  | exception D.Refused message ->
      Error [ { Decode.file = "openapi.json"; pointer = ""; message } ]

let files ~root:_ spec =
  Result.map
    (List.map (fun (path, file) -> { Output.path; text = S.print file }))
    (swift_files spec)
