// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import xynolog.identifiers.AnnotationId

@Serializable
@JsonIgnoreUnknownKeys
public data class Annotation(
    /** W3C Web Annotation JSON-LD context */
    @SerialName("@context")
    @EncodeDefault
    public val context: AnnotationContext = AnnotationContext.HttpWwwW3OrgNsAnnoJsonld,
    /** W3C Annotation type */
    @EncodeDefault
    public val type: AnnotationType = AnnotationType.Annotation,
    @get:JvmExposeBoxed
    public val id: AnnotationId,
    public val motivation: Motivation,
    /** W3C Web Annotation target: the id of the resource annotated, when the whole of it is, or an object with source and optional selector (fragment) */
    public val target: AnnotationTargetValue,
    /** W3C Web Annotation body. Optional per the W3C spec — annotations whose motivation alone is meaningful (highlighting) legitimately omit it. Present values are either a single body or a non-empty array of bodies; there is no empty array. */
    public val body: AnnotationBodies? = null,
    /** Web Annotation creator — who requested the annotation. DERIVED by the knowledge base at write time, never accepted from an emitter (a payload carrying it is refused): the verified emitter of the write, or, when the write cites a job, the verified emitter of the job:create that produced it. A Person for human-requested work; a Software peer for autonomous-agent work. */
    public val creator: Agent? = null,
    /** When the annotation was MADE — the authoring moment, carried from the event that created it. Not when a projection happened to write it: a store that rebuilds from the log must preserve this value, never restamp it. */
    public val created: String,
    public val modified: String? = null,
    /** Web Annotation generator — the Software peer that produced the annotation, when software did. Absent for a person's own annotation. An emitter may supply it to carry the model's parameters, but its identity must be the emitter's own: the knowledge base refuses a generator naming anyone else, and supplies it from the verified emitter when omitted. One producer per write — a write carrying the array form is refused. */
    public val generator: OneOrMoreAgents? = null,
    /** PROV-O wasAttributedTo — every party responsible for this annotation, DERIVED by the knowledge base from `creator` and the verified executor of the write: `[creator, generator]` when one agent requested the work and software produced it; collapsed to the one agent when requester and producer are the same. Never accepted from an emitter. */
    public val wasAttributedTo: OneOrMoreAgents? = null,
) {
    /** How Java makes a `Annotation`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val id: AnnotationId,
        private val motivation: Motivation,
        private val target: AnnotationTargetValue,
        private val created: String,
    ) {
        private var body: AnnotationBodies? = null
        private var creator: Agent? = null
        private var modified: String? = null
        private var generator: OneOrMoreAgents? = null
        private var wasAttributedTo: OneOrMoreAgents? = null

        public fun body(body: AnnotationBodies?): Builder = apply { this.body = body }
        public fun creator(creator: Agent?): Builder = apply { this.creator = creator }
        public fun modified(modified: String?): Builder = apply { this.modified = modified }
        public fun generator(generator: OneOrMoreAgents?): Builder = apply { this.generator = generator }
        public fun wasAttributedTo(wasAttributedTo: OneOrMoreAgents?): Builder = apply { this.wasAttributedTo = wasAttributedTo }

        public fun build(): Annotation = Annotation(id = id, motivation = motivation, target = target, body = body, creator = creator, created = created, modified = modified, generator = generator, wasAttributedTo = wasAttributedTo)
    }

    public companion object {
        /** A builder of a `Annotation` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(id: AnnotationId, motivation: Motivation, target: AnnotationTargetValue, created: String): Builder = Builder(id, motivation, target, created)
    }
}
