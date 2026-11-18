// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** Whole-resource focus. */
@Serializable
@JsonIgnoreUnknownKeys
public data class GatheredContextFocusResource(
    @EncodeDefault
    public val kind: GatheredContextFocusResourceKind = GatheredContextFocusResourceKind.Resource,
    /** The resource this context was gathered for */
    public val resource: ResourceDescriptor,
    public val summary: String? = null,
    public val suggestedReferences: kotlin.collections.List<String>? = null,
    /** Resource content (included when requested) */
    public val content: GatheredContextFocusResourceContent? = null,
) : GatheredContextFocus {
    /** How Java makes a `GatheredContextFocusResource`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val resource: ResourceDescriptor,
    ) {
        private var summary: String? = null
        private var suggestedReferences: kotlin.collections.List<String>? = null
        private var content: GatheredContextFocusResourceContent? = null

        public fun summary(summary: String?): Builder = apply { this.summary = summary }
        public fun suggestedReferences(suggestedReferences: kotlin.collections.List<String>?): Builder = apply { this.suggestedReferences = suggestedReferences }
        public fun content(content: GatheredContextFocusResourceContent?): Builder = apply { this.content = content }

        public fun build(): GatheredContextFocusResource = GatheredContextFocusResource(resource = resource, summary = summary, suggestedReferences = suggestedReferences, content = content)
    }

    public companion object {
        /** A builder of a `GatheredContextFocusResource` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(resource: ResourceDescriptor): Builder = Builder(resource)
    }
}
