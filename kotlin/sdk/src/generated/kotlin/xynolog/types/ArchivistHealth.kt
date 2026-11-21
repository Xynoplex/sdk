// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** The Archivist's liveness answer: it serves, and the actors it hosts. */
@Serializable
@JsonIgnoreUnknownKeys
public data class ArchivistHealth(
    @EncodeDefault
    public val status: ArchivistHealthStatus = ArchivistHealthStatus.Ok,
    /** The record actors this process hosts: each of the enum's, once, in the order the enum lists them. */
    public val actors: kotlin.collections.List<ArchivistHealthActorsItem>,
) {
    /** How Java makes a `ArchivistHealth`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val actors: kotlin.collections.List<ArchivistHealthActorsItem>,
    ) {
        public fun build(): ArchivistHealth = ArchivistHealth(actors = actors)
    }

    public companion object {
        /** A builder of a `ArchivistHealth` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(actors: kotlin.collections.List<ArchivistHealthActorsItem>): Builder = Builder(actors)
    }
}
