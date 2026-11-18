// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** Error response for failed bus commands. Replaces native Error objects on the EventBus so payloads are serializable and OpenAPI-typed. */
@Serializable
@JsonIgnoreUnknownKeys
public data class CommandError(
    /** Machine-readable failure class, for consumers that must BRANCH on why a command failed rather than log it. Optional and deliberately sparse: absent means 'no class declared', and every existing failure stays that way. An enum rather than a free string so the vocabulary has an owner — an unconstrained code is a mirror with no gate, and adding one should be a deliberate spec change. `message` remains the human-readable text and is unaffected. Members: `peer-unavailable` — the channel this command was sent on has no subscriber, i.e. the service that answers it has not connected yet. Transient by nature (a peer still starting), which is what distinguishes it from a refusal: retrying is the correct response. `not-found` — the resource this command addressed does not exist in this knowledge base. A verdict, not a symptom: it is emitted only where the answer comes from the event store, which is the system of record, and never from a projection that may merely be lagging. Deterministic, so unlike `peer-unavailable` retrying is pointless — and consumers may act destructively on it (the SDK deletes a restored tab). Absence is not denial: a future 'exists, but not for you' must travel as its own code, never as this one. `unauthorized` — that code: the caller is authenticated but not permitted to do what it asked. A verdict about the CALLER, not the resource, so retrying under the same credential cannot succeed and a consumer must never spin on it; emitted by `job:claim` for a caller whose token carries no worker role. `none-pending` — a declined claim, not an error: the queue holds no pending job of the requested types. Nothing went wrong; the one code a consumer PARKS on, meaning 'nothing to do until a wake-up'. Emitted by `job:claim` only. A `job:claim` refusal carrying neither is unclassified — a malformed record or a missing injection — and a consumer treats it as 'log it, assume nothing'. */
    public val code: CommandErrorCode? = null,
    /** Human-readable error message */
    public val message: String,
    /** Optional additional context (stack trace, field name, etc.) */
    public val details: String? = null,
) {
    /** How Java makes a `CommandError`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val message: String,
    ) {
        private var code: CommandErrorCode? = null
        private var details: String? = null

        public fun code(code: CommandErrorCode?): Builder = apply { this.code = code }
        public fun details(details: String?): Builder = apply { this.details = details }

        public fun build(): CommandError = CommandError(code = code, message = message, details = details)
    }

    public companion object {
        /** A builder of a `CommandError` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(message: String): Builder = Builder(message)
    }
}
