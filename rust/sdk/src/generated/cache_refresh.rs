// Generated from protocol/specs/src/client/refresh.json; do not edit.
// Regenerate: make generate (codegen/lib/cache_refresh/rust.ml)
/// The live queries a client's cache answers.
#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub enum CacheQuery {
    /// A resource's description.
    Resource,
    /// The annotations of a resource.
    Annotations,
    /// One annotation.
    Annotation,
    /// The recorded history of a resource.
    Events,
    /// The annotations elsewhere that refer to a resource.
    ReferencedBy,
    /// A list of resources, one per set of filters asked for. It is a query's answer, kept fresh by what every client hears and by the events of the resources whose scope the client holds, and by nothing else: a resource archived, unarchived or retagged elsewhere, by someone else, does not refresh it.
    Resources,
    /// The resources a text search found, one per search and set of filters asked for. A query's answer like `resources`, and kept fresh by the same events and no others.
    MatchedResources,
    /// The knowledge base's entity types.
    EntityTypes,
    /// The knowledge base's tag schemas.
    TagSchemas,
    /// The knowledge base's engines, joined with the limits each inference key holder reports: asking again asks every `<flow>:limits-requested` operation of the registry again too.
    Engines,
}

impl CacheQuery {
    /// Every query, in the table's order.
    pub const ALL: &'static [CacheQuery] = &[
        CacheQuery::Resource,
        CacheQuery::Annotations,
        CacheQuery::Annotation,
        CacheQuery::Events,
        CacheQuery::ReferencedBy,
        CacheQuery::Resources,
        CacheQuery::MatchedResources,
        CacheQuery::EntityTypes,
        CacheQuery::TagSchemas,
        CacheQuery::Engines,
    ];

    /// The queries whose answers a client keeps across its lives, for the person signed in, in the table's order.
    pub const PERSISTED: &'static [CacheQuery] = &[
        CacheQuery::Resource,
        CacheQuery::Annotations,
        CacheQuery::Annotation,
        CacheQuery::EntityTypes,
        CacheQuery::TagSchemas,
    ];

    /// The query's name, as the table and every SDK spell it.
    pub const fn name(self) -> &'static str {
        match self {
            CacheQuery::Resource => "resource",
            CacheQuery::Annotations => "annotations",
            CacheQuery::Annotation => "annotation",
            CacheQuery::Events => "events",
            CacheQuery::ReferencedBy => "referencedBy",
            CacheQuery::Resources => "resources",
            CacheQuery::MatchedResources => "matchedResources",
            CacheQuery::EntityTypes => "entityTypes",
            CacheQuery::TagSchemas => "tagSchemas",
            CacheQuery::Engines => "engines",
        }
    }
}

/// What refreshes a cache: the events of a channel, or a trigger that is no channel's: `Reopened`, the stream open again after a drop, and `Unreadable`, an event that cannot be read.
#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub enum RefreshTrigger {
    /// The stream is open again after a drop. Events every client hears carry no position, so the ones published meanwhile are lost and nothing replays them: the client asks again for everything they feed. What a resource's own scope feeds needs nothing here: its events are replayed from where the client left off, or `bus:resume-gap` says they could not be.
    Reopened,
    /// A frame on a channel of this table that its reading refuses, or one a member of which the row names is present and is not what it names: something changed and nothing says what, so every key held is asked for again, as after a gap.
    Unreadable,
    /// The gateway could not replay what a scope missed: everything held of that resource, and of its annotations, is asked for again.
    BusResumeGap,
    /// An annotation was added to the resource.
    MarkAdded,
    /// An annotation was removed from the resource.
    MarkRemoved,
    /// The reply to this client's own deletion: the annotation is gone whether or not the client holds the scope that would tell it so.
    MarkDeleteOk,
    /// An annotation's body changed, and the event carries the annotation as it now is. An annotation's body changed, and the event could not say what it now is.
    MarkBodyUpdated,
    /// An entity tag was added to the resource.
    MarkEntityTagAdded,
    /// An entity tag was removed from the resource.
    MarkEntityTagRemoved,
    /// The resource was archived, which its description states and lists filter on.
    MarkArchived,
    /// The resource was unarchived.
    MarkUnarchived,
    /// A resource was created.
    YieldCreated,
    /// A resource was updated.
    YieldUpdated,
    /// A resource was created as a clone.
    YieldCloned,
    /// A resource was renamed or moved.
    YieldMoved,
    /// An entity type was added to the knowledge base.
    FrameEntityTypeAdded,
    /// A tag schema was added to the knowledge base.
    FrameTagSchemaAdded,
}

