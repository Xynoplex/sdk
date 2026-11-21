"""The client's surface against `protocol/specs/src/client/surface.json`.

Every method the table lists is called as each of its cases states, and what
the call did first is held to the row. The calls are surface_calls.py's,
generated from the table: a method this SDK lacks, or takes otherwise than the
table says, fails the type checkers.

What a method does first is one of: a request of a bus operation, a frame sent
over the wire, a frame published on the client's own bus, a call of the
content transport, a call of the gateway, or reading a channel of the client's
own bus. A call that is awaited is driven on a task of its own, and what it
resolves with is not this test's to judge: a case holds what the call did, not
what it was answered.
"""

import asyncio
from collections.abc import Callable
from typing import Final, final

import pytest
from aio import run, soon
from pydantic import JsonValue
from spec import SPEC, JsonObject, objects, read, text
from surface_arguments import Args, Client
from surface_calls import CALLS, EVENTS

from xynolog.channels import BRIDGED_CHANNELS
from xynolog.claims import JOB_CLAIM_CHANNELS
from xynolog.client import XynologClient
from xynolog.testing import (
    ContentCall,
    FaultyTransport,
    GetAnchoredText,
    GetAnnotations,
    GetBinary,
    GetBinaryStream,
    GetResourceGraph,
    InMemoryContent,
    PutBinary,
    StubGateway,
)
from xynolog.transport import Frame

TABLE = read(SPEC / "client/surface.json")


def fixtures() -> JsonObject:
    stated = TABLE["fixtures"]
    assert isinstance(stated, dict)
    return stated


FIXTURES: Final = fixtures()


def resolved(value: JsonValue) -> JsonValue:
    """`value` with each `{"$fixture": name}` replaced by the table's fixture."""
    if isinstance(value, list):
        return [resolved(item) for item in value]
    if not isinstance(value, dict):
        return value
    named = value.get("$fixture")
    if isinstance(named, str) and len(value) == 1:
        assert named in FIXTURES, f"the table has no fixture {named}"
        return FIXTURES[named]
    return {key: resolved(item) for key, item in value.items()}


def numbers(value: JsonValue) -> JsonValue:
    """`value` with every number as the number it is, however it was written: `200` and `200.0` are one JSON number."""
    if isinstance(value, bool):
        return value
    if isinstance(value, int | float):
        return float(value)
    if isinstance(value, list):
        return [numbers(item) for item in value]
    if isinstance(value, dict):
        return {key: numbers(item) for key, item in value.items()}
    return value


def content_call(call: ContentCall) -> tuple[str, JsonObject]:
    """A call of the content transport, as the table names it and states what it was given."""
    match call:
        case PutBinary(request=request):
            given: JsonObject = {
                "name": request.name,
                "content": request.file.decode(),
                "format": request.format,
                "storageUri": request.storage_uri,
            }
            if request.clone_token is not None:
                given["cloneToken"] = request.clone_token
            return "putBinary", given
        case GetBinary(resource_id=resource_id):
            return "getBinary", {"resourceId": resource_id}
        case GetBinaryStream(resource_id=resource_id):
            return "getBinaryStream", {"resourceId": resource_id}
        case GetResourceGraph(resource_id=resource_id):
            return "getResourceGraph", {"resourceId": resource_id}
        case GetAnnotations(resource_id=resource_id):
            return "getAnnotations", {"resourceId": resource_id}
        case GetAnchoredText(resource_id=resource_id):
            return "getAnchoredText", {"resourceId": resource_id}


GATEWAY: Final = {
    "get_current_user": "getCurrentUser",
    "get_media_token": "getMediaToken",
    "get_protected_resource_metadata": "getProtectedResourceMetadata",
    "health_check": "healthCheck",
    "get_status": "getStatus",
}
"""The gateway's own operations, as the table names each."""


def gateway_call(call: str) -> tuple[str, JsonObject]:
    """A call of the gateway, as the table names it and states what it was given."""
    operation, _, of = call.partition(" ")
    return GATEWAY[operation], {"resourceId": of} if of else {}


@final
class World:
    """A client over doubles nothing is scripted to answer, which record what it asked of each.

    Its stream names a full client's channels and what a worker's claims read: the surface claims jobs too.
    """

    def __init__(self) -> None:
        self.transport = FaultyTransport(channels=(*BRIDGED_CHANNELS, *JOB_CLAIM_CHANNELS))
        self.content = InMemoryContent()
        self.gateway = StubGateway()
        self.client: Client = XynologClient(self.transport, self.content, self.gateway)
        self.calls: list[asyncio.Task[object]] = []

    def call(self, namespace: str, method: str, args: Args) -> None:
        """Start `namespace.method` as the case states it."""
        started = CALLS[namespace, method](self.client, args)
        if started is not None:
            self.calls.append(asyncio.ensure_future(started))

    async def over(self) -> None:
        """End the client, and every call still waiting. What each resolved with is nobody's to judge here."""
        await self.client.close()
        for call in self.calls:
            call.cancel()
        await asyncio.gather(*self.calls, return_exceptions=True)


