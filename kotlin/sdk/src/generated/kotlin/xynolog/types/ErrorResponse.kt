// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonElement
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** The body of every error the gateway answers, whatever the status and whatever the route — including a path it does not serve. */
@Serializable
@JsonIgnoreUnknownKeys
public data class ErrorResponse(
    /** What went wrong, in a sentence. */
    public val error: String,
    /** A machine-readable class, when the route defines one. */
    public val code: String? = null,
    /** What the caller can do about it, when there is something to say. */
    public val hint: String? = null,
    public val details: JsonElement? = null,
) {
    /** How Java makes a `ErrorResponse`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val error: String,
    ) {
        private var code: String? = null
        private var hint: String? = null
        private var details: JsonElement? = null

        public fun code(code: String?): Builder = apply { this.code = code }
        public fun hint(hint: String?): Builder = apply { this.hint = hint }
        public fun details(details: JsonElement?): Builder = apply { this.details = details }

        public fun build(): ErrorResponse = ErrorResponse(error = error, code = code, hint = hint, details = details)
    }

    public companion object {
        /** A builder of a `ErrorResponse` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(error: String): Builder = Builder(error)
    }
}
