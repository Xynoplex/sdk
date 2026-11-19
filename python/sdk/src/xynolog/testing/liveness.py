"""The liveness axioms, executable.

The state-unit axioms (`xynolog.testing.axioms`) make a unit's wrongness
detectable; these make silence detectable: under any behaviour of the wire,
something is eventually delivered.

- **L1** every output says something, a value or a failure, within the bound.
  Pending forever is the violation.
- **L2** every awaited path settles within the bound; a request is sent again
  no more often than its retry budget allows; and one whose last attempt was
  faulted is either sent again or surfaced, never swallowed.
- **L3** every event written to a live connection is delivered exactly once,
  wherever a client-initiated transition (a handoff, a reopening, a change of
  scope) lands relative to it: a connection is retired by drain, never by
  abort.

`assert_liveness_axioms` runs L1 and L2 against a composition over a
`FaultyTransport`, under generated fault schedules. `assert_exactly_once_delivery`
runs L3 against generated interleavings of writes and transitions, on anything
shaped like a connection: a model of one, or a real transport over real
sockets. Each raises `AssertionError` naming the axiom broken, how, and under
what.

A composition and a subject are each built by an asynchronous context manager:
built on the way in, ended on the way out, as the client, the transport and the
session they are built of are held. Each case runs on an event loop of its own
whose clock is the real one, so a subject may do real I/O. A case of L1 and L2
runs for the whole of its bound, however soon everything it watches has
spoken, so a request sent again after that is counted: a composition is given
small timeouts, and each case costs its bound.

The cases are drawn by Hypothesis, which is installed with the extra
`xynolog[axioms]` and imported when a harness runs or a strategy is asked for:
every module of the package, this one among them, imports without it. Call a
harness from a test that is not itself running an event loop.
"""

import asyncio
from abc import ABC, abstractmethod
from collections import Counter
from collections.abc import Callable, Coroutine, Sequence
from contextlib import AbstractAsyncContextManager
from typing import TYPE_CHECKING, Final

from xynolog.channels import BRIDGED_CHANNELS
from xynolog.testing._kit import (
    DELAY_MS,
    DELIVERY_OPS,
    FAULTS,
    SCHEDULE_LENGTH,
    SLACK,
    Delay,
    DeliveryOp,
    DropReply,
    FaultAction,
    RejectEmit,
    RequestLogEntry,
)
from xynolog.testing._liveness_kit import LivenessScenario, LivenessSpec
from xynolog.testing.transport import FaultyTransport, refuse_unscripted_operation

if TYPE_CHECKING:
    from hypothesis.strategies import SearchStrategy

__all__ = [
    "DeliveryOp",
    "DeliverySubject",
    "LivenessScenario",
    "LivenessSpec",
    "assert_exactly_once_delivery",
    "assert_liveness_axioms",
    "delivery_ops",
    "fault_actions",
    "fault_schedules",
]

_LONGEST: Final = 12
"""The most steps of a drawn interleaving, when no interleavings are given."""


def _held[T](values: "SearchStrategy[T]", cases: int, case: Callable[[T], Coroutine[object, object, str | None]]) -> None:
    """Run `case` on each of `cases` values drawn, each on a loop of its own, and raise the violation one gives as an `AssertionError`."""
    from hypothesis import given, settings

    @settings(max_examples=cases, database=None, deadline=None, derandomize=True)
    @given(values)
    def holds(value: T) -> None:
        violation = asyncio.run(case(value))
        if violation is not None:
            raise AssertionError(violation)

    holds()


# ── L1, L2 ──────────────────────────────────────────────────────────────


def fault_actions() -> "SearchStrategy[FaultAction]":
    """A wire behaviour, each as likely as the others. A delay is of `DELAY_MS` milliseconds."""
    from hypothesis import strategies as st

    least, most = DELAY_MS

    def drawn(fault: type[FaultAction]) -> "SearchStrategy[FaultAction]":
        if issubclass(fault, Delay):
            return st.integers(min_value=least, max_value=most).map(Delay)
        return st.just(fault())

    return st.one_of(*(drawn(fault) for fault in FAULTS))


def fault_schedules() -> "SearchStrategy[list[FaultAction]]":
    """A fault schedule of `SCHEDULE_LENGTH` behaviours."""
    from hypothesis import strategies as st

    least, most = SCHEDULE_LENGTH
    return st.lists(fault_actions(), min_size=least, max_size=most)


def _described(schedule: Sequence[FaultAction]) -> str:
    """A schedule as a violation names it."""
    return ",".join(f"delay({action.ms})" if isinstance(action, Delay) else action.kind for action in schedule)


async def _watched(scenario: LivenessScenario, bound_ms: int) -> tuple[list[bool], list[bool]]:
    """Watch every output and every path for the whole of the bound.

    Gives which outputs said something, and which paths settled.
    """
    outputs = [asyncio.ensure_future(output) for output in scenario.outputs]
    settlements = [asyncio.ensure_future(settlement) for settlement in scenario.settlements]
    watched = [*outputs, *settlements]
    # The whole bound, however soon everything has spoken: a request sent again after that is counted too.
    await asyncio.sleep(bound_ms / 1000)
    notified = [output.done() for output in outputs]
    settled = [settlement.done() for settlement in settlements]
    # What is still waiting is stopped before the composition is ended. Either way is settled: what one raised is no axiom's business.
    for task in watched:
        task.cancel()
    await asyncio.gather(*watched, return_exceptions=True)
    return notified, settled


