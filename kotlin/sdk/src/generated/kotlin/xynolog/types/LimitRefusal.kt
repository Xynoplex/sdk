// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonElement
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** An ErrorResponse that names, in `code`, the limit the request met. */
@Serializable
@JsonIgnoreUnknownKeys
public data class LimitRefusal(
    /** What went wrong, in a sentence. */
    public val error: String,
    /** `streams`: the principal already holds as many streams as its coefficient of `x-xynolog-limits.streamsPerPrincipal` allows. `emit-rate`: the principal's emits have used its bucket, whose rate and burst are its coefficient of `x-xynolog-limits.emitsPerPrincipal`, per gateway process. `unanswered-requests`: the client already awaits as many replies as `BusSubscribeRequest.pendingReplies` may name. `capacity`: the gateway holds as many queued bytes as it can. `refusal-rate`: the request's credential was refused, and the requests its holder has had refused have used their allowance; it answers only a request whose token has already failed verification, so it says what a 401 says, and a client that can renew its token renews it and sends the request again rather than waiting (contract/TRANSPORT-CONTRACT.md § A refused credential). */
    public val code: LimitRefusalCode,
    /** What the caller can do about it, when there is something to say. */
    public val hint: String? = null,
    public val details: JsonElement? = null,
) {
    /** How Java makes a `LimitRefusal`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val error: String,
        private val code: LimitRefusalCode,
    ) {
        private var hint: String? = null
        private var details: JsonElement? = null

        public fun hint(hint: String?): Builder = apply { this.hint = hint }
        public fun details(details: JsonElement?): Builder = apply { this.details = details }

        public fun build(): LimitRefusal = LimitRefusal(error = error, code = code, hint = hint, details = details)
    }

    public companion object {
        /** A builder of a `LimitRefusal` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(error: String, code: LimitRefusalCode): Builder = Builder(error, code)
    }
}
