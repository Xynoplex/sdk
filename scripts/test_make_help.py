"""make help lists every public target and nothing else, and refuses an entry without its text.

Run with: python3 scripts/test_make_help.py
"""

import re
import shutil
import subprocess
import tempfile
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
# An entry whose name holds one of these stands for a target per word of the variable.
LISTS = {"<language>": "LANGUAGES"}


def make(*arguments, cwd=ROOT):
    return subprocess.run(["make", "-s", *arguments], cwd=cwd, capture_output=True, text=True)


def database():
    """The Makefile as make reads it, every variable and `.PHONY` expanded."""
    return subprocess.run(
        ["make", "-pRrq", "-f", "Makefile", ":"], cwd=ROOT, capture_output=True, text=True
    ).stdout


class MakeHelp(unittest.TestCase):
    def test_lists_every_public_target_and_nothing_else(self):
        result = make("help")
        self.assertEqual(result.returncode, 0, result.stderr)
        read = database()
        variables = dict(re.findall(r"^([A-Z][A-Z0-9_]*) :?= (.*)$", read, re.M))
        listed = set()
        for line in result.stdout.splitlines():
            named = re.match(r"  ([a-z<]\S*)", line)
            if not named:
                continue
            name = named[1]
            placeholder = next((p for p in LISTS if p in name), None)
            if placeholder is None:
                listed.add(name)
            else:
                words = variables[LISTS[placeholder]].split()
                listed |= {name.replace(placeholder, word) for word in words}
        phony = set(re.search(r"^\.PHONY: (.*)$", read, re.M)[1].split())
        self.assertEqual(listed, phony - {"help"})

    def test_refuses_an_entry_without_its_text(self):
        with tempfile.TemporaryDirectory() as scratch:
            copy = Path(scratch)
            (copy / "scripts").mkdir()
            shutil.copy(ROOT / "scripts" / "make-help.awk", copy / "scripts" / "make-help.awk")
            makefile = (ROOT / "Makefile").read_text()
            (copy / "Makefile").write_text(makefile + "## clean Remove everything\n")
            result = make("help", cwd=copy)
        self.assertNotEqual(result.returncode, 0)
        self.assertIn("clean Remove everything", result.stderr)


if __name__ == "__main__":
    unittest.main()
