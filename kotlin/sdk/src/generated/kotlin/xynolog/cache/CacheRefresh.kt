// Generated from protocol/specs/src/client/refresh.json; do not edit.
// Regenerate: make generate (codegen/lib/cache_refresh/kotlin.ml)

package xynolog.cache

import kotlinx.serialization.serializer
import xynolog.bus.decoded
import xynolog.channels.Channels
import xynolog.identifiers.AnnotationId
import xynolog.identifiers.ResourceId
import xynolog.registry.KeptQuery
import xynolog.registry.WholeKeySerializer
import xynolog.types.TagSchema

/** The live queries a client's cache answers. */
internal enum class CacheQuery(
    /** The query as the table names it. */
    val wire: String,
) {
    /**
     * A resource's description.
     */
    Resource("resource"),

    /**
     * The annotations of a resource.
     */
    Annotations("annotations"),

    /**
     * One annotation.
     */
    Annotation("annotation"),

    /**
     * The recorded history of a resource.
     */
    Events("events"),

    /**
     * The annotations elsewhere that refer to a resource.
     */
    ReferencedBy("referencedBy"),

    /**
     * A list of resources, one per set of filters asked for. It is a query's answer, kept fresh by what every client hears and by the events of the resources whose scope the client holds, and by nothing else: a resource archived, unarchived or retagged elsewhere, by someone else, does not refresh it.
     */
    Resources("resources"),

    /**
     * The resources a text search found, one per search and set of filters asked for. A query's answer like `resources`, and kept fresh by the same events and no others.
     */
    MatchedResources("matchedResources"),

    /**
     * The knowledge base's entity types.
     */
    EntityTypes("entityTypes"),

    /**
     * The knowledge base's tag schemas.
     */
    TagSchemas("tagSchemas"),

    /**
     * The knowledge base's engines, joined with the limits each inference key holder reports: asking again asks every `<flow>:limits-requested` operation of the registry again too.
     */
    Engines("engines"),
}

/** The caches a client keeps the queries it keeps in, each by its query's name, holding for each key what the query's `value` says. */
internal interface KeptCaches {
    /**
     * A resource's description.
     */
    val resource: Cache<ResourceId, xynolog.types.ResourceDescriptor>

    /**
     * The annotations of a resource.
     */
    val annotations: Cache<ResourceId, xynolog.types.GetAnnotationsResponse>

    /**
     * One annotation.
     */
    val annotation: Cache<AnnotationId, xynolog.types.Annotation>

    /**
     * The knowledge base's entity types.
     */
    val entityTypes: Cache<String, kotlin.collections.List<String>>

    /**
     * The knowledge base's tag schemas.
     */
    val tagSchemas: Cache<String, kotlin.collections.List<TagSchema>>
}

/** The queries whose answers a client with a storage keeps, in the table's order: each with what its entries' keys and values are, and its cache. */
internal val PERSISTED_QUERIES: List<KeptQuery<*, *>> = listOf(
    KeptQuery(CacheQuery.Resource, ResourceId.serializer(), serializer<xynolog.types.ResourceDescriptor>(), KeptCaches::resource),
    KeptQuery(CacheQuery.Annotations, ResourceId.serializer(), serializer<xynolog.types.GetAnnotationsResponse>(), KeptCaches::annotations),
    KeptQuery(CacheQuery.Annotation, AnnotationId.serializer(), serializer<xynolog.types.Annotation>(), KeptCaches::annotation),
    KeptQuery(CacheQuery.EntityTypes, WholeKeySerializer, serializer<kotlin.collections.List<String>>(), KeptCaches::entityTypes),
    KeptQuery(CacheQuery.TagSchemas, WholeKeySerializer, serializer<kotlin.collections.List<TagSchema>>(), KeptCaches::tagSchemas),
)

/** What each trigger is: a channel whose events are it; `reopened`, the stream open again after a drop; or `unreadable`, an event on one of the table's channels that cannot be read. */
internal enum class CacheRefreshTrigger(
    /** The trigger as the table names it. */
    val wire: String,
) {
    Reopened("reopened"),
    Unreadable("unreadable"),
    BusResumeGap("bus:resume-gap"),
    MarkAdded("mark:added"),
    MarkRemoved("mark:removed"),
    MarkDeleteOk("mark:delete-ok"),
    MarkBodyUpdated("mark:body-updated"),
    MarkEntityTagAdded("mark:entity-tag-added"),
    MarkEntityTagRemoved("mark:entity-tag-removed"),
    MarkArchived("mark:archived"),
    MarkUnarchived("mark:unarchived"),
    YieldCreated("yield:created"),
    YieldUpdated("yield:updated"),
    YieldCloned("yield:cloned"),
    YieldMoved("yield:moved"),
    FrameEntityTypeAdded("frame:entity-type-added"),
    FrameTagSchemaAdded("frame:tag-schema-added"),
}

