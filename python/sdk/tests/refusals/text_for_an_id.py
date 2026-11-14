"""Text is not an id until a kind's rule has passed it."""

from xynoplex.identifiers import ResourceId
from xynoplex.types import MarkDeleteCommand


def as_a_field() -> MarkDeleteCommand:
    return MarkDeleteCommand(annotation_id="a-1")  # type: ignore[arg-type]  # pyright: ignore[reportArgumentType]


def as_a_result() -> ResourceId:
    return "res-1"  # type: ignore[return-value]  # pyright: ignore[reportReturnType]
