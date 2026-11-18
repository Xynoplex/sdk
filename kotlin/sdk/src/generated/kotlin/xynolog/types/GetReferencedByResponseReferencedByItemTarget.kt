// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import xynolog.identifiers.ResourceId

@Serializable
@JsonIgnoreUnknownKeys
public data class GetReferencedByResponseReferencedByItemTarget(
    /** ID of resource containing the reference */
    @get:JvmExposeBoxed
    public val source: ResourceId,
    public val selector: GetReferencedByResponseReferencedByItemTargetSelector,
) {
    /** How Java makes a `GetReferencedByResponseReferencedByItemTarget`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val source: ResourceId,
        private val selector: GetReferencedByResponseReferencedByItemTargetSelector,
    ) {
        public fun build(): GetReferencedByResponseReferencedByItemTarget = GetReferencedByResponseReferencedByItemTarget(source = source, selector = selector)
    }

    public companion object {
        /** A builder of a `GetReferencedByResponseReferencedByItemTarget` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(source: ResourceId, selector: GetReferencedByResponseReferencedByItemTargetSelector): Builder = Builder(source, selector)
    }
}
