(* Every generation group, by the name make generate and make check-generated
   run it under. A group writes its files from the model, and refuses a spec
   that breaks a rule its files rely on. *)

type group = {
  name : string;
  files : specs:string -> Spec.t -> (Output.file list, Decode.error list) result;
}

let all = [ { name = "bus"; files = Bus.files } ]
