// Generated from protocol/specs/src/openapi.json and its paths; do not edit.
// Regenerate: make generate (codegen/lib/gateway_http/kotlin.ml)

package xynolog.http

/** An operation of the gateway: its method, and its path, a `{name}` for each parameter, which the caller fills. */
internal data class GatewayRoute(val method: String, val path: String)

/** `getHealth`. */
internal val GET_HEALTH = GatewayRoute(method = "GET", path = "/api/health")

/** `getHealthAtRoot`. */
internal val GET_HEALTH_AT_ROOT = GatewayRoute(method = "GET", path = "/")

/** `getOpenApiDocument`. */
internal val GET_OPEN_API_DOCUMENT = GatewayRoute(method = "GET", path = "/api/openapi.json")

/** `getProtectedResourceMetadata`. */
internal val GET_PROTECTED_RESOURCE_METADATA = GatewayRoute(method = "GET", path = "/.well-known/oauth-protected-resource")

/** `createMediaToken`. */
internal val CREATE_MEDIA_TOKEN = GatewayRoute(method = "POST", path = "/api/tokens/media")

/** `getCurrentUser`. */
internal val GET_CURRENT_USER = GatewayRoute(method = "GET", path = "/api/users/me")

/** `getStatus`. */
internal val GET_STATUS = GatewayRoute(method = "GET", path = "/api/status")

/** `subscribeToBus`. */
internal val SUBSCRIBE_TO_BUS = GatewayRoute(method = "POST", path = "/bus/subscribe")

/** `emitOnBus`. */
internal val EMIT_ON_BUS = GatewayRoute(method = "POST", path = "/bus/emit")

/** `uploadResource`. */
internal val UPLOAD_RESOURCE = GatewayRoute(method = "POST", path = "/resources")

/** `getResourceRepresentation`. */
internal val GET_RESOURCE_REPRESENTATION = GatewayRoute(method = "GET", path = "/resources/{id}")

/** `getResourceJsonLd`. */
internal val GET_RESOURCE_JSON_LD = GatewayRoute(method = "GET", path = "/resources/{id}/jsonld")

/** `getResourceAnnotations`. */
internal val GET_RESOURCE_ANNOTATIONS = GatewayRoute(method = "GET", path = "/resources/{id}/annotations")

/** `getResourceAnchoredText`. */
internal val GET_RESOURCE_ANCHORED_TEXT = GatewayRoute(method = "GET", path = "/resources/{id}/anchored-text")

/** `getResourceRepresentationWithMediaToken`. */
internal val GET_RESOURCE_REPRESENTATION_WITH_MEDIA_TOKEN = GatewayRoute(method = "GET", path = "/api/resources/{id}")

internal const val GET_HEALTH_ANSWERS = "application/json"
internal const val GET_HEALTH_AT_ROOT_ANSWERS = "application/json"
internal const val GET_OPEN_API_DOCUMENT_ANSWERS = "application/json"
internal const val GET_PROTECTED_RESOURCE_METADATA_ANSWERS = "application/json"
internal const val CREATE_MEDIA_TOKEN_SENDS = "application/json"
internal const val CREATE_MEDIA_TOKEN_ANSWERS = "application/json"
internal const val GET_CURRENT_USER_ANSWERS = "application/json"
internal const val GET_STATUS_ANSWERS = "application/json"
internal const val SUBSCRIBE_TO_BUS_SENDS = "application/json"
internal const val SUBSCRIBE_TO_BUS_ANSWERS = "text/event-stream"
internal const val EMIT_ON_BUS_SENDS = "application/json"
internal const val EMIT_ON_BUS_ANSWERS = "application/json"
internal const val UPLOAD_RESOURCE_SENDS = "multipart/form-data"
internal const val UPLOAD_RESOURCE_ANSWERS = "application/json"
internal const val GET_RESOURCE_REPRESENTATION_ANSWERS = "*/*"
internal const val GET_RESOURCE_JSON_LD_ANSWERS = "application/ld+json"
internal const val GET_RESOURCE_ANNOTATIONS_ANSWERS = "application/json"
internal const val GET_RESOURCE_ANCHORED_TEXT_ANSWERS = "application/json"
internal const val GET_RESOURCE_REPRESENTATION_WITH_MEDIA_TOKEN_ANSWERS = "*/*"

internal const val CACHE_CONTROL = "Cache-Control"
internal const val IDEMPOTENCY_KEY = "Idempotency-Key"
internal const val LINK = "Link"
internal const val RETRY_AFTER = "Retry-After"
internal const val WWW_AUTHENTICATE = "WWW-Authenticate"

/** A member of an upload (`ResourceUpload`), in the schema's order. */
internal enum class UploadField(val wire: String, val required: Boolean) {
    Name("name", true),
    File("file", true),
    Format("format", true),
    StorageUri("storageUri", true),
    Language("language", false),
    EntityTypes("entityTypes", false),
    SourceAnnotationId("sourceAnnotationId", false),
    SourceResourceId("sourceResourceId", false),
    GenerationPrompt("generationPrompt", false),
    Generator("generator", false),
    JobId("jobId", false),
    IsDraft("isDraft", false),
    CloneToken("cloneToken", false),
    ArchiveOriginal("archiveOriginal", false),
}

internal const val BUS_FRAME_CHANNEL = "channel"
internal const val BUS_FRAME_CORRELATION_ID = "correlationId"
internal const val BUS_FRAME_PAYLOAD = "payload"
internal const val BUS_FRAME_SCOPE = "scope"

/** The form a service account posts with a client secret, each member by its name, in the schema's order. */
internal fun clientSecretForm(clientId: String, clientSecret: String): List<Pair<String, String>> = listOf("grant_type" to "client_credentials", "client_id" to clientId, "client_secret" to clientSecret)
