package xynolog.mediatypes

/** One media type a knowledge base admits. Its extension is the one a stored name takes, with its dot; an authorable type is offered where a person writes a resource; a generatable one the generation worker can produce. */
internal data class MediaType(val mediaType: String, val extension: String, val textSource: TextSource, val authorable: Boolean, val generatable: Boolean)
