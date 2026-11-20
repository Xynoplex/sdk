"""Mark: annotations, a resource's own metadata, and the annotating of a resource delegated as a job.

Each write is confirmed: it resolves when the knowledge base says it is
recorded, and fails with the failure it answered. What changed then arrives
on the `browse` queries.
"""

from collections.abc import Sequence
from typing import Final, final

from xynolog.channels import MARK_DELETE_ERROR, MARK_REQUESTED, MARK_SUBMIT
from xynolog.identifiers import AnnotationId, ResourceId
from xynolog.model import stated
from xynolog.namespaces.follow import Delegation, follow
from xynolog.namespaces.links import Links
from xynolog.operations import MARK_ARCHIVE, MARK_CREATE_REQUEST, MARK_DELETE, MARK_UNARCHIVE, MARK_UPDATE_ENTITY_TYPES
from xynolog.types import (
    AnnotationSelector,
    CreateAnnotationRequest,
    MarkArchiveCommand,
    MarkCreateOkResponse,
    MarkCreateRequest,
    MarkDeleteCommand,
    MarkJobCompleteCommand,
    MarkJobCreateCommand,
    MarkJobParams,
    MarkRequestedEvent,
    MarkSubmitEvent,
    MarkUnarchiveCommand,
    MarkUpdateEntityTypesCommand,
    Motivation,
    ResourceErrorEvent,
)

__all__ = ["MarkNamespace"]


@final
class MarkNamespace:
    """See the module's documentation."""

    def __init__(self, links: Links) -> None:
        self._links: Final = links

    async def annotation(self, input: CreateAnnotationRequest) -> MarkCreateOkResponse:
        """Create an annotation on the resource its target names."""
        created = await self._links.request(MARK_CREATE_REQUEST, MarkCreateRequest(resource_id=input.target.source, request=input))
        return created.response

    async def delete(self, resource_id: ResourceId, annotation_id: AnnotationId) -> None:
        """Delete an annotation."""
        await self._links.request(MARK_DELETE, MarkDeleteCommand(annotation_id=annotation_id, resource_id=resource_id))

    async def archive(self, resource_id: ResourceId) -> None:
        """Archive a resource."""
        await self._links.request(MARK_ARCHIVE, MarkArchiveCommand(resource_id=resource_id))

    async def unarchive(self, resource_id: ResourceId) -> None:
        """Bring an archived resource back."""
        await self._links.request(MARK_UNARCHIVE, MarkUnarchiveCommand(resource_id=resource_id))

    async def update_entity_types(self, resource_id: ResourceId, current: Sequence[str], updated: Sequence[str]) -> None:
        """Replace a resource's own entity types: `current` is what it has now, `updated` the whole set it is to have."""
        await self._links.request(
            MARK_UPDATE_ENTITY_TYPES,
            MarkUpdateEntityTypesCommand(resource_id=resource_id, current_entity_types=list(current), updated_entity_types=list(updated)),
        )

    def delegate(self, resource_id: ResourceId, params: MarkJobParams) -> Delegation[MarkJobCompleteCommand]:
        """Delegate the annotating of a resource, as a `mark` job: its progress, any attempt that will be tried again, and its completion.

        `params` is the job's parameters, one shape for each motivation, and
        its `motivation` says which. An option of it given as `None` is an
        option not given.
        """
        create = MarkJobCreateCommand(job_type="mark", resource_id=resource_id, params=stated(params))
        return follow(self._links, create, MarkJobCompleteCommand, resource_id=resource_id, stall_ms=None)

    def request(self, source: ResourceId, selector: AnnotationSelector, motivation: Motivation) -> None:
        """Signal: a new annotation is wanted on `source`."""
        self._links.signal(MARK_REQUESTED, MarkRequestedEvent(source=source, selector=selector, motivation=motivation))

    def submit(self, input: MarkSubmitEvent) -> None:
        """Signal: submit the annotation that is pending."""
        self._links.signal(MARK_SUBMIT, input)

    def report_delete_error(self, input: ResourceErrorEvent) -> None:
        """Signal: a delete failed where nothing could show it. Said by whoever awaited `delete`, which knows the resource."""
        self._links.signal(MARK_DELETE_ERROR, input)
