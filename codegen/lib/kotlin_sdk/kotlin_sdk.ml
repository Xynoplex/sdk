(* The kotlin-sdk group: Kotlin's types of the component schemas, a file
   each under xynolog/types, and the kinds of id in xynolog/identifiers, in
   kotlin/sdk/src/generated/kotlin. *)

module Names = Names
module Rule = Rule
module Types = Types
module K = Kotlin_syntax

let ( let* ) = Result.bind
let directory = "kotlin/sdk/src/generated/kotlin"
let types_directory = directory ^ "/xynolog/types"
let sign_in_file = "sign-in-store/SignIn.json"

(* The schemas a generation writes: every component schema of the gateway's
   document, and the sign-in store's entry, which is the store's own schema
   and no component of the API. *)
let spec_of (spec : Spec.t) : (Types.spec, string) result =
  let schema_of file = List.assoc_opt file spec.schemas in
  let components =
    List.map
      (fun (name, reference) -> (name, fst (Decode.resolve reference)))
      spec.gateway.components.schemas
  in
  let* definitions =
    List.fold_right
      (fun (name, file) rest ->
        let* rest = rest in
        match schema_of file with
        | Some schema -> Ok ((name, schema) :: rest)
        | None ->
            Error
              ("the component " ^ name ^ " names " ^ file
             ^ ", which the model has not read"))
      components (Ok [])
  in
  let* sign_in =
    match schema_of sign_in_file with
    | Some s -> Ok s
    | None -> Error (sign_in_file ^ " is not in the spec")
  in
  if List.mem_assoc "SignIn" definitions then
    Error "the API's components name a SignIn, which is the sign-in store's"
  else
    Ok
      {
        Types.definitions = definitions @ [ ("SignIn", sign_in) ];
        identifiers =
          List.map
            (fun (k : Tables.Identifiers_kinds.kind) -> k.schema)
            spec.tables.identifiers_kinds.kinds;
        component_of_file =
          List.map (fun (name, file) -> (file, name)) components;
      }

(* [spec_of], its refusal one of the gateway's document's. *)
let refused message =
  [ { Decode.file = "openapi.json"; pointer = ""; message } ]

let types_of spec = Result.map_error refused (spec_of spec)

let opt_in =
  K.annotation
    ~args:
      [
        K.arg
          (K.Class_literal "kotlinx.serialization.ExperimentalSerializationApi");
        K.arg (K.Class_literal "kotlin.ExperimentalStdlibApi");
      ]
    "OptIn"

let file ~package ~imports decls =
  K.text
    {
      banner =
        Banner.lines ~from_:"the component schemas in protocol/specs/src"
          __FILE__;
      file_annotations = [ opt_in ];
      package;
      imports = Types.imported @ imports;
      decls;
    }

let path package name =
  directory ^ "/"
  ^ String.map (function '.' -> '/' | c -> c) package
  ^ "/" ^ name ^ ".kt"

(* A file of data, opening with [banner]: no opt-in, and the imports and
   declarations it is given. *)
let data_file ~banner ~package ~name ~imports decls =
  {
    Output.path = path package name;
    text = K.text { banner; file_annotations = []; package; imports; decls };
  }

(* A table's file, which [writer] (its [__FILE__]) writes from Protocol's
   [from_]. *)
let table ~from_ writer =
  data_file ~banner:(Banner.lines ~from_:("protocol/specs/src/" ^ from_) writer)

(* What [write] writes, or the refusal it raises, made one of Protocol's
   [from_]. *)
let written ~from_ write =
  match write () with
  | written -> Ok written
  | exception Names.Refused message ->
      Error [ { Decode.file = from_; pointer = ""; message } ]

(* A file in the types' directory that no run writes: refused rather than
   removed, so the run that drops a schema names the file to delete with
   it. *)
let stale ~root written =
  let on_disk =
    match Sys.readdir (Filename.concat root types_directory) with
    | names -> List.sort String.compare (Array.to_list names)
    | exception Sys_error _ -> []
  in
  match
    List.find_opt
      (fun name -> not (List.mem (types_directory ^ "/" ^ name) written))
      on_disk
  with
  | Some name ->
      Error
        ("a generated file no schema writes: " ^ types_directory ^ "/" ^ name)
  | None -> Ok ()

let generate (spec : Spec.t) =
  let* types_spec = spec_of spec in
  match Types.generate types_spec with
  | exception Names.Refused message -> Error message
  | generated ->
      let kinds =
        List.map
          (fun kind -> Types.identifiers_package ^ "." ^ kind)
          types_spec.identifiers
      in
      Ok
        ({
           Output.path = path Types.identifiers_package "Identifiers";
           text =
             file ~package:Types.identifiers_package ~imports:[]
               generated.identifier_decls;
         }
        :: List.map
             (fun (name, decls) ->
               {
                 Output.path = path Types.types_package name;
                 text = file ~package:Types.types_package ~imports:kinds decls;
               })
             generated.types)

let files ~root (spec : Spec.t) =
  Result.map_error refused
    (let* files = generate spec in
     let* () = stale ~root (List.map (fun (f : Output.file) -> f.path) files) in
     Ok files)
