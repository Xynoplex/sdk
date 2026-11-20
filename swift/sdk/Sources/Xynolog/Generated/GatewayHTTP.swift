// Generated from protocol/specs/src/openapi.json and its paths; do not edit.
// Regenerate: make generate (codegen/lib/gateway_http/swift.ml)
import Foundation

/// An operation of the gateway: its method, and its path, a `{name}` for each parameter, which the
/// caller fills.
struct GatewayRoute: Sendable {
  let method: String
  let path: String
  /// `getHealth`.
  static let getHealth = GatewayRoute(method: "GET", path: "/api/health")
  /// `getHealthAtRoot`.
  static let getHealthAtRoot = GatewayRoute(method: "GET", path: "/")
  /// `getOpenApiDocument`.
  static let getOpenApiDocument = GatewayRoute(method: "GET", path: "/api/openapi.json")
  /// `getProtectedResourceMetadata`.
  static let getProtectedResourceMetadata = GatewayRoute(
    method: "GET", path: "/.well-known/oauth-protected-resource")
  /// `createMediaToken`.
  static let createMediaToken = GatewayRoute(method: "POST", path: "/api/tokens/media")
  /// `getCurrentUser`.
  static let getCurrentUser = GatewayRoute(method: "GET", path: "/api/users/me")
  /// `getStatus`.
  static let getStatus = GatewayRoute(method: "GET", path: "/api/status")
  /// `subscribeToBus`.
  static let subscribeToBus = GatewayRoute(method: "POST", path: "/bus/subscribe")
  /// `emitOnBus`.
  static let emitOnBus = GatewayRoute(method: "POST", path: "/bus/emit")
  /// `uploadResource`.
  static let uploadResource = GatewayRoute(method: "POST", path: "/resources")
  /// `getResourceRepresentation`.
  static let getResourceRepresentation = GatewayRoute(method: "GET", path: "/resources/{id}")
  /// `getResourceJsonLd`.
  static let getResourceJsonLd = GatewayRoute(method: "GET", path: "/resources/{id}/jsonld")
  /// `getResourceAnnotations`.
  static let getResourceAnnotations = GatewayRoute(
    method: "GET", path: "/resources/{id}/annotations")
  /// `getResourceAnchoredText`.
  static let getResourceAnchoredText = GatewayRoute(
    method: "GET", path: "/resources/{id}/anchored-text")
  /// `getResourceRepresentationWithMediaToken`.
  static let getResourceRepresentationWithMediaToken = GatewayRoute(
    method: "GET", path: "/api/resources/{id}")
}

/// The media type each operation sends and answers with, where it has a body.
enum GatewayMedia {
  static let getHealthAnswers = "application/json"
  static let getHealthAtRootAnswers = "application/json"
  static let getOpenApiDocumentAnswers = "application/json"
  static let getProtectedResourceMetadataAnswers = "application/json"
  static let createMediaTokenSends = "application/json"
  static let createMediaTokenAnswers = "application/json"
  static let getCurrentUserAnswers = "application/json"
  static let getStatusAnswers = "application/json"
  static let subscribeToBusSends = "application/json"
  static let subscribeToBusAnswers = "text/event-stream"
  static let emitOnBusSends = "application/json"
  static let emitOnBusAnswers = "application/json"
  static let uploadResourceSends = "multipart/form-data"
  static let uploadResourceAnswers = "application/json"
  static let getResourceRepresentationAnswers = "*/*"
  static let getResourceJsonLdAnswers = "application/ld+json"
  static let getResourceAnnotationsAnswers = "application/json"
  static let getResourceAnchoredTextAnswers = "application/json"
  static let getResourceRepresentationWithMediaTokenAnswers = "*/*"
}

/// Each header the gateway's operations name, asked or answered.
enum GatewayHeader {
  static let cacheControl = "Cache-Control"
  static let idempotencyKey = "Idempotency-Key"
  static let link = "Link"
  static let retryAfter = "Retry-After"
  static let wwwAuthenticate = "WWW-Authenticate"
}

/// A member of an upload (`ResourceUpload`), by the name it is sent under.
enum UploadField: String, Sendable, CaseIterable {
  case name
  case file
  case format
  case storageUri
  case language
  case entityTypes
  case sourceAnnotationId
  case sourceResourceId
  case generationPrompt
  case generator
  case jobId
  case isDraft
  case cloneToken
  case archiveOriginal
}

/// The form a service account posts with a client secret, each member by its name, in the schema's
/// order.
func clientSecretForm(clientId: String, clientSecret: String) -> [(String, String)] {
  return [
    ("grant_type", "client_credentials"), ("client_id", clientId), ("client_secret", clientSecret),
  ]
}
