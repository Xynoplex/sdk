"""A shape of the protocol is immutable."""

from xynoplex.identifiers import AnnotationId
from xynoplex.types import MarkDeleteCommand


def to_a_field(command: MarkDeleteCommand) -> None:
    command.annotation_id = AnnotationId("a-2")  # type: ignore[misc]  # pyright: ignore[reportAttributeAccessIssue]
