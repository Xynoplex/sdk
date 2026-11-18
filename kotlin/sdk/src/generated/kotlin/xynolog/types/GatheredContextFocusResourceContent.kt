// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** Resource content (included when requested) */
@Serializable
@JsonIgnoreUnknownKeys
public data class GatheredContextFocusResourceContent(
    /** Content of the focal resource */
    public val main: String? = null,
    /** Map of related resource IDs to their content */
    public val related: kotlin.collections.Map<String, String>? = null,
) {
    /** How Java makes a `GatheredContextFocusResourceContent`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor() {
        private var main: String? = null
        private var related: kotlin.collections.Map<String, String>? = null

        public fun main(main: String?): Builder = apply { this.main = main }
        public fun related(related: kotlin.collections.Map<String, String>?): Builder = apply { this.related = related }

        public fun build(): GatheredContextFocusResourceContent = GatheredContextFocusResourceContent(main = main, related = related)
    }

    public companion object {
        /** A builder of a `GatheredContextFocusResourceContent` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(): Builder = Builder()
    }
}
