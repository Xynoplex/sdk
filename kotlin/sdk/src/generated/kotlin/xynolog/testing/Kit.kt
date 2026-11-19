// Generated from protocol/specs/src/client/testing.json; do not edit.
// Regenerate: make generate (codegen/lib/testing/kotlin.ml)

package xynolog.testing

import kotlinx.coroutines.Dispatchers
import kotlinx.serialization.json.JsonObject
import xynolog.Generated
import java.util.concurrent.CompletableFuture
import kotlin.coroutines.CoroutineContext

/** What the wire does to one request. */
@Generated
public sealed interface FaultAction {
    /** The word a request log names it by. */
    public val kind: String
}

/** The request's reply is delivered. */
@Generated
public data object Deliver : FaultAction {
    override val kind: String = "deliver"
}

/** The request's reply is lost. */
@Generated
public data object DropReply : FaultAction {
    override val kind: String = "drop-reply"
}

/** The request's reply is delivered after `ms` milliseconds. */
@Generated
public data class Delay(public val ms: Long) : FaultAction {
    override val kind: String = "delay"
}

/** The request's reply is delivered twice. */
@Generated
public data object DuplicateReply : FaultAction {
    override val kind: String = "duplicate-reply"
}

/** The emit itself is refused: the request never reaches the gateway. */
@Generated
public data object RejectEmit : FaultAction {
    override val kind: String = "reject-emit"
}

/** Every fault: what a schedule is drawn from, a delay's own milliseconds drawn apart. */
internal val FAULTS: List<FaultAction> = listOf(Deliver, DropReply, Delay(0), DuplicateReply, RejectEmit)

/** The delays a drawn fault is of, in milliseconds. */
internal val DELAY_MS: IntRange = 0..5

/** How many faults a drawn schedule is of. */
internal val SCHEDULE_LENGTH: IntRange = 1..8

/** How many times its reckoned bound a case is given: the room a scheduler's jitter takes. */
internal const val SLACK: Int = 4

/** One step of an interleaving: a write, or a client-initiated transition. */
@Generated
public enum class DeliveryOp(
    /** The step, as every SDK spells it. */
    public val value: String,
) {
    Write("write"),
    Transition("transition"),
}

/** One request the transport was sent. */
@Generated
public data class RequestLogEntry(
    /** The channel it was sent on. */
    public val channel: String,
    /** What the schedule did to it. */
    public val action: FaultAction,
    /** What pairs it with its reply; null for a request that awaits none. */
    public val correlationId: String?,
    /** The request's identity across retries: two entries with the same key are one logical request, sent again (`retryKeyOf`). */
    public val retryKey: String,
    /** The payload as it was sent. */
    public val payload: JsonObject,
)

/** What one fresh run of a composition exposes to the axioms. */
@Generated
public class LivenessScenario @JvmOverloads constructor(
    /** One per output: each completes when the output has said something, a value or a failure (L1). A live query's first state, pending, is nothing said. */
    public val outputs: List<CompletableFuture<*>>,
    /** One per awaited path: each completes when the path has settled, by returning or by failing (L2). */
    public val settlements: List<CompletableFuture<*>>,
    /** What closing it ends: the composition. */
    private val end: AutoCloseable = AutoCloseable { Unit },
) : AutoCloseable {
    override fun close(): Unit = end.close()
}

/** A composition, and the schedules it is run under. */
@Generated
public class LivenessSpec @JvmOverloads constructor(
    /** Builds a fresh composition over the transport it is given, whose stream names a full client's channels (`BRIDGED_CHANNELS`). The scenario it gives is closed when the case is over, and the transport after it. */
    public val setup: (FaultyTransport) -> LivenessScenario,
    /** The time the composition gives a bus request. A case's bound is derived from it: the timeout times one more than `retryBudget`, and the schedule's delays, all of it `SLACK` times over. */
    public val timeoutMs: Long,
    /** How often the composition may send a logical request again. */
    public val retryBudget: Int,
    /** How many schedules are drawn (`faultSchedules`) when `schedules` states none. */
    public val cases: Int,
    /** The fault schedules to run, one case each, in place of drawn ones. */
    public val schedules: List<List<FaultAction>> = emptyList(),
    /** What the gateway answers a request nothing queued an answer for, as `FaultyTransport`'s `respond` does. */
    public val makeResponse: Respond = REFUSE_UNSCRIPTED,
    /** What the transport is made on. Each case blocks its caller's thread while it waits out its bound there, and a wait on a clock the caller controls ends only when the caller moves it, so on a test dispatcher, whose time moves only when its test advances it, a case never ends: give it a dispatcher that keeps the system's time. */
    public val context: CoroutineContext = Dispatchers.Default,
)
