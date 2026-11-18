// Generated from the component schemas of protocol/specs/src/openapi.json; do not edit.
// Regenerate: make generate (codegen/lib/required/rust.ml)
pub(crate) const SCHEMAS: &[(&str, Shape)] = &[
    (
        "Agent",
        Shape {
            kinds: Some(&[Kind::Object]),
            one_of: &[
                Shape {
                    reference: Some("AgentPerson"),
                    ..NONE
                },
                Shape {
                    reference: Some("AgentOrganization"),
                    ..NONE
                },
                Shape {
                    reference: Some("AgentSoftware"),
                    ..NONE
                },
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
                (
                    "@id",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "@type",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[Listed::Text("Organization")]),
                        ..NONE
                    },
                ),
                (
                    "homepage",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "name",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
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
                (
                    "@id",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "@type",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[Listed::Text("Person")]),
                        ..NONE
                    },
                ),
                (
                    "email",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "email_sha1",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "homepage",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "name",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "nickname",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
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
                (
                    "@id",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "@type",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[Listed::Text("Software")]),
                        ..NONE
                    },
                ),
                (
                    "model",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "name",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "parameters",
                    Shape {
                        kinds: Some(&[Kind::Object]),
                        ..NONE
                    },
                ),
                (
                    "provider",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
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
                        items: Some(&Shape {
                            reference: Some("PdfTextItem"),
                            ..NONE
                        }),
                        ..NONE
                    },
                ),
                (
                    "text",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
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
                Shape {
                    reference: Some("ExtractedText"),
                    ..NONE
                },
                Shape {
                    reference: Some("ExtractionDeclined"),
                    ..NONE
                },
                Shape {
                    reference: Some("AnchoredTextAbsent"),
                    ..NONE
                },
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
                (
                    "declined",
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
                Shape {
                    reference: Some("AnchoredTextExtractedEntry"),
                    ..NONE
                },
                Shape {
                    reference: Some("AnchoredTextDeclinedEntry"),
                    ..NONE
                },
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
                                (
                                    "h",
                                    Shape {
                                        kinds: Some(&[Kind::Number]),
                                        ..NONE
                                    },
                                ),
                                (
                                    "p",
                                    Shape {
                                        kinds: Some(&[Kind::Integer]),
                                        ..NONE
                                    },
                                ),
                                (
                                    "words",
                                    Shape {
                                        kinds: Some(&[Kind::Array]),
                                        items: Some(&Shape {
                                            kinds: Some(&[Kind::Array]),
                                            min_items: Some(4),
                                            max_items: Some(4),
                                            items: Some(&Shape {
                                                kinds: Some(&[Kind::Number]),
                                                ..NONE
                                            }),
                                            ..NONE
                                        }),
                                        ..NONE
                                    },
                                ),
                                (
                                    "y",
                                    Shape {
                                        kinds: Some(&[Kind::Number]),
                                        ..NONE
                                    },
                                ),
                            ],
                            closed: Some(&["h", "p", "words", "y"]),
                            ..NONE
                        }),
                        ..NONE
                    },
                ),
                (
                    "method",
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
                    "ocrConfidence",
                    Shape {
                        kinds: Some(&[Kind::Object]),
                        required: &["mean", "lowConfidenceWords", "totalWords"],
                        members: &[
                            (
                                "lowConfidenceWords",
                                Shape {
                                    kinds: Some(&[Kind::Integer]),
                                    ..NONE
                                },
                            ),
                            (
                                "mean",
                                Shape {
                                    kinds: Some(&[Kind::Number]),
                                    ..NONE
                                },
                            ),
                            (
                                "totalWords",
                                Shape {
                                    kinds: Some(&[Kind::Integer]),
                                    ..NONE
                                },
                            ),
                        ],
                        ..NONE
                    },
                ),
                (
                    "pdfClass",
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
                    "stamp",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        min_length: Some(1),
                        ..NONE
                    },
                ),
                (
                    "text",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "unreadPages",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&Shape {
                            kinds: Some(&[Kind::Integer]),
                            ..NONE
                        }),
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
                (
                    "entry",
                    Shape {
                        reference: Some("AnchoredTextEntry"),
                        ..NONE
                    },
                ),
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
                (
                    "body",
                    Shape {
                        reference: Some("AnnotationBodies"),
                        ..NONE
                    },
                ),
                (
                    "created",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "creator",
                    Shape {
                        reference: Some("Agent"),
                        ..NONE
                    },
                ),
                (
                    "generator",
                    Shape {
                        kinds: Some(&[Kind::Object, Kind::Array]),
                        one_of: &[
                            Shape {
                                reference: Some("Agent"),
                                ..NONE
                            },
                            Shape {
                                kinds: Some(&[Kind::Array]),
                                min_items: Some(1),
                                items: Some(&Shape {
                                    reference: Some("Agent"),
                                    ..NONE
                                }),
                                ..NONE
                            },
                        ],
                        ..NONE
                    },
                ),
                (
                    "id",
                    Shape {
                        reference: Some("AnnotationId"),
                        ..NONE
                    },
                ),
                (
                    "modified",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "motivation",
                    Shape {
                        reference: Some("Motivation"),
                        ..NONE
                    },
                ),
                (
                    "target",
                    Shape {
                        kinds: Some(&[Kind::Object, Kind::String]),
                        one_of: &[
                            Shape {
                                reference: Some("ResourceId"),
                                ..NONE
                            },
                            Shape {
                                reference: Some("AnnotationTarget"),
                                ..NONE
                            },
                        ],
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
                (
                    "wasAttributedTo",
                    Shape {
                        kinds: Some(&[Kind::Object, Kind::Array]),
                        one_of: &[
                            Shape {
                                reference: Some("Agent"),
                                ..NONE
                            },
                            Shape {
                                kinds: Some(&[Kind::Array]),
                                min_items: Some(1),
                                items: Some(&Shape {
                                    reference: Some("Agent"),
                                    ..NONE
                                }),
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
        "AnnotationAddedPayload",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["annotation"],
            members: &[
                (
                    "annotation",
                    Shape {
                        reference: Some("Annotation"),
                        ..NONE
                    },
                ),
                (
                    "contentChecksum",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
            ],
            ..NONE
        },
    ),
    (
        "AnnotationBodies",
        Shape {
            kinds: Some(&[Kind::Object, Kind::Array]),
            one_of: &[
                Shape {
                    reference: Some("AnnotationBody"),
                    ..NONE
                },
                Shape {
                    kinds: Some(&[Kind::Array]),
                    min_items: Some(1),
                    items: Some(&Shape {
                        reference: Some("AnnotationBody"),
                        ..NONE
                    }),
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
            one_of: &[
                Shape {
                    reference: Some("TextualBody"),
                    ..NONE
                },
                Shape {
                    reference: Some("SpecificResource"),
                    ..NONE
                },
            ],
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
                (
                    "annotationId",
                    Shape {
                        reference: Some("AnnotationId"),
                        ..NONE
                    },
                ),
                (
                    "operations",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&Shape {
                            kinds: Some(&[Kind::Object]),
                            one_of: &[
                                Shape {
                                    reference: Some("BodyOperationAdd"),
                                    ..NONE
                                },
                                Shape {
                                    reference: Some("BodyOperationRemove"),
                                    ..NONE
                                },
                                Shape {
                                    reference: Some("BodyOperationReplace"),
                                    ..NONE
                                },
                            ],
                            ..NONE
                        }),
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
            members: &[(
                "annotationId",
                Shape {
                    reference: Some("AnnotationId"),
                    ..NONE
                },
            )],
            ..NONE
        },
    ),
    (
        "AnnotationSelector",
        Shape {
            kinds: Some(&[Kind::Object, Kind::Array]),
            one_of: &[
                Shape {
                    reference: Some("Selector"),
                    ..NONE
                },
                Shape {
                    kinds: Some(&[Kind::Array]),
                    items: Some(&Shape {
                        reference: Some("Selector"),
                        ..NONE
                    }),
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
                (
                    "selector",
                    Shape {
                        reference: Some("AnnotationSelector"),
                        ..NONE
                    },
                ),
                (
                    "source",
                    Shape {
                        reference: Some("ResourceId"),
                        ..NONE
                    },
                ),
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
                (
                    "engines",
                    Shape {
                        reference: Some("ArchivistEngines"),
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
                    "logFormat",
                    Shape {
                        reference: Some("LogFormat"),
                        ..NONE
                    },
                ),
                (
                    "logLevel",
                    Shape {
                        reference: Some("LogLevel"),
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
                    "root",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        min_length: Some(1),
                        ..NONE
                    },
                ),
                (
                    "skipRebuild",
                    Shape {
                        kinds: Some(&[Kind::Boolean]),
                        ..NONE
                    },
                ),
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
                            (
                                "gatherer",
                                Shape {
                                    reference: Some("Engine"),
                                    ..NONE
                                },
                            ),
                            (
                                "matcher",
                                Shape {
                                    reference: Some("Engine"),
                                    ..NONE
                                },
                            ),
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
                                        (
                                            "assessing",
                                            Shape {
                                                reference: Some("Engine"),
                                                ..NONE
                                            },
                                        ),
                                        (
                                            "commenting",
                                            Shape {
                                                reference: Some("Engine"),
                                                ..NONE
                                            },
                                        ),
                                        (
                                            "highlighting",
                                            Shape {
                                                reference: Some("Engine"),
                                                ..NONE
                                            },
                                        ),
                                        (
                                            "linking",
                                            Shape {
                                                reference: Some("Engine"),
                                                ..NONE
                                            },
                                        ),
                                        (
                                            "tagging",
                                            Shape {
                                                reference: Some("Engine"),
                                                ..NONE
                                            },
                                        ),
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
                            (
                                "yield",
                                Shape {
                                    reference: Some("Engine"),
                                    ..NONE
                                },
                            ),
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
                        items: Some(&Shape {
                            reference: Some("StoredEventResponse"),
                            ..NONE
                        }),
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
                        items: Some(&Shape {
                            kinds: Some(&[Kind::String]),
                            ..NONE
                        }),
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
                (
                    "resourceId",
                    Shape {
                        reference: Some("ResourceId"),
                        ..NONE
                    },
                ),
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
                    items: Some(&Shape {
                        reference: Some("ArchivistStream"),
                        ..NONE
                    }),
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
                (
                    "density",
                    Shape {
                        kinds: Some(&[Kind::Number]),
                        ..NONE
                    },
                ),
                (
                    "instructions",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "language",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "motivation",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[Listed::Text("assessing")]),
                        ..NONE
                    },
                ),
                (
                    "sourceLanguage",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
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
                Shape {
                    reference: Some("StoredEventResponse"),
                    ..NONE
                },
                Shape {
                    kinds: Some(&[Kind::Object]),
                    required: &["agent"],
                    members: &[(
                        "agent",
                        Shape {
                            reference: Some("Agent"),
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
        "BeckonFocusEvent",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["resourceId"],
            members: &[
                (
                    "annotationId",
                    Shape {
                        reference: Some("AnnotationId"),
                        ..NONE
                    },
                ),
                (
                    "resourceId",
                    Shape {
                        reference: Some("ResourceId"),
                        ..NONE
                    },
                ),
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
                    one_of: &[
                        Shape {
                            kinds: Some(&[Kind::Null]),
                            ..NONE
                        },
                        Shape {
                            reference: Some("AnnotationId"),
                            ..NONE
                        },
                    ],
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
            members: &[(
                "annotationId",
                Shape {
                    reference: Some("AnnotationId"),
                    ..NONE
                },
            )],
            ..NONE
        },
    ),
    (
        "BindBodyOperation",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["op"],
            members: &[
                (
                    "item",
                    Shape {
                        reference: Some("AnnotationBody"),
                        ..NONE
                    },
                ),
                (
                    "newItem",
                    Shape {
                        reference: Some("AnnotationBody"),
                        ..NONE
                    },
                ),
                (
                    "oldItem",
                    Shape {
                        reference: Some("AnnotationBody"),
                        ..NONE
                    },
                ),
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
    (
        "BindBodyUpdated",
        Shape {
            kinds: Some(&[Kind::Object]),
            ..NONE
        },
    ),
    (
        "BindInitiateCommand",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["annotationId", "resourceId", "defaultTitle", "entityTypes"],
            members: &[
                (
                    "annotationId",
                    Shape {
                        reference: Some("AnnotationId"),
                        ..NONE
                    },
                ),
                (
                    "defaultTitle",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "entityTypes",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&Shape {
                            kinds: Some(&[Kind::String]),
                            ..NONE
                        }),
                        ..NONE
                    },
                ),
                (
                    "resourceId",
                    Shape {
                        reference: Some("ResourceId"),
                        ..NONE
                    },
                ),
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
                (
                    "_userId",
                    Shape {
                        reference: Some("UserId"),
                        ..NONE
                    },
                ),
                (
                    "annotationId",
                    Shape {
                        reference: Some("AnnotationId"),
                        ..NONE
                    },
                ),
                (
                    "operations",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&Shape {
                            reference: Some("BindBodyOperation"),
                            ..NONE
                        }),
                        ..NONE
                    },
                ),
                (
                    "resourceId",
                    Shape {
                        reference: Some("ResourceId"),
                        ..NONE
                    },
                ),
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
                (
                    "item",
                    Shape {
                        kinds: Some(&[Kind::Object]),
                        one_of: &[
                            Shape {
                                reference: Some("TextualBody"),
                                ..NONE
                            },
                            Shape {
                                reference: Some("SpecificResource"),
                                ..NONE
                            },
                        ],
                        ..NONE
                    },
                ),
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
                (
                    "item",
                    Shape {
                        kinds: Some(&[Kind::Object]),
                        one_of: &[
                            Shape {
                                reference: Some("TextualBody"),
                                ..NONE
                            },
                            Shape {
                                reference: Some("SpecificResource"),
                                ..NONE
                            },
                        ],
                        ..NONE
                    },
                ),
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
                (
                    "newItem",
                    Shape {
                        kinds: Some(&[Kind::Object]),
                        one_of: &[
                            Shape {
                                reference: Some("TextualBody"),
                                ..NONE
                            },
                            Shape {
                                reference: Some("SpecificResource"),
                                ..NONE
                            },
                        ],
                        ..NONE
                    },
                ),
                (
                    "oldItem",
                    Shape {
                        kinds: Some(&[Kind::Object]),
                        one_of: &[
                            Shape {
                                reference: Some("TextualBody"),
                                ..NONE
                            },
                            Shape {
                                reference: Some("SpecificResource"),
                                ..NONE
                            },
                        ],
                        ..NONE
                    },
                ),
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
                (
                    "annotationId",
                    Shape {
                        reference: Some("AnnotationId"),
                        ..NONE
                    },
                ),
                (
                    "resourceId",
                    Shape {
                        reference: Some("ResourceId"),
                        ..NONE
                    },
                ),
            ],
            ..NONE
        },
    ),
    (
        "BrowseAnnotationHistoryResult",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["response"],
            members: &[(
                "response",
                Shape {
                    reference: Some("GetAnnotationHistoryResponse"),
                    ..NONE
                },
            )],
            ..NONE
        },
    ),
    (
        "BrowseAnnotationRequest",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["resourceId", "annotationId"],
            members: &[
                (
                    "annotationId",
                    Shape {
                        reference: Some("AnnotationId"),
                        ..NONE
                    },
                ),
                (
                    "resourceId",
                    Shape {
                        reference: Some("ResourceId"),
                        ..NONE
                    },
                ),
            ],
            ..NONE
        },
    ),
    (
        "BrowseAnnotationResult",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["response"],
            members: &[(
                "response",
                Shape {
                    reference: Some("GetAnnotationResponse"),
                    ..NONE
                },
            )],
            ..NONE
        },
    ),
    (
        "BrowseClickEvent",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["annotationId"],
            members: &[(
                "annotationId",
                Shape {
                    reference: Some("AnnotationId"),
                    ..NONE
                },
            )],
            ..NONE
        },
    ),
    (
        "BrowseDirectoryFailed",
        Shape {
            kinds: Some(&[Kind::Object]),
            all_of: &[
                Shape {
                    reference: Some("CommandError"),
                    ..NONE
                },
                Shape {
                    kinds: Some(&[Kind::Object]),
                    required: &["path"],
                    members: &[(
                        "path",
                        Shape {
                            kinds: Some(&[Kind::String]),
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
        "BrowseDirectoryRequest",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["path"],
            members: &[
                (
                    "path",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
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
            members: &[(
                "response",
                Shape {
                    reference: Some("BrowseDirectoryResultResponse"),
                    ..NONE
                },
            )],
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
                        items: Some(&Shape {
                            reference: Some("DirectoryEntry"),
                            ..NONE
                        }),
                        ..NONE
                    },
                ),
                (
                    "path",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
            ],
            ..NONE
        },
    ),
    (
        "BrowseEnginesRequest",
        Shape {
            kinds: Some(&[Kind::Object]),
            ..NONE
        },
    ),
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
                            items: Some(&Shape {
                                reference: Some("EngineEntry"),
                                ..NONE
                            }),
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
            members: &[(
                "entityType",
                Shape {
                    kinds: Some(&[Kind::String]),
                    ..NONE
                },
            )],
            ..NONE
        },
    ),
    (
        "BrowseEntityTypesRequest",
        Shape {
            kinds: Some(&[Kind::Object]),
            ..NONE
        },
    ),
    (
        "BrowseEntityTypesResult",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["response"],
            members: &[(
                "response",
                Shape {
                    reference: Some("GetEntityTypesResponse"),
                    ..NONE
                },
            )],
            ..NONE
        },
    ),
    (
        "BrowseEventsRequest",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["resourceId"],
            members: &[
                (
                    "limit",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        ..NONE
                    },
                ),
                (
                    "resourceId",
                    Shape {
                        reference: Some("ResourceId"),
                        ..NONE
                    },
                ),
                (
                    "type",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "userId",
                    Shape {
                        reference: Some("UserId"),
                        ..NONE
                    },
                ),
            ],
            ..NONE
        },
    ),
    (
        "BrowseEventsResult",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["response"],
            members: &[(
                "response",
                Shape {
                    reference: Some("GetEventsResponse"),
                    ..NONE
                },
            )],
            ..NONE
        },
    ),
    (
        "BrowseExternalNavigateEvent",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["url"],
            members: &[
                (
                    "resourceId",
                    Shape {
                        reference: Some("ResourceId"),
                        ..NONE
                    },
                ),
                (
                    "url",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
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
                        items: Some(&Shape {
                            reference: Some("DirectoryEntry"),
                            ..NONE
                        }),
                        ..NONE
                    },
                ),
                (
                    "path",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
            ],
            closed: Some(&["entries", "path"]),
            ..NONE
        },
    ),
    (
        "BrowseKbRequest",
        Shape {
            kinds: Some(&[Kind::Object]),
            ..NONE
        },
    ),
    (
        "BrowseKbResult",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["response"],
            members: &[(
                "response",
                Shape {
                    reference: Some("KbDescription"),
                    ..NONE
                },
            )],
            ..NONE
        },
    ),
    (
        "BrowseLinkClickedEvent",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["href"],
            members: &[
                (
                    "href",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "label",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
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
                (
                    "motivation",
                    Shape {
                        reference: Some("Motivation"),
                        ..NONE
                    },
                ),
                (
                    "panel",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "scrollToAnnotationId",
                    Shape {
                        reference: Some("AnnotationId"),
                        ..NONE
                    },
                ),
            ],
            ..NONE
        },
    ),
    (
        "BrowsePanelToggleEvent",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["panel"],
            members: &[(
                "panel",
                Shape {
                    kinds: Some(&[Kind::String]),
                    ..NONE
                },
            )],
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
                    items: Some(&Shape {
                        reference: Some("UserId"),
                        ..NONE
                    }),
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
                            values: Some(&Shape {
                                reference: Some("Profile"),
                                ..NONE
                            }),
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
            members: &[(
                "resourceId",
                Shape {
                    reference: Some("ResourceId"),
                    ..NONE
                },
            )],
            ..NONE
        },
    ),
    (
        "BrowseResourceOpenEvent",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["resourceId"],
            members: &[(
                "resourceId",
                Shape {
                    reference: Some("ResourceId"),
                    ..NONE
                },
            )],
            ..NONE
        },
    ),
    (
        "BrowseResourceReorderEvent",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["oldIndex", "newIndex"],
            members: &[
                (
                    "newIndex",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        ..NONE
                    },
                ),
                (
                    "oldIndex",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        ..NONE
                    },
                ),
            ],
            ..NONE
        },
    ),
    (
        "BrowseResourceRequest",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["resourceId"],
            members: &[(
                "resourceId",
                Shape {
                    reference: Some("ResourceId"),
                    ..NONE
                },
            )],
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
                        (
                            "resource",
                            Shape {
                                reference: Some("ResourceDescriptor"),
                                ..NONE
                            },
                        ),
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
            members: &[(
                "resourceId",
                Shape {
                    reference: Some("ResourceId"),
                    ..NONE
                },
            )],
            ..NONE
        },
    ),
    (
        "BrowseResourcesRequest",
        Shape {
            kinds: Some(&[Kind::Object]),
            members: &[
                (
                    "archived",
                    Shape {
                        kinds: Some(&[Kind::Boolean]),
                        ..NONE
                    },
                ),
                (
                    "entityType",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
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
            members: &[(
                "response",
                Shape {
                    reference: Some("ListResourcesResponse"),
                    ..NONE
                },
            )],
            ..NONE
        },
    ),
    (
        "BrowseRouterPushEvent",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["path"],
            members: &[
                (
                    "path",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "reason",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
            ],
            ..NONE
        },
    ),
    (
        "BrowseTagSchemasRequest",
        Shape {
            kinds: Some(&[Kind::Object]),
            ..NONE
        },
    ),
    (
        "BrowseTagSchemasResult",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["response"],
            members: &[(
                "response",
                Shape {
                    reference: Some("GetTagSchemasResponse"),
                    ..NONE
                },
            )],
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
                (
                    "clientId",
                    Shape {
                        kinds: Some(&[Kind::String]),
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
                (
                    "payload",
                    Shape {
                        kinds: Some(&[Kind::Object]),
                        ..NONE
                    },
                ),
                (
                    "scope",
                    Shape {
                        reference: Some("ResourceId"),
                        ..NONE
                    },
                ),
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
                (
                    "data",
                    Shape {
                        reference: Some("BusFrame"),
                        ..NONE
                    },
                ),
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
                            Shape {
                                reference: Some("PersistedEventId"),
                                ..NONE
                            },
                            Shape {
                                reference: Some("ReplyEventId"),
                                ..NONE
                            },
                            Shape {
                                reference: Some("EphemeralEventId"),
                                ..NONE
                            },
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
                (
                    "payload",
                    Shape {
                        kinds: Some(&[Kind::Object]),
                        ..NONE
                    },
                ),
                (
                    "scope",
                    Shape {
                        reference: Some("ResourceId"),
                        ..NONE
                    },
                ),
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
                (
                    "lastSeenId",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
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
                (
                    "scope",
                    Shape {
                        reference: Some("ResourceId"),
                        ..NONE
                    },
                ),
            ],
            closed: Some(&["lastSeenId", "reason", "scope"]),
            ..NONE
        },
    ),
    (
        "BusStreamMessage",
        Shape {
            kinds: Some(&[Kind::Object]),
            one_of: &[
                Shape {
                    reference: Some("BusEventMessage"),
                    ..NONE
                },
                Shape {
                    reference: Some("BusPingMessage"),
                    ..NONE
                },
            ],
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
                                (
                                    "lastEventId",
                                    Shape {
                                        kinds: Some(&[Kind::String]),
                                        ..NONE
                                    },
                                ),
                                (
                                    "scope",
                                    Shape {
                                        reference: Some("ResourceId"),
                                        ..NONE
                                    },
                                ),
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
                (
                    "expiresAt",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "resource",
                    Shape {
                        reference: Some("ResourceDescriptor"),
                        ..NONE
                    },
                ),
                (
                    "token",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
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
                (
                    "details",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "message",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
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
                (
                    "density",
                    Shape {
                        kinds: Some(&[Kind::Number]),
                        ..NONE
                    },
                ),
                (
                    "instructions",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "language",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "motivation",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[Listed::Text("commenting")]),
                        ..NONE
                    },
                ),
                (
                    "sourceLanguage",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
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
    (
        "ContentFormat",
        Shape {
            kinds: Some(&[Kind::String]),
            ..NONE
        },
    ),
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
                            (
                                "after",
                                Shape {
                                    kinds: Some(&[Kind::String]),
                                    ..NONE
                                },
                            ),
                            (
                                "before",
                                Shape {
                                    kinds: Some(&[Kind::String]),
                                    ..NONE
                                },
                            ),
                            (
                                "selected",
                                Shape {
                                    kinds: Some(&[Kind::String]),
                                    ..NONE
                                },
                            ),
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
                                    items: Some(&Shape {
                                        kinds: Some(&[Kind::String]),
                                        ..NONE
                                    }),
                                    ..NONE
                                },
                            ),
                            (
                                "resourceId",
                                Shape {
                                    reference: Some("ResourceId"),
                                    ..NONE
                                },
                            ),
                            (
                                "resourceName",
                                Shape {
                                    kinds: Some(&[Kind::String]),
                                    ..NONE
                                },
                            ),
                        ],
                        closed: Some(&["entityTypes", "resourceId", "resourceName"]),
                        ..NONE
                    },
                ),
                (
                    "summary",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
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
                (
                    "body",
                    Shape {
                        reference: Some("AnnotationBodies"),
                        ..NONE
                    },
                ),
                (
                    "motivation",
                    Shape {
                        reference: Some("Motivation"),
                        ..NONE
                    },
                ),
                (
                    "target",
                    Shape {
                        reference: Some("AnnotationTarget"),
                        ..NONE
                    },
                ),
            ],
            ..NONE
        },
    ),
    (
        "CreateResourceResponse",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["resourceId"],
            members: &[(
                "resourceId",
                Shape {
                    reference: Some("ResourceId"),
                    ..NONE
                },
            )],
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
                (
                    "mtime",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "name",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "path",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
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
            one_of: &[
                Shape {
                    reference: Some("FileEntry"),
                    ..NONE
                },
                Shape {
                    reference: Some("DirEntry"),
                    ..NONE
                },
            ],
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
                (
                    "did",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "host",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "managedBy",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "placement",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[Listed::Text("local"), Listed::Text("codespace")]),
                        ..NONE
                    },
                ),
                (
                    "port",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        ..NONE
                    },
                ),
                (
                    "repo",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "siteName",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
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
                        items: Some(&Shape {
                            reference: Some("DiscoveredKB"),
                            ..NONE
                        }),
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
                (
                    "identity",
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
                    "kb",
                    Shape {
                        reference: Some("KbIdentity"),
                        ..NONE
                    },
                ),
                (
                    "logFormat",
                    Shape {
                        reference: Some("LogFormat"),
                        ..NONE
                    },
                ),
                (
                    "logLevel",
                    Shape {
                        reference: Some("LogLevel"),
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
                Shape {
                    reference: Some("OllamaEmbeddingConfig"),
                    ..NONE
                },
                Shape {
                    reference: Some("VoyageEmbeddingConfig"),
                    ..NONE
                },
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
                (
                    "engine",
                    Shape {
                        reference: Some("Engine"),
                        ..NONE
                    },
                ),
                (
                    "jobs",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&Shape {
                            reference: Some("JobFilter"),
                            ..NONE
                        }),
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
                (
                    "engine",
                    Shape {
                        reference: Some("Engine"),
                        ..NONE
                    },
                ),
                (
                    "limits",
                    Shape {
                        reference: Some("InferenceLimits"),
                        ..NONE
                    },
                ),
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
                Shape {
                    reference: Some("StoredEventResponse"),
                    ..NONE
                },
                Shape {
                    kinds: Some(&[Kind::Object]),
                    members: &[(
                        "annotation",
                        Shape {
                            reference: Some("Annotation"),
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
        "EntityTagChangedPayload",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["entityType"],
            members: &[(
                "entityType",
                Shape {
                    kinds: Some(&[Kind::String]),
                    ..NONE
                },
            )],
            ..NONE
        },
    ),
    (
        "EntityTypeAddedPayload",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["entityType"],
            members: &[(
                "entityType",
                Shape {
                    kinds: Some(&[Kind::String]),
                    ..NONE
                },
            )],
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
                    items: Some(&Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    }),
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
                (
                    "code",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "error",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "hint",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
            ],
            ..NONE
        },
    ),
    (
        "EventMetadata",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["sequenceNumber"],
            members: &[(
                "sequenceNumber",
                Shape {
                    kinds: Some(&[Kind::Integer]),
                    ..NONE
                },
            )],
            ..NONE
        },
    ),
    (
        "ExtractedText",
        Shape {
            kinds: Some(&[Kind::Object]),
            all_of: &[
                Shape {
                    reference: Some("AnchoredText"),
                    ..NONE
                },
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
                        (
                            "method",
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
                            "ocrConfidence",
                            Shape {
                                kinds: Some(&[Kind::Object]),
                                required: &["mean", "lowConfidenceWords", "totalWords"],
                                members: &[
                                    (
                                        "lowConfidenceWords",
                                        Shape {
                                            kinds: Some(&[Kind::Integer]),
                                            ..NONE
                                        },
                                    ),
                                    (
                                        "mean",
                                        Shape {
                                            kinds: Some(&[Kind::Number]),
                                            ..NONE
                                        },
                                    ),
                                    (
                                        "totalWords",
                                        Shape {
                                            kinds: Some(&[Kind::Integer]),
                                            ..NONE
                                        },
                                    ),
                                ],
                                ..NONE
                            },
                        ),
                        (
                            "pdfClass",
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
                            "unreadPages",
                            Shape {
                                kinds: Some(&[Kind::Array]),
                                items: Some(&Shape {
                                    kinds: Some(&[Kind::Integer]),
                                    ..NONE
                                }),
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
                (
                    "declined",
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
        "ExtractionOutcome",
        Shape {
            kinds: Some(&[Kind::Object]),
            one_of: &[
                Shape {
                    reference: Some("ExtractedText"),
                    ..NONE
                },
                Shape {
                    reference: Some("ExtractionDeclined"),
                    ..NONE
                },
            ],
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
                (
                    "annotationCount",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        ..NONE
                    },
                ),
                (
                    "creator",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "entityTypes",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&Shape {
                            kinds: Some(&[Kind::String]),
                            ..NONE
                        }),
                        ..NONE
                    },
                ),
                (
                    "mtime",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "name",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "path",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "resourceId",
                    Shape {
                        reference: Some("ResourceId"),
                        ..NONE
                    },
                ),
                (
                    "size",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        ..NONE
                    },
                ),
                (
                    "tracked",
                    Shape {
                        kinds: Some(&[Kind::Boolean]),
                        ..NONE
                    },
                ),
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
                (
                    "conformsTo",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "type",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[Listed::Text("FragmentSelector")]),
                        ..NONE
                    },
                ),
                (
                    "value",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
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
                (
                    "_userId",
                    Shape {
                        reference: Some("UserId"),
                        ..NONE
                    },
                ),
                (
                    "tag",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
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
                (
                    "_userId",
                    Shape {
                        reference: Some("UserId"),
                        ..NONE
                    },
                ),
                (
                    "schema",
                    Shape {
                        reference: Some("TagSchema"),
                        ..NONE
                    },
                ),
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
                (
                    "archivist",
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
                (
                    "kb",
                    Shape {
                        reference: Some("KbIdentity"),
                        ..NONE
                    },
                ),
                (
                    "logFormat",
                    Shape {
                        reference: Some("LogFormat"),
                        ..NONE
                    },
                ),
                (
                    "logLevel",
                    Shape {
                        reference: Some("LogLevel"),
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
                (
                    "annotationId",
                    Shape {
                        reference: Some("AnnotationId"),
                        ..NONE
                    },
                ),
                (
                    "response",
                    Shape {
                        reference: Some("GatheredContext"),
                        ..NONE
                    },
                ),
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
                (
                    "includeSourceContext",
                    Shape {
                        kinds: Some(&[Kind::Boolean]),
                        ..NONE
                    },
                ),
                (
                    "includeTargetContext",
                    Shape {
                        kinds: Some(&[Kind::Boolean]),
                        ..NONE
                    },
                ),
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
                (
                    "annotationId",
                    Shape {
                        reference: Some("AnnotationId"),
                        ..NONE
                    },
                ),
                (
                    "options",
                    Shape {
                        reference: Some("GatherAnnotationOptions"),
                        ..NONE
                    },
                ),
                (
                    "resourceId",
                    Shape {
                        reference: Some("ResourceId"),
                        ..NONE
                    },
                ),
            ],
            ..NONE
        },
    ),
    (
        "GatherFailed",
        Shape {
            kinds: Some(&[Kind::Object]),
            all_of: &[
                Shape {
                    reference: Some("CommandError"),
                    ..NONE
                },
                Shape {
                    kinds: Some(&[Kind::Object]),
                    required: &["annotationId"],
                    members: &[(
                        "annotationId",
                        Shape {
                            reference: Some("AnnotationId"),
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
        "GatherReferencedByRequest",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["resourceId"],
            members: &[
                (
                    "motivation",
                    Shape {
                        reference: Some("Motivation"),
                        ..NONE
                    },
                ),
                (
                    "resourceId",
                    Shape {
                        reference: Some("ResourceId"),
                        ..NONE
                    },
                ),
            ],
            ..NONE
        },
    ),
    (
        "GatherReferencedByResult",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["response"],
            members: &[(
                "response",
                Shape {
                    reference: Some("GetReferencedByResponse"),
                    ..NONE
                },
            )],
            ..NONE
        },
    ),
    (
        "GatherResourceComplete",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["resourceId", "response"],
            members: &[
                (
                    "resourceId",
                    Shape {
                        reference: Some("ResourceId"),
                        ..NONE
                    },
                ),
                (
                    "response",
                    Shape {
                        reference: Some("GatheredContext"),
                        ..NONE
                    },
                ),
            ],
            ..NONE
        },
    ),
    (
        "GatherResourceFailed",
        Shape {
            kinds: Some(&[Kind::Object]),
            all_of: &[
                Shape {
                    reference: Some("CommandError"),
                    ..NONE
                },
                Shape {
                    kinds: Some(&[Kind::Object]),
                    required: &["resourceId"],
                    members: &[(
                        "resourceId",
                        Shape {
                            reference: Some("ResourceId"),
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
        "GatherResourceRequest",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["resourceId", "options"],
            members: &[
                (
                    "options",
                    Shape {
                        reference: Some("GatherResourceRequestOptions"),
                        ..NONE
                    },
                ),
                (
                    "resourceId",
                    Shape {
                        reference: Some("ResourceId"),
                        ..NONE
                    },
                ),
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
                        items: Some(&Shape {
                            kinds: Some(&[Kind::String]),
                            ..NONE
                        }),
                        ..NONE
                    },
                ),
                (
                    "includeContent",
                    Shape {
                        kinds: Some(&[Kind::Boolean]),
                        ..NONE
                    },
                ),
                (
                    "includeSummary",
                    Shape {
                        kinds: Some(&[Kind::Boolean]),
                        ..NONE
                    },
                ),
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
                (
                    "annotationId",
                    Shape {
                        reference: Some("AnnotationId"),
                        ..NONE
                    },
                ),
                (
                    "resourceId",
                    Shape {
                        reference: Some("ResourceId"),
                        ..NONE
                    },
                ),
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
                                    (
                                        "annotation",
                                        Shape {
                                            reference: Some("Annotation"),
                                            ..NONE
                                        },
                                    ),
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
                                                (
                                                    "after",
                                                    Shape {
                                                        kinds: Some(&[Kind::String]),
                                                        ..NONE
                                                    },
                                                ),
                                                (
                                                    "before",
                                                    Shape {
                                                        kinds: Some(&[Kind::String]),
                                                        ..NONE
                                                    },
                                                ),
                                                (
                                                    "text",
                                                    Shape {
                                                        kinds: Some(&[Kind::String]),
                                                        ..NONE
                                                    },
                                                ),
                                            ],
                                            ..NONE
                                        },
                                    ),
                                    (
                                        "sourceResource",
                                        Shape {
                                            reference: Some("ResourceDescriptor"),
                                            ..NONE
                                        },
                                    ),
                                    (
                                        "targetContext",
                                        Shape {
                                            kinds: Some(&[Kind::Object]),
                                            required: &["content"],
                                            members: &[
                                                (
                                                    "content",
                                                    Shape {
                                                        kinds: Some(&[Kind::String]),
                                                        ..NONE
                                                    },
                                                ),
                                                (
                                                    "summary",
                                                    Shape {
                                                        kinds: Some(&[Kind::String]),
                                                        ..NONE
                                                    },
                                                ),
                                            ],
                                            ..NONE
                                        },
                                    ),
                                    (
                                        "targetResource",
                                        Shape {
                                            reference: Some("ResourceDescriptor"),
                                            ..NONE
                                        },
                                    ),
                                    (
                                        "userHint",
                                        Shape {
                                            kinds: Some(&[Kind::String]),
                                            ..NONE
                                        },
                                    ),
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
                                                (
                                                    "main",
                                                    Shape {
                                                        kinds: Some(&[Kind::String]),
                                                        ..NONE
                                                    },
                                                ),
                                                (
                                                    "related",
                                                    Shape {
                                                        kinds: Some(&[Kind::Object]),
                                                        values: Some(&Shape {
                                                            kinds: Some(&[Kind::String]),
                                                            ..NONE
                                                        }),
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
                                    (
                                        "resource",
                                        Shape {
                                            reference: Some("ResourceDescriptor"),
                                            ..NONE
                                        },
                                    ),
                                    (
                                        "suggestedReferences",
                                        Shape {
                                            kinds: Some(&[Kind::Array]),
                                            items: Some(&Shape {
                                                kinds: Some(&[Kind::String]),
                                                ..NONE
                                            }),
                                            ..NONE
                                        },
                                    ),
                                    (
                                        "summary",
                                        Shape {
                                            kinds: Some(&[Kind::String]),
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
                    "graph",
                    Shape {
                        reference: Some("KnowledgeGraph"),
                        ..NONE
                    },
                ),
                (
                    "inferredRelationshipSummary",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "metadata",
                    Shape {
                        kinds: Some(&[Kind::Object]),
                        members: &[
                            (
                                "entityTypeFrequencies",
                                Shape {
                                    kinds: Some(&[Kind::Object]),
                                    values: Some(&Shape {
                                        kinds: Some(&[Kind::Integer]),
                                        ..NONE
                                    }),
                                    ..NONE
                                },
                            ),
                            (
                                "entityTypes",
                                Shape {
                                    kinds: Some(&[Kind::Array]),
                                    items: Some(&Shape {
                                        kinds: Some(&[Kind::String]),
                                        ..NONE
                                    }),
                                    ..NONE
                                },
                            ),
                            (
                                "language",
                                Shape {
                                    kinds: Some(&[Kind::String]),
                                    ..NONE
                                },
                            ),
                            (
                                "resourceType",
                                Shape {
                                    kinds: Some(&[Kind::String]),
                                    ..NONE
                                },
                            ),
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
                                    items: Some(&Shape {
                                        kinds: Some(&[Kind::String]),
                                        ..NONE
                                    }),
                                    ..NONE
                                },
                            ),
                            (
                                "similar",
                                Shape {
                                    kinds: Some(&[Kind::Array]),
                                    items: Some(&Shape {
                                        reference: Some("SemanticMatch"),
                                        ..NONE
                                    }),
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
                Shape {
                    reference: Some("GenerationJobRequest"),
                    ..NONE
                },
                Shape {
                    kinds: Some(&[Kind::Object]),
                    required: &["context"],
                    members: &[(
                        "context",
                        Shape {
                            reference: Some("GatheredContext"),
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
        "GenerationJobRequest",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["title", "storageUri"],
            members: &[
                (
                    "cite",
                    Shape {
                        kinds: Some(&[Kind::Boolean]),
                        ..NONE
                    },
                ),
                (
                    "entityTypes",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&Shape {
                            kinds: Some(&[Kind::String]),
                            ..NONE
                        }),
                        ..NONE
                    },
                ),
                (
                    "language",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "maxTokens",
                    Shape {
                        kinds: Some(&[Kind::Number]),
                        ..NONE
                    },
                ),
                (
                    "outputMediaType",
                    Shape {
                        reference: Some("SupportedMediaType"),
                        ..NONE
                    },
                ),
                (
                    "prompt",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "sourceLanguage",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "storageUri",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        min_length: Some(1),
                        ..NONE
                    },
                ),
                (
                    "structure",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "task",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "temperature",
                    Shape {
                        kinds: Some(&[Kind::Number]),
                        ..NONE
                    },
                ),
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
                (
                    "annotationId",
                    Shape {
                        reference: Some("AnnotationId"),
                        ..NONE
                    },
                ),
                (
                    "events",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&Shape {
                            reference: Some("AttributedEvent"),
                            ..NONE
                        }),
                        ..NONE
                    },
                ),
                (
                    "resourceId",
                    Shape {
                        reference: Some("ResourceId"),
                        ..NONE
                    },
                ),
                (
                    "total",
                    Shape {
                        kinds: Some(&[Kind::Number]),
                        ..NONE
                    },
                ),
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
                (
                    "annotation",
                    Shape {
                        reference: Some("Annotation"),
                        ..NONE
                    },
                ),
                (
                    "resolvedResource",
                    Shape {
                        kinds: Some(&[Kind::Object, Kind::Null]),
                        one_of: &[
                            Shape {
                                kinds: Some(&[Kind::Null]),
                                ..NONE
                            },
                            Shape {
                                reference: Some("ResourceDescriptor"),
                                ..NONE
                            },
                        ],
                        ..NONE
                    },
                ),
                (
                    "resource",
                    Shape {
                        kinds: Some(&[Kind::Object, Kind::Null]),
                        one_of: &[
                            Shape {
                                kinds: Some(&[Kind::Null]),
                                ..NONE
                            },
                            Shape {
                                reference: Some("ResourceDescriptor"),
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
        "GetAnnotationsResponse",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["annotations", "total"],
            members: &[
                (
                    "annotations",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&Shape {
                            reference: Some("Annotation"),
                            ..NONE
                        }),
                        ..NONE
                    },
                ),
                (
                    "motivation",
                    Shape {
                        kinds: Some(&[Kind::String, Kind::Null]),
                        one_of: &[
                            Shape {
                                kinds: Some(&[Kind::Null]),
                                ..NONE
                            },
                            Shape {
                                reference: Some("Motivation"),
                                ..NONE
                            },
                        ],
                        ..NONE
                    },
                ),
                (
                    "total",
                    Shape {
                        kinds: Some(&[Kind::Number]),
                        ..NONE
                    },
                ),
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
                    items: Some(&Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    }),
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
                        items: Some(&Shape {
                            reference: Some("AttributedEvent"),
                            ..NONE
                        }),
                        ..NONE
                    },
                ),
                (
                    "resourceId",
                    Shape {
                        reference: Some("ResourceId"),
                        ..NONE
                    },
                ),
                (
                    "total",
                    Shape {
                        kinds: Some(&[Kind::Number]),
                        ..NONE
                    },
                ),
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
                    items: Some(&Shape {
                        reference: Some("GetReferencedByResponseReferencedByItem"),
                        ..NONE
                    }),
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
                (
                    "id",
                    Shape {
                        reference: Some("AnnotationId"),
                        ..NONE
                    },
                ),
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
                                    members: &[(
                                        "exact",
                                        Shape {
                                            kinds: Some(&[Kind::String]),
                                            ..NONE
                                        },
                                    )],
                                    ..NONE
                                },
                            ),
                            (
                                "source",
                                Shape {
                                    reference: Some("ResourceId"),
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
        "GetResourceByTokenResponse",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["sourceResource", "expiresAt"],
            members: &[
                (
                    "expiresAt",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "sourceResource",
                    Shape {
                        reference: Some("ResourceDescriptor"),
                        ..NONE
                    },
                ),
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
                        items: Some(&Shape {
                            reference: Some("Annotation"),
                            ..NONE
                        }),
                        ..NONE
                    },
                ),
                (
                    "resource",
                    Shape {
                        reference: Some("ResourceDescriptor"),
                        ..NONE
                    },
                ),
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
                    items: Some(&Shape {
                        reference: Some("TagSchema"),
                        ..NONE
                    }),
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
                (
                    "annotation",
                    Shape {
                        reference: Some("Annotation"),
                        ..NONE
                    },
                ),
                (
                    "entityTypes",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&Shape {
                            kinds: Some(&[Kind::String]),
                            ..NONE
                        }),
                        ..NONE
                    },
                ),
                (
                    "id",
                    Shape {
                        reference: Some("AnnotationId"),
                        ..NONE
                    },
                ),
                (
                    "label",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "metadata",
                    Shape {
                        kinds: Some(&[Kind::Object]),
                        ..NONE
                    },
                ),
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
                Shape {
                    reference: Some("Neo4jGraphConfig"),
                    ..NONE
                },
                Shape {
                    reference: Some("JanusGraphConfig"),
                    ..NONE
                },
                Shape {
                    reference: Some("NeptuneGraphConfig"),
                    ..NONE
                },
                Shape {
                    reference: Some("MemoryGraphConfig"),
                    ..NONE
                },
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
                        items: Some(&Shape {
                            kinds: Some(&[Kind::String]),
                            ..NONE
                        }),
                        ..NONE
                    },
                ),
                (
                    "id",
                    Shape {
                        reference: Some("ResourceId"),
                        ..NONE
                    },
                ),
                (
                    "label",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "metadata",
                    Shape {
                        kinds: Some(&[Kind::Object]),
                        ..NONE
                    },
                ),
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
                (
                    "message",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "status",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "timestamp",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "version",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
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
                (
                    "density",
                    Shape {
                        kinds: Some(&[Kind::Number]),
                        ..NONE
                    },
                ),
                (
                    "instructions",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "motivation",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[Listed::Text("highlighting")]),
                        ..NONE
                    },
                ),
                (
                    "sourceLanguage",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
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
                (
                    "host",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
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
                (
                    "acceptsTemperature",
                    Shape {
                        kinds: Some(&[Kind::Boolean]),
                        ..NONE
                    },
                ),
                (
                    "contextTokens",
                    Shape {
                        kinds: Some(&[Kind::Number]),
                        ..NONE
                    },
                ),
                (
                    "maxOutputTokens",
                    Shape {
                        kinds: Some(&[Kind::Number]),
                        ..NONE
                    },
                ),
            ],
            ..NONE
        },
    ),
    (
        "InferenceLimitsRequest",
        Shape {
            kinds: Some(&[Kind::Object]),
            ..NONE
        },
    ),
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
                            items: Some(&Shape {
                                reference: Some("EngineLimits"),
                                ..NONE
                            }),
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
                Shape {
                    reference: Some("JobPending"),
                    ..NONE
                },
                Shape {
                    reference: Some("JobRunning"),
                    ..NONE
                },
                Shape {
                    reference: Some("JobComplete"),
                    ..NONE
                },
                Shape {
                    reference: Some("JobFailed"),
                    ..NONE
                },
                Shape {
                    reference: Some("JobCancelled"),
                    ..NONE
                },
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
                (
                    "_userId",
                    Shape {
                        reference: Some("UserId"),
                        ..NONE
                    },
                ),
                (
                    "holder",
                    Shape {
                        reference: Some("UserId"),
                        ..NONE
                    },
                ),
                (
                    "jobId",
                    Shape {
                        reference: Some("JobId"),
                        ..NONE
                    },
                ),
                (
                    "jobType",
                    Shape {
                        reference: Some("JobType"),
                        ..NONE
                    },
                ),
                (
                    "requester",
                    Shape {
                        reference: Some("UserId"),
                        ..NONE
                    },
                ),
                (
                    "resourceId",
                    Shape {
                        reference: Some("ResourceId"),
                        ..NONE
                    },
                ),
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
                (
                    "holder",
                    Shape {
                        reference: Some("UserId"),
                        ..NONE
                    },
                ),
                (
                    "jobId",
                    Shape {
                        reference: Some("JobId"),
                        ..NONE
                    },
                ),
                (
                    "jobType",
                    Shape {
                        reference: Some("JobType"),
                        ..NONE
                    },
                ),
                (
                    "requester",
                    Shape {
                        reference: Some("UserId"),
                        ..NONE
                    },
                ),
                (
                    "resourceId",
                    Shape {
                        reference: Some("ResourceId"),
                        ..NONE
                    },
                ),
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
                (
                    "_userId",
                    Shape {
                        reference: Some("UserId"),
                        ..NONE
                    },
                ),
                (
                    "annotationId",
                    Shape {
                        reference: Some("AnnotationId"),
                        ..NONE
                    },
                ),
                (
                    "completedUnits",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&Shape {
                            kinds: Some(&[Kind::String]),
                            ..NONE
                        }),
                        ..NONE
                    },
                ),
                (
                    "jobId",
                    Shape {
                        reference: Some("JobId"),
                        ..NONE
                    },
                ),
                (
                    "jobType",
                    Shape {
                        reference: Some("JobType"),
                        ..NONE
                    },
                ),
                (
                    "resourceId",
                    Shape {
                        reference: Some("ResourceId"),
                        ..NONE
                    },
                ),
                (
                    "unitCursors",
                    Shape {
                        kinds: Some(&[Kind::Object]),
                        values: Some(&Shape {
                            reference: Some("UnitCursor"),
                            ..NONE
                        }),
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
            members: &[(
                "jobId",
                Shape {
                    reference: Some("JobId"),
                    ..NONE
                },
            )],
            ..NONE
        },
    ),
    (
        "JobCancelResult",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["cancelled"],
            members: &[(
                "cancelled",
                Shape {
                    kinds: Some(&[Kind::Boolean]),
                    ..NONE
                },
            )],
            ..NONE
        },
    ),
    (
        "JobCancelled",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["status", "metadata", "params", "completedAt"],
            members: &[
                (
                    "completedAt",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "metadata",
                    Shape {
                        reference: Some("JobMetadata"),
                        ..NONE
                    },
                ),
                (
                    "params",
                    Shape {
                        reference: Some("JobParams"),
                        ..NONE
                    },
                ),
                (
                    "startedAt",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
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
                (
                    "_userId",
                    Shape {
                        reference: Some("UserId"),
                        ..NONE
                    },
                ),
                (
                    "completedUnits",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&Shape {
                            kinds: Some(&[Kind::String]),
                            ..NONE
                        }),
                        ..NONE
                    },
                ),
                (
                    "jobId",
                    Shape {
                        reference: Some("JobId"),
                        ..NONE
                    },
                ),
                (
                    "unitCursors",
                    Shape {
                        kinds: Some(&[Kind::Object]),
                        values: Some(&Shape {
                            reference: Some("UnitCursor"),
                            ..NONE
                        }),
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
                        items: Some(&Shape {
                            kinds: Some(&[Kind::String]),
                            ..NONE
                        }),
                        ..NONE
                    },
                ),
                (
                    "_userId",
                    Shape {
                        reference: Some("UserId"),
                        ..NONE
                    },
                ),
                (
                    "accepts",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        min_items: Some(1),
                        items: Some(&Shape {
                            reference: Some("JobFilter"),
                            ..NONE
                        }),
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
            members: &[(
                "response",
                Shape {
                    reference: Some("JobRunning"),
                    ..NONE
                },
            )],
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
                (
                    "completedAt",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "metadata",
                    Shape {
                        reference: Some("JobMetadata"),
                        ..NONE
                    },
                ),
                (
                    "params",
                    Shape {
                        reference: Some("JobParams"),
                        ..NONE
                    },
                ),
                (
                    "result",
                    Shape {
                        reference: Some("JobStoredResult"),
                        ..NONE
                    },
                ),
                (
                    "startedAt",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
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
                Shape {
                    reference: Some("MarkJobCompleteCommand"),
                    ..NONE
                },
                Shape {
                    reference: Some("YieldJobCompleteCommand"),
                    ..NONE
                },
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
                (
                    "annotationId",
                    Shape {
                        reference: Some("AnnotationId"),
                        ..NONE
                    },
                ),
                (
                    "annotationUri",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "attempt",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        ..NONE
                    },
                ),
                (
                    "durability",
                    Shape {
                        reference: Some("DurabilityEvidence"),
                        ..NONE
                    },
                ),
                (
                    "foundCount",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        ..NONE
                    },
                ),
                (
                    "jobId",
                    Shape {
                        reference: Some("JobId"),
                        ..NONE
                    },
                ),
                (
                    "jobType",
                    Shape {
                        reference: Some("JobType"),
                        ..NONE
                    },
                ),
                (
                    "result",
                    Shape {
                        kinds: Some(&[Kind::Object]),
                        ..NONE
                    },
                ),
                (
                    "resultResourceId",
                    Shape {
                        reference: Some("ResourceId"),
                        ..NONE
                    },
                ),
                (
                    "totalSteps",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        ..NONE
                    },
                ),
            ],
            ..NONE
        },
    ),
    (
        "JobCreateCommand",
        Shape {
            kinds: Some(&[Kind::Object]),
            one_of: &[
                Shape {
                    reference: Some("MarkJobCreateCommand"),
                    ..NONE
                },
                Shape {
                    reference: Some("YieldJobCreateCommand"),
                    ..NONE
                },
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
            members: &[(
                "response",
                Shape {
                    reference: Some("JobCreatedResultResponse"),
                    ..NONE
                },
            )],
            ..NONE
        },
    ),
    (
        "JobCreatedResultResponse",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["jobId"],
            members: &[(
                "jobId",
                Shape {
                    reference: Some("JobId"),
                    ..NONE
                },
            )],
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
                (
                    "_userId",
                    Shape {
                        reference: Some("UserId"),
                        ..NONE
                    },
                ),
                (
                    "annotationId",
                    Shape {
                        reference: Some("AnnotationId"),
                        ..NONE
                    },
                ),
                (
                    "attempt",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        ..NONE
                    },
                ),
                (
                    "completedUnits",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&Shape {
                            kinds: Some(&[Kind::String]),
                            ..NONE
                        }),
                        ..NONE
                    },
                ),
                (
                    "durability",
                    Shape {
                        reference: Some("DurabilityEvidence"),
                        ..NONE
                    },
                ),
                (
                    "error",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "failureClass",
                    Shape {
                        reference: Some("FailureClass"),
                        ..NONE
                    },
                ),
                (
                    "jobId",
                    Shape {
                        reference: Some("JobId"),
                        ..NONE
                    },
                ),
                (
                    "jobType",
                    Shape {
                        reference: Some("JobType"),
                        ..NONE
                    },
                ),
                (
                    "resourceId",
                    Shape {
                        reference: Some("ResourceId"),
                        ..NONE
                    },
                ),
                (
                    "unitCursors",
                    Shape {
                        kinds: Some(&[Kind::Object]),
                        values: Some(&Shape {
                            reference: Some("UnitCursor"),
                            ..NONE
                        }),
                        ..NONE
                    },
                ),
                (
                    "willRetry",
                    Shape {
                        kinds: Some(&[Kind::Boolean]),
                        ..NONE
                    },
                ),
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
                (
                    "completedAt",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "error",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "failureClass",
                    Shape {
                        reference: Some("FailureClass"),
                        ..NONE
                    },
                ),
                (
                    "metadata",
                    Shape {
                        reference: Some("JobMetadata"),
                        ..NONE
                    },
                ),
                (
                    "params",
                    Shape {
                        reference: Some("JobParams"),
                        ..NONE
                    },
                ),
                (
                    "startedAt",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
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
                (
                    "annotationId",
                    Shape {
                        reference: Some("AnnotationId"),
                        ..NONE
                    },
                ),
                (
                    "attempt",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        ..NONE
                    },
                ),
                (
                    "durability",
                    Shape {
                        reference: Some("DurabilityEvidence"),
                        ..NONE
                    },
                ),
                (
                    "error",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "failureClass",
                    Shape {
                        reference: Some("FailureClass"),
                        ..NONE
                    },
                ),
                (
                    "jobId",
                    Shape {
                        reference: Some("JobId"),
                        ..NONE
                    },
                ),
                (
                    "jobType",
                    Shape {
                        reference: Some("JobType"),
                        ..NONE
                    },
                ),
                (
                    "willRetry",
                    Shape {
                        kinds: Some(&[Kind::Boolean]),
                        ..NONE
                    },
                ),
            ],
            ..NONE
        },
    ),
    (
        "JobFilter",
        Shape {
            kinds: Some(&[Kind::Object]),
            one_of: &[
                Shape {
                    reference: Some("MarkJobFilter"),
                    ..NONE
                },
                Shape {
                    reference: Some("YieldJobFilter"),
                    ..NONE
                },
            ],
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
                        items: Some(&Shape {
                            kinds: Some(&[Kind::String]),
                            ..NONE
                        }),
                        ..NONE
                    },
                ),
                (
                    "created",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "id",
                    Shape {
                        reference: Some("JobId"),
                        ..NONE
                    },
                ),
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
                (
                    "type",
                    Shape {
                        reference: Some("JobType"),
                        ..NONE
                    },
                ),
                (
                    "unitCursors",
                    Shape {
                        kinds: Some(&[Kind::Object]),
                        values: Some(&Shape {
                            reference: Some("UnitCursor"),
                            ..NONE
                        }),
                        ..NONE
                    },
                ),
                (
                    "userId",
                    Shape {
                        reference: Some("UserId"),
                        ..NONE
                    },
                ),
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
                (
                    "resourceId",
                    Shape {
                        reference: Some("ResourceId"),
                        ..NONE
                    },
                ),
                (
                    "schema",
                    Shape {
                        reference: Some("TagSchema"),
                        ..NONE
                    },
                ),
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
                (
                    "metadata",
                    Shape {
                        reference: Some("JobMetadata"),
                        ..NONE
                    },
                ),
                (
                    "params",
                    Shape {
                        reference: Some("JobParams"),
                        ..NONE
                    },
                ),
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
                (
                    "annotationId",
                    Shape {
                        reference: Some("AnnotationId"),
                        ..NONE
                    },
                ),
                (
                    "completedItems",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&Shape {
                            kinds: Some(&[Kind::Object]),
                            required: &["value", "foundCount"],
                            members: &[
                                (
                                    "foundCount",
                                    Shape {
                                        kinds: Some(&[Kind::Integer]),
                                        ..NONE
                                    },
                                ),
                                (
                                    "persistedCount",
                                    Shape {
                                        kinds: Some(&[Kind::Integer]),
                                        ..NONE
                                    },
                                ),
                                (
                                    "underReported",
                                    Shape {
                                        kinds: Some(&[Kind::Object]),
                                        required: &["pieces", "found", "counted"],
                                        members: &[
                                            (
                                                "counted",
                                                Shape {
                                                    kinds: Some(&[Kind::Integer]),
                                                    ..NONE
                                                },
                                            ),
                                            (
                                                "found",
                                                Shape {
                                                    kinds: Some(&[Kind::Integer]),
                                                    ..NONE
                                                },
                                            ),
                                            (
                                                "pieces",
                                                Shape {
                                                    kinds: Some(&[Kind::Integer]),
                                                    ..NONE
                                                },
                                            ),
                                        ],
                                        ..NONE
                                    },
                                ),
                                (
                                    "value",
                                    Shape {
                                        kinds: Some(&[Kind::String]),
                                        ..NONE
                                    },
                                ),
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
                            (
                                "value",
                                Shape {
                                    kinds: Some(&[Kind::String]),
                                    ..NONE
                                },
                            ),
                        ],
                        ..NONE
                    },
                ),
                (
                    "entitiesEmitted",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        ..NONE
                    },
                ),
                (
                    "entitiesExpected",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        ..NONE
                    },
                ),
                (
                    "entitiesFound",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        ..NONE
                    },
                ),
                (
                    "message",
                    Shape {
                        reference: Some("JobProgressMessage"),
                        ..NONE
                    },
                ),
                (
                    "percentage",
                    Shape {
                        kinds: Some(&[Kind::Number]),
                        ..NONE
                    },
                ),
                (
                    "processed",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        ..NONE
                    },
                ),
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
                                (
                                    "value",
                                    Shape {
                                        kinds: Some(&[Kind::String]),
                                        ..NONE
                                    },
                                ),
                            ],
                            ..NONE
                        }),
                        ..NONE
                    },
                ),
                (
                    "total",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        ..NONE
                    },
                ),
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
                (
                    "count",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        ..NONE
                    },
                ),
                (
                    "motivation",
                    Shape {
                        reference: Some("Motivation"),
                        ..NONE
                    },
                ),
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
                (
                    "truncated",
                    Shape {
                        kinds: Some(&[Kind::Boolean]),
                        ..NONE
                    },
                ),
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
                (
                    "count",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        ..NONE
                    },
                ),
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
                (
                    "count",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        ..NONE
                    },
                ),
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
                (
                    "entityType",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
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
                Shape {
                    reference: Some("JobProgressLoading"),
                    ..NONE
                },
                Shape {
                    reference: Some("JobProgressAnalyzing"),
                    ..NONE
                },
                Shape {
                    reference: Some("JobProgressAnalyzingTags"),
                    ..NONE
                },
                Shape {
                    reference: Some("JobProgressGeneratingResource"),
                    ..NONE
                },
                Shape {
                    reference: Some("JobProgressCreatingResource"),
                    ..NONE
                },
                Shape {
                    reference: Some("JobProgressCompleteGenerated"),
                    ..NONE
                },
                Shape {
                    reference: Some("JobProgressDetectingEntities"),
                    ..NONE
                },
                Shape {
                    reference: Some("JobProgressCreatingAnnotations"),
                    ..NONE
                },
                Shape {
                    reference: Some("JobProgressCreatingTagAnnotations"),
                    ..NONE
                },
                Shape {
                    reference: Some("JobProgressCompleteCreated"),
                    ..NONE
                },
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
                Shape {
                    reference: Some("MarkJobQueuedEvent"),
                    ..NONE
                },
                Shape {
                    reference: Some("YieldJobQueuedEvent"),
                    ..NONE
                },
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
                (
                    "job",
                    Shape {
                        reference: Some("Job"),
                        ..NONE
                    },
                ),
                (
                    "lastProgressAt",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
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
                (
                    "_userId",
                    Shape {
                        reference: Some("UserId"),
                        ..NONE
                    },
                ),
                (
                    "annotationId",
                    Shape {
                        reference: Some("AnnotationId"),
                        ..NONE
                    },
                ),
                (
                    "attempt",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        ..NONE
                    },
                ),
                (
                    "jobId",
                    Shape {
                        reference: Some("JobId"),
                        ..NONE
                    },
                ),
                (
                    "jobType",
                    Shape {
                        reference: Some("JobType"),
                        ..NONE
                    },
                ),
                (
                    "percentage",
                    Shape {
                        kinds: Some(&[Kind::Number]),
                        ..NONE
                    },
                ),
                (
                    "progress",
                    Shape {
                        reference: Some("JobProgress"),
                        ..NONE
                    },
                ),
                (
                    "resourceId",
                    Shape {
                        reference: Some("ResourceId"),
                        ..NONE
                    },
                ),
            ],
            ..NONE
        },
    ),
    (
        "JobResult",
        Shape {
            kinds: Some(&[Kind::Object]),
            one_of: &[
                Shape {
                    reference: Some("MarkJobDone"),
                    ..NONE
                },
                Shape {
                    reference: Some("YieldJobDone"),
                    ..NONE
                },
                Shape {
                    reference: Some("JobDeclined"),
                    ..NONE
                },
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
                (
                    "metadata",
                    Shape {
                        reference: Some("JobMetadata"),
                        ..NONE
                    },
                ),
                (
                    "params",
                    Shape {
                        reference: Some("JobParams"),
                        ..NONE
                    },
                ),
                (
                    "progress",
                    Shape {
                        reference: Some("JobStoredProgress"),
                        ..NONE
                    },
                ),
                (
                    "startedAt",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
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
                (
                    "_userId",
                    Shape {
                        reference: Some("UserId"),
                        ..NONE
                    },
                ),
                (
                    "annotationId",
                    Shape {
                        reference: Some("AnnotationId"),
                        ..NONE
                    },
                ),
                (
                    "attempt",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        ..NONE
                    },
                ),
                (
                    "jobId",
                    Shape {
                        reference: Some("JobId"),
                        ..NONE
                    },
                ),
                (
                    "jobType",
                    Shape {
                        reference: Some("JobType"),
                        ..NONE
                    },
                ),
                (
                    "resourceId",
                    Shape {
                        reference: Some("ResourceId"),
                        ..NONE
                    },
                ),
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
                (
                    "annotationId",
                    Shape {
                        reference: Some("AnnotationId"),
                        ..NONE
                    },
                ),
                (
                    "jobId",
                    Shape {
                        reference: Some("JobId"),
                        ..NONE
                    },
                ),
                (
                    "jobType",
                    Shape {
                        reference: Some("JobType"),
                        ..NONE
                    },
                ),
                (
                    "totalSteps",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        ..NONE
                    },
                ),
            ],
            ..NONE
        },
    ),
    (
        "JobStatusRequest",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["jobId"],
            members: &[(
                "jobId",
                Shape {
                    reference: Some("JobId"),
                    ..NONE
                },
            )],
            ..NONE
        },
    ),
    (
        "JobStatusResponse",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["jobId", "type", "status", "userId", "created"],
            members: &[
                (
                    "completedAt",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "created",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "error",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "failureClass",
                    Shape {
                        reference: Some("FailureClass"),
                        ..NONE
                    },
                ),
                (
                    "jobId",
                    Shape {
                        reference: Some("JobId"),
                        ..NONE
                    },
                ),
                (
                    "progress",
                    Shape {
                        reference: Some("JobStoredProgress"),
                        ..NONE
                    },
                ),
                (
                    "result",
                    Shape {
                        reference: Some("JobStoredResult"),
                        ..NONE
                    },
                ),
                (
                    "startedAt",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
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
                (
                    "type",
                    Shape {
                        reference: Some("JobType"),
                        ..NONE
                    },
                ),
                (
                    "userId",
                    Shape {
                        reference: Some("UserId"),
                        ..NONE
                    },
                ),
            ],
            ..NONE
        },
    ),
    (
        "JobStatusResult",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["response"],
            members: &[(
                "response",
                Shape {
                    reference: Some("JobStatusResponse"),
                    ..NONE
                },
            )],
            ..NONE
        },
    ),
    (
        "JobStoredProgress",
        Shape {
            kinds: Some(&[Kind::Object]),
            one_of: &[
                Shape {
                    reference: Some("JobProgress"),
                    ..NONE
                },
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
                Shape {
                    reference: Some("JobResult"),
                    ..NONE
                },
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
                (
                    "domain",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "gitBranch",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "name",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
            ],
            ..NONE
        },
    ),
    (
        "KbEndpoint",
        Shape {
            kinds: Some(&[Kind::Object]),
            one_of: &[
                Shape {
                    reference: Some("HttpEndpoint"),
                    ..NONE
                },
                Shape {
                    reference: Some("LocalEndpoint"),
                    ..NONE
                },
            ],
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
                (
                    "at",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "gitBranch",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
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
                (
                    "endpoint",
                    Shape {
                        reference: Some("KbEndpoint"),
                        ..NONE
                    },
                ),
                (
                    "id",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "label",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
            ],
            ..NONE
        },
    ),
    (
        "KnowledgeBase",
        Shape {
            kinds: Some(&[Kind::Object]),
            all_of: &[
                Shape {
                    reference: Some("KbTarget"),
                    ..NONE
                },
                Shape {
                    reference: Some("NewKnowledgeBase"),
                    ..NONE
                },
            ],
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
                                (
                                    "bidirectional",
                                    Shape {
                                        kinds: Some(&[Kind::Boolean]),
                                        ..NONE
                                    },
                                ),
                                (
                                    "metadata",
                                    Shape {
                                        kinds: Some(&[Kind::Object]),
                                        ..NONE
                                    },
                                ),
                                (
                                    "source",
                                    Shape {
                                        kinds: Some(&[Kind::String]),
                                        ..NONE
                                    },
                                ),
                                (
                                    "target",
                                    Shape {
                                        kinds: Some(&[Kind::String]),
                                        ..NONE
                                    },
                                ),
                                (
                                    "type",
                                    Shape {
                                        kinds: Some(&[Kind::String]),
                                        ..NONE
                                    },
                                ),
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
                                Shape {
                                    reference: Some("GraphResourceNode"),
                                    ..NONE
                                },
                                Shape {
                                    reference: Some("GraphAnnotationNode"),
                                    ..NONE
                                },
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
                (
                    "truncated",
                    Shape {
                        kinds: Some(&[Kind::Boolean]),
                        ..NONE
                    },
                ),
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
                (
                    "archivist",
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
                    "embedding",
                    Shape {
                        reference: Some("EmbeddingConfig"),
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
                (
                    "gatherer",
                    Shape {
                        reference: Some("LibrarianEngineConfig"),
                        ..NONE
                    },
                ),
                (
                    "graph",
                    Shape {
                        reference: Some("GraphConfig"),
                        ..NONE
                    },
                ),
                (
                    "identity",
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
                    "kb",
                    Shape {
                        reference: Some("KbIdentity"),
                        ..NONE
                    },
                ),
                (
                    "logFormat",
                    Shape {
                        reference: Some("LogFormat"),
                        ..NONE
                    },
                ),
                (
                    "logLevel",
                    Shape {
                        reference: Some("LogLevel"),
                        ..NONE
                    },
                ),
                (
                    "matcher",
                    Shape {
                        reference: Some("LibrarianEngineConfig"),
                        ..NONE
                    },
                ),
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
                (
                    "vectors",
                    Shape {
                        reference: Some("VectorsConfig"),
                        ..NONE
                    },
                ),
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
                (
                    "engine",
                    Shape {
                        reference: Some("Engine"),
                        ..NONE
                    },
                ),
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
                Shape {
                    reference: Some("ErrorResponse"),
                    ..NONE
                },
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
                        items: Some(&Shape {
                            kinds: Some(&[Kind::String]),
                            ..NONE
                        }),
                        ..NONE
                    },
                ),
                (
                    "includeDescriptiveReferences",
                    Shape {
                        kinds: Some(&[Kind::Boolean]),
                        ..NONE
                    },
                ),
                (
                    "language",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "motivation",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[Listed::Text("linking")]),
                        ..NONE
                    },
                ),
                (
                    "sourceLanguage",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
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
                (
                    "limit",
                    Shape {
                        kinds: Some(&[Kind::Number]),
                        ..NONE
                    },
                ),
                (
                    "offset",
                    Shape {
                        kinds: Some(&[Kind::Number]),
                        ..NONE
                    },
                ),
                (
                    "resources",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&Shape {
                            reference: Some("ResourceDescriptor"),
                            ..NONE
                        }),
                        ..NONE
                    },
                ),
                (
                    "total",
                    Shape {
                        kinds: Some(&[Kind::Number]),
                        ..NONE
                    },
                ),
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
                (
                    "kbId",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
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
                (
                    "_userId",
                    Shape {
                        reference: Some("UserId"),
                        ..NONE
                    },
                ),
                (
                    "keepFile",
                    Shape {
                        kinds: Some(&[Kind::Boolean]),
                        ..NONE
                    },
                ),
                (
                    "resourceId",
                    Shape {
                        reference: Some("ResourceId"),
                        ..NONE
                    },
                ),
                (
                    "storageUri",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
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
                        items: Some(&Shape {
                            kinds: Some(&[Kind::String]),
                            ..NONE
                        }),
                        ..NONE
                    },
                ),
                (
                    "_userId",
                    Shape {
                        reference: Some("UserId"),
                        ..NONE
                    },
                ),
                (
                    "annotations",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&Shape {
                            reference: Some("Annotation"),
                            ..NONE
                        }),
                        ..NONE
                    },
                ),
                (
                    "jobId",
                    Shape {
                        reference: Some("JobId"),
                        ..NONE
                    },
                ),
                (
                    "resourceId",
                    Shape {
                        reference: Some("ResourceId"),
                        ..NONE
                    },
                ),
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
                                items: Some(&Shape {
                                    reference: Some("AnnotationId"),
                                    ..NONE
                                }),
                                ..NONE
                            },
                        ),
                        (
                            "persisted",
                            Shape {
                                kinds: Some(&[Kind::Integer]),
                                ..NONE
                            },
                        ),
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
            members: &[(
                "response",
                Shape {
                    reference: Some("MarkCreateOkResponse"),
                    ..NONE
                },
            )],
            ..NONE
        },
    ),
    (
        "MarkCreateOkResponse",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["annotationId"],
            members: &[(
                "annotationId",
                Shape {
                    reference: Some("AnnotationId"),
                    ..NONE
                },
            )],
            ..NONE
        },
    ),
    (
        "MarkCreateRequest",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["resourceId", "request"],
            members: &[
                (
                    "request",
                    Shape {
                        reference: Some("CreateAnnotationRequest"),
                        ..NONE
                    },
                ),
                (
                    "resourceId",
                    Shape {
                        reference: Some("ResourceId"),
                        ..NONE
                    },
                ),
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
                (
                    "motivation",
                    Shape {
                        reference: Some("Motivation"),
                        ..NONE
                    },
                ),
                (
                    "resourceId",
                    Shape {
                        reference: Some("ResourceId"),
                        ..NONE
                    },
                ),
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
                (
                    "_userId",
                    Shape {
                        reference: Some("UserId"),
                        ..NONE
                    },
                ),
                (
                    "annotationId",
                    Shape {
                        reference: Some("AnnotationId"),
                        ..NONE
                    },
                ),
                (
                    "resourceId",
                    Shape {
                        reference: Some("ResourceId"),
                        ..NONE
                    },
                ),
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
                    members: &[(
                        "annotationId",
                        Shape {
                            reference: Some("AnnotationId"),
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
        "MarkJobCompleteCommand",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["resourceId", "jobId", "jobType"],
            members: &[
                (
                    "_userId",
                    Shape {
                        reference: Some("UserId"),
                        ..NONE
                    },
                ),
                (
                    "attempt",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        ..NONE
                    },
                ),
                (
                    "durability",
                    Shape {
                        reference: Some("DurabilityEvidence"),
                        ..NONE
                    },
                ),
                (
                    "jobId",
                    Shape {
                        reference: Some("JobId"),
                        ..NONE
                    },
                ),
                (
                    "jobType",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[Listed::Text("mark")]),
                        ..NONE
                    },
                ),
                (
                    "resourceId",
                    Shape {
                        reference: Some("ResourceId"),
                        ..NONE
                    },
                ),
                (
                    "result",
                    Shape {
                        reference: Some("MarkJobResult"),
                        ..NONE
                    },
                ),
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
                        items: Some(&Shape {
                            kinds: Some(&[Kind::String]),
                            ..NONE
                        }),
                        ..NONE
                    },
                ),
                (
                    "_userId",
                    Shape {
                        reference: Some("UserId"),
                        ..NONE
                    },
                ),
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
                        reference: Some("MarkJobParams"),
                        ..NONE
                    },
                ),
                (
                    "resourceId",
                    Shape {
                        reference: Some("ResourceId"),
                        ..NONE
                    },
                ),
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
                        values: Some(&Shape {
                            kinds: Some(&[Kind::Integer]),
                            ..NONE
                        }),
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
                (
                    "underReportedPieces",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        ..NONE
                    },
                ),
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
                        members: &[(
                            "motivation",
                            Shape {
                                reference: Some("Motivation"),
                                ..NONE
                            },
                        )],
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
                Shape {
                    reference: Some("HighlightingJobParams"),
                    ..NONE
                },
                Shape {
                    reference: Some("CommentingJobParams"),
                    ..NONE
                },
                Shape {
                    reference: Some("AssessingJobParams"),
                    ..NONE
                },
                Shape {
                    reference: Some("LinkingJobParams"),
                    ..NONE
                },
                Shape {
                    reference: Some("TaggingJobParams"),
                    ..NONE
                },
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
                (
                    "jobId",
                    Shape {
                        reference: Some("JobId"),
                        ..NONE
                    },
                ),
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
                        reference: Some("MarkJobParams"),
                        ..NONE
                    },
                ),
                (
                    "resourceId",
                    Shape {
                        reference: Some("ResourceId"),
                        ..NONE
                    },
                ),
                (
                    "userId",
                    Shape {
                        reference: Some("UserId"),
                        ..NONE
                    },
                ),
            ],
            ..NONE
        },
    ),
    (
        "MarkJobResult",
        Shape {
            kinds: Some(&[Kind::Object]),
            one_of: &[
                Shape {
                    reference: Some("MarkJobDone"),
                    ..NONE
                },
                Shape {
                    reference: Some("JobDeclined"),
                    ..NONE
                },
            ],
            ..NONE
        },
    ),
    (
        "MarkRequestedEvent",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["source", "selector", "motivation"],
            members: &[
                (
                    "motivation",
                    Shape {
                        reference: Some("Motivation"),
                        ..NONE
                    },
                ),
                (
                    "selector",
                    Shape {
                        reference: Some("AnnotationSelector"),
                        ..NONE
                    },
                ),
                (
                    "source",
                    Shape {
                        reference: Some("ResourceId"),
                        ..NONE
                    },
                ),
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
                (
                    "body",
                    Shape {
                        reference: Some("AnnotationBodies"),
                        ..NONE
                    },
                ),
                (
                    "motivation",
                    Shape {
                        reference: Some("Motivation"),
                        ..NONE
                    },
                ),
                (
                    "selector",
                    Shape {
                        reference: Some("AnnotationSelector"),
                        ..NONE
                    },
                ),
                (
                    "source",
                    Shape {
                        reference: Some("ResourceId"),
                        ..NONE
                    },
                ),
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
                (
                    "_userId",
                    Shape {
                        reference: Some("UserId"),
                        ..NONE
                    },
                ),
                (
                    "resourceId",
                    Shape {
                        reference: Some("ResourceId"),
                        ..NONE
                    },
                ),
                (
                    "storageUri",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
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
                (
                    "_userId",
                    Shape {
                        reference: Some("UserId"),
                        ..NONE
                    },
                ),
                (
                    "annotationId",
                    Shape {
                        reference: Some("AnnotationId"),
                        ..NONE
                    },
                ),
                (
                    "operations",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&Shape {
                            kinds: Some(&[Kind::Object]),
                            one_of: &[
                                Shape {
                                    reference: Some("BodyOperationAdd"),
                                    ..NONE
                                },
                                Shape {
                                    reference: Some("BodyOperationRemove"),
                                    ..NONE
                                },
                                Shape {
                                    reference: Some("BodyOperationReplace"),
                                    ..NONE
                                },
                            ],
                            ..NONE
                        }),
                        ..NONE
                    },
                ),
                (
                    "resourceId",
                    Shape {
                        reference: Some("ResourceId"),
                        ..NONE
                    },
                ),
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
                (
                    "_userId",
                    Shape {
                        reference: Some("UserId"),
                        ..NONE
                    },
                ),
                (
                    "currentEntityTypes",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&Shape {
                            kinds: Some(&[Kind::String]),
                            ..NONE
                        }),
                        ..NONE
                    },
                ),
                (
                    "resourceId",
                    Shape {
                        reference: Some("ResourceId"),
                        ..NONE
                    },
                ),
                (
                    "updatedEntityTypes",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&Shape {
                            kinds: Some(&[Kind::String]),
                            ..NONE
                        }),
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
                (
                    "archived",
                    Shape {
                        kinds: Some(&[Kind::Boolean]),
                        ..NONE
                    },
                ),
                (
                    "entityType",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
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
                (
                    "search",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
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
                        items: Some(&Shape {
                            reference: Some("ResourceDescriptor"),
                            ..NONE
                        }),
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
            members: &[(
                "response",
                Shape {
                    reference: Some("MatchResourcesResponse"),
                    ..NONE
                },
            )],
            ..NONE
        },
    ),
    (
        "MatchSearchFailed",
        Shape {
            kinds: Some(&[Kind::Object]),
            all_of: &[
                Shape {
                    reference: Some("CommandError"),
                    ..NONE
                },
                Shape {
                    kinds: Some(&[Kind::Object]),
                    required: &["referenceId"],
                    members: &[(
                        "referenceId",
                        Shape {
                            reference: Some("AnnotationId"),
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
        "MatchSearchRequest",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["resourceId", "referenceId", "context"],
            members: &[
                (
                    "context",
                    Shape {
                        reference: Some("GatheredContext"),
                        ..NONE
                    },
                ),
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
                    "referenceId",
                    Shape {
                        reference: Some("AnnotationId"),
                        ..NONE
                    },
                ),
                (
                    "resourceId",
                    Shape {
                        reference: Some("ResourceId"),
                        ..NONE
                    },
                ),
                (
                    "useSemanticScoring",
                    Shape {
                        kinds: Some(&[Kind::Boolean]),
                        ..NONE
                    },
                ),
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
                (
                    "referenceId",
                    Shape {
                        reference: Some("AnnotationId"),
                        ..NONE
                    },
                ),
                (
                    "response",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&Shape {
                            reference: Some("ScoredResource"),
                            ..NONE
                        }),
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
            members: &[(
                "resourceId",
                Shape {
                    reference: Some("ResourceId"),
                    ..NONE
                },
            )],
            ..NONE
        },
    ),
    (
        "MediaTokenResponse",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["token"],
            members: &[(
                "token",
                Shape {
                    kinds: Some(&[Kind::String]),
                    ..NONE
                },
            )],
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
                (
                    "did",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "endpoint",
                    Shape {
                        reference: Some("KbEndpoint"),
                        ..NONE
                    },
                ),
                (
                    "label",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "lastRead",
                    Shape {
                        reference: Some("KbRead"),
                        ..NONE
                    },
                ),
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
                (
                    "height",
                    Shape {
                        kinds: Some(&[Kind::Number]),
                        ..NONE
                    },
                ),
                (
                    "page",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
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
                    "width",
                    Shape {
                        kinds: Some(&[Kind::Number]),
                        ..NONE
                    },
                ),
                (
                    "x",
                    Shape {
                        kinds: Some(&[Kind::Number]),
                        ..NONE
                    },
                ),
                (
                    "y",
                    Shape {
                        kinds: Some(&[Kind::Number]),
                        ..NONE
                    },
                ),
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
                (
                    "_userId",
                    Shape {
                        reference: Some("UserId"),
                        ..NONE
                    },
                ),
                (
                    "name",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
            ],
            ..NONE
        },
    ),
    (
        "PrincipalProfiledPayload",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["name"],
            members: &[(
                "name",
                Shape {
                    kinds: Some(&[Kind::String]),
                    ..NONE
                },
            )],
            ..NONE
        },
    ),
    (
        "Profile",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["name", "since"],
            members: &[
                (
                    "name",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "since",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
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
                    values: Some(&Shape {
                        reference: Some("Profile"),
                        ..NONE
                    }),
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
                        items: Some(&Shape {
                            kinds: Some(&[Kind::String]),
                            ..NONE
                        }),
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
                (
                    "resource",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "resource_name",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
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
                (
                    "@id",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "@type",
                    Shape {
                        kinds: Some(&[Kind::Array, Kind::String]),
                        one_of: &[
                            Shape {
                                kinds: Some(&[Kind::String]),
                                ..NONE
                            },
                            Shape {
                                kinds: Some(&[Kind::Array]),
                                min_items: Some(1),
                                items: Some(&Shape {
                                    kinds: Some(&[Kind::String]),
                                    ..NONE
                                }),
                                ..NONE
                            },
                        ],
                        ..NONE
                    },
                ),
                (
                    "byteSize",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        minimum: Some(0.0),
                        ..NONE
                    },
                ),
                (
                    "checksum",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "conformsTo",
                    Shape {
                        kinds: Some(&[Kind::Array, Kind::String]),
                        one_of: &[
                            Shape {
                                kinds: Some(&[Kind::String]),
                                ..NONE
                            },
                            Shape {
                                kinds: Some(&[Kind::Array]),
                                items: Some(&Shape {
                                    kinds: Some(&[Kind::String]),
                                    ..NONE
                                }),
                                ..NONE
                            },
                        ],
                        ..NONE
                    },
                ),
                (
                    "created",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "duration",
                    Shape {
                        kinds: Some(&[Kind::Number]),
                        minimum: Some(0.0),
                        ..NONE
                    },
                ),
                (
                    "encoding",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "filename",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "height",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        minimum: Some(0.0),
                        ..NONE
                    },
                ),
                (
                    "language",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "mediaType",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "modified",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
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
                (
                    "storageUri",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "tags",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&Shape {
                            kinds: Some(&[Kind::String]),
                            ..NONE
                        }),
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
            members: &[(
                "representation",
                Shape {
                    reference: Some("Representation"),
                    ..NONE
                },
            )],
            ..NONE
        },
    ),
    (
        "RepresentationNotFound",
        Shape {
            kinds: Some(&[Kind::Object]),
            all_of: &[
                Shape {
                    reference: Some("ErrorResponse"),
                    ..NONE
                },
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
            members: &[(
                "checksum",
                Shape {
                    kinds: Some(&[Kind::String]),
                    ..NONE
                },
            )],
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
                        items: Some(&Shape {
                            reference: Some("Annotation"),
                            ..NONE
                        }),
                        ..NONE
                    },
                ),
                (
                    "resourceId",
                    Shape {
                        reference: Some("ResourceId"),
                        ..NONE
                    },
                ),
                (
                    "updatedAt",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
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
            members: &[(
                "reason",
                Shape {
                    kinds: Some(&[Kind::String]),
                    ..NONE
                },
            )],
            ..NONE
        },
    ),
    (
        "ResourceClonedPayload",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["name", "format", "contentChecksum", "parentResourceId"],
            members: &[
                (
                    "contentByteSize",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        ..NONE
                    },
                ),
                (
                    "contentChecksum",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "creator",
                    Shape {
                        reference: Some("Agent"),
                        ..NONE
                    },
                ),
                (
                    "entityTypes",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&Shape {
                            kinds: Some(&[Kind::String]),
                            ..NONE
                        }),
                        ..NONE
                    },
                ),
                (
                    "format",
                    Shape {
                        reference: Some("ContentFormat"),
                        ..NONE
                    },
                ),
                (
                    "language",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "name",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "parentResourceId",
                    Shape {
                        reference: Some("ResourceId"),
                        ..NONE
                    },
                ),
                (
                    "storageUri",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "wasAttributedTo",
                    Shape {
                        kinds: Some(&[Kind::Object, Kind::Array]),
                        one_of: &[
                            Shape {
                                reference: Some("Agent"),
                                ..NONE
                            },
                            Shape {
                                kinds: Some(&[Kind::Array]),
                                items: Some(&Shape {
                                    reference: Some("Agent"),
                                    ..NONE
                                }),
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
        "ResourceCreatedPayload",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["name", "format", "contentChecksum"],
            members: &[
                (
                    "contentByteSize",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        ..NONE
                    },
                ),
                (
                    "contentChecksum",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "creator",
                    Shape {
                        reference: Some("Agent"),
                        ..NONE
                    },
                ),
                (
                    "entityTypes",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&Shape {
                            kinds: Some(&[Kind::String]),
                            ..NONE
                        }),
                        ..NONE
                    },
                ),
                (
                    "format",
                    Shape {
                        reference: Some("ContentFormat"),
                        ..NONE
                    },
                ),
                (
                    "generatedFrom",
                    Shape {
                        kinds: Some(&[Kind::Object]),
                        required: &["resourceId"],
                        members: &[
                            (
                                "annotationId",
                                Shape {
                                    reference: Some("AnnotationId"),
                                    ..NONE
                                },
                            ),
                            (
                                "resourceId",
                                Shape {
                                    reference: Some("ResourceId"),
                                    ..NONE
                                },
                            ),
                        ],
                        ..NONE
                    },
                ),
                (
                    "generationPrompt",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "generator",
                    Shape {
                        kinds: Some(&[Kind::Object, Kind::Array]),
                        one_of: &[
                            Shape {
                                reference: Some("Agent"),
                                ..NONE
                            },
                            Shape {
                                kinds: Some(&[Kind::Array]),
                                items: Some(&Shape {
                                    reference: Some("Agent"),
                                    ..NONE
                                }),
                                ..NONE
                            },
                        ],
                        ..NONE
                    },
                ),
                (
                    "isDraft",
                    Shape {
                        kinds: Some(&[Kind::Boolean]),
                        ..NONE
                    },
                ),
                (
                    "jobId",
                    Shape {
                        reference: Some("JobId"),
                        ..NONE
                    },
                ),
                (
                    "language",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "name",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "storageUri",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "wasAttributedTo",
                    Shape {
                        kinds: Some(&[Kind::Object, Kind::Array]),
                        one_of: &[
                            Shape {
                                reference: Some("Agent"),
                                ..NONE
                            },
                            Shape {
                                kinds: Some(&[Kind::Array]),
                                items: Some(&Shape {
                                    reference: Some("Agent"),
                                    ..NONE
                                }),
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
                            Shape {
                                kinds: Some(&[Kind::String]),
                                ..NONE
                            },
                            Shape {
                                kinds: Some(&[Kind::Object]),
                                ..NONE
                            },
                            Shape {
                                kinds: Some(&[Kind::Array]),
                                items: Some(&Shape {
                                    kinds: Some(&[Kind::Object, Kind::String]),
                                    one_of: &[
                                        Shape {
                                            kinds: Some(&[Kind::String]),
                                            ..NONE
                                        },
                                        Shape {
                                            kinds: Some(&[Kind::Object]),
                                            ..NONE
                                        },
                                    ],
                                    ..NONE
                                }),
                                ..NONE
                            },
                        ],
                        ..NONE
                    },
                ),
                (
                    "@id",
                    Shape {
                        reference: Some("ResourceId"),
                        ..NONE
                    },
                ),
                (
                    "@type",
                    Shape {
                        kinds: Some(&[Kind::Array, Kind::String]),
                        one_of: &[
                            Shape {
                                kinds: Some(&[Kind::String]),
                                ..NONE
                            },
                            Shape {
                                kinds: Some(&[Kind::Array]),
                                min_items: Some(1),
                                items: Some(&Shape {
                                    kinds: Some(&[Kind::String]),
                                    ..NONE
                                }),
                                ..NONE
                            },
                        ],
                        ..NONE
                    },
                ),
                (
                    "about",
                    Shape {
                        kinds: Some(&[Kind::Array, Kind::String]),
                        one_of: &[
                            Shape {
                                kinds: Some(&[Kind::String]),
                                ..NONE
                            },
                            Shape {
                                kinds: Some(&[Kind::Array]),
                                min_items: Some(1),
                                items: Some(&Shape {
                                    kinds: Some(&[Kind::String]),
                                    ..NONE
                                }),
                                ..NONE
                            },
                        ],
                        ..NONE
                    },
                ),
                (
                    "archived",
                    Shape {
                        kinds: Some(&[Kind::Boolean]),
                        ..NONE
                    },
                ),
                (
                    "availableFormats",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&Shape {
                            kinds: Some(&[Kind::String]),
                            ..NONE
                        }),
                        ..NONE
                    },
                ),
                (
                    "conformsTo",
                    Shape {
                        kinds: Some(&[Kind::Array, Kind::String]),
                        one_of: &[
                            Shape {
                                kinds: Some(&[Kind::String]),
                                ..NONE
                            },
                            Shape {
                                kinds: Some(&[Kind::Array]),
                                items: Some(&Shape {
                                    kinds: Some(&[Kind::String]),
                                    ..NONE
                                }),
                                ..NONE
                            },
                        ],
                        ..NONE
                    },
                ),
                (
                    "dateCreated",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "dateModified",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "description",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "entityTypes",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&Shape {
                            kinds: Some(&[Kind::String]),
                            ..NONE
                        }),
                        ..NONE
                    },
                ),
                (
                    "generator",
                    Shape {
                        kinds: Some(&[Kind::Object, Kind::Array]),
                        one_of: &[
                            Shape {
                                reference: Some("Agent"),
                                ..NONE
                            },
                            Shape {
                                kinds: Some(&[Kind::Array]),
                                items: Some(&Shape {
                                    reference: Some("Agent"),
                                    ..NONE
                                }),
                                ..NONE
                            },
                        ],
                        ..NONE
                    },
                ),
                (
                    "hasPart",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&Shape {
                            kinds: Some(&[Kind::String]),
                            ..NONE
                        }),
                        ..NONE
                    },
                ),
                (
                    "identifier",
                    Shape {
                        kinds: Some(&[Kind::Object, Kind::Array, Kind::String]),
                        one_of: &[
                            Shape {
                                kinds: Some(&[Kind::String]),
                                ..NONE
                            },
                            Shape {
                                kinds: Some(&[Kind::Array]),
                                min_items: Some(1),
                                items: Some(&Shape {
                                    kinds: Some(&[Kind::String]),
                                    ..NONE
                                }),
                                ..NONE
                            },
                            Shape {
                                kinds: Some(&[Kind::Object]),
                                members: &[
                                    (
                                        "@id",
                                        Shape {
                                            kinds: Some(&[Kind::String]),
                                            ..NONE
                                        },
                                    ),
                                    (
                                        "scheme",
                                        Shape {
                                            kinds: Some(&[Kind::String]),
                                            ..NONE
                                        },
                                    ),
                                    (
                                        "value",
                                        Shape {
                                            kinds: Some(&[Kind::String]),
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
                    "isDraft",
                    Shape {
                        kinds: Some(&[Kind::Boolean]),
                        ..NONE
                    },
                ),
                (
                    "isPartOf",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&Shape {
                            kinds: Some(&[Kind::String]),
                            ..NONE
                        }),
                        ..NONE
                    },
                ),
                (
                    "license",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "name",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "originatedFrom",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "representations",
                    Shape {
                        kinds: Some(&[Kind::Object, Kind::Array]),
                        one_of: &[
                            Shape {
                                reference: Some("Representation"),
                                ..NONE
                            },
                            Shape {
                                kinds: Some(&[Kind::Array]),
                                items: Some(&Shape {
                                    reference: Some("Representation"),
                                    ..NONE
                                }),
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
                        items: Some(&Shape {
                            kinds: Some(&[Kind::String]),
                            ..NONE
                        }),
                        ..NONE
                    },
                ),
                (
                    "sourceAnnotationId",
                    Shape {
                        reference: Some("AnnotationId"),
                        ..NONE
                    },
                ),
                (
                    "sourceResourceId",
                    Shape {
                        reference: Some("ResourceId"),
                        ..NONE
                    },
                ),
                (
                    "version",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "wasAttributedTo",
                    Shape {
                        kinds: Some(&[Kind::Object, Kind::Array]),
                        one_of: &[
                            Shape {
                                reference: Some("Agent"),
                                ..NONE
                            },
                            Shape {
                                kinds: Some(&[Kind::Array]),
                                items: Some(&Shape {
                                    reference: Some("Agent"),
                                    ..NONE
                                }),
                                ..NONE
                            },
                        ],
                        ..NONE
                    },
                ),
                (
                    "wasDerivedFrom",
                    Shape {
                        kinds: Some(&[Kind::Array, Kind::String]),
                        one_of: &[
                            Shape {
                                reference: Some("ResourceId"),
                                ..NONE
                            },
                            Shape {
                                kinds: Some(&[Kind::Array]),
                                items: Some(&Shape {
                                    reference: Some("ResourceId"),
                                    ..NONE
                                }),
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
                (
                    "message",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "resourceId",
                    Shape {
                        reference: Some("ResourceId"),
                        ..NONE
                    },
                ),
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
                (
                    "fromUri",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "toUri",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
            ],
            ..NONE
        },
    ),
    (
        "ResourceUnarchivedPayload",
        Shape {
            kinds: Some(&[Kind::Object]),
            ..NONE
        },
    ),
    (
        "ResourceUpdatedPayload",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["contentChecksum"],
            members: &[
                (
                    "contentByteSize",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        ..NONE
                    },
                ),
                (
                    "contentChecksum",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
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
                (
                    "archiveOriginal",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "cloneToken",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "entityTypes",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "file",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "format",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "generationPrompt",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "generator",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "isDraft",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "jobId",
                    Shape {
                        reference: Some("JobId"),
                        ..NONE
                    },
                ),
                (
                    "language",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "name",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "sourceAnnotationId",
                    Shape {
                        reference: Some("AnnotationId"),
                        ..NONE
                    },
                ),
                (
                    "sourceResourceId",
                    Shape {
                        reference: Some("ResourceId"),
                        ..NONE
                    },
                ),
                (
                    "storageUri",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
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
                (
                    "annotations",
                    Shape {
                        reference: Some("ResourceAnnotations"),
                        ..NONE
                    },
                ),
                (
                    "lastSequence",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        minimum: Some(1.0),
                        ..NONE
                    },
                ),
                (
                    "resource",
                    Shape {
                        reference: Some("ResourceDescriptor"),
                        ..NONE
                    },
                ),
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
                Shape {
                    reference: Some("ResourceDescriptor"),
                    ..NONE
                },
                Shape {
                    kinds: Some(&[Kind::Object]),
                    members: &[
                        (
                            "matchReason",
                            Shape {
                                kinds: Some(&[Kind::String]),
                                ..NONE
                            },
                        ),
                        (
                            "score",
                            Shape {
                                kinds: Some(&[Kind::Number]),
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
        "Selector",
        Shape {
            kinds: Some(&[Kind::Object]),
            one_of: &[
                Shape {
                    reference: Some("TextPositionSelector"),
                    ..NONE
                },
                Shape {
                    reference: Some("TextQuoteSelector"),
                    ..NONE
                },
                Shape {
                    reference: Some("SvgSelector"),
                    ..NONE
                },
                Shape {
                    reference: Some("FragmentSelector"),
                    ..NONE
                },
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
                (
                    "annotationId",
                    Shape {
                        reference: Some("AnnotationId"),
                        ..NONE
                    },
                ),
                (
                    "entityTypes",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&Shape {
                            kinds: Some(&[Kind::String]),
                            ..NONE
                        }),
                        ..NONE
                    },
                ),
                (
                    "machineRead",
                    Shape {
                        kinds: Some(&[Kind::Boolean]),
                        ..NONE
                    },
                ),
                (
                    "resourceId",
                    Shape {
                        reference: Some("ResourceId"),
                        ..NONE
                    },
                ),
                (
                    "resourceName",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "score",
                    Shape {
                        kinds: Some(&[Kind::Number]),
                        ..NONE
                    },
                ),
                (
                    "text",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
            ],
            ..NONE
        },
    ),
    (
        "SessionJoinedEvent",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["participant", "connectionId"],
            members: &[
                (
                    "connectionId",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "participant",
                    Shape {
                        reference: Some("UserId"),
                        ..NONE
                    },
                ),
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
                (
                    "connectionId",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "participant",
                    Shape {
                        reference: Some("UserId"),
                        ..NONE
                    },
                ),
            ],
            ..NONE
        },
    ),
    (
        "SettingsHoverDelayChangedEvent",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["hoverDelayMs"],
            members: &[(
                "hoverDelayMs",
                Shape {
                    kinds: Some(&[Kind::Integer]),
                    ..NONE
                },
            )],
            ..NONE
        },
    ),
    (
        "SettingsLocaleChangedEvent",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["locale"],
            members: &[(
                "locale",
                Shape {
                    kinds: Some(&[Kind::String]),
                    ..NONE
                },
            )],
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
                (
                    "_userId",
                    Shape {
                        reference: Some("UserId"),
                        ..NONE
                    },
                ),
                (
                    "resourceId",
                    Shape {
                        reference: Some("ResourceId"),
                        ..NONE
                    },
                ),
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
                (
                    "contentChecksum",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
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
                (
                    "resourceId",
                    Shape {
                        reference: Some("ResourceId"),
                        ..NONE
                    },
                ),
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
                (
                    "archivist",
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
                (
                    "cursorsPath",
                    Shape {
                        reference: Some("CursorsPath"),
                        ..NONE
                    },
                ),
                (
                    "embedding",
                    Shape {
                        reference: Some("EmbeddingConfig"),
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
                    "kb",
                    Shape {
                        reference: Some("KbIdentity"),
                        ..NONE
                    },
                ),
                (
                    "logFormat",
                    Shape {
                        reference: Some("LogFormat"),
                        ..NONE
                    },
                ),
                (
                    "logLevel",
                    Shape {
                        reference: Some("LogLevel"),
                        ..NONE
                    },
                ),
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
                (
                    "vectors",
                    Shape {
                        reference: Some("VectorsConfig"),
                        ..NONE
                    },
                ),
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
                (
                    "purpose",
                    Shape {
                        reference: Some("BodyPurpose"),
                        ..NONE
                    },
                ),
                (
                    "source",
                    Shape {
                        reference: Some("ResourceId"),
                        ..NONE
                    },
                ),
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
                (
                    "authenticatedAs",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "features",
                    Shape {
                        kinds: Some(&[Kind::Object]),
                        required: &["semanticContent", "collaboration"],
                        members: &[
                            (
                                "collaboration",
                                Shape {
                                    kinds: Some(&[Kind::String]),
                                    ..NONE
                                },
                            ),
                            (
                                "semanticContent",
                                Shape {
                                    kinds: Some(&[Kind::String]),
                                    ..NONE
                                },
                            ),
                        ],
                        ..NONE
                    },
                ),
                (
                    "message",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "status",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "version",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
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
                (
                    "resourceId",
                    Shape {
                        reference: Some("ResourceId"),
                        ..NONE
                    },
                ),
                (
                    "uri",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
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
                (
                    "id",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "metadata",
                    Shape {
                        reference: Some("EventMetadata"),
                        ..NONE
                    },
                ),
                (
                    "payload",
                    Shape {
                        kinds: Some(&[Kind::Object]),
                        ..NONE
                    },
                ),
                (
                    "resourceId",
                    Shape {
                        reference: Some("ResourceId"),
                        ..NONE
                    },
                ),
                (
                    "timestamp",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "type",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "userId",
                    Shape {
                        reference: Some("UserId"),
                        ..NONE
                    },
                ),
                (
                    "version",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        ..NONE
                    },
                ),
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
                (
                    "value",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
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
                (
                    "description",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "examples",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&Shape {
                            kinds: Some(&[Kind::String]),
                            ..NONE
                        }),
                        ..NONE
                    },
                ),
                (
                    "name",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
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
                (
                    "description",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "domain",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "id",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "name",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "tags",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&Shape {
                            reference: Some("TagCategory"),
                            ..NONE
                        }),
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
            members: &[(
                "schema",
                Shape {
                    reference: Some("TagSchema"),
                    ..NONE
                },
            )],
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
                    items: Some(&Shape {
                        reference: Some("TagSchema"),
                        ..NONE
                    }),
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
                        items: Some(&Shape {
                            kinds: Some(&[Kind::String]),
                            ..NONE
                        }),
                        ..NONE
                    },
                ),
                (
                    "language",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
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
                (
                    "sourceLanguage",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
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
                (
                    "exact",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "prefix",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "suffix",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
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
                (
                    "format",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "language",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "purpose",
                    Shape {
                        reference: Some("BodyPurpose"),
                        ..NONE
                    },
                ),
                (
                    "type",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[Listed::Text("TextualBody")]),
                        ..NONE
                    },
                ),
                (
                    "value",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
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
                        items: Some(&Shape {
                            kinds: Some(&[Kind::Object]),
                            one_of: &[
                                Shape {
                                    reference: Some("BodyOperationAdd"),
                                    ..NONE
                                },
                                Shape {
                                    reference: Some("BodyOperationRemove"),
                                    ..NONE
                                },
                                Shape {
                                    reference: Some("BodyOperationReplace"),
                                    ..NONE
                                },
                            ],
                            ..NONE
                        }),
                        ..NONE
                    },
                ),
                (
                    "resourceId",
                    Shape {
                        reference: Some("ResourceId"),
                        ..NONE
                    },
                ),
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
                (
                    "did",
                    Shape {
                        reference: Some("UserId"),
                        ..NONE
                    },
                ),
                (
                    "domain",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "email",
                    Shape {
                        kinds: Some(&[Kind::String, Kind::Null]),
                        ..NONE
                    },
                ),
                (
                    "image",
                    Shape {
                        kinds: Some(&[Kind::String, Kind::Null]),
                        ..NONE
                    },
                ),
                (
                    "name",
                    Shape {
                        kinds: Some(&[Kind::String, Kind::Null]),
                        ..NONE
                    },
                ),
            ],
            ..NONE
        },
    ),
    (
        "VectorsConfig",
        Shape {
            kinds: Some(&[Kind::Object]),
            one_of: &[
                Shape {
                    reference: Some("QdrantVectorsConfig"),
                    ..NONE
                },
                Shape {
                    reference: Some("MemoryVectorsConfig"),
                    ..NONE
                },
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
                (
                    "resourceId",
                    Shape {
                        reference: Some("ResourceId"),
                        ..NONE
                    },
                ),
                (
                    "sequenceNumber",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        ..NONE
                    },
                ),
            ],
            ..NONE
        },
    ),
    (
        "WeaveRebuildCommand",
        Shape {
            kinds: Some(&[Kind::Object]),
            members: &[
                (
                    "_userId",
                    Shape {
                        reference: Some("UserId"),
                        ..NONE
                    },
                ),
                (
                    "resourceId",
                    Shape {
                        reference: Some("ResourceId"),
                        ..NONE
                    },
                ),
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
                (
                    "archivist",
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
                    "cursorsPath",
                    Shape {
                        reference: Some("CursorsPath"),
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
                    "graph",
                    Shape {
                        reference: Some("GraphConfig"),
                        ..NONE
                    },
                ),
                (
                    "identity",
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
                    "kb",
                    Shape {
                        reference: Some("KbIdentity"),
                        ..NONE
                    },
                ),
                (
                    "logFormat",
                    Shape {
                        reference: Some("LogFormat"),
                        ..NONE
                    },
                ),
                (
                    "logLevel",
                    Shape {
                        reference: Some("LogLevel"),
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
                        items: Some(&Shape {
                            reference: Some("WorkerKnowledgeBaseConfig"),
                            ..NONE
                        }),
                        ..NONE
                    },
                ),
                (
                    "logFormat",
                    Shape {
                        reference: Some("LogFormat"),
                        ..NONE
                    },
                ),
                (
                    "logLevel",
                    Shape {
                        reference: Some("LogLevel"),
                        ..NONE
                    },
                ),
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
                (
                    "engine",
                    Shape {
                        reference: Some("Engine"),
                        ..NONE
                    },
                ),
                (
                    "jobs",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        min_items: Some(1),
                        items: Some(&Shape {
                            reference: Some("JobFilter"),
                            ..NONE
                        }),
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
                            (
                                "jobId",
                                Shape {
                                    reference: Some("JobId"),
                                    ..NONE
                                },
                            ),
                            (
                                "since",
                                Shape {
                                    kinds: Some(&[Kind::String]),
                                    ..NONE
                                },
                            ),
                            (
                                "type",
                                Shape {
                                    reference: Some("JobType"),
                                    ..NONE
                                },
                            ),
                        ],
                        closed: Some(&["jobId", "since", "type"]),
                        ..NONE
                    },
                ),
                (
                    "engine",
                    Shape {
                        reference: Some("Engine"),
                        ..NONE
                    },
                ),
                (
                    "jobs",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        min_items: Some(1),
                        items: Some(&Shape {
                            reference: Some("JobFilter"),
                            ..NONE
                        }),
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
                (
                    "lastActivityAt",
                    Shape {
                        kinds: Some(&[Kind::String, Kind::Null]),
                        ..NONE
                    },
                ),
                (
                    "lastClaimAt",
                    Shape {
                        kinds: Some(&[Kind::String, Kind::Null]),
                        ..NONE
                    },
                ),
                (
                    "lastFinishedAt",
                    Shape {
                        kinds: Some(&[Kind::String, Kind::Null]),
                        ..NONE
                    },
                ),
                (
                    "lastQueuedEventAt",
                    Shape {
                        kinds: Some(&[Kind::String, Kind::Null]),
                        ..NONE
                    },
                ),
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
                        items: Some(&Shape {
                            reference: Some("WorkerKnowledgeBaseHealth"),
                            ..NONE
                        }),
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
                        items: Some(&Shape {
                            reference: Some("WorkerEngineConfig"),
                            ..NONE
                        }),
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
                        items: Some(&Shape {
                            reference: Some("WorkerEngineHealth"),
                            ..NONE
                        }),
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
                (
                    "_userId",
                    Shape {
                        reference: Some("UserId"),
                        ..NONE
                    },
                ),
                (
                    "archiveOriginal",
                    Shape {
                        kinds: Some(&[Kind::Boolean]),
                        ..NONE
                    },
                ),
                (
                    "byteSize",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        ..NONE
                    },
                ),
                (
                    "contentChecksum",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "format",
                    Shape {
                        reference: Some("ContentFormat"),
                        ..NONE
                    },
                ),
                (
                    "name",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "storageUri",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "token",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
            ],
            ..NONE
        },
    ),
    (
        "YieldCloneCreated",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["response"],
            members: &[(
                "response",
                Shape {
                    kinds: Some(&[Kind::Object]),
                    required: &["resourceId"],
                    members: &[(
                        "resourceId",
                        Shape {
                            reference: Some("ResourceId"),
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
                (
                    "_userId",
                    Shape {
                        reference: Some("UserId"),
                        ..NONE
                    },
                ),
                (
                    "byteSize",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        ..NONE
                    },
                ),
                (
                    "contentChecksum",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "entityTypes",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&Shape {
                            kinds: Some(&[Kind::String]),
                            ..NONE
                        }),
                        ..NONE
                    },
                ),
                (
                    "format",
                    Shape {
                        reference: Some("ContentFormat"),
                        ..NONE
                    },
                ),
                (
                    "language",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "name",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "parentResourceId",
                    Shape {
                        reference: Some("ResourceId"),
                        ..NONE
                    },
                ),
                (
                    "storageUri",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
            ],
            ..NONE
        },
    ),
    (
        "YieldClonePersistOk",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["response"],
            members: &[(
                "response",
                Shape {
                    kinds: Some(&[Kind::Object]),
                    required: &["resourceId"],
                    members: &[(
                        "resourceId",
                        Shape {
                            reference: Some("ResourceId"),
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
        "YieldCloneResourceRequest",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["token"],
            members: &[(
                "token",
                Shape {
                    kinds: Some(&[Kind::String]),
                    ..NONE
                },
            )],
            ..NONE
        },
    ),
    (
        "YieldCloneTokenRequest",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["resourceId"],
            members: &[(
                "resourceId",
                Shape {
                    reference: Some("ResourceId"),
                    ..NONE
                },
            )],
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
                        items: Some(&Shape {
                            kinds: Some(&[Kind::String]),
                            ..NONE
                        }),
                        ..NONE
                    },
                ),
                (
                    "_userId",
                    Shape {
                        reference: Some("UserId"),
                        ..NONE
                    },
                ),
                (
                    "byteSize",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        ..NONE
                    },
                ),
                (
                    "contentChecksum",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "entityTypes",
                    Shape {
                        kinds: Some(&[Kind::Array]),
                        items: Some(&Shape {
                            kinds: Some(&[Kind::String]),
                            ..NONE
                        }),
                        ..NONE
                    },
                ),
                (
                    "format",
                    Shape {
                        reference: Some("ContentFormat"),
                        ..NONE
                    },
                ),
                (
                    "generatedFrom",
                    Shape {
                        kinds: Some(&[Kind::Object]),
                        members: &[
                            (
                                "annotationId",
                                Shape {
                                    reference: Some("AnnotationId"),
                                    ..NONE
                                },
                            ),
                            (
                                "resourceId",
                                Shape {
                                    reference: Some("ResourceId"),
                                    ..NONE
                                },
                            ),
                        ],
                        ..NONE
                    },
                ),
                (
                    "generationPrompt",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "generator",
                    Shape {
                        kinds: Some(&[Kind::Object, Kind::Array]),
                        one_of: &[
                            Shape {
                                reference: Some("Agent"),
                                ..NONE
                            },
                            Shape {
                                kinds: Some(&[Kind::Array]),
                                items: Some(&Shape {
                                    reference: Some("Agent"),
                                    ..NONE
                                }),
                                ..NONE
                            },
                        ],
                        ..NONE
                    },
                ),
                (
                    "isDraft",
                    Shape {
                        kinds: Some(&[Kind::Boolean]),
                        ..NONE
                    },
                ),
                (
                    "jobId",
                    Shape {
                        reference: Some("JobId"),
                        ..NONE
                    },
                ),
                (
                    "language",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "name",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "storageUri",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
            ],
            ..NONE
        },
    ),
    (
        "YieldCreateOk",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["response"],
            members: &[(
                "response",
                Shape {
                    kinds: Some(&[Kind::Object]),
                    required: &["resourceId"],
                    members: &[(
                        "resourceId",
                        Shape {
                            reference: Some("ResourceId"),
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
        "YieldJobCompleteCommand",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["resourceId", "jobId", "jobType"],
            members: &[
                (
                    "_userId",
                    Shape {
                        reference: Some("UserId"),
                        ..NONE
                    },
                ),
                (
                    "annotationId",
                    Shape {
                        reference: Some("AnnotationId"),
                        ..NONE
                    },
                ),
                (
                    "attempt",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        ..NONE
                    },
                ),
                (
                    "durability",
                    Shape {
                        reference: Some("DurabilityEvidence"),
                        ..NONE
                    },
                ),
                (
                    "jobId",
                    Shape {
                        reference: Some("JobId"),
                        ..NONE
                    },
                ),
                (
                    "jobType",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[Listed::Text("yield")]),
                        ..NONE
                    },
                ),
                (
                    "resourceId",
                    Shape {
                        reference: Some("ResourceId"),
                        ..NONE
                    },
                ),
                (
                    "result",
                    Shape {
                        reference: Some("YieldJobResult"),
                        ..NONE
                    },
                ),
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
                        items: Some(&Shape {
                            kinds: Some(&[Kind::String]),
                            ..NONE
                        }),
                        ..NONE
                    },
                ),
                (
                    "_userId",
                    Shape {
                        reference: Some("UserId"),
                        ..NONE
                    },
                ),
                (
                    "jobType",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[Listed::Text("yield")]),
                        ..NONE
                    },
                ),
                (
                    "params",
                    Shape {
                        reference: Some("GenerationJobParams"),
                        ..NONE
                    },
                ),
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
                (
                    "resourceId",
                    Shape {
                        reference: Some("ResourceId"),
                        ..NONE
                    },
                ),
                (
                    "resourceName",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "truncated",
                    Shape {
                        kinds: Some(&[Kind::Boolean]),
                        ..NONE
                    },
                ),
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
                (
                    "jobId",
                    Shape {
                        reference: Some("JobId"),
                        ..NONE
                    },
                ),
                (
                    "jobType",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        enumeration: Some(&[Listed::Text("yield")]),
                        ..NONE
                    },
                ),
                (
                    "params",
                    Shape {
                        reference: Some("GenerationJobRequest"),
                        ..NONE
                    },
                ),
                (
                    "resourceId",
                    Shape {
                        reference: Some("ResourceId"),
                        ..NONE
                    },
                ),
                (
                    "userId",
                    Shape {
                        reference: Some("UserId"),
                        ..NONE
                    },
                ),
            ],
            ..NONE
        },
    ),
    (
        "YieldJobResult",
        Shape {
            kinds: Some(&[Kind::Object]),
            one_of: &[
                Shape {
                    reference: Some("YieldJobDone"),
                    ..NONE
                },
                Shape {
                    reference: Some("JobDeclined"),
                    ..NONE
                },
            ],
            ..NONE
        },
    ),
    (
        "YieldUpdateCommand",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["resourceId", "storageUri", "contentChecksum", "byteSize"],
            members: &[
                (
                    "_userId",
                    Shape {
                        reference: Some("UserId"),
                        ..NONE
                    },
                ),
                (
                    "byteSize",
                    Shape {
                        kinds: Some(&[Kind::Integer]),
                        ..NONE
                    },
                ),
                (
                    "contentChecksum",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
                (
                    "resourceId",
                    Shape {
                        reference: Some("ResourceId"),
                        ..NONE
                    },
                ),
                (
                    "storageUri",
                    Shape {
                        kinds: Some(&[Kind::String]),
                        ..NONE
                    },
                ),
            ],
            ..NONE
        },
    ),
    (
        "YieldUpdateOk",
        Shape {
            kinds: Some(&[Kind::Object]),
            required: &["response"],
            members: &[(
                "response",
                Shape {
                    kinds: Some(&[Kind::Object]),
                    required: &["resourceId"],
                    members: &[(
                        "resourceId",
                        Shape {
                            reference: Some("ResourceId"),
                            ..NONE
                        },
                    )],
                    ..NONE
                },
            )],
            ..NONE
        },
    ),
];
