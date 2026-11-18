// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** Success reply after cloning a resource, matched to the originating command by correlationId. */
@Serializable
@JsonIgnoreUnknownKeys
public data class YieldClonePersistOk(
    /** The clone's identity — a new resource, distinct from its parent. */
    public val response: YieldedResource,
) {
    /** How Java makes a `YieldClonePersistOk`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val response: YieldedResource,
    ) {
        public fun build(): YieldClonePersistOk = YieldClonePersistOk(response = response)
    }

    public companion object {
        /** A builder of a `YieldClonePersistOk` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(response: YieldedResource): Builder = Builder(response)
    }
}
