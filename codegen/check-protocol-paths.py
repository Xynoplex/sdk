"""check-protocol-paths.py SDK PROTOCOL: every sdk path Protocol names is one
the SDK checkout has. Protocol says who writes or holds each of its tables by
naming sdk files, as `sdk/<path>` in its prose and tables and as links to
github.com/xynolog/sdk/tree/main/<path> (or blob/main) in its contract docs;
nothing else holds those names to the files.

A link names the sdk repository whatever its path. A bare `sdk/<path>` names
it when the path's first segment is one of the SDK checkout's own top-level
entries: Protocol's own conformance/sdk/ is the other sdk/ its prose names
(`sdk/wire/...`, `sdk/live/...`), and holding those is Protocol's. So a bare
path under a top-level entry this checkout no longer has goes unread here. A
path with `{a,b}` names each path the braces expand to, and one with `*`
names at least one file.

Every file of the Protocol checkout is read, but no checkout nested in it."""

import re
import sys
from pathlib import Path

SDK = Path(sys.argv[1]).resolve()
PROTOCOL = Path(sys.argv[2]).resolve()

PATH = rb"((?:[A-Za-z0-9_.*/-]|\{[A-Za-z0-9_.,/-]*\})+)"
LINK = re.compile(rb"github\.com/xynolog/sdk/(?:tree|blob)/main/" + PATH)
BARE = re.compile(rb"\bsdk/" + PATH)
TOP_LEVEL = {entry.name.encode() for entry in SDK.iterdir() if entry.name != ".git"}


def protocol_files(directory):
    for entry in sorted(directory.iterdir()):
        if entry.name == ".git":
            continue
        if entry.is_dir():
            if not (entry / ".git").exists():
                yield from protocol_files(entry)
        else:
            yield entry


def expansions(path):
    brace = re.search(r"\{([^}]*)\}", path)
    if not brace:
        return [path]
    return [
        expanded
        for alternative in brace.group(1).split(",")
        for expanded in expansions(path[: brace.start()] + alternative + path[brace.end() :])
    ]


def present(path):
    if "*" in path:
        return any(SDK.glob(path))
    return (SDK / path).exists()


def references(text):
    """Each sdk path the text names, by its line, the links before the bare
    form: a link holds `sdk/tree/main/...` too."""
    linked = []
    for match in LINK.finditer(text):
        linked.append(match.span())
        yield match.start(), match.group(1)
    for match in BARE.finditer(text):
        path = match.group(1)
        inside_link = any(start <= match.start() < end for start, end in linked)
        if not inside_link and path.split(b"/")[0].rstrip(b".") in TOP_LEVEL:
            yield match.start(), path


named = 0
refusals = []
for file in protocol_files(PROTOCOL):
    text = file.read_bytes()
    for offset, raw in references(text):
        path = raw.decode().rstrip(".")
        named += 1
        line = text.count(b"\n", 0, offset) + 1
        refusals.extend(
            f"protocol/{file.relative_to(PROTOCOL)}:{line}: sdk/{expanded} is not in the SDK checkout"
            for expanded in expansions(path)
            if not present(expanded)
        )
for refusal in refusals:
    print(refusal, file=sys.stderr)
if refusals:
    sys.exit(1)
print(f"PASS every sdk path Protocol names is in the SDK checkout: {named} named")
