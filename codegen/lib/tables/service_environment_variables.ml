(* specs/src/service-environment/variables.json *)

type variable = {
  name : string;
  services : string list;
  read_by : string;
  provided_by : string;
  required : bool;
  effect_ : string;
}

let variable =
  Decode.obj (fun o : variable ->
      {
        name = Decode.required o "name" Decode.string;
        services = Decode.required o "services" (Decode.list Decode.string);
        read_by = Decode.required o "readBy" Decode.string;
        provided_by = Decode.required o "providedBy" Decode.string;
        required = Decode.required o "required" Decode.bool;
        effect_ = Decode.required o "effect" Decode.string;
      })

type t = { comment : string; variables : variable list }

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        variables = Decode.required o "variables" (Decode.list variable);
      })
