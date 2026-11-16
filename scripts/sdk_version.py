#!/usr/bin/env python3
"""The SDK's version in each language, derived from version.json.

version.json names two things: the coming release, `YY.M.N`, and each
language's compatibility number `C`. A language publishes the release as
`C.YYMM.N`, the month as two digits. Swift has no `C`: SwiftPM takes the
repository's root release tag, `vYY.M.N`, as the Swift package's version.
Every package version and file name is derived here, and nothing else reads
version.json's `release` or `compatibility`.

A commit that the release tag `vYY.M.N` points at builds the release. Every
other commit builds a development version: a pre-release of the coming
release, labelled by the commit's UTC time and hash, which a shallow checkout
has (Hackage's by the time alone). A development version is never pushed to a
registry.

    sdk_version.py release      the coming release, YY.M.N
    sdk_version.py <language>   that language's version for this commit
    sdk_version.py check        the committed manifests hold the release's versions
    sdk_version.py write        write them there
"""

import json
import os
import re
import subprocess
import sys
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
RELEASE = re.compile(r"([0-9]{2})\.([1-9]|1[0-2])\.(0|[1-9][0-9]*)")
UNNUMBERED = ("swift",)


def makefile_languages() -> tuple:
    found = re.findall(r"(?m)^LANGUAGES := (.+)$", (ROOT / "Makefile").read_text())
    if len(found) != 1:
        raise SystemExit("sdk_version.py: the Makefile must set LANGUAGES exactly once")
    return tuple(found[0].split())


LANGUAGES = makefile_languages()


def config() -> dict:
    data = json.loads((ROOT / "version.json").read_text())
    if not RELEASE.fullmatch(data["release"]):
        raise SystemExit(f"version.json: release {data['release']!r} is not YY.M.N")
    numbered = sorted(set(LANGUAGES) - set(UNNUMBERED))
    if sorted(data["compatibility"]) != numbered:
        raise SystemExit(f"version.json: compatibility names {sorted(data['compatibility'])}, not {numbered}")
    for language, number in data["compatibility"].items():
        if type(number) is not int or number < 1:
            raise SystemExit(f"version.json: {language}'s compatibility number {number!r} is not a whole number from 1")
    return data


def released(data: dict, language: str) -> str:
    if language not in LANGUAGES:
        raise SystemExit(f"sdk_version.py: unknown SDK language {language!r}")
    if language in UNNUMBERED:
        return data["release"]
    year, month, count = RELEASE.fullmatch(data["release"]).groups()
    return f"{data['compatibility'][language]}.{year}{int(month):02d}.{count}"


def development(data: dict, language: str, time: str, commit: str) -> str:
    base, label = released(data, language), f"g{commit[:7]}"
    if language == "python":
        return f"{base}.dev{time}+{label}"
    if language == "haskell":
        # Hackage takes no pre-release, and Cabal no more than nine digits in a
        # part: the date and the time of day as two more numeric parts. Five
        # parts never equal a release's three.
        return f"{base}.{time[:8]}.{int(time[8:])}"
    if language == "ocaml":
        return f"{base}~dev{time}.{label}"
    return f"{base}-dev.{time}.{label}"


def git(*arguments: str) -> str:
    return subprocess.run(
        ["git", "-C", str(ROOT), *arguments],
        stdout=subprocess.PIPE, text=True, check=True, env={**os.environ, "TZ": "UTC"},
    ).stdout.strip()


def is_release(data: dict) -> bool:
    return f"v{data['release']}" in git("tag", "--points-at", "HEAD").split()


def version(language: str) -> str:
    """The version a build of this commit gives the language's packages."""
    data = config()
    if is_release(data):
        return released(data, language)
    time = git("log", "-1", "--format=%cd", "--date=format-local:%Y%m%d%H%M%S")
    return development(data, language, time, git("rev-parse", "HEAD"))


def manifests(data: dict) -> list:
    """Each committed manifest's version, as (path, found, wanted)."""
    found = []
    cargo = (ROOT / "rust/Cargo.toml").read_text()
    section = ""
    for line in cargo.splitlines():
        if line.startswith("["):
            section = line
        elif section == "[workspace.package]" and line.startswith("version = "):
            found.append(("rust/Cargo.toml [workspace.package]", line.split('"')[1], "rust"))
        elif section == "[workspace.dependencies]" and "path = " in line and 'version = "' in line:
            found.append((f"rust/Cargo.toml {line.split()[0]}", re.search(r'version = "([^"]*)"', line).group(1), "rust"))
    published = subprocess.run(
        ["bash", str(ROOT / "rust/scripts/published-crates.sh")], stdout=subprocess.PIPE, text=True, check=True,
    ).stdout.split()
    lock = (ROOT / "rust/Cargo.lock").read_text()
    for crate in published:
        entry = re.search(rf'(?m)^name = "{re.escape(crate)}"\nversion = "([^"]*)"$', lock)
        found.append((f"rust/Cargo.lock {crate}", entry.group(1) if entry else None, "rust"))
    for package in data["packages"].values():
        path = f"{package['dir']}/package.json"
        found.append((path, json.loads((ROOT / path).read_text()).get("version"), "typescript"))
    cabal = re.findall(r"(?m)^version: (.+)$", (ROOT / "haskell/sdk/xynolog.cabal").read_text())
    found.append(("haskell/sdk/xynolog.cabal", cabal[0] if len(cabal) == 1 else None, "haskell"))
    return [(path, value, released(data, language)) for path, value, language in found]


def check() -> None:
    wrong = [f"  {path}: {value}, not {wanted}" for path, value, wanted in manifests(config()) if value != wanted]
    if wrong:
        raise SystemExit("The committed manifests must hold the release's versions (sdk_version.py write):\n" + "\n".join(wrong))
    print("The committed manifests hold the release's versions.")


def write() -> None:
    data = config()
    subprocess.run(["bash", str(ROOT / "rust/scripts/cargo-version.sh"), released(data, "rust")], check=True)
    subprocess.run(
        ["bash", str(ROOT / "haskell/scripts/cabal-version.sh"), released(data, "haskell"), str(ROOT / "haskell/sdk/xynolog.cabal")],
        check=True,
    )
    for package in data["packages"].values():
        path = ROOT / package["dir"] / "package.json"
        manifest = json.loads(path.read_text())
        manifest["version"] = released(data, "typescript")
        path.write_text(json.dumps(manifest, indent=2, ensure_ascii=False) + "\n")
    check()


def main() -> None:
    if len(sys.argv) != 2:
        raise SystemExit(__doc__)
    command = sys.argv[1]
    if command == "release":
        print(config()["release"])
    elif command == "check":
        check()
    elif command == "write":
        write()
    else:
        print(version(command))


if __name__ == "__main__":
    main()
