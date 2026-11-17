(* The table as the Python SDK's reader of a resource's text reads it
   (python/sdk/src/xynolog/resources.py): Python's codecs have other labels
   and, for some bytes, other characters. *)

let path = "python/sdk/src/xynolog/_encodings.py"

let text (t : Table.t) =
  let rows pairs =
    String.concat ""
      (List.map
         (fun (a, b) ->
           Printf.sprintf "    %s: %s,\n" (Text.ascii_quoted a)
             (Text.ascii_quoted b))
         pairs)
  in
  String.concat ""
    [
      {|# Generated from protocol/specs/src/text/encoding-cases.json; do not edit.
# Regenerate: make generate (codegen/lib/encodings/python.ml)

"""The Encoding Standard as the reader of a resource's text needs it: the encoding each label names, and each single-byte encoding byte by byte."""

from collections.abc import Mapping
from typing import Final

__all__ = ["ENCODING_OF_LABEL", "REFUSED", "SINGLE_BYTE"]

|};
      Printf.sprintf "# Every label of the standard: %d of them.\n"
        (List.length t.labels);
      "ENCODING_OF_LABEL: Final[Mapping[str, str]] = {\n";
      rows t.labels;
      "}\n\
       \"\"\"The encoding each label of the standard names. A label is matched \
       in lower case, with no white space around it.";
      Table.undecoded t ~single_byte:"`SINGLE_BYTE`" ~refused:"`REFUSED`";
      "\"\"\"\n\nSINGLE_BYTE: Final[Mapping[str, str]] = {\n";
      rows t.single_byte;
      {|}
"""For each single-byte encoding, the 256 characters its bytes are: the one at `n` is the byte `n`'s."""

REFUSED: Final = frozenset({|};
      String.concat ", " (List.map Text.ascii_quoted t.refused);
      {|})
"""The encodings whose labels are refused: no text is read under them."""
|};
    ]

let file t = { Output.path; text = text t }
