(* The OCaml SDK's facts of tables no group of its own writes for it: a
   client assertion's lifetime and types (ocaml/sdk/lib/assertion_facts.ml);
   the registry's fixed keys, its session keys' prefix and the discovery
   document's versions (registry_facts.ml); the names a log never prints the
   value of (log_facts.ml); and the offset cases the capability probe walks
   (probes/unicode_cases.ml). *)

let string = Text.ocaml_quoted
let discovery = "discovery/DiscoveryDocument.json"

let files (spec : Spec.t) =
  let assertion = spec.tables.session_client_assertion_cases in
  let stored = spec.tables.session_stored in
  let versions =
    match List.assoc_opt discovery spec.schemas with
    | Some (Schema.Schema { properties = Some properties; _ }) -> (
        match List.assoc_opt "version" properties with
        | Some (Schema.Schema { enum = Some members; _ }) ->
            List.fold_right
              (fun member rest ->
                match (member, rest) with
                | Schema.Int_literal n, Some rest -> Some (n :: rest)
                | _ -> None)
              members (Some [])
        | _ -> None)
    | _ -> None
  in
  match versions with
  | None ->
      Error
        [
          {
            Decode.file = discovery;
            pointer = "/properties/version/enum";
            message = "is not a list of whole versions";
          };
        ]
  | Some versions ->
      let file path ~from_ body =
        { Output.path; text = Banner.ocaml ~from_ __FILE__ ^ body }
      in
      Ok
        [
          file "ocaml/sdk/lib/assertion_facts.ml"
            ~from_:"session/client-assertion-cases.json"
            (Printf.sprintf
               "let lifetime_seconds = %d\nlet assertion_type = %s\nlet grant_type = %s\n"
               assertion.lifetime_seconds
               (string assertion.assertion_type)
               (string assertion.grant_type));
          file "ocaml/sdk/lib/registry_facts.ml"
            ~from_:("session/stored.json and " ^ discovery)
            (String.concat ""
               (List.map
                  (fun (k : Tables.Session_stored.key) ->
                    "let " ^ Text.snake k.member ^ " = " ^ string k.key ^ "\n")
                  stored.keys)
            ^ "let session_prefix = "
            ^ string stored.session_key_prefix.prefix
            ^ "\nlet discovery_versions = ["
            ^ String.concat "; " (List.map string_of_int versions)
            ^ "]\n");
          file "ocaml/sdk/lib/log_facts.ml" ~from_:"bus/log-cases.json"
            ("let credentials = ["
            ^ String.concat "; " (List.map string spec.tables.bus_log_cases.names)
            ^ "]\n");
          file "ocaml/sdk/probes/unicode_cases.ml" ~from_:"text/offset-cases.json"
            ("let cases = [\n"
            ^ String.concat ";\n"
                (List.map
                   (fun (c : Tables.Text_offset_cases.case) ->
                     Printf.sprintf "  (%s, %d, [%s])" (string c.text) c.code_points
                       (String.concat "; "
                          (List.map
                             (fun (s : Tables.Text_offset_cases.span) ->
                               Printf.sprintf "(%s, %d, %d, %d)" (string s.exact)
                                 s.occurrence s.start s.end_)
                             c.spans)))
                   spec.tables.text_offset_cases.cases)
            ^ "\n]\n");
        ]
