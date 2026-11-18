(* The kinds of id as the TypeScript SDK's core declares them
   (typescript/core/src/identifiers.ts): for each, its branded type, a guard
   and the one constructor that makes it, of the kind its rule makes. What the
   kinds share is the SDK's own (typescript/core/src/identifier.ts). The
   brands themselves are the typescript-types group's, in types.ts. *)

module T = Typescript_syntax

let path = "typescript/core/src/identifiers.ts"

let kind (k : Table.kind) =
  let name = k.name in
  let make = Go.lower name and rule = Text.upper_snake name in
  [
    T.type_alias name ~about:[ Doc k.description ] (T.schema name);
    T.const ~export:false rule
      (Call
         ( Instantiate (Name "identifierKind", [ T_name name ]),
           [ Str name; Str k.pattern ] ));
    T.const ("is" ^ name)
      ~about:
        [
          Doc
            (Printf.sprintf
               "Whether `value` is a `%s`: where text enters and what is not \
                an id is an answer, not a fault."
               name);
        ]
      (Member (Name rule, "is"));
    T.const make
      ~about:
        [
          Doc
            (Printf.sprintf
               "`value` as a `%s`. Throws a `TypeError` when the kind's rule \
                refuses it."
               name);
        ]
      (Member (Name rule, "of"));
  ]

let text kinds =
  T.text
    {
      banner =
        Banner.typescript_lines
          ~authority:
            [
              "protocol/specs/src/identifiers/kinds.json and each kind's schema";
            ]
          __FILE__;
      body =
        T.Comment
          [
            Block
              [
                "The kinds of id. Each is a type of its own, so one kind is \
                 not taken for";
                "another, and each is made by one constructor that holds text \
                 to the kind's";
                "rule, which is the schema's pattern; its guard asks the same \
                 of text without";
                "throwing. A constructor stands where text enters: a URL, a \
                 DOM attribute, a";
                "script's argument. What the gateway answers is typed already \
                 and is not";
                "checked again here.";
              ];
          ]
        :: T.Adjacent
             [
               T.import ~type_only:true [ "components" ] "./types";
               T.import [ "identifierKind" ] "./identifier";
             ]
        :: List.concat_map kind kinds;
    }

let file kinds = { Output.path; text = text kinds }
