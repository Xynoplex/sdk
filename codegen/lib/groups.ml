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
    { name = "error-codes"; files = Error_codes.files };
    { name = "timing"; files = Timing.files };
    { name = "cache-refresh"; files = Cache_refresh.files };
    { name = "identifiers"; files = Identifiers.files };
    { name = "oauth-clients"; files = Oauth_clients.files };
    { name = "telemetry"; files = Telemetry.files };
    { name = "sign-in"; files = Sign_in.files };
    { name = "media-types"; files = Media_types.files };
  ]
