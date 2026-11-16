"""Hold each Dune project's compiler and repository constraints to the container pins.

The projects are the SDK (ocaml/sdk) and the generator (codegen), which build
on the same toolchain. With --base-image it then prints the image the pins are
built on, which every OCaml container starts from.
"""
import json
import sys
from pathlib import Path
import re

root = Path(__file__).resolve().parent
pins = json.loads((root / 'toolchain.json').read_text())
for project_root in (root / 'sdk', root.parent / 'codegen'):
    project = (project_root / 'dune-project').read_text()
    workspace = (project_root / 'dune-workspace').read_text()
    assert re.findall(r'\(ocaml \(= ([^)]+)\)\)', project) == [pins['ocaml']], project_root
    assert re.findall(r'\(lang dune ([^)]+)\)', project) == ['.'.join(pins['dune'].split('.')[:2])], project_root
    assert re.findall(r'\(ocamlformat \(and :with-test \(= ([^)]+)\)\)\)', project) == [pins['ocamlformat']], project_root
    assert (project_root / '.ocamlformat').read_text().strip() == 'version=' + pins['ocamlformat'], project_root
    assert re.findall(r'git\+https://github.com/ocaml/opam-repository.git#([a-f0-9]+)', workspace) == [pins['opamRepository']], project_root
    assert re.findall(r'git\+https://github.com/ocaml-dune/opam-overlays.git#([a-f0-9]+)', workspace) == [pins['duneOverlay']], project_root
if sys.argv[1:] == ['--base-image']:
    print(pins['baseImage'])
elif sys.argv[1:]:
    raise SystemExit('usage: check-toolchain.py [--base-image]')
else:
    print('OCaml toolchain constraints agree')
