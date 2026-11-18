(* Boundary's import graph and its refusals, in a checkout of a few seeded
   modules: a cycle back to a generated module, and imports that make none at
   run time. *)

open Xynolog_codegen

let case name test = Alcotest.test_case name `Quick test

let rec make_directory path =
  if not (Sys.file_exists path) then (
    make_directory (Filename.dirname path);
    Sys.mkdir path 0o755)

let checkout files =
  let root = Filename.temp_dir "boundary" "" in
  List.iter
    (fun (path, text) ->
      let full = Filename.concat root path in
      make_directory (Filename.dirname full);
      Out_channel.with_open_bin full (fun out ->
          Out_channel.output_string out text))
    files;
  root

let language label =
  List.find (fun (l : Boundary.language) -> l.label = label) Boundary.languages

let imports root label path =
  match
    Boundary.Graph.find_opt path (Boundary.graph ~root (language label))
  with
  | Some found -> found
  | None -> Alcotest.failf "%s is no module" path

let ts = "typescript/core/src/"
let py = "python/sdk/src/xynolog/"
let strings = Alcotest.(list string)

let typescript () =
  let root =
    checkout
      [
        ( ts ^ "generated.ts",
          "import { a } from './base';\n\
           import type { B } from './types';\n\
           import { type C, type D } from './typed';\n\
           export {\n\
          \  e,\n\
          \  f,\n\
           } from './reexported.js';\n\
           import * as all from './all';\n\
          \  import { g } from './indented';\n\
           import h from \"./double\";\n" );
        (ts ^ "base.ts", "import { generated } from './generated';\n");
        (ts ^ "types.ts", "");
      ]
  in
  Alcotest.check strings "the run-time imports, at a line's start"
    [ ts ^ "all.ts"; ts ^ "base.ts"; ts ^ "reexported.ts" ]
    (imports root "TypeScript" (ts ^ "generated.ts"));
  let generated, refusals =
    Boundary.check ~root
      ~generated:[ ts ^ "generated.ts" ]
      (language "TypeScript")
  in
  Alcotest.check strings "generated" [ ts ^ "generated.ts" ] generated;
  Alcotest.check strings "the cycle back"
    [
      "TypeScript: generated " ^ ts ^ "generated.ts imports " ^ ts
      ^ "base.ts, which comes back to it: " ^ ts ^ "base.ts -> " ^ ts
      ^ "generated.ts";
    ]
    refusals

let python () =
  let root =
    checkout
      [
        ( py ^ "generated.py",
          "from .base import a\n\
           from . import (\n\
          \    sibling,  # held\n\
          \    other as renamed,\n\
           )\n\
           import xynolog.plain\n\
           import json\n\
           from typing import TYPE_CHECKING\n\
           if TYPE_CHECKING:\n\
          \    from .typed import T\n" );
        (py ^ "base.py", "from xynolog.generated import thing\n");
        (py ^ "sibling.py", "");
        (py ^ "other.py", "");
        (py ^ "plain.py", "");
        (py ^ "typed.py", "from .generated import thing\n");
        (py ^ "__init__.py", "");
        (py ^ "inner/__init__.py", "");
        (py ^ "inner/deep.py", "from .. import base\nfrom ..base import a\n");
      ]
  in
  Alcotest.check strings "the run-time imports, at a line's start"
    [ py ^ "base.py"; py ^ "other.py"; py ^ "plain.py"; py ^ "sibling.py" ]
    (imports root "Python" (py ^ "generated.py"));
  Alcotest.check strings "a relative import climbs out of its package"
    [ py ^ "base.py" ]
    (imports root "Python" (py ^ "inner/deep.py"));
  let _, refusals =
    Boundary.check ~root ~generated:[ py ^ "generated.py" ] (language "Python")
  in
  Alcotest.check strings "the cycle back, but none through a type import"
    [
      "Python: generated " ^ py ^ "generated.py imports " ^ py
      ^ "base.py, which comes back to it: " ^ py ^ "base.py -> " ^ py
      ^ "generated.py";
    ]
    refusals

let () =
  Alcotest.run "boundary"
    [ ("imports", [ case "TypeScript" typescript; case "Python" python ]) ]
