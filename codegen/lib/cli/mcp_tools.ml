(* The mcp-tools group: the tools `xynolog mcp` serves, from cli's own table
   of them (Mcp_tools_table) and the components of protocol/specs/src it
   names, for cli's internal/launcher/verbs/mcp_tools_gen.go: every tool,
   with its input and output schema, and every SDK method no tool calls.

   Each schema is self-contained: every component it refers to, and every
   one those refer to, is in its $defs, and each reference names it there.
   A component is written as Protocol writes it, its references rewritten.
   The table's own schemas ([kb], [own]) are the MCP layer's and refer to
   nothing. *)

module G = Go_syntax
module T = Mcp_tools_table
open Schemas

let components = "components/schemas/"
let path = "internal/launcher/verbs/mcp_tools_gen.go"
let component name = components ^ name ^ ".json"

let def_name file =
  Filename.remove_extension
    (String.sub file (String.length components)
       (String.length file - String.length components))

(* A component's JSON as Protocol writes it, once known to be a schema of
   Protocol's. *)
let raw ~root spec file =
  ignore (schema spec file);
  match
    Decode.parse_file ~root:(Filename.concat root "protocol/specs/src") file
  with
  | Ok json -> json
  | Error error -> raise (Refused error)

(* Where a reference written in [from_] leads: a whole component, by its
   file. *)
let component_ref ~where from_ target =
  match Decode.resolve { Decode.target; file = from_; pointer = "" } with
  | file, "" when String.starts_with ~prefix:components file -> file
  | _ ->
      refuse T.file
        (Printf.sprintf "%s refers to %s, which is no whole component" where
           target)

(* [json], written in [from_], with each reference to a component naming it
   in $defs, as the components it refers to are added to [refs]. *)
let rec rewrite ~where from_ refs (json : Yojson.Safe.t) : Yojson.Safe.t =
  match json with
  | `List items -> `List (List.map (rewrite ~where from_ refs) items)
  | `Assoc members ->
      `Assoc
        (List.map
           (fun (key, value) ->
             match (key, value) with
             | "$ref", `String target
               when not (String.starts_with ~prefix:"#" target) ->
                 let file = component_ref ~where from_ target in
                 refs := file :: !refs;
                 (key, `String ("#/$defs/" ^ def_name file))
             | "discriminator", `Assoc d when List.mem_assoc "mapping" d ->
                 ( key,
                   `Assoc
                     (List.map
                        (function
                          | "mapping", `Assoc mapping ->
                              ( "mapping",
                                `Assoc
                                  (List.map
                                     (fun (tag, target) ->
                                       match target with
                                       | `String target ->
                                           let file =
                                             component_ref ~where from_ target
                                           in
                                           refs := file :: !refs;
                                           ( tag,
                                             `String ("#/$defs/" ^ def_name file)
                                           )
                                       | _ ->
                                           refuse from_
                                             "a discriminator maps a tag to no \
                                              reference")
                                     mapping) )
                          | other -> other)
                        d) )
             | _ -> (key, rewrite ~where from_ refs value))
           members)
  | other -> other

(* The table's own schemas refer to nothing: they are the MCP layer's. *)
let rec own ~where (json : Yojson.Safe.t) =
  match json with
  | `List items -> List.iter (own ~where) items
  | `Assoc members ->
      List.iter
        (fun (key, value) ->
          if key = "$ref" then
            refuse T.file (where ^ " refers to a schema from its own")
          else own ~where value)
        members
  | _ -> ()

type st = { root : string; spec : Spec.t }

(* The $defs of a schema that refers to [refs]: every component it reaches,
   by name. *)
let defs_of st ~where refs =
  List.map
    (fun file ->
      if not (String.starts_with ~prefix:components file) then
        refuse T.file
          (Printf.sprintf "%s reaches %s, which is no component" where file);
      ( def_name file,
        rewrite ~where file (ref []) (raw ~root:st.root st.spec file) ))
    (reach st.spec (List.sort_uniq String.compare refs))

(* A member of a component: its schema, and whether the component requires
   it. *)
