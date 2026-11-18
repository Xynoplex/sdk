// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.Serializable

/** The knowledge base has the resource, and said what it is called now. */
@Serializable
public data class TabCheckReady(
    /** What checking an open resource against its knowledge base concluded. */
    @EncodeDefault
    public val verdict: TabCheckReadyVerdict = TabCheckReadyVerdict.Ready,
    /** The name the knowledge base gave the resource. */
    public val name: String,
    /** The media type of its primary representation. Absent when it said none. */
    public val mediaType: String? = null,
) : TabCheck {
    /** How Java makes a `TabCheckReady`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val name: String,
    ) {
        private var mediaType: String? = null

        public fun mediaType(mediaType: String?): Builder = apply { this.mediaType = mediaType }

        public fun build(): TabCheckReady = TabCheckReady(name = name, mediaType = mediaType)
    }

    public companion object {
        /** A builder of a `TabCheckReady` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(name: String): Builder = Builder(name)
    }
}
