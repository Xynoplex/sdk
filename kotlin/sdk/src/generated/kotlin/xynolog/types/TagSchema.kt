// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** A structural-analysis schema (e.g. legal-irac, scientific-imrad, argument-toulmin). Defines a methodology framework as an id, name, description, domain hint, and an ordered list of categories. KBs and their skills register schemas with the runtime registry via `frame.addTagSchema(...)` at session start. */
@Serializable
@JsonIgnoreUnknownKeys
public data class TagSchema(
    public val id: String,
    public val name: String,
    public val description: String,
    /** Free-form domain hint (e.g. 'legal', 'scientific', 'general'). Used in the LLM prompt to tune the model's analysis voice. KB authors choose. */
    public val domain: String,
    public val tags: kotlin.collections.List<TagCategory>,
) {
    /** How Java makes a `TagSchema`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val id: String,
        private val name: String,
        private val description: String,
        private val domain: String,
        private val tags: kotlin.collections.List<TagCategory>,
    ) {
        public fun build(): TagSchema = TagSchema(id = id, name = name, description = description, domain = domain, tags = tags)
    }

    public companion object {
        /** A builder of a `TagSchema` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(id: String, name: String, description: String, domain: String, tags: kotlin.collections.List<TagCategory>): Builder = Builder(id, name, description, domain, tags)
    }
}
