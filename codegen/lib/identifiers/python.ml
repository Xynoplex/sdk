(* The kinds of id as the Python SDK declares them
   (python/sdk/src/xynolog/identifiers.py): a str subclass for each, made only
   through the kind's rule, which Python asks of the whole text. What the
   kinds share is the SDK's own (python/sdk/src/xynolog/_identifier.py). *)

module P = Python_syntax

let path = "python/sdk/src/xynolog/identifiers.py"
let class_var type_ = P.sub "ClassVar" [ P.item type_ ]

let kind (k : Table.kind) =
  P.Class
    {
      decorators = [ P.Name "final" ];
      name = k.name;
      bases = [ P.item (P.Name "Identifier") ];
      doc = Some (Wrapped k.description);
      spacing = Packed;
      body =
        [
          P.assign "__slots__" ~value:(P.tuple []);
          P.assign "PATTERN" ~annotation:(class_var (P.Name "str"))
            ~value:(P.Str k.pattern);
          P.assign "_RULE"
            ~annotation:
              (class_var (P.sub "re.Pattern" [ P.item (P.Name "str") ]))
            ~value:(P.call "re.compile" [ P.item (P.Str k.whole) ]);
        ];
    }

let text (kinds : Table.kind list) =
  P.text
    {
      header =
        Banner.python_lines
          ~from_:
            "protocol/specs/src/identifiers/kinds.json and each kind's schema"
          __FILE__;
      doc =
        As_is
          "The kinds of id.\n\n\
           A value of one of these types is text that passed its kind's rule, \
           which is the\n\
           schema's pattern. It is made here and nowhere else: by the kind's \
           constructor,\n\
           which raises `InvalidIdentifier` for text the rule refuses, by \
           `parse`, which\n\
           answers `None` instead, and by decoding, which goes through the \
           same rule. It\n\
           is a `str`, so it reads as the text it is. One kind is not another: \
           a type\n\
           checker refuses a `ResourceId` where an `AnnotationId` is wanted.\n";
      imports =
        [
          [ P.Import "re"; P.From ("typing", [ "ClassVar"; "final" ]) ];
          [
            P.From ("xynolog._identifier", [ "Identifier"; "InvalidIdentifier" ]);
          ];
        ];
      body =
        P.assign "__all__"
          ~value:
            (P.List
               (P.items
                  (List.map
                     (fun n -> P.item (P.Str n))
                     (List.sort compare
                        ("InvalidIdentifier"
                        :: List.map (fun (k : Table.kind) -> k.name) kinds)))))
        :: List.map kind kinds;
    }

let file kinds = { Output.path; text = text kinds }