let member st ~where (m : T.member) =
  let file = component m.from in
  let json = raw ~root:st.root st.spec file in
  if String.starts_with ~prefix:"_" m.member then
    refuse T.file
      (Printf.sprintf "%s: %s.%s is the gateway's, never an argument" where
         m.from m.member);
  let field name = function
    | `Assoc members -> List.assoc_opt name members
    | _ -> None
  in
  match Option.bind (field "properties" json) (field m.member) with
  | None ->
      refuse T.file
        (Printf.sprintf "%s: %s has no member %s" where m.from m.member)
  | Some sub ->
      let required =
        match field "required" json with
        | Some (`List names) -> List.mem (`String m.member) names
        | _ -> false
      in
      (file, sub, required)

let whole name = `Assoc [ ("$ref", `String ("./" ^ name ^ ".json")) ]

(* The schema of a form, with the components it reaches added to [refs]. *)
let of_form st ~where refs : T.form -> Yojson.Safe.t = function
  | Component name -> rewrite ~where (component name) refs (whole name)
  | Own json ->
      own ~where json;
      json
  | List_of_component name ->
      `Assoc
        [
          ("type", `String "array");
          ("items", rewrite ~where (component name) refs (whole name));
        ]
  | List_of_member m ->
      let file, sub, _ = member st ~where m in
      `Assoc
        [ ("type", `String "array"); ("items", rewrite ~where file refs sub) ]

(* An object of [properties], [required] as listed, with the $defs they
   reach. *)
let object_of st ~where properties required refs =
  let defs = defs_of st ~where refs in
  `Assoc
    ([ ("type", `String "object"); ("properties", `Assoc properties) ]
    @ (if required = [] then []
       else [ ("required", `List (List.map (fun n -> `String n) required)) ])
    @ [ ("additionalProperties", `Bool false) ]
    @ if defs = [] then [] else [ ("$defs", `Assoc defs) ])

let input st (table : T.t) (tool : T.tool) =
  let where = tool.name ^ "'s arguments" in
  let refs = ref [] in
  let arguments =
    List.map
      (fun (argument : T.argument) ->
        match argument with
        | Of_member { of_; optional } ->
            let file, sub, requires = member st ~where of_ in
            if optional <> None && not requires then
              refuse T.file
                (Printf.sprintf "%s: %s is optional, which %s does not require"
                   where of_.member of_.from);
            ( of_.member,
              rewrite ~where file refs sub,
              requires && optional = None )
        | Named { name; required; form } ->
            (name, of_form st ~where:(where ^ ", " ^ name) refs form, required))
      tool.arguments
  in
  let properties =
    (if tool.calls = [] then [] else [ ("kb", table.kb) ])
    @ List.map (fun (name, schema, _) -> (name, schema)) arguments
  in
  let rec twice = function
    | [] -> ()
    | (name, _) :: rest ->
        if List.mem_assoc name rest then
          refuse T.file (Printf.sprintf "%s names %s twice" where name);
        twice rest
  in
  twice properties;
  object_of st ~where properties
    (List.filter_map
       (fun (name, _, required) -> if required then Some name else None)
       arguments)
    !refs

let output st (tool : T.tool) = function
  | T.Whole name -> (
      let where = tool.name ^ "'s result" in
      let refs = ref [] in
      let file = component name in
      let schema = rewrite ~where file refs (raw ~root:st.root st.spec file) in
      let defs = defs_of st ~where !refs in
      if defs = [] then schema
      else
        match schema with
        | `Assoc members -> `Assoc (members @ [ ("$defs", `Assoc defs) ])
        | _ -> refuse file "is no object")
  | T.Members members ->
      let where = tool.name ^ "'s result" in
      let refs = ref [] in
      let properties =
        List.map
          (fun (name, (m : T.result_member)) ->
            match m with
            | Result_member { of_; required } ->
                let file, sub, _ = member st ~where:(where ^ ", " ^ name) of_ in
                (name, rewrite ~where file refs sub, required)
            | Result_named { required; form } ->
                ( name,
                  of_form st ~where:(where ^ ", " ^ name) refs form,
                  required ))
          members
      in
      object_of st ~where
        (List.map (fun (name, schema, _) -> (name, schema)) properties)
        (List.filter_map
           (fun (name, _, required) -> if required then Some name else None)
           properties)
        !refs

let derive ~root (spec : Spec.t) =
  let table =
    match T.read ~root with Ok t -> t | Error error -> raise (Refused error)
  in
  (match table.kb with
  | `Assoc members when List.assoc_opt "type" members = Some (`String "string")
    ->
      own ~where:"kb" table.kb
  | _ -> refuse T.file "states no `kb` argument");
  let st = { root; spec } in
  let tools =
    List.map
      (fun (tool : T.tool) ->
        `Assoc
          ([
             ("name", `String tool.name);
             ("title", `String tool.title);
             ("description", `String tool.description);
             ("calls", `List (List.map (fun c -> `String c) tool.calls));
             ("readOnly", `Bool tool.read_only);
             ("destructive", `Bool tool.destructive);
             ("input", input st table tool);
           ]
          @
          match tool.result with
          | Some result -> [ ("output", output st tool result) ]
          | None -> []))
      table.tools
  in
  let left_out =
    List.sort (fun (a, _) (b, _) -> String.compare a b) table.left_out
  in
  let document =
    `Assoc
      [
        ("tools", `List tools);
        ("leftOut", `Assoc (List.map (fun (k, v) -> (k, `String v)) left_out));
      ]
  in
  [
    {
      Output.path;
      text =
        G.text
          {
            header =
              G.verbatim
                ("Code generated from " ^ T.file
               ^ " and protocol/specs/src/components/schemas — DO NOT EDIT.\n\n\
                  Regenerate: make generate (xynolog/sdk's "
               ^ Banner.writer __FILE__ ^ ")");
            package = "verbs";
            imports = [];
            decls =
              [
                G.Const
                  (G.spec
                     ~doc:
                       (G.prose
                          "mcpToolsDocument: every tool xynolog mcp serves, in \
                           the order tools/list gives them, each with its \
                           input and output schema, and every method of the \
                           SDK's surface no tool calls, with its reason.")
                     "mcpToolsDocument"
                     (G.Quoted (Yojson.Safe.to_string document)));
              ];
          };
    };
  ]

let files ~root spec = Schemas.files (fun () -> derive ~root spec)
