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
    (fun i (l : T.locales_item) ->
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
         List.find_index (fun (o : T.locales_item) -> o.code = l.code) t.locales
       with
      | Some j when j < i ->
          refuse (at ^ "/code")
            (Printf.sprintf "is %s, which /locales/%d states already" l.code j)
      | _ -> ());
      if l.native_name = "" then refuse (at ^ "/nativeName") "is empty";
      if l.english_name = "" then refuse (at ^ "/englishName") "is empty")
    t.locales;
  match List.rev !refusals with [] -> Ok t | errors -> Error errors

let typescript (t : T.t) =
  let module S = Typescript_syntax in
  let text value = S.Str value in
  {
    Output.path = "typescript/core/src/locale-registry.ts";
    text =
      S.text
        {
          banner =
            Banner.typescript_lines
              ~authority:[ "protocol/specs/src/" ^ file ]
              __FILE__;
          body =
            [
              S.const "LOCALE_CODES" ~as_const:true
                ~about:
                  [
                    Doc
                      "The code of every supported language, in the registry's \
                       order.";
                  ]
                (S.strings
                   (List.map (fun (l : T.locales_item) -> l.code) t.locales));
              S.type_alias "LocaleCode"
                ~about:[ Doc "The code of a supported language." ]
                (T_index (T_paren (T_typeof "LOCALE_CODES"), T_name "number"));
              S.Interface
                {
                  about =
                    [
                      Doc
                        "A supported language: its code, what it calls itself, \
                         and its name in English.";
                    ];
                  export = true;
                  name = "LocaleInfo";
                  members =
                    [
                      S.member (Ident "code") (T_name "LocaleCode");
                      S.member (Ident "nativeName") (T_name "string");
                      S.member (Ident "englishName") (T_name "string");
                    ];
                };
              S.const "LOCALES"
                ~about:
                  [
                    Doc "A row per supported language, in the registry's order.";
                  ]
                ~annotation:(T_readonly (T_array (T_name "LocaleInfo")))
                (S.array
                   (List.map
                      (fun (l : T.locales_item) ->
                        S.Object
                          {
                            layout = Inline;
                            entries =
                              [
                                S.entry (Ident "code") (text l.code);
                                S.entry (Ident "nativeName")
                                  (text l.native_name);
                                S.entry (Ident "englishName")
                                  (text l.english_name);
                              ];
                          })
                      t.locales));
            ];
        };
  }

let files ~root:_ (spec : Spec.t) =
  Result.map (fun t -> [ typescript t ]) (derive spec.tables.locales_registry)
