// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.DeserializationStrategy
import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.ExperimentalSerializationApi
import kotlinx.serialization.KSerializer
import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable
import kotlinx.serialization.SerializationException
import kotlinx.serialization.builtins.ListSerializer
import kotlinx.serialization.descriptors.PrimitiveKind
import kotlinx.serialization.descriptors.PrimitiveSerialDescriptor
import kotlinx.serialization.descriptors.SerialDescriptor
import kotlinx.serialization.descriptors.nullable
import kotlinx.serialization.encoding.Decoder
import kotlinx.serialization.encoding.Encoder
import kotlinx.serialization.json.JsonArray
import kotlinx.serialization.json.JsonContentPolymorphicSerializer
import kotlinx.serialization.json.JsonDecoder
import kotlinx.serialization.json.JsonElement
import kotlinx.serialization.json.JsonEncoder
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import kotlinx.serialization.json.JsonObject
import kotlinx.serialization.json.JsonPrimitive
import kotlinx.serialization.json.jsonObject
import kotlinx.serialization.serializer
import xynolog.identifiers.AnnotationId
import xynolog.identifiers.JobId
import xynolog.identifiers.ResourceId
import xynolog.identifiers.UserId

/**
 * The bounds on how far the staging driver may run behind the working tree, in milliseconds. A knowledge base that does not sync git stages nothing, and reads neither.
 */
@Serializable
public data class ArchivistConfigStaging(
    /**
     * The quiet period after the last change before pending changes are staged.
     */
    @SerialName("flushMs")
    public val flushMs: Long,
    /**
     * The longest a change waits to be staged while others keep arriving, measured from the oldest pending change.
     */
    @SerialName("maxWaitMs")
    public val maxWaitMs: Long,
) {
    /** How Java makes a `ArchivistConfigStaging`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val flushMs: Long,
        private val maxWaitMs: Long,
    ) {
        public fun build(): ArchivistConfigStaging = ArchivistConfigStaging(flushMs = flushMs, maxWaitMs = maxWaitMs)
    }

    public companion object {
        /** A builder of a `ArchivistConfigStaging` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(flushMs: Long, maxWaitMs: Long): Builder = Builder(flushMs, maxWaitMs)
    }
}