def _liveness_violation(
    retry_budget: int,
    bound_ms: int,
    schedule: Sequence[FaultAction],
    notified: list[bool],
    settled: list[bool],
    log: Sequence[RequestLogEntry],
) -> str | None:
    """What a case broke, or nothing."""
    under = f"under schedule ⟨{_described(schedule)}⟩"
    # L2 first: where it applies it names the mechanism. L1 is the broader net, and would shadow it.
    if False in settled:
        return f"L2: settlement #{settled.index(False)} did not settle within {bound_ms}ms {under}"
    sent = Counter[str]()
    last_faulted: dict[str, bool] = {}
    for entry in log:
        sent[entry.retry_key] += 1
        last_faulted[entry.retry_key] = isinstance(entry.action, DropReply | RejectEmit)
    silent = True not in notified
    for key, times in sent.items():
        if times > 1 + retry_budget:
            return f"L2: request ⟨{key}⟩ was sent {times} times, past the retry budget (1 + {retry_budget}) {under}"
        if last_faulted[key] and times <= retry_budget and len(notified) > 0 and silent:
            return f"L2: faulted request ⟨{key}⟩ was neither sent again nor surfaced {under}: its failure was swallowed"
    if False in notified:
        return f"L1: output #{notified.index(False)} said nothing within {bound_ms}ms {under}: silently pending"
    return None


def assert_liveness_axioms(spec: LivenessSpec) -> None:
    """Run L1 and L2 across fault schedules. Raises `AssertionError` naming the first axiom broken, how, and under which schedule."""
    schedules = fault_schedules() if spec.schedules is None else spec.schedules

    async def case(schedule: Sequence[FaultAction]) -> str | None:
        delays = sum(action.ms for action in schedule if isinstance(action, Delay))
        bound_ms = (spec.timeout_ms * (1 + spec.retry_budget) + delays) * SLACK
        make_response = refuse_unscripted_operation if spec.make_response is None else spec.make_response
        transport = FaultyTransport(schedule, channels=BRIDGED_CHANNELS, make_response=make_response)
        try:
            async with spec.setup(transport) as scenario:
                notified, settled = await _watched(scenario, bound_ms)
                return _liveness_violation(spec.retry_budget, bound_ms, schedule, notified, settled, transport.request_log)
        finally:
            await transport.close()

    _held(schedules, spec.cases, case)


# ── L3 ──────────────────────────────────────────────────────────────────


class DeliverySubject(ABC):
    """Something shaped like a connection.

    It accepts writes to whichever connection is live, can be told to change
    connections, and delivers.
    """

    @abstractmethod
    def write(self, event_id: str) -> None:
        """Write the event with this id to the connection that is live now."""

    @abstractmethod
    async def transition(self) -> None:
        """Make a client-initiated transition: a handoff, a reopening, a change of scope."""

    @abstractmethod
    async def delivered(self) -> Sequence[str]:
        """Let whatever is in flight be delivered, then give the ids delivered, in order."""


def _writing(ops: list[DeliveryOp]) -> list[DeliveryOp]:
    """The interleaving, with a write at its end when it has none."""
    return ops if "write" in ops else [*ops, "write"]


def delivery_ops(longest: int) -> "SearchStrategy[list[DeliveryOp]]":
    """Interleavings of writes and transitions, of one to `longest` steps.

    Each has at least one write: a sequence that writes nothing checks nothing.
    """
    from hypothesis import strategies as st

    return st.lists(st.sampled_from(DELIVERY_OPS), min_size=1, max_size=longest).map(_writing)


def _delivery_violation(ops: Sequence[DeliveryOp], written: Sequence[str], delivered: Sequence[str]) -> str | None:
    """The first event written that was not delivered exactly once, or nothing."""
    under = f"under ⟨{','.join(ops)}⟩"
    for event_id in written:
        times = delivered.count(event_id)
        if times == 0:
            return f"L3: event ⟨{event_id}⟩ was delivered 0 times {under}: lost across a transition"
        if times > 1:
            return f"L3: event ⟨{event_id}⟩ was delivered {times} times {under}"
    return None


def assert_exactly_once_delivery(
    setup: Callable[[], AbstractAsyncContextManager[DeliverySubject]],
    *,
    ops: "SearchStrategy[Sequence[DeliveryOp]] | None" = None,
    cases: int,
) -> None:
    """Run L3 across `cases` interleavings, drawn from `ops`; with none, `delivery_ops(12)`'s.

    `setup` builds a fresh subject for each, inside the case's loop, and ends
    it on the way out. Raises `AssertionError` naming the event lost or
    doubled, and the interleaving.
    """
    interleavings = delivery_ops(_LONGEST) if ops is None else ops

    async def case(steps: Sequence[DeliveryOp]) -> str | None:
        written: list[str] = []
        async with setup() as subject:
            # No settling between steps: the races that matter are a transition landing before a write has been delivered.
            for number, step in enumerate(steps):
                match step:
                    case "write":
                        event_id = f"e{number}"
                        subject.write(event_id)
                        written.append(event_id)
                    case "transition":
                        await subject.transition()
            return _delivery_violation(steps, written, await subject.delivered())

    _held(interleavings, cases, case)
