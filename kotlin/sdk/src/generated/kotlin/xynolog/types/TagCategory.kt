// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** A single category within a tag schema (e.g. 'Issue' in IRAC, 'distinguished' in legal-citation-treatment). Each category carries methodology-bound semantics: a name, a description, and examples used in the LLM prompt. */
@Serializable
@JsonIgnoreUnknownKeys
public data class TagCategory(
    public val name: String,
    public val description: String,
    public val examples: kotlin.collections.List<String>,
) {
    /** How Java makes a `TagCategory`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val name: String,
        private val description: String,
        private val examples: kotlin.collections.List<String>,
    ) {
        public fun build(): TagCategory = TagCategory(name = name, description = description, examples = examples)
    }

    public companion object {
        /** A builder of a `TagCategory` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(name: String, description: String, examples: kotlin.collections.List<String>): Builder = Builder(name, description, examples)
    }
}
