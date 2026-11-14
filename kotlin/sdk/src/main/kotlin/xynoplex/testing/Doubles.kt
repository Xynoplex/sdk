@file:OptIn(kotlin.ExperimentalStdlibApi::class)

package xynoplex.testing

import kotlinx.coroutines.CompletableDeferred
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.channels.Channel
import kotlinx.coroutines.flow.consumeAsFlow
import kotlinx.coroutines.flow.flowOf
import xynoplex.errors.TransportError
import xynoplex.errors.TransportErrorCode
import xynoplex.identifiers.ResourceId
import xynoplex.telemetry.futureOf
import xynoplex.transport.Content
import xynoplex.transport.ContentStream
import xynoplex.transport.ContentTransport
import xynoplex.transport.Events
import xynoplex.transport.GatewayOperations
import xynoplex.transport.PutBinaryRequest
import xynoplex.transport.Upload
import xynoplex.transport.UploadProgress
import xynoplex.types.AnchoredTextAnswer
import xynoplex.types.CreateResourceResponse
import xynoplex.types.GetAnnotationsResponse
import xynoplex.types.GetResourceResponse
import xynoplex.types.HealthResponse
import xynoplex.types.MediaTokenResponse
import xynoplex.types.ProtectedResourceMetadata
import xynoplex.types.StatusResponse
import xynoplex.types.UserResponse
import java.util.concurrent.CompletableFuture

/** One call made of `InMemoryContent`. */
public sealed interface ContentCall

/** A call of `putBinary`, with what it was given. */
public data class PutBinary(public val request: PutBinaryRequest) : ContentCall

/** A call of `getBinary`. */
public data class GetBinary(@get:JvmExposeBoxed public val resourceId: ResourceId) : ContentCall

/** A call of `getBinaryStream`. */
public data class GetBinaryStream(@get:JvmExposeBoxed public val resourceId: ResourceId) : ContentCall

/** A call of `getResourceGraph`. */
public data class GetResourceGraph(@get:JvmExposeBoxed public val resourceId: ResourceId) : ContentCall

/** A call of `getAnnotations`. */
public data class GetAnnotations(@get:JvmExposeBoxed public val resourceId: ResourceId) : ContentCall

/** A call of `getAnchoredText`. */
public data class GetAnchoredText(@get:JvmExposeBoxed public val resourceId: ResourceId) : ContentCall

private fun notFound(what: String, resourceId: ResourceId): TransportError =
    TransportError(TransportErrorCode.NotFound, "InMemoryContent: no $what stored for ${resourceId.value}", 404)

/**
 * A `ContentTransport` with no wire, for tests. It keeps what `putBinary`
 * receives and gives it back to a read, and records every call made of it.
 * A read of a resource nobody stored fails as `not-found`, as a gateway's
 * would, so a test that forgot to seed its content fails where it forgot,
 * not on bytes the double made up; a read of an anchored text nobody seeded
 * fails the same way. Nothing it does waits: a future of it runs on the
 * thread that asks.
 */
public class InMemoryContent : ContentTransport {
    private val stored = mutableMapOf<ResourceId, Content>()
    private val graphs = mutableMapOf<ResourceId, GetResourceResponse>()
    private val annotations = mutableMapOf<ResourceId, GetAnnotationsResponse>()
    private val anchoredTexts = mutableMapOf<ResourceId, AnchoredTextAnswer>()
    private val made = mutableListOf<ContentCall>()
    private val scope = CoroutineScope(SupervisorJob() + Dispatchers.Unconfined)

    /** Store `content` as the bytes of `resourceId`. */
    @JvmExposeBoxed
    public fun seed(resourceId: ResourceId, content: Content): Unit = synchronized(this) { stored[resourceId] = content }

    /** Store `graph` as the description of `resourceId`. */
    @JvmExposeBoxed
    public fun seedGraph(resourceId: ResourceId, graph: GetResourceResponse): Unit = synchronized(this) { graphs[resourceId] = graph }

    /** Store `annotations` as the annotations of `resourceId`. */
    @JvmExposeBoxed
    public fun seedAnnotations(resourceId: ResourceId, annotations: GetAnnotationsResponse): Unit = synchronized(this) { this.annotations[resourceId] = annotations }

    /** Store `answer` as what a read of `resourceId`'s anchored text is answered. */
    @JvmExposeBoxed
    public fun seedAnchoredText(resourceId: ResourceId, answer: AnchoredTextAnswer): Unit = synchronized(this) { anchoredTexts[resourceId] = answer }

    /** Every call made, in order. */
    public val calls: List<ContentCall> get() = synchronized(this) { made.toList() }

    private fun <T> called(call: ContentCall, read: () -> T): T = synchronized(this) {
        made += call
        read()
    }

    /** Stored under an id of this double's making, `test-content-<n>`, its progress said once, whole. */
    override fun putBinary(request: PutBinaryRequest): Upload {
        val created = synchronized(this) {
            val resourceId = ResourceId("test-content-${stored.size + 1}")
            stored[resourceId] = Content(request.format, request.file)
            made += PutBinary(request)
            CreateResourceResponse(resourceId = resourceId)
        }
        val progress = Channel<UploadProgress>(1)
        progress.trySend(UploadProgress(request.file.size.toLong(), request.file.size.toLong()))
        progress.close()
        return Upload(CompletableDeferred(created), Events(progress.consumeAsFlow()) { progress.close() })
    }

