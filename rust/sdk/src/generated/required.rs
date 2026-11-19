// Generated from the component schemas of protocol/specs/src/openapi.json; do not edit.
// Regenerate: make generate (codegen/lib/required/rust.ml)
pub(crate) const SCHEMAS: &[(&str, Shape)] = &[
    (
        "Agent",
        Shape {
            kinds: Some(&[Kind::Object]),
            one_of: &[
                reference("AgentPerson"),
                reference("AgentOrganization"),
                reference("AgentSoftware"),
            ],
            discriminator: Some(Discriminator {
                property: "@type",
                mapping: &[("Person", 0), ("Organization", 1), ("Software", 2)],
            }),
            ..NONE
        },
    ),
    (
        "AgentOrganization",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["@type", "name"],
            members: &[
                ("@id", of(&[Kind::String])),
                (
                    "@type",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[Listed::Text("Organization")]),
                        ..NONE
                    },
                ),
                ("homepage", of(&[Kind::String])),
                ("name", of(&[Kind::String])),
            ],
            ..NONE
        },
    ),
    (
        "AgentPerson",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["@type"],
            members: &[
                ("@id", of(&[Kind::String])),
                (
                    "@type",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[Listed::Text("Person")]),
                        ..NONE
                    },
                ),
                ("email", of(&[Kind::String])),
                ("email_sha1", of(&[Kind::String])),
                ("homepage", of(&[Kind::String])),
                ("name", of(&[Kind::String])),
                ("nickname", of(&[Kind::String])),
            ],
            ..NONE
        },
    ),
    (
        "AgentSoftware",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["@type"],
            members: &[
                ("@id", of(&[Kind::String])),
                (
                    "@type",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[Listed::Text("Software")]),
                        ..NONE
                    },
                ),
                ("model", of(&[Kind::String])),
                ("name", of(&[Kind::String])),
                ("parameters", of(&[Kind::Object])),
                ("provider", of(&[Kind::String])),
            ],
            ..NONE
        },
    ),
    (
        "AnchoredText",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["text", "items"],
            members: &[
                (
                    "items",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&reference("PdfTextItem")),
                        ..NONE
                    },
                ),
                ("text", of(&[Kind::String])),
            ],
            ..NONE
        },
    ),
    (
        "AnchoredTextAbsent",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["kind"],
            members: &[(
                "kind",
                Shape {
                    kinds: Some(&[Kind::String]),
                    enumeration: Some(&[
                        Listed::Text("not-yet"),
                        Listed::Text("no-map"),
                        Listed::Text("unknown"),
                    ]),
                    ..NONE
                },
            )],
            ..NONE
        },
    ),
    (
        "AnchoredTextAnswer",
        Shape {
            kinds: Some(&[Kind::Object]),
            one_of: &[
                reference("ExtractedText"),
                reference("ExtractionDeclined"),
                reference("AnchoredTextAbsent"),
            ],
            discriminator: Some(Discriminator {
                property: "kind",
                mapping: &[
                    ("extracted", 0),
                    ("declined", 1),
                    ("not-yet", 2),
                    ("no-map", 2),
                    ("unknown", 2),
                ],
            }),
            ..NONE
        },
    ),
    (
        "AnchoredTextDeclinedEntry",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["v", "stamp", "declined"],
            members: &[
                ("declined", reference("ExtractionDeclinedReason")),
                (
                    "stamp",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        min_length: Some(1),
                        ..NONE
                    },
                ),
                (
                    "v",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        enumeration: Some(&[Listed::Number(3.0)]),
                        ..NONE
                    },
                ),
            ],
            closed: Some(&["declined", "stamp", "v"]),
            ..NONE
        },
    ),
    (
        "AnchoredTextEntries",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["checksums"],
            members: &[(
                "checksums",
                Shape {
                    kinds: Some(&[Kind::Array]),
                    items: Some(&Shape {
                        kinds: Some(&[Kind::String]),
                        pattern: Some(&[Step {
                            of: &[(48, 57), (97, 102)],
                            min: 64,
                            max: Some(64),
                        }]),
                        ..NONE
                    }),
                    ..NONE
                },
            )],
            closed: Some(&["checksums"]),
            ..NONE
        },
    ),
    (
        "AnchoredTextEntry",
        Shape {
            kinds: Some(&[Kind::Object]),
            one_of: &[
                reference("AnchoredTextExtractedEntry"),
                reference("AnchoredTextDeclinedEntry"),
            ],
            ..NONE
        },
    ),
    (
        "AnchoredTextExtractedEntry",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["v", "stamp", "text", "lines", "method"],
            members: &[
                (
                    "lines",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&Shape {
                            kinds: Some(&[Kind::Object]),
                            required: &["p", "y", "h", "words"],
                            members: &[
                                ("h", of(&[Kind::Number])),
                                ("p", of(&[Kind::Integer])),
                                (
                                    "words",
                                    Shape {
                                        kinds: Some(&[Kind::Array]),
                                        items: Some(&Shape {
                                            kinds: Some(&[Kind::Array]),
                                            min_items: Some(4),
                                            max_items: Some(4),
                                            items: Some(&of(&[Kind::Number])),
                                            ..NONE
                                        }),
                                        ..NONE
                                    },
                                ),
                                ("y", of(&[Kind::Number])),
                            ],
                            closed: Some(&["h", "p", "words", "y"]),
                            ..NONE
                        }),
                        ..NONE
                    },
                ),
                ("method", reference("ExtractionMethod")),
                ("ocrConfidence", reference("OcrConfidence")),
                ("pdfClass", reference("PdfClass")),
                (
                    "stamp",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        min_length: Some(1),
                        ..NONE
                    },
                ),
                ("text", of(&[Kind::String])),
                (
                    "unreadPages",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&of(&[Kind::Integer])),
                        ..NONE
                    },
                ),
                (
                    "v",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        enumeration: Some(&[Listed::Number(3.0)]),
                        ..NONE
                    },
                ),
            ],
            closed: Some(&[
                "lines",
                "method",
                "ocrConfidence",
                "pdfClass",
                "stamp",
                "text",
                "unreadPages",
                "v",
            ]),
            ..NONE
        },
    ),
    (
        "AnchoredTextStamp",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["stamp"],
            members: &[(
                "stamp",
                Shape {
                    kinds: Some(&[Kind::String]),
                    pattern: Some(&[Step {
                        of: &[
                            (0, 8),
                            (14, 31),
                            (33, 159),
                            (161, 5759),
                            (5761, 8191),
                            (8203, 8231),
                            (8234, 8238),
                            (8240, 8286),
                            (8288, 12287),
                            (12289, 65278),
                            (65280, 1114111),
                        ],
                        min: 1,
                        max: None,
                    }]),
                    min_length: Some(1),
                    ..NONE
                },
            )],
            closed: Some(&["stamp"]),
            ..NONE
        },
    ),
    (
        "AnchoredTextWrite",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["contentChecksum", "entry"],
            members: &[
                (
                    "contentChecksum",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        pattern: Some(&[Step {
                            of: &[(48, 57), (97, 102)],
                            min: 64,
                            max: Some(64),
                        }]),
                        ..NONE
                    },
                ),
                ("entry", reference("AnchoredTextEntry")),
            ],
            closed: Some(&["contentChecksum", "entry"]),
            ..NONE
        },
    ),
    (
        "Annotation",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["@context", "type", "id", "motivation", "target", "created"],
            members: &[
                (
                    "@context",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[Listed::Text("http://www.w3.org/ns/anno.jsonld")]),
                        ..NONE
                    },
                ),
                ("body", reference("AnnotationBodies")),
                ("created", of(&[Kind::String])),
                ("creator", reference("Agent")),
                ("generator", reference("OneOrMoreAgents")),
                ("id", reference("AnnotationId")),
                ("modified", of(&[Kind::String])),
                ("motivation", reference("Motivation")),
                (
                    "target",
                    Shape {
                        kinds: Some(&[Kind::Object, Kind::String]),
                        one_of: &[reference("ResourceId"), reference("AnnotationTarget")],
                        ..NONE
                    },
                ),
                (
                    "type",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[Listed::Text("Annotation")]),
                        ..NONE
                    },
                ),
                ("wasAttributedTo", reference("OneOrMoreAgents")),
            ],
            ..NONE
        },
    ),
    (
        "AnnotationAddedPayload",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["annotation"],
            members: &[
                ("annotation", reference("Annotation")),
                ("contentChecksum", of(&[Kind::String])),
            ],
            ..NONE
        },
    ),
    (
        "AnnotationBodies",
        Shape {
            kinds: Some(&[Kind::Object, Kind::Array]),
            one_of: &[
                reference("AnnotationBody"),
                Shape {
                    kinds: Some(&[Kind::Array]),
                    min_items: Some(1),
                    items: Some(&reference("AnnotationBody")),
                    ..NONE
                },
            ],
            ..NONE
        },
    ),
    (
        "AnnotationBody",
        Shape {
            kinds: Some(&[Kind::Object]),
            one_of: &[reference("TextualBody"), reference("SpecificResource")],
            discriminator: Some(Discriminator {
                property: "type",
                mapping: &[("TextualBody", 0), ("SpecificResource", 1)],
            }),
            ..NONE
        },
    ),
    (
        "AnnotationBodyUpdatedPayload",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["annotationId", "operations"],
            members: &[
                ("annotationId", reference("AnnotationId")),
                (
                    "operations",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&reference("BodyOperation")),
                        ..NONE
                    },
                ),
            ],
            ..NONE
        },
    ),
    (
        "AnnotationId",
        Shape {
            kinds: Some(&[Kind::String]),
            pattern: Some(&[Step {
                of: &[(45, 45), (48, 57), (65, 90), (95, 95), (97, 122)],
                min: 1,
                max: Some(128),
            }]),
            ..NONE
        },
    ),
    (
        "AnnotationRemovedPayload",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["annotationId"],
            members: &[("annotationId", reference("AnnotationId"))],
            ..NONE
        },
    ),
    (
        "AnnotationSelector",
        Shape {
            kinds: Some(&[Kind::Object, Kind::Array]),
            one_of: &[
                reference("Selector"),
                Shape {
                    kinds: Some(&[Kind::Array]),
                    items: Some(&reference("Selector")),
                    ..NONE
                },
            ],
            ..NONE
        },
    ),
    (
        "AnnotationTarget",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["source"],
            members: &[
                ("selector", reference("AnnotationSelector")),
                ("source", reference("ResourceId")),
                (
                    "type",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[Listed::Text("SpecificResource")]),
                        ..NONE
                    },
                ),
            ],
            ..NONE
        },
    ),
    (
        "ArchivistConfig",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &[
                "gatewayUrl",
                "identity",
                "root",
                "stateHome",
                "anchoredTextDir",
                "engines",
                "port",
                "skipRebuild",
                "staging",
                "logLevel",
                "logFormat",
            ],
            members: &[
                (
                    "anchoredTextDir",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        min_length: Some(1),
                        ..NONE
                    },
                ),
                ("engines", reference("ArchivistEngines")),
                (
                    "gatewayUrl",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        min_length: Some(1),
                        ..NONE
                    },
                ),
                ("identity", reference("ServiceIdentity")),
                ("logFormat", reference("LogFormat")),
                ("logLevel", reference("LogLevel")),
                (
                    "port",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        minimum: Some(1.0),
                        maximum: Some(65535.0),
                        ..NONE
                    },
                ),
                (
                    "root",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        min_length: Some(1),
                        ..NONE
                    },
                ),
                ("skipRebuild", of(&[Kind::Boolean])),
                (
                    "staging",
                    Shape {
                        kinds: Some(&[Kind::Object]),
                        required: &["flushMs", "maxWaitMs"],
                        members: &[
                            (
                                "flushMs",
                                Shape {
                                    kinds: Some(&[Kind::Integer]),
                                    minimum: Some(1.0),
                                    ..NONE
                                },
                            ),
                            (
                                "maxWaitMs",
                                Shape {
                                    kinds: Some(&[Kind::Integer]),
                                    minimum: Some(1.0),
                                    ..NONE
                                },
                            ),
                        ],
                        closed: Some(&["flushMs", "maxWaitMs"]),
                        ..NONE
                    },
                ),
                (
                    "stateHome",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        min_length: Some(1),
                        ..NONE
                    },
                ),
            ],
            closed: Some(&[
                "anchoredTextDir",
                "engines",
                "gatewayUrl",
                "identity",
                "logFormat",
                "logLevel",
                "port",
                "root",
                "skipRebuild",
                "staging",
                "stateHome",
            ]),
            ..NONE
        },
    ),
    (
        "ArchivistEngines",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["jobs", "actors"],
            members: &[
                (
                    "actors",
                    Shape {
                        kinds: Some(&[Kind::Object]),
                        members: &[
                            ("gatherer", reference("Engine")),
                            ("matcher", reference("Engine")),
                        ],
                        closed: Some(&["gatherer", "matcher"]),
                        ..NONE
                    },
                ),
                (
                    "jobs",
                    Shape {
                        kinds: Some(&[Kind::Object]),
                        members: &[
                            (
                                "mark",
                                Shape {
                                    kinds: Some(&[Kind::Object]),
                                    members: &[
                                        ("assessing", reference("Engine")),
                                        ("commenting", reference("Engine")),
                                        ("highlighting", reference("Engine")),
                                        ("linking", reference("Engine")),
                                        ("tagging", reference("Engine")),
                                    ],
                                    closed: Some(&[
                                        "assessing",
                                        "commenting",
                                        "highlighting",
                                        "linking",
                                        "tagging",
                                    ]),
                                    ..NONE
                                },
                            ),
                            ("yield", reference("Engine")),
                        ],
                        closed: Some(&["mark", "yield"]),
                        ..NONE
                    },
                ),
            ],
            closed: Some(&["actors", "jobs"]),
            ..NONE
        },
    ),
    (
        "ArchivistEventsResponse",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["events", "lastSequence"],
            members: &[
                (
                    "events",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&reference("StoredEventResponse")),
                        ..NONE
                    },
                ),
                (
                    "lastSequence",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        minimum: Some(0.0),
                        ..NONE
                    },
                ),
            ],
            ..NONE
        },
    ),
    (
        "ArchivistHealth",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["status", "actors"],
            members: &[
                (
                    "actors",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&of(&[Kind::String])),
                        ..NONE
                    },
                ),
                (
                    "status",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[Listed::Text("ok")]),
                        ..NONE
                    },
                ),
            ],
            ..NONE
        },
    ),
    (
        "ArchivistStream",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["resourceId", "lastSequence"],
            members: &[
                (
                    "lastSequence",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        minimum: Some(0.0),
                        ..NONE
                    },
                ),
                ("resourceId", reference("ResourceId")),
            ],
            closed: Some(&["lastSequence", "resourceId"]),
            ..NONE
        },
    ),
    (
        "ArchivistStreamsResponse",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["streams"],
            members: &[(
                "streams",
                Shape {
                    kinds: Some(&[Kind::Array]),
                    items: Some(&reference("ArchivistStream")),
                    ..NONE
                },
            )],
            closed: Some(&["streams"]),
            ..NONE
        },
    ),
    (
        "AssessingJobParams",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["motivation"],
            members: &[
                ("density", of(&[Kind::Number])),
                ("instructions", of(&[Kind::String])),
                ("language", of(&[Kind::String])),
                (
                    "motivation",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[Listed::Text("assessing")]),
                        ..NONE
                    },
                ),
                ("sourceLanguage", of(&[Kind::String])),
                (
                    "tone",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[
                            Listed::Text("analytical"),
                            Listed::Text("critical"),
                            Listed::Text("balanced"),
                            Listed::Text("constructive"),
                        ]),
                        ..NONE
                    },
                ),
            ],
            closed: Some(&[
                "density",
                "instructions",
                "language",
                "motivation",
                "sourceLanguage",
                "tone",
            ]),
            ..NONE
        },
    ),
    (
        "AttributedEvent",
        Shape {
            kinds: Some(&[Kind::Object]),
            all_of: &[
                reference("StoredEventResponse"),
                Shape {
                    kinds: Some(&[Kind::Object]),
                    required: &["agent"],
                    members: &[("agent", reference("Agent"))],
                    ..NONE
                },
            ],
            ..NONE
        },
    ),
    (
        "BeckonFocusEvent",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["resourceId"],
            members: &[
                ("annotationId", reference("AnnotationId")),
                ("resourceId", reference("ResourceId")),
            ],
            ..NONE
        },
    ),
    (
        "BeckonHoverEvent",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["annotationId"],
            members: &[(
                "annotationId",
                Shape {
                    kinds: Some(&[Kind::String, Kind::Null]),
                    one_of: &[of(&[Kind::Null]), reference("AnnotationId")],
                    ..NONE
                },
            )],
            ..NONE
        },
    ),
    (
        "BeckonSparkleEvent",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["annotationId"],
            members: &[("annotationId", reference("AnnotationId"))],
            ..NONE
        },
    ),
    (
        "BindBodyOperation",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["op"],
            members: &[
                ("item", reference("AnnotationBody")),
                ("newItem", reference("AnnotationBody")),
                ("oldItem", reference("AnnotationBody")),
                (
                    "op",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[
                            Listed::Text("add"),
                            Listed::Text("remove"),
                            Listed::Text("replace"),
                        ]),
                        ..NONE
                    },
                ),
            ],
            ..NONE
        },
    ),
    ("BindBodyUpdated", of(&[Kind::Object])),
    (
        "BindInitiateCommand",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["annotationId", "resourceId", "defaultTitle", "entityTypes"],
            members: &[
                ("annotationId", reference("AnnotationId")),
                ("defaultTitle", of(&[Kind::String])),
                (
                    "entityTypes",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&of(&[Kind::String])),
                        ..NONE
                    },
                ),
                ("resourceId", reference("ResourceId")),
            ],
            ..NONE
        },
    ),
    (
        "BindUpdateBodyCommand",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["annotationId", "resourceId", "operations"],
            members: &[
                ("_userId", reference("UserId")),
                ("annotationId", reference("AnnotationId")),
                (
                    "operations",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&reference("BindBodyOperation")),
                        ..NONE
                    },
                ),
                ("resourceId", reference("ResourceId")),
            ],
            ..NONE
        },
    ),
    (
        "BodyOperation",
        Shape {
            kinds: Some(&[Kind::Object]),
            one_of: &[
                reference("BodyOperationAdd"),
                reference("BodyOperationRemove"),
                reference("BodyOperationReplace"),
            ],
            ..NONE
        },
    ),
    (
        "BodyOperationAdd",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["op", "item"],
            members: &[
                ("item", reference("AnnotationBody")),
                (
                    "op",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[Listed::Text("add")]),
                        ..NONE
                    },
                ),
            ],
            ..NONE
        },
    ),
    (
        "BodyOperationRemove",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["op", "item"],
            members: &[
                ("item", reference("AnnotationBody")),
                (
                    "op",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[Listed::Text("remove")]),
                        ..NONE
                    },
                ),
            ],
            ..NONE
        },
    ),
    (
        "BodyOperationReplace",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["op", "oldItem", "newItem"],
            members: &[
                ("newItem", reference("AnnotationBody")),
                ("oldItem", reference("AnnotationBody")),
                (
                    "op",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[Listed::Text("replace")]),
                        ..NONE
                    },
                ),
            ],
            ..NONE
        },
    ),
    (
        "BodyPurpose",
        Shape {
            kinds: Some(&[Kind::String]),
            enumeration: Some(&[
                Listed::Text("assessing"),
                Listed::Text("bookmarking"),
                Listed::Text("classifying"),
                Listed::Text("commenting"),
                Listed::Text("describing"),
                Listed::Text("editing"),
                Listed::Text("highlighting"),
                Listed::Text("identifying"),
                Listed::Text("linking"),
                Listed::Text("moderating"),
                Listed::Text("questioning"),
                Listed::Text("replying"),
                Listed::Text("tagging"),
            ]),
            ..NONE
        },
    ),
    (
        "BrowseAnnotationHistoryRequest",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["resourceId", "annotationId"],
            members: &[
                ("annotationId", reference("AnnotationId")),
                ("resourceId", reference("ResourceId")),
            ],
            ..NONE
        },
    ),
    (
        "BrowseAnnotationHistoryResult",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["response"],
            members: &[("response", reference("GetAnnotationHistoryResponse"))],
            ..NONE
        },
    ),
    (
        "BrowseAnnotationRequest",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["resourceId", "annotationId"],
            members: &[
                ("annotationId", reference("AnnotationId")),
                ("resourceId", reference("ResourceId")),
            ],
            ..NONE
        },
    ),
    (
        "BrowseAnnotationResult",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["response"],
            members: &[("response", reference("GetAnnotationResponse"))],
            ..NONE
        },
    ),
    (
        "BrowseClickEvent",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["annotationId"],
            members: &[("annotationId", reference("AnnotationId"))],
            ..NONE
        },
    ),
    (
        "BrowseDirectoryFailed",
        Shape {
            kinds: Some(&[Kind::Object]),
            all_of: &[
                reference("CommandError"),
                Shape {
                    kinds: Some(&[Kind::Object]),
                    required: &["path"],
                    members: &[("path", of(&[Kind::String]))],
                    ..NONE
                },
            ],
            ..NONE
        },
    ),
    (
        "BrowseDirectoryRequest",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["path"],
            members: &[
                ("path", of(&[Kind::String])),
                (
                    "sort",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[
                            Listed::Text("name"),
                            Listed::Text("mtime"),
                            Listed::Text("annotationCount"),
                        ]),
                        ..NONE
                    },
                ),
            ],
            ..NONE
        },
    ),
    (
        "BrowseDirectoryResult",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["response"],
            members: &[("response", reference("BrowseDirectoryResultResponse"))],
            ..NONE
        },
    ),
    (
        "BrowseDirectoryResultResponse",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["path", "entries"],
            members: &[
                (
                    "entries",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&reference("DirectoryEntry")),
                        ..NONE
                    },
                ),
                ("path", of(&[Kind::String])),
            ],
            ..NONE
        },
    ),
    ("BrowseEnginesRequest", of(&[Kind::Object])),
    (
        "BrowseEnginesResult",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["response"],
            members: &[(
                "response",
                Shape {
                    kinds: Some(&[Kind::Object]),
                    required: &["engines"],
                    members: &[(
                        "engines",
                        Shape {
                            kinds: Some(&[Kind::Array]),
                            items: Some(&reference("EngineEntry")),
                            ..NONE
                        },
                    )],
                    ..NONE
                },
            )],
            ..NONE
        },
    ),
    (
        "BrowseEntityTypeClickedEvent",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["entityType"],
            members: &[("entityType", of(&[Kind::String]))],
            ..NONE
        },
    ),
    ("BrowseEntityTypesRequest", of(&[Kind::Object])),
    (
        "BrowseEntityTypesResult",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["response"],
            members: &[("response", reference("GetEntityTypesResponse"))],
            ..NONE
        },
    ),
    (
        "BrowseEventsRequest",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["resourceId"],
            members: &[
                ("limit", of(&[Kind::Integer])),
                ("resourceId", reference("ResourceId")),
                ("type", of(&[Kind::String])),
                ("userId", reference("UserId")),
            ],
            ..NONE
        },
    ),
    (
        "BrowseEventsResult",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["response"],
            members: &[("response", reference("GetEventsResponse"))],
            ..NONE
        },
    ),
    (
        "BrowseExternalNavigateEvent",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["url"],
            members: &[
                ("resourceId", reference("ResourceId")),
                ("url", of(&[Kind::String])),
            ],
            ..NONE
        },
    ),
    (
        "BrowseFilesResponse",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["path", "entries"],
            members: &[
                (
                    "entries",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&reference("DirectoryEntry")),
                        ..NONE
                    },
                ),
                ("path", of(&[Kind::String])),
            ],
            closed: Some(&["entries", "path"]),
            ..NONE
        },
    ),
    ("BrowseKbRequest", of(&[Kind::Object])),
    (
        "BrowseKbResult",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["response"],
            members: &[("response", reference("KbDescription"))],
            ..NONE
        },
    ),
    (
        "BrowseLinkClickedEvent",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["href"],
            members: &[
                ("href", of(&[Kind::String])),
                ("label", of(&[Kind::String])),
            ],
            ..NONE
        },
    ),
    (
        "BrowsePanelOpenEvent",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["panel"],
            members: &[
                ("motivation", reference("Motivation")),
                ("panel", of(&[Kind::String])),
                ("scrollToAnnotationId", reference("AnnotationId")),
            ],
            ..NONE
        },
    ),
    (
        "BrowsePanelToggleEvent",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["panel"],
            members: &[("panel", of(&[Kind::String]))],
            ..NONE
        },
    ),
    (
        "BrowseProfilesRequest",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["dids"],
            members: &[(
                "dids",
                Shape {
                    kinds: Some(&[Kind::Array]),
                    min_items: Some(1),
                    max_items: Some(500),
                    items: Some(&reference("UserId")),
                    ..NONE
                },
            )],
            closed: Some(&["dids"]),
            ..NONE
        },
    ),
    (
        "BrowseProfilesResult",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["response"],
            members: &[(
                "response",
                Shape {
                    kinds: Some(&[Kind::Object]),
                    required: &["profiles"],
                    members: &[(
                        "profiles",
                        Shape {
                            kinds: Some(&[Kind::Object]),
                            values: Some(&reference("Profile")),
                            ..NONE
                        },
                    )],
                    closed: Some(&["profiles"]),
                    ..NONE
                },
            )],
            ..NONE
        },
    ),
    (
        "BrowseResourceCloseEvent",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["resourceId"],
            members: &[("resourceId", reference("ResourceId"))],
            ..NONE
        },
    ),
    (
        "BrowseResourceOpenEvent",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["resourceId"],
            members: &[("resourceId", reference("ResourceId"))],
            ..NONE
        },
    ),
    (
        "BrowseResourceReorderEvent",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["oldIndex", "newIndex"],
            members: &[
                ("newIndex", of(&[Kind::Integer])),
                ("oldIndex", of(&[Kind::Integer])),
            ],
            ..NONE
        },
    ),
    (
        "BrowseResourceRequest",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["resourceId"],
            members: &[("resourceId", reference("ResourceId"))],
            ..NONE
        },
    ),
    (
        "BrowseResourceResult",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["response"],
            members: &[(
                "response",
                Shape {
                    kinds: Some(&[Kind::Object]),
                    required: &["resource", "lastSequence"],
                    members: &[
                        (
                            "lastSequence",
                            Shape {
                                kinds: Some(&[Kind::Integer]),
                                minimum: Some(1.0),
                                ..NONE
                            },
                        ),
                        ("resource", reference("ResourceDescriptor")),
                    ],
                    closed: Some(&["lastSequence", "resource"]),
                    ..NONE
                },
            )],
            ..NONE
        },
    ),
    (
        "BrowseResourceViewedEvent",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["resourceId"],
            members: &[("resourceId", reference("ResourceId"))],
            ..NONE
        },
    ),
    (
        "BrowseResourcesRequest",
        Shape {
            kinds: Some(&[Kind::Object]),
            members: &[
                ("archived", of(&[Kind::Boolean])),
                ("entityType", of(&[Kind::String])),
                (
                    "limit",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        minimum: Some(1.0),
                        ..NONE
                    },
                ),
                (
                    "offset",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        minimum: Some(0.0),
                        ..NONE
                    },
                ),
            ],
            ..NONE
        },
    ),
    (
        "BrowseResourcesResult",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["response"],
            members: &[("response", reference("ListResourcesResponse"))],
            ..NONE
        },
    ),
    (
        "BrowseRouterPushEvent",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["path"],
            members: &[
                ("path", of(&[Kind::String])),
                ("reason", of(&[Kind::String])),
            ],
            ..NONE
        },
    ),
    ("BrowseTagSchemasRequest", of(&[Kind::Object])),
    (
        "BrowseTagSchemasResult",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["response"],
            members: &[("response", reference("GetTagSchemasResponse"))],
            ..NONE
        },
    ),
    (
        "BusEmitAccepted",
        Shape {
            kinds: Some(&[Kind::Object]),
            members: &[(
                "subscribers",
                Shape {
                    kinds: Some(&[Kind::Integer]),
                    minimum: Some(0.0),
                    ..NONE
                },
            )],
            ..NONE
        },
    ),
    (
        "BusEmitRequest",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["channel", "payload"],
            members: &[
                (
                    "channel",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        min_length: Some(1),
                        ..NONE
                    },
                ),
                ("clientId", of(&[Kind::String])),
                (
                    "correlationId",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        min_length: Some(1),
                        ..NONE
                    },
                ),
                ("payload", of(&[Kind::Object])),
                ("scope", reference("ResourceId")),
            ],
            ..NONE
        },
    ),
    (
        "BusEventMessage",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["event", "id", "data"],
            members: &[
                ("data", reference("BusFrame")),
                (
                    "event",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[Listed::Text("bus-event")]),
                        ..NONE
                    },
                ),
                (
                    "id",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        one_of: &[
                            reference("PersistedEventId"),
                            reference("ReplyEventId"),
                            reference("EphemeralEventId"),
                        ],
                        ..NONE
                    },
                ),
            ],
            closed: Some(&["data", "event", "id"]),
            ..NONE
        },
    ),
    (
        "BusFrame",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["channel", "payload"],
            members: &[
                (
                    "channel",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        min_length: Some(1),
                        ..NONE
                    },
                ),
                (
                    "correlationId",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        min_length: Some(1),
                        ..NONE
                    },
                ),
                ("payload", of(&[Kind::Object])),
                ("scope", reference("ResourceId")),
            ],
            closed: Some(&["channel", "correlationId", "payload", "scope"]),
            ..NONE
        },
    ),
    (
        "BusPingMessage",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["event", "data"],
            members: &[
                (
                    "data",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        max_length: Some(0),
                        ..NONE
                    },
                ),
                (
                    "event",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[Listed::Text("ping")]),
                        ..NONE
                    },
                ),
            ],
            closed: Some(&["data", "event"]),
            ..NONE
        },
    ),
    (
        "BusResumeGap",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["scope", "lastSeenId", "reason"],
            members: &[
                ("lastSeenId", of(&[Kind::String])),
                (
                    "reason",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[
                            Listed::Text("unparseable-last-event-id"),
                            Listed::Text("scope-mismatch"),
                            Listed::Text("retention-exceeded"),
                            Listed::Text("query-error"),
                        ]),
                        ..NONE
                    },
                ),
                ("scope", reference("ResourceId")),
            ],
            closed: Some(&["lastSeenId", "reason", "scope"]),
            ..NONE
        },
    ),
    (
        "BusStreamMessage",
        Shape {
            kinds: Some(&[Kind::Object]),
            one_of: &[reference("BusEventMessage"), reference("BusPingMessage")],
            ..NONE
        },
    ),
    (
        "BusSubscribeRequest",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["clientId"],
            members: &[
                (
                    "clientId",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        min_length: Some(1),
                        ..NONE
                    },
                ),
                (
                    "global",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&Shape {
                            kinds: Some(&[Kind::String]),
                            min_length: Some(1),
                            ..NONE
                        }),
                        ..NONE
                    },
                ),
                (
                    "pendingReplies",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        max_items: Some(256),
                        items: Some(&Shape {
                            kinds: Some(&[Kind::String]),
                            min_length: Some(1),
                            ..NONE
                        }),
                        ..NONE
                    },
                ),
                (
                    "scoped",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        max_items: Some(512),
                        items: Some(&Shape {
                            kinds: Some(&[Kind::Object]),
                            required: &["scope", "channels"],
                            members: &[
                                (
                                    "channels",
                                    Shape {
                                        kinds: Some(&[Kind::Array]),
                                        min_items: Some(1),
                                        items: Some(&Shape {
                                            kinds: Some(&[Kind::String]),
                                            min_length: Some(1),
                                            ..NONE
                                        }),
                                        ..NONE
                                    },
                                ),
                                ("lastEventId", of(&[Kind::String])),
                                ("scope", reference("ResourceId")),
                            ],
                            closed: Some(&["channels", "lastEventId", "scope"]),
                            ..NONE
                        }),
                        ..NONE
                    },
                ),
            ],
            closed: Some(&["clientId", "global", "pendingReplies", "scoped"]),
            ..NONE
        },
    ),
    (
        "CloneResourceWithTokenResponse",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["token", "expiresAt", "resource"],
            members: &[
                ("expiresAt", of(&[Kind::String])),
                ("resource", reference("ResourceDescriptor")),
                ("token", of(&[Kind::String])),
            ],
            ..NONE
        },
    ),
    (
        "CommandError",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["message"],
            members: &[
                (
                    "code",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        recognized: Some(&[
                            "peer-unavailable",
                            "not-found",
                            "unauthorized",
                            "none-pending",
                        ]),
                        ..NONE
                    },
                ),
                ("details", of(&[Kind::String])),
                ("message", of(&[Kind::String])),
            ],
            ..NONE
        },
    ),
    (
        "CommentingJobParams",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["motivation"],
            members: &[
                ("density", of(&[Kind::Number])),
                ("instructions", of(&[Kind::String])),
                ("language", of(&[Kind::String])),
                (
                    "motivation",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[Listed::Text("commenting")]),
                        ..NONE
                    },
                ),
                ("sourceLanguage", of(&[Kind::String])),
                (
                    "tone",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[
                            Listed::Text("scholarly"),
                            Listed::Text("explanatory"),
                            Listed::Text("conversational"),
                            Listed::Text("technical"),
                        ]),
                        ..NONE
                    },
                ),
            ],
            closed: Some(&[
                "density",
                "instructions",
                "language",
                "motivation",
                "sourceLanguage",
                "tone",
            ]),
            ..NONE
        },
    ),
    ("ContentFormat", of(&[Kind::String])),
    (
        "ContextualSummaryResponse",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["summary", "relevantFields", "context"],
            members: &[
                (
                    "context",
                    Shape {
                        kinds: Some(&[Kind::Object]),
                        required: &["selected"],
                        members: &[
                            ("after", of(&[Kind::String])),
                            ("before", of(&[Kind::String])),
                            ("selected", of(&[Kind::String])),
                        ],
                        ..NONE
                    },
                ),
                (
                    "relevantFields",
                    Shape {
                        kinds: Some(&[Kind::Object]),
                        required: &["resourceId", "resourceName", "entityTypes"],
                        members: &[
                            (
                                "entityTypes",
                                Shape {
                                    kinds: Some(&[Kind::Array]),
                                    items: Some(&of(&[Kind::String])),
                                    ..NONE
                                },
                            ),
                            ("resourceId", reference("ResourceId")),
                            ("resourceName", of(&[Kind::String])),
                        ],
                        closed: Some(&["entityTypes", "resourceId", "resourceName"]),
                        ..NONE
                    },
                ),
                ("summary", of(&[Kind::String])),
            ],
            ..NONE
        },
    ),
    (
        "CreateAnnotationRequest",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["target", "motivation"],
            members: &[
                ("body", reference("AnnotationBodies")),
                ("motivation", reference("Motivation")),
                ("target", reference("AnnotationTarget")),
            ],
            ..NONE
        },
    ),
    (
        "CreateResourceResponse",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["resourceId"],
            members: &[("resourceId", reference("ResourceId"))],
            ..NONE
        },
    ),
    (
        "CursorsPath",
        Shape {
            kinds: Some(&[Kind::String]),
            min_length: Some(1),
            ..NONE
        },
    ),
    (
        "DirEntry",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["type", "name", "path", "mtime"],
            members: &[
                ("mtime", of(&[Kind::String])),
                ("name", of(&[Kind::String])),
                ("path", of(&[Kind::String])),
                (
                    "type",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[Listed::Text("dir")]),
                        ..NONE
                    },
                ),
            ],
            closed: Some(&["mtime", "name", "path", "type"]),
            ..NONE
        },
    ),
    (
        "DirectoryEntry",
        Shape {
            kinds: Some(&[Kind::Object]),
            one_of: &[reference("FileEntry"), reference("DirEntry")],
            discriminator: Some(Discriminator {
                property: "type",
                mapping: &[("file", 0), ("dir", 1)],
            }),
            ..NONE
        },
    ),
    (
        "DiscoveredKB",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["host", "port", "placement", "did", "managedBy"],
            members: &[
                ("did", of(&[Kind::String])),
                ("host", of(&[Kind::String])),
                ("managedBy", of(&[Kind::String])),
                (
                    "placement",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[Listed::Text("local"), Listed::Text("codespace")]),
                        ..NONE
                    },
                ),
                ("port", of(&[Kind::Integer])),
                ("repo", of(&[Kind::String])),
                ("siteName", of(&[Kind::String])),
            ],
            ..NONE
        },
    ),
    (
        "DiscoveryDocument",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["version", "kbs"],
            members: &[
                (
                    "kbs",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&reference("DiscoveredKB")),
                        ..NONE
                    },
                ),
                (
                    "version",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        enumeration: Some(&[Listed::Number(1.0)]),
                        ..NONE
                    },
                ),
            ],
            ..NONE
        },
    ),
    (
        "DispatcherConfig",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &[
                "kb",
                "gatewayUrl",
                "identity",
                "queue",
                "port",
                "timing",
                "logLevel",
                "logFormat",
            ],
            members: &[
                (
                    "gatewayUrl",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        min_length: Some(1),
                        ..NONE
                    },
                ),
                ("identity", reference("ServiceIdentity")),
                ("kb", reference("KbIdentity")),
                ("logFormat", reference("LogFormat")),
                ("logLevel", reference("LogLevel")),
                (
                    "port",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        minimum: Some(1.0),
                        maximum: Some(65535.0),
                        ..NONE
                    },
                ),
                (
                    "queue",
                    Shape {
                        kinds: Some(&[Kind::Object]),
                        required: &["servers"],
                        members: &[
                            (
                                "passwordEnv",
                                Shape {
                                    kinds: Some(&[Kind::String]),
                                    min_length: Some(1),
                                    ..NONE
                                },
                            ),
                            (
                                "servers",
                                Shape {
                                    kinds: Some(&[Kind::String]),
                                    min_length: Some(1),
                                    ..NONE
                                },
                            ),
                            (
                                "userEnv",
                                Shape {
                                    kinds: Some(&[Kind::String]),
                                    min_length: Some(1),
                                    ..NONE
                                },
                            ),
                        ],
                        closed: Some(&["passwordEnv", "servers", "userEnv"]),
                        ..NONE
                    },
                ),
                (
                    "timing",
                    Shape {
                        kinds: Some(&[Kind::Object]),
                        required: &[
                            "tickMs",
                            "staleRunningMs",
                            "ackWaitMs",
                            "retentionMs",
                            "retentionSweepMs",
                            "progressWriteIntervalMs",
                            "bootDeadlineMs",
                        ],
                        members: &[
                            (
                                "ackWaitMs",
                                Shape {
                                    kinds: Some(&[Kind::Integer]),
                                    minimum: Some(1.0),
                                    ..NONE
                                },
                            ),
                            (
                                "bootDeadlineMs",
                                Shape {
                                    kinds: Some(&[Kind::Integer]),
                                    minimum: Some(1.0),
                                    ..NONE
                                },
                            ),
                            (
                                "progressWriteIntervalMs",
                                Shape {
                                    kinds: Some(&[Kind::Integer]),
                                    minimum: Some(1.0),
                                    ..NONE
                                },
                            ),
                            (
                                "retentionMs",
                                Shape {
                                    kinds: Some(&[Kind::Integer]),
                                    minimum: Some(1.0),
                                    ..NONE
                                },
                            ),
                            (
                                "retentionSweepMs",
                                Shape {
                                    kinds: Some(&[Kind::Integer]),
                                    minimum: Some(1.0),
                                    ..NONE
                                },
                            ),
                            (
                                "staleRunningMs",
                                Shape {
                                    kinds: Some(&[Kind::Integer]),
                                    minimum: Some(1.0),
                                    ..NONE
                                },
                            ),
                            (
                                "tickMs",
                                Shape {
                                    kinds: Some(&[Kind::Integer]),
                                    minimum: Some(1.0),
                                    ..NONE
                                },
                            ),
                        ],
                        closed: Some(&[
                            "ackWaitMs",
                            "bootDeadlineMs",
                            "progressWriteIntervalMs",
                            "retentionMs",
                            "retentionSweepMs",
                            "staleRunningMs",
                            "tickMs",
                        ]),
                        ..NONE
                    },
                ),
            ],
            closed: Some(&[
                "gatewayUrl",
                "identity",
                "kb",
                "logFormat",
                "logLevel",
                "port",
                "queue",
                "timing",
            ]),
            ..NONE
        },
    ),
    (
        "DispatcherHealth",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["status", "queue"],
            members: &[
                (
                    "queue",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[Listed::Text("jetstream")]),
                        ..NONE
                    },
                ),
                (
                    "status",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[Listed::Text("ok")]),
                        ..NONE
                    },
                ),
            ],
            closed: Some(&["queue", "status"]),
            ..NONE
        },
    ),
    (
        "DurabilityEvidence",
        Shape {
            kinds: Some(&[Kind::String]),
            enumeration: Some(&[
                Listed::Text("acknowledged"),
                Listed::Text("probe-confirmed"),
                Listed::Text("probe-refused"),
                Listed::Text("probe-unreachable"),
            ]),
            ..NONE
        },
    ),
    (
        "EmbeddingConfig",
        Shape {
            kinds: Some(&[Kind::Object]),
            one_of: &[
                reference("OllamaEmbeddingConfig"),
                reference("VoyageEmbeddingConfig"),
            ],
            discriminator: Some(Discriminator {
                property: "type",
                mapping: &[("ollama", 0), ("voyage", 1)],
            }),
            ..NONE
        },
    ),
    (
        "Engine",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["provider", "model"],
            members: &[
                (
                    "model",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        min_length: Some(1),
                        ..NONE
                    },
                ),
                (
                    "provider",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[
                            Listed::Text("anthropic"),
                            Listed::Text("google"),
                            Listed::Text("llamacpp"),
                            Listed::Text("ollama"),
                            Listed::Text("openai"),
                            Listed::Text("together"),
                            Listed::Text("vllm"),
                        ]),
                        ..NONE
                    },
                ),
            ],
            closed: Some(&["model", "provider"]),
            ..NONE
        },
    ),
    (
        "EngineEntry",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["engine"],
            members: &[
                ("engine", reference("Engine")),
                (
                    "jobs",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&reference("JobFilter")),
                        ..NONE
                    },
                ),
            ],
            closed: Some(&["engine", "jobs"]),
            ..NONE
        },
    ),
    (
        "EngineLimits",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["engine", "limits"],
            members: &[
                ("engine", reference("Engine")),
                ("limits", reference("InferenceLimits")),
            ],
            closed: Some(&["engine", "limits"]),
            ..NONE
        },
    ),
    (
        "EnrichedResourceEvent",
        Shape {
            kinds: Some(&[Kind::Object]),
            all_of: &[
                reference("StoredEventResponse"),
                Shape {
                    kinds: Some(&[Kind::Object]),
                    members: &[("annotation", reference("Annotation"))],
                    ..NONE
                },
            ],
            ..NONE
        },
    ),
    (
        "EntityTagChangedPayload",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["entityType"],
            members: &[("entityType", of(&[Kind::String]))],
            ..NONE
        },
    ),
    (
        "EntityTypeAddedPayload",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["entityType"],
            members: &[("entityType", of(&[Kind::String]))],
            ..NONE
        },
    ),
    (
        "EntityTypesProjection",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["entityTypes"],
            members: &[(
                "entityTypes",
                Shape {
                    kinds: Some(&[Kind::Array]),
                    items: Some(&of(&[Kind::String])),
                    ..NONE
                },
            )],
            closed: Some(&["entityTypes"]),
            ..NONE
        },
    ),
    (
        "EphemeralEventId",
        Shape {
            kinds: Some(&[Kind::String]),
            pattern: Some(&[
                Step {
                    of: &[(101, 101)],
                    min: 1,
                    max: Some(1),
                },
                Step {
                    of: &[(45, 45)],
                    min: 1,
                    max: Some(1),
                },
                Step {
                    of: &[(0, 57), (59, 1114111)],
                    min: 1,
                    max: None,
                },
            ]),
            ..NONE
        },
    ),
    (
        "ErrorResponse",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["error"],
            members: &[
                ("code", of(&[Kind::String])),
                ("error", of(&[Kind::String])),
                ("hint", of(&[Kind::String])),
            ],
            ..NONE
        },
    ),
    (
        "EventMetadata",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["sequenceNumber"],
            members: &[("sequenceNumber", of(&[Kind::Integer]))],
            ..NONE
        },
    ),
    (
        "ExtractedText",
        Shape {
            kinds: Some(&[Kind::Object]),
            all_of: &[
                reference("AnchoredText"),
                Shape {
                    kinds: Some(&[Kind::Object]),
                    required: &["kind", "method"],
                    members: &[
                        (
                            "kind",
                            Shape {
                                kinds: Some(&[Kind::String]),
                                enumeration: Some(&[Listed::Text("extracted")]),
                                ..NONE
                            },
                        ),
                        ("method", reference("ExtractionMethod")),
                        ("ocrConfidence", reference("OcrConfidence")),
                        ("pdfClass", reference("PdfClass")),
                        (
                            "unreadPages",
                            Shape {
                                kinds: Some(&[Kind::Array]),
                                items: Some(&of(&[Kind::Integer])),
                                ..NONE
                            },
                        ),
                    ],
                    ..NONE
                },
            ],
            ..NONE
        },
    ),
    (
        "ExtractionDeclined",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["kind", "declined"],
            members: &[
                ("declined", reference("ExtractionDeclinedReason")),
                (
                    "kind",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[Listed::Text("declined")]),
                        ..NONE
                    },
                ),
            ],
            ..NONE
        },
    ),
    (
        "ExtractionDeclinedReason",
        Shape {
            kinds: Some(&[Kind::String]),
            enumeration: Some(&[
                Listed::Text("no-text-layer"),
                Listed::Text("encrypted"),
                Listed::Text("corrupt"),
                Listed::Text("too-large"),
            ]),
            ..NONE
        },
    ),
    (
        "ExtractionMethod",
        Shape {
            kinds: Some(&[Kind::String]),
            enumeration: Some(&[
                Listed::Text("text-passthrough"),
                Listed::Text("pdf-text-layer"),
                Listed::Text("table"),
                Listed::Text("form"),
                Listed::Text("ocr"),
            ]),
            ..NONE
        },
    ),
    (
        "ExtractionOutcome",
        Shape {
            kinds: Some(&[Kind::Object]),
            one_of: &[reference("ExtractedText"), reference("ExtractionDeclined")],
            discriminator: Some(Discriminator {
                property: "kind",
                mapping: &[("extracted", 0), ("declined", 1)],
            }),
            ..NONE
        },
    ),
    (
        "FailureClass",
        Shape {
            kinds: Some(&[Kind::String]),
            enumeration: Some(&[
                Listed::Text("transient"),
                Listed::Text("deterministic"),
                Listed::Text("withheld"),
            ]),
            ..NONE
        },
    ),
    (
        "FileEntry",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["type", "name", "path", "size", "mtime", "tracked"],
            members: &[
                ("annotationCount", of(&[Kind::Integer])),
                ("creator", of(&[Kind::String])),
                (
                    "entityTypes",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&of(&[Kind::String])),
                        ..NONE
                    },
                ),
                ("mtime", of(&[Kind::String])),
                ("name", of(&[Kind::String])),
                ("path", of(&[Kind::String])),
                ("resourceId", reference("ResourceId")),
                ("size", of(&[Kind::Integer])),
                ("tracked", of(&[Kind::Boolean])),
                (
                    "type",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[Listed::Text("file")]),
                        ..NONE
                    },
                ),
            ],
            closed: Some(&[
                "annotationCount",
                "creator",
                "entityTypes",
                "mtime",
                "name",
                "path",
                "resourceId",
                "size",
                "tracked",
                "type",
            ]),
            ..NONE
        },
    ),
    (
        "FragmentSelector",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["type", "value"],
            members: &[
                ("conformsTo", of(&[Kind::String])),
                (
                    "type",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[Listed::Text("FragmentSelector")]),
                        ..NONE
                    },
                ),
                ("value", of(&[Kind::String])),
            ],
            ..NONE
        },
    ),
    (
        "FrameAddEntityTypeCommand",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["tag"],
            members: &[
                ("_userId", reference("UserId")),
                ("tag", of(&[Kind::String])),
            ],
            ..NONE
        },
    ),
    (
        "FrameAddTagSchemaCommand",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["schema"],
            members: &[
                ("_userId", reference("UserId")),
                ("schema", reference("TagSchema")),
            ],
            ..NONE
        },
    ),
    (
        "GatewayConfig",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &[
                "kb",
                "port",
                "publicUrl",
                "identity",
                "archivist",
                "signal",
                "logLevel",
                "logFormat",
                "capacity",
            ],
            members: &[
                ("archivist", reference("ServiceAddress")),
                (
                    "capacity",
                    Shape {
                        kinds: Some(&[Kind::Object]),
                        required: &["queuedBytes", "connections"],
                        members: &[
                            (
                                "connections",
                                Shape {
                                    kinds: Some(&[Kind::Integer]),
                                    minimum: Some(1.0),
                                    ..NONE
                                },
                            ),
                            (
                                "queuedBytes",
                                Shape {
                                    kinds: Some(&[Kind::Integer]),
                                    minimum: Some(1.0),
                                    ..NONE
                                },
                            ),
                        ],
                        closed: Some(&["connections", "queuedBytes"]),
                        ..NONE
                    },
                ),
                (
                    "identity",
                    Shape {
                        kinds: Some(&[Kind::Object]),
                        required: &["issuer", "subjectClaim"],
                        members: &[
                            (
                                "issuer",
                                Shape {
                                    kinds: Some(&[Kind::String]),
                                    min_length: Some(1),
                                    ..NONE
                                },
                            ),
                            (
                                "subjectClaim",
                                Shape {
                                    kinds: Some(&[Kind::String]),
                                    min_length: Some(1),
                                    ..NONE
                                },
                            ),
                        ],
                        closed: Some(&["issuer", "subjectClaim"]),
                        ..NONE
                    },
                ),
                ("kb", reference("KbIdentity")),
                ("logFormat", reference("LogFormat")),
                ("logLevel", reference("LogLevel")),
                (
                    "port",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        minimum: Some(1.0),
                        maximum: Some(65535.0),
                        ..NONE
                    },
                ),
                (
                    "publicUrl",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        min_length: Some(1),
                        ..NONE
                    },
                ),
                (
                    "signal",
                    Shape {
                        kinds: Some(&[Kind::Object]),
                        required: &["type"],
                        members: &[
                            (
                                "passwordEnv",
                                Shape {
                                    kinds: Some(&[Kind::String]),
                                    min_length: Some(1),
                                    ..NONE
                                },
                            ),
                            (
                                "servers",
                                Shape {
                                    kinds: Some(&[Kind::String]),
                                    min_length: Some(1),
                                    ..NONE
                                },
                            ),
                            (
                                "type",
                                Shape {
                                    kinds: Some(&[Kind::String]),
                                    enumeration: Some(&[
                                        Listed::Text("in-process"),
                                        Listed::Text("nats"),
                                    ]),
                                    ..NONE
                                },
                            ),
                            (
                                "userEnv",
                                Shape {
                                    kinds: Some(&[Kind::String]),
                                    min_length: Some(1),
                                    ..NONE
                                },
                            ),
                        ],
                        closed: Some(&["passwordEnv", "servers", "type", "userEnv"]),
                        ..NONE
                    },
                ),
            ],
            closed: Some(&[
                "archivist",
                "capacity",
                "identity",
                "kb",
                "logFormat",
                "logLevel",
                "port",
                "publicUrl",
                "signal",
            ]),
            ..NONE
        },
    ),
    (
        "GatherAnnotationComplete",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["annotationId", "response"],
            members: &[
                ("annotationId", reference("AnnotationId")),
                ("response", reference("GatheredContext")),
            ],
            ..NONE
        },
    ),
    (
        "GatherAnnotationOptions",
        Shape {
            kinds: Some(&[Kind::Object]),
            members: &[
                (
                    "contextWindow",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        minimum: Some(100.0),
                        maximum: Some(5000.0),
                        ..NONE
                    },
                ),
                ("includeSourceContext", of(&[Kind::Boolean])),
                ("includeTargetContext", of(&[Kind::Boolean])),
            ],
            ..NONE
        },
    ),
    (
        "GatherAnnotationRequest",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["annotationId", "resourceId"],
            members: &[
                ("annotationId", reference("AnnotationId")),
                ("options", reference("GatherAnnotationOptions")),
                ("resourceId", reference("ResourceId")),
            ],
            ..NONE
        },
    ),
    (
        "GatherFailed",
        Shape {
            kinds: Some(&[Kind::Object]),
            all_of: &[
                reference("CommandError"),
                Shape {
                    kinds: Some(&[Kind::Object]),
                    required: &["annotationId"],
                    members: &[("annotationId", reference("AnnotationId"))],
                    ..NONE
                },
            ],
            ..NONE
        },
    ),
    (
        "GatherReferencedByRequest",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["resourceId"],
            members: &[
                ("motivation", reference("Motivation")),
                ("resourceId", reference("ResourceId")),
            ],
            ..NONE
        },
    ),
    (
        "GatherReferencedByResult",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["response"],
            members: &[("response", reference("GetReferencedByResponse"))],
            ..NONE
        },
    ),
    (
        "GatherResourceComplete",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["resourceId", "response"],
            members: &[
                ("resourceId", reference("ResourceId")),
                ("response", reference("GatheredContext")),
            ],
            ..NONE
        },
    ),
    (
        "GatherResourceFailed",
        Shape {
            kinds: Some(&[Kind::Object]),
            all_of: &[
                reference("CommandError"),
                Shape {
                    kinds: Some(&[Kind::Object]),
                    required: &["resourceId"],
                    members: &[("resourceId", reference("ResourceId"))],
                    ..NONE
                },
            ],
            ..NONE
        },
    ),
    (
        "GatherResourceRequest",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["resourceId", "options"],
            members: &[
                ("options", reference("GatherResourceRequestOptions")),
                ("resourceId", reference("ResourceId")),
            ],
            ..NONE
        },
    ),
    (
        "GatherResourceRequestOptions",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["depth", "maxResources", "includeContent", "includeSummary"],
            members: &[
                (
                    "depth",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        minimum: Some(1.0),
                        maximum: Some(3.0),
                        ..NONE
                    },
                ),
                (
                    "excludeEntityTypes",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&of(&[Kind::String])),
                        ..NONE
                    },
                ),
                ("includeContent", of(&[Kind::Boolean])),
                ("includeSummary", of(&[Kind::Boolean])),
                (
                    "maxResources",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        minimum: Some(1.0),
                        maximum: Some(200.0),
                        ..NONE
                    },
                ),
            ],
            ..NONE
        },
    ),
    (
        "GatherSummaryRequest",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["annotationId", "resourceId"],
            members: &[
                ("annotationId", reference("AnnotationId")),
                ("resourceId", reference("ResourceId")),
            ],
            ..NONE
        },
    ),
    (
        "GatheredContext",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["focus", "graph", "metadata"],
            members: &[
                (
                    "focus",
                    Shape {
                        kinds: Some(&[Kind::Object]),
                        one_of: &[
                            Shape {
                                kinds: Some(&[Kind::Object]),
                                required: &["kind", "annotation", "sourceResource"],
                                members: &[
                                    ("annotation", reference("Annotation")),
                                    (
                                        "kind",
                                        Shape {
                                            kinds: Some(&[Kind::String]),
                                            enumeration: Some(&[Listed::Text("annotation")]),
                                            ..NONE
                                        },
                                    ),
                                    (
                                        "selected",
                                        Shape {
                                            kinds: Some(&[Kind::Object]),
                                            required: &["text"],
                                            members: &[
                                                ("after", of(&[Kind::String])),
                                                ("before", of(&[Kind::String])),
                                                ("text", of(&[Kind::String])),
                                            ],
                                            ..NONE
                                        },
                                    ),
                                    ("sourceResource", reference("ResourceDescriptor")),
                                    (
                                        "targetContext",
                                        Shape {
                                            kinds: Some(&[Kind::Object]),
                                            required: &["content"],
                                            members: &[
                                                ("content", of(&[Kind::String])),
                                                ("summary", of(&[Kind::String])),
                                            ],
                                            ..NONE
                                        },
                                    ),
                                    ("targetResource", reference("ResourceDescriptor")),
                                    ("userHint", of(&[Kind::String])),
                                ],
                                ..NONE
                            },
                            Shape {
                                kinds: Some(&[Kind::Object]),
                                required: &["kind", "resource"],
                                members: &[
                                    (
                                        "content",
                                        Shape {
                                            kinds: Some(&[Kind::Object]),
                                            members: &[
                                                ("main", of(&[Kind::String])),
                                                (
                                                    "related",
                                                    Shape {
                                                        kinds: Some(&[Kind::Object]),
                                                        values: Some(&of(&[Kind::String])),
                                                        ..NONE
                                                    },
                                                ),
                                            ],
                                            ..NONE
                                        },
                                    ),
                                    (
                                        "kind",
                                        Shape {
                                            kinds: Some(&[Kind::String]),
                                            enumeration: Some(&[Listed::Text("resource")]),
                                            ..NONE
                                        },
                                    ),
                                    ("resource", reference("ResourceDescriptor")),
                                    (
                                        "suggestedReferences",
                                        Shape {
                                            kinds: Some(&[Kind::Array]),
                                            items: Some(&of(&[Kind::String])),
                                            ..NONE
                                        },
                                    ),
                                    ("summary", of(&[Kind::String])),
                                ],
                                ..NONE
                            },
                        ],
                        ..NONE
                    },
                ),
                ("graph", reference("KnowledgeGraph")),
                ("inferredRelationshipSummary", of(&[Kind::String])),
                (
                    "metadata",
                    Shape {
                        kinds: Some(&[Kind::Object]),
                        members: &[
                            (
                                "entityTypeFrequencies",
                                Shape {
                                    kinds: Some(&[Kind::Object]),
                                    values: Some(&of(&[Kind::Integer])),
                                    ..NONE
                                },
                            ),
                            (
                                "entityTypes",
                                Shape {
                                    kinds: Some(&[Kind::Array]),
                                    items: Some(&of(&[Kind::String])),
                                    ..NONE
                                },
                            ),
                            ("language", of(&[Kind::String])),
                            ("resourceType", of(&[Kind::String])),
                        ],
                        ..NONE
                    },
                ),
                (
                    "semanticContext",
                    Shape {
                        kinds: Some(&[Kind::Object]),
                        required: &["similar"],
                        members: &[
                            (
                                "excludedEntityTypes",
                                Shape {
                                    kinds: Some(&[Kind::Array]),
                                    items: Some(&of(&[Kind::String])),
                                    ..NONE
                                },
                            ),
                            (
                                "similar",
                                Shape {
                                    kinds: Some(&[Kind::Array]),
                                    items: Some(&reference("SemanticMatch")),
                                    ..NONE
                                },
                            ),
                        ],
                        ..NONE
                    },
                ),
            ],
            ..NONE
        },
    ),
    (
        "GenerationJobParams",
        Shape {
            kinds: Some(&[Kind::Object]),
            all_of: &[
                reference("GenerationJobRequest"),
                Shape {
                    kinds: Some(&[Kind::Object]),
                    required: &["context"],
                    members: &[("context", reference("GatheredContext"))],
                    ..NONE
                },
            ],
            ..NONE
        },
    ),
    (
        "GenerationJobRequest",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["title", "storageUri"],
            members: &[
                ("cite", of(&[Kind::Boolean])),
                (
                    "entityTypes",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&of(&[Kind::String])),
                        ..NONE
                    },
                ),
                ("language", of(&[Kind::String])),
                ("maxTokens", of(&[Kind::Number])),
                ("outputMediaType", reference("SupportedMediaType")),
                ("prompt", of(&[Kind::String])),
                ("sourceLanguage", of(&[Kind::String])),
                (
                    "storageUri",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        min_length: Some(1),
                        ..NONE
                    },
                ),
                ("structure", of(&[Kind::String])),
                ("task", of(&[Kind::String])),
                ("temperature", of(&[Kind::Number])),
                (
                    "title",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        min_length: Some(1),
                        ..NONE
                    },
                ),
            ],
            ..NONE
        },
    ),
    (
        "GetAnnotationHistoryResponse",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["events", "total", "annotationId", "resourceId"],
            members: &[
                ("annotationId", reference("AnnotationId")),
                (
                    "events",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&reference("AttributedEvent")),
                        ..NONE
                    },
                ),
                ("resourceId", reference("ResourceId")),
                ("total", of(&[Kind::Number])),
            ],
            ..NONE
        },
    ),
    (
        "GetAnnotationResponse",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["annotation", "resource", "resolvedResource"],
            members: &[
                ("annotation", reference("Annotation")),
                (
                    "resolvedResource",
                    Shape {
                        kinds: Some(&[Kind::Object, Kind::Null]),
                        one_of: &[of(&[Kind::Null]), reference("ResourceDescriptor")],
                        ..NONE
                    },
                ),
                (
                    "resource",
                    Shape {
                        kinds: Some(&[Kind::Object, Kind::Null]),
                        one_of: &[of(&[Kind::Null]), reference("ResourceDescriptor")],
                        ..NONE
                    },
                ),
            ],
            ..NONE
        },
    ),
    (
        "GetAnnotationsResponse",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["annotations", "total"],
            members: &[
                (
                    "annotations",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&reference("Annotation")),
                        ..NONE
                    },
                ),
                (
                    "motivation",
                    Shape {
                        kinds: Some(&[Kind::String, Kind::Null]),
                        one_of: &[of(&[Kind::Null]), reference("Motivation")],
                        ..NONE
                    },
                ),
                ("total", of(&[Kind::Number])),
            ],
            ..NONE
        },
    ),
    (
        "GetEntityTypesResponse",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["entityTypes"],
            members: &[(
                "entityTypes",
                Shape {
                    kinds: Some(&[Kind::Array]),
                    items: Some(&of(&[Kind::String])),
                    ..NONE
                },
            )],
            ..NONE
        },
    ),
    (
        "GetEventsResponse",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["events", "total", "resourceId"],
            members: &[
                (
                    "events",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&reference("AttributedEvent")),
                        ..NONE
                    },
                ),
                ("resourceId", reference("ResourceId")),
                ("total", of(&[Kind::Number])),
            ],
            ..NONE
        },
    ),
    (
        "GetReferencedByResponse",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["referencedBy"],
            members: &[(
                "referencedBy",
                Shape {
                    kinds: Some(&[Kind::Array]),
                    items: Some(&reference("GetReferencedByResponseReferencedByItem")),
                    ..NONE
                },
            )],
            ..NONE
        },
    ),
    (
        "GetReferencedByResponseReferencedByItem",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["id", "target"],
            members: &[
                ("id", reference("AnnotationId")),
                (
                    "resourceName",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        min_length: Some(1),
                        ..NONE
                    },
                ),
                (
                    "target",
                    Shape {
                        kinds: Some(&[Kind::Object]),
                        required: &["source", "selector"],
                        members: &[
                            (
                                "selector",
                                Shape {
                                    kinds: Some(&[Kind::Object]),
                                    required: &["exact"],
                                    members: &[("exact", of(&[Kind::String]))],
                                    ..NONE
                                },
                            ),
                            ("source", reference("ResourceId")),
                        ],
                        ..NONE
                    },
                ),
            ],
            ..NONE
        },
    ),
    (
        "GetResourceByTokenResponse",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["sourceResource", "expiresAt"],
            members: &[
                ("expiresAt", of(&[Kind::String])),
                ("sourceResource", reference("ResourceDescriptor")),
            ],
            ..NONE
        },
    ),
    (
        "GetResourceResponse",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["resource", "annotations"],
            members: &[
                (
                    "annotations",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&reference("Annotation")),
                        ..NONE
                    },
                ),
                ("resource", reference("ResourceDescriptor")),
            ],
            ..NONE
        },
    ),
    (
        "GetTagSchemasResponse",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["tagSchemas"],
            members: &[(
                "tagSchemas",
                Shape {
                    kinds: Some(&[Kind::Array]),
                    items: Some(&reference("TagSchema")),
                    ..NONE
                },
            )],
            ..NONE
        },
    ),
    (
        "GraphAnnotationNode",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["id", "type", "label", "annotation"],
            members: &[
                ("annotation", reference("Annotation")),
                (
                    "entityTypes",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&of(&[Kind::String])),
                        ..NONE
                    },
                ),
                ("id", reference("AnnotationId")),
                ("label", of(&[Kind::String])),
                ("metadata", of(&[Kind::Object])),
                (
                    "type",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[Listed::Text("annotation")]),
                        ..NONE
                    },
                ),
            ],
            ..NONE
        },
    ),
    (
        "GraphConfig",
        Shape {
            kinds: Some(&[Kind::Object]),
            one_of: &[
                reference("Neo4jGraphConfig"),
                reference("JanusGraphConfig"),
                reference("NeptuneGraphConfig"),
                reference("MemoryGraphConfig"),
            ],
            discriminator: Some(Discriminator {
                property: "type",
                mapping: &[
                    ("neo4j", 0),
                    ("janusgraph", 1),
                    ("neptune", 2),
                    ("memory", 3),
                ],
            }),
            ..NONE
        },
    ),
    (
        "GraphResourceNode",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["id", "type", "label"],
            members: &[
                (
                    "entityTypes",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&of(&[Kind::String])),
                        ..NONE
                    },
                ),
                ("id", reference("ResourceId")),
                ("label", of(&[Kind::String])),
                ("metadata", of(&[Kind::Object])),
                (
                    "type",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[Listed::Text("resource")]),
                        ..NONE
                    },
                ),
            ],
            ..NONE
        },
    ),
    (
        "HealthResponse",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["status", "message", "version", "timestamp"],
            members: &[
                ("message", of(&[Kind::String])),
                ("status", of(&[Kind::String])),
                ("timestamp", of(&[Kind::String])),
                ("version", of(&[Kind::String])),
            ],
            ..NONE
        },
    ),
    (
        "HighlightingJobParams",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["motivation"],
            members: &[
                ("density", of(&[Kind::Number])),
                ("instructions", of(&[Kind::String])),
                (
                    "motivation",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[Listed::Text("highlighting")]),
                        ..NONE
                    },
                ),
                ("sourceLanguage", of(&[Kind::String])),
            ],
            closed: Some(&["density", "instructions", "motivation", "sourceLanguage"]),
            ..NONE
        },
    ),
    (
        "HttpEndpoint",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["kind", "host", "port", "protocol"],
            members: &[
                ("host", of(&[Kind::String])),
                (
                    "kind",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[Listed::Text("http")]),
                        ..NONE
                    },
                ),
                (
                    "port",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        minimum: Some(1.0),
                        maximum: Some(65535.0),
                        ..NONE
                    },
                ),
                (
                    "protocol",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[Listed::Text("http"), Listed::Text("https")]),
                        ..NONE
                    },
                ),
            ],
            ..NONE
        },
    ),
    (
        "InferenceLimits",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["contextTokens", "maxOutputTokens"],
            members: &[
                ("acceptsTemperature", of(&[Kind::Boolean])),
                ("contextTokens", of(&[Kind::Number])),
                ("maxOutputTokens", of(&[Kind::Number])),
            ],
            ..NONE
        },
    ),
    ("InferenceLimitsRequest", of(&[Kind::Object])),
    (
        "InferenceLimitsResult",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["response"],
            members: &[(
                "response",
                Shape {
                    kinds: Some(&[Kind::Object]),
                    required: &["limits"],
                    members: &[(
                        "limits",
                        Shape {
                            kinds: Some(&[Kind::Array]),
                            items: Some(&reference("EngineLimits")),
                            ..NONE
                        },
                    )],
                    ..NONE
                },
            )],
            ..NONE
        },
    ),
    (
        "JanusGraphConfig",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["type", "host", "port"],
            members: &[
                (
                    "host",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        min_length: Some(1),
                        ..NONE
                    },
                ),
                (
                    "port",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        minimum: Some(1.0),
                        maximum: Some(65535.0),
                        ..NONE
                    },
                ),
                (
                    "type",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[Listed::Text("janusgraph")]),
                        ..NONE
                    },
                ),
            ],
            closed: Some(&["host", "port", "type"]),
            ..NONE
        },
    ),
    (
        "Job",
        Shape {
            kinds: Some(&[Kind::Object]),
            one_of: &[
                reference("JobPending"),
                reference("JobRunning"),
                reference("JobComplete"),
                reference("JobFailed"),
                reference("JobCancelled"),
            ],
            discriminator: Some(Discriminator {
                property: "status",
                mapping: &[
                    ("pending", 0),
                    ("running", 1),
                    ("complete", 2),
                    ("failed", 3),
                    ("cancelled", 4),
                ],
            }),
            ..NONE
        },
    ),
    (
        "JobAssignCommand",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["jobId", "jobType", "resourceId", "holder", "requester"],
            members: &[
                ("_userId", reference("UserId")),
                ("holder", reference("UserId")),
                ("jobId", reference("JobId")),
                ("jobType", reference("JobType")),
                ("requester", reference("UserId")),
                ("resourceId", reference("ResourceId")),
            ],
            ..NONE
        },
    ),
    (
        "JobAssignedPayload",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["jobId", "jobType", "resourceId", "holder", "requester"],
            members: &[
                ("holder", reference("UserId")),
                ("jobId", reference("JobId")),
                ("jobType", reference("JobType")),
                ("requester", reference("UserId")),
                ("resourceId", reference("ResourceId")),
            ],
            ..NONE
        },
    ),
    (
        "JobCancelCommand",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["resourceId", "jobId", "jobType"],
            members: &[
                ("_userId", reference("UserId")),
                ("annotationId", reference("AnnotationId")),
                (
                    "completedUnits",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&of(&[Kind::String])),
                        ..NONE
                    },
                ),
                ("jobId", reference("JobId")),
                ("jobType", reference("JobType")),
                ("resourceId", reference("ResourceId")),
                (
                    "unitCursors",
                    Shape {
                        kinds: Some(&[Kind::Object]),
                        values: Some(&reference("UnitCursor")),
                        ..NONE
                    },
                ),
            ],
            ..NONE
        },
    ),
    (
        "JobCancelRequest",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["jobId"],
            members: &[("jobId", reference("JobId"))],
            ..NONE
        },
    ),
    (
        "JobCancelResult",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["cancelled"],
            members: &[("cancelled", of(&[Kind::Boolean]))],
            ..NONE
        },
    ),
    (
        "JobCancelled",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["status", "metadata", "params", "completedAt"],
            members: &[
                ("completedAt", of(&[Kind::String])),
                ("metadata", reference("JobMetadata")),
                ("params", reference("JobParams")),
                ("startedAt", of(&[Kind::String])),
                (
                    "status",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[Listed::Text("cancelled")]),
                        ..NONE
                    },
                ),
            ],
            closed: Some(&["completedAt", "metadata", "params", "startedAt", "status"]),
            ..NONE
        },
    ),
    (
        "JobCheckpointCommand",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["jobId", "completedUnits"],
            members: &[
                ("_userId", reference("UserId")),
                (
                    "completedUnits",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&of(&[Kind::String])),
                        ..NONE
                    },
                ),
                ("jobId", reference("JobId")),
                (
                    "unitCursors",
                    Shape {
                        kinds: Some(&[Kind::Object]),
                        values: Some(&reference("UnitCursor")),
                        ..NONE
                    },
                ),
            ],
            ..NONE
        },
    ),
    (
        "JobClaimCommand",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["accepts"],
            members: &[
                (
                    "_roles",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&of(&[Kind::String])),
                        ..NONE
                    },
                ),
                ("_userId", reference("UserId")),
                (
                    "accepts",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        min_items: Some(1),
                        items: Some(&reference("JobFilter")),
                        ..NONE
                    },
                ),
            ],
            ..NONE
        },
    ),
    (
        "JobClaimedResult",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["response"],
            members: &[("response", reference("JobRunning"))],
            closed: Some(&["response"]),
            ..NONE
        },
    ),
    (
        "JobComplete",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &[
                "status",
                "metadata",
                "params",
                "startedAt",
                "completedAt",
                "result",
            ],
            members: &[
                ("completedAt", of(&[Kind::String])),
                ("metadata", reference("JobMetadata")),
                ("params", reference("JobParams")),
                ("result", reference("JobStoredResult")),
                ("startedAt", of(&[Kind::String])),
                (
                    "status",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[Listed::Text("complete")]),
                        ..NONE
                    },
                ),
            ],
            closed: Some(&[
                "completedAt",
                "metadata",
                "params",
                "result",
                "startedAt",
                "status",
            ]),
            ..NONE
        },
    ),
    (
        "JobCompleteCommand",
        Shape {
            kinds: Some(&[Kind::Object]),
            one_of: &[
                reference("MarkJobCompleteCommand"),
                reference("YieldJobCompleteCommand"),
            ],
            discriminator: Some(Discriminator {
                property: "jobType",
                mapping: &[("mark", 0), ("yield", 1)],
            }),
            ..NONE
        },
    ),
    (
        "JobCompletedPayload",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["jobId", "jobType"],
            members: &[
                ("annotationId", reference("AnnotationId")),
                ("annotationUri", of(&[Kind::String])),
                ("attempt", of(&[Kind::Integer])),
                ("durability", reference("DurabilityEvidence")),
                ("foundCount", of(&[Kind::Integer])),
                ("jobId", reference("JobId")),
                ("jobType", reference("JobType")),
                ("result", of(&[Kind::Object])),
                ("resultResourceId", reference("ResourceId")),
                ("totalSteps", of(&[Kind::Integer])),
            ],
            ..NONE
        },
    ),
    (
        "JobCreateCommand",
        Shape {
            kinds: Some(&[Kind::Object]),
            one_of: &[
                reference("MarkJobCreateCommand"),
                reference("YieldJobCreateCommand"),
            ],
            discriminator: Some(Discriminator {
                property: "jobType",
                mapping: &[("mark", 0), ("yield", 1)],
            }),
            ..NONE
        },
    ),
    (
        "JobCreatedResult",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["response"],
            members: &[("response", reference("JobCreatedResultResponse"))],
            ..NONE
        },
    ),
    (
        "JobCreatedResultResponse",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["jobId"],
            members: &[("jobId", reference("JobId"))],
            ..NONE
        },
    ),
    (
        "JobDeclined",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["declined", "reason"],
            members: &[
                (
                    "declined",
                    Shape {
                        kinds: Some(&[Kind::Boolean]),
                        enumeration: Some(&[Listed::Boolean(true)]),
                        ..NONE
                    },
                ),
                (
                    "reason",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[
                            Listed::Text("no-text-layer"),
                            Listed::Text("encrypted"),
                            Listed::Text("corrupt"),
                            Listed::Text("too-large"),
                            Listed::Text("empty"),
                        ]),
                        ..NONE
                    },
                ),
            ],
            closed: Some(&["declined", "reason"]),
            ..NONE
        },
    ),
    (
        "JobFailCommand",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["resourceId", "jobId", "jobType", "error"],
            members: &[
                ("_userId", reference("UserId")),
                ("annotationId", reference("AnnotationId")),
                ("attempt", of(&[Kind::Integer])),
                (
                    "completedUnits",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&of(&[Kind::String])),
                        ..NONE
                    },
                ),
                ("durability", reference("DurabilityEvidence")),
                ("error", of(&[Kind::String])),
                ("failureClass", reference("FailureClass")),
                ("jobId", reference("JobId")),
                ("jobType", reference("JobType")),
                ("resourceId", reference("ResourceId")),
                (
                    "unitCursors",
                    Shape {
                        kinds: Some(&[Kind::Object]),
                        values: Some(&reference("UnitCursor")),
                        ..NONE
                    },
                ),
                ("willRetry", of(&[Kind::Boolean])),
            ],
            ..NONE
        },
    ),
    (
        "JobFailed",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["status", "metadata", "params", "completedAt", "error"],
            members: &[
                ("completedAt", of(&[Kind::String])),
                ("error", of(&[Kind::String])),
                ("failureClass", reference("FailureClass")),
                ("metadata", reference("JobMetadata")),
                ("params", reference("JobParams")),
                ("startedAt", of(&[Kind::String])),
                (
                    "status",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[Listed::Text("failed")]),
                        ..NONE
                    },
                ),
            ],
            closed: Some(&[
                "completedAt",
                "error",
                "failureClass",
                "metadata",
                "params",
                "startedAt",
                "status",
            ]),
            ..NONE
        },
    ),
    (
        "JobFailedPayload",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["jobId", "jobType", "error"],
            members: &[
                ("annotationId", reference("AnnotationId")),
                ("attempt", of(&[Kind::Integer])),
                ("durability", reference("DurabilityEvidence")),
                ("error", of(&[Kind::String])),
                ("failureClass", reference("FailureClass")),
                ("jobId", reference("JobId")),
                ("jobType", reference("JobType")),
                ("willRetry", of(&[Kind::Boolean])),
            ],
            ..NONE
        },
    ),
    (
        "JobFilter",
        Shape {
            kinds: Some(&[Kind::Object]),
            one_of: &[reference("MarkJobFilter"), reference("YieldJobFilter")],
            discriminator: Some(Discriminator {
                property: "jobType",
                mapping: &[("mark", 0), ("yield", 1)],
            }),
            ..NONE
        },
    ),
    (
        "JobId",
        Shape {
            kinds: Some(&[Kind::String]),
            pattern: Some(&[Step {
                of: &[(45, 45), (48, 57), (65, 90), (95, 95), (97, 122)],
                min: 1,
                max: Some(128),
            }]),
            ..NONE
        },
    ),
    (
        "JobMetadata",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &[
                "id",
                "type",
                "userId",
                "created",
                "retryCount",
                "maxRetries",
            ],
            members: &[
                (
                    "completedUnits",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&of(&[Kind::String])),
                        ..NONE
                    },
                ),
                ("created", of(&[Kind::String])),
                ("id", reference("JobId")),
                (
                    "maxRetries",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        minimum: Some(0.0),
                        ..NONE
                    },
                ),
                (
                    "retryCount",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        minimum: Some(0.0),
                        ..NONE
                    },
                ),
                ("type", reference("JobType")),
                (
                    "unitCursors",
                    Shape {
                        kinds: Some(&[Kind::Object]),
                        values: Some(&reference("UnitCursor")),
                        ..NONE
                    },
                ),
                ("userId", reference("UserId")),
            ],
            closed: Some(&[
                "completedUnits",
                "created",
                "id",
                "maxRetries",
                "retryCount",
                "type",
                "unitCursors",
                "userId",
            ]),
            ..NONE
        },
    ),
    (
        "JobParams",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["resourceId"],
            members: &[
                ("resourceId", reference("ResourceId")),
                ("schema", reference("TagSchema")),
            ],
            ..NONE
        },
    ),
    (
        "JobPending",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["status", "metadata", "params"],
            members: &[
                ("metadata", reference("JobMetadata")),
                ("params", reference("JobParams")),
                (
                    "status",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[Listed::Text("pending")]),
                        ..NONE
                    },
                ),
            ],
            closed: Some(&["metadata", "params", "status"]),
            ..NONE
        },
    ),
    (
        "JobProgress",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["percentage"],
            members: &[
                ("annotationId", reference("AnnotationId")),
                (
                    "completedItems",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&Shape {
                            kinds: Some(&[Kind::Object]),
                            required: &["value", "foundCount"],
                            members: &[
                                ("foundCount", of(&[Kind::Integer])),
                                ("persistedCount", of(&[Kind::Integer])),
                                (
                                    "underReported",
                                    Shape {
                                        kinds: Some(&[Kind::Object]),
                                        required: &["pieces", "found", "counted"],
                                        members: &[
                                            ("counted", of(&[Kind::Integer])),
                                            ("found", of(&[Kind::Integer])),
                                            ("pieces", of(&[Kind::Integer])),
                                        ],
                                        ..NONE
                                    },
                                ),
                                ("value", of(&[Kind::String])),
                            ],
                            ..NONE
                        }),
                        ..NONE
                    },
                ),
                (
                    "current",
                    Shape {
                        kinds: Some(&[Kind::Object]),
                        required: &["kind", "value"],
                        members: &[
                            (
                                "kind",
                                Shape {
                                    kinds: Some(&[Kind::String]),
                                    enumeration: Some(&[
                                        Listed::Text("entity-type"),
                                        Listed::Text("category"),
                                    ]),
                                    ..NONE
                                },
                            ),
                            ("value", of(&[Kind::String])),
                        ],
                        ..NONE
                    },
                ),
                ("entitiesEmitted", of(&[Kind::Integer])),
                ("entitiesExpected", of(&[Kind::Integer])),
                ("entitiesFound", of(&[Kind::Integer])),
                ("message", reference("JobProgressMessage")),
                ("percentage", of(&[Kind::Number])),
                ("processed", of(&[Kind::Integer])),
                (
                    "requestParams",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&Shape {
                            kinds: Some(&[Kind::Object]),
                            required: &["label", "value"],
                            members: &[
                                (
                                    "label",
                                    Shape {
                                        kinds: Some(&[Kind::String]),
                                        enumeration: Some(&[
                                            Listed::Text("entity-types"),
                                            Listed::Text("instructions"),
                                            Listed::Text("tone"),
                                            Listed::Text("density"),
                                        ]),
                                        ..NONE
                                    },
                                ),
                                ("value", of(&[Kind::String])),
                            ],
                            ..NONE
                        }),
                        ..NONE
                    },
                ),
                ("total", of(&[Kind::Integer])),
            ],
            ..NONE
        },
    ),
    (
        "JobProgressAnalyzing",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["code"],
            members: &[(
                "code",
                Shape {
                    kinds: Some(&[Kind::String]),
                    enumeration: Some(&[Listed::Text("analyzing")]),
                    ..NONE
                },
            )],
            ..NONE
        },
    ),
    (
        "JobProgressAnalyzingTags",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["code"],
            members: &[(
                "code",
                Shape {
                    kinds: Some(&[Kind::String]),
                    enumeration: Some(&[Listed::Text("analyzing-tags")]),
                    ..NONE
                },
            )],
            ..NONE
        },
    ),
    (
        "JobProgressCompleteCreated",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["code", "count", "motivation"],
            members: &[
                (
                    "code",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[Listed::Text("complete-created")]),
                        ..NONE
                    },
                ),
                ("count", of(&[Kind::Integer])),
                ("motivation", reference("Motivation")),
            ],
            ..NONE
        },
    ),
    (
        "JobProgressCompleteGenerated",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["code", "truncated"],
            members: &[
                (
                    "code",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[Listed::Text("complete-generated")]),
                        ..NONE
                    },
                ),
                ("truncated", of(&[Kind::Boolean])),
            ],
            ..NONE
        },
    ),
    (
        "JobProgressCreatingAnnotations",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["code", "count"],
            members: &[
                (
                    "code",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[Listed::Text("creating-annotations")]),
                        ..NONE
                    },
                ),
                ("count", of(&[Kind::Integer])),
            ],
            ..NONE
        },
    ),
    (
        "JobProgressCreatingResource",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["code"],
            members: &[(
                "code",
                Shape {
                    kinds: Some(&[Kind::String]),
                    enumeration: Some(&[Listed::Text("creating-resource")]),
                    ..NONE
                },
            )],
            ..NONE
        },
    ),
    (
        "JobProgressCreatingTagAnnotations",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["code", "count"],
            members: &[
                (
                    "code",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[Listed::Text("creating-tag-annotations")]),
                        ..NONE
                    },
                ),
                ("count", of(&[Kind::Integer])),
            ],
            ..NONE
        },
    ),
    (
        "JobProgressDetectingEntities",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["code", "entityType"],
            members: &[
                (
                    "code",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[Listed::Text("detecting-entities")]),
                        ..NONE
                    },
                ),
                ("entityType", of(&[Kind::String])),
            ],
            ..NONE
        },
    ),
    (
        "JobProgressGeneratingResource",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["code"],
            members: &[(
                "code",
                Shape {
                    kinds: Some(&[Kind::String]),
                    enumeration: Some(&[Listed::Text("generating-resource")]),
                    ..NONE
                },
            )],
            ..NONE
        },
    ),
    (
        "JobProgressLoading",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["code"],
            members: &[(
                "code",
                Shape {
                    kinds: Some(&[Kind::String]),
                    enumeration: Some(&[Listed::Text("loading")]),
                    ..NONE
                },
            )],
            ..NONE
        },
    ),
    (
        "JobProgressMessage",
        Shape {
            kinds: Some(&[Kind::Object]),
            one_of: &[
                reference("JobProgressLoading"),
                reference("JobProgressAnalyzing"),
                reference("JobProgressAnalyzingTags"),
                reference("JobProgressGeneratingResource"),
                reference("JobProgressCreatingResource"),
                reference("JobProgressCompleteGenerated"),
                reference("JobProgressDetectingEntities"),
                reference("JobProgressCreatingAnnotations"),
                reference("JobProgressCreatingTagAnnotations"),
                reference("JobProgressCompleteCreated"),
            ],
            discriminator: Some(Discriminator {
                property: "code",
                mapping: &[
                    ("loading", 0),
                    ("analyzing", 1),
                    ("analyzing-tags", 2),
                    ("generating-resource", 3),
                    ("creating-resource", 4),
                    ("complete-generated", 5),
                    ("detecting-entities", 6),
                    ("creating-annotations", 7),
                    ("creating-tag-annotations", 8),
                    ("complete-created", 9),
                ],
            }),
            ..NONE
        },
    ),
    (
        "JobQueuedEvent",
        Shape {
            kinds: Some(&[Kind::Object]),
            one_of: &[
                reference("MarkJobQueuedEvent"),
                reference("YieldJobQueuedEvent"),
            ],
            discriminator: Some(Discriminator {
                property: "jobType",
                mapping: &[("mark", 0), ("yield", 1)],
            }),
            ..NONE
        },
    ),
    (
        "JobRecord",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["job", "lastProgressAt"],
            members: &[
                ("job", reference("Job")),
                ("lastProgressAt", of(&[Kind::String])),
            ],
            closed: Some(&["job", "lastProgressAt"]),
            ..NONE
        },
    ),
    (
        "JobReportProgressCommand",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["resourceId", "jobId", "jobType", "percentage"],
            members: &[
                ("_userId", reference("UserId")),
                ("annotationId", reference("AnnotationId")),
                ("attempt", of(&[Kind::Integer])),
                ("jobId", reference("JobId")),
                ("jobType", reference("JobType")),
                ("percentage", of(&[Kind::Number])),
                ("progress", reference("JobProgress")),
                ("resourceId", reference("ResourceId")),
            ],
            ..NONE
        },
    ),
    (
        "JobResult",
        Shape {
            kinds: Some(&[Kind::Object]),
            one_of: &[
                reference("MarkJobDone"),
                reference("YieldJobDone"),
                reference("JobDeclined"),
            ],
            ..NONE
        },
    ),
    (
        "JobRunning",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["status", "metadata", "params", "startedAt", "progress"],
            members: &[
                ("metadata", reference("JobMetadata")),
                ("params", reference("JobParams")),
                ("progress", reference("JobStoredProgress")),
                ("startedAt", of(&[Kind::String])),
                (
                    "status",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[Listed::Text("running")]),
                        ..NONE
                    },
                ),
            ],
            closed: Some(&["metadata", "params", "progress", "startedAt", "status"]),
            ..NONE
        },
    ),
    (
        "JobStartCommand",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["resourceId", "jobId", "jobType"],
            members: &[
                ("_userId", reference("UserId")),
                ("annotationId", reference("AnnotationId")),
                ("attempt", of(&[Kind::Integer])),
                ("jobId", reference("JobId")),
                ("jobType", reference("JobType")),
                ("resourceId", reference("ResourceId")),
            ],
            ..NONE
        },
    ),
    (
        "JobStartedPayload",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["jobId", "jobType"],
            members: &[
                ("annotationId", reference("AnnotationId")),
                ("jobId", reference("JobId")),
                ("jobType", reference("JobType")),
                ("totalSteps", of(&[Kind::Integer])),
            ],
            ..NONE
        },
    ),
    (
        "JobStatusRequest",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["jobId"],
            members: &[("jobId", reference("JobId"))],
            ..NONE
        },
    ),
    (
        "JobStatusResponse",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["jobId", "type", "status", "userId", "created"],
            members: &[
                ("completedAt", of(&[Kind::String])),
                ("created", of(&[Kind::String])),
                ("error", of(&[Kind::String])),
                ("failureClass", reference("FailureClass")),
                ("jobId", reference("JobId")),
                ("progress", reference("JobStoredProgress")),
                ("result", reference("JobStoredResult")),
                ("startedAt", of(&[Kind::String])),
                (
                    "status",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[
                            Listed::Text("pending"),
                            Listed::Text("running"),
                            Listed::Text("complete"),
                            Listed::Text("failed"),
                            Listed::Text("cancelled"),
                        ]),
                        ..NONE
                    },
                ),
                ("type", reference("JobType")),
                ("userId", reference("UserId")),
            ],
            ..NONE
        },
    ),
    (
        "JobStatusResult",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["response"],
            members: &[("response", reference("JobStatusResponse"))],
            ..NONE
        },
    ),
    (
        "JobStoredProgress",
        Shape {
            kinds: Some(&[Kind::Object]),
            one_of: &[
                reference("JobProgress"),
                Shape {
                    kinds: Some(&[Kind::Object]),
                    closed: Some(&[]),
                    ..NONE
                },
            ],
            ..NONE
        },
    ),
    (
        "JobStoredResult",
        Shape {
            kinds: Some(&[Kind::Object]),
            one_of: &[
                reference("JobResult"),
                Shape {
                    kinds: Some(&[Kind::Object]),
                    closed: Some(&[]),
                    ..NONE
                },
            ],
            ..NONE
        },
    ),
    (
        "JobType",
        Shape {
            kinds: Some(&[Kind::String]),
            enumeration: Some(&[Listed::Text("mark"), Listed::Text("yield")]),
            ..NONE
        },
    ),
    (
        "KbDescription",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["name", "domain"],
            members: &[
                ("domain", of(&[Kind::String])),
                ("gitBranch", of(&[Kind::String])),
                ("name", of(&[Kind::String])),
            ],
            ..NONE
        },
    ),
    (
        "KbEndpoint",
        Shape {
            kinds: Some(&[Kind::Object]),
            one_of: &[reference("HttpEndpoint"), reference("LocalEndpoint")],
            discriminator: Some(Discriminator {
                property: "kind",
                mapping: &[("http", 0), ("local", 1)],
            }),
            ..NONE
        },
    ),
    (
        "KbIdentity",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["name", "domain"],
            members: &[
                (
                    "domain",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        pattern: Some(&[Step {
                            of: &[
                                (0, 8),
                                (14, 31),
                                (33, 159),
                                (161, 5759),
                                (5761, 8191),
                                (8203, 8231),
                                (8234, 8238),
                                (8240, 8286),
                                (8288, 12287),
                                (12289, 65278),
                                (65280, 1114111),
                            ],
                            min: 1,
                            max: None,
                        }]),
                        min_length: Some(1),
                        ..NONE
                    },
                ),
                (
                    "name",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        min_length: Some(1),
                        ..NONE
                    },
                ),
            ],
            closed: Some(&["domain", "name"]),
            ..NONE
        },
    ),
    (
        "KbRead",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["at"],
            members: &[
                ("at", of(&[Kind::String])),
                ("gitBranch", of(&[Kind::String])),
            ],
            ..NONE
        },
    ),
    (
        "KbTarget",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["id", "label", "endpoint"],
            members: &[
                ("endpoint", reference("KbEndpoint")),
                ("id", of(&[Kind::String])),
                ("label", of(&[Kind::String])),
            ],
            ..NONE
        },
    ),
    (
        "KnowledgeBase",
        Shape {
            kinds: Some(&[Kind::Object]),
            all_of: &[reference("KbTarget"), reference("NewKnowledgeBase")],
            ..NONE
        },
    ),
    (
        "KnowledgeGraph",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["nodes", "edges"],
            members: &[
                (
                    "edges",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&Shape {
                            kinds: Some(&[Kind::Object]),
                            required: &["source", "target", "type"],
                            members: &[
                                ("bidirectional", of(&[Kind::Boolean])),
                                ("metadata", of(&[Kind::Object])),
                                ("source", of(&[Kind::String])),
                                ("target", of(&[Kind::String])),
                                ("type", of(&[Kind::String])),
                            ],
                            ..NONE
                        }),
                        ..NONE
                    },
                ),
                (
                    "nodes",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&Shape {
                            kinds: Some(&[Kind::Object]),
                            one_of: &[
                                reference("GraphResourceNode"),
                                reference("GraphAnnotationNode"),
                            ],
                            discriminator: Some(Discriminator {
                                property: "type",
                                mapping: &[("resource", 0), ("annotation", 1)],
                            }),
                            ..NONE
                        }),
                        ..NONE
                    },
                ),
                ("truncated", of(&[Kind::Boolean])),
            ],
            ..NONE
        },
    ),
    (
        "LibrarianConfig",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &[
                "kb",
                "gatewayUrl",
                "identity",
                "archivist",
                "graph",
                "vectors",
                "embedding",
                "matcher",
                "gatherer",
                "modelCatalogue",
                "gather",
                "search",
                "port",
                "logLevel",
                "logFormat",
            ],
            members: &[
                ("archivist", reference("ServiceAddress")),
                ("embedding", reference("EmbeddingConfig")),
                (
                    "gatewayUrl",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        min_length: Some(1),
                        ..NONE
                    },
                ),
                (
                    "gather",
                    Shape {
                        kinds: Some(&[Kind::Object]),
                        required: &["settleTimeoutMs"],
                        members: &[(
                            "settleTimeoutMs",
                            Shape {
                                kinds: Some(&[Kind::Integer]),
                                minimum: Some(1.0),
                                ..NONE
                            },
                        )],
                        closed: Some(&["settleTimeoutMs"]),
                        ..NONE
                    },
                ),
                ("gatherer", reference("LibrarianEngineConfig")),
                ("graph", reference("GraphConfig")),
                ("identity", reference("ServiceIdentity")),
                ("kb", reference("KbIdentity")),
                ("logFormat", reference("LogFormat")),
                ("logLevel", reference("LogLevel")),
                ("matcher", reference("LibrarianEngineConfig")),
                (
                    "modelCatalogue",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        min_length: Some(1),
                        ..NONE
                    },
                ),
                (
                    "port",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        minimum: Some(1.0),
                        maximum: Some(65535.0),
                        ..NONE
                    },
                ),
                (
                    "search",
                    Shape {
                        kinds: Some(&[Kind::Object]),
                        required: &["semanticFloor"],
                        members: &[(
                            "semanticFloor",
                            Shape {
                                kinds: Some(&[Kind::Number]),
                                minimum: Some(0.0),
                                maximum: Some(1.0),
                                ..NONE
                            },
                        )],
                        closed: Some(&["semanticFloor"]),
                        ..NONE
                    },
                ),
                ("vectors", reference("VectorsConfig")),
            ],
            closed: Some(&[
                "archivist",
                "embedding",
                "gatewayUrl",
                "gather",
                "gatherer",
                "graph",
                "identity",
                "kb",
                "logFormat",
                "logLevel",
                "matcher",
                "modelCatalogue",
                "port",
                "search",
                "vectors",
            ]),
            ..NONE
        },
    ),
    (
        "LibrarianEngineConfig",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["engine", "baseUrl"],
            members: &[
                (
                    "apiKeyEnv",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        min_length: Some(1),
                        ..NONE
                    },
                ),
                (
                    "baseUrl",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        min_length: Some(1),
                        ..NONE
                    },
                ),
                ("engine", reference("Engine")),
            ],
            closed: Some(&["apiKeyEnv", "baseUrl", "engine"]),
            ..NONE
        },
    ),
    (
        "LimitRefusal",
        Shape {
            kinds: Some(&[Kind::Object]),
            all_of: &[
                reference("ErrorResponse"),
                Shape {
                    kinds: Some(&[Kind::Object]),
                    required: &["code"],
                    members: &[(
                        "code",
                        Shape {
                            kinds: Some(&[Kind::String]),
                            enumeration: Some(&[
                                Listed::Text("streams"),
                                Listed::Text("emit-rate"),
                                Listed::Text("unanswered-requests"),
                                Listed::Text("capacity"),
                                Listed::Text("refusal-rate"),
                            ]),
                            ..NONE
                        },
                    )],
                    ..NONE
                },
            ],
            ..NONE
        },
    ),
    (
        "LinkingJobParams",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["motivation", "entityTypes"],
            members: &[
                (
                    "entityTypes",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        min_items: Some(1),
                        items: Some(&of(&[Kind::String])),
                        ..NONE
                    },
                ),
                ("includeDescriptiveReferences", of(&[Kind::Boolean])),
                ("language", of(&[Kind::String])),
                (
                    "motivation",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[Listed::Text("linking")]),
                        ..NONE
                    },
                ),
                ("sourceLanguage", of(&[Kind::String])),
            ],
            closed: Some(&[
                "entityTypes",
                "includeDescriptiveReferences",
                "language",
                "motivation",
                "sourceLanguage",
            ]),
            ..NONE
        },
    ),
    (
        "ListResourcesResponse",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["resources", "total", "offset", "limit"],
            members: &[
                ("limit", of(&[Kind::Number])),
                ("offset", of(&[Kind::Number])),
                (
                    "resources",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&reference("ResourceDescriptor")),
                        ..NONE
                    },
                ),
                ("total", of(&[Kind::Number])),
            ],
            ..NONE
        },
    ),
    (
        "LocalEndpoint",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["kind", "kbId"],
            members: &[
                ("kbId", of(&[Kind::String])),
                (
                    "kind",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[Listed::Text("local")]),
                        ..NONE
                    },
                ),
            ],
            ..NONE
        },
    ),
    (
        "LogFormat",
        Shape {
            kinds: Some(&[Kind::String]),
            enumeration: Some(&[Listed::Text("json"), Listed::Text("simple")]),
            ..NONE
        },
    ),
    (
        "LogLevel",
        Shape {
            kinds: Some(&[Kind::String]),
            enumeration: Some(&[
                Listed::Text("error"),
                Listed::Text("warn"),
                Listed::Text("info"),
                Listed::Text("http"),
                Listed::Text("debug"),
            ]),
            ..NONE
        },
    ),
    (
        "MarkArchiveCommand",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["resourceId"],
            members: &[
                ("_userId", reference("UserId")),
                ("keepFile", of(&[Kind::Boolean])),
                ("resourceId", reference("ResourceId")),
                ("storageUri", of(&[Kind::String])),
            ],
            ..NONE
        },
    ),
    (
        "MarkCommitCommand",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["resourceId", "annotations"],
            members: &[
                (
                    "_roles",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&of(&[Kind::String])),
                        ..NONE
                    },
                ),
                ("_userId", reference("UserId")),
                (
                    "annotations",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&reference("Annotation")),
                        ..NONE
                    },
                ),
                ("jobId", reference("JobId")),
                ("resourceId", reference("ResourceId")),
            ],
            ..NONE
        },
    ),
    (
        "MarkCommitOk",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["response"],
            members: &[(
                "response",
                Shape {
                    kinds: Some(&[Kind::Object]),
                    required: &["persisted", "annotationIds"],
                    members: &[
                        (
                            "annotationIds",
                            Shape {
                                kinds: Some(&[Kind::Array]),
                                items: Some(&reference("AnnotationId")),
                                ..NONE
                            },
                        ),
                        ("persisted", of(&[Kind::Integer])),
                    ],
                    ..NONE
                },
            )],
            ..NONE
        },
    ),
    (
        "MarkCreateOk",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["response"],
            members: &[("response", reference("MarkCreateOkResponse"))],
            ..NONE
        },
    ),
    (
        "MarkCreateOkResponse",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["annotationId"],
            members: &[("annotationId", reference("AnnotationId"))],
            ..NONE
        },
    ),
    (
        "MarkCreateRequest",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["resourceId", "request"],
            members: &[
                ("request", reference("CreateAnnotationRequest")),
                ("resourceId", reference("ResourceId")),
            ],
            ..NONE
        },
    ),
    (
        "MarkDelegateTimeoutEvent",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["resourceId", "motivation"],
            members: &[
                ("motivation", reference("Motivation")),
                ("resourceId", reference("ResourceId")),
            ],
            ..NONE
        },
    ),
    (
        "MarkDeleteCommand",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["annotationId"],
            members: &[
                ("_userId", reference("UserId")),
                ("annotationId", reference("AnnotationId")),
                ("resourceId", reference("ResourceId")),
            ],
            ..NONE
        },
    ),
    (
        "MarkDeleteOk",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["response"],
            members: &[(
                "response",
                Shape {
                    kinds: Some(&[Kind::Object]),
                    required: &["annotationId"],
                    members: &[("annotationId", reference("AnnotationId"))],
                    ..NONE
                },
            )],
            ..NONE
        },
    ),
    (
        "MarkJobCompleteCommand",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["resourceId", "jobId", "jobType"],
            members: &[
                ("_userId", reference("UserId")),
                ("attempt", of(&[Kind::Integer])),
                ("durability", reference("DurabilityEvidence")),
                ("jobId", reference("JobId")),
                (
                    "jobType",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[Listed::Text("mark")]),
                        ..NONE
                    },
                ),
                ("resourceId", reference("ResourceId")),
                ("result", reference("MarkJobResult")),
            ],
            ..NONE
        },
    ),
    (
        "MarkJobCreateCommand",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["jobType", "resourceId", "params"],
            members: &[
                (
                    "_roles",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&of(&[Kind::String])),
                        ..NONE
                    },
                ),
                ("_userId", reference("UserId")),
                (
                    "jobType",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[Listed::Text("mark")]),
                        ..NONE
                    },
                ),
                ("params", reference("MarkJobParams")),
                ("resourceId", reference("ResourceId")),
            ],
            closed: Some(&["_roles", "_userId", "jobType", "params", "resourceId"]),
            ..NONE
        },
    ),
    (
        "MarkJobDone",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["found", "persisted"],
            members: &[
                (
                    "byCategory",
                    Shape {
                        kinds: Some(&[Kind::Object]),
                        values: Some(&of(&[Kind::Integer])),
                        ..NONE
                    },
                ),
                (
                    "errors",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        minimum: Some(1.0),
                        ..NONE
                    },
                ),
                (
                    "found",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        minimum: Some(0.0),
                        ..NONE
                    },
                ),
                (
                    "persisted",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        minimum: Some(0.0),
                        ..NONE
                    },
                ),
                (
                    "uncheckedPieces",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        minimum: Some(1.0),
                        ..NONE
                    },
                ),
                ("underReportedPieces", of(&[Kind::Integer])),
            ],
            closed: Some(&[
                "byCategory",
                "errors",
                "found",
                "persisted",
                "uncheckedPieces",
                "underReportedPieces",
            ]),
            ..NONE
        },
    ),
    (
        "MarkJobFilter",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["jobType", "params"],
            members: &[
                (
                    "jobType",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[Listed::Text("mark")]),
                        ..NONE
                    },
                ),
                (
                    "params",
                    Shape {
                        kinds: Some(&[Kind::Object]),
                        required: &["motivation"],
                        members: &[("motivation", reference("Motivation"))],
                        closed: Some(&["motivation"]),
                        ..NONE
                    },
                ),
            ],
            closed: Some(&["jobType", "params"]),
            ..NONE
        },
    ),
    (
        "MarkJobParams",
        Shape {
            kinds: Some(&[Kind::Object]),
            one_of: &[
                reference("HighlightingJobParams"),
                reference("CommentingJobParams"),
                reference("AssessingJobParams"),
                reference("LinkingJobParams"),
                reference("TaggingJobParams"),
            ],
            discriminator: Some(Discriminator {
                property: "motivation",
                mapping: &[
                    ("highlighting", 0),
                    ("commenting", 1),
                    ("assessing", 2),
                    ("linking", 3),
                    ("tagging", 4),
                ],
            }),
            ..NONE
        },
    ),
    (
        "MarkJobQueuedEvent",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["jobId", "jobType", "resourceId", "userId", "params"],
            members: &[
                ("jobId", reference("JobId")),
                (
                    "jobType",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[Listed::Text("mark")]),
                        ..NONE
                    },
                ),
                ("params", reference("MarkJobParams")),
                ("resourceId", reference("ResourceId")),
                ("userId", reference("UserId")),
            ],
            ..NONE
        },
    ),
    (
        "MarkJobResult",
        Shape {
            kinds: Some(&[Kind::Object]),
            one_of: &[reference("MarkJobDone"), reference("JobDeclined")],
            ..NONE
        },
    ),
    (
        "MarkRequestedEvent",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["source", "selector", "motivation"],
            members: &[
                ("motivation", reference("Motivation")),
                ("selector", reference("AnnotationSelector")),
                ("source", reference("ResourceId")),
            ],
            ..NONE
        },
    ),
    (
        "MarkSubmitEvent",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["source", "motivation", "selector"],
            members: &[
                ("body", reference("AnnotationBodies")),
                ("motivation", reference("Motivation")),
                ("selector", reference("AnnotationSelector")),
                ("source", reference("ResourceId")),
            ],
            ..NONE
        },
    ),
    (
        "MarkUnarchiveCommand",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["resourceId"],
            members: &[
                ("_userId", reference("UserId")),
                ("resourceId", reference("ResourceId")),
                ("storageUri", of(&[Kind::String])),
            ],
            ..NONE
        },
    ),
    (
        "MarkUpdateBodyCommand",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["annotationId", "resourceId", "operations"],
            members: &[
                ("_userId", reference("UserId")),
                ("annotationId", reference("AnnotationId")),
                (
                    "operations",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&reference("BodyOperation")),
                        ..NONE
                    },
                ),
                ("resourceId", reference("ResourceId")),
            ],
            ..NONE
        },
    ),
    (
        "MarkUpdateEntityTypesCommand",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["resourceId", "currentEntityTypes", "updatedEntityTypes"],
            members: &[
                ("_userId", reference("UserId")),
                (
                    "currentEntityTypes",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&of(&[Kind::String])),
                        ..NONE
                    },
                ),
                ("resourceId", reference("ResourceId")),
                (
                    "updatedEntityTypes",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&of(&[Kind::String])),
                        ..NONE
                    },
                ),
            ],
            ..NONE
        },
    ),
    (
        "MatchResourcesRequest",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["search"],
            members: &[
                ("archived", of(&[Kind::Boolean])),
                ("entityType", of(&[Kind::String])),
                (
                    "limit",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        minimum: Some(1.0),
                        maximum: Some(200.0),
                        ..NONE
                    },
                ),
                (
                    "offset",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        minimum: Some(0.0),
                        ..NONE
                    },
                ),
                ("search", of(&[Kind::String])),
            ],
            ..NONE
        },
    ),
    (
        "MatchResourcesResponse",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["resources", "total", "offset", "limit", "matchKind"],
            members: &[
                (
                    "limit",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        minimum: Some(1.0),
                        ..NONE
                    },
                ),
                (
                    "matchKind",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[Listed::Text("lexical"), Listed::Text("semantic")]),
                        ..NONE
                    },
                ),
                (
                    "offset",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        minimum: Some(0.0),
                        ..NONE
                    },
                ),
                (
                    "resources",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&reference("ResourceDescriptor")),
                        ..NONE
                    },
                ),
                (
                    "total",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        minimum: Some(0.0),
                        ..NONE
                    },
                ),
            ],
            ..NONE
        },
    ),
    (
        "MatchResourcesResult",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["response"],
            members: &[("response", reference("MatchResourcesResponse"))],
            ..NONE
        },
    ),
    (
        "MatchSearchFailed",
        Shape {
            kinds: Some(&[Kind::Object]),
            all_of: &[
                reference("CommandError"),
                Shape {
                    kinds: Some(&[Kind::Object]),
                    required: &["referenceId"],
                    members: &[("referenceId", reference("AnnotationId"))],
                    ..NONE
                },
            ],
            ..NONE
        },
    ),
    (
        "MatchSearchRequest",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["resourceId", "referenceId", "context"],
            members: &[
                ("context", reference("GatheredContext")),
                (
                    "limit",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        minimum: Some(1.0),
                        maximum: Some(200.0),
                        ..NONE
                    },
                ),
                ("referenceId", reference("AnnotationId")),
                ("resourceId", reference("ResourceId")),
                ("useSemanticScoring", of(&[Kind::Boolean])),
            ],
            ..NONE
        },
    ),
    (
        "MatchSearchResult",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["referenceId", "response"],
            members: &[
                ("referenceId", reference("AnnotationId")),
                (
                    "response",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&reference("ScoredResource")),
                        ..NONE
                    },
                ),
            ],
            ..NONE
        },
    ),
    (
        "MediaTokenRequest",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["resourceId"],
            members: &[("resourceId", reference("ResourceId"))],
            ..NONE
        },
    ),
    (
        "MediaTokenResponse",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["token"],
            members: &[("token", of(&[Kind::String]))],
            ..NONE
        },
    ),
    (
        "MemoryGraphConfig",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["type"],
            members: &[(
                "type",
                Shape {
                    kinds: Some(&[Kind::String]),
                    enumeration: Some(&[Listed::Text("memory")]),
                    ..NONE
                },
            )],
            closed: Some(&["type"]),
            ..NONE
        },
    ),
    (
        "MemoryVectorsConfig",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["type"],
            members: &[(
                "type",
                Shape {
                    kinds: Some(&[Kind::String]),
                    enumeration: Some(&[Listed::Text("memory")]),
                    ..NONE
                },
            )],
            closed: Some(&["type"]),
            ..NONE
        },
    ),
    (
        "Motivation",
        Shape {
            kinds: Some(&[Kind::String]),
            enumeration: Some(&[
                Listed::Text("assessing"),
                Listed::Text("commenting"),
                Listed::Text("highlighting"),
                Listed::Text("linking"),
                Listed::Text("tagging"),
            ]),
            ..NONE
        },
    ),
    (
        "Neo4jGraphConfig",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["type", "uri", "username", "passwordEnv", "database"],
            members: &[
                (
                    "database",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        min_length: Some(1),
                        ..NONE
                    },
                ),
                (
                    "passwordEnv",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        min_length: Some(1),
                        ..NONE
                    },
                ),
                (
                    "type",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[Listed::Text("neo4j")]),
                        ..NONE
                    },
                ),
                (
                    "uri",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        min_length: Some(1),
                        ..NONE
                    },
                ),
                (
                    "username",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        min_length: Some(1),
                        ..NONE
                    },
                ),
            ],
            closed: Some(&["database", "passwordEnv", "type", "uri", "username"]),
            ..NONE
        },
    ),
    (
        "NeptuneGraphConfig",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["type", "endpoint", "port"],
            members: &[
                (
                    "endpoint",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        min_length: Some(1),
                        ..NONE
                    },
                ),
                (
                    "port",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        minimum: Some(1.0),
                        maximum: Some(65535.0),
                        ..NONE
                    },
                ),
                (
                    "type",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[Listed::Text("neptune")]),
                        ..NONE
                    },
                ),
            ],
            closed: Some(&["endpoint", "port", "type"]),
            ..NONE
        },
    ),
    (
        "NewKnowledgeBase",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["label", "endpoint", "did"],
            members: &[
                ("did", of(&[Kind::String])),
                ("endpoint", reference("KbEndpoint")),
                ("label", of(&[Kind::String])),
                ("lastRead", reference("KbRead")),
            ],
            ..NONE
        },
    ),
    (
        "OcrConfidence",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["mean", "lowConfidenceWords", "totalWords"],
            members: &[
                ("lowConfidenceWords", of(&[Kind::Integer])),
                ("mean", of(&[Kind::Number])),
                ("totalWords", of(&[Kind::Integer])),
            ],
            ..NONE
        },
    ),
    (
        "OllamaEmbeddingConfig",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["type", "model", "baseUrl"],
            members: &[
                (
                    "baseUrl",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        min_length: Some(1),
                        ..NONE
                    },
                ),
                (
                    "model",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        min_length: Some(1),
                        ..NONE
                    },
                ),
                (
                    "type",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[Listed::Text("ollama")]),
                        ..NONE
                    },
                ),
            ],
            closed: Some(&["baseUrl", "model", "type"]),
            ..NONE
        },
    ),
    (
        "OneOrMoreAgents",
        Shape {
            kinds: Some(&[Kind::Object, Kind::Array]),
            one_of: &[
                reference("Agent"),
                Shape {
                    kinds: Some(&[Kind::Array]),
                    min_items: Some(1),
                    items: Some(&reference("Agent")),
                    ..NONE
                },
            ],
            ..NONE
        },
    ),
    (
        "OneOrMoreStrings",
        Shape {
            kinds: Some(&[Kind::Array, Kind::String]),
            one_of: &[
                of(&[Kind::String]),
                Shape {
                    kinds: Some(&[Kind::Array]),
                    min_items: Some(1),
                    items: Some(&of(&[Kind::String])),
                    ..NONE
                },
            ],
            ..NONE
        },
    ),
    (
        "OneOrMoreUris",
        Shape {
            kinds: Some(&[Kind::Array, Kind::String]),
            one_of: &[
                of(&[Kind::String]),
                Shape {
                    kinds: Some(&[Kind::Array]),
                    min_items: Some(1),
                    items: Some(&of(&[Kind::String])),
                    ..NONE
                },
            ],
            ..NONE
        },
    ),
    (
        "PdfClass",
        Shape {
            kinds: Some(&[Kind::String]),
            enumeration: Some(&[
                Listed::Text("A"),
                Listed::Text("B"),
                Listed::Text("C"),
                Listed::Text("D"),
                Listed::Text("E"),
                Listed::Text("F"),
                Listed::Text("G"),
            ]),
            ..NONE
        },
    ),
    (
        "PdfTextItem",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["start", "end", "page", "x", "y", "width", "height"],
            members: &[
                (
                    "end",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        minimum: Some(0.0),
                        ..NONE
                    },
                ),
                ("height", of(&[Kind::Number])),
                ("page", of(&[Kind::Integer])),
                (
                    "start",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        minimum: Some(0.0),
                        ..NONE
                    },
                ),
                ("width", of(&[Kind::Number])),
                ("x", of(&[Kind::Number])),
                ("y", of(&[Kind::Number])),
            ],
            ..NONE
        },
    ),
    (
        "PersistedEventId",
        Shape {
            kinds: Some(&[Kind::String]),
            pattern: Some(&[
                Step {
                    of: &[(112, 112)],
                    min: 1,
                    max: Some(1),
                },
                Step {
                    of: &[(45, 45)],
                    min: 1,
                    max: Some(1),
                },
                Step {
                    of: &[(0, 9), (11, 12), (14, 8231), (8234, 1114111)],
                    min: 1,
                    max: None,
                },
                Step {
                    of: &[(45, 45)],
                    min: 1,
                    max: Some(1),
                },
                Step {
                    of: &[(48, 57)],
                    min: 1,
                    max: None,
                },
            ]),
            ..NONE
        },
    ),
    (
        "PrincipalProfileCommand",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["name"],
            members: &[
                ("_userId", reference("UserId")),
                ("name", of(&[Kind::String])),
            ],
            ..NONE
        },
    ),
    (
        "PrincipalProfiledPayload",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["name"],
            members: &[("name", of(&[Kind::String]))],
            ..NONE
        },
    ),
    (
        "Profile",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["name", "since"],
            members: &[
                ("name", of(&[Kind::String])),
                ("since", of(&[Kind::String])),
            ],
            closed: Some(&["name", "since"]),
            ..NONE
        },
    ),
    (
        "ProfilesProjection",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["profiles"],
            members: &[(
                "profiles",
                Shape {
                    kinds: Some(&[Kind::Object]),
                    values: Some(&reference("Profile")),
                    ..NONE
                },
            )],
            closed: Some(&["profiles"]),
            ..NONE
        },
    ),
    (
        "ProtectedResourceMetadata",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &[
                "resource",
                "authorization_servers",
                "bearer_methods_supported",
            ],
            members: &[
                (
                    "authorization_servers",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&of(&[Kind::String])),
                        ..NONE
                    },
                ),
                (
                    "bearer_methods_supported",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&Shape {
                            kinds: Some(&[Kind::String]),
                            enumeration: Some(&[Listed::Text("header")]),
                            ..NONE
                        }),
                        ..NONE
                    },
                ),
                ("resource", of(&[Kind::String])),
                ("resource_name", of(&[Kind::String])),
            ],
            closed: Some(&[
                "authorization_servers",
                "bearer_methods_supported",
                "resource",
                "resource_name",
            ]),
            ..NONE
        },
    ),
    (
        "QdrantVectorsConfig",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["type", "host", "port", "tokenEnv"],
            members: &[
                (
                    "host",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        min_length: Some(1),
                        ..NONE
                    },
                ),
                (
                    "port",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        minimum: Some(1.0),
                        maximum: Some(65535.0),
                        ..NONE
                    },
                ),
                (
                    "tokenEnv",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        min_length: Some(1),
                        ..NONE
                    },
                ),
                (
                    "type",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[Listed::Text("qdrant")]),
                        ..NONE
                    },
                ),
            ],
            closed: Some(&["host", "port", "tokenEnv", "type"]),
            ..NONE
        },
    ),
    (
        "ReplyEventId",
        Shape {
            kinds: Some(&[Kind::String]),
            pattern: Some(&[
                Step {
                    of: &[(101, 101)],
                    min: 1,
                    max: Some(1),
                },
                Step {
                    of: &[(45, 45)],
                    min: 1,
                    max: Some(1),
                },
                Step {
                    of: &[(0, 57), (59, 1114111)],
                    min: 1,
                    max: None,
                },
                Step {
                    of: &[(58, 58)],
                    min: 1,
                    max: Some(1),
                },
                Step {
                    of: &[(0, 57), (59, 1114111)],
                    min: 1,
                    max: None,
                },
                Step {
                    of: &[(58, 58)],
                    min: 1,
                    max: Some(1),
                },
                Step {
                    of: &[(0, 9), (11, 12), (14, 8231), (8234, 1114111)],
                    min: 1,
                    max: None,
                },
            ]),
            ..NONE
        },
    ),
    (
        "Representation",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["mediaType"],
            members: &[
                ("@id", of(&[Kind::String])),
                ("@type", reference("OneOrMoreStrings")),
                (
                    "byteSize",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        minimum: Some(0.0),
                        ..NONE
                    },
                ),
                ("checksum", of(&[Kind::String])),
                ("conformsTo", reference("OneOrMoreUris")),
                ("created", of(&[Kind::String])),
                (
                    "duration",
                    Shape {
                        kinds: Some(&[Kind::Number]),
                        minimum: Some(0.0),
                        ..NONE
                    },
                ),
                ("encoding", of(&[Kind::String])),
                ("filename", of(&[Kind::String])),
                (
                    "height",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        minimum: Some(0.0),
                        ..NONE
                    },
                ),
                ("language", of(&[Kind::String])),
                ("mediaType", of(&[Kind::String])),
                ("modified", of(&[Kind::String])),
                (
                    "rel",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[
                            Listed::Text("original"),
                            Listed::Text("thumbnail"),
                            Listed::Text("preview"),
                            Listed::Text("optimized"),
                            Listed::Text("derived"),
                            Listed::Text("other"),
                        ]),
                        ..NONE
                    },
                ),
                ("storageUri", of(&[Kind::String])),
                (
                    "tags",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&of(&[Kind::String])),
                        ..NONE
                    },
                ),
                (
                    "width",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        minimum: Some(0.0),
                        ..NONE
                    },
                ),
            ],
            ..NONE
        },
    ),
    (
        "RepresentationAddedPayload",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["representation"],
            members: &[("representation", reference("Representation"))],
            ..NONE
        },
    ),
    (
        "RepresentationNotFound",
        Shape {
            kinds: Some(&[Kind::Object]),
            all_of: &[
                reference("ErrorResponse"),
                Shape {
                    kinds: Some(&[Kind::Object]),
                    required: &["code"],
                    members: &[(
                        "code",
                        Shape {
                            kinds: Some(&[Kind::String]),
                            enumeration: Some(&[
                                Listed::Text("resource"),
                                Listed::Text("representation"),
                            ]),
                            ..NONE
                        },
                    )],
                    ..NONE
                },
            ],
            ..NONE
        },
    ),
    (
        "RepresentationRemovedPayload",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["checksum"],
            members: &[("checksum", of(&[Kind::String]))],
            ..NONE
        },
    ),
    (
        "ResourceAnnotations",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["resourceId", "annotations", "version", "updatedAt"],
            members: &[
                (
                    "annotations",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&reference("Annotation")),
                        ..NONE
                    },
                ),
                ("resourceId", reference("ResourceId")),
                ("updatedAt", of(&[Kind::String])),
                (
                    "version",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        minimum: Some(0.0),
                        ..NONE
                    },
                ),
            ],
            closed: Some(&["annotations", "resourceId", "updatedAt", "version"]),
            ..NONE
        },
    ),
    (
        "ResourceArchivedPayload",
        Shape {
            kinds: Some(&[Kind::Object]),
            members: &[("reason", of(&[Kind::String]))],
            ..NONE
        },
    ),
    (
        "ResourceClonedPayload",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["name", "format", "contentChecksum", "parentResourceId"],
            members: &[
                ("contentByteSize", of(&[Kind::Integer])),
                ("contentChecksum", of(&[Kind::String])),
                ("creator", reference("Agent")),
                (
                    "entityTypes",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&of(&[Kind::String])),
                        ..NONE
                    },
                ),
                ("format", reference("ContentFormat")),
                ("language", of(&[Kind::String])),
                ("name", of(&[Kind::String])),
                ("parentResourceId", reference("ResourceId")),
                ("storageUri", of(&[Kind::String])),
                ("wasAttributedTo", reference("OneOrMoreAgents")),
            ],
            ..NONE
        },
    ),
    (
        "ResourceCreatedPayload",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["name", "format", "contentChecksum"],
            members: &[
                ("contentByteSize", of(&[Kind::Integer])),
                ("contentChecksum", of(&[Kind::String])),
                ("creator", reference("Agent")),
                (
                    "entityTypes",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&of(&[Kind::String])),
                        ..NONE
                    },
                ),
                ("format", reference("ContentFormat")),
                (
                    "generatedFrom",
                    Shape {
                        kinds: Some(&[Kind::Object]),
                        required: &["resourceId"],
                        members: &[
                            ("annotationId", reference("AnnotationId")),
                            ("resourceId", reference("ResourceId")),
                        ],
                        ..NONE
                    },
                ),
                ("generationPrompt", of(&[Kind::String])),
                ("generator", reference("OneOrMoreAgents")),
                ("isDraft", of(&[Kind::Boolean])),
                ("jobId", reference("JobId")),
                ("language", of(&[Kind::String])),
                ("name", of(&[Kind::String])),
                ("storageUri", of(&[Kind::String])),
                ("wasAttributedTo", reference("OneOrMoreAgents")),
            ],
            ..NONE
        },
    ),
    (
        "ResourceDescriptor",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["@context", "@id", "name", "representations"],
            members: &[
                (
                    "@context",
                    Shape {
                        kinds: Some(&[Kind::Object, Kind::Array, Kind::String]),
                        one_of: &[
                            of(&[Kind::String]),
                            of(&[Kind::Object]),
                            Shape {
                                kinds: Some(&[Kind::Array]),
                                items: Some(&Shape {
                                    kinds: Some(&[Kind::Object, Kind::String]),
                                    one_of: &[of(&[Kind::String]), of(&[Kind::Object])],
                                    ..NONE
                                }),
                                ..NONE
                            },
                        ],
                        ..NONE
                    },
                ),
                ("@id", reference("ResourceId")),
                ("@type", reference("OneOrMoreStrings")),
                ("about", reference("OneOrMoreStrings")),
                ("archived", of(&[Kind::Boolean])),
                (
                    "availableFormats",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&of(&[Kind::String])),
                        ..NONE
                    },
                ),
                ("conformsTo", reference("OneOrMoreUris")),
                ("dateCreated", of(&[Kind::String])),
                ("dateModified", of(&[Kind::String])),
                ("description", of(&[Kind::String])),
                (
                    "entityTypes",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&of(&[Kind::String])),
                        ..NONE
                    },
                ),
                ("generator", reference("OneOrMoreAgents")),
                (
                    "hasPart",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&of(&[Kind::String])),
                        ..NONE
                    },
                ),
                (
                    "identifier",
                    Shape {
                        kinds: Some(&[Kind::Object, Kind::Array, Kind::String]),
                        one_of: &[
                            of(&[Kind::String]),
                            Shape {
                                kinds: Some(&[Kind::Array]),
                                min_items: Some(1),
                                items: Some(&of(&[Kind::String])),
                                ..NONE
                            },
                            Shape {
                                kinds: Some(&[Kind::Object]),
                                members: &[
                                    ("@id", of(&[Kind::String])),
                                    ("scheme", of(&[Kind::String])),
                                    ("value", of(&[Kind::String])),
                                ],
                                ..NONE
                            },
                        ],
                        ..NONE
                    },
                ),
                ("isDraft", of(&[Kind::Boolean])),
                (
                    "isPartOf",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&of(&[Kind::String])),
                        ..NONE
                    },
                ),
                ("license", of(&[Kind::String])),
                ("name", of(&[Kind::String])),
                ("originatedFrom", of(&[Kind::String])),
                (
                    "representations",
                    Shape {
                        kinds: Some(&[Kind::Object, Kind::Array]),
                        one_of: &[
                            reference("Representation"),
                            Shape {
                                kinds: Some(&[Kind::Array]),
                                items: Some(&reference("Representation")),
                                ..NONE
                            },
                        ],
                        ..NONE
                    },
                ),
                (
                    "sameAs",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&of(&[Kind::String])),
                        ..NONE
                    },
                ),
                ("sourceAnnotationId", reference("AnnotationId")),
                ("sourceResourceId", reference("ResourceId")),
                ("version", of(&[Kind::String])),
                ("wasAttributedTo", reference("OneOrMoreAgents")),
                (
                    "wasDerivedFrom",
                    Shape {
                        kinds: Some(&[Kind::Array, Kind::String]),
                        one_of: &[
                            reference("ResourceId"),
                            Shape {
                                kinds: Some(&[Kind::Array]),
                                items: Some(&reference("ResourceId")),
                                ..NONE
                            },
                        ],
                        ..NONE
                    },
                ),
            ],
            ..NONE
        },
    ),
    (
        "ResourceErrorEvent",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["resourceId", "message"],
            members: &[
                ("message", of(&[Kind::String])),
                ("resourceId", reference("ResourceId")),
            ],
            ..NONE
        },
    ),
    (
        "ResourceId",
        Shape {
            kinds: Some(&[Kind::String]),
            pattern: Some(&[Step {
                of: &[(45, 45), (48, 57), (65, 90), (95, 95), (97, 122)],
                min: 1,
                max: Some(128),
            }]),
            ..NONE
        },
    ),
    (
        "ResourceMovedPayload",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["fromUri", "toUri"],
            members: &[
                ("fromUri", of(&[Kind::String])),
                ("toUri", of(&[Kind::String])),
            ],
            ..NONE
        },
    ),
    ("ResourceUnarchivedPayload", of(&[Kind::Object])),
    (
        "ResourceUpdatedPayload",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["contentChecksum"],
            members: &[
                ("contentByteSize", of(&[Kind::Integer])),
                ("contentChecksum", of(&[Kind::String])),
            ],
            ..NONE
        },
    ),
    (
        "ResourceUpload",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["name", "file", "format", "storageUri"],
            members: &[
                ("archiveOriginal", of(&[Kind::String])),
                ("cloneToken", of(&[Kind::String])),
                ("entityTypes", of(&[Kind::String])),
                ("file", of(&[Kind::String])),
                ("format", of(&[Kind::String])),
                ("generationPrompt", of(&[Kind::String])),
                ("generator", of(&[Kind::String])),
                ("isDraft", of(&[Kind::String])),
                ("jobId", reference("JobId")),
                ("language", of(&[Kind::String])),
                ("name", of(&[Kind::String])),
                ("sourceAnnotationId", reference("AnnotationId")),
                ("sourceResourceId", reference("ResourceId")),
                ("storageUri", of(&[Kind::String])),
            ],
            ..NONE
        },
    ),
    (
        "ResourceView",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["resource", "annotations", "lastSequence"],
            members: &[
                ("annotations", reference("ResourceAnnotations")),
                (
                    "lastSequence",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        minimum: Some(1.0),
                        ..NONE
                    },
                ),
                ("resource", reference("ResourceDescriptor")),
            ],
            closed: Some(&["annotations", "lastSequence", "resource"]),
            ..NONE
        },
    ),
    (
        "ScoredResource",
        Shape {
            kinds: Some(&[Kind::Object]),
            all_of: &[
                reference("ResourceDescriptor"),
                Shape {
                    kinds: Some(&[Kind::Object]),
                    members: &[
                        ("matchReason", of(&[Kind::String])),
                        ("score", of(&[Kind::Number])),
                    ],
                    ..NONE
                },
            ],
            ..NONE
        },
    ),
    (
        "Selector",
        Shape {
            kinds: Some(&[Kind::Object]),
            one_of: &[
                reference("TextPositionSelector"),
                reference("TextQuoteSelector"),
                reference("SvgSelector"),
                reference("FragmentSelector"),
            ],
            discriminator: Some(Discriminator {
                property: "type",
                mapping: &[
                    ("TextPositionSelector", 0),
                    ("TextQuoteSelector", 1),
                    ("SvgSelector", 2),
                    ("FragmentSelector", 3),
                ],
            }),
            ..NONE
        },
    ),
    (
        "SemanticMatch",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["text", "resourceId", "resourceName", "score"],
            members: &[
                ("annotationId", reference("AnnotationId")),
                (
                    "entityTypes",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&of(&[Kind::String])),
                        ..NONE
                    },
                ),
                ("machineRead", of(&[Kind::Boolean])),
                ("resourceId", reference("ResourceId")),
                ("resourceName", of(&[Kind::String])),
                ("score", of(&[Kind::Number])),
                ("text", of(&[Kind::String])),
            ],
            ..NONE
        },
    ),
    (
        "ServiceAddress",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["host", "port"],
            members: &[
                (
                    "host",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        min_length: Some(1),
                        ..NONE
                    },
                ),
                (
                    "port",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        minimum: Some(1.0),
                        maximum: Some(65535.0),
                        ..NONE
                    },
                ),
            ],
            closed: Some(&["host", "port"]),
            ..NONE
        },
    ),
    (
        "ServiceIdentity",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["issuer"],
            members: &[(
                "issuer",
                Shape {
                    kinds: Some(&[Kind::String]),
                    min_length: Some(1),
                    ..NONE
                },
            )],
            closed: Some(&["issuer"]),
            ..NONE
        },
    ),
    (
        "SessionJoinedEvent",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["participant", "connectionId"],
            members: &[
                ("connectionId", of(&[Kind::String])),
                ("participant", reference("UserId")),
            ],
            ..NONE
        },
    ),
    (
        "SessionLeftEvent",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["participant", "connectionId"],
            members: &[
                ("connectionId", of(&[Kind::String])),
                ("participant", reference("UserId")),
            ],
            ..NONE
        },
    ),
    (
        "SettingsHoverDelayChangedEvent",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["hoverDelayMs"],
            members: &[("hoverDelayMs", of(&[Kind::Integer]))],
            ..NONE
        },
    ),
    (
        "SettingsLocaleChangedEvent",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["locale"],
            members: &[("locale", of(&[Kind::String]))],
            ..NONE
        },
    ),
    (
        "SettingsThemeChangedEvent",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["theme"],
            members: &[(
                "theme",
                Shape {
                    kinds: Some(&[Kind::String]),
                    enumeration: Some(&[
                        Listed::Text("light"),
                        Listed::Text("dark"),
                        Listed::Text("system"),
                    ]),
                    ..NONE
                },
            )],
            ..NONE
        },
    ),
    (
        "SmeltRebuildAnchorsCommand",
        Shape {
            kinds: Some(&[Kind::Object]),
            members: &[
                ("_userId", reference("UserId")),
                ("resourceId", reference("ResourceId")),
            ],
            ..NONE
        },
    ),
    (
        "SmeltSettled",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["resourceId", "contentChecksum", "outcome"],
            members: &[
                ("contentChecksum", of(&[Kind::String])),
                (
                    "outcome",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[Listed::Text("indexed"), Listed::Text("skipped")]),
                        ..NONE
                    },
                ),
                (
                    "reason",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[
                            Listed::Text("no-extractor"),
                            Listed::Text("empty"),
                            Listed::Text("no-text-layer"),
                            Listed::Text("encrypted"),
                            Listed::Text("corrupt"),
                            Listed::Text("too-large"),
                        ]),
                        ..NONE
                    },
                ),
                ("resourceId", reference("ResourceId")),
            ],
            ..NONE
        },
    ),
    (
        "SmelterConfig",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &[
                "kb",
                "gatewayUrl",
                "identity",
                "archivist",
                "embedding",
                "vectors",
                "chunking",
                "pdfsAtOnce",
                "cursorsPath",
                "port",
                "logLevel",
                "logFormat",
            ],
            members: &[
                ("archivist", reference("ServiceAddress")),
                (
                    "chunking",
                    Shape {
                        kinds: Some(&[Kind::Object]),
                        required: &["chunkSize", "overlap"],
                        members: &[
                            (
                                "chunkSize",
                                Shape {
                                    kinds: Some(&[Kind::Integer]),
                                    minimum: Some(1.0),
                                    ..NONE
                                },
                            ),
                            (
                                "overlap",
                                Shape {
                                    kinds: Some(&[Kind::Integer]),
                                    minimum: Some(0.0),
                                    ..NONE
                                },
                            ),
                        ],
                        closed: Some(&["chunkSize", "overlap"]),
                        ..NONE
                    },
                ),
                ("cursorsPath", reference("CursorsPath")),
                ("embedding", reference("EmbeddingConfig")),
                (
                    "gatewayUrl",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        min_length: Some(1),
                        ..NONE
                    },
                ),
                ("identity", reference("ServiceIdentity")),
                ("kb", reference("KbIdentity")),
                ("logFormat", reference("LogFormat")),
                ("logLevel", reference("LogLevel")),
                (
                    "pdfsAtOnce",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        minimum: Some(1.0),
                        ..NONE
                    },
                ),
                (
                    "port",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        minimum: Some(1.0),
                        maximum: Some(65535.0),
                        ..NONE
                    },
                ),
                ("vectors", reference("VectorsConfig")),
            ],
            closed: Some(&[
                "archivist",
                "chunking",
                "cursorsPath",
                "embedding",
                "gatewayUrl",
                "identity",
                "kb",
                "logFormat",
                "logLevel",
                "pdfsAtOnce",
                "port",
                "vectors",
            ]),
            ..NONE
        },
    ),
    (
        "SpecificResource",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["type", "source"],
            members: &[
                ("purpose", reference("BodyPurpose")),
                ("source", reference("ResourceId")),
                (
                    "type",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[Listed::Text("SpecificResource")]),
                        ..NONE
                    },
                ),
            ],
            ..NONE
        },
    ),
    (
        "StatusResponse",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["status", "version", "features", "message"],
            members: &[
                ("authenticatedAs", of(&[Kind::String])),
                (
                    "features",
                    Shape {
                        kinds: Some(&[Kind::Object]),
                        required: &["semanticContent", "collaboration"],
                        members: &[
                            ("collaboration", of(&[Kind::String])),
                            ("semanticContent", of(&[Kind::String])),
                        ],
                        ..NONE
                    },
                ),
                ("message", of(&[Kind::String])),
                ("status", of(&[Kind::String])),
                ("version", of(&[Kind::String])),
            ],
            ..NONE
        },
    ),
    (
        "StorageUriEntry",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["uri", "resourceId"],
            members: &[
                ("resourceId", reference("ResourceId")),
                ("uri", of(&[Kind::String])),
            ],
            closed: Some(&["resourceId", "uri"]),
            ..NONE
        },
    ),
    (
        "StoredEventResponse",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &[
                "id",
                "type",
                "timestamp",
                "userId",
                "version",
                "payload",
                "metadata",
            ],
            members: &[
                ("id", of(&[Kind::String])),
                ("metadata", reference("EventMetadata")),
                ("payload", of(&[Kind::Object])),
                ("resourceId", reference("ResourceId")),
                ("timestamp", of(&[Kind::String])),
                ("type", of(&[Kind::String])),
                ("userId", reference("UserId")),
                ("version", of(&[Kind::Integer])),
            ],
            ..NONE
        },
    ),
    (
        "SupportedMediaType",
        Shape {
            kinds: Some(&[Kind::String]),
            enumeration: Some(&[
                Listed::Text("text/plain"),
                Listed::Text("text/markdown"),
                Listed::Text("text/html"),
                Listed::Text("text/css"),
                Listed::Text("text/csv"),
                Listed::Text("text/xml"),
                Listed::Text("application/json"),
                Listed::Text("application/xml"),
                Listed::Text("application/yaml"),
                Listed::Text("application/x-yaml"),
                Listed::Text("application/pdf"),
                Listed::Text("application/msword"),
                Listed::Text(
                    "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
                ),
                Listed::Text("application/vnd.ms-excel"),
                Listed::Text("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"),
                Listed::Text("application/vnd.ms-powerpoint"),
                Listed::Text(
                    "application/vnd.openxmlformats-officedocument.presentationml.presentation",
                ),
                Listed::Text("application/zip"),
                Listed::Text("application/gzip"),
                Listed::Text("application/x-tar"),
                Listed::Text("application/x-7z-compressed"),
                Listed::Text("application/octet-stream"),
                Listed::Text("application/wasm"),
                Listed::Text("image/png"),
                Listed::Text("image/jpeg"),
                Listed::Text("image/gif"),
                Listed::Text("image/webp"),
                Listed::Text("image/svg+xml"),
                Listed::Text("image/bmp"),
                Listed::Text("image/tiff"),
                Listed::Text("image/x-icon"),
                Listed::Text("video/mp4"),
                Listed::Text("video/mpeg"),
                Listed::Text("video/webm"),
                Listed::Text("video/ogg"),
                Listed::Text("video/quicktime"),
                Listed::Text("video/x-msvideo"),
                Listed::Text("audio/mpeg"),
                Listed::Text("audio/wav"),
                Listed::Text("audio/ogg"),
                Listed::Text("audio/webm"),
                Listed::Text("audio/aac"),
                Listed::Text("audio/flac"),
                Listed::Text("text/javascript"),
                Listed::Text("application/javascript"),
                Listed::Text("text/x-typescript"),
                Listed::Text("application/typescript"),
                Listed::Text("text/x-python"),
                Listed::Text("text/x-java"),
                Listed::Text("text/x-c"),
                Listed::Text("text/x-c++"),
                Listed::Text("text/x-csharp"),
                Listed::Text("text/x-go"),
                Listed::Text("text/x-rust"),
                Listed::Text("text/x-ruby"),
                Listed::Text("text/x-php"),
                Listed::Text("text/x-swift"),
                Listed::Text("text/x-kotlin"),
                Listed::Text("text/x-shell"),
                Listed::Text("font/woff"),
                Listed::Text("font/woff2"),
                Listed::Text("font/ttf"),
                Listed::Text("font/otf"),
            ]),
            ..NONE
        },
    ),
    (
        "SvgSelector",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["type", "value"],
            members: &[
                (
                    "type",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[Listed::Text("SvgSelector")]),
                        ..NONE
                    },
                ),
                ("value", of(&[Kind::String])),
            ],
            ..NONE
        },
    ),
    (
        "TagCategory",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["name", "description", "examples"],
            members: &[
                ("description", of(&[Kind::String])),
                (
                    "examples",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&of(&[Kind::String])),
                        ..NONE
                    },
                ),
                ("name", of(&[Kind::String])),
            ],
            ..NONE
        },
    ),
    (
        "TagSchema",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["id", "name", "description", "domain", "tags"],
            members: &[
                ("description", of(&[Kind::String])),
                ("domain", of(&[Kind::String])),
                ("id", of(&[Kind::String])),
                ("name", of(&[Kind::String])),
                (
                    "tags",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&reference("TagCategory")),
                        ..NONE
                    },
                ),
            ],
            ..NONE
        },
    ),
    (
        "TagSchemaAddedPayload",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["schema"],
            members: &[("schema", reference("TagSchema"))],
            ..NONE
        },
    ),
    (
        "TagSchemasProjection",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["tagSchemas"],
            members: &[(
                "tagSchemas",
                Shape {
                    kinds: Some(&[Kind::Array]),
                    items: Some(&reference("TagSchema")),
                    ..NONE
                },
            )],
            closed: Some(&["tagSchemas"]),
            ..NONE
        },
    ),
    (
        "TaggingJobParams",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["motivation", "schemaId", "categories"],
            members: &[
                (
                    "categories",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        min_items: Some(1),
                        items: Some(&of(&[Kind::String])),
                        ..NONE
                    },
                ),
                ("language", of(&[Kind::String])),
                (
                    "motivation",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[Listed::Text("tagging")]),
                        ..NONE
                    },
                ),
                (
                    "schemaId",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        min_length: Some(1),
                        ..NONE
                    },
                ),
                ("sourceLanguage", of(&[Kind::String])),
            ],
            closed: Some(&[
                "categories",
                "language",
                "motivation",
                "schemaId",
                "sourceLanguage",
            ]),
            ..NONE
        },
    ),
    (
        "TextPositionSelector",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["type", "start", "end"],
            members: &[
                (
                    "end",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        minimum: Some(0.0),
                        ..NONE
                    },
                ),
                (
                    "start",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        minimum: Some(0.0),
                        ..NONE
                    },
                ),
                (
                    "type",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[Listed::Text("TextPositionSelector")]),
                        ..NONE
                    },
                ),
            ],
            ..NONE
        },
    ),
    (
        "TextQuoteSelector",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["type", "exact"],
            members: &[
                ("exact", of(&[Kind::String])),
                ("prefix", of(&[Kind::String])),
                ("suffix", of(&[Kind::String])),
                (
                    "type",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[Listed::Text("TextQuoteSelector")]),
                        ..NONE
                    },
                ),
            ],
            ..NONE
        },
    ),
    (
        "TextualBody",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["type", "value"],
            members: &[
                ("format", of(&[Kind::String])),
                ("language", of(&[Kind::String])),
                ("purpose", reference("BodyPurpose")),
                (
                    "type",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[Listed::Text("TextualBody")]),
                        ..NONE
                    },
                ),
                ("value", of(&[Kind::String])),
            ],
            ..NONE
        },
    ),
    (
        "UnitCursor",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["next", "size", "found", "emitted", "errors"],
            members: &[
                (
                    "emitted",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        minimum: Some(0.0),
                        ..NONE
                    },
                ),
                (
                    "errors",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        minimum: Some(0.0),
                        ..NONE
                    },
                ),
                (
                    "found",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        minimum: Some(0.0),
                        ..NONE
                    },
                ),
                (
                    "next",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        minimum: Some(0.0),
                        ..NONE
                    },
                ),
                (
                    "size",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        minimum: Some(1.0),
                        ..NONE
                    },
                ),
            ],
            ..NONE
        },
    ),
    (
        "UpdateAnnotationBodyRequest",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["resourceId", "operations"],
            members: &[
                (
                    "operations",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        min_items: Some(1),
                        items: Some(&reference("BodyOperation")),
                        ..NONE
                    },
                ),
                ("resourceId", reference("ResourceId")),
            ],
            ..NONE
        },
    ),
    (
        "UserId",
        Shape {
            kinds: Some(&[Kind::String]),
            pattern: Some(&[
                Step {
                    of: &[(100, 100)],
                    min: 1,
                    max: Some(1),
                },
                Step {
                    of: &[(105, 105)],
                    min: 1,
                    max: Some(1),
                },
                Step {
                    of: &[(100, 100)],
                    min: 1,
                    max: Some(1),
                },
                Step {
                    of: &[(58, 58)],
                    min: 1,
                    max: Some(1),
                },
                Step {
                    of: &[
                        (0, 8),
                        (14, 31),
                        (33, 159),
                        (161, 5759),
                        (5761, 8191),
                        (8203, 8231),
                        (8234, 8238),
                        (8240, 8286),
                        (8288, 12287),
                        (12289, 65278),
                        (65280, 1114111),
                    ],
                    min: 1,
                    max: None,
                },
            ]),
            ..NONE
        },
    ),
    (
        "UserResponse",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["did", "email", "name", "image", "domain"],
            members: &[
                ("did", reference("UserId")),
                ("domain", of(&[Kind::String])),
                ("email", of(&[Kind::String, Kind::Null])),
                ("image", of(&[Kind::String, Kind::Null])),
                ("name", of(&[Kind::String, Kind::Null])),
            ],
            ..NONE
        },
    ),
    (
        "VectorsConfig",
        Shape {
            kinds: Some(&[Kind::Object]),
            one_of: &[
                reference("QdrantVectorsConfig"),
                reference("MemoryVectorsConfig"),
            ],
            discriminator: Some(Discriminator {
                property: "type",
                mapping: &[("qdrant", 0), ("memory", 1)],
            }),
            ..NONE
        },
    ),
    (
        "VoyageEmbeddingConfig",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["type", "model", "endpoint", "apiKeyEnv"],
            members: &[
                (
                    "apiKeyEnv",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        min_length: Some(1),
                        ..NONE
                    },
                ),
                (
                    "endpoint",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        min_length: Some(1),
                        ..NONE
                    },
                ),
                (
                    "model",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        min_length: Some(1),
                        ..NONE
                    },
                ),
                (
                    "type",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[Listed::Text("voyage")]),
                        ..NONE
                    },
                ),
            ],
            closed: Some(&["apiKeyEnv", "endpoint", "model", "type"]),
            ..NONE
        },
    ),
    (
        "WeaveApplied",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["resourceId", "sequenceNumber"],
            members: &[
                ("resourceId", reference("ResourceId")),
                ("sequenceNumber", of(&[Kind::Integer])),
            ],
            ..NONE
        },
    ),
    (
        "WeaveRebuildCommand",
        Shape {
            kinds: Some(&[Kind::Object]),
            members: &[
                ("_userId", reference("UserId")),
                ("resourceId", reference("ResourceId")),
            ],
            ..NONE
        },
    ),
    (
        "WeaverConfig",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &[
                "kb",
                "gatewayUrl",
                "identity",
                "archivist",
                "graph",
                "cursorsPath",
                "port",
                "logLevel",
                "logFormat",
            ],
            members: &[
                ("archivist", reference("ServiceAddress")),
                ("cursorsPath", reference("CursorsPath")),
                (
                    "gatewayUrl",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        min_length: Some(1),
                        ..NONE
                    },
                ),
                ("graph", reference("GraphConfig")),
                ("identity", reference("ServiceIdentity")),
                ("kb", reference("KbIdentity")),
                ("logFormat", reference("LogFormat")),
                ("logLevel", reference("LogLevel")),
                (
                    "port",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        minimum: Some(1.0),
                        maximum: Some(65535.0),
                        ..NONE
                    },
                ),
            ],
            closed: Some(&[
                "archivist",
                "cursorsPath",
                "gatewayUrl",
                "graph",
                "identity",
                "kb",
                "logFormat",
                "logLevel",
                "port",
            ]),
            ..NONE
        },
    ),
    (
        "WorkerConfig",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &[
                "knowledgeBases",
                "modelCatalogue",
                "port",
                "logLevel",
                "logFormat",
            ],
            members: &[
                (
                    "knowledgeBases",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        min_items: Some(1),
                        items: Some(&reference("WorkerKnowledgeBaseConfig")),
                        ..NONE
                    },
                ),
                ("logFormat", reference("LogFormat")),
                ("logLevel", reference("LogLevel")),
                (
                    "modelCatalogue",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        min_length: Some(1),
                        ..NONE
                    },
                ),
                (
                    "port",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        minimum: Some(1.0),
                        maximum: Some(65535.0),
                        ..NONE
                    },
                ),
            ],
            closed: Some(&[
                "knowledgeBases",
                "logFormat",
                "logLevel",
                "modelCatalogue",
                "port",
            ]),
            ..NONE
        },
    ),
    (
        "WorkerEngineConfig",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["engine", "jobs", "baseUrl"],
            members: &[
                (
                    "apiKeyEnv",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        min_length: Some(1),
                        ..NONE
                    },
                ),
                (
                    "baseUrl",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        min_length: Some(1),
                        ..NONE
                    },
                ),
                ("engine", reference("Engine")),
                (
                    "jobs",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        min_items: Some(1),
                        items: Some(&reference("JobFilter")),
                        ..NONE
                    },
                ),
            ],
            closed: Some(&["apiKeyEnv", "baseUrl", "engine", "jobs"]),
            ..NONE
        },
    ),
    (
        "WorkerEngineHealth",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &[
                "engine",
                "jobs",
                "lastQueuedEventAt",
                "lastClaimAt",
                "lastFinishedAt",
                "lastActivityAt",
                "activeJob",
                "jobsCompleted",
            ],
            members: &[
                (
                    "activeJob",
                    Shape {
                        kinds: Some(&[Kind::Object, Kind::Null]),
                        required: &["jobId", "type", "since"],
                        members: &[
                            ("jobId", reference("JobId")),
                            ("since", of(&[Kind::String])),
                            ("type", reference("JobType")),
                        ],
                        closed: Some(&["jobId", "since", "type"]),
                        ..NONE
                    },
                ),
                ("engine", reference("Engine")),
                (
                    "jobs",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        min_items: Some(1),
                        items: Some(&reference("JobFilter")),
                        ..NONE
                    },
                ),
                (
                    "jobsCompleted",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        minimum: Some(0.0),
                        ..NONE
                    },
                ),
                ("lastActivityAt", of(&[Kind::String, Kind::Null])),
                ("lastClaimAt", of(&[Kind::String, Kind::Null])),
                ("lastFinishedAt", of(&[Kind::String, Kind::Null])),
                ("lastQueuedEventAt", of(&[Kind::String, Kind::Null])),
            ],
            closed: Some(&[
                "activeJob",
                "engine",
                "jobs",
                "jobsCompleted",
                "lastActivityAt",
                "lastClaimAt",
                "lastFinishedAt",
                "lastQueuedEventAt",
            ]),
            ..NONE
        },
    ),
    (
        "WorkerHealth",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["status", "knowledgeBases"],
            members: &[
                (
                    "knowledgeBases",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        min_items: Some(1),
                        items: Some(&reference("WorkerKnowledgeBaseHealth")),
                        ..NONE
                    },
                ),
                (
                    "status",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[Listed::Text("ok")]),
                        ..NONE
                    },
                ),
            ],
            closed: Some(&["knowledgeBases", "status"]),
            ..NONE
        },
    ),
    (
        "WorkerKnowledgeBaseConfig",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["domain", "gatewayUrl", "identity", "engines"],
            members: &[
                (
                    "domain",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        min_length: Some(1),
                        ..NONE
                    },
                ),
                (
                    "engines",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        min_items: Some(1),
                        items: Some(&reference("WorkerEngineConfig")),
                        ..NONE
                    },
                ),
                (
                    "gatewayUrl",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        min_length: Some(1),
                        ..NONE
                    },
                ),
                (
                    "identity",
                    Shape {
                        kinds: Some(&[Kind::Object]),
                        required: &["issuer", "clientId"],
                        members: &[
                            (
                                "clientId",
                                Shape {
                                    kinds: Some(&[Kind::String]),
                                    min_length: Some(1),
                                    ..NONE
                                },
                            ),
                            (
                                "issuer",
                                Shape {
                                    kinds: Some(&[Kind::String]),
                                    min_length: Some(1),
                                    ..NONE
                                },
                            ),
                        ],
                        closed: Some(&["clientId", "issuer"]),
                        ..NONE
                    },
                ),
            ],
            closed: Some(&["domain", "engines", "gatewayUrl", "identity"]),
            ..NONE
        },
    ),
    (
        "WorkerKnowledgeBaseHealth",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["domain", "state"],
            members: &[
                (
                    "did",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        min_length: Some(1),
                        ..NONE
                    },
                ),
                (
                    "domain",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        min_length: Some(1),
                        ..NONE
                    },
                ),
                (
                    "engines",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        min_items: Some(1),
                        items: Some(&reference("WorkerEngineHealth")),
                        ..NONE
                    },
                ),
                (
                    "state",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[
                            Listed::Text("starting"),
                            Listed::Text("working"),
                            Listed::Text("refused"),
                        ]),
                        ..NONE
                    },
                ),
            ],
            closed: Some(&["did", "domain", "engines", "state"]),
            ..NONE
        },
    ),
    (
        "YieldCloneCreateCommand",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &[
                "token",
                "name",
                "storageUri",
                "contentChecksum",
                "byteSize",
                "format",
            ],
            members: &[
                ("_userId", reference("UserId")),
                ("archiveOriginal", of(&[Kind::Boolean])),
                ("byteSize", of(&[Kind::Integer])),
                ("contentChecksum", of(&[Kind::String])),
                ("format", reference("ContentFormat")),
                ("name", of(&[Kind::String])),
                ("storageUri", of(&[Kind::String])),
                ("token", of(&[Kind::String])),
            ],
            ..NONE
        },
    ),
    (
        "YieldCloneCreated",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["response"],
            members: &[("response", reference("YieldedResource"))],
            ..NONE
        },
    ),
    (
        "YieldClonePersistCommand",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &[
                "name",
                "storageUri",
                "contentChecksum",
                "byteSize",
                "format",
                "parentResourceId",
            ],
            members: &[
                ("_userId", reference("UserId")),
                ("byteSize", of(&[Kind::Integer])),
                ("contentChecksum", of(&[Kind::String])),
                (
                    "entityTypes",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&of(&[Kind::String])),
                        ..NONE
                    },
                ),
                ("format", reference("ContentFormat")),
                ("language", of(&[Kind::String])),
                ("name", of(&[Kind::String])),
                ("parentResourceId", reference("ResourceId")),
                ("storageUri", of(&[Kind::String])),
            ],
            ..NONE
        },
    ),
    (
        "YieldClonePersistOk",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["response"],
            members: &[("response", reference("YieldedResource"))],
            ..NONE
        },
    ),
    (
        "YieldCloneResourceRequest",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["token"],
            members: &[("token", of(&[Kind::String]))],
            ..NONE
        },
    ),
    (
        "YieldCloneTokenRequest",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["resourceId"],
            members: &[("resourceId", reference("ResourceId"))],
            ..NONE
        },
    ),
    (
        "YieldCreateCommand",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &[
                "name",
                "storageUri",
                "contentChecksum",
                "byteSize",
                "format",
            ],
            members: &[
                (
                    "_roles",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&of(&[Kind::String])),
                        ..NONE
                    },
                ),
                ("_userId", reference("UserId")),
                ("byteSize", of(&[Kind::Integer])),
                ("contentChecksum", of(&[Kind::String])),
                (
                    "entityTypes",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&of(&[Kind::String])),
                        ..NONE
                    },
                ),
                ("format", reference("ContentFormat")),
                (
                    "generatedFrom",
                    Shape {
                        kinds: Some(&[Kind::Object]),
                        members: &[
                            ("annotationId", reference("AnnotationId")),
                            ("resourceId", reference("ResourceId")),
                        ],
                        ..NONE
                    },
                ),
                ("generationPrompt", of(&[Kind::String])),
                ("generator", reference("OneOrMoreAgents")),
                ("isDraft", of(&[Kind::Boolean])),
                ("jobId", reference("JobId")),
                ("language", of(&[Kind::String])),
                ("name", of(&[Kind::String])),
                ("storageUri", of(&[Kind::String])),
            ],
            ..NONE
        },
    ),
    (
        "YieldCreateOk",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["response"],
            members: &[("response", reference("YieldedResource"))],
            ..NONE
        },
    ),
    (
        "YieldJobCompleteCommand",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["resourceId", "jobId", "jobType"],
            members: &[
                ("_userId", reference("UserId")),
                ("annotationId", reference("AnnotationId")),
                ("attempt", of(&[Kind::Integer])),
                ("durability", reference("DurabilityEvidence")),
                ("jobId", reference("JobId")),
                (
                    "jobType",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[Listed::Text("yield")]),
                        ..NONE
                    },
                ),
                ("resourceId", reference("ResourceId")),
                ("result", reference("YieldJobResult")),
            ],
            ..NONE
        },
    ),
    (
        "YieldJobCreateCommand",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["jobType", "params"],
            members: &[
                (
                    "_roles",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&of(&[Kind::String])),
                        ..NONE
                    },
                ),
                ("_userId", reference("UserId")),
                (
                    "jobType",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[Listed::Text("yield")]),
                        ..NONE
                    },
                ),
                ("params", reference("GenerationJobParams")),
            ],
            closed: Some(&["_roles", "_userId", "jobType", "params"]),
            ..NONE
        },
    ),
    (
        "YieldJobDone",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["resourceId", "resourceName", "truncated"],
            members: &[
                ("resourceId", reference("ResourceId")),
                ("resourceName", of(&[Kind::String])),
                ("truncated", of(&[Kind::Boolean])),
            ],
            closed: Some(&["resourceId", "resourceName", "truncated"]),
            ..NONE
        },
    ),
    (
        "YieldJobFilter",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["jobType"],
            members: &[(
                "jobType",
                Shape {
                    kinds: Some(&[Kind::String]),
                    enumeration: Some(&[Listed::Text("yield")]),
                    ..NONE
                },
            )],
            closed: Some(&["jobType"]),
            ..NONE
        },
    ),
    (
        "YieldJobQueuedEvent",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["jobId", "jobType", "resourceId", "userId", "params"],
            members: &[
                ("jobId", reference("JobId")),
                (
                    "jobType",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[Listed::Text("yield")]),
                        ..NONE
                    },
                ),
                ("params", reference("GenerationJobRequest")),
                ("resourceId", reference("ResourceId")),
                ("userId", reference("UserId")),
            ],
            ..NONE
        },
    ),
    (
        "YieldJobResult",
        Shape {
            kinds: Some(&[Kind::Object]),
            one_of: &[reference("YieldJobDone"), reference("JobDeclined")],
            ..NONE
        },
    ),
    (
        "YieldUpdateCommand",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["resourceId", "storageUri", "contentChecksum", "byteSize"],
            members: &[
                ("_userId", reference("UserId")),
                ("byteSize", of(&[Kind::Integer])),
                ("contentChecksum", of(&[Kind::String])),
                ("resourceId", reference("ResourceId")),
                ("storageUri", of(&[Kind::String])),
            ],
            ..NONE
        },
    ),
    (
        "YieldUpdateOk",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["response"],
            members: &[("response", reference("YieldedResource"))],
            ..NONE
        },
    ),
    (
        "YieldedResource",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["resourceId"],
            members: &[("resourceId", reference("ResourceId"))],
            ..NONE
        },
    ),
];
