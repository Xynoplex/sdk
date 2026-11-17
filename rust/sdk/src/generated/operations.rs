// Generated from protocol/specs/src/bus/registry.json; do not edit.
// Regenerate: make generate (codegen/lib/bus/rust.ml)
pub const OPERATIONS: &[Operation] = &[
    Operation {
        request: "bind:update-body",
        result: "bind:body-updated",
        failure: "bind:body-update-failed",
    },
    Operation {
        request: "browse:resource-requested",
        result: "browse:resource-result",
        failure: "browse:resource-failed",
    },
    Operation {
        request: "browse:resources-requested",
        result: "browse:resources-result",
        failure: "browse:resources-failed",
    },
    Operation {
        request: "browse:annotation-requested",
        result: "browse:annotation-result",
        failure: "browse:annotation-failed",
    },
    Operation {
        request: "browse:annotation-history-requested",
        result: "browse:annotation-history-result",
        failure: "browse:annotation-history-failed",
    },
    Operation {
        request: "browse:events-requested",
        result: "browse:events-result",
        failure: "browse:events-failed",
    },
    Operation {
        request: "browse:entity-types-requested",
        result: "browse:entity-types-result",
        failure: "browse:entity-types-failed",
    },
    Operation {
        request: "browse:tag-schemas-requested",
        result: "browse:tag-schemas-result",
        failure: "browse:tag-schemas-failed",
    },
    Operation {
        request: "browse:engines-requested",
        result: "browse:engines-result",
        failure: "browse:engines-failed",
    },
    Operation {
        request: "browse:profiles-requested",
        result: "browse:profiles-result",
        failure: "browse:profiles-failed",
    },
    Operation {
        request: "browse:kb-requested",
        result: "browse:kb-result",
        failure: "browse:kb-failed",
    },
    Operation {
        request: "browse:directory-requested",
        result: "browse:directory-result",
        failure: "browse:directory-failed",
    },
    Operation {
        request: "frame:add-entity-type",
        result: "frame:entity-type-add-ok",
        failure: "frame:entity-type-add-failed",
    },
    Operation {
        request: "frame:add-tag-schema",
        result: "frame:tag-schema-add-ok",
        failure: "frame:tag-schema-add-failed",
    },
    Operation {
        request: "gather:requested",
        result: "gather:complete",
        failure: "gather:failed",
    },
    Operation {
        request: "gather:resource-requested",
        result: "gather:resource-complete",
        failure: "gather:resource-failed",
    },
    Operation {
        request: "gather:summary-requested",
        result: "gather:summary-result",
        failure: "gather:summary-failed",
    },
    Operation {
        request: "gather:referenced-by-requested",
        result: "gather:referenced-by-result",
        failure: "gather:referenced-by-failed",
    },
    Operation {
        request: "gather:limits-requested",
        result: "gather:limits-result",
        failure: "gather:limits-failed",
    },
    Operation {
        request: "job:create",
        result: "job:created",
        failure: "job:create-failed",
    },
    Operation {
        request: "job:status-requested",
        result: "job:status-result",
        failure: "job:status-failed",
    },
    Operation {
        request: "job:limits-requested",
        result: "job:limits-result",
        failure: "job:limits-failed",
    },
    Operation {
        request: "job:cancel-requested",
        result: "job:cancel-ok",
        failure: "job:cancel-failed",
    },
    Operation {
        request: "job:claim",
        result: "job:claimed",
        failure: "job:claim-failed",
    },
    Operation {
        request: "mark:create-request",
        result: "mark:create-ok",
        failure: "mark:create-failed",
    },
    Operation {
        request: "mark:commit",
        result: "mark:commit-ok",
        failure: "mark:commit-failed",
    },
    Operation {
        request: "mark:delete",
        result: "mark:delete-ok",
        failure: "mark:delete-failed",
    },
    Operation {
        request: "mark:archive",
        result: "mark:archive-ok",
        failure: "mark:archive-failed",
    },
    Operation {
        request: "mark:unarchive",
        result: "mark:unarchive-ok",
        failure: "mark:unarchive-failed",
    },
    Operation {
        request: "mark:update-entity-types",
        result: "mark:update-entity-types-ok",
        failure: "mark:update-entity-types-failed",
    },
    Operation {
        request: "match:search-requested",
        result: "match:search-results",
        failure: "match:search-failed",
    },
    Operation {
        request: "match:resources-requested",
        result: "match:resources-result",
        failure: "match:resources-failed",
    },
    Operation {
        request: "match:limits-requested",
        result: "match:limits-result",
        failure: "match:limits-failed",
    },
    Operation {
        request: "weave:rebuild",
        result: "weave:rebuild-ok",
        failure: "weave:rebuild-failed",
    },
    Operation {
        request: "smelt:rebuild-anchors",
        result: "smelt:rebuild-anchors-ok",
        failure: "smelt:rebuild-anchors-failed",
    },
    Operation {
        request: "yield:create",
        result: "yield:create-ok",
        failure: "yield:create-failed",
    },
    Operation {
        request: "yield:clone-persist",
        result: "yield:clone-persist-ok",
        failure: "yield:clone-persist-failed",
    },
    Operation {
        request: "yield:update",
        result: "yield:update-ok",
        failure: "yield:update-failed",
    },
    Operation {
        request: "yield:clone-create",
        result: "yield:clone-created",
        failure: "yield:clone-create-failed",
    },
    Operation {
        request: "yield:clone-resource-requested",
        result: "yield:clone-resource-result",
        failure: "yield:clone-resource-failed",
    },
    Operation {
        request: "yield:clone-token-requested",
        result: "yield:clone-token-generated",
        failure: "yield:clone-token-failed",
    },
];
/// What an operation's reply states beside its `response`, by the request's channel: each a
/// property of the request, which the reply states again. An operation that is not here states
/// nothing beside it.
pub const REPLY_NAMES: &[(&str, &[&str])] = &[
    ("gather:requested", &["annotationId"]),
    ("gather:resource-requested", &["resourceId"]),
    ("match:search-requested", &["referenceId"]),
];
/// The operations that report the limits of the engines a service holds a client for.
pub const LIMITS_OPERATIONS: &[&str] = &[
    "gather:limits-requested",
    "job:limits-requested",
    "match:limits-requested",
];
