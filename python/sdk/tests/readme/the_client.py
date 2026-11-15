from xynolog.channels import BRIDGED_CHANNELS
from xynolog.client import XynologClient
from xynolog.http import HttpTransport
from xynolog.identifiers import AnnotationId, ResourceId
from xynolog.namespaces.follow import JobAttemptFailed, JobCompleted, JobCreated, JobProgressed, JobRefused
from xynolog.transport import Transport
from xynolog.types import HighlightingJobParams
from xynolog.watched import Variable


async def annotate(client: XynologClient[Transport], resource: ResourceId, annotation: AnnotationId) -> None:
    described = await client.browse.resource(resource).fresh()  # a query, read once
    text = await client.browse.resource_content(resource)  # asked once, answered once
    print(described.name, len(text))

    async for event in client.mark.delegate(resource, HighlightingJobParams(motivation="highlighting")):  # a job, followed
        match event:
            case JobCreated(data=created):
                print("to cancel it:", created.job_id)  # what client.job.cancel names
            case JobProgressed(data=progress):
                print(progress.percentage)
            case JobAttemptFailed(data=setback):
                print("trying again after:", setback.error)
            case JobRefused(data=refused):
                print("a frame refused on", refused.channel)  # some job's, maybe this one's
            case JobCompleted(data=done):
                print(done.result)

    reached = await client.beckon.attention(resource, annotation)  # a drive: how many the gateway reached
    client.browse.click(annotation)  # a signal: this viewer's own, never sent
    print(reached)


async def over_http(origin: str, token: str, resource: ResourceId, annotation: AnnotationId) -> None:
    async with (
        HttpTransport(origin, token=Variable[str | None](token), channels=BRIDGED_CHANNELS) as transport,
        XynologClient(transport, transport.content, transport) as client,
    ):
        await annotate(client, resource, annotation)
