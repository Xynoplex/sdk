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
 * When a knowledge base last described itself, and what it said beyond its name. A client shows it as current only while a session to the knowledge base is live, and as of `at` otherwise.
 */
@Serializable
@JsonIgnoreUnknownKeys
public data class KbRead(
    /**
     * When the description arrived.
     */
    @SerialName("at")
    public val at: String,
    /**
     * The branch of the knowledge base's working tree then. Absent when the working tree was not a git checkout.
     */
    @SerialName("gitBranch")
    public val gitBranch: String? = null,
) {
    /** How Java makes a `KbRead`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val at: String,
    ) {
        private var gitBranch: String? = null

        public fun gitBranch(gitBranch: String?): Builder {
            this.gitBranch = gitBranch
            return this
        }

        public fun build(): KbRead = KbRead(at = at, gitBranch = gitBranch)
    }

    public companion object {
        /** A builder of a `KbRead` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(at: String): Builder = Builder(at)
    }
}
