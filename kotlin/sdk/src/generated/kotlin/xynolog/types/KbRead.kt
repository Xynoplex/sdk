// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** When a knowledge base last described itself, and what it said beyond its name. A client shows it as current only while a session to the knowledge base is live, and as of `at` otherwise. */
@Serializable
@JsonIgnoreUnknownKeys
public data class KbRead(
    /** When the description arrived. */
    public val at: String,
    /** The branch of the knowledge base's working tree then. Absent when the working tree was not a git checkout. */
    public val gitBranch: String? = null,
) {
    /** How Java makes a `KbRead`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val at: String,
    ) {
        private var gitBranch: String? = null

        public fun gitBranch(gitBranch: String?): Builder = apply { this.gitBranch = gitBranch }

        public fun build(): KbRead = KbRead(at = at, gitBranch = gitBranch)
    }

    public companion object {
        /** A builder of a `KbRead` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(at: String): Builder = Builder(at)
    }
}
