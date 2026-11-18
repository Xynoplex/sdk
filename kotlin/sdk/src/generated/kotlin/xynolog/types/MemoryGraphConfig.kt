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
 * A graph held in the memory of the one process that is given it: for a test. It cannot be shared between processes, so a service that writes the graph for another to read, or reads what another wrote, refuses it.
 */
@Serializable
public data class MemoryGraphConfig(
    @SerialName("type")
    @EncodeDefault
    public val type: MemoryGraphConfigType = MemoryGraphConfigType.Memory,
) : GraphConfig {
    /** How Java makes a `MemoryGraphConfig`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor() {
        public fun build(): MemoryGraphConfig = MemoryGraphConfig()
    }

    public companion object {
        /** A builder of a `MemoryGraphConfig` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(): Builder = Builder()
    }
}
