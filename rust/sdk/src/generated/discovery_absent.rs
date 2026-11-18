// Generated from protocol/specs/src/client/discovery-absent.json; do not edit.
// Regenerate: make generate (codegen/lib/rust_types/rust_types.ml)
/// Why no launcher was found.
#[derive(
    Debug, Clone, Copy, PartialEq, Eq, PartialOrd, Ord, Hash, serde::Deserialize, serde::Serialize,
)]
pub enum DiscoveryAbsentReason {
    #[serde(rename = "not-found")]
    NotFound,
    #[serde(rename = "not-json")]
    NotJson,
    #[serde(rename = "invalid")]
    Invalid,
    #[serde(rename = "unsupported-version")]
    UnsupportedVersion,
    #[serde(rename = "unreadable")]
    Unreadable,
}

impl DiscoveryAbsentReason {
    /// The value as the wire spells it.
    pub const fn as_str(&self) -> &'static str {
        match self {
            DiscoveryAbsentReason::NotFound => "not-found",
            DiscoveryAbsentReason::NotJson => "not-json",
            DiscoveryAbsentReason::Invalid => "invalid",
            DiscoveryAbsentReason::UnsupportedVersion => "unsupported-version",
            DiscoveryAbsentReason::Unreadable => "unreadable",
        }
    }
}
