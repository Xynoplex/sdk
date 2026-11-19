# Generated from protocol/specs/src/client/testing.json; do not edit.
# Regenerate: make generate (codegen/lib/testing/python.ml)
# ruff: noqa: E501, I001, RUF002, RUF022, RUF100

"""The testing kit's facts: what a faulty transport does to a request, the bounds a
liveness check draws a schedule within and the room it gives a case, the steps
an exactly-once check interleaves, and the request log's entry."""

from collections.abc import Mapping
from dataclasses import dataclass, field
from typing import Final, Literal, final

from pydantic import JsonValue

__all__ = [
    "DELAY_MS",
    "DELIVERY_OPS",
    "Delay",
    "Deliver",
    "DeliveryOp",
    "DropReply",
    "DuplicateReply",
    "FAULTS",
    "FaultAction",
    "RejectEmit",
    "RequestLogEntry",
    "SCHEDULE_LENGTH",
    "SLACK",
]


@final
@dataclass(frozen=True, slots=True)
class Deliver:
    """The request's reply is delivered."""

    kind: Literal["deliver"] = field(default="deliver", init=False)


@final
@dataclass(frozen=True, slots=True)
class DropReply:
    """The request's reply is lost."""

    kind: Literal["drop-reply"] = field(default="drop-reply", init=False)


@final
@dataclass(frozen=True, slots=True)
class Delay:
    """The request's reply is delivered after `ms` milliseconds."""

    ms: int
    kind: Literal["delay"] = field(default="delay", init=False)


@final
@dataclass(frozen=True, slots=True)
class DuplicateReply:
    """The request's reply is delivered twice."""

    kind: Literal["duplicate-reply"] = field(default="duplicate-reply", init=False)


@final
@dataclass(frozen=True, slots=True)
class RejectEmit:
    """The emit itself is refused: the request never reaches the gateway."""

    kind: Literal["reject-emit"] = field(default="reject-emit", init=False)


type FaultAction = Deliver | DropReply | Delay | DuplicateReply | RejectEmit
"""What the wire does to one request."""

FAULTS: Final = (Deliver, DropReply, Delay, DuplicateReply, RejectEmit)
"""Every fault: what a schedule is drawn from."""

DELAY_MS: Final = (0, 5)
"""The delays a drawn fault is of, in milliseconds. Its least and its most."""

SCHEDULE_LENGTH: Final = (1, 8)
"""How many faults a drawn schedule is of. Its least and its most."""

SLACK: Final = 4
"""How many times its reckoned bound a case is given: the room a scheduler's jitter takes."""

type DeliveryOp = Literal["write", "transition"]
"""One step of an interleaving: a write, or a client-initiated transition."""

DELIVERY_OPS: Final[tuple[DeliveryOp, ...]] = ("write", "transition")
"""Every delivery step."""


@final
@dataclass(frozen=True, slots=True, kw_only=True)
class RequestLogEntry:
    """One request the transport was sent."""

    channel: str
    """The channel it was sent on."""
    action: FaultAction
    """What the schedule did to it."""
    correlation_id: str | None
    """What pairs it with its reply; `None` for a request that awaits none."""
    retry_key: str
    """The request's identity across retries: two entries with the same key are one logical request, sent again."""
    payload: Mapping[str, JsonValue]
    """The payload as it was sent."""
