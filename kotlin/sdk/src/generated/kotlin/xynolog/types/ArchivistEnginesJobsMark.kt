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
 * The engine for `mark` jobs of each motivation.
 */
@Serializable
public data class ArchivistEnginesJobsMark(
    @SerialName("highlighting")
    public val highlighting: Engine? = null,
    @SerialName("commenting")
    public val commenting: Engine? = null,
    @SerialName("assessing")
    public val assessing: Engine? = null,
    @SerialName("linking")
    public val linking: Engine? = null,
    @SerialName("tagging")
    public val tagging: Engine? = null,
) {
    /** How Java makes a `ArchivistEnginesJobsMark`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor() {
        private var highlighting: Engine? = null
        private var commenting: Engine? = null
        private var assessing: Engine? = null
        private var linking: Engine? = null
        private var tagging: Engine? = null

        public fun highlighting(highlighting: Engine?): Builder {
            this.highlighting = highlighting
            return this
        }

        public fun commenting(commenting: Engine?): Builder {
            this.commenting = commenting
            return this
        }

        public fun assessing(assessing: Engine?): Builder {
            this.assessing = assessing
            return this
        }

        public fun linking(linking: Engine?): Builder {
            this.linking = linking
            return this
        }

        public fun tagging(tagging: Engine?): Builder {
            this.tagging = tagging
            return this
        }

        public fun build(): ArchivistEnginesJobsMark = ArchivistEnginesJobsMark(highlighting = highlighting, commenting = commenting, assessing = assessing, linking = linking, tagging = tagging)
    }

    public companion object {
        /** A builder of a `ArchivistEnginesJobsMark` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(): Builder = Builder()
    }
}
