@file:OptIn(kotlin.ExperimentalStdlibApi::class)

package xynolog.namespaces

import xynolog.Running
import xynolog.bus.Operations
import xynolog.cache.Cached
import xynolog.cache.Keyed
import xynolog.identifiers.AnnotationId
import xynolog.identifiers.ResourceId
import xynolog.types.GatheredContext
import xynolog.types.MatchResourcesResponse
import xynolog.types.MatchSearchRequest
import xynolog.types.MatchSearchResult

/** How many candidates a search for a reference gives when none is stated. */
internal const val SEARCH_LIMIT: Long = 10

/** Whether a search for a reference scores its candidates semantically when that is not stated. */
internal const val SEMANTIC_SCORING: Boolean = true

/** Searching: for what a reference could refer to, and for resources by text. */
public class MatchNamespace internal constructor(private val links: Links, private val live: Live) {
    /** Candidates for a reference, given its gathered context: ten, scored semantically, when nothing else is stated. */
    @JvmOverloads
    @JvmExposeBoxed
    public fun search(
        resourceId: ResourceId,
        referenceId: AnnotationId,
        context: GatheredContext,
        limit: Long = SEARCH_LIMIT,
        useSemanticScoring: Boolean = SEMANTIC_SCORING,
    ): Running<MatchSearchResult> {
        val request = MatchSearchRequest(resourceId = resourceId, referenceId = referenceId, context = context, limit = limit, useSemanticScoring = useSemanticScoring)
        return Running(links.scope) { links.request(Operations.MATCH_SEARCH_REQUESTED, request) }
    }

    /** Signal: a search is wanted. The client's own state runs it, and answers under `correlationId`. */
    public fun requestSearch(request: MatchSearchRequest, correlationId: String): Unit =
        links.signal(Operations.MATCH_SEARCH_REQUESTED.request, request, correlationId)

    /**
     * The resources a text search finds, among those the filters admit: the
     * first hundred when nothing is stated, `offset` of them passed over
     * before the page begins. A live query, kept true by the same events as
     * `browse.resources` and no others.
     */
    @JvmOverloads
    public fun resources(
        search: String,
        limit: Long = LIST_LIMIT,
        offset: Long = 0,
        archived: Boolean? = null,
        entityType: String? = null,
    ): Cached<MatchResourcesResponse> = live.query(Keyed(live.matchedResources, ResourceSearch(search, ResourceFilters(limit, offset, archived, entityType)), { it }))
}
