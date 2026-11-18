// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonObject

@Serializable(with = ScoredResourceContextItemSerializer::class)
public sealed interface ScoredResourceContextItem {
    /** A member that is a `String`, as the value itself. */
    @Serializable(with = Text.Serializer::class)
    public data class Text(public val value: String) : ScoredResourceContextItem {
        internal object Serializer : WrapperSerializer<Text, String>(Text::class, kotlinx.serialization.serializer(), { Text(it) }, Text::value)
    }

    /** A member that is a `JsonObject`, as the value itself. */
    @Serializable(with = Object.Serializer::class)
    public data class Object(public val value: JsonObject) : ScoredResourceContextItem {
        internal object Serializer : WrapperSerializer<Object, JsonObject>(Object::class, kotlinx.serialization.serializer(), { Object(it) }, Object::value)
    }
}

internal object ScoredResourceContextItemSerializer : KindsUnionSerializer<ScoredResourceContextItem>(
    ScoredResourceContextItem::class,
    strings = { listOf(ScoredResourceContextItem.Text.serializer()) },
    arrays = { emptyList() },
    objects = { listOf(ScoredResourceContextItem.Object.serializer()) },
)
