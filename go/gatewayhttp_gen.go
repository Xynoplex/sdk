// Code generated from protocol/specs/src/openapi.json and its paths; DO NOT EDIT.
//
// Regenerate: make generate (codegen/lib/gateway_http/go.ml)

package xynolog

import "net/url"

// gatewayRoute is an operation of the gateway: its method and its path, a
// {name} for each parameter, which the caller fills.
type gatewayRoute struct {
	method, path string
}

// routeGetHealth is getHealth.
var routeGetHealth = gatewayRoute{method: "GET", path: "/api/health"}

// routeGetHealthAtRoot is getHealthAtRoot.
var routeGetHealthAtRoot = gatewayRoute{method: "GET", path: "/"}

// routeGetOpenApiDocument is getOpenApiDocument.
var routeGetOpenApiDocument = gatewayRoute{method: "GET", path: "/api/openapi.json"}

// routeGetProtectedResourceMetadata is getProtectedResourceMetadata.
var routeGetProtectedResourceMetadata = gatewayRoute{method: "GET", path: "/.well-known/oauth-protected-resource"}

// routeCreateMediaToken is createMediaToken.
var routeCreateMediaToken = gatewayRoute{method: "POST", path: "/api/tokens/media"}

// routeGetCurrentUser is getCurrentUser.
var routeGetCurrentUser = gatewayRoute{method: "GET", path: "/api/users/me"}

// routeGetStatus is getStatus.
var routeGetStatus = gatewayRoute{method: "GET", path: "/api/status"}

// routeSubscribeToBus is subscribeToBus.
var routeSubscribeToBus = gatewayRoute{method: "POST", path: "/bus/subscribe"}

// routeEmitOnBus is emitOnBus.
var routeEmitOnBus = gatewayRoute{method: "POST", path: "/bus/emit"}

// routeUploadResource is uploadResource.
var routeUploadResource = gatewayRoute{method: "POST", path: "/resources"}

// routeGetResourceRepresentation is getResourceRepresentation.
var routeGetResourceRepresentation = gatewayRoute{method: "GET", path: "/resources/{id}"}

// routeGetResourceJsonLd is getResourceJsonLd.
var routeGetResourceJsonLd = gatewayRoute{method: "GET", path: "/resources/{id}/jsonld"}

// routeGetResourceAnnotations is getResourceAnnotations.
var routeGetResourceAnnotations = gatewayRoute{method: "GET", path: "/resources/{id}/annotations"}

// routeGetResourceAnchoredText is getResourceAnchoredText.
var routeGetResourceAnchoredText = gatewayRoute{method: "GET", path: "/resources/{id}/anchored-text"}

// routeGetResourceRepresentationWithMediaToken is
// getResourceRepresentationWithMediaToken.
var routeGetResourceRepresentationWithMediaToken = gatewayRoute{method: "GET", path: "/api/resources/{id}"}

// The media type each operation sends and answers with, where it has a body.
const (
	routeGetHealthAnswers                               = "application/json"
	routeGetHealthAtRootAnswers                         = "application/json"
	routeGetOpenApiDocumentAnswers                      = "application/json"
	routeGetProtectedResourceMetadataAnswers            = "application/json"
	routeCreateMediaTokenSends                          = "application/json"
	routeCreateMediaTokenAnswers                        = "application/json"
	routeGetCurrentUserAnswers                          = "application/json"
	routeGetStatusAnswers                               = "application/json"
	routeSubscribeToBusSends                            = "application/json"
	routeSubscribeToBusAnswers                          = "text/event-stream"
	routeEmitOnBusSends                                 = "application/json"
	routeEmitOnBusAnswers                               = "application/json"
	routeUploadResourceSends                            = "multipart/form-data"
	routeUploadResourceAnswers                          = "application/json"
	routeGetResourceRepresentationAnswers               = "*/*"
	routeGetResourceJsonLdAnswers                       = "application/ld+json"
	routeGetResourceAnnotationsAnswers                  = "application/json"
	routeGetResourceAnchoredTextAnswers                 = "application/json"
	routeGetResourceRepresentationWithMediaTokenAnswers = "*/*"
)

// Each header the gateway's operations name, asked or answered.
const (
	headerCacheControl    = "Cache-Control"
	headerIdempotencyKey  = "Idempotency-Key"
	headerLink            = "Link"
	headerRetryAfter      = "Retry-After"
	headerWWWAuthenticate = "WWW-Authenticate"
)

// uploadField is a member of an upload (ResourceUpload), and whether every
// upload sends it.
type uploadField struct {
	name     string
	required bool
}

// The name each member of an upload is sent under.
const (
	uploadFieldName               = "name"
	uploadFieldFile               = "file"
	uploadFieldFormat             = "format"
	uploadFieldStorageUri         = "storageUri"
	uploadFieldLanguage           = "language"
	uploadFieldEntityTypes        = "entityTypes"
	uploadFieldSourceAnnotationId = "sourceAnnotationId"
	uploadFieldSourceResourceId   = "sourceResourceId"
	uploadFieldGenerationPrompt   = "generationPrompt"
	uploadFieldGenerator          = "generator"
	uploadFieldJobId              = "jobId"
	uploadFieldIsDraft            = "isDraft"
	uploadFieldCloneToken         = "cloneToken"
	uploadFieldArchiveOriginal    = "archiveOriginal"
)

// uploadFields is every member of an upload, in the schema's order.
var uploadFields = []uploadField{
	{name: uploadFieldName, required: true},
	{name: uploadFieldFile, required: true},
	{name: uploadFieldFormat, required: true},
	{name: uploadFieldStorageUri, required: true},
	{name: uploadFieldLanguage, required: false},
	{name: uploadFieldEntityTypes, required: false},
	{name: uploadFieldSourceAnnotationId, required: false},
	{name: uploadFieldSourceResourceId, required: false},
	{name: uploadFieldGenerationPrompt, required: false},
	{name: uploadFieldGenerator, required: false},
	{name: uploadFieldJobId, required: false},
	{name: uploadFieldIsDraft, required: false},
	{name: uploadFieldCloneToken, required: false},
	{name: uploadFieldArchiveOriginal, required: false},
}

// The name each member of a bus frame (BusFrame) is written under.
const (
	busFrameChannel       = "channel"
	busFrameCorrelationId = "correlationId"
	busFramePayload       = "payload"
	busFrameScope         = "scope"
)

// clientSecretForm is the form a service account posts with a client secret.
func clientSecretForm(clientID string, clientSecret string) url.Values {
	return url.Values{"grant_type": {"client_credentials"}, "client_id": {clientID}, "client_secret": {clientSecret}}
}
