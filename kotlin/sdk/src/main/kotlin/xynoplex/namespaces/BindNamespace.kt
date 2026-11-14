@file:OptIn(kotlin.ExperimentalStdlibApi::class)

package xynoplex.namespaces

import xynoplex.bus.Operations
import xynoplex.channels.Channels
import xynoplex.identifiers.AnnotationId
import xynoplex.identifiers.ResourceId
import xynoplex.types.BindBodyOperation
import xynoplex.types.BindInitiateCommand
import xynoplex.types.BindUpdateBodyCommand
import xynoplex.types.ResourceErrorEvent
import java.util.concurrent.CompletableFuture

/** Linking a reference to what it refers to. */
public class BindNamespace internal constructor(private val links: Links) {
    /** Change an annotation's body: it resolves when the change is recorded, and fails with the failure the knowledge base answered. */
    public suspend fun body(resourceId: ResourceId, annotationId: AnnotationId, operations: List<BindBodyOperation>) {
        links.request(Operations.BIND_UPDATE_BODY, BindUpdateBodyCommand(annotationId = annotationId, resourceId = resourceId, operations = operations))
    }

    /** `body`, for Java. */
    @JvmExposeBoxed
    public fun bodyFuture(resourceId: ResourceId, annotationId: AnnotationId, operations: List<BindBodyOperation>): CompletableFuture<Unit> =
        links.future { body(resourceId, annotationId, operations) }

    /** Signal: a binding is begun in this viewer. */
    public fun initiate(command: BindInitiateCommand): Unit = links.signal(Channels.BIND_INITIATE, command)

    /** Signal: a body change failed, for this viewer to say. */
    public fun reportBodyError(event: ResourceErrorEvent): Unit = links.signal(Channels.BIND_BODY_ERROR, event)
}
