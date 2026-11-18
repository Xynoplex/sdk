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
 * The engine each job is done with when software does it, keyed as a job description is: by `jobType`, and for `mark` by motivation.
 */
@Serializable
public data class ArchivistEnginesJobs(
    /**
     * The engine for `mark` jobs of each motivation.
     */
    @SerialName("mark")
    public val mark: ArchivistEnginesJobsMark? = null,
    @SerialName("yield")
    public val yield: Engine? = null,
) {
    /** How Java makes a `ArchivistEnginesJobs`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor() {
        private var mark: ArchivistEnginesJobsMark? = null
        private var yield: Engine? = null

        public fun mark(mark: ArchivistEnginesJobsMark?): Builder {
            this.mark = mark
            return this
        }

        public fun yield(yield: Engine?): Builder {
            this.yield = yield
            return this
        }

        public fun build(): ArchivistEnginesJobs = ArchivistEnginesJobs(mark = mark, yield = yield)
    }

    public companion object {
        /** A builder of a `ArchivistEnginesJobs` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(): Builder = Builder()
    }
}
