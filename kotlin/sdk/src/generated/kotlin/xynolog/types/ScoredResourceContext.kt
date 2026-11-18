// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonObject

/** JSON-LD context; URI, object, or array of these. */
@Serializable(with = ScoredResourceContextSerializer::class)
public sealed interface ScoredResourceContext {
    /** A member that is a `String`, as the value itself. */
    @Serializable(with = Text.Serializer::class)
    public data class Text(public val value: String) : ScoredResourceContext {
        internal object Serializer : WrapperSerializer<Text, String>(Text::class, kotlinx.serialization.serializer(), { Text(it) }, Text::value)
    }

    /** A member that is a `JsonObject`, as the value itself. */
    @Serializable(with = Object.Serializer::class)
    public data class Object(public val value: JsonObject) : ScoredResourceContext {
        internal object Serializer : WrapperSerializer<Object, JsonObject>(Object::class, kotlinx.serialization.serializer(), { Object(it) }, Object::value)
    }

    /** A member that is a `List<ScoredResourceContextItem>`, as the value itself. */
    @Serializable(with = List.Serializer::class)
    public data class List(public val value: kotlin.collections.List<ScoredResourceContextItem>) : ScoredResourceContext {
        internal object Serializer : WrapperSerializer<List, kotlin.collections.List<ScoredResourceContextItem>>(List::class, kotlinx.serialization.serializer(), { List(it) }, List::value)
    }
}

internal object ScoredResourceContextSerializer : KindsUnionSerializer<ScoredResourceContext>(
    ScoredResourceContext::class,
    strings = { listOf(ScoredResourceContext.Text.serializer()) },
    arrays = { listOf(ScoredResourceContext.List.serializer()) },
    objects = { listOf(ScoredResourceContext.Object.serializer()) },
)
