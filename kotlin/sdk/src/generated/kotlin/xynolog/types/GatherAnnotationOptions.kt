// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** Optional configuration for an annotation-focus gather, which windows text around a mark. Distinct from the resource-focus options (depth / maxResources / includeContent / includeSummary), which traverse the resource graph. */
@Serializable
@JsonIgnoreUnknownKeys
public data class GatherAnnotationOptions(
    /** Whether to include source context in the gathered result */
    public val includeSourceContext: Boolean? = null,
    /** Whether to include target context in the gathered result */
    public val includeTargetContext: Boolean? = null,
    /** How much of the text on each side of the annotation to include, counted in Unicode code points */
    public val contextWindow: Long? = null,
) {
    /** How Java makes a `GatherAnnotationOptions`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor() {
        private var includeSourceContext: Boolean? = null
        private var includeTargetContext: Boolean? = null
        private var contextWindow: Long? = null

        public fun includeSourceContext(includeSourceContext: Boolean?): Builder = apply { this.includeSourceContext = includeSourceContext }
        public fun includeTargetContext(includeTargetContext: Boolean?): Builder = apply { this.includeTargetContext = includeTargetContext }
        public fun contextWindow(contextWindow: Long?): Builder = apply { this.contextWindow = contextWindow }

        public fun build(): GatherAnnotationOptions = GatherAnnotationOptions(includeSourceContext = includeSourceContext, includeTargetContext = includeTargetContext, contextWindow = contextWindow)
    }

    public companion object {
        /** A builder of a `GatherAnnotationOptions` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(): Builder = Builder()
    }
}
