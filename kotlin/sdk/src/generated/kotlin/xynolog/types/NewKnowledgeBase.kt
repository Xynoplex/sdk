// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** What registering a knowledge base takes: everything a registered one holds but its id, which the client's list makes. It has a did, because registering follows a sign-in: the knowledge base has already said what it is. */
@Serializable
@JsonIgnoreUnknownKeys
public data class NewKnowledgeBase(
    /** What a person reads the knowledge base as. Once the knowledge base has described itself, its own name. */
    public val label: String,
    public val endpoint: KbEndpoint,
    /** The did the knowledge base reported of itself. */
    public val did: String,
    /** The last time the knowledge base described itself. Absent until it has, in an answer that carried this entry's did. */
    public val lastRead: KbRead? = null,
) {
    /** How Java makes a `NewKnowledgeBase`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val label: String,
        private val endpoint: KbEndpoint,
        private val did: String,
    ) {
        private var lastRead: KbRead? = null

        public fun lastRead(lastRead: KbRead?): Builder = apply { this.lastRead = lastRead }

        public fun build(): NewKnowledgeBase = NewKnowledgeBase(label = label, endpoint = endpoint, did = did, lastRead = lastRead)
    }

    public companion object {
        /** A builder of a `NewKnowledgeBase` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(label: String, endpoint: KbEndpoint, did: String): Builder = Builder(label, endpoint, did)
    }
}