    override suspend fun getBinary(resourceId: ResourceId): Content = called(GetBinary(resourceId)) { stored[resourceId] ?: throw notFound("content", resourceId) }

    @JvmExposeBoxed
    override fun getBinaryFuture(resourceId: ResourceId): CompletableFuture<Content> = scope.futureOf { getBinary(resourceId) }

    override suspend fun getBinaryStream(resourceId: ResourceId): ContentStream {
        val content = called(GetBinaryStream(resourceId)) { stored[resourceId] ?: throw notFound("content", resourceId) }
        return ContentStream(content.contentType, flowOf(content.bytes), scope)
    }

    @JvmExposeBoxed
    override fun getBinaryStreamFuture(resourceId: ResourceId): CompletableFuture<ContentStream> = scope.futureOf { getBinaryStream(resourceId) }

    override suspend fun getResourceGraph(resourceId: ResourceId): GetResourceResponse =
        called(GetResourceGraph(resourceId)) { graphs[resourceId] ?: throw notFound("description", resourceId) }

    @JvmExposeBoxed
    override fun getResourceGraphFuture(resourceId: ResourceId): CompletableFuture<GetResourceResponse> = scope.futureOf { getResourceGraph(resourceId) }

    override suspend fun getAnnotations(resourceId: ResourceId): GetAnnotationsResponse =
        called(GetAnnotations(resourceId)) { annotations[resourceId] ?: throw notFound("annotations", resourceId) }

    @JvmExposeBoxed
    override fun getAnnotationsFuture(resourceId: ResourceId): CompletableFuture<GetAnnotationsResponse> = scope.futureOf { getAnnotations(resourceId) }

    override suspend fun getAnchoredText(resourceId: ResourceId): AnchoredTextAnswer =
        called(GetAnchoredText(resourceId)) { anchoredTexts[resourceId] ?: throw notFound("anchored text", resourceId) }

    @JvmExposeBoxed
    override fun getAnchoredTextFuture(resourceId: ResourceId): CompletableFuture<AnchoredTextAnswer> = scope.futureOf { getAnchoredText(resourceId) }

    override fun close(): Unit = Unit
}

/**
 * A `GatewayOperations` for tests that answers only what it was told to. An
 * operation nobody scripted is refused, naming it: a double that answered it
 * with a value of its own making would hand its caller a success nobody
 * decided on. Every call is recorded, answered or not. Nothing it does
 * waits: a future of it runs on the thread that asks.
 */
public class StubGateway : GatewayOperations {
    private var currentUser: UserResponse? = null
    private var mediaToken: MediaTokenResponse? = null
    private var protectedResourceMetadata: ProtectedResourceMetadata? = null
    private var health: HealthResponse? = null
    private var status: StatusResponse? = null
    private val made = mutableListOf<String>()
    private val scope = CoroutineScope(SupervisorJob() + Dispatchers.Unconfined)

    /** What `getCurrentUser` answers. */
    public fun currentUser(answer: UserResponse): Unit = synchronized(this) { currentUser = answer }

    /** What `getMediaToken` answers, of any resource. */
    public fun mediaToken(answer: MediaTokenResponse): Unit = synchronized(this) { mediaToken = answer }

    /** What `getProtectedResourceMetadata` answers. */
    public fun protectedResourceMetadata(answer: ProtectedResourceMetadata): Unit = synchronized(this) { protectedResourceMetadata = answer }

    /** What `healthCheck` answers. */
    public fun health(answer: HealthResponse): Unit = synchronized(this) { health = answer }

    /** What `getStatus` answers. */
    public fun status(answer: StatusResponse): Unit = synchronized(this) { status = answer }

    /** Every operation called, in order: its name and, when it has one, the resource it was called for (`getMediaToken res-1`). */
    public val calls: List<String> get() = synchronized(this) { made.toList() }

    private fun <T : Any> answered(operation: String, scripted: () -> T?, of: ResourceId? = null): T = synchronized(this) {
        made += if (of == null) operation else "$operation ${of.value}"
        scripted() ?: throw TransportError(TransportErrorCode.Error, "StubGateway: not scripted: $operation")
    }

    override suspend fun getCurrentUser(): UserResponse = answered("getCurrentUser", { currentUser })

    override fun getCurrentUserFuture(): CompletableFuture<UserResponse> = scope.futureOf { getCurrentUser() }

    override suspend fun getMediaToken(resourceId: ResourceId): MediaTokenResponse = answered("getMediaToken", { mediaToken }, resourceId)

    @JvmExposeBoxed
    override fun getMediaTokenFuture(resourceId: ResourceId): CompletableFuture<MediaTokenResponse> = scope.futureOf { getMediaToken(resourceId) }

    override suspend fun getProtectedResourceMetadata(): ProtectedResourceMetadata = answered("getProtectedResourceMetadata", { protectedResourceMetadata })

    override fun getProtectedResourceMetadataFuture(): CompletableFuture<ProtectedResourceMetadata> = scope.futureOf { getProtectedResourceMetadata() }

    override suspend fun healthCheck(): HealthResponse = answered("healthCheck", { health })

    override fun healthCheckFuture(): CompletableFuture<HealthResponse> = scope.futureOf { healthCheck() }

    override suspend fun getStatus(): StatusResponse = answered("getStatus", { status })

    override fun getStatusFuture(): CompletableFuture<StatusResponse> = scope.futureOf { getStatus() }
}
