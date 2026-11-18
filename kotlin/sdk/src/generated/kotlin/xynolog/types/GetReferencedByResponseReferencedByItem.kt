// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import xynolog.identifiers.AnnotationId

@Serializable
@JsonIgnoreUnknownKeys
public data class GetReferencedByResponseReferencedByItem(
    /** Reference annotation ID */
    @get:JvmExposeBoxed
    public val id: AnnotationId,
    /** Name of the resource containing the reference. Absent where no description of that resource is held, and where its name is empty. */
    public val resourceName: String? = null,
    public val target: GetReferencedByResponseReferencedByItemTarget,
) {
    /** How Java makes a `GetReferencedByResponseReferencedByItem`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val id: AnnotationId,
        private val target: GetReferencedByResponseReferencedByItemTarget,
    ) {
        private var resourceName: String? = null

        public fun resourceName(resourceName: String?): Builder = apply { this.resourceName = resourceName }

        public fun build(): GetReferencedByResponseReferencedByItem = GetReferencedByResponseReferencedByItem(id = id, resourceName = resourceName, target = target)
    }

    public companion object {
        /** A builder of a `GetReferencedByResponseReferencedByItem` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(id: AnnotationId, target: GetReferencedByResponseReferencedByItemTarget): Builder = Builder(id, target)
    }
}
