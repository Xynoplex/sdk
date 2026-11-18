// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** What a knowledge base says about itself, answered by the Archivist from the committed .xynolog/config.yaml and the working tree it holds. The only source clients use for a knowledge base's name and domain. */
@Serializable
@JsonIgnoreUnknownKeys
public data class KbDescription(
    /** The committed project.name, or the knowledge base directory's name when it commits no .xynolog/config.yaml. */
    public val name: String,
    /** The committed site.domain: the knowledge base's permanent identity. Its did is 'did:web:' + this domain (kbDid in @xynolog/core). It names WHICH knowledge base this is, not which running copy: a local clone and a codespace of one repo report the same domain, so use it to verify what you connected to, never to select among copies. A knowledge base that commits no .xynolog/config.yaml declares none, and is refused with browse:kb-failed. */
    public val domain: String,
    /** The working tree's current git branch. Absent when the knowledge base does not sync git (`git.sync` in its committed .xynolog/config.yaml), and when its tree is not a git checkout. */
    public val gitBranch: String? = null,
) {
    /** How Java makes a `KbDescription`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val name: String,
        private val domain: String,
    ) {
        private var gitBranch: String? = null

        public fun gitBranch(gitBranch: String?): Builder = apply { this.gitBranch = gitBranch }

        public fun build(): KbDescription = KbDescription(name = name, domain = domain, gitBranch = gitBranch)
    }

    public companion object {
        /** A builder of a `KbDescription` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(name: String, domain: String): Builder = Builder(name, domain)
    }
}
