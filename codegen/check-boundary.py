"""check-boundary.py ROOT: the imports between generated and hand-written
modules run one way. A hand-written module that a generated one imports when
it runs is a base module, and nothing a base module imports when it runs
comes back to the generated module that imports it: the public modules,
which import generated ones, stand above both. A generated module is the one
its banner says it is.

An import of types only is no import at run time: in TypeScript it is
erased, and in Python it is under `if TYPE_CHECKING:`. The base modules are
listed nowhere; they are whatever generated code imports, so a generated
module that comes to import a public one fails here rather than in a cycle
at run time."""

import re
import sys
from pathlib import Path

ROOT = Path(sys.argv[1]).resolve()


def is_generated(text):
    head = text[:400]
    return "GENERATED FILE" in head or ("Generated from" in head and "do not edit" in head.lower())


# TypeScript: typescript/core/src, a module by its file.
TS = ROOT / "typescript/core/src"
TS_IMPORT = re.compile(r"^(?:import|export)\s+(type\s+)?(?:\{([^}]*)\}|\*\s+as\s+\w+|\w+)\s+from\s+'(\.[^']+)'", re.M)


def ts_runtime_imports(path):
    found = set()
    for type_only, names, target in TS_IMPORT.findall(path.read_text()):
        if type_only or (names and all(n.strip().startswith("type ") for n in names.split(",") if n.strip())):
            continue
        module = (path.parent / target).resolve()
        found.add(module if module.suffix == ".ts" else module.with_suffix(".ts"))
    return found


# Python: python/sdk/src, a module by its file. An import at the margin is
# made when the module is; one indented is under `if TYPE_CHECKING:` or in a
# function, and makes no cycle at import time.
PY = ROOT / "python/sdk/src"
PY_IMPORT = re.compile(r"^(?:from\s+(\.*[\w.]*)\s+import\s+(\([^)]*\)|[^\n]+)|import\s+([\w.]+))", re.M)


def py_module(name):
    base = PY.joinpath(*name.split("."))
    for candidate in (base.with_suffix(".py"), base / "__init__.py"):
        if candidate.is_file():
            return candidate
    return None


def py_runtime_imports(path):
    package = path.relative_to(PY).with_suffix("").parts[:-1]
    found = set()
    for source, names, plain in PY_IMPORT.findall(path.read_text()):
        if plain:
            module = py_module(plain) if plain.startswith("xynolog") else None
            found.update([module] if module else [])
            continue
        level = len(source) - len(source.lstrip("."))
        name = source.lstrip(".")
        if level:
            name = ".".join(list(package[: len(package) - level + 1]) + ([name] if name else []))
        if not name.startswith("xynolog"):
            continue
        for alias in names.strip("()").split(","):
            alias = alias.split("#")[0].split(" as ")[0].strip()
            module = (py_module(name + "." + alias) or py_module(name)) if alias else None
            found.update([module] if module else [])
    return found


def check(label, files, imports):
    graph = {f: imports(f) for f in files}
    generated = {f for f in files if is_generated(f.read_text())}

    def path_to(start, goal):
        seen, stack = set(), [(start, [start])]
        while stack:
            at, path = stack.pop()
            if at == goal:
                return path
            if at in seen:
                continue
            seen.add(at)
            stack.extend((n, path + [n]) for n in graph.get(at, ()) if n not in seen)
        return None

    refusals = []
    for g in sorted(generated):
        for base in sorted(graph[g] - generated):
            back = path_to(base, g)
            if back:
                refusals.append(
                    f"{label}: generated {g.relative_to(ROOT)} imports {base.relative_to(ROOT)}, "
                    "which comes back to it: " + " -> ".join(str(p.relative_to(ROOT)) for p in back)
                )
    return generated, refusals


ts_generated, ts_refusals = check("TypeScript", sorted(TS.glob("*.ts")), ts_runtime_imports)
py_generated, py_refusals = check("Python", sorted(PY.rglob("*.py")), py_runtime_imports)
for refusal in ts_refusals + py_refusals:
    print(refusal, file=sys.stderr)
if ts_refusals or py_refusals:
    sys.exit(1)
print(f"PASS each base module a generated one imports stays below it: {len(ts_generated)} TypeScript, {len(py_generated)} Python")
