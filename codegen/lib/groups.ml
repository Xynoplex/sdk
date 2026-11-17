(* Every generation group, by the name make generate and make check-generated
   run it under. A group writes its files from the model, and refuses a spec
   that breaks a rule its files rely on. [root] is the sdk checkout, for a
   group that holds its files to what another generator wrote there. *)

type group = {
  name : string;
  files : root:string -> Spec.t -> (Output.file list, Decode.error list) result;
}

let all =
  [
    { name = "bus"; files = Bus.files };
    { name = "required"; files = Required.files };
    { name = "unicode-case"; files = Unicode_case.files };
    { name = "encodings"; files = Encodings.files };
  ]
