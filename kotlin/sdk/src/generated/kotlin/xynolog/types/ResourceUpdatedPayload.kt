// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** Payload for yield:updated domain event */
@Serializable
@JsonIgnoreUnknownKeys
public data class ResourceUpdatedPayload(
    /** SHA-256 of new content */
    public val contentChecksum: String,
    public val contentByteSize: Long? = null,
) {
    /** How Java makes a `ResourceUpdatedPayload`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val contentChecksum: String,
    ) {
        private var contentByteSize: Long? = null

        public fun contentByteSize(contentByteSize: Long?): Builder = apply { this.contentByteSize = contentByteSize }

        public fun build(): ResourceUpdatedPayload = ResourceUpdatedPayload(contentChecksum = contentChecksum, contentByteSize = contentByteSize)
    }

    public companion object {
        /** A builder of a `ResourceUpdatedPayload` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(contentChecksum: String): Builder = Builder(contentChecksum)
    }
}
