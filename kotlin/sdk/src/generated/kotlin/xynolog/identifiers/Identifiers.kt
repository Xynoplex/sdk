// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.identifiers

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

/**
 * An annotation's id: a name, never the annotation's URI. 1 to 128 of the letters `A`–`Z` and `a`–`z`, the digits, `_` and `-`. It is one segment of a URL and one name in a file system, and it is held to that wherever it enters: a gateway refuses a payload that carries anything else. How one is made is no part of the rule.
 */
@Serializable(with = AnnotationId.Serializer::class)
@JvmExposeBoxed
@JvmInline
public value class AnnotationId(
    /** The id as text. */
    public val value: String,
) {
    init {
        if (!admits(value)) throw InvalidIdentifier("AnnotationId", PATTERN, value)
    }

    override fun toString(): String = value

    /** The id as a JSON string; text its rule refuses fails as a decoder's failures do. */
    internal object Serializer : KSerializer<AnnotationId> {
        override val descriptor: SerialDescriptor = PrimitiveSerialDescriptor("xynolog.identifiers.AnnotationId", PrimitiveKind.STRING)

        override fun serialize(encoder: Encoder, value: AnnotationId) {
            encoder.encodeString(value.value)
        }

        override fun deserialize(decoder: Decoder): AnnotationId =
            try {
                AnnotationId(decoder.decodeInline(descriptor).decodeString())
            } catch (refused: InvalidIdentifier) {
                throw SerializationException(refused.message, refused)
            }
    }

    public companion object {
        /** The rule a value is held to, as the spec writes it. */
        public const val PATTERN: String = "^[A-Za-z0-9_-]{1,128}\$"

        /** `value` as a `AnnotationId`, or null when it is not one. */
        @JvmStatic
        @JvmExposeBoxed
        public fun parse(value: String): AnnotationId? = if (admits(value)) AnnotationId(value) else null

        private fun admits(value: String): Boolean = value.codePointCount(0, value.length) in 1..128 && value.codePoints().allMatch { c -> c in 'A'.code..'Z'.code || c in 'a'.code..'z'.code || c in '0'.code..'9'.code || c == '_'.code || c == '-'.code }
    }
}

/**
 * A job's id. 1 to 128 of the letters `A`–`Z` and `a`–`z`, the digits, `_` and `-`. It is one segment of a URL and one name in a file system, and it is held to that wherever it enters: a gateway refuses a payload that carries anything else. How one is made is no part of the rule.
 */
@Serializable(with = JobId.Serializer::class)
@JvmExposeBoxed
@JvmInline
public value class JobId(
    /** The id as text. */
    public val value: String,
) {
    init {
        if (!admits(value)) throw InvalidIdentifier("JobId", PATTERN, value)
    }

    override fun toString(): String = value

    /** The id as a JSON string; text its rule refuses fails as a decoder's failures do. */
    internal object Serializer : KSerializer<JobId> {
        override val descriptor: SerialDescriptor = PrimitiveSerialDescriptor("xynolog.identifiers.JobId", PrimitiveKind.STRING)

        override fun serialize(encoder: Encoder, value: JobId) {
            encoder.encodeString(value.value)
        }

        override fun deserialize(decoder: Decoder): JobId =
            try {
                JobId(decoder.decodeInline(descriptor).decodeString())
            } catch (refused: InvalidIdentifier) {
                throw SerializationException(refused.message, refused)
            }
    }

    public companion object {
        /** The rule a value is held to, as the spec writes it. */
        public const val PATTERN: String = "^[A-Za-z0-9_-]{1,128}\$"

        /** `value` as a `JobId`, or null when it is not one. */
        @JvmStatic
        @JvmExposeBoxed
        public fun parse(value: String): JobId? = if (admits(value)) JobId(value) else null

        private fun admits(value: String): Boolean = value.codePointCount(0, value.length) in 1..128 && value.codePoints().allMatch { c -> c in 'A'.code..'Z'.code || c in 'a'.code..'z'.code || c in '0'.code..'9'.code || c == '_'.code || c == '-'.code }
    }
}

