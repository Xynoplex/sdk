// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.Serializable

/** What creating a resource from a clone token is told: the token, the clone's name and text, and whether the source is archived once the clone exists. */
@Serializable
public data class CreateFromTokenOptions(
    public val token: String,
    public val name: String,
    /** The clone's text, uploaded as its content. */
    public val content: String,
    public val archiveOriginal: Boolean? = null,
) {
    /** How Java makes a `CreateFromTokenOptions`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val token: String,
        private val name: String,
        private val content: String,
    ) {
        private var archiveOriginal: Boolean? = null

        public fun archiveOriginal(archiveOriginal: Boolean?): Builder = apply { this.archiveOriginal = archiveOriginal }

        public fun build(): CreateFromTokenOptions = CreateFromTokenOptions(token = token, name = name, content = content, archiveOriginal = archiveOriginal)
    }

    public companion object {
        /** A builder of a `CreateFromTokenOptions` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(token: String, name: String, content: String): Builder = Builder(token, name, content)
    }
}
