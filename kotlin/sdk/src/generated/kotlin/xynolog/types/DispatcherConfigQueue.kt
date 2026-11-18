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
 * The JetStream broker holding the job queue, whose layout is specs/src/jobs/storage.json.
 */
@Serializable
public data class DispatcherConfigQueue(
    /**
     * The broker's address (`host:port`, or several, comma-separated).
     */
    @SerialName("servers")
    public val servers: String,
    /**
     * The environment variable holding the broker user, when the broker requires one.
     */
    @SerialName("userEnv")
    public val userEnv: String? = null,
    /**
     * The environment variable holding the broker password, when the broker requires one.
     */
    @SerialName("passwordEnv")
    public val passwordEnv: String? = null,
) {
    /** How Java makes a `DispatcherConfigQueue`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val servers: String,
    ) {
        private var userEnv: String? = null
        private var passwordEnv: String? = null

        public fun userEnv(userEnv: String?): Builder {
            this.userEnv = userEnv
            return this
        }

        public fun passwordEnv(passwordEnv: String?): Builder {
            this.passwordEnv = passwordEnv
            return this
        }

        public fun build(): DispatcherConfigQueue = DispatcherConfigQueue(servers = servers, userEnv = userEnv, passwordEnv = passwordEnv)
    }

    public companion object {
        /** A builder of a `DispatcherConfigQueue` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(servers: String): Builder = Builder(servers)
    }
}
