from typing import assert_never

from xynolog.cache import Failed, Pending, Ready
from xynolog.client import XynologClient
from xynolog.errors import XynologError
from xynolog.identifiers import ResourceId
from xynolog.transport import Transport


async def watch(client: XynologClient[Transport], resource: ResourceId) -> None:
    async with client.browse.annotations(resource) as live:  # holds the resource's scope
        async for state in live:
            match state:
                case Pending():
                    print("asking")
                case Ready(value=annotations):
                    print(len(annotations), "annotations")
                case Failed(error=XynologError() as error):  # a state, not a raise: the query lives on
                    print("failed:", error.code)
                case Failed(error=error):  # whatever else the request failed with
                    print("failed:", error)
                case _:
                    assert_never(state)
