(* The kinds of id as the Python SDK declares them
   (python/sdk/src/xynolog/identifiers.py): a str subclass for each, made only
   through the kind's rule, which Python asks of the whole text. *)

let path = "python/sdk/src/xynolog/identifiers.py"

let kind (k : Table.kind) =
  Printf.sprintf
    {|@final
class %s(_Identifier):
%s

    __slots__ = ()
    PATTERN: ClassVar[str] = %s
    _RULE: ClassVar[re.Pattern[str]] = re.compile(%s)
|}
    k.name
    (Text.python_docstring ~indent:"    " k.description)
    (Text.quoted k.pattern) (Text.quoted k.whole)

let text (kinds : Table.kind list) =
  String.concat ""
    [
      Banner.python
        ~from_:
          "protocol/specs/src/identifiers/kinds.json and each kind's schema"
        __FILE__;
      {|
"""The kinds of id.

A value of one of these types is text that passed its kind's rule, which is the
schema's pattern. It is made here and nowhere else: by the kind's constructor,
which raises `InvalidIdentifier` for text the rule refuses, by `parse`, which
answers `None` instead, and by decoding, which goes through the same rule. It
is a `str`, so it reads as the text it is. One kind is not another: a type
checker refuses a `ResourceId` where an `AnnotationId` is wanted.
"""

import re
from typing import ClassVar, Final, Self, final

from pydantic import GetCoreSchemaHandler
from pydantic_core import CoreSchema, core_schema

__all__ = [|};
      String.concat ", "
        (List.map Text.quoted
           (List.sort compare
              ("InvalidIdentifier"
              :: List.map (fun (k : Table.kind) -> k.name) kinds)));
      {|]


@final
class InvalidIdentifier(ValueError):
    """Text that is not an id of the kind it was to be."""

    def __init__(self, kind: str, pattern: str, value: str) -> None:
        super().__init__(f"{value!r} is not a {kind}: it does not match {pattern}")
        self.kind: Final = kind
        self.pattern: Final = pattern
        self.value: Final = value


class _Identifier(str):
    """What the kinds share: text held to a rule, wherever it is made."""

    __slots__ = ()
    PATTERN: ClassVar[str]
    """The kind's rule, as its schema states it."""
    _RULE: ClassVar[re.Pattern[str]]

    def __new__(cls, text: str) -> Self:
        if cls._RULE.fullmatch(text) is None:
            raise InvalidIdentifier(cls.__name__, cls.PATTERN, text)
        return super().__new__(cls, text)

    @classmethod
    def parse(cls, text: str) -> Self | None:
        """`text` as this kind of id, or `None` when the kind's rule refuses it.

        For where text that is not an id is an ordinary answer and not a fault:
        an address someone typed, a key read from storage.
        """
        return super().__new__(cls, text) if cls._RULE.fullmatch(text) is not None else None

    @classmethod
    def __get_pydantic_core_schema__(cls, source: object, handler: GetCoreSchemaHandler) -> CoreSchema:
        # Decoding goes through the constructor: an id in an answer passed the
        # same rule as one a caller made.
        return core_schema.no_info_after_validator_function(cls, core_schema.str_schema())


|};
      String.concat "\n\n" (List.map kind kinds);
    ]

let file kinds = { Output.path; text = text kinds }
