(* What every generated C# type that System.Text.Json reads and writes
   states: the attribute that names its converter, and the converter, a
   [Read] and a [Write] over the type. *)

module C = Csharp_syntax

let json name = "global::System.Text.Json." ^ name
let name type_name = type_name ^ "JsonConverter"

let attribute type_name : C.attribute =
  {
    name = json "Serialization.JsonConverter";
    args = [ C.Typeof (C.T (name type_name)) ];
  }

let param by type_ name : C.param = { by; type_; name }

let converter type_name ~read ~write =
  let t = C.T type_name in
  C.Type
    {
      attributes = [];
      modifiers = [ Internal; Sealed ];
      kind = Class;
      name = name type_name;
      params = None;
      base = Some (C.Generic (json "Serialization.JsonConverter", [ t ]));
      body =
        Some
          ( Spaced,
            [
              C.Method
                {
                  modifiers = [ Public; Override ];
                  returns = t;
                  name = "Read";
                  params =
                    [
                      param `Ref (C.T (json "Utf8JsonReader")) "reader";
                      param `Value (C.T "global::System.Type") "type";
                      param `Value
                        (C.T (json "JsonSerializerOptions"))
                        "options";
                    ];
                  body = Block read;
                };
              C.Method
                {
                  modifiers = [ Public; Override ];
                  returns = C.T "void";
                  name = "Write";
                  params =
                    [
                      param `Value (C.T (json "Utf8JsonWriter")) "writer";
                      param `Value t "value";
                      param `Value
                        (C.T (json "JsonSerializerOptions"))
                        "options";
                    ];
                  body = Block write;
                };
            ] );
    }
