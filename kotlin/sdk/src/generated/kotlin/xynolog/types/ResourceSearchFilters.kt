// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.Serializable

/** What a text search for resources is told beside its text: MatchResourcesRequest's other members. client/surface.json's `match.resources` cases state what is sent for one left out. */
@Serializable
public data class ResourceSearchFilters(
    public val archived: Boolean? = null,
    public val entityType: String? = null,
    /** How many of the resources the search finds are passed over before the page begins. */
    public val offset: Long? = null,
    /** The most resources a page has. */
    public val limit: Long? = null,
) {
    /** How Java makes a `ResourceSearchFilters`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor() {
        private var archived: Boolean? = null
        private var entityType: String? = null
        private var offset: Long? = null
        private var limit: Long? = null

        public fun archived(archived: Boolean?): Builder = apply { this.archived = archived }
        public fun entityType(entityType: String?): Builder = apply { this.entityType = entityType }
        public fun offset(offset: Long?): Builder = apply { this.offset = offset }
        public fun limit(limit: Long?): Builder = apply { this.limit = limit }

        public fun build(): ResourceSearchFilters = ResourceSearchFilters(archived = archived, entityType = entityType, offset = offset, limit = limit)
    }

    public companion object {
        /** A builder of a `ResourceSearchFilters` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(): Builder = Builder()
    }
}
