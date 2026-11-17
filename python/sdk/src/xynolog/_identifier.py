"""What every kind of id shares (`xynolog.identifiers` declares the kinds):
text held to its kind's rule wherever it is made, and the error text the rule
refuses raises.
"""

import re
from typing import ClassVar, Final, Self, final

from pydantic import GetCoreSchemaHandler
from pydantic_core import CoreSchema, core_schema

__all__ = ["Identifier", "InvalidIdentifier"]


@final
class InvalidIdentifier(ValueError):
    """Text that is not an id of the kind it was to be."""

    def __init__(self, kind: str, pattern: str, value: str) -> None:
        super().__init__(f"{value!r} is not a {kind}: it does not match {pattern}")
        self.kind: Final = kind
        self.pattern: Final = pattern
        self.value: Final = value


class Identifier(str):
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