/** Each trigger's rows: one, or one for each kind of event of a split channel. */
internal val CACHE_REFRESH: Map<CacheRefreshTrigger, List<CacheRefresh>> = mapOf(
    CacheRefreshTrigger.Reopened to listOf(
        CacheRefresh(CacheRefreshReach.Held, CacheRefreshNames(null, null), null, listOf(CacheQuery.Resources, CacheQuery.MatchedResources, CacheQuery.Resource, CacheQuery.EntityTypes, CacheQuery.TagSchemas, CacheQuery.Engines), listOf(), listOf(), null),
    ),
    CacheRefreshTrigger.Unreadable to listOf(
        CacheRefresh(CacheRefreshReach.Held, CacheRefreshNames(null, null), null, listOf(CacheQuery.Resource, CacheQuery.Annotations, CacheQuery.Annotation, CacheQuery.Events, CacheQuery.ReferencedBy, CacheQuery.Resources, CacheQuery.MatchedResources, CacheQuery.EntityTypes, CacheQuery.TagSchemas, CacheQuery.Engines), listOf(), listOf(), null),
    ),
    CacheRefreshTrigger.BusResumeGap to listOf(
        CacheRefresh(CacheRefreshReach.Subject, CacheRefreshNames(listOf("scope"), null), null, listOf(CacheQuery.Annotations, CacheQuery.Annotation, CacheQuery.Resource, CacheQuery.Events, CacheQuery.ReferencedBy), listOf(), listOf(), null),
    ),
    CacheRefreshTrigger.MarkAdded to listOf(
        CacheRefresh(CacheRefreshReach.Subject, CacheRefreshNames(listOf("resourceId"), null), null, listOf(CacheQuery.Annotations, CacheQuery.Events), listOf(), listOf(), null),
    ),
    CacheRefreshTrigger.MarkRemoved to listOf(
        CacheRefresh(CacheRefreshReach.Subject, CacheRefreshNames(listOf("resourceId"), listOf("payload", "annotationId")), null, listOf(CacheQuery.Annotations, CacheQuery.Events), listOf(), listOf(CacheQuery.Annotation), null),
    ),
    CacheRefreshTrigger.MarkDeleteOk to listOf(
        CacheRefresh(CacheRefreshReach.Subject, CacheRefreshNames(null, listOf("response", "annotationId")), null, listOf(), listOf(), listOf(CacheQuery.Annotation), null),
    ),
    CacheRefreshTrigger.MarkBodyUpdated to listOf(
        CacheRefresh(CacheRefreshReach.Subject, CacheRefreshNames(listOf("resourceId"), listOf("annotation", "id")), listOf("annotation"), listOf(CacheQuery.Events), listOf(CacheQuery.Annotations, CacheQuery.Annotation), listOf(), CacheRefreshWhen.Enriched),
        CacheRefresh(CacheRefreshReach.Subject, CacheRefreshNames(listOf("resourceId"), listOf("payload", "annotationId")), null, listOf(CacheQuery.Annotations, CacheQuery.Annotation, CacheQuery.Events), listOf(), listOf(), CacheRefreshWhen.Unenriched),
    ),
    CacheRefreshTrigger.MarkEntityTagAdded to listOf(
        CacheRefresh(CacheRefreshReach.Subject, CacheRefreshNames(listOf("resourceId"), null), null, listOf(CacheQuery.Annotations, CacheQuery.Resource, CacheQuery.Events), listOf(), listOf(), null),
    ),
    CacheRefreshTrigger.MarkEntityTagRemoved to listOf(
        CacheRefresh(CacheRefreshReach.Subject, CacheRefreshNames(listOf("resourceId"), null), null, listOf(CacheQuery.Annotations, CacheQuery.Resource, CacheQuery.Events), listOf(), listOf(), null),
    ),
    CacheRefreshTrigger.MarkArchived to listOf(
        CacheRefresh(CacheRefreshReach.Subject, CacheRefreshNames(listOf("resourceId"), null), null, listOf(CacheQuery.Resource, CacheQuery.Resources, CacheQuery.MatchedResources), listOf(), listOf(), null),
    ),
    CacheRefreshTrigger.MarkUnarchived to listOf(
        CacheRefresh(CacheRefreshReach.Subject, CacheRefreshNames(listOf("resourceId"), null), null, listOf(CacheQuery.Resource, CacheQuery.Resources, CacheQuery.MatchedResources), listOf(), listOf(), null),
    ),
    CacheRefreshTrigger.YieldCreated to listOf(
        CacheRefresh(CacheRefreshReach.Subject, CacheRefreshNames(listOf("resourceId"), null), null, listOf(CacheQuery.Resource, CacheQuery.Resources, CacheQuery.MatchedResources), listOf(), listOf(), null),
    ),
    CacheRefreshTrigger.YieldUpdated to listOf(
        CacheRefresh(CacheRefreshReach.Subject, CacheRefreshNames(listOf("resourceId"), null), null, listOf(CacheQuery.Resource, CacheQuery.Resources, CacheQuery.MatchedResources), listOf(), listOf(), null),
    ),
    CacheRefreshTrigger.YieldCloned to listOf(
        CacheRefresh(CacheRefreshReach.Subject, CacheRefreshNames(listOf("resourceId"), null), null, listOf(CacheQuery.Resource, CacheQuery.Resources, CacheQuery.MatchedResources), listOf(), listOf(), null),
    ),
    CacheRefreshTrigger.YieldMoved to listOf(
        CacheRefresh(CacheRefreshReach.Subject, CacheRefreshNames(listOf("resourceId"), null), null, listOf(CacheQuery.Resource, CacheQuery.Resources, CacheQuery.MatchedResources), listOf(), listOf(), null),
    ),
    CacheRefreshTrigger.FrameEntityTypeAdded to listOf(
        CacheRefresh(CacheRefreshReach.Subject, CacheRefreshNames(null, null), null, listOf(CacheQuery.EntityTypes), listOf(), listOf(), null),
    ),
    CacheRefreshTrigger.FrameTagSchemaAdded to listOf(
        CacheRefresh(CacheRefreshReach.Subject, CacheRefreshNames(null, null), null, listOf(CacheQuery.TagSchemas), listOf(), listOf(), null),
    ),
)

