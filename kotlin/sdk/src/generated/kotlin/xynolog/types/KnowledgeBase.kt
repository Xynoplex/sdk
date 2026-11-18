// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** A registered knowledge base: a target, and what registering it took, the identity the knowledge base reported of itself when it was reached (`did`) among it. What a client's list of knowledge bases holds. A did says which knowledge base, not which running copy: a clone and a codespace of one repository are one knowledge base at two addresses and report one did. So an entry is looked up by its endpoint, and its did is what an answer is verified against; nothing selects by did. Its `label` and `lastRead` are written only from an answer that carried its did. */
@Serializable
@JsonIgnoreUnknownKeys
public data class KnowledgeBase(
    /** The key the client stores a session's credentials under. Two sessions that share one storage have two ids, or each overwrites the other's tokens. Whoever builds the target chooses it; none is made up. */
    public val id: String,
    /** What a person reads the knowledge base as. Once the knowledge base has described itself, its own name. */
    public val label: String,
    public val endpoint: KbEndpoint,
    /** The did the knowledge base reported of itself. */
    public val did: String,
    /** The last time the knowledge base described itself. Absent until it has, in an answer that carried this entry's did. */
    public val lastRead: KbRead? = null,
) {
    /** How Java makes a `KnowledgeBase`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val id: String,
        private val label: String,
        private val endpoint: KbEndpoint,
        private val did: String,
    ) {
        private var lastRead: KbRead? = null

        public fun lastRead(lastRead: KbRead?): Builder = apply { this.lastRead = lastRead }

        public fun build(): KnowledgeBase = KnowledgeBase(id = id, label = label, endpoint = endpoint, did = did, lastRead = lastRead)
    }

    public companion object {
        /** A builder of a `KnowledgeBase` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(id: String, label: String, endpoint: KbEndpoint, did: String): Builder = Builder(id, label, endpoint, did)
    }
}
