// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.KSerializer
import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable
import kotlinx.serialization.SerializationException
import kotlinx.serialization.descriptors.SerialDescriptor
import kotlinx.serialization.encoding.Decoder
import kotlinx.serialization.encoding.Encoder
import kotlinx.serialization.json.JsonDecoder
import kotlinx.serialization.json.JsonEncoder
import kotlinx.serialization.json.JsonObject
import kotlinx.serialization.json.jsonObject

@Serializable(with = ScoredResourceIdentifierObject.Serializer::class)
public data class ScoredResourceIdentifierObject(
    @SerialName("@id")
    public val id: String? = null,
    public val value: String? = null,
    public val scheme: String? = null,
    /** Every property the schema does not name, as it came. */
    public val rest: JsonObject = JsonObject(emptyMap()),
) : ScoredResourceIdentifier {
    /** How Java makes a `ScoredResourceIdentifierObject`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor() {
        private var id: String? = null
        private var value: String? = null
        private var scheme: String? = null
        private var rest: JsonObject = JsonObject(emptyMap())

        public fun id(id: String?): Builder = apply { this.id = id }
        public fun value(value: String?): Builder = apply { this.value = value }
        public fun scheme(scheme: String?): Builder = apply { this.scheme = scheme }
        public fun rest(rest: JsonObject): Builder = apply { this.rest = rest }

        public fun build(): ScoredResourceIdentifierObject = ScoredResourceIdentifierObject(id = id, value = value, scheme = scheme, rest = rest)
    }

    public companion object {
        /** A builder of a `ScoredResourceIdentifierObject` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(): Builder = Builder()
    }

    @Serializable
    internal data class Known(
        @SerialName("@id")
        public val id: String? = null,
        public val value: String? = null,
        public val scheme: String? = null,
    )

    internal object Serializer : KSerializer<ScoredResourceIdentifierObject> {
        private val named: Set<String> = setOf("@id", "value", "scheme")

        override val descriptor: SerialDescriptor = SerialDescriptor("xynolog.types.ScoredResourceIdentifierObject", Known.serializer().descriptor)

        override fun deserialize(decoder: Decoder): ScoredResourceIdentifierObject {
            val json = decoder as? JsonDecoder ?: throw SerializationException("a ScoredResourceIdentifierObject is read from JSON alone")
            val all = json.decodeJsonElement().jsonObject
            val known = json.json.decodeFromJsonElement(Known.serializer(), JsonObject(all.filterKeys { it in named }))
            return ScoredResourceIdentifierObject(id = known.id, value = known.value, scheme = known.scheme, rest = JsonObject(all.filterKeys { it !in named }))
        }

        override fun serialize(encoder: Encoder, value: ScoredResourceIdentifierObject) {
            val json = encoder as? JsonEncoder ?: throw SerializationException("a ScoredResourceIdentifierObject is written as JSON alone")
            val known = json.json.encodeToJsonElement(Known.serializer(), Known(id = value.id, value = value.value, scheme = value.scheme)).jsonObject
            json.encodeJsonElement(JsonObject(known + value.rest))
        }
    }
}
