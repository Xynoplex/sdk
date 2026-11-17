(* The locales group: the languages Xynolog supports, and what each is called
   (protocol/specs/src/locales/registry.json), for the TypeScript SDK. The
   interface is read in one of them and a resource is written in one of them,
   so the frontend and the workers that tell a model what language a text is
   in read this one table. A language is a lower-case code of two or three
   letters, stated once, with its native and its English name. *)

module T = Tables.Locales_registry

let file = "locales/registry.json"

let derive (t : T.t) =
  let refusals = ref [] in
  let refuse pointer message =
    refusals := { Decode.file; pointer; message } :: !refusals
  in
  if t.locales = [] then refuse "/locales" "states no languages";
  List.iteri
    (fun i (l : T.locale) ->
      let at = Printf.sprintf "/locales/%d" i in
      let n = String.length l.code in
      if
        not
          (n >= 2 && n <= 3
          && String.for_all (function 'a' .. 'z' -> true | _ -> false) l.code)
      then
        refuse (at ^ "/code")
          (Printf.sprintf "is %S, not a lower-case language code" l.code);
      (match
         List.find_index (fun (o : T.locale) -> o.code = l.code) t.locales
       with
      | Some j when j < i ->
          refuse (at ^ "/code")
            (Printf.sprintf "is %s, which /locales/%d states already" l.code j)
      | _ -> ());
      if l.native_name = "" then refuse (at ^ "/nativeName") "is empty";
      if l.english_name = "" then refuse (at ^ "/englishName") "is empty")
    t.locales;
  match List.rev !refusals with [] -> Ok t | errors -> Error errors

(* A TypeScript string in single quotes. *)
let text value =
  "'"
  ^ Text.replace_all ~sub:"'" ~by:"\\'"
      (Text.replace_all ~sub:"\\" ~by:"\\\\" value)
  ^ "'"

let typescript (t : T.t) =
  {
    Output.path = "typescript/core/src/locale-registry.ts";
    text =
      String.concat ""
        [
          "// ⚠ GENERATED FILE — do not edit.\n\
           //\n\
           // Authority:   protocol/specs/src/" ^ file
          ^ "\n// Regenerate:  make generate  (";
          Banner.writer __FILE__;
          ")\n\n\
           /** The code of every supported language, in the registry's order. */\n\
           export const LOCALE_CODES = [";
          String.concat ", "
            (List.map (fun (l : T.locale) -> text l.code) t.locales);
          {|] as const;

/** The code of a supported language. */
export type LocaleCode = (typeof LOCALE_CODES)[number];

/** A supported language: its code, what it calls itself, and its name in English. */
export interface LocaleInfo {
  code: LocaleCode;
  nativeName: string;
  englishName: string;
}

/** A row per supported language, in the registry's order. */
export const LOCALES: readonly LocaleInfo[] = [
|};
          String.concat ""
            (List.map
               (fun (l : T.locale) ->
                 "  { code: " ^ text l.code ^ ", nativeName: "
                 ^ text l.native_name ^ ", englishName: " ^ text l.english_name
                 ^ " },\n")
               t.locales);
          "];\n";
        ];
  }

let files ~root:_ (spec : Spec.t) =
  Result.map (fun t -> [ typescript t ]) (derive spec.tables.locales_registry)