async def eventually[T](what: str, seen: Callable[[], T | None]) -> T:
    """Wait, a second at most, for `seen` to give something."""
    for _ in range(200):
        found_now = seen()
        if found_now is not None:
            return found_now
        await asyncio.sleep(0.005)
    raise AssertionError(f"{what} did not happen")


def via(step: JsonObject) -> tuple[str, str]:
    """What a row, or one further step of a case, goes through: the kind, and what it names."""
    (kind, named), *others = ((kind, named) for kind, named in step.items() if kind != "sends")
    assert not others, "a step goes through exactly one thing"
    return kind, text(named, kind)


async def held_to(world: World, at: int, step: JsonObject, sends: JsonValue, why: str) -> None:
    """One step of a case: what was done, and what it was given."""
    kind, named = via(step)
    if kind in ("request", "emit"):
        frame: Frame = await eventually(
            f"{why}: a frame on {named}", lambda: world.transport.emitted[at] if len(world.transport.emitted) > at else None
        )
        assert frame.channel == named, why
        assert numbers(dict(frame.payload)) == numbers(sends), f"{why}: what was sent"
        assert frame.scope is None, f"{why}: it is sent globally"
        assert (frame.correlation_id is not None) == (kind == "request"), (
            f"{why}: a request carries a key of the client's making, and a frame nobody answers carries none"
        )
    elif kind == "content":
        operation, given = content_call(
            await eventually(f"{why}: a call of the content transport", lambda: world.content.calls[0] if world.content.calls else None)
        )
        assert operation == named, why
        assert numbers(given) == numbers(sends), f"{why}: what it was given"
    elif kind == "gateway":
        operation, given = gateway_call(
            await eventually(f"{why}: a call of the gateway", lambda: world.gateway.calls[0] if world.gateway.calls else None)
        )
        assert operation == named, why
        assert numbers(given) == numbers(sends), f"{why}: what it was given"
    else:
        raise AssertionError(f"{why}: a step through {kind} is not one this runner holds")


def cases() -> list[tuple[str, str, JsonObject, JsonObject]]:
    """Every case of every row: the namespace, the method, the row and the case."""
    found_cases: list[tuple[str, str, JsonObject, JsonObject]] = []
    for namespace in objects(TABLE["namespaces"], "namespaces"):
        for row in objects(namespace["methods"], "methods"):
            for case in objects(row["cases"], "cases"):
                found_cases.append((text(namespace["namespace"], "namespace"), text(row["method"], "method"), row, case))
    return found_cases


CASES = cases()


def named(case: tuple[str, str, JsonObject, JsonObject]) -> str:
    namespace, method, _, stated = case
    return f"{namespace}.{method} ({stated.get('why', 'as stated')})"


@pytest.mark.parametrize("case", CASES, ids=named)
def test_a_method_does_what_its_row_says(case: tuple[str, str, JsonObject, JsonObject]) -> None:
    namespace, method, row, stated = case
    why = named(case)
    step = row["via"]
    assert isinstance(step, dict)
    kind, channel = via(step)
    args = resolved(stated["args"])
    assert isinstance(args, dict)
    sends = resolved(stated["sends"])

    async def scenario() -> None:
        world = World()
        try:
            if "answers" in stated:
                world.transport.queue_reply(channel, [resolved(stated["answers"])])
            if kind == "local":
                published = world.client.bus.frames_on(channel)
                world.call(namespace, method, args)
                frame = await soon(anext(published), within=1.0)
                assert isinstance(frame, Frame), f"{why}: what was published was refused: {frame!r}"
                assert numbers(dict(frame.payload)) == numbers(sends), f"{why}: what was published"
                assert frame.correlation_id == stated.get("correlationId"), f"{why}: the key on its envelope"
                await asyncio.sleep(0.02)
                assert world.transport.emitted == [], f"{why}: a signal never reaches the wire"
            elif kind == "observes":
                assert isinstance(sends, dict)
                hearing = asyncio.ensure_future(EVENTS[namespace, method](world.client))
                await asyncio.sleep(0)
                world.client.bus.emit(channel, sends)
                assert numbers(await soon(hearing, within=1.0)) == numbers(sends), f"{why}: what was heard"
            else:
                world.call(namespace, method, args)
                await held_to(world, 0, step, sends, why)
                then = stated.get("then", [])
                for index, further in enumerate(objects(then, "then")):
                    await held_to(world, index + 1, further, resolved(further["sends"]), why)
        finally:
            await world.over()

    run(scenario())