impl RefreshTrigger {
    /// Every trigger, in the table's order.
    pub const ALL: &'static [RefreshTrigger] = &[
        RefreshTrigger::Reopened,
        RefreshTrigger::Unreadable,
        RefreshTrigger::BusResumeGap,
        RefreshTrigger::MarkAdded,
        RefreshTrigger::MarkRemoved,
        RefreshTrigger::MarkDeleteOk,
        RefreshTrigger::MarkBodyUpdated,
        RefreshTrigger::MarkEntityTagAdded,
        RefreshTrigger::MarkEntityTagRemoved,
        RefreshTrigger::MarkArchived,
        RefreshTrigger::MarkUnarchived,
        RefreshTrigger::YieldCreated,
        RefreshTrigger::YieldUpdated,
        RefreshTrigger::YieldCloned,
        RefreshTrigger::YieldMoved,
        RefreshTrigger::FrameEntityTypeAdded,
        RefreshTrigger::FrameTagSchemaAdded,
    ];

    /// The channel whose events are this trigger; none of a trigger that is no channel.
    pub const fn channel(self) -> Option<&'static str> {
        match self {
            RefreshTrigger::Reopened => None,
            RefreshTrigger::Unreadable => None,
            RefreshTrigger::BusResumeGap => Some("bus:resume-gap"),
            RefreshTrigger::MarkAdded => Some("mark:added"),
            RefreshTrigger::MarkRemoved => Some("mark:removed"),
            RefreshTrigger::MarkDeleteOk => Some("mark:delete-ok"),
            RefreshTrigger::MarkBodyUpdated => Some("mark:body-updated"),
            RefreshTrigger::MarkEntityTagAdded => Some("mark:entity-tag-added"),
            RefreshTrigger::MarkEntityTagRemoved => Some("mark:entity-tag-removed"),
            RefreshTrigger::MarkArchived => Some("mark:archived"),
            RefreshTrigger::MarkUnarchived => Some("mark:unarchived"),
            RefreshTrigger::YieldCreated => Some("yield:created"),
            RefreshTrigger::YieldUpdated => Some("yield:updated"),
            RefreshTrigger::YieldCloned => Some("yield:cloned"),
            RefreshTrigger::YieldMoved => Some("yield:moved"),
            RefreshTrigger::FrameEntityTypeAdded => Some("frame:entity-type-added"),
            RefreshTrigger::FrameTagSchemaAdded => Some("frame:tag-schema-added"),
        }
    }

    /// What this trigger does: one row, or two for a channel whose events come two ways.
    pub const fn rows(self) -> &'static [CacheRefresh] {
        match self {
            RefreshTrigger::Reopened => &[CacheRefresh {
                when: None,
                reach: Reach::Held,
                names: RefreshNames {
                    resource: None,
                    annotation: None,
                },
                carries: None,
                refetches: &[
                    CacheQuery::Resources,
                    CacheQuery::MatchedResources,
                    CacheQuery::Resource,
                    CacheQuery::EntityTypes,
                    CacheQuery::TagSchemas,
                    CacheQuery::Engines,
                ],
                writes: &[],
                removes: &[],
            }],
            RefreshTrigger::Unreadable => &[CacheRefresh {
                when: None,
                reach: Reach::Held,
                names: RefreshNames {
                    resource: None,
                    annotation: None,
                },
                carries: None,
                refetches: &[
                    CacheQuery::Resource,
                    CacheQuery::Annotations,
                    CacheQuery::Annotation,
                    CacheQuery::Events,
                    CacheQuery::ReferencedBy,
                    CacheQuery::Resources,
                    CacheQuery::MatchedResources,
                    CacheQuery::EntityTypes,
                    CacheQuery::TagSchemas,
                    CacheQuery::Engines,
                ],
                writes: &[],
                removes: &[],
            }],
            RefreshTrigger::BusResumeGap => &[CacheRefresh {
                when: None,
                reach: Reach::Subject,
                names: RefreshNames {
                    resource: Some(&["scope"]),
                    annotation: None,
                },
                carries: None,
                refetches: &[
                    CacheQuery::Annotations,
                    CacheQuery::Annotation,
                    CacheQuery::Resource,
                    CacheQuery::Events,
                    CacheQuery::ReferencedBy,
                ],
                writes: &[],
                removes: &[],
            }],
            RefreshTrigger::MarkAdded => &[CacheRefresh {
                when: None,
                reach: Reach::Subject,
                names: RefreshNames {
                    resource: Some(&["resourceId"]),
                    annotation: None,
                },
                carries: None,
                refetches: &[CacheQuery::Annotations, CacheQuery::Events],
                writes: &[],
                removes: &[],
            }],
            RefreshTrigger::MarkRemoved => &[CacheRefresh {
                when: None,
                reach: Reach::Subject,
                names: RefreshNames {
                    resource: Some(&["resourceId"]),
                    annotation: Some(&["payload", "annotationId"]),
                },
                carries: None,
                refetches: &[CacheQuery::Annotations, CacheQuery::Events],
                writes: &[],
                removes: &[CacheQuery::Annotation],
            }],
            RefreshTrigger::MarkDeleteOk => &[CacheRefresh {
                when: None,
                reach: Reach::Subject,
                names: RefreshNames {
                    resource: None,
                    annotation: Some(&["response", "annotationId"]),
                },
                carries: None,
                refetches: &[],
                writes: &[],
                removes: &[CacheQuery::Annotation],
            }],
            RefreshTrigger::MarkBodyUpdated => &[
                CacheRefresh {
                    when: Some(RefreshWhen::Enriched),
                    reach: Reach::Subject,
                    names: RefreshNames {
                        resource: Some(&["resourceId"]),
                        annotation: Some(&["annotation", "id"]),
                    },
                    carries: Some(&["annotation"]),
                    refetches: &[CacheQuery::Events],
                    writes: &[CacheQuery::Annotations, CacheQuery::Annotation],
                    removes: &[],
                },
                CacheRefresh {
                    when: Some(RefreshWhen::Unenriched),
                    reach: Reach::Subject,
                    names: RefreshNames {
                        resource: Some(&["resourceId"]),
                        annotation: Some(&["payload", "annotationId"]),
                    },
                    carries: None,
                    refetches: &[
                        CacheQuery::Annotations,
                        CacheQuery::Annotation,
                        CacheQuery::Events,
                    ],
                    writes: &[],
                    removes: &[],
                },
            ],
            RefreshTrigger::MarkEntityTagAdded => &[CacheRefresh {
                when: None,
                reach: Reach::Subject,
                names: RefreshNames {
                    resource: Some(&["resourceId"]),
                    annotation: None,
                },
                carries: None,
                refetches: &[
                    CacheQuery::Annotations,
                    CacheQuery::Resource,
                    CacheQuery::Events,
                ],
                writes: &[],
                removes: &[],
            }],
            RefreshTrigger::MarkEntityTagRemoved => &[CacheRefresh {
                when: None,
                reach: Reach::Subject,
                names: RefreshNames {
                    resource: Some(&["resourceId"]),
                    annotation: None,
                },
                carries: None,
                refetches: &[
                    CacheQuery::Annotations,
                    CacheQuery::Resource,
                    CacheQuery::Events,
                ],
                writes: &[],
                removes: &[],
            }],
            RefreshTrigger::MarkArchived => &[CacheRefresh {
                when: None,
                reach: Reach::Subject,
                names: RefreshNames {
                    resource: Some(&["resourceId"]),
                    annotation: None,
                },
                carries: None,
                refetches: &[
                    CacheQuery::Resource,
                    CacheQuery::Resources,
                    CacheQuery::MatchedResources,
                ],
                writes: &[],
                removes: &[],
            }],
            RefreshTrigger::MarkUnarchived => &[CacheRefresh {
                when: None,
                reach: Reach::Subject,
                names: RefreshNames {
                    resource: Some(&["resourceId"]),
                    annotation: None,
                },
                carries: None,
                refetches: &[
                    CacheQuery::Resource,
                    CacheQuery::Resources,
                    CacheQuery::MatchedResources,
                ],
                writes: &[],
                removes: &[],
            }],
            RefreshTrigger::YieldCreated => &[CacheRefresh {
                when: None,
                reach: Reach::Subject,
                names: RefreshNames {
                    resource: Some(&["resourceId"]),
                    annotation: None,
                },
                carries: None,
                refetches: &[
                    CacheQuery::Resource,
                    CacheQuery::Resources,
                    CacheQuery::MatchedResources,
                ],
                writes: &[],
                removes: &[],
            }],
            RefreshTrigger::YieldUpdated => &[CacheRefresh {
                when: None,
                reach: Reach::Subject,
                names: RefreshNames {
                    resource: Some(&["resourceId"]),
                    annotation: None,
                },
                carries: None,
                refetches: &[
                    CacheQuery::Resource,
                    CacheQuery::Resources,
                    CacheQuery::MatchedResources,
                ],
                writes: &[],
                removes: &[],
            }],
            RefreshTrigger::YieldCloned => &[CacheRefresh {
                when: None,
                reach: Reach::Subject,
                names: RefreshNames {
                    resource: Some(&["resourceId"]),
                    annotation: None,
                },
                carries: None,
                refetches: &[
                    CacheQuery::Resource,
                    CacheQuery::Resources,
                    CacheQuery::MatchedResources,
                ],
                writes: &[],
                removes: &[],
            }],
            RefreshTrigger::YieldMoved => &[CacheRefresh {
                when: None,
                reach: Reach::Subject,
                names: RefreshNames {
                    resource: Some(&["resourceId"]),
                    annotation: None,
                },
                carries: None,
                refetches: &[
                    CacheQuery::Resource,
                    CacheQuery::Resources,
                    CacheQuery::MatchedResources,
                ],
                writes: &[],
                removes: &[],
            }],
            RefreshTrigger::FrameEntityTypeAdded => &[CacheRefresh {
                when: None,
                reach: Reach::Subject,
                names: RefreshNames {
                    resource: None,
                    annotation: None,
                },
                carries: None,
                refetches: &[CacheQuery::EntityTypes],
                writes: &[],
                removes: &[],
            }],
            RefreshTrigger::FrameTagSchemaAdded => &[CacheRefresh {
                when: None,
                reach: Reach::Subject,
                names: RefreshNames {
                    resource: None,
                    annotation: None,
                },
                carries: None,
                refetches: &[CacheQuery::TagSchemas],
                writes: &[],
                removes: &[],
            }],
        }
    }
}
