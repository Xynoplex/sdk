"""A closed vocabulary takes its own words and no other."""

from xynoplex.error_codes import TransportErrorCode
from xynoplex.types import Motivation


def a_motivation() -> Motivation:
    return "highlightning"  # type: ignore[return-value]  # pyright: ignore[reportReturnType]


def a_code() -> TransportErrorCode:
    return "teapot"  # type: ignore[return-value]  # pyright: ignore[reportReturnType]
