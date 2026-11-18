@file:OptIn(ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.ExperimentalSerializationApi
import kotlinx.serialization.KSerializer
import kotlinx.serialization.Serializable
import kotlinx.serialization.SerializationException
import kotlinx.serialization.descriptors.SerialDescriptor
import kotlinx.serialization.descriptors.nullable
import kotlinx.serialization.encoding.Decoder
import kotlinx.serialization.encoding.Encoder

/**
 * A property the spec says may be left out and may be null: absent, null or
 * a value, three things. An absent one is left out when it is written.
 */
@Serializable(with = Stated.Serializer::class)
public sealed interface Stated<out T> {
    /** Left out. */
    public data object Absent : Stated<Nothing>

    /** Stated as null. */
    public data object Null : Stated<Nothing>

    /** Stated as a value. */
    public data class Value<out T>(public val value: T) : Stated<T>

    /** Absent is no value, and is never written: what writes it leaves defaults out, as the SDK does. */
    public class Serializer<T>(private val value: KSerializer<T>) : KSerializer<Stated<T>> {
        override val descriptor: SerialDescriptor = value.descriptor.nullable

        override fun serialize(encoder: Encoder, value: Stated<T>) {
            when (value) {
                Absent -> throw SerializationException("an absent property is left out: write it with encodeDefaults = false")
                Null -> encoder.encodeNull()
                is Value -> encoder.encodeSerializableValue(this.value, value.value)
            }
        }

        override fun deserialize(decoder: Decoder): Stated<T> =
            if (decoder.decodeNotNullMark()) Value(decoder.decodeSerializableValue(value)) else Null.also { decoder.decodeNull() }
    }
}
