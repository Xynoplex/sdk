"""A shape of the protocol is immutable."""

from xynolog.identifiers import AnnotationId
from xynolog.types import MarkDeleteCommand


def to_a_field(command: MarkDeleteCommand) -> None:
    command.annotation_id = AnnotationId("a-2")  # type: ignore[misc]  # pyright: ignore[reportAttributeAccessIssue]
