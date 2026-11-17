(* The unicode-case group: what Unicode's default lower-casing needs that a
   runtime may not give, as the case-insensitive search lower-cases
   (protocol/specs/src/annotations/reconcile-cases.json):
   - the code points Unicode gives the Cased and the Case_Ignorable property,
     which decide whether a capital sigma ends a word. Neither .NET, the JDK,
     Go's unicode package nor Haskell's Data.Char gives the two;
   - for Haskell, whose Data.Text lower-cases by the unconditional mappings
     alone, every code point's full lower-case mapping, the one rule of
     context no language decides (Final_Sigma), and the White_Space
     property.
   All are read from Unicode's own files (codegen/ucd), of one version. *)

module Json = Json
module Go = Go
module Haskell = Haskell
module Kotlin = Kotlin

let derived_core = "codegen/ucd/DerivedCoreProperties.txt"
let prop_list = "codegen/ucd/PropList.txt"
let unicode_data = "codegen/ucd/UnicodeData.txt"
let special_casing = "codegen/ucd/SpecialCasing.txt"

type t = {
  version : string;
  notice : string list;
      (** Unicode's licence, which every file written from its data carries. *)
  cased : (int * int) list;
  case_ignorable : (int * int) list;
  white_space : (int * int) list;
  lowercase : (int * int list) list;
      (** Each code point that lower-cases to other code points, ascending. *)
  final_lowercase : (int * int list) list;
      (** Each that lower-cases otherwise where it ends a word. *)
}

let refusal file message = { Decode.file; pointer = ""; message }

(* The full lower-case mappings: SpecialCasing's that always hold, and
   UnicodeData's simple one for every other code point; each a mapping only
   where it changes the code point. *)
let lowercase ~simple ~special =
  let always =
    List.filter_map
      (fun { Ucd.code; lower; conditions } ->
        if conditions = [] then Some (code, lower) else None)
      special
  in
  let full = Hashtbl.create 2048 in
  List.iter (fun (code, lower) -> Hashtbl.replace full code [ lower ]) simple;
  List.iter (fun (code, lower) -> Hashtbl.replace full code lower) always;
  List.sort compare
    (Hashtbl.fold
       (fun code lower rows ->
         if lower = [ code ] then rows else (code, lower) :: rows)
       full [])

(* SpecialCasing's rows of context alone, refusing any but Final_Sigma: a
   language's rows (lt, tr, az) are that locale's, and the search
   lower-cases by none. *)
let final_lowercase ~special ~lowercase =
  let is_language condition =
    String.for_all (function 'a' .. 'z' -> true | _ -> false) condition
  in
  let ( let* ) = Result.bind in
  let* rows =
    List.fold_left
      (fun rows { Ucd.code; lower; conditions } ->
        let* rows = rows in
        match conditions with
        | [] -> Ok rows
        | conditions when List.exists is_language conditions -> Ok rows
        | [ "Final_Sigma" ] -> Ok ((code, lower) :: rows)
        | _ ->
            Error
              [
                refusal special_casing
                  (Printf.sprintf
                     "%04X lower-cases by %s, a context no language decides \
                      that the SDKs do not implement"
                     code
                     (String.concat " " conditions));
              ])
      (Ok []) special
  in
  let unconditional code =
    Option.value ~default:[ code ] (List.assoc_opt code lowercase)
  in
  Ok
    (List.sort compare
       (List.filter (fun (code, lower) -> lower <> unconditional code) rows))

let read_file ~root file read =
  Result.map_error
    (fun error -> [ error ])
    (read ~file
       (In_channel.with_open_bin
          (Filename.concat root file)
          In_channel.input_all))

let property (ucd : Ucd.t) file name =
  match Ucd.ranges ucd name with
  | Some ranges -> Ok ranges
  | None ->
      Error
        [
          refusal file
            (Printf.sprintf "gives no code point the %s property" name);
        ]

let derive ~root =
  let ( let* ) = Result.bind in
  let* core = read_file ~root derived_core Ucd.read in
  let* props = read_file ~root prop_list Ucd.read in
  let* simple = read_file ~root unicode_data Ucd.simple_lowercase in
  let* special_version, special =
    read_file ~root special_casing Ucd.special_casing
  in
  let* () =
    match
      List.filter
        (fun (_, version) -> version <> core.version)
        [ (prop_list, props.version); (special_casing, special_version) ]
    with
    | [] -> Ok ()
    | others ->
        Error
          (List.map
             (fun (file, version) ->
               refusal file
                 (Printf.sprintf "is Unicode %s's, where %s is %s's" version
                    derived_core core.version))
             others)
  in
  let* cased = property core derived_core "Cased" in
  let* case_ignorable = property core derived_core "Case_Ignorable" in
  let* white_space = property props prop_list "White_Space" in
  let lowercase = lowercase ~simple ~special in
  let* final_lowercase = final_lowercase ~special ~lowercase in
  let notice =
    Ucd.notice
      (In_channel.with_open_bin
         (Filename.concat root Ucd.license_file)
         In_channel.input_all)
  in
  Ok
    {
      version = core.version;
      notice;
      cased;
      case_ignorable;
      white_space;
      lowercase;
      final_lowercase;
    }

let files ~root (_ : Spec.t) =
  Result.bind (derive ~root) (fun t ->
      Result.map
        (fun kotlin ->
          Json.files ~version:t.version ~notice:t.notice ~cased:t.cased
            ~case_ignorable:t.case_ignorable
          @ [
              Go.file ~version:t.version ~notice:t.notice ~cased:t.cased
                ~case_ignorable:t.case_ignorable;
              Haskell.file ~version:t.version ~notice:t.notice ~cased:t.cased
                ~case_ignorable:t.case_ignorable ~white_space:t.white_space
                ~lowercase:t.lowercase ~final_lowercase:t.final_lowercase;
              kotlin;
            ])
        (Kotlin_sdk.written ~from_:derived_core (fun () ->
             Kotlin.file ~version:t.version ~notice:t.notice ~cased:t.cased
               ~case_ignorable:t.case_ignorable)))
