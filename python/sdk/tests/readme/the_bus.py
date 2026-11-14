from xynoplex.bus import Bus, Delivered
from xynoplex.channels import BRIDGED_CHANNELS, MARK_ADDED
from xynoplex.errors import BusRequestError
from xynoplex.http import HttpTransport
from xynoplex.identifiers import ResourceId
from xynoplex.operations import BROWSE_RESOURCE_REQUESTED
from xynoplex.transport import FrameRefusal
from xynoplex.types import BrowseResourceRequest
from xynoplex.watched import Variable


async def read(origin: str, token: str, resource: ResourceId) -> None:
    async with HttpTransport(origin, token=Variable[str | None](token), channels=BRIDGED_CHANNELS) as transport:
        bus = Bus(transport)
        try:
            reply = await bus.request(BROWSE_RESOURCE_REQUESTED, BrowseResourceRequest(resource_id=resource))
        except BusRequestError as error:
            print(error.code)  # "bus.not-found", "bus.timeout", …: a closed vocabulary
            return
        print(reply.response.resource.name)

        # A resource's channel is read for the resource: the read holds its scope, and lets go on the way out.
        async with bus.frames(MARK_ADDED, resource) as added:
            async for heard in added:
                match heard:
                    case Delivered():
                        print(heard.scope, heard.payload.type)
                    case FrameRefusal():
                        print(f"a frame on {heard.channel} refused at its `{heard.member}`: {heard.reason}")
