package xynolog.cache

import kotlinx.serialization.json.JsonObject

/*
 * The types of a row of the refresh table (protocol/specs/src/client/refresh.json),
 * which CacheRefresh.kt states each trigger's rows in.
 */

/** Which keys a row acts on: `Subject`, the keys the event names; `Held`, every key the client holds. */
internal enum class CacheRefreshReach { Subject, Held }

/** Which of a split channel's two kinds of event a row is for. */
internal enum class CacheRefreshWhen { Enriched, Unenriched }

/** Where in an event (the frame's payload) a `Subject` row finds the resource it names (a ResourceId) and the annotation (an AnnotationId): each a way, the names of the members it is within and its own; null where the row names none. */
internal data class CacheRefreshNames(
    val resource: List<String>?,
    val annotation: List<String>?,
)

/** What one trigger does to the cache: what it asks for again, what it writes with the value the event carries (an Annotation, at the way `carries`), and what it says is gone. */
internal data class CacheRefresh(
    val reach: CacheRefreshReach,
    val names: CacheRefreshNames,
    val carries: List<String>?,
    val refetches: List<CacheQuery>,
    val writes: List<CacheQuery>,
    val removes: List<CacheQuery>,
    val whenIs: CacheRefreshWhen?,
)

/** A trigger that is a channel of the bus, and that channel's reading of a payload on it, which throws `TransportError` for a payload that is not the channel's. */
internal class CacheRefreshChannel(
    val trigger: CacheRefreshTrigger,
    val read: (JsonObject) -> Unit,
)
