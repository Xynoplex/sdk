@file:OptIn(kotlin.ExperimentalStdlibApi::class)

package xynolog.registry

import kotlinx.serialization.Serializable
import xynolog.identifiers.ResourceId
import xynolog.types.TabCheck
import xynolog.types.TabCheckGone
import xynolog.types.TabCheckReady
import xynolog.types.TabCheckUnknown

/** One resource open in a knowledge base: a tab, where there are tabs. */
@Serializable
public data class OpenResource @JvmExposeBoxed constructor(
    @get:JvmExposeBoxed
    public val id: ResourceId,
    public val name: String,
    /** When it was opened, in milliseconds since the epoch. */
    public val openedAt: Long,
    /** Its place among the others. */
    public val order: Int,
    public val mediaType: String? = null,
    /** Where it is in the working tree, such as `file://docs/overview.md`; null when that is not known. */
    public val storageUri: String? = null,
)

/**
 * Apply each verdict to what is open: what is gone is dropped, what was found
 * takes its name and media type, and everything else is left as it was. One
 * with no verdict is left: it was opened while the checks were in flight.
 */
public fun applyTabChecks(opened: List<OpenResource>, checks: Map<ResourceId, TabCheck>): List<OpenResource> = opened.mapNotNull { tab ->
    when (val check = checks[tab.id]) {
        is TabCheckGone -> null
        is TabCheckReady -> tab.copy(name = check.name, mediaType = check.mediaType ?: tab.mediaType)
        is TabCheckUnknown, null -> tab
    }
}

/** `resources` by the place each has, and among those given the same place, by when each was opened. */
public fun sortOpenResources(resources: List<OpenResource>): List<OpenResource> = resources.sortedWith(compareBy({ it.order }, { it.openedAt }))
