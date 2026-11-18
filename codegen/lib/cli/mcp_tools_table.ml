(* cli's internal/launcher/verbs/mcp-tools.json: the tools `xynolog mcp`
   serves, a curated set the launcher owns. Its $comment states its forms;
   this reads them strictly, so a form the table adds stops the run until
   the mcp-tools group renders it. *)

let file = "internal/launcher/verbs/mcp-tools.json"

(* A member of a component schema, by the component's name. *)
type member = { from : string; member : string }

(* What an argument or a result member is when it is no member of a
   component: a whole component, a list of a component or of a member of
   one, or the tool's own schema (the MCP layer's, not the spec's). *)
type form =
  | Component of string
  | List_of_component of string
  | List_of_member of member
  | Own of Yojson.Safe.t

type argument =
  | Of_member of { of_ : member; optional : string option }
      (** [optional] is why the tool leaves out a member its component requires.
      *)
  | Named of { name : string; required : bool; form : form }

type result_member =
  | Result_member of { of_ : member; required : bool }
  | Result_named of { required : bool; form : form }

type result = Whole of string | Members of (string * result_member) list

type tool = {
  name : string;
  title : string;
  description : string;
  calls : string list;
  read_only : bool;
  destructive : bool;
  arguments : argument list;
  result : result option;
}

type t = {
  comment : string;
  kb : Yojson.Safe.t;
  tools : tool list;
  left_out : (string * string) list;
}

let member_of o =
  {
    from = Decode.required o "from" Decode.non_empty_string;
    member = Decode.required o "member" Decode.non_empty_string;
  }

(* A flag that is true or absent: absence says false. *)
let flag o name =
  match Decode.optional o name Decode.bool with
  | Some true -> true
  | None -> false
  | Some false ->
      Decode.refuse (Decode.at o) (name ^ " is false, which its absence says")

let form o =
  let schema = Decode.optional o "schema" Decode.non_empty_string in
  let list_of =
    Decode.optional o "listOf" (fun c ->
        match Decode.kind c with
        | Decode.String -> List_of_component (Decode.non_empty_string c)
        | _ -> List_of_member (Decode.obj member_of c))
  in
  let own = Decode.optional o "own" Decode.json in
  match (schema, list_of, own) with
  | Some name, None, None -> Component name
  | None, Some list, None -> list
  | None, None, Some own -> Own own
  | _ ->
      Decode.refuse (Decode.at o)
        "states other than one of schema, listOf and own"

let argument =
  Decode.obj (fun o ->
      if Decode.has_member "from" (Decode.at o) then
        Of_member
          {
            of_ = member_of o;
            optional = Decode.optional o "optional" Decode.non_empty_string;
          }
      else
        Named
          {
            name = Decode.required o "name" Decode.non_empty_string;
            required = Decode.required o "required" Decode.bool;
            form = form o;
          })

let result_member =
  Decode.obj (fun o ->
      let required = Decode.required o "required" Decode.bool in
      if Decode.has_member "from" (Decode.at o) then
        Result_member { of_ = member_of o; required }
      else Result_named { required; form = form o })

let result c =
  if Decode.has_member "component" c then
    Decode.obj
      (fun o -> Whole (Decode.required o "component" Decode.non_empty_string))
      c
  else Members (Decode.map result_member c)

let tool =
  Decode.obj (fun o ->
      {
        name = Decode.required o "name" Decode.non_empty_string;
        title = Decode.required o "title" Decode.non_empty_string;
        description = Decode.required o "description" Decode.non_empty_string;
        calls = Decode.required o "calls" (Decode.list Decode.non_empty_string);
        read_only = flag o "readOnly";
        destructive = flag o "destructive";
        arguments = Decode.required o "arguments" (Decode.list argument);
        result = Decode.optional o "result" result;
      })

let decode =
  Decode.obj (fun o ->
      {
        comment = Decode.required o "$comment" Decode.string;
        kb = Decode.required o "kb" Decode.json;
        tools = Decode.required o "tools" (Decode.list tool);
        left_out =
          Decode.required o "leftOut" (Decode.map Decode.non_empty_string);
      })

(* The table at [root], cli's checkout. *)
let read ~root =
  match Decode.parse_file ~root file with
  | Error error -> Error error
  | Ok json -> Result.map fst (Decode.run ~file json decode)
