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
 * One edit to a linking annotation's body list: add or remove a body item, or replace an existing one.
 */
@Serializable
@JsonIgnoreUnknownKeys
public data class BindBodyOperation(
    /**
     * The type of body operation
     */
    @SerialName("op")
    public val op: BindBodyOperationOp,
    @SerialName("item")
    public val item: AnnotationBody? = null,
    @SerialName("oldItem")
    public val oldItem: AnnotationBody? = null,
    @SerialName("newItem")
    public val newItem: AnnotationBody? = null,
) {
    /** How Java makes a `BindBodyOperation`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val op: BindBodyOperationOp,
    ) {
        private var item: AnnotationBody? = null
        private var oldItem: AnnotationBody? = null
        private var newItem: AnnotationBody? = null

        public fun item(item: AnnotationBody?): Builder {
            this.item = item
            return this
        }

        public fun oldItem(oldItem: AnnotationBody?): Builder {
            this.oldItem = oldItem
            return this
        }

        public fun newItem(newItem: AnnotationBody?): Builder {
            this.newItem = newItem
            return this
        }

        public fun build(): BindBodyOperation = BindBodyOperation(op = op, item = item, oldItem = oldItem, newItem = newItem)
    }

    public companion object {
        /** A builder of a `BindBodyOperation` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(op: BindBodyOperationOp): Builder = Builder(op)
    }
}
