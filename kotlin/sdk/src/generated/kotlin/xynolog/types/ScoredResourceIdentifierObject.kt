// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.KeepGeneratedSerializer
import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable
import kotlinx.serialization.Transient
import kotlinx.serialization.json.JsonObject

@Serializable(with = ScoredResourceIdentifierObject.Serializer::class)
@KeepGeneratedSerializer
public data class ScoredResourceIdentifierObject(
    @SerialName("@id")
    public val id: String? = null,
    public val value: String? = null,
    public val scheme: String? = null,
    /** Every property the schema does not name, as it came. */
    @Transient
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

    internal object Serializer : OpenObjectSerializer<ScoredResourceIdentifierObject>(
        ScoredResourceIdentifierObject.generatedSerializer(),
        ScoredResourceIdentifierObject::rest,
        { named, rest -> named.copy(rest = rest) },
    )
}