/** The triggers that are channels of the bus, by the channel's name, in the table's order. */
internal val CACHE_REFRESH_CHANNELS: Map<String, CacheRefreshChannel> = mapOf(
    "bus:resume-gap" to CacheRefreshChannel(CacheRefreshTrigger.BusResumeGap) { decoded(Channels.BUS_RESUME_GAP, it) },
    "mark:added" to CacheRefreshChannel(CacheRefreshTrigger.MarkAdded) { decoded(Channels.MARK_ADDED, it) },
    "mark:removed" to CacheRefreshChannel(CacheRefreshTrigger.MarkRemoved) { decoded(Channels.MARK_REMOVED, it) },
    "mark:delete-ok" to CacheRefreshChannel(CacheRefreshTrigger.MarkDeleteOk) { decoded(Channels.MARK_DELETE_OK, it) },
    "mark:body-updated" to CacheRefreshChannel(CacheRefreshTrigger.MarkBodyUpdated) { decoded(Channels.MARK_BODY_UPDATED, it) },
    "mark:entity-tag-added" to CacheRefreshChannel(CacheRefreshTrigger.MarkEntityTagAdded) { decoded(Channels.MARK_ENTITY_TAG_ADDED, it) },
    "mark:entity-tag-removed" to CacheRefreshChannel(CacheRefreshTrigger.MarkEntityTagRemoved) { decoded(Channels.MARK_ENTITY_TAG_REMOVED, it) },
    "mark:archived" to CacheRefreshChannel(CacheRefreshTrigger.MarkArchived) { decoded(Channels.MARK_ARCHIVED, it) },
    "mark:unarchived" to CacheRefreshChannel(CacheRefreshTrigger.MarkUnarchived) { decoded(Channels.MARK_UNARCHIVED, it) },
    "yield:created" to CacheRefreshChannel(CacheRefreshTrigger.YieldCreated) { decoded(Channels.YIELD_CREATED, it) },
    "yield:updated" to CacheRefreshChannel(CacheRefreshTrigger.YieldUpdated) { decoded(Channels.YIELD_UPDATED, it) },
    "yield:cloned" to CacheRefreshChannel(CacheRefreshTrigger.YieldCloned) { decoded(Channels.YIELD_CLONED, it) },
    "yield:moved" to CacheRefreshChannel(CacheRefreshTrigger.YieldMoved) { decoded(Channels.YIELD_MOVED, it) },
    "frame:entity-type-added" to CacheRefreshChannel(CacheRefreshTrigger.FrameEntityTypeAdded) { decoded(Channels.FRAME_ENTITY_TYPE_ADDED, it) },
    "frame:tag-schema-added" to CacheRefreshChannel(CacheRefreshTrigger.FrameTagSchemaAdded) { decoded(Channels.FRAME_TAG_SCHEMA_ADDED, it) },
)