/**
 * A resource's id: a name, never the resource's URI or a path. 1 to 128 of the letters `A`–`Z` and `a`–`z`, the digits, `_` and `-`. It is one segment of a URL and one name in a file system, and it is held to that wherever it enters: a gateway refuses a payload that carries anything else. How one is made is no part of the rule. `__system__` is the one that names no resource: the scope events about the knowledge base itself are logged under.
 */
@Serializable(with = ResourceId.Serializer::class)
@JvmExposeBoxed
@JvmInline
public value class ResourceId(
    /** The id as text. */
    public val value: String,
) {
    init {
        if (!admits(value)) throw InvalidIdentifier("ResourceId", PATTERN, value)
    }

    override fun toString(): String = value

    /** The id as a JSON string; text its rule refuses fails as a decoder's failures do. */
    internal object Serializer : KSerializer<ResourceId> {
        override val descriptor: SerialDescriptor = PrimitiveSerialDescriptor("xynolog.identifiers.ResourceId", PrimitiveKind.STRING)

        override fun serialize(encoder: Encoder, value: ResourceId) {
            encoder.encodeString(value.value)
        }

        override fun deserialize(decoder: Decoder): ResourceId =
            try {
                ResourceId(decoder.decodeInline(descriptor).decodeString())
            } catch (refused: InvalidIdentifier) {
                throw SerializationException(refused.message, refused)
            }
    }

    public companion object {
        /** The rule a value is held to, as the spec writes it. */
        public const val PATTERN: String = "^[A-Za-z0-9_-]{1,128}\$"

        /** `value` as a `ResourceId`, or null when it is not one. */
        @JvmStatic
        @JvmExposeBoxed
        public fun parse(value: String): ResourceId? = if (admits(value)) ResourceId(value) else null

        private fun admits(value: String): Boolean = value.codePointCount(0, value.length) in 1..128 && value.codePoints().allMatch { c -> c in 'A'.code..'Z'.code || c in 'a'.code..'z'.code || c in '0'.code..'9'.code || c == '_'.code || c == '-'.code }
    }
}

/**
 * The identity of whoever did something, a person or a software agent alike: a DID (`did:web:<domain>:users:<subject>`, `did:web:<domain>:agents:<subject>`), with no whitespace in it. Never a name, an address, or a row in a table. What follows `did:` is not constrained further: a subject is the issuer's, percent-encoded, and that encoding leaves some punctuation as it is.
 */
@Serializable(with = UserId.Serializer::class)
@JvmExposeBoxed
@JvmInline
public value class UserId(
    /** The id as text. */
    public val value: String,
) {
    init {
        if (!admits(value)) throw InvalidIdentifier("UserId", PATTERN, value)
    }

    override fun toString(): String = value

    /** The id as a JSON string; text its rule refuses fails as a decoder's failures do. */
    internal object Serializer : KSerializer<UserId> {
        override val descriptor: SerialDescriptor = PrimitiveSerialDescriptor("xynolog.identifiers.UserId", PrimitiveKind.STRING)

        override fun serialize(encoder: Encoder, value: UserId) {
            encoder.encodeString(value.value)
        }

        override fun deserialize(decoder: Decoder): UserId =
            try {
                UserId(decoder.decodeInline(descriptor).decodeString())
            } catch (refused: InvalidIdentifier) {
                throw SerializationException(refused.message, refused)
            }
    }

    public companion object {
        /** The rule a value is held to, as the spec writes it. */
        public const val PATTERN: String = "^did:\\S+\$"

        /** `value` as a `UserId`, or null when it is not one. */
        @JvmStatic
        @JvmExposeBoxed
        public fun parse(value: String): UserId? = if (admits(value)) UserId(value) else null

        private fun admits(value: String): Boolean {
            if (!value.startsWith("did:")) return false
            val rest = value.substring(4)
            return rest.codePointCount(0, rest.length) >= 1 && rest.codePoints().allMatch { c -> !isWhitespace(c) }
        }
    }
}
