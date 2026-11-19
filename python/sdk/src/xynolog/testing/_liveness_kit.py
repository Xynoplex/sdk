# Generated from protocol/specs/src/client/testing.json; do not edit.
# Regenerate: make generate (codegen/lib/testing/python.ml)
# ruff: noqa: E501, I001, RUF002, RUF022, RUF100

"""What a liveness check is run over: a composition, the schedules it is run under,
and what one fresh run of it exposes."""

from collections.abc import Awaitable, Sequence
from dataclasses import dataclass
from typing import TYPE_CHECKING, final

if TYPE_CHECKING:
    from collections.abc import Callable
    from contextlib import AbstractAsyncContextManager

    from hypothesis.strategies import SearchStrategy

    from xynolog.testing._kit import FaultAction
    from xynolog.testing.transport import FaultyTransport, MakeResponse

__all__ = [
    "LivenessScenario",
    "LivenessSpec",
]


@final
@dataclass(frozen=True, slots=True, kw_only=True)
class LivenessScenario:
    """What one fresh run of a composition exposes to the axioms."""

    outputs: Sequence[Awaitable[object]]
    """One per output: it completes when the output has said something, a value or a failure (L1).

    A live query's first state, `Pending`, is nothing said: an output of one
    completes on the first state that is not."""
    settlements: Sequence[Awaitable[object]]
    """One per awaited path: it completes when the path has settled, by returning or by raising (L2)."""


@final
@dataclass(frozen=True, slots=True, kw_only=True)
class LivenessSpec:
    """A composition, and the schedules it is run under."""

    setup: "Callable[[FaultyTransport], AbstractAsyncContextManager[LivenessScenario]]"
    """Build a fresh composition over the transport it is given, and give what it exposes.

    The transport's stream names a full client's channels, `BRIDGED_CHANNELS`.

    Called once per case, inside the case's loop. What it opened it ends on
    the way out, and the transport is closed after."""
    timeout_ms: int
    """The time the composition gives a bus request.

    The bound is derived from it: the timeout times one more than the retry
    budget, and the schedule's delays, all of it `SLACK` times over."""
    retry_budget: int
    """How often a logical request may be sent again."""
    cases: int
    """How many schedules it is run under."""
    schedules: "SearchStrategy[Sequence[FaultAction]] | None" = None
    """The schedules drawn; with none, `fault_schedules()`'s."""
    make_response: "MakeResponse | None" = None
    """What the gateway answers a request nothing queued an answer for, as `FaultyTransport`'s `make_response` does; with none, `refuse_unscripted_operation`."""
