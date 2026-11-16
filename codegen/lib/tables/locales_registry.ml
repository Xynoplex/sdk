(* specs/src/locales/registry.json *)

type locale = { code : string; native_name : string; english_name : string }

let locale =
  Decode.obj (fun o : locale ->
      {
        code = Decode.required o "code" Decode.string;
        native_name = Decode.required o "nativeName" Decode.string;
        english_name = Decode.required o "englishName" Decode.string;
      })

type t = { comment : string; locales : locale list }

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        locales = Decode.required o "locales" (Decode.list locale);
      })
