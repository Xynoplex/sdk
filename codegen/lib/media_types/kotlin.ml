(* The media types as the Kotlin SDK reads them (xynolog.mediatypes): the
   registry's text sources, and each row's media type, extension, text
   source and whether a person authors it and a generation writes it, as the
   hand-written MediaType holds them. [from_] is the registry's file. *)

module K = Kotlin_syntax
module T = Tables.Media_types_registry

let source word =
  K.Member (K.Name "TextSource", Kotlin_sdk.Names.variant_of word)

let file ~from_ (t : T.t) =
  Kotlin_sdk.table ~from_ __FILE__ ~package:"xynolog.mediatypes"
    ~name:"MediaTypesTable" ~imports:[]
    [
      K.class_
        ~about:
          (K.Doc
             "Where a type's text comes from: decoded from its own bytes, \
              derived by reading them, or nowhere.")
        ~visibility:K.Internal
        ~constructor:
          (K.constructor
             [
               K.param ~about:(K.Doc "The word as the registry spells it.")
                 ~binding:(K.Bound { visibility = K.Default; mutable_ = false })
                 "word" (K.Type "String");
             ])
        ~entries:
          (List.map
             (fun word ->
               K.entry ~args:[ K.Str word ] (Kotlin_sdk.Names.variant_of word))
             t.text_source)
        K.Enum_class "TextSource";
      K.property
        ~about:
          (K.Doc
             (Printf.sprintf "The registry, in its own order: %d media types."
                (List.length t.media_types)))
        ~visibility:K.Internal
        ~type_:(K.Generic ("List", [ K.Type "MediaType" ]))
        ~value:
          (K.Same_line
             (K.call ~layout:K.Lines (K.Name "listOf")
                (List.map
                   (fun (row : T.media_type) ->
                     K.call (K.Name "MediaType")
                       [
                         K.Str row.media_type;
                         K.Str row.extension;
                         source row.text_source;
                         K.Bool row.authorable;
                         K.Bool row.generatable;
                       ])
                   t.media_types)))
        "MEDIA_TYPES";
    ]
