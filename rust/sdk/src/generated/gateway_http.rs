// Generated from protocol/specs/src/openapi.json and its paths; do not edit.
// Regenerate: make generate (codegen/lib/gateway_http/rust.ml)
/// A method the gateway's operations use.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Method {
    Get,
    Post,
}

/// An operation of the gateway: its method, its path (a `{name}` for each
/// parameter, which the caller fills), and the media types it sends and
/// answers with, if it has a body.
#[derive(Clone, Copy, Debug)]
pub struct Route {
    pub method: Method,
    pub path: &'static str,
    pub sends: Option<&'static str>,
    pub answers: Option<&'static str>,
}

/// `getHealth`.
pub const GET_HEALTH: Route = Route {
    method: Method::Get,
    path: "/api/health",
    sends: None,
    answers: Some("application/json"),
};

/// `getHealthAtRoot`.
pub const GET_HEALTH_AT_ROOT: Route = Route {
    method: Method::Get,
    path: "/",
    sends: None,
    answers: Some("application/json"),
};

/// `getOpenApiDocument`.
pub const GET_OPEN_API_DOCUMENT: Route = Route {
    method: Method::Get,
    path: "/api/openapi.json",
    sends: None,
    answers: Some("application/json"),
};

/// `getProtectedResourceMetadata`.
pub const GET_PROTECTED_RESOURCE_METADATA: Route = Route {
    method: Method::Get,
    path: "/.well-known/oauth-protected-resource",
    sends: None,
    answers: Some("application/json"),
};

/// `createMediaToken`.
pub const CREATE_MEDIA_TOKEN: Route = Route {
    method: Method::Post,
    path: "/api/tokens/media",
    sends: Some("application/json"),
    answers: Some("application/json"),
};

/// `getCurrentUser`.
pub const GET_CURRENT_USER: Route = Route {
    method: Method::Get,
    path: "/api/users/me",
    sends: None,
    answers: Some("application/json"),
};

/// `getStatus`.
pub const GET_STATUS: Route = Route {
    method: Method::Get,
    path: "/api/status",
    sends: None,
    answers: Some("application/json"),
};

/// `subscribeToBus`.
pub const SUBSCRIBE_TO_BUS: Route = Route {
    method: Method::Post,
    path: "/bus/subscribe",
    sends: Some("application/json"),
    answers: Some("text/event-stream"),
};

/// `emitOnBus`.
pub const EMIT_ON_BUS: Route = Route {
    method: Method::Post,
    path: "/bus/emit",
    sends: Some("application/json"),
    answers: Some("application/json"),
};

/// `uploadResource`.
pub const UPLOAD_RESOURCE: Route = Route {
    method: Method::Post,
    path: "/resources",
    sends: Some("multipart/form-data"),
    answers: Some("application/json"),
};

/// `getResourceRepresentation`.
pub const GET_RESOURCE_REPRESENTATION: Route = Route {
    method: Method::Get,
    path: "/resources/{id}",
    sends: None,
    answers: Some("*/*"),
};

/// `getResourceJsonLd`.
pub const GET_RESOURCE_JSON_LD: Route = Route {
    method: Method::Get,
    path: "/resources/{id}/jsonld",
    sends: None,
    answers: Some("application/ld+json"),
};

/// `getResourceAnnotations`.
pub const GET_RESOURCE_ANNOTATIONS: Route = Route {
    method: Method::Get,
    path: "/resources/{id}/annotations",
    sends: None,
    answers: Some("application/json"),
};

/// `getResourceAnchoredText`.
pub const GET_RESOURCE_ANCHORED_TEXT: Route = Route {
    method: Method::Get,
    path: "/resources/{id}/anchored-text",
    sends: None,
    answers: Some("application/json"),
};

/// `getResourceRepresentationWithMediaToken`.
pub const GET_RESOURCE_REPRESENTATION_WITH_MEDIA_TOKEN: Route = Route {
    method: Method::Get,
    path: "/api/resources/{id}",
    sends: None,
    answers: Some("*/*"),
};

pub const CACHE_CONTROL: &str = "Cache-Control";
pub const IDEMPOTENCY_KEY: &str = "Idempotency-Key";
pub const LINK: &str = "Link";
pub const RETRY_AFTER: &str = "Retry-After";
pub const WWW_AUTHENTICATE: &str = "WWW-Authenticate";

/// A member of an upload (`ResourceUpload`).
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum UploadField {
    Name,
    File,
    Format,
    StorageUri,
    Language,
    EntityTypes,
    SourceAnnotationId,
    SourceResourceId,
    GenerationPrompt,
    Generator,
    JobId,
    IsDraft,
    CloneToken,
    ArchiveOriginal,
}

impl UploadField {
    /// Every member, in the schema's order.
    pub const ALL: [UploadField; 14] = [
        UploadField::Name,
        UploadField::File,
        UploadField::Format,
        UploadField::StorageUri,
        UploadField::Language,
        UploadField::EntityTypes,
        UploadField::SourceAnnotationId,
        UploadField::SourceResourceId,
        UploadField::GenerationPrompt,
        UploadField::Generator,
        UploadField::JobId,
        UploadField::IsDraft,
        UploadField::CloneToken,
        UploadField::ArchiveOriginal,
    ];

    /// The name the member is sent under.
    pub const fn name(self) -> &'static str {
        match self {
            UploadField::Name => "name",
            UploadField::File => "file",
            UploadField::Format => "format",
            UploadField::StorageUri => "storageUri",
            UploadField::Language => "language",
            UploadField::EntityTypes => "entityTypes",
            UploadField::SourceAnnotationId => "sourceAnnotationId",
            UploadField::SourceResourceId => "sourceResourceId",
            UploadField::GenerationPrompt => "generationPrompt",
            UploadField::Generator => "generator",
            UploadField::JobId => "jobId",
            UploadField::IsDraft => "isDraft",
            UploadField::CloneToken => "cloneToken",
            UploadField::ArchiveOriginal => "archiveOriginal",
        }
    }

    /// Whether every upload sends it.
    pub const fn required(self) -> bool {
        match self {
            UploadField::Name => true,
            UploadField::File => true,
            UploadField::Format => true,
            UploadField::StorageUri => true,
            UploadField::Language => false,
            UploadField::EntityTypes => false,
            UploadField::SourceAnnotationId => false,
            UploadField::SourceResourceId => false,
            UploadField::GenerationPrompt => false,
            UploadField::Generator => false,
            UploadField::JobId => false,
            UploadField::IsDraft => false,
            UploadField::CloneToken => false,
            UploadField::ArchiveOriginal => false,
        }
    }
}

/// The form a service account posts with a client secret, each member
/// by its name, in the schema's order.
pub fn client_secret_form<'a>(
    client_id: &'a str,
    client_secret: &'a str,
) -> [(&'static str, &'a str); 3] {
    [
        ("grant_type", "client_credentials"),
        ("client_id", client_id),
        ("client_secret", client_secret),
    ]
}
