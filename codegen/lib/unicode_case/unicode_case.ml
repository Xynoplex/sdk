(* The unicode-case group: the code points Unicode gives the Cased and the
   Case_Ignorable property, which decide whether a capital sigma ends a word
   as the case-insensitive search lower-cases it
   (protocol/specs/src/annotations/reconcile-cases.json). Neither .NET, the
   JDK nor Go's unicode package gives the two, so their SDKs are given them,
   from Unicode's own DerivedCoreProperties.txt (codegen/ucd). *)

module Json = Json
module Go = Go

let source = "codegen/ucd/DerivedCoreProperties.txt"

let files ~root (_ : Spec.t) =
  let ( let* ) = Result.bind in
  let* ucd =
    Result.map_error
      (fun error -> [ error ])
      (Ucd.read ~file:source
         (In_channel.with_open_bin
            (Filename.concat root source)
            In_channel.input_all))
  in
  let property name =
    match Ucd.ranges ucd name with
    | Some ranges -> Ok ranges
    | None ->
        Error
          [
            {
              Decode.file = source;
              pointer = "";
              message =
                Printf.sprintf "gives no code point the %s property" name;
            };
          ]
  in
  let* cased = property "Cased" in
  let* case_ignorable = property "Case_Ignorable" in
  let version = ucd.version in
  Ok
    (Json.files ~version ~cased ~case_ignorable
    @ [ Go.file ~version ~cased ~case_ignorable ])
