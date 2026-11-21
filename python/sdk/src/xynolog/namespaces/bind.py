"""Bind: linking a reference to what it refers to."""

from collections.abc import Sequence
from typing import Final, final

from xynolog.channels import BIND_BODY_ERROR, BIND_INITIATE
from xynolog.identifiers import AnnotationId, ResourceId
from xynolog.namespaces.links import Links
from xynolog.operations import BIND_UPDATE_BODY
from xynolog.types import BindBodyOperation, BindInitiateCommand, BindUpdateBodyCommand, ResourceErrorEvent

__all__ = ["BindNamespace"]


@final
class BindNamespace:
    """See the module's documentation."""

    def __init__(self, links: Links) -> None:
        self._links: Final = links

    async def body(self, resource_id: ResourceId, annotation_id: AnnotationId, operations: Sequence[BindBodyOperation]) -> None:
        """Change an annotation's body.

        Confirmed: it resolves when the change is recorded, and fails with the
        failure the knowledge base answered.
        """
        await self._links.request(
            BIND_UPDATE_BODY, BindUpdateBodyCommand(annotation_id=annotation_id, resource_id=resource_id, operations=list(operations))
        )

    def initiate(self, input: BindInitiateCommand) -> None:
        """Signal: a binding is wanted for an annotation."""
        self._links.signal(BIND_INITIATE, input)

    def report_body_error(self, input: ResourceErrorEvent) -> None:
        """Signal: a body update failed where nothing could show it."""
        self._links.signal(BIND_BODY_ERROR, input)
