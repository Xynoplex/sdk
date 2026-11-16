(* specs/src/control/cli.json *)

type flag = {
  cli_only : string option;
  fields : string list option;
  notes : string option;
  method_ : string option;
}

let flag =
  Decode.obj (fun o : flag ->
      {
        cli_only = Decode.optional o "cliOnly" Decode.string;
        fields = Decode.optional o "fields" (Decode.list Decode.string);
        notes = Decode.optional o "notes" Decode.string;
        method_ = Decode.optional o "method" Decode.string;
      })

type positional = {
  name : string;
  fields : string list option;
  cli_only : string option;
}

let positional =
  Decode.obj (fun o : positional ->
      {
        name = Decode.required o "name" Decode.string;
        fields = Decode.optional o "fields" (Decode.list Decode.string);
        cli_only = Decode.optional o "cliOnly" Decode.string;
      })

type command = {
  parser : string;
  method_ : string;
  flags : (string * flag) list;
  positionals : positional list option;
}

let command =
  Decode.obj (fun o : command ->
      {
        parser = Decode.required o "parser" Decode.string;
        method_ = Decode.required o "method" Decode.string;
        flags = Decode.required o "flags" (Decode.map flag);
        positionals = Decode.optional o "positionals" (Decode.list positional);
      })

type t = { comment : string; commands : (string * command) list }

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        commands = Decode.required o "commands" (Decode.map command);
      })
