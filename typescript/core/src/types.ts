// ⚠ GENERATED FILE — do not edit.
//
// Authority:   the component schemas of protocol/specs/src/openapi.json
//              protocol/specs/src/identifiers/kinds.json, for the brands
// Regenerate:  make generate  (codegen/lib/typescript_types/typescript_types.ml)

export interface components {
  schemas: {
    /**
     * Web Annotation / W3C PROV Agent. Discriminated by @type — Person,
     * Organization, or Software (named member schemas: AgentPerson,
     * AgentOrganization, AgentSoftware). Software peers are first-class
     * participants, not a sub-class of Person.
     */
    Agent:
      | components['schemas']['AgentPerson']
      | components['schemas']['AgentOrganization']
      | components['schemas']['AgentSoftware'];
    /** An organization — the Organization branch of Agent. */
    AgentOrganization: {
      '@type': 'Organization';
      '@id'?: string;
      name: string;
      homepage?: string;
    } & { [key: string]: unknown };
    /** A human participant — the Person branch of Agent. */
    AgentPerson: {
      '@type': 'Person';
      /** DID-shaped identifier (e.g. did:web:host:users:email%40host) */
      '@id'?: string;
      /**
       * Display name. ABSENT until resolved: a Person is identified by `@id`
       * and nothing else, and what they are called is recorded once per change
       * on the knowledge base's own log and filled in when a record is read. An
       * artifact therefore never freezes a name, which is what lets a
       * correction reach every artifact its subject ever wrote. Absent also
       * means genuinely unknown — a DID this knowledge base has no profile for.
       */
      name?: string;
      nickname?: string;
      email?: string;
      email_sha1?: string;
      homepage?: string;
    } & { [key: string]: unknown };
    /**
     * A software peer, the Software branch of Agent: an agent, which is an
     * account as a person is. Its `provider` and `model` are what it says of
     * itself, attributed to it and not checked; the knowledge base reads
     * neither from its DID. Its `name` is no part of what it writes: what it
     * last said it is called is its profile, and readers fill it in, as they do
     * a person's. A generator the knowledge base supplies, for an agent that
     * supplied none, carries `@type` and `@id` alone.
     */
    AgentSoftware: {
      '@type': 'Software';
      /**
       * The agent's DID: did:web:<domain>:agents:<subject>, its account at the
       * knowledge base's issuer
       */
      '@id'?: string;
      /**
       * What the agent last said it is called. ABSENT until resolved: filled in
       * from its profile when a record is read, as a Person's name is. Absent
       * also where it has said nothing. Not parsed.
       */
      name?: string;
      /** Inference provider (e.g. ollama, anthropic) */
      provider?: string;
      /** Model identifier (e.g. gemma2:27b, claude-3-5-sonnet) */
      model?: string;
      /**
       * Inference parameters (temperature, maxTokens, systemPrompt, etc.).
       * Runtime metadata, not part of identity.
       */
      parameters?: { [key: string]: unknown };
    } & { [key: string]: unknown };
    /**
     * Text paired with the geometry that indexes it — the minimum needed to
     * turn a range of the text, two offsets counted in Unicode code points,
     * into a selection, or a rectangle into a quote. Whole-resource: a producer
     * iterates page by page, but every consumer wants one map.
     */
    AnchoredText: {
      /** Reading-order text of the whole resource. */
      text: string;
      /** Positioned runs indexing `text`, roughly one per word. */
      items: components['schemas']['PdfTextItem'][];
    };
    /**
     * There is no coordinate map to serve, and WHY — the distinction a bare
     * null could not carry.
     *
     * One member covers all three absences because none carries a payload;
     * `kind` alone is the fact. Retryability is legible from the name,
     * deliberately: a caller must not need a lookup table to decide whether to
     * come back.
     */
    AnchoredTextAbsent: {
      /**
       * Discriminant, sharing the `kind` field with the
       * ExtractedText/ExtractionDeclined members so the whole answer is one
       * flat union.
       *
       * `not-yet` — the resource's media type has text that is derived by
       * reading its content, and the store holds no entry for this content: the
       * Smelter has not read it yet, or the entry was lost (a loss the
       * Smelter's reconcile pass re-derives). RETRY.
       *
       * `no-map` — the resource's media type has no derived text, so no entry
       * exists and none will until the type is given a reader. Decided by the
       * media type alone, and answered at once. TERMINAL.
       *
       * `unknown` — no content identity to look up: the resource is not in the
       * view store, or its primary representation carries no checksum.
       * TERMINAL.
       */
      kind: 'not-yet' | 'no-map' | 'unknown';
    };
    /**
     * What a reader gets when it asks for a resource's coordinate map: the map,
     * a stored decline, or a named absence.
     *
     * Distinct from `ExtractionOutcome` on purpose. That type is what the STORE
     * holds and what an extractor RETURNS — neither of which can ever be 'not
     * yet'. This is the read answer, which can, so widening ExtractionOutcome
     * itself would have put an impossible state into the store's own type.
     *
     * Flat, one discriminant: every member carries `kind`, rather than nesting
     * an outcome inside a status envelope and giving the wire two `kind` fields
     * at different depths.
     */
    AnchoredTextAnswer:
      | components['schemas']['ExtractedText']
      | components['schemas']['ExtractionDeclined']
      | components['schemas']['AnchoredTextAbsent'];
    /** The bytes were declined: no text is extracted from them. */
    AnchoredTextDeclinedEntry: {
      /** The entry format. */
      v: 3;
      /**
       * The stamp the entry was derived under: the PDF reader's and the OCR
       * engine's. A reader takes the entry only when it equals the stamp the
       * Smelter last stated.
       */
      stamp: string;
      /** Why extraction yielded nothing, by class. */
      declined: components['schemas']['ExtractionDeclinedReason'];
    };
    /**
     * The keys of the entries the anchored-text store holds under the stamp
     * last stated: one checksum for each set of bytes whose text is stored, in
     * no order.
     */
    AnchoredTextEntries: {
      checksums: string[];
    };
    /**
     * One entry of the anchored-text store: the file `<ab>/<cd>/<key>.json`
     * under the store's directory, where the key is the SHA-256 of the bytes
     * the text was extracted from, in hex. The Smelter derives it and stores it
     * over the Archivist's HTTP surface (`AnchoredTextWrite`); the Archivist
     * writes it, as compact JSON with `v` and `stamp` first, to a sibling
     * temporary file renamed onto the path. The stamp the Smelter states
     * (`AnchoredTextStamp`) is kept, followed by a newline, in the file `STAMP`
     * at the store's root.
     */
    AnchoredTextEntry:
      | components['schemas']['AnchoredTextExtractedEntry']
      | components['schemas']['AnchoredTextDeclinedEntry'];
    /**
     * The text extracted from the bytes, where each word is on the page, and
     * how it was extracted.
     */
    AnchoredTextExtractedEntry: {
      /** The entry format. */
      v: 3;
      /**
       * The stamp the entry was derived under: the PDF reader's and the OCR
       * engine's. A reader takes the entry only when it equals the stamp the
       * Smelter last stated.
       */
      stamp: string;
      /** The extracted text. */
      text: string;
      /** Where each word of `text` is, line by line, in reading order. */
      lines: {
        /** The page, counted from 1. */
        p: number;
        /**
         * The line's vertical position in PDF points, from the bottom of the
         * page.
         */
        y: number;
        /** The line's height in PDF points. */
        h: number;
        /**
         * Each word as `[x, width, start, end]`: its horizontal position and
         * width in PDF points, and the offsets of its text in `text`, which are
         * whole numbers of Unicode code points from the start of `text`.
         */
        words: number[][];
      }[];
      /** How the text was extracted. */
      method: components['schemas']['ExtractionMethod'];
      /** PDF classification, when the source was a PDF. */
      pdfClass?: components['schemas']['PdfClass'];
      /**
       * How well the engine read the pixels, when any of this text came from
       * OCR.
       */
      ocrConfidence?: components['schemas']['OcrConfidence'];
      /**
       * 1-indexed pages this extraction could not read — present only for
       * partially covered documents (class C).
       */
      unreadPages?: number[];
    };
    /**
     * The stamp an anchored-text store's entries are taken under: which PDF
     * reader and which OCR engine derived them. Its writer states it before it
     * writes or lists an entry; an entry stored under another stamp is answered
     * to no reader.
     */
    AnchoredTextStamp: {
      /** The stamp: no white space, since it is held in a file of one line. */
      stamp: string;
    };
    /**
     * A write of an anchored-text entry for the bytes of one resource: what the
     * Smelter derived from them, and their checksum. The Archivist files the
     * entry under the checksum, so every resource whose bytes those are has it,
     * and refuses the write when the resource's first representation has other
     * bytes.
     */
    AnchoredTextWrite: {
      /**
       * The SHA-256 of the bytes the text was derived from, as 64 lower-case
       * hexadecimal digits: the key the entry is filed under.
       */
      contentChecksum: string;
      entry: components['schemas']['AnchoredTextEntry'];
    };
    Annotation: {
      /** W3C Web Annotation JSON-LD context */
      '@context': 'http://www.w3.org/ns/anno.jsonld';
      /** W3C Annotation type */
      type: 'Annotation';
      id: components['schemas']['AnnotationId'];
      motivation: components['schemas']['Motivation'];
      /**
       * W3C Web Annotation target: the id of the resource annotated, when the
       * whole of it is, or an object with source and optional selector
       * (fragment)
       */
      target:
        | components['schemas']['ResourceId']
        | components['schemas']['AnnotationTarget'];
      /**
       * W3C Web Annotation body. Optional per the W3C spec — annotations whose
       * motivation alone is meaningful (highlighting) legitimately omit it.
       * Present values are either a single body or a non-empty array of bodies;
       * there is no empty array.
       */
      body?: components['schemas']['AnnotationBodies'];
      creator?: components['schemas']['Agent'];
      /**
       * When the annotation was MADE — the authoring moment, carried from the
       * event that created it. Not when a projection happened to write it: a
       * store that rebuilds from the log must preserve this value, never
       * restamp it.
       */
      created: string;
      modified?: string;
      /**
       * Web Annotation generator — the Software peer that produced the
       * annotation, when software did. Absent for a person's own annotation. An
       * emitter may supply it to carry the model's parameters, but its identity
       * must be the emitter's own: the knowledge base refuses a generator
       * naming anyone else, and supplies it from the verified emitter when
       * omitted. One producer per write — a write carrying the array form is
       * refused.
       */
      generator?: components['schemas']['OneOrMoreAgents'];
      /**
       * PROV-O wasAttributedTo — every party responsible for this annotation,
       * DERIVED by the knowledge base from `creator` and the verified executor
       * of the write: `[creator, generator]` when one agent requested the work
       * and software produced it; collapsed to the one agent when requester and
       * producer are the same. Never accepted from an emitter.
       */
      wasAttributedTo?: components['schemas']['OneOrMoreAgents'];
    };
    /** Payload for mark:added domain event */
    AnnotationAddedPayload: {
      annotation: components['schemas']['Annotation'];
      /** SHA-256 of resource content at annotation time */
      contentChecksum?: string;
    };
    /**
     * What an annotation's `body` holds: one body, or a non-empty list of them.
     * There is no empty list: an annotation with nothing to say has no `body`.
     */
    AnnotationBodies:
      | components['schemas']['AnnotationBody']
      | components['schemas']['AnnotationBody'][];
    /**
     * An annotation's body: a TextualBody carries text the annotation states
     * (entity tags, descriptions, comments), a SpecificResource points at what
     * it links to. Tell them apart by `type`, which is required on both and
     * single-valued — a consumer never has to probe for which fields happen to
     * be present.
     */
    AnnotationBody:
      | components['schemas']['TextualBody']
      | components['schemas']['SpecificResource'];
    /** Payload for mark:body-updated domain event */
    AnnotationBodyUpdatedPayload: {
      annotationId: components['schemas']['AnnotationId'];
      operations: components['schemas']['BodyOperation'][];
    };
    /**
     * An annotation's id: a name, never the annotation's URI. 1 to 128 of the
     * letters `A`–`Z` and `a`–`z`, the digits, `_` and `-`. It is one segment
     * of a URL and one name in a file system, and it is held to that wherever
     * it enters: a gateway refuses a payload that carries anything else. How
     * one is made is no part of the rule.
     */
    AnnotationId: string & { readonly __brand: 'AnnotationId' };
    /** Payload for mark:removed domain event */
    AnnotationRemovedPayload: {
      annotationId: components['schemas']['AnnotationId'];
    };
    /**
     * What a target's `selector` holds: one W3C selector, or several of the
     * same segment.
     */
    AnnotationSelector:
      components['schemas']['Selector'] | components['schemas']['Selector'][];
    /**
     * W3C Web Annotation target object - source is required, selector is
     * optional
     */
    AnnotationTarget: {
      /**
       * Stated by the annotation of a span: the target is a part of its source,
       * which the selector picks out. An annotation of a resource as a whole
       * states none.
       */
      type?: 'SpecificResource';
      /** The id of the resource being annotated */
      source: components['schemas']['ResourceId'];
      /**
       * Optional selector to identify a specific segment of the source resource
       */
      selector?: components['schemas']['AnnotationSelector'];
    };
    /**
     * Everything the Archivist reads at boot: nothing in it is defaulted by the
     * Archivist. The launcher writes it for the Archivist it starts, from the
     * knowledge base's stack documents, and the Archivist reads it from the
     * path its `--config` flag names (its image passes
     * `/etc/xynolog/archivist.json`). Started without `--config`, or with a
     * path that names no file, the Archivist refuses to start and says which.
     * No secret is a value here. What the knowledge base says of itself is not
     * here either: its name, its `site.domain` and its `git.sync` are read from
     * the committed `.xynolog/config.yaml` of the tree at `root`. The
     * Archivist's other inputs are the environment variables
     * specs/src/service-environment/variables.json lists for it. A document
     * that does not validate is refused at boot, naming each failing field.
     */
    ArchivistConfig: {
      /**
       * The URL the Archivist reaches the gateway at: its only route to the
       * bus.
       */
      gatewayUrl: string;
      /**
       * The issuer the Archivist's service account signs in at, and whose
       * tokens it admits callers of its HTTP surface by.
       */
      identity: components['schemas']['ServiceIdentity'];
      /**
       * The knowledge base's working tree: the directory holding `.xynolog/`.
       * The event log, the content and the committed config are under it.
       */
      root: string;
      /**
       * The state volume, this knowledge base's alone: the Archivist keeps the
       * knowledge base's views and projections in it, at its top.
       */
      stateHome: string;
      /**
       * The anchored-text store, which only the Archivist mounts: the Smelter
       * stores each entry in it over HTTP, and the Archivist serves it.
       */
      anchoredTextDir: string;
      engines: components['schemas']['ArchivistEngines'];
      /**
       * The port the Archivist's HTTP surface answers on, `/health` included.
       */
      port: number;
      /**
       * Whether the Archivist serves the views it finds at boot instead of
       * rebuilding them from the event log first.
       */
      skipRebuild: boolean;
      /**
       * The bounds on how far the staging driver may run behind the working
       * tree, in milliseconds. A knowledge base that does not sync git stages
       * nothing, and reads neither.
       */
      staging: {
        /**
         * The quiet period after the last change before pending changes are
         * staged.
         */
        flushMs: number;
        /**
         * The longest a change waits to be staged while others keep arriving,
         * measured from the oldest pending change.
         */
        maxWaitMs: number;
      };
      logLevel: components['schemas']['LogLevel'];
      logFormat: components['schemas']['LogFormat'];
    };
    /**
     * The engine for each job and each Librarian actor, behind
     * `browse:engines`: a provider and a model, and no credential. It is the
     * knowledge base's Inference document's `engines` as they stand, with no
     * fallback, so a job or an actor absent here has no engine.
     */
    ArchivistEngines: {
      /**
       * The engine each job is done with when software does it, keyed as a job
       * description is: by `jobType`, and for `mark` by motivation.
       */
      jobs: {
        /** The engine for `mark` jobs of each motivation. */
        mark?: {
          highlighting?: components['schemas']['Engine'];
          commenting?: components['schemas']['Engine'];
          assessing?: components['schemas']['Engine'];
          linking?: components['schemas']['Engine'];
          tagging?: components['schemas']['Engine'];
        };
        yield?: components['schemas']['Engine'];
      };
      /** The engine each Librarian actor that calls a model asks. */
      actors: {
        gatherer?: components['schemas']['Engine'];
        matcher?: components['schemas']['Engine'];
      };
    };
    /**
     * A page of one stream's events from one sequence number, inclusive, in log
     * order, and the sequence number of the stream's last event: the
     * Archivist's answer to `GET /events/{resourceId}`.
     */
    ArchivistEventsResponse: {
      events: components['schemas']['StoredEventResponse'][];
      /**
       * The sequence number of the stream's last event when it was read: 0 for
       * a stream with none. More events follow the page while its last event's
       * number is below it.
       */
      lastSequence: number;
    };
    /** The Archivist's liveness answer: it serves, and the actors it hosts. */
    ArchivistHealth: {
      status: 'ok';
      /** The record actors this process hosts. */
      actors: string[];
    };
    /**
     * One stream of the event log, and where it stands: the resource it is of,
     * or `__system__` for the knowledge base's own, and the sequence number of
     * its last event.
     */
    ArchivistStream: {
      resourceId: components['schemas']['ResourceId'];
      /**
       * The sequence number of the stream's last event when it was read: 0 for
       * a stream with none.
       */
      lastSequence: number;
    };
    /**
     * Every stream of the event log, `__system__` among them, each with the
     * sequence number of its last event, in no order: the Archivist's answer to
     * `GET /events`.
     */
    ArchivistStreamsResponse: {
      streams: components['schemas']['ArchivistStream'][];
    };
    /**
     * What an assessing job takes: passages of the resource are marked, each
     * with an assessment the model writes.
     */
    AssessingJobParams: {
      motivation: 'assessing';
      /** What to look for, in the caller's words. Added to the prompt. */
      instructions?: string;
      /** The stance the assessments are written from. */
      tone?: 'analytical' | 'critical' | 'balanced' | 'constructive';
      /** How many annotations to aim for per 2000 words of the resource. */
      density?: number;
      /** The language the annotations' own text is written in. BCP 47. */
      language?: string;
      /** The language of the resource being read. BCP 47. */
      sourceLanguage?: string;
    };
    /**
     * A persisted event as a history reply carries it: the stored event, and
     * the agent its `userId` identifies. The agent is derived when the reply is
     * made — the DID read into a Person or a Software agent, and a Person's
     * name filled in from the knowledge base's profiles — and is stored
     * nowhere. A Person the record does not name carries no `name`.
     */
    AttributedEvent: components['schemas']['StoredEventResponse'] & {
      agent: components['schemas']['Agent'];
    };
    /**
     * Emitted to draw attention to a resource: to one of its annotations, or,
     * with no annotation, to the resource as a whole. The resource is always
     * named. A focus on an annotation scrolls a viewer showing that resource to
     * it, and a viewer showing a different resource ignores it — a deliberate
     * ignore rather than a silent no-op. A focus on the resource as a whole
     * brings that resource forward, opened if it is not open, at its top.
     */
    BeckonFocusEvent: {
      annotationId?: components['schemas']['AnnotationId'];
      /**
       * The resource this focus applies to, always named. With an annotation it
       * is a guard: a viewer showing a different resource ignores the event.
       * With none it is the resource the focus brings forward.
       */
      resourceId: components['schemas']['ResourceId'];
    };
    /** Emitted when an annotation is hovered over for beckoning */
    BeckonHoverEvent: {
      annotationId: components['schemas']['AnnotationId'] | null;
    };
    /** Emitted when a sparkle effect is triggered on an annotation */
    BeckonSparkleEvent: {
      annotationId: components['schemas']['AnnotationId'];
    };
    /**
     * One edit to a linking annotation's body list: add or remove a body item,
     * or replace an existing one.
     */
    BindBodyOperation: {
      /** The type of body operation */
      op: 'add' | 'remove' | 'replace';
      item?: components['schemas']['AnnotationBody'];
      oldItem?: components['schemas']['AnnotationBody'];
      newItem?: components['schemas']['AnnotationBody'];
    };
    /**
     * Void success reply emitted on the bind:body-updated channel after
     * bind:update-body has been applied, matched to the originating command by
     * correlationId.
     */
    BindBodyUpdated: Record<string, never>;
    /**
     * Command payload sent on the bind:initiate bus channel to start a bind
     * flow.
     */
    BindInitiateCommand: {
      /** Branded AnnotationId of the annotation being bound */
      annotationId: components['schemas']['AnnotationId'];
      /** Branded ResourceId of the resource being bound to */
      resourceId: components['schemas']['ResourceId'];
      /** Default title for the bound annotation */
      defaultTitle: string;
      /** Entity types to associate with the annotation */
      entityTypes: string[];
    };
    /**
     * Command payload sent on the bind:update-body bus channel to modify
     * annotation bodies.
     */
    BindUpdateBodyCommand: {
      /**
       * Authenticated user's DID, injected by the /bus/emit gateway. Clients do
       * not set this.
       */
      _userId?: components['schemas']['UserId'];
      /** Branded AnnotationId of the annotation whose body is being updated */
      annotationId: components['schemas']['AnnotationId'];
      /** Branded ResourceId of the resource the annotation belongs to */
      resourceId: components['schemas']['ResourceId'];
      /** Ordered body-list edits to apply. */
      operations: components['schemas']['BindBodyOperation'][];
    };
    /**
     * One change to an annotation's bodies: a body added, a body removed, or
     * one body replaced by another.
     */
    BodyOperation:
      | components['schemas']['BodyOperationAdd']
      | components['schemas']['BodyOperationRemove']
      | components['schemas']['BodyOperationReplace'];
    BodyOperationAdd: {
      op: 'add';
      item: components['schemas']['AnnotationBody'];
    };
    BodyOperationRemove: {
      op: 'remove';
      item: components['schemas']['AnnotationBody'];
    };
    BodyOperationReplace: {
      op: 'replace';
      oldItem: components['schemas']['AnnotationBody'];
      newItem: components['schemas']['AnnotationBody'];
    };
    /**
     * W3C Web Annotation body purpose vocabulary -
     * https://www.w3.org/TR/annotation-vocab/#motivation
     */
    BodyPurpose:
      | 'assessing'
      | 'bookmarking'
      | 'classifying'
      | 'commenting'
      | 'describing'
      | 'editing'
      | 'highlighting'
      | 'identifying'
      | 'linking'
      | 'moderating'
      | 'questioning'
      | 'replying'
      | 'tagging';
    /** Request to browse the history of an annotation */
    BrowseAnnotationHistoryRequest: {
      resourceId: components['schemas']['ResourceId'];
      annotationId: components['schemas']['AnnotationId'];
    };
    /** Result of browsing annotation history */
    BrowseAnnotationHistoryResult: {
      response: components['schemas']['GetAnnotationHistoryResponse'];
    };
    /** Request to browse a single annotation */
    BrowseAnnotationRequest: {
      resourceId: components['schemas']['ResourceId'];
      annotationId: components['schemas']['AnnotationId'];
    };
    /** Result of browsing a single annotation */
    BrowseAnnotationResult: {
      response: components['schemas']['GetAnnotationResponse'];
    };
    /**
     * An annotation was clicked — open it: the viewer selects its entry in the
     * annotations panel and relays a focus signal to scroll to it. The
     * annotation id is the whole address; it identifies exactly one annotation
     * on exactly one resource, so no resource field is carried and none is
     * needed to scope the event. Motivation is NOT on the wire either: the
     * viewer derives it from the annotation the id names, so the wire states
     * the fact once. A viewer that has not loaded that annotation finds nothing
     * and does nothing. Emitted locally by every clickable annotation surface,
     * and over the wire by a driver opening an annotation on another
     * participant's screen.
     */
    BrowseClickEvent: {
      annotationId: components['schemas']['AnnotationId'];
    };
    /**
     * The payload of `browse:directory-failed`: a CommandError that names the
     * directory that could not be read.
     */
    BrowseDirectoryFailed: components['schemas']['CommandError'] & {
      /** The path the read was asked for. */
      path: string;
    };
    /** Request to browse a directory listing */
    BrowseDirectoryRequest: {
      path: string;
      sort?: 'name' | 'mtime' | 'annotationCount';
    };
    /** Result of browsing a directory listing */
    BrowseDirectoryResult: {
      response: components['schemas']['BrowseDirectoryResultResponse'];
    };
    BrowseDirectoryResultResponse: {
      path: string;
      entries: components['schemas']['DirectoryEntry'][];
    };
    /**
     * Request for the knowledge base's engines: those its Inference document
     * names
     */
    BrowseEnginesRequest: Record<string, never>;
    /**
     * The knowledge base's engines: those its Inference document names, and the
     * jobs it has each used for
     */
    BrowseEnginesResult: {
      response: {
        engines: components['schemas']['EngineEntry'][];
      };
    };
    /** Emitted when an entity type is clicked in the browse panel */
    BrowseEntityTypeClickedEvent: {
      entityType: string;
    };
    /** Request to browse available entity types */
    BrowseEntityTypesRequest: Record<string, never>;
    /** Result of browsing entity types */
    BrowseEntityTypesResult: {
      response: components['schemas']['GetEntityTypesResponse'];
    };
    /** Request to browse events for a resource */
    BrowseEventsRequest: {
      resourceId: components['schemas']['ResourceId'];
      type?: string;
      userId?: components['schemas']['UserId'];
      limit?: number;
    };
    /** Result of browsing events for a resource */
    BrowseEventsResult: {
      response: components['schemas']['GetEventsResponse'];
    };
    /** Emitted when navigation to an external URL is requested */
    BrowseExternalNavigateEvent: {
      url: string;
      resourceId?: components['schemas']['ResourceId'];
    };
    BrowseFilesResponse: {
      /** The directory path that was listed, relative to project root */
      path: string;
      entries: components['schemas']['DirectoryEntry'][];
    };
    /** Request for the knowledge base's description of itself */
    BrowseKbRequest: Record<string, never>;
    /** Result of browse:kb-requested */
    BrowseKbResult: {
      response: components['schemas']['KbDescription'];
    };
    /** Emitted when a link is clicked in the browse panel */
    BrowseLinkClickedEvent: {
      href: string;
      label?: string;
    };
    /** Emitted when a browse panel is opened */
    BrowsePanelOpenEvent: {
      panel: string;
      scrollToAnnotationId?: components['schemas']['AnnotationId'];
      motivation?: components['schemas']['Motivation'];
    };
    /** Emitted when a browse panel is toggled */
    BrowsePanelToggleEvent: {
      panel: string;
    };
    /**
     * Request for the profiles of some principals: the DIDs a reply mentions.
     * Bounded by the question: a reader that has more asks in parts.
     */
    BrowseProfilesRequest: {
      /** The principals asked after. */
      dids: components['schemas']['UserId'][];
    };
    /**
     * The profiles of the principals asked after: each that has one, keyed by
     * DID. A DID with no profile is absent, and is named by no one.
     */
    BrowseProfilesResult: {
      response: {
        /** Each profile, keyed by DID. */
        profiles: { [key: string]: components['schemas']['Profile'] };
      };
    };
    /** Emitted when a resource is closed in the browse panel */
    BrowseResourceCloseEvent: {
      resourceId: components['schemas']['ResourceId'];
    };
    /**
     * Domain intent to open a resource in the viewer: emitted locally by in-app
     * link handlers and remotely by the launcher's tour verbs; the viewer
     * translates it to host routing (nav:push), which never crosses the wire.
     * Deliberately not named 'navigate' — that word and the nav:* prefix belong
     * to the host-local framework layer.
     */
    BrowseResourceOpenEvent: {
      resourceId: components['schemas']['ResourceId'];
    };
    /** Emitted when resources are reordered in the browse panel */
    BrowseResourceReorderEvent: {
      oldIndex: number;
      newIndex: number;
    };
    /** Request to browse a single resource */
    BrowseResourceRequest: {
      resourceId: components['schemas']['ResourceId'];
    };
    /**
     * A resource's descriptor, and the sequence number of the last of its
     * events the descriptor reflects. Its annotations are not here: their
     * number follows the document's, so they are read over HTTP (`GET
     * /resources/{id}/annotations`).
     */
    BrowseResourceResult: {
      response: {
        resource: components['schemas']['ResourceDescriptor'];
        /**
         * The sequence number of the resource's last event. A graph read that
         * follows a write waits for the graph projection to reach it.
         */
        lastSequence: number;
      };
    };
    /**
     * REPORT that a resource has loaded in a viewer — emitted on arrival by ANY
     * means: a followed cue, an in-app link, the back button, a typed URL.
     * Deliberately distinct from the imperative browse:resource-open: drive and
     * report never share a channel, or the driver hears its own commands and
     * one viewer's arrival steers another's page.
     */
    BrowseResourceViewedEvent: {
      resourceId: components['schemas']['ResourceId'];
    };
    /** Request to browse resources with optional filtering and pagination */
    BrowseResourcesRequest: {
      archived?: boolean;
      entityType?: string;
      /**
       * How many of the resources the filters admit are passed over before the
       * page begins.
       */
      offset?: number;
      /** The most resources a page has. */
      limit?: number;
    };
    /** Result of browsing resources */
    BrowseResourcesResult: {
      response: components['schemas']['ListResourcesResponse'];
    };
    /** Emitted when the browse panel requests a router navigation */
    BrowseRouterPushEvent: {
      path: string;
      reason?: string;
    };
    /** Request to browse registered tag schemas */
    BrowseTagSchemasRequest: Record<string, never>;
    /** Result of browsing tag schemas */
    BrowseTagSchemasResult: {
      response: components['schemas']['GetTagSchemasResponse'];
    };
    /**
     * Result of publishing one event. `subscribers` is the number of observers
     * attached to the target subject at dispatch — the GLOBAL subject for an
     * unscoped emit, the scoped one when `scope` is set. Zero means the signal
     * reached nobody: /bus/subscribe enforces no channel allowlist and the emit
     * handler publishes unconditionally, so a client can emit a channel no
     * participant subscribes to and otherwise receive a clean 202 with no way
     * to tell. Deliberately NOT named `delivered`: this is the count at
     * dispatch, and a subscriber may still drop the frame downstream, so the
     * field is named after what the server can actually observe.
     */
    BusEmitAccepted: {
      /**
       * Observers on the target subject when the event was dispatched. ABSENT
       * means the gateway could not count: under a broker signal plane (the
       * KnowledgeBase document's `spec.messaging.signal.type: nats`) the event
       * is published to a fabric whose observers the gateway cannot see. The
       * one zero a broker plane states is a registry operation's request with a
       * `correlationId` that reached nobody, which the broker itself reports
       * (no responders). Never defaulted: a zero here is the claim that nobody
       * was listening, and a gateway that did not observe that never makes it.
       */
      subscribers?: number;
    };
    /**
     * One event for the bus. `channel` names a channel of the bus registry
     * (specs/src/bus/registry.json) and `payload` must match the schema the
     * registry's `validate` names for it. `scope` publishes a resource-bound
     * broadcast to that resource's subscribers only; everything else is
     * unscoped. `clientId` and `correlationId` are routing facts beside the
     * payload, never inside it.
     */
    BusEmitRequest: {
      /** A channel of the bus registry. */
      channel: string;
      /**
       * The channel's payload, validated against the schema its registry entry
       * names. `_userId` and `_roles` are the gateway's to write: whatever a
       * caller puts there is replaced.
       */
      payload: { [key: string]: unknown };
      /**
       * The resource scope of a resource-bound broadcast. Publishers of those
       * broadcasts only; a command or request never carries one.
       */
      scope?: components['schemas']['ResourceId'];
      /**
       * The address this request's reply is delivered to: the emit claims
       * `correlationId` for this clientId and the verified principal. Required
       * when `channel` is a registry operation's request and a correlationId is
       * present; ignored otherwise. An empty string counts as absent.
       */
      clientId?: string;
      /**
       * Pairs a reply with its request. On a registry operation's request it
       * claims the id: a second claim of a live id is refused with 409. Replies
       * carry it back on the frame, never in the payload.
       */
      correlationId?: string;
    };
    /**
     * A bus frame on the stream: `event: bus-event`, an `id:` line, and one
     * `data:` line holding the JSON-serialised BusFrame. This schema describes
     * the message with `data` already parsed.
     */
    BusEventMessage: {
      event: 'bus-event';
      id:
        | components['schemas']['PersistedEventId']
        | components['schemas']['ReplyEventId']
        | components['schemas']['EphemeralEventId'];
      data: components['schemas']['BusFrame'];
    };
    /**
     * One frame of the bus stream, as the `data` line of a `bus-event` message
     * carries it (JSON-serialised on one line). `payload` is the channel's
     * payload as its registry entry declares it. A frame on a scoped
     * subscription carries the scope it was published on; a correlated reply
     * carries the `correlationId` of the request it answers.
     */
    BusFrame: {
      /** A channel of the bus registry (specs/src/bus/registry.json). */
      channel: string;
      /**
       * The request this frame answers. Present on correlated replies; absent
       * otherwise.
       */
      correlationId?: string;
      /**
       * The channel's payload. A replayed persisted event is the stored event
       * itself, whose `metadata.sequenceNumber` the message id carries.
       */
      payload: { [key: string]: unknown };
      /**
       * The resource scope the frame was published on. Present exactly when it
       * arrived through a `scoped` entry of the subscription.
       */
      scope?: components['schemas']['ResourceId'];
    };
    /**
     * The heartbeat: `event: ping` with an empty `data:` line. The first is
     * written once the stream has caught up (after any replay), then one every
     * `x-xynolog-limits.heartbeatSeconds`. It carries no id, so it never
     * disturbs a client's last-seen ids.
     */
    BusPingMessage: {
      event: 'ping';
      data: string;
    };
    /**
     * The payload of `bus:resume-gap`: a scope's `lastEventId` could not be
     * honoured, so the client cannot trust that it has every persisted event of
     * that scope and must refetch what it caches for it. Written by the
     * gateway, never by a participant.
     */
    BusResumeGap: {
      /** The scope of the subscription entry whose watermark failed. */
      scope: components['schemas']['ResourceId'];
      /** The watermark the entry carried. */
      lastSeenId: string;
      /**
       * `unparseable-last-event-id`: the watermark is not a PersistedEventId.
       * `scope-mismatch`: it names another scope. `retention-exceeded`: the
       * record no longer holds the events after it (what it still holds is
       * replayed first). `query-error`: the record could not be read.
       */
      reason:
        | 'unparseable-last-event-id'
        | 'scope-mismatch'
        | 'retention-exceeded'
        | 'query-error';
    };
    /**
     * Every message the bus stream carries. A client ignores an `event` it does
     * not know; the gateway writes no other.
     */
    BusStreamMessage:
      | components['schemas']['BusEventMessage']
      | components['schemas']['BusPingMessage'];
    /**
     * Subscription matrix for the bus stream. `global` channels are delivered
     * unscoped; each `scoped` entry subscribes the connection to one resource
     * scope's channels, optionally resuming from that scope's last-seen
     * persisted event id. At least one global channel or one scoped entry is
     * required, and no scope may appear in two entries.
     */
    BusSubscribeRequest: {
      /** Unscoped channels to subscribe to. */
      global?: string[];
      /**
       * Correlation ids of requests this client still awaits a reply to. The
       * gateway writes every reply it still retains for them (for
       * `x-xynolog-limits.replyRetentionSeconds` after it was published) as an
       * ordinary frame with its ReplyEventId, so a reply that also arrived live
       * dedups client-side. A client can have no more pending than it may have
       * unanswered requests, so this bound is also the number of unanswered
       * requests `POST /bus/emit` allows a client.
       */
      pendingReplies?: string[];
      /**
       * Per-resource-scope subscriptions, at most 512 on one connection. Scopes
       * must be unique across entries.
       */
      scoped?: {
        /** Resource scope (a resourceId). */
        scope: components['schemas']['ResourceId'];
        /** Channels to subscribe within this scope. */
        channels: string[];
        /**
         * This scope's last-seen PersistedEventId. The gateway replays this
         * scope's persisted events after it — those on the entry's channels —
         * before the live tail, and writes a scoped `bus:resume-gap`
         * (BusResumeGap) when it cannot cover the gap.
         */
        lastEventId?: string;
      }[];
      /**
       * Routing address for correlated replies: a UUID minted once per
       * bus-client lifetime — per actor, not per connection, so it survives a
       * reconnect and two overlapping connections share it. A correlated reply
       * is delivered to a connection only when its request was emitted under
       * the same clientId by the same principal. Not authentication — the
       * bearer token stays that — and never echoed into any payload or
       * broadcast frame.
       */
      clientId: string;
    };
    CloneResourceWithTokenResponse: {
      /** Generated clone token */
      token: string;
      /** ISO 8601 timestamp when token expires */
      expiresAt: string;
      resource: components['schemas']['ResourceDescriptor'];
    };
    /**
     * Error response for failed bus commands. Replaces native Error objects on
     * the EventBus so payloads are serializable and OpenAPI-typed.
     */
    CommandError: {
      /**
       * Machine-readable failure class, for consumers that must BRANCH on why a
       * command failed rather than log it. Optional and deliberately sparse:
       * absent means 'no class declared', and every existing failure stays that
       * way. An enum rather than a free string so the vocabulary has an owner —
       * an unconstrained code is a mirror with no gate, and adding one should
       * be a deliberate spec change. `message` remains the human-readable text
       * and is unaffected. Members: `peer-unavailable` — the channel this
       * command was sent on has no subscriber, i.e. the service that answers it
       * has not connected yet. Transient by nature (a peer still starting),
       * which is what distinguishes it from a refusal: retrying is the correct
       * response. `not-found` — the resource this command addressed does not
       * exist in this knowledge base. A verdict, not a symptom: it is emitted
       * only where the answer comes from the event store, which is the system
       * of record, and never from a projection that may merely be lagging.
       * Deterministic, so unlike `peer-unavailable` retrying is pointless — and
       * consumers may act destructively on it (the SDK deletes a restored tab).
       * Absence is not denial: a future 'exists, but not for you' must travel
       * as its own code, never as this one. `unauthorized` — that code: the
       * caller is authenticated but not permitted to do what it asked. A
       * verdict about the CALLER, not the resource, so retrying under the same
       * credential cannot succeed and a consumer must never spin on it; emitted
       * by `job:claim` for a caller whose token carries no worker role.
       * `none-pending` — a declined claim, not an error: the queue holds no
       * pending job of the requested types. Nothing went wrong; the one code a
       * consumer PARKS on, meaning 'nothing to do until a wake-up'. Emitted by
       * `job:claim` only. A `job:claim` refusal carrying neither is
       * unclassified — a malformed record or a missing injection — and a
       * consumer treats it as 'log it, assume nothing'.
       */
      code?: 'peer-unavailable' | 'not-found' | 'unauthorized' | 'none-pending';
      /** Human-readable error message */
      message: string;
      /** Optional additional context (stack trace, field name, etc.) */
      details?: string;
    };
    /**
     * What a commenting job takes: passages of the resource are marked, each
     * with a comment the model writes.
     */
    CommentingJobParams: {
      motivation: 'commenting';
      /** What to look for, in the caller's words. Added to the prompt. */
      instructions?: string;
      /** The voice the comments are written in. */
      tone?: 'scholarly' | 'explanatory' | 'conversational' | 'technical';
      /** How many annotations to aim for per 2000 words of the resource. */
      density?: number;
      /** The language the annotations' own text is written in. BCP 47. */
      language?: string;
      /** The language of the resource being read. BCP 47. */
      sourceLanguage?: string;
    };
    /**
     * Content format as a MIME type, optionally with parameters. The base type
     * (everything before the first ';') MUST be a SupportedMediaType;
     * parameters such as charset are preserved as metadata. Semantic validation
     * happens in code at the create/yield boundary — there is deliberately no
     * pattern here, the vocabulary lives in SupportedMediaType. Examples:
     * text/plain, text/plain; charset=iso-8859-1, text/markdown;
     * charset=windows-1252, image/png, application/pdf
     */
    ContentFormat: string;
    ContextualSummaryResponse: {
      summary: string;
      /**
       * What the summary is of: the resource the annotation is on, and the
       * annotation's entity types.
       */
      relevantFields: {
        resourceId: components['schemas']['ResourceId'];
        resourceName: string;
        entityTypes: string[];
      };
      context: {
        before?: string;
        selected: string;
        after?: string;
      };
    };
    CreateAnnotationRequest: {
      motivation: components['schemas']['Motivation'];
      target: components['schemas']['AnnotationTarget'];
      /**
       * Optional body. Omit for annotations whose motivation alone is
       * meaningful (highlighting) or whose user-supplied content is empty.
       * Shape matches Annotation.body.
       */
      body?: components['schemas']['AnnotationBodies'];
    };
    /**
     * The id of the resource an upload created. The Archivist answers it (200)
     * once it has stored the bytes and recorded the resource, and the gateway
     * forwards it (202), so the id is the one the record minted and its
     * creation event is persisted. What remains asynchronous is downstream
     * projection: graph, views and vectors settle afterwards.
     */
    CreateResourceResponse: {
      /** The id of the newly created resource, as the record minted it. */
      resourceId: components['schemas']['ResourceId'];
    };
    /**
     * The file a follower of the record keeps its cursors in: for each log of
     * the record it follows, the sequence number of the last event of it taken
     * (contract/TRANSPORT-CONTRACT.md § What repairs a passing frame). A file
     * of the service's own disk, never of the knowledge base: a service that
     * finds none starts each log as it starts one with no cursor, so losing it
     * costs time and never correctness.
     */
    CursorsPath: string;
    DirEntry: {
      type: 'dir';
      /** Entry name (basename) */
      name: string;
      /** Path relative to project root */
      path: string;
      /** Last modified time (ISO 8601) */
      mtime: string;
    };
    /**
     * One entry in a directory listing: a file, which may carry the resource it
     * was ingested as, or a subdirectory. Tell them apart by `type`, which is
     * required on both and single-valued.
     */
    DirectoryEntry:
      components['schemas']['FileEntry'] | components['schemas']['DirEntry'];
    /**
     * One knowledge base the Xynolog launcher manages on this machine, as
     * published in the discovery document (see DiscoveryDocument). Endpoints
     * and identity only — never credentials; login remains the consumer's
     * per-KB business.
     */
    DiscoveredKB: {
      /**
       * Hostname the KB is reachable on from this machine (always "localhost" —
       * local stacks bind locally and codespace KBs arrive through a local port
       * forward)
       */
      host: string;
      /**
       * Local TCP port of the KB's API (the gateway port for a local stack; the
       * allocated forward port for a codespace stack)
       */
      port: number;
      /**
       * Where the stack actually runs. "local": containers on this machine.
       * "codespace": a GitHub-hosted VM whose KB is port-forwarded here.
       */
      placement: 'local' | 'codespace';
      /**
       * owner/name GitHub slug — present for codespace placements, where the
       * repo is the stack's identity
       */
      repo?: string;
      /**
       * The KB's did:web identifier, from its committed .xynolog/config.yaml —
       * "did:web:" + its site.domain, verbatim. REQUIRED: a KB that declares no
       * domain has no identity to publish, and the launcher refuses to start it
       * rather than inventing or defaulting one. NOT unique within a document:
       * a did names the knowledge base, not a running copy of it, so a local
       * clone and a codespace of the same repo legitimately share one and both
       * are published. host:port is the unique field (at most one entry per
       * address), so consumers look up by ADDRESS and use the did to VERIFY
       * that the copy they reached is the KB they meant — an address alone
       * cannot say which KB is which, and an identity alone cannot say which
       * copy.
       */
      did: string;
      /**
       * Human-readable site name from the KB's .xynolog/config.yaml
       * (site.siteName), for display
       */
      siteName?: string;
      /**
       * The agent that owns this entry's lifecycle (the launcher writes
       * "xynolog-launcher"). Consumers treat managed entries as authoritative
       * for themselves — upsert on appearance, remove on disappearance — and
       * never touch entries they did not write.
       */
      managedBy: string;
    };
    /**
     * The launcher's KB discovery document — the schema authority for
     * <stateDir>/discovery/kbs.json, which the Xynolog CLI (xynolog/cli)
     * regenerates on every stack mutation and the Browser container mounts
     * read-only at /discovery. NOT an API endpoint: a static document fetched
     * same-origin by browsers (via the Browser's static server). An empty kbs
     * list is meaningful ("the launcher manages nothing right now") and
     * distinct from an absent file.
     */
    DiscoveryDocument: {
      /**
       * Document schema version. Consumers MUST check it and ignore documents
       * they do not understand.
       */
      version: 1;
      /** Every KB the launcher currently manages, local and forwarded */
      kbs: components['schemas']['DiscoveredKB'][];
    };
    /**
     * Everything the dispatcher reads at boot: nothing in it is defaulted by
     * the dispatcher. The launcher writes it for the dispatcher it starts, from
     * the knowledge base's stack documents, and the dispatcher reads it from
     * the path its `--config` flag names (its image passes
     * `/etc/xynolog/dispatcher.json`). Started without `--config`, or with a
     * path that names no file, the dispatcher refuses to start and says which.
     * Secrets are never values here: a field that needs one names the
     * environment variable holding it. The dispatcher's other inputs are the
     * environment variables specs/src/service-environment/variables.json lists
     * for it, and the ones this document names. A document that does not
     * validate is refused at boot, naming each failing field.
     */
    DispatcherConfig: {
      kb: components['schemas']['KbIdentity'];
      /**
       * The URL the dispatcher reaches the gateway at: its only route to the
       * bus.
       */
      gatewayUrl: string;
      /** The issuer the dispatcher's service account signs in at. */
      identity: components['schemas']['ServiceIdentity'];
      /**
       * The JetStream broker holding the job queue, whose layout is
       * specs/src/jobs/storage.json.
       */
      queue: {
        /** The broker's address (`host:port`, or several, comma-separated). */
        servers: string;
        /**
         * The environment variable holding the broker user, when the broker
         * requires one.
         */
        userEnv?: string;
        /**
         * The environment variable holding the broker password, when the broker
         * requires one.
         */
        passwordEnv?: string;
      };
      /** The port the dispatcher answers `/health` on. */
      port: number;
      /**
       * The queue's clocks, in milliseconds. The launcher writes the values a
       * deployment runs with; a test harness shrinks them.
       */
      timing: {
        /**
         * How often the queue re-announces pending jobs and sweeps for dead
         * workers. The re-announcement is insurance against a lost wake-up, not
         * dispatch.
         */
        tickMs: number;
        /**
         * How long a running job may go without progress, a checkpoint or a
         * claim before its worker is presumed dead.
         */
        staleRunningMs: number;
        /**
         * How long the broker waits, after this dispatcher stops renewing a
         * job's lease, before redelivering its message.
         */
        ackWaitMs: number;
        /** How long a concluded job is kept before it is deleted. */
        retentionMs: number;
        /** How often concluded jobs past `retentionMs` are deleted. */
        retentionSweepMs: number;
        /**
         * The least time between two progress writes for one job; reports
         * closer together than this are not written.
         */
        progressWriteIntervalMs: number;
        /**
         * How long the dispatcher waits at boot for the broker before it exits,
         * so that a restart policy can retry.
         */
        bootDeadlineMs: number;
      };
      logLevel: components['schemas']['LogLevel'];
      logFormat: components['schemas']['LogFormat'];
    };
    /**
     * The dispatcher's liveness answer. It answers only once its queue has
     * connected and its bus pumps are attached, so a 200 means it can take
     * work.
     */
    DispatcherHealth: {
      status: 'ok';
      /** The queue it holds. */
      queue: 'jetstream';
    };
    /**
     * How a job's annotations were established as durable — the OBSERVATION,
     * never a conclusion drawn from it. 'acknowledged': the event log confirmed
     * the batch (mark:commit-ok). 'probe-confirmed': the acknowledgement was
     * lost and a later read found the batch's last annotation present — true,
     * but a weaker claim than an ack, since it rests on the log appending a
     * batch in order and stopping at the first failure. 'probe-refused': the
     * read returned a failure reply; note this does NOT assert the annotations
     * are absent, because a read that failed for its own reasons answers on the
     * same channel. 'probe-unreachable': no answer came at all, so nothing was
     * established either way. ABSENT means the question never arose — a job
     * that committed no annotations. Never defaulted: a manufactured value here
     * is a claim nobody made, in a log nobody can rewrite.
     */
    DurabilityEvidence:
      | 'acknowledged'
      | 'probe-confirmed'
      | 'probe-refused'
      | 'probe-unreachable';
    /**
     * The embedding provider a service asks for vectors, and what that kind of
     * provider needs to be asked: one of the providers `xynolog-vectors` has,
     * told apart by `type`. Two services that share an index name the same
     * provider and the same model: a vector is compared only with vectors of
     * the model that made it. A secret is never a value here: a provider's key
     * is named by the environment variable that holds it.
     */
    EmbeddingConfig:
      | components['schemas']['OllamaEmbeddingConfig']
      | components['schemas']['VoyageEmbeddingConfig'];
    /**
     * An engine: an inference provider and a model, which software does a job
     * or an actor's step with. An engine is not a principal: the principal that
     * used one names it on each write it produced with it (`generator`). A
     * person who does a job uses none.
     */
    Engine: {
      /**
       * The inference provider: who serves the model. `anthropic`, `google`,
       * `openai` and `together` are those companies' own APIs. `llamacpp`,
       * `ollama` and `vllm` are servers a deployment runs or reaches, each
       * named for the server's software.
       */
      provider:
        | 'anthropic'
        | 'google'
        | 'llamacpp'
        | 'ollama'
        | 'openai'
        | 'together'
        | 'vllm';
      /** The model identifier, as the provider names it. */
      model: string;
    };
    /**
     * One of the knowledge base's engines: a provider and a model its Inference
     * document names, and the jobs the document has it used for. An engine is
     * not a principal: whichever worker claims a job does it, under its own
     * account, and names on each write the engine it used, if any. Carries no
     * inference limits: the services that hold the inference credentials report
     * those (InferenceLimitsResult).
     */
    EngineEntry: {
      engine: components['schemas']['Engine'];
      /**
       * The jobs the knowledge base's Inference document has this engine used
       * for, as a claim names them. Absent for an engine only Librarian actors
       * ask.
       */
      jobs?: components['schemas']['JobFilter'][];
    };
    /** The discovered limits of one engine. */
    EngineLimits: {
      engine: components['schemas']['Engine'];
      limits: components['schemas']['InferenceLimits'];
    };
    /**
     * Wire format for persisted events delivered over the bus SSE stream (GET
     * /bus/subscribe). Extends StoredEventResponse with optional enrichment
     * fields the EventStore populates from the materialized view at publish
     * time (persistence → view → enrich → notification). Subscribers read the
     * enrichment fields directly to update local caches without an additional
     * fetch.
     */
    EnrichedResourceEvent: components['schemas']['StoredEventResponse'] & {
      /**
       * Populated for events that mutate an annotation (mark:added,
       * mark:body-updated, mark:removed). Carries the post-materialization
       * annotation as it exists in the view, so subscribers can update local
       * caches in-place without refetching. Absent for events that don't touch
       * annotations.
       */
      annotation?: components['schemas']['Annotation'];
    };
    /**
     * Payload for mark:entity-tag-added and mark:entity-tag-removed domain
     * events
     */
    EntityTagChangedPayload: {
      entityType: string;
    };
    /**
     * Payload for frame:entity-type-added domain event (system-level, no
     * resourceId — fan-out is global)
     */
    EntityTypeAddedPayload: {
      entityType: string;
    };
    /**
     * The knowledge base's entity-type vocabulary: the file
     * `projections/__system__/entitytypes.json` under the state directory, the
     * sum of the `frame:entity-type-added` events. Written as JSON indented by
     * two spaces.
     */
    EntityTypesProjection: {
      /** Every entity type added, each once, sorted. */
      entityTypes: string[];
    };
    /**
     * `e-<publishId>` — the id of any other frame, given once when the frame is
     * published: the same on every connection that carries it, through every
     * replica, so a copy arriving on two connections (a reconnect overlap)
     * dedups. Never a resumption watermark.
     */
    EphemeralEventId: string;
    /**
     * The body of every error the gateway answers, whatever the status and
     * whatever the route — including a path it does not serve.
     */
    ErrorResponse: {
      /** What went wrong, in a sentence. */
      error: string;
      /** A machine-readable class, when the route defines one. */
      code?: string;
      /** What the caller can do about it, when there is something to say. */
      hint?: string;
      details?: unknown;
    };
    /**
     * Metadata added at persistence time. Part of every StoredEvent. Integrity
     * is provided by git at the commit level (when gitSync is enabled), not by
     * in-event metadata fields.
     */
    EventMetadata: {
      /** Monotonic position in the event log (ordering authority) */
      sequenceNumber: number;
    };
    /**
     * A successful extraction: the anchored text plus its provenance. The
     * 'extracted' member of ExtractionOutcome, the record the anchored-text
     * store holds.
     */
    ExtractedText: components['schemas']['AnchoredText'] & {
      /**
       * Discriminant — both ExtractionOutcome members carry `kind`,
       * single-valued: the category here, the detail in `method`.
       */
      kind: 'extracted';
      /** How the text was extracted. */
      method: components['schemas']['ExtractionMethod'];
      /** PDF classification, when the source was a PDF. */
      pdfClass?: components['schemas']['PdfClass'];
      /**
       * How well the engine read the pixels, when any of this text came from
       * OCR.
       */
      ocrConfidence?: components['schemas']['OcrConfidence'];
      /**
       * 1-indexed pages this extraction could not read — present only for
       * partially covered documents (class C).
       */
      unreadPages?: number[];
    };
    /**
     * A named decline: extraction ran and yielded nothing, by class. A
     * first-class, cacheable outcome — 'we ran and there was nothing' costs a
     * full recognition pass to discover.
     */
    ExtractionDeclined: {
      /**
       * Discriminant — both ExtractionOutcome members carry `kind`,
       * single-valued: the category here, the detail in `declined`.
       */
      kind: 'declined';
      /** Why extraction yielded nothing, by class. */
      declined: components['schemas']['ExtractionDeclinedReason'];
    };
    /** Why extraction yielded nothing, by class. */
    ExtractionDeclinedReason:
      'no-text-layer' | 'encrypted' | 'corrupt' | 'too-large';
    /**
     * How a text was extracted: a plain text taken as it is, a PDF's text layer
     * read, a grid written as rows, a filled form's values read, or pixels read
     * by OCR.
     */
    ExtractionMethod:
      'text-passthrough' | 'pdf-text-layer' | 'table' | 'form' | 'ocr';
    /**
     * The full outcome of text extraction for one representation — the record
     * the anchored-text store holds and the wire serves. Discriminated on
     * `kind`: 'extracted' — the anchored text with its provenance; 'declined' —
     * a named decline. ocrConfidence is extraction quality for operators,
     * deliberately not anchor confidence.
     */
    ExtractionOutcome:
      | components['schemas']['ExtractedText']
      | components['schemas']['ExtractionDeclined'];
    /**
     * The class of a job's failure, stated by the worker, where the failure is
     * still typed: at the gateway it is already text, and classing a failure by
     * its text is what this exists to avoid. A job no worker concluded, because
     * its worker stopped reporting, is classed by the dispatcher, as
     * 'transient'. Each value is a claim. 'transient': nothing about the
     * request was judged (the worker's own bound ran out, the provider said not
     * now), so another attempt may succeed. 'deterministic': the same request
     * cannot succeed on a second attempt. 'withheld': the model's provider had
     * the request and withheld its answer, by a refusal or a content filter,
     * and the same request is withheld again; nothing broke. A 'deterministic'
     * or a 'withheld' failure is not retried, whatever retry budget is left.
     * ABSENT means the failure was not classified, which is not the claim
     * 'transient' makes; it is retried as a transient one is. Only a failure
     * known to be deterministic or withheld is called so: calling a transient
     * failure either one halves reliability, where the reverse costs one wasted
     * attempt.
     */
    FailureClass: 'transient' | 'deterministic' | 'withheld';
    FileEntry: {
      type: 'file';
      /** Entry name (basename) */
      name: string;
      /** Path relative to project root */
      path: string;
      /** File size in bytes */
      size: number;
      /** Last modified time (ISO 8601) */
      mtime: string;
      /** True if this file is a tracked resource in the Knowledge Base */
      tracked: boolean;
      /** Resource ID (only when tracked is true) */
      resourceId?: components['schemas']['ResourceId'];
      /** Entity types assigned to this resource (only when tracked is true) */
      entityTypes?: string[];
      /** Number of annotations on this resource (only when tracked is true) */
      annotationCount?: number;
      /**
       * DID of the resource's creator — the first of its derived
       * `wasAttributedTo`, the requester as the knowledge base recorded it
       * (only when tracked is true)
       */
      creator?: string;
    };
    /**
     * W3C Web Annotation FragmentSelector for media fragment identifiers (RFC
     * 3778 for PDFs)
     */
    FragmentSelector: {
      type: 'FragmentSelector';
      /**
       * Media fragment identifier (e.g., 'page=1&viewrect=100,200,50,30' for
       * PDF)
       */
      value: string;
      /** URI identifying the fragment syntax specification */
      conformsTo?: string;
    };
    /**
     * Bus command to add a new entity type to the KB's vocabulary. Carried on
     * the `frame:add-entity-type` channel — Frame is the schema-layer flow that
     * owns vocabulary writes.
     */
    FrameAddEntityTypeCommand: {
      tag: string;
      /**
       * Authenticated user's DID, injected by the /bus/emit gateway. Clients do
       * not set this.
       */
      _userId?: components['schemas']['UserId'];
    };
    /**
     * Bus command to register a tag schema with the KB's runtime registry.
     * Carried on the `frame:add-tag-schema` channel — Frame is the schema-layer
     * flow that owns vocabulary writes. Most-recent registration of a given
     * `schema.id` wins; the projection reflects the latest content. Identical
     * re-registrations are silent; differing content overwrites and logs a
     * warning.
     */
    FrameAddTagSchemaCommand: {
      schema: components['schemas']['TagSchema'];
      /**
       * Authenticated user's DID, injected by the /bus/emit gateway. Clients do
       * not set this.
       */
      _userId?: components['schemas']['UserId'];
    };
    /**
     * Everything the gateway reads at boot: nothing in it is defaulted by the
     * gateway. The launcher writes it for the gateway it starts — from the
     * knowledge base's committed identity and its stack documents — and a
     * gateway started any other way is given the same document at the path its
     * `--config` flag names (the image passes `/etc/xynolog/gateway.json`).
     * Started without `--config`, or with a path that names no file, the
     * gateway refuses to start and says which. Secrets are never values here: a
     * field that needs one names the environment variable holding it. The
     * gateway's other inputs are the environment variables
     * specs/src/service-environment/variables.json lists for it, and the ones
     * this document names. A document that does not validate is refused at boot
     * — the gateway exits without serving — and the refusal names each failing
     * field by its JSON pointer.
     */
    GatewayConfig: {
      kb: components['schemas']['KbIdentity'];
      /**
       * The port the gateway listens on, on every address the host has: IPv4
       * and IPv6.
       */
      port: number;
      /**
       * The URL clients reach this gateway at: the `servers` entry of the
       * OpenAPI document it serves.
       */
      publicUrl: string;
      /** The issuer this knowledge base trusts. */
      identity: {
        /** The issuer URL, exactly as tokens carry it in `iss`. */
        issuer: string;
        /**
         * The claim a person's DID is built from: `did:web:<domain>:users:<its
         * value>`.
         */
        subjectClaim: string;
      };
      /** Where the Archivist listens. */
      archivist: components['schemas']['ServiceAddress'];
      /**
       * The signal plane: `in-process`, one gateway on its own fabric; or
       * `nats`, the fabric every replica on one broker shares, which requires
       * `servers` and a broker with JetStream.
       */
      signal: {
        type: 'in-process' | 'nats';
        /**
         * The broker's address (`host:port`, or several, comma-separated).
         * Required for `nats`.
         */
        servers?: string;
        /**
         * The environment variable holding the broker user, when the broker
         * requires one.
         */
        userEnv?: string;
        /**
         * The environment variable holding the broker password, when the broker
         * requires one.
         */
        passwordEnv?: string;
      };
      logLevel: components['schemas']['LogLevel'];
      logFormat: components['schemas']['LogFormat'];
      /**
       * What this gateway process can hold, from the memory its deployment
       * gives it. `queuedBytes`: the bytes queued for all its streams together;
       * at it, a new stream is refused with 503 (`AtCapacity`, code `capacity`)
       * until the queues drain — each stream's own bound is
       * `x-xynolog-limits.pendingWriteBytes`. `connections`: the connections it
       * holds open at once; one past it is closed unanswered. The launcher
       * derives both from the memory it gives the gateway's container.
       */
      capacity: {
        queuedBytes: number;
        connections: number;
      };
    };
    /**
     * Completion payload emitted on the gather:annotation-complete bus channel
     * when annotation context gathering finishes.
     */
    GatherAnnotationComplete: {
      /** Branded AnnotationId of the annotation whose context was gathered */
      annotationId: components['schemas']['AnnotationId'];
      /**
       * The gathered annotation context (unified GatheredContext,
       * focus.kind:'annotation')
       */
      response: components['schemas']['GatheredContext'];
    };
    /**
     * Optional configuration for an annotation-focus gather, which windows text
     * around a mark. Distinct from the resource-focus options (depth /
     * maxResources / includeContent / includeSummary), which traverse the
     * resource graph.
     */
    GatherAnnotationOptions: {
      /** Whether to include source context in the gathered result */
      includeSourceContext?: boolean;
      /** Whether to include target context in the gathered result */
      includeTargetContext?: boolean;
      /**
       * How much of the text on each side of the annotation to include, counted
       * in Unicode code points
       */
      contextWindow?: number;
    };
    /**
     * Request payload sent on the gather:requested bus channel to gather
     * context for an annotation.
     */
    GatherAnnotationRequest: {
      /** Branded AnnotationId of the annotation to gather context for */
      annotationId: components['schemas']['AnnotationId'];
      /** Branded ResourceId of the resource the annotation belongs to */
      resourceId: components['schemas']['ResourceId'];
      options?: components['schemas']['GatherAnnotationOptions'];
    };
    /**
     * The payload of `gather:failed`: a CommandError that names the annotation
     * whose context could not be gathered.
     */
    GatherFailed: components['schemas']['CommandError'] & {
      /** The annotation the gather was asked for. */
      annotationId: components['schemas']['AnnotationId'];
    };
    /**
     * Request for the annotations elsewhere that refer to a resource. The
     * Librarian answers from the graph.
     */
    GatherReferencedByRequest: {
      resourceId: components['schemas']['ResourceId'];
      /**
       * The one motivation the annotations answered have. Every annotation that
       * refers to the resource is answered where none is stated.
       */
      motivation?: components['schemas']['Motivation'];
    };
    /** The annotations elsewhere that refer to a resource */
    GatherReferencedByResult: {
      response: components['schemas']['GetReferencedByResponse'];
    };
    /**
     * Completion payload emitted on the gather:resource-complete bus channel
     * when resource context gathering finishes.
     */
    GatherResourceComplete: {
      /** Branded ResourceId of the resource whose context was gathered */
      resourceId: components['schemas']['ResourceId'];
      /**
       * The gathered resource context (unified GatheredContext,
       * focus.kind:'resource')
       */
      response: components['schemas']['GatheredContext'];
    };
    /**
     * The payload of `gather:resource-failed`: a CommandError that names the
     * resource whose context could not be gathered.
     */
    GatherResourceFailed: components['schemas']['CommandError'] & {
      /** The resource the gather was asked for. */
      resourceId: components['schemas']['ResourceId'];
    };
    /**
     * Request payload sent on the gather:resource-requested bus channel to
     * gather context for a resource.
     */
    GatherResourceRequest: {
      /** Branded ResourceId of the resource to gather context for */
      resourceId: components['schemas']['ResourceId'];
      options: components['schemas']['GatherResourceRequestOptions'];
    };
    /** Gathering configuration */
    GatherResourceRequestOptions: {
      /**
       * How many links out from the resource the knowledge graph reaches,
       * nearest first: 1 is what the resource links to and what cites it, and
       * each further link out adds what those link to and what cites them
       */
      depth: number;
      /** Maximum number of related resources to include */
      maxResources: number;
      /** Whether to include resource content in the gathered result */
      includeContent: boolean;
      /** Whether to include resource summaries in the gathered result */
      includeSummary: boolean;
      /**
       * Entity types to exclude from the semantic recall built into this
       * context (caller-supplied; e.g. a chat consumer passes ['Question'] so
       * prior questions never ground answer generation). Optional; default
       * none.
       */
      excludeEntityTypes?: string[];
    };
    /** Request to generate an AI summary of an annotation */
    GatherSummaryRequest: {
      annotationId: components['schemas']['AnnotationId'];
      resourceId: components['schemas']['ResourceId'];
    };
    /**
     * Context gathered for a gather.* call — consumed by yield.* (generation)
     * and the matcher. A shared base (graph, semanticContext, metadata,
     * inferredRelationshipSummary) plus a discriminated `focus` that names the
     * anchor: an annotation or a whole resource.
     */
    GatheredContext: {
      /** The gather anchor. Discriminated on `kind`. */
      focus:
        | {
            kind: 'annotation';
            /** The annotation this context was gathered for */
            annotation: components['schemas']['Annotation'];
            /** The resource containing the annotation */
            sourceResource: components['schemas']['ResourceDescriptor'];
            /** Text context around the annotation target */
            selected?: {
              /** Text appearing before the selected passage */
              before?: string;
              /** The selected text passage (the annotation target) */
              text: string;
              /** Text appearing after the selected passage */
              after?: string;
            };
            /**
             * User-provided hint to supplement or replace the selected text for
             * search and generation
             */
            userHint?: string;
            /**
             * The resource the annotation links to, if it is a resolved reference.
             * Dormant capability — produced/exposed but not yet consumed.
             */
            targetResource?: components['schemas']['ResourceDescriptor'];
            /**
             * Context about the annotation's link target. Dormant —
             * produced/exposed but not yet consumed.
             */
            targetContext?: {
              content: string;
              summary?: string;
            };
          }
        | {
            kind: 'resource';
            /** The resource this context was gathered for */
            resource: components['schemas']['ResourceDescriptor'];
            summary?: string;
            suggestedReferences?: string[];
            /** Resource content (included when requested) */
            content?: {
              /** Content of the focal resource */
              main?: string;
              /** Map of related resource IDs to their content */
              related?: { [key: string]: string };
            };
          };
      /**
       * Knowledge graph backbone — resources AND annotations as typed nodes.
       * The flattened views (connections, citedBy, siblings) are derived from
       * this.
       */
      graph: components['schemas']['KnowledgeGraph'];
      /**
       * Semantically similar passages from across the knowledge base, found via
       * vector search
       */
      semanticContext?: {
        /** Passages ranked by cosine similarity to the focal text */
        similar: components['schemas']['SemanticMatch'][];
        /**
         * Entity types excluded from this recall — a record of how `similar`
         * was filtered (e.g. ['Question'] so answer-generation never surfaces
         * prior questions). Absent when no exclusion was applied.
         */
        excludedEntityTypes?: string[];
      };
      /** Context metadata about the focal anchor and its source */
      metadata: {
        /** Type of source resource (e.g., 'document', 'image', 'video') */
        resourceType?: string;
        /** BCP 47 language tag of source content */
        language?: string;
        /** Entity types associated with the focal anchor */
        entityTypes?: string[];
        /**
         * Global frequency counts for entity types (for IDF-like weighting). A
         * KB-wide statistic, not a neighborhood property — kept here rather
         * than on the graph.
         */
        entityTypeFrequencies?: { [key: string]: number };
      };
      /**
       * LLM-generated summary of the focal anchor's relationships in the
       * knowledge graph
       */
      inferredRelationshipSummary?: string;
    };
    /**
     * The parameters of a `yield` job: what it is asked to make
     * (GenerationJobRequest) and the gathered context it is made from. The
     * job's resource is derived from `context.focus` by the dispatcher
     * (resource focus → focus.resource; annotation focus →
     * focus.sourceResource, with the worker binding to focus.annotation), and
     * the dispatcher refuses a parameter this schema does not name.
     */
    GenerationJobParams: components['schemas']['GenerationJobRequest'] & {
      /**
       * The gathered context that grounds the generation. Its `focus` names the
       * anchor: the DISPATCHER derives the job's resourceId from it (resource
       * focus → focus.resource; annotation focus → focus.sourceResource, with
       * the worker auto-binding to focus.annotation) and REJECTS a
       * caller-supplied id — the context is authoritative. Under `cite`, the
       * ids its embedding carries are the only valid citation targets.
       */
      context: components['schemas']['GatheredContext'];
    };
    /**
     * What a `yield` job is asked to make: every parameter of
     * GenerationJobParams but its `context`, the input the resource is made
     * from. It is what an announcement of the job carries.
     */
    GenerationJobRequest: {
      /**
       * Title of the generated resource. Not empty: the gateway refuses a
       * `job:create` whose title is.
       */
      title: string;
      /**
       * Storage URI for the generated resource's content — AUTHORITATIVE: the
       * worker writes exactly here and never derives a location from the title.
       * Not empty, and there is no fallback: the gateway refuses a `job:create`
       * whose storageUri is.
       */
      storageUri: string;
      /**
       * Refining instruction, composed with `task` (task = what, prompt = how).
       */
      prompt?: string;
      /**
       * Entity-type tags to stamp on the synthesized resource. Used both as a
       * prompt bias for the generation worker and as the `entityTypes` set on
       * the resulting resource.
       */
      entityTypes?: string[];
      /**
       * Annotation/resource body locale — language the generated resource is
       * written in (typically the user's UI locale). BCP-47.
       */
      language?: string;
      /**
       * Source-resource locale — language of the resource being referenced,
       * used in the prompt so the LLM understands embedded source-context
       * snippets when source ≠ target language. BCP-47.
       */
      sourceLanguage?: string;
      /** Sampling temperature forwarded to the model. */
      temperature?: number;
      /**
       * Output token budget forwarded to the model. Length never determines
       * structure.
       */
      maxTokens?: number;
      /**
       * Requested media type of the generated resource's content. Default
       * `text/markdown` at the worker, which validates it against its supported
       * output set and FAILS the job for anything it can't write — not a silent
       * fallback.
       */
      outputMediaType?: components['schemas']['SupportedMediaType'];
      /**
       * What the model is asked to produce — the prompt's framing verb.
       * Canonical values ('resource', 'answer', 'summary') map to the worker's
       * tested framings; any other string is used VERBATIM as the framing
       * instruction (loud degrade: the worker warns, never silently falls
       * back). Unset ⇒ 'resource' (article framing).
       */
      task?: string;
      /**
       * How the output is internally segmented — shape for text-bearing media,
       * subordinate to `outputMediaType` (never its peer). Canonical values:
       * 'prose' (flowing paragraphs), 'sections' (titled sections + title),
       * 'chat' (speaker-labeled turns); any other string becomes a freeform
       * "organize as: …" directive (loud degrade). Unset ⇒ NO structure
       * directive at all — the task framing and the model determine shape.
       */
      structure?: string;
      /**
       * Ask the model to cite its sources, by the ids the gathered context
       * labels its passages with. The model wraps the words a source supports
       * as `[[<id>: <claim>]]`, the ids of several sources separated by commas;
       * a bare `[[<id>]]` is replaced by the source's name. The worker checks
       * every id against the gathered context (an id it did not show is
       * dropped, with a warning), takes every token out of the stored content,
       * and mints a W3C linking annotation on the new resource over exactly the
       * words each token cites.
       */
      cite?: boolean;
    };
    GetAnnotationHistoryResponse: {
      events: components['schemas']['AttributedEvent'][];
      total: number;
      annotationId: components['schemas']['AnnotationId'];
      resourceId: components['schemas']['ResourceId'];
    };
    GetAnnotationResponse: {
      annotation: components['schemas']['Annotation'];
      resource: components['schemas']['ResourceDescriptor'] | null;
      resolvedResource: components['schemas']['ResourceDescriptor'] | null;
    };
    GetAnnotationsResponse: {
      annotations: components['schemas']['Annotation'][];
      /** Total number of annotations */
      total: number;
      /** Motivation filter applied (if any) */
      motivation?: components['schemas']['Motivation'] | null;
    };
    GetEntityTypesResponse: {
      entityTypes: string[];
    };
    GetEventsResponse: {
      events: components['schemas']['AttributedEvent'][];
      total: number;
      resourceId: components['schemas']['ResourceId'];
    };
    GetReferencedByResponse: {
      referencedBy: components['schemas']['GetReferencedByResponseReferencedByItem'][];
    };
    GetReferencedByResponseReferencedByItem: {
      /** Reference annotation ID */
      id: components['schemas']['AnnotationId'];
      /**
       * Name of the resource containing the reference. Absent where no
       * description of that resource is held, and where its name is empty.
       */
      resourceName?: string;
      target: {
        /** ID of resource containing the reference */
        source: components['schemas']['ResourceId'];
        selector: {
          /** The selected text that references this resource */
          exact: string;
        };
      };
    };
    GetResourceByTokenResponse: {
      sourceResource: components['schemas']['ResourceDescriptor'];
      /** ISO 8601 timestamp when token expires */
      expiresAt: string;
    };
    GetResourceResponse: {
      resource: components['schemas']['ResourceDescriptor'];
      /**
       * All annotations for the resource (highlights, references, assessments,
       * etc.)
       */
      annotations: components['schemas']['Annotation'][];
    };
    GetTagSchemasResponse: {
      tagSchemas: components['schemas']['TagSchema'][];
    };
    /**
     * An annotation's graph presence. The node IS the annotation, so the full
     * W3C object is required — selectors and body included, which is what lets
     * a client place context annotations without a second fetch. Citations ride
     * here too: an inbound reference is its linking annotation, anchored by an
     * `annotation-of` edge to the resource it lives on and a `cites` edge to
     * the focal resource.
     */
    GraphAnnotationNode: {
      /** The AnnotationId — the same value as annotation.id */
      id: components['schemas']['AnnotationId'];
      type: 'annotation';
      /** The annotation's motivation, as a display label */
      label: string;
      /** Entity types carried by the annotation */
      entityTypes?: string[];
      annotation: components['schemas']['Annotation'];
      metadata?: { [key: string]: unknown };
    };
    /**
     * The graph database a service writes or reads, and what that kind of
     * database needs to be reached: one of the kinds `xynolog-graph` has a
     * store for, told apart by `type`. A secret is never a value here: a
     * database's password is named by the environment variable that holds it.
     */
    GraphConfig:
      | components['schemas']['Neo4jGraphConfig']
      | components['schemas']['JanusGraphConfig']
      | components['schemas']['NeptuneGraphConfig']
      | components['schemas']['MemoryGraphConfig'];
    /** A resource's presence in the gathered knowledge graph. */
    GraphResourceNode: {
      /** The resource's ResourceId */
      id: components['schemas']['ResourceId'];
      type: 'resource';
      /**
       * The resource's display name — its raw id when the resource's view was
       * missing at build time
       */
      label: string;
      /** Entity types on the resource */
      entityTypes?: string[];
      metadata?: { [key: string]: unknown };
    };
    /**
     * Liveness: the process is up and serving. It asks nothing of the Archivist
     * or the broker — a gateway that cannot reach them refuses to start, so one
     * that answers here got past both at boot.
     */
    HealthResponse: {
      status: string;
      message: string;
      version: string;
      timestamp: string;
    };
    /**
     * What a highlighting job takes: passages of the resource worth a reader's
     * attention are marked, with no text of the job's own.
     */
    HighlightingJobParams: {
      motivation: 'highlighting';
      /** What to look for, in the caller's words. Added to the prompt. */
      instructions?: string;
      /** How many annotations to aim for per 2000 words of the resource. */
      density?: number;
      /** The language of the resource being read. BCP 47. */
      sourceLanguage?: string;
    };
    /**
     * A knowledge base reached through its gateway, over HTTP. The gateway's
     * origin is the protocol, the host in lowercase and the port; a host that
     * is not a host's name is refused before it is put into a URL
     * (specs/src/session/gateway-url-cases.json).
     */
    HttpEndpoint: {
      /** Discriminant: the endpoint is a gateway reached over HTTP. */
      kind: 'http';
      /** The gateway's host, as a person or a discovery document gave it. */
      host: string;
      /** The gateway's port. */
      port: number;
      /** What the gateway is reached over. */
      protocol: 'http' | 'https';
    };
    /**
     * A provider's actual ceilings for a model, discovered from the provider
     * itself (Anthropic Models API; Ollama /api/show) — never hand-maintained
     * constants. Semantics differ by provider shape: Anthropic reports maximum
     * input tokens in contextTokens with a separate output ceiling in
     * maxOutputTokens; Ollama reports the shared input+output window and
     * mirrors it into both fields (there is no separate output ceiling), so
     * maxOutputTokens === contextTokens signals a shared window.
     */
    InferenceLimits: {
      /**
       * The context window in tokens. Anthropic: maximum input tokens (output
       * has its own ceiling). Ollama: the shared input+output window.
       */
      contextTokens: number;
      /**
       * Maximum output tokens per generation. Equal to contextTokens when the
       * provider has a single shared window.
       */
      maxOutputTokens: number;
      /**
       * Whether this engine accepts a caller-supplied sampling temperature,
       * measured against the provider (Anthropic: an active probe at discovery,
       * because some models reject the parameter outright and the Models API
       * does not say; Ollama: always true). Consumers treat only an explicit
       * false as 'hide temperature controls' — absence means no claim.
       */
      acceptsTemperature?: boolean;
    };
    /**
     * Request for the inference limits of the engines one service holds a
     * client for. Answered on job:limits-requested by the worker, and on
     * gather:limits-requested and match:limits-requested by the librarian: each
     * service that holds an inference credential reports for its own engines,
     * so no other service needs one.
     */
    InferenceLimitsRequest: Record<string, never>;
    /**
     * The inference limits one service discovered for the engines it holds a
     * client for. An engine whose discovery is currently unavailable is absent.
     */
    InferenceLimitsResult: {
      response: {
        limits: components['schemas']['EngineLimits'][];
      };
    };
    /**
     * A graph kept in a JanusGraph server, asked in Gremlin. No service has
     * been run against one.
     */
    JanusGraphConfig: {
      type: 'janusgraph';
      /** The server's host. */
      host: string;
      /** The port its Gremlin endpoint listens on. */
      port: number;
    };
    /**
     * A job as the dispatcher holds it. Its `status` decides which timestamps
     * and outcome fields it carries. It is what a claim returns (`job:claimed`,
     * always `running`) and what the queue stores, inside a JobRecord.
     */
    Job:
      | components['schemas']['JobPending']
      | components['schemas']['JobRunning']
      | components['schemas']['JobComplete']
      | components['schemas']['JobFailed']
      | components['schemas']['JobCancelled'];
    /**
     * Bus command the dispatcher emits, under its own service identity,
     * immediately after it accepts a job:claim — the correlated job:claimed
     * reply is unchanged. The Stower persists it as job:assigned. It is the one
     * fact only the dispatcher can vouch for: which holder took which job, and
     * who requested it. A later write citing `jobId` is checked against the
     * holder and its `creator` derived from the requester by reading the
     * resource's own log, with nothing outside the record.
     */
    JobAssignCommand: {
      /**
       * The dispatcher's service DID, injected by the /bus/emit gateway.
       * Clients do not set this.
       */
      _userId?: components['schemas']['UserId'];
      jobId: components['schemas']['JobId'];
      jobType: components['schemas']['JobType'];
      /**
       * The job's resource — for a generation, the source it generates from.
       * The assignment is persisted on this resource's log.
       */
      resourceId: components['schemas']['ResourceId'];
      /**
       * DID of the claimant whose claim was accepted — the `_userId` the
       * gateway stamped on the job:claim, restated by the dispatcher.
       */
      holder: components['schemas']['UserId'];
      /**
       * DID of the emitter of the job:create that produced this job — the
       * `_userId` the gateway stamped on that create, restated by the
       * dispatcher.
       */
      requester: components['schemas']['UserId'];
    };
    /**
     * Payload for job:assigned — the dispatcher's own record that it accepted a
     * claim. Emitted by the dispatcher under its service identity after a
     * successful job:claim (the correlated job:claimed reply is unchanged).
     * This is the one fact only the dispatcher can vouch for: which holder took
     * which job, and who requested it. The Stower persists it beside
     * job:started so that a write citing `jobId` can be checked against the
     * holder and its `creator` derived from the requester with no read outside
     * the event log.
     */
    JobAssignedPayload: {
      jobId: components['schemas']['JobId'];
      jobType: components['schemas']['JobType'];
      /**
       * The job's resource — for a generation, the source it generates from.
       * Job events are scoped here.
       */
      resourceId: components['schemas']['ResourceId'];
      /**
       * DID of the emitter whose claim the dispatcher accepted. The bus stamped
       * it on the job:claim as `_userId`; the dispatcher restates it here under
       * its own identity.
       */
      holder: components['schemas']['UserId'];
      /**
       * DID of the emitter of the job:create that produced this job. The
       * dispatcher restates the `_userId` the gateway stamped on that create.
       */
      requester: components['schemas']['UserId'];
    };
    /**
     * A worker's settling of a running job it holds whose work it has stopped
     * for a cancellation — the queue moves the job to cancelled/. Distinct from
     * JobCancelRequest (the client→worker REQUEST to stop): this is the worker
     * announcing it did, so the running job is never yanked to cancelled/ out
     * from under a live worker (the roach-motel race).
     */
    JobCancelCommand: {
      /**
       * Authenticated user's DID, injected by the /bus/emit gateway. Clients do
       * not set this.
       */
      _userId?: components['schemas']['UserId'];
      resourceId: components['schemas']['ResourceId'];
      jobId: components['schemas']['JobId'];
      jobType: components['schemas']['JobType'];
      /**
       * Annotation this job is attached to, when applicable. Lets the UI route
       * cancellation feedback to a specific annotation.
       */
      annotationId?: components['schemas']['AnnotationId'];
      /**
       * The units the worker had finished when it stopped. Recorded on the
       * cancelled job's metadata so the work already done stays visible.
       */
      completedUnits?: string[];
      /**
       * The furthest each unit begun got, keyed by unit, with what it had
       * counted there — the grain `completedUnits` cannot express. A unit named
       * in `completedUnits` is stated here too, by the cursor it ended at: a
       * later attempt skips it whole and counts it by that cursor. A cursor
       * never says a unit is finished; only `completedUnits` does. Merged
       * monotonically per unit, finished or not: a stale snapshot must never
       * move a cursor backward.
       */
      unitCursors?: { [key: string]: components['schemas']['UnitCursor'] };
    };
    /**
     * Request to cancel one job, named by its id. A pending job is cancelled
     * immediately by the dispatcher. A running job is cancelled only by the
     * worker that holds it: the worker stops its work and settles the job with
     * `job:cancel` (JobCancelCommand). The queue is never made to yank a
     * running job out from under a live worker.
     */
    JobCancelRequest: {
      jobId: components['schemas']['JobId'];
    };
    /**
     * What a cancel did, in the `response` of `job:cancel-ok`: whether the
     * queue acted on the job it named. A pending job is cancelled outright; a
     * running one is left to its worker, so for it true means accepted, not
     * stopped.
     */
    JobCancelResult: {
      /**
       * True when the queue acted on the job; false when the job is unknown or
       * already over.
       */
      cancelled: boolean;
    };
    /** A job cancelled before it concluded. */
    JobCancelled: {
      status: 'cancelled';
      metadata: components['schemas']['JobMetadata'];
      params: components['schemas']['JobParams'];
      /**
       * When its claim was made; absent when it was cancelled while pending.
       */
      startedAt?: string;
      /** When it was cancelled. */
      completedAt: string;
    };
    /**
     * Command to persist a running job's completed-unit checkpoint AT unit
     * completion. Distinct from JobFailCommand's checkpoint, which lands only
     * on a clean failure: a worker that dies (crash/OOM/kill) never emits
     * job:fail, so this durable, unthrottled write is what lets the janitor's
     * stale-running recovery resume a dead worker's job rather than redo its
     * finished units.
     */
    JobCheckpointCommand: {
      /**
       * Authenticated user's DID, injected by the /bus/emit gateway. Clients do
       * not set this.
       */
      _userId?: components['schemas']['UserId'];
      jobId: components['schemas']['JobId'];
      /**
       * Entity-type units whose annotations have been fully emitted so far.
       * Unioned into the running job's metadata checkpoint; a retry after
       * recovery skips them.
       */
      completedUnits: string[];
      /**
       * The furthest each unit begun got, keyed by unit, with what it had
       * counted there — the grain `completedUnits` cannot express. A unit named
       * in `completedUnits` is stated here too, by the cursor it ended at: a
       * later attempt skips it whole and counts it by that cursor. A cursor
       * never says a unit is finished; only `completedUnits` does. Merged
       * monotonically per unit, finished or not: a stale snapshot must never
       * move a cursor backward.
       */
      unitCursors?: { [key: string]: components['schemas']['UnitCursor'] };
    };
    /**
     * Claim the NEXT pending job that matches one of `accepts` (atomic: pending
     * → running). A job:queued announcement is a WAKE-UP, not a reservation:
     * the claimed job may differ from the announced one, and two claims after
     * one announcement both succeed on different jobs instead of racing for
     * one. job:claimed carries the claimed job; job:claim-failed reports that
     * nothing matching is pending.
     */
    JobClaimCommand: {
      /**
       * The jobs this claim takes. A job is handed over when it matches any one
       * of them.
       */
      accepts: components['schemas']['JobFilter'][];
      /**
       * Authenticated claimant's DID, injected by the /bus/emit gateway.
       * Clients do not set this. The dispatcher records it as the holder on
       * job:assigned.
       */
      _userId?: components['schemas']['UserId'];
      /**
       * The claimant's capabilities (the token's `roles`), injected by the
       * /bus/emit gateway. Clients do not set this. The dispatcher authorizes
       * the claim by capability — it admits the claim only when this carries
       * the worker role — so a claimant that is not a worker for this knowledge
       * base is refused before the queue is consulted.
       */
      _roles?: string[];
    };
    /**
     * The reply to a successful `job:claim`: the claimed job, now running under
     * the claimant.
     */
    JobClaimedResult: {
      response: components['schemas']['JobRunning'];
    };
    /** A job its worker completed. */
    JobComplete: {
      status: 'complete';
      metadata: components['schemas']['JobMetadata'];
      params: components['schemas']['JobParams'];
      /** When the claim that completed it was made. */
      startedAt: string;
      /** When it completed. */
      completedAt: string;
      result: components['schemas']['JobStoredResult'];
    };
    /**
     * A job's worker says the job is complete. The result it carries is its
     * verb's: a `mark` job's counts or the resource a `yield` job made, or a
     * decline from either. A completion whose result is the other verb's is
     * refused where the command is admitted.
     */
    JobCompleteCommand:
      | components['schemas']['MarkJobCompleteCommand']
      | components['schemas']['YieldJobCompleteCommand'];
    /** Payload for job:completed domain event */
    JobCompletedPayload: {
      jobId: components['schemas']['JobId'];
      jobType: components['schemas']['JobType'];
      /**
       * Which attempt produced this event, 1-based (a first run is 1). ALWAYS
       * present: the queue re-runs a failed job silently, so an operator
       * reading progress or a terminal record has no other way to tell a re-run
       * from a first run — and provider spend, already counted in
       * xynolog_inference_tokens_total, cannot be attributed to a repeated
       * document without it. Stated rather than inferred from absence, because
       * 'attempt 1' is a fact the emitter always knows.
       */
      attempt?: number;
      /** Annotation this job was attached to, when applicable */
      annotationId?: components['schemas']['AnnotationId'];
      totalSteps?: number;
      /** For detection: total entities found */
      foundCount?: number;
      /** For generation: ID of generated resource */
      resultResourceId?: components['schemas']['ResourceId'];
      /** For generation: URI of annotation that triggered generation */
      annotationUri?: string;
      /** Full result object for extensibility */
      result?: { [key: string]: unknown };
      durability?: components['schemas']['DurabilityEvidence'];
    };
    /**
     * Create a job. A job description is its `jobType` and enough parameters to
     * be well formed: a `mark` job names its resource and, in its parameters,
     * its motivation; a `yield` job names its context.
     */
    JobCreateCommand:
      | components['schemas']['MarkJobCreateCommand']
      | components['schemas']['YieldJobCreateCommand'];
    /** Result of a job:create command */
    JobCreatedResult: {
      response: components['schemas']['JobCreatedResultResponse'];
    };
    JobCreatedResultResponse: {
      jobId: components['schemas']['JobId'];
    };
    /**
     * Result of a job that completed without doing its work because the
     * resource could not be read. Distinct from a failure: nothing went wrong,
     * there was simply no text to work with — an encrypted or damaged PDF, a
     * scan whose text could not be recognized, or a document that yielded
     * nothing. The reasons are the extraction vocabulary the Smelter reports on
     * `smelt:settled`, MINUS `no-extractor`: a media type that can never yield
     * text (a zip, an image) is a bad request rather than a decline, so a
     * worker asked to detect over one throws and the job reports `job:fail`.
     * Everything here is a resource-specific outcome — the same media type
     * would have succeeded on a different document.
     */
    JobDeclined: {
      /**
       * Always true. It is what tells a decline from the result of a job that
       * did its work, which never carries it.
       */
      declined: true;
      /**
       * Why the resource could not be read. A CODE, not a sentence: the client
       * owns the wording, so a browser renders it in the user's language and
       * the CLI renders English terminal copy from the same value. A prose
       * `message` composed server-side would be English everywhere.
       */
      reason: 'no-text-layer' | 'encrypted' | 'corrupt' | 'too-large' | 'empty';
    };
    /** Command to mark a job as failed */
    JobFailCommand: {
      /**
       * Authenticated user's DID, injected by the /bus/emit gateway. Clients do
       * not set this.
       */
      _userId?: components['schemas']['UserId'];
      resourceId: components['schemas']['ResourceId'];
      jobId: components['schemas']['JobId'];
      jobType: components['schemas']['JobType'];
      /**
       * Which attempt produced this event, 1-based (a first run is 1). ALWAYS
       * present: the queue re-runs a failed job silently, so an operator
       * reading progress or a terminal record has no other way to tell a re-run
       * from a first run — and provider spend, already counted in
       * xynolog_inference_tokens_total, cannot be attributed to a repeated
       * document without it. Stated rather than inferred from absence, because
       * 'attempt 1' is a fact the emitter always knows.
       */
      attempt?: number;
      /**
       * Annotation this job is attached to, when applicable. Lets the UI route
       * failure feedback (error toast, revert state) to a specific annotation.
       */
      annotationId?: components['schemas']['AnnotationId'];
      error: string;
      /**
       * Entity-type units whose annotations were fully emitted before this
       * failure (checkpointed resume). The queue records them on the retried
       * job's metadata; a retried claim skips them so completed work is neither
       * redone nor duplicated.
       */
      completedUnits?: string[];
      /**
       * The furthest each unit begun got, keyed by unit, with what it had
       * counted there — the grain `completedUnits` cannot express. A unit named
       * in `completedUnits` is stated here too, by the cursor it ended at: a
       * later attempt skips it whole and counts it by that cursor. A cursor
       * never says a unit is finished; only `completedUnits` does. Merged
       * monotonically per unit, finished or not: a stale snapshot must never
       * move a cursor backward.
       */
      unitCursors?: { [key: string]: components['schemas']['UnitCursor'] };
      failureClass?: components['schemas']['FailureClass'];
      /**
       * Whether the queue will re-queue this job for another attempt. Computed
       * by the worker from the SAME rule the queue applies when it takes the
       * failure (specs/src/jobs/retry-cases.json, which every SDK and the
       * dispatcher run) using the retry budget carried on the claimed record.
       * FALSE (or absent) means this failure is TERMINAL: a client's job-watch
       * stream ends here. TRUE means the work continues on a fresh attempt —
       * the failure is an event, not the end, and a stream that terminated on
       * it would report a recovering run as a failed one.
       */
      willRetry?: boolean;
      durability?: components['schemas']['DurabilityEvidence'];
    };
    /** A job that failed and will not be retried. */
    JobFailed: {
      status: 'failed';
      metadata: components['schemas']['JobMetadata'];
      params: components['schemas']['JobParams'];
      /** When the last claim was made; absent when it failed without one. */
      startedAt?: string;
      /** When it failed. */
      completedAt: string;
      /** The failure's message. */
      error: string;
      failureClass?: components['schemas']['FailureClass'];
    };
    /**
     * Payload for the job:failed domain event — a permanent fact of the
     * resource, not operational state. It carries the judgments the worker
     * COMPUTED, not just its message: at the log they are otherwise
     * unrecoverable, the only remaining witness being a flattened English
     * string.
     */
    JobFailedPayload: {
      jobId: components['schemas']['JobId'];
      jobType: components['schemas']['JobType'];
      /**
       * Which attempt produced this event, 1-based (a first run is 1). ALWAYS
       * present: the queue re-runs a failed job silently, so an operator
       * reading progress or a terminal record has no other way to tell a re-run
       * from a first run — and provider spend, already counted in
       * xynolog_inference_tokens_total, cannot be attributed to a repeated
       * document without it. Stated rather than inferred from absence, because
       * 'attempt 1' is a fact the emitter always knows.
       */
      attempt?: number;
      /** Annotation this job was attached to, when applicable */
      annotationId?: components['schemas']['AnnotationId'];
      error: string;
      failureClass?: components['schemas']['FailureClass'];
      /**
       * Whether the worker computed that the queue would re-queue this job
       * (same predicate the queue applies, `willRetryAfter`). Absent means the
       * worker stated nothing. Without it a reader of the log cannot tell a run
       * recovering across several job:failed events from that many dead jobs.
       */
      willRetry?: boolean;
      durability?: components['schemas']['DurabilityEvidence'];
    };
    /**
     * Some jobs, named by fields of the job description: a partial description,
     * at the description's own paths. A job matches when every field stated
     * here equals the job's. A `mark` filter always states its motivation.
     */
    JobFilter:
      | components['schemas']['MarkJobFilter']
      | components['schemas']['YieldJobFilter'];
    /**
     * A job's id. 1 to 128 of the letters `A`–`Z` and `a`–`z`, the digits, `_`
     * and `-`. It is one segment of a URL and one name in a file system, and it
     * is held to that wherever it enters: a gateway refuses a payload that
     * carries anything else. How one is made is no part of the rule.
     */
    JobId: string & { readonly __brand: 'JobId' };
    /**
     * What the dispatcher records about a job beside its parameters.
     * `completedUnits` and `unitCursors` appear once a worker has checkpointed.
     * `retryCount` counts the times the queue has put the job back to pending
     * after a failure it classes as transient.
     */
    JobMetadata: {
      /**
       * The job's id: `job-` followed by a version 4 UUID written as 32
       * lowercase hex digits, without dashes.
       */
      id: components['schemas']['JobId'];
      type: components['schemas']['JobType'];
      /** The DID of the principal whose `job:create` created the job. */
      userId: components['schemas']['UserId'];
      /** When the job was created, as an ISO 8601 timestamp. */
      created: string;
      retryCount: number;
      /**
       * How many transient failures the queue retries: 0 for generation, whose
       * re-run produces different content; 1 for every other type.
       */
      maxRetries: number;
      /**
       * The units a worker has finished, merged across checkpoints and failures
       * as a set.
       */
      completedUnits?: string[];
      /**
       * The furthest each unit begun got, keyed by unit, with what it had
       * counted there. A finished unit keeps its cursor: where it ended, and
       * its final counts.
       */
      unitCursors?: { [key: string]: components['schemas']['UnitCursor'] };
    };
    /**
     * A job's parameters as the Dispatcher holds them: the `params` of its
     * `job:create`, and what the Dispatcher adds. It adds `resourceId`, the
     * resource the job is about: a `mark` job's own, and for a `yield` job the
     * one its context focuses on. For a tagging job it adds `schema`, the tag
     * schema its `schemaId` names, so that whoever holds the job needs no
     * registry. Nothing the caller sent is changed or removed.
     */
    JobParams: {
      resourceId: components['schemas']['ResourceId'];
      /**
       * The tag schema a tagging job's `schemaId` names, as the knowledge base
       * registered it when the job was created. On a tagging job, and on no
       * other.
       */
      schema?: components['schemas']['TagSchema'];
    } & { [key: string]: unknown };
    /** A job waiting for a worker to claim it. */
    JobPending: {
      status: 'pending';
      metadata: components['schemas']['JobMetadata'];
      params: components['schemas']['JobParams'];
    };
    /**
     * Progress report from a running job. The required field is `percentage`;
     * `message` carries the coded phase and the rest are optional job-shape
     * fields. This is the single progress shape for every job type — annotation
     * workers and generation alike. Terminality is signalled on `job:complete`
     * / `job:fail`, not here. A flow that iterates a user-chosen list (entity
     * types for references, categories for tags) reports its position as one
     * `current`/`processed`/`total` triple, the same shape for both, so a
     * client never needs to know which flow it is drawing.
     */
    JobProgress: {
      /** Completion percentage (0-100) */
      percentage: number;
      message?: components['schemas']['JobProgressMessage'];
      /**
       * Annotation this job is attached to, when applicable. Echoed inside
       * JobProgress (in addition to the outer command envelope) so consumers
       * that only see the inner progress object (e.g. what `yield.delegate`
       * returns) can still route visual feedback to a specific annotation.
       */
      annotationId?: components['schemas']['AnnotationId'];
      /**
       * What the run is working on right now. `kind` is a CODE the client
       * renders a localized name for; `value` is KB data (an entity type, a tag
       * category) shown verbatim — the same split as `requestParams`. Absent on
       * flows that iterate nothing, such as generation.
       */
      current?: {
        /**
         * What sort of thing `value` is. Adding a variant means adding client
         * copy for it in every locale.
         */
        kind: 'entity-type' | 'category';
        /** The item itself, shown verbatim and never translated. */
        value: string;
      };
      /**
       * Items completed so far, zero-based — the item in `current` is the one
       * after these. Paired with `total`.
       */
      processed?: number;
      /** Items this run will process in all. */
      total?: number;
      /** Entities found so far (a linking job) */
      entitiesFound?: number;
      /**
       * Cumulative mentions the count-verifier priced across the pieces
       * accepted so far — the denominator for a real progress bar (found of
       * ~expected). Approximate by nature (the count saturates on very large
       * pieces) and monotonically growing within a run. ABSENT when the
       * provider does not verify detection yield, or before any piece has been
       * priced: no claim, never zero.
       */
      entitiesExpected?: number;
      /** Annotations emitted so far (a linking job) */
      entitiesEmitted?: number;
      /**
       * Per-item results for the items already finished, for the UI's completed
       * log. Generic across flows for the same reason `current` is.
       */
      completedItems?: {
        /** The item, shown verbatim. */
        value: string;
        /** Annotations found for it. */
        foundCount: number;
        /**
         * Annotations actually persisted for it — post-dedupe and
         * post-durability-acknowledgement, so it counts what the event log
         * holds, not what the model proposed. Beside foundCount this is the
         * per-unit yield the sizing work is judged by. Present on flows whose
         * units persist as they complete (a linking job); the tagging flow
         * reports the same fact as byCategory on its result, because its
         * annotations are built after the per-category loop.
         */
        persistedCount?: number;
        /**
         * Present only when pieces of this unit were accepted at the
         * subdivision floor while a count call said more was present. The unit
         * completed, but incompletely — this carries the EVIDENCE (found vs
         * counted, over how many pieces), never a judgment against any expected
         * yield. Absent means complete: genuinely absent, not defaulted.
         */
        underReported?: {
          /** Floor-accepted pieces in this unit. */
          pieces: number;
          /**
           * Annotations extraction did find on those pieces — every span
           * write-time-verified.
           */
          found: number;
          /**
           * Mentions the count calls reported across those pieces (approximate
           * by nature).
           */
          counted: number;
        };
      }[];
      /**
       * Echoed job parameters for display in the progress UI. `label` is a
       * CODE, not a sentence — the client owns the wording, same rule as the
       * progress message. `value` is the user's own input (an entity-type list,
       * their instructions) and is deliberately NOT translated: it is their
       * words, not ours.
       */
      requestParams?: {
        /**
         * Which parameter this is. The client renders a localized name for it.
         */
        label: 'entity-types' | 'instructions' | 'tone' | 'density';
        /** The user's own input, shown verbatim. */
        value: string;
      }[];
    };
    /** Analyzing the content. */
    JobProgressAnalyzing: {
      code: 'analyzing';
    };
    /** Analyzing the content against the tag schema. */
    JobProgressAnalyzingTags: {
      code: 'analyzing-tags';
    };
    /** Terminal success summary. */
    JobProgressCompleteCreated: {
      code: 'complete-created';
      /** How many annotations were created */
      count: number;
      /**
       * The motivation of the job, and so of what it created. A client words it
       * in its own language.
       */
      motivation: components['schemas']['Motivation'];
    };
    /**
     * Generation's terminal success. Deliberately generic — the client already
     * holds the title it typed, and the outcome (name + resource link) travels
     * on job:complete, not on progress. `truncated` qualifies the completion:
     * the same bit `YieldJobDone.truncated` carries, so the two surfaces cannot
     * drift.
     */
    JobProgressCompleteGenerated: {
      code: 'complete-generated';
      /**
       * True when the model stopped at the maxTokens ceiling — the artifact is
       * cut off, not complete.
       */
      truncated: boolean;
    };
    /** Writing detected annotations back to the resource. */
    JobProgressCreatingAnnotations: {
      code: 'creating-annotations';
      /** How many annotations are being created */
      count: number;
    };
    /** Writing the generated resource. */
    JobProgressCreatingResource: {
      code: 'creating-resource';
    };
    /** Writing detected tag annotations back to the resource. */
    JobProgressCreatingTagAnnotations: {
      code: 'creating-tag-annotations';
      /** How many annotations are being created */
      count: number;
    };
    /** Entity detection, one entity type at a time. */
    JobProgressDetectingEntities: {
      code: 'detecting-entities';
      /** Entity type currently being detected */
      entityType: string;
    };
    /** The model is generating the resource. */
    JobProgressGeneratingResource: {
      code: 'generating-resource';
    };
    /** Loading the resource content. */
    JobProgressLoading: {
      code: 'loading';
    };
    /**
     * What a running job is doing right now, as a code plus typed params —
     * never a prose sentence. The producer reports what happened; each client
     * renders it in the user's language (react-ui from its translations, the Go
     * launcher from its English map). One named schema per code, discriminated
     * on `code`, so generated clients get typed variants and copy-map
     * completeness is statically checkable. The vocabulary is every report
     * Xynolog's worker makes (contract/WORKER-SERVICE.md, D16 to D19 and Y8);
     * extending it means adding a named variant here and copy in every client,
     * gated by the locale-completeness check.
     */
    JobProgressMessage:
      | components['schemas']['JobProgressLoading']
      | components['schemas']['JobProgressAnalyzing']
      | components['schemas']['JobProgressAnalyzingTags']
      | components['schemas']['JobProgressGeneratingResource']
      | components['schemas']['JobProgressCreatingResource']
      | components['schemas']['JobProgressCompleteGenerated']
      | components['schemas']['JobProgressDetectingEntities']
      | components['schemas']['JobProgressCreatingAnnotations']
      | components['schemas']['JobProgressCreatingTagAnnotations']
      | components['schemas']['JobProgressCompleteCreated'];
    /**
     * A pending job, announced when it is created and again at each tick while
     * it waits. It carries the job description less the job's input, so that a
     * party deciding whether to claim reads here what its claim would be
     * matched against. It is a wake-up and not an offer of this job: a claim is
     * answered with the next pending job it matches.
     */
    JobQueuedEvent:
      | components['schemas']['MarkJobQueuedEvent']
      | components['schemas']['YieldJobQueuedEvent'];
    /**
     * One job as the queue stores it: the job, and when it last showed life.
     * The dead-worker sweep reads `lastProgressAt`: a running job whose worker
     * has reported nothing for the configured interval is presumed dead. Where
     * the queue keeps these records is the job storage layout,
     * specs/src/jobs/storage.json.
     */
    JobRecord: {
      job: components['schemas']['Job'];
      /**
       * When the job was created, claimed, checkpointed or last reported
       * progress, as an ISO 8601 timestamp.
       */
      lastProgressAt: string;
    };
    /** Command to report progress on a job */
    JobReportProgressCommand: {
      /**
       * Authenticated user's DID, injected by the /bus/emit gateway. Clients do
       * not set this.
       */
      _userId?: components['schemas']['UserId'];
      resourceId: components['schemas']['ResourceId'];
      jobId: components['schemas']['JobId'];
      jobType: components['schemas']['JobType'];
      /**
       * Which attempt produced this event, 1-based (a first run is 1). ALWAYS
       * present: the queue re-runs a failed job silently, so an operator
       * reading progress or a terminal record has no other way to tell a re-run
       * from a first run — and provider spend, already counted in
       * xynolog_inference_tokens_total, cannot be attributed to a repeated
       * document without it. Stated rather than inferred from absence, because
       * 'attempt 1' is a fact the emitter always knows.
       */
      attempt?: number;
      /**
       * Annotation this job is attached to, when applicable. Lets the UI attach
       * progress visuals to a specific annotation (e.g. a reference whose
       * generation is running).
       */
      annotationId?: components['schemas']['AnnotationId'];
      percentage: number;
      progress?: components['schemas']['JobProgress'];
    };
    /**
     * What a job reports when it concludes without failing: a `mark` job's
     * counts, the resource a `yield` job made, or a decline from either. A
     * result has no discriminant of its own: the job description beside it says
     * which job it answers, and the three share no member, so each is told from
     * the others by what it alone carries.
     */
    JobResult:
      | components['schemas']['MarkJobDone']
      | components['schemas']['YieldJobDone']
      | components['schemas']['JobDeclined'];
    /** A job a worker has claimed and not yet concluded. */
    JobRunning: {
      status: 'running';
      metadata: components['schemas']['JobMetadata'];
      params: components['schemas']['JobParams'];
      /** When the claim that holds it was made, as an ISO 8601 timestamp. */
      startedAt: string;
      progress: components['schemas']['JobStoredProgress'];
    };
    /** Command to start a job */
    JobStartCommand: {
      /**
       * Authenticated user's DID, injected by the /bus/emit gateway. Clients do
       * not set this.
       */
      _userId?: components['schemas']['UserId'];
      resourceId: components['schemas']['ResourceId'];
      jobId: components['schemas']['JobId'];
      jobType: components['schemas']['JobType'];
      /**
       * Annotation this job is attached to, when applicable. Set for
       * annotation-scoped jobs like generation (from a specific reference).
       * Unset for resource-scoped jobs like bulk reference/tag/highlight
       * detection.
       */
      annotationId?: components['schemas']['AnnotationId'];
      /**
       * Which attempt produced this event, 1-based (a first run is 1). ALWAYS
       * present: the queue re-runs a failed job silently, so an operator
       * reading progress or a terminal record has no other way to tell a re-run
       * from a first run — and provider spend, already counted in
       * xynolog_inference_tokens_total, cannot be attributed to a repeated
       * document without it. Stated rather than inferred from absence, because
       * 'attempt 1' is a fact the emitter always knows.
       */
      attempt?: number;
    };
    /** Payload for job:started domain event */
    JobStartedPayload: {
      jobId: components['schemas']['JobId'];
      jobType: components['schemas']['JobType'];
      /** Annotation this job is attached to, when applicable */
      annotationId?: components['schemas']['AnnotationId'];
      totalSteps?: number;
    };
    /** Request to check the status of a job */
    JobStatusRequest: {
      jobId: components['schemas']['JobId'];
    };
    JobStatusResponse: {
      jobId: components['schemas']['JobId'];
      type: components['schemas']['JobType'];
      status: 'pending' | 'running' | 'complete' | 'failed' | 'cancelled';
      userId: components['schemas']['UserId'];
      created: string;
      startedAt?: string;
      completedAt?: string;
      error?: string;
      failureClass?: components['schemas']['FailureClass'];
      progress?: components['schemas']['JobStoredProgress'];
      result?: components['schemas']['JobStoredResult'];
    };
    /** Result of a job status request */
    JobStatusResult: {
      response: components['schemas']['JobStatusResponse'];
    };
    /**
     * A running job's progress as the dispatcher stores it: the last
     * JobProgress its worker reported with `job:report-progress`, or an empty
     * object before the first report.
     */
    JobStoredProgress:
      components['schemas']['JobProgress'] | Record<string, never>;
    /**
     * A completed job's result as the dispatcher stores it: the result its
     * worker reported with `job:complete`, or an empty object when it reported
     * none.
     */
    JobStoredResult: components['schemas']['JobResult'] | Record<string, never>;
    /**
     * What a job does, as the verb that asks for it: `mark` annotates a
     * resource, `yield` makes one. A job description is its `jobType` and the
     * parameters that verb takes; a `mark` job's parameters state its
     * motivation.
     */
    JobType: 'mark' | 'yield';
    /**
     * What a knowledge base says about itself, answered by the Archivist from
     * the committed .xynolog/config.yaml and the working tree it holds. The
     * only source clients use for a knowledge base's name and domain.
     */
    KbDescription: {
      /**
       * The committed project.name, or the knowledge base directory's name when
       * it commits no .xynolog/config.yaml.
       */
      name: string;
      /**
       * The committed site.domain: the knowledge base's permanent identity. Its
       * did is 'did:web:' + this domain (kbDid in @xynolog/core). It names
       * WHICH knowledge base this is, not which running copy: a local clone and
       * a codespace of one repo report the same domain, so use it to verify
       * what you connected to, never to select among copies. A knowledge base
       * that commits no .xynolog/config.yaml declares none, and is refused with
       * browse:kb-failed.
       */
      domain: string;
      /**
       * The working tree's current git branch. Absent when the knowledge base
       * does not sync git (`git.sync` in its committed .xynolog/config.yaml),
       * and when its tree is not a git checkout.
       */
      gitBranch?: string;
    };
    /**
     * How a knowledge base is reached: a gateway over HTTP, or a knowledge base
     * the host process has loaded. Told apart by `kind`. Only what builds a
     * transport, or signs in at an issuer, reads it.
     */
    KbEndpoint:
      | components['schemas']['HttpEndpoint']
      | components['schemas']['LocalEndpoint'];
    /**
     * A knowledge base's committed identity (`project.name` and `site.domain`
     * in its .xynolog/config.yaml), as a service's document names the knowledge
     * base it serves. Its telemetry names it by its DID (`xynolog.kb`,
     * specs/src/service-telemetry/telemetry.json).
     */
    KbIdentity: {
      /**
       * Its name. The gateway publishes it as its resource metadata's
       * `resource_name`.
       */
      name: string;
      /**
       * Its did:web domain: its permanent identity, the source of the audience
       * its tokens must carry, and the authority its people and agents are
       * named under.
       */
      domain: string;
    };
    /**
     * When a knowledge base last described itself, and what it said beyond its
     * name. A client shows it as current only while a session to the knowledge
     * base is live, and as of `at` otherwise.
     */
    KbRead: {
      /** When the description arrived. */
      at: string;
      /**
       * The branch of the knowledge base's working tree then. Absent when the
       * working tree was not a git checkout.
       */
      gitBranch?: string;
    };
    /**
     * Where to connect to a knowledge base: an endpoint, and the labels a
     * client keeps of it. It carries no identity: which knowledge base answers
     * at an address is known only once it has been reached with a token and
     * asked, so a target is what every caller can build before then, and a
     * session's whole input. A client keeps it locally; it is never sent.
     */
    KbTarget: {
      /**
       * The key the client stores a session's credentials under. Two sessions
       * that share one storage have two ids, or each overwrites the other's
       * tokens. Whoever builds the target chooses it; none is made up.
       */
      id: string;
      /**
       * What a person reads the knowledge base as. Once the knowledge base has
       * described itself, its own name.
       */
      label: string;
      endpoint: components['schemas']['KbEndpoint'];
    };
    /**
     * A registered knowledge base: a target, and what registering it took, the
     * identity the knowledge base reported of itself when it was reached
     * (`did`) among it. What a client's list of knowledge bases holds. A did
     * says which knowledge base, not which running copy: a clone and a
     * codespace of one repository are one knowledge base at two addresses and
     * report one did. So an entry is looked up by its endpoint, and its did is
     * what an answer is verified against; nothing selects by did. Its `label`
     * and `lastRead` are written only from an answer that carried its did.
     */
    KnowledgeBase: components['schemas']['KbTarget'] &
      components['schemas']['NewKnowledgeBase'];
    /**
     * Knowledge graph gathered for an LLM context — a shared backbone in which
     * resources AND annotations are typed nodes, connected by typed (optionally
     * bidirectional) edges. Flattened views the matcher/generation read
     * (connections, citedBy, siblings) are derived from these nodes/edges.
     */
    KnowledgeGraph: {
      nodes: (
        | components['schemas']['GraphResourceNode']
        | components['schemas']['GraphAnnotationNode']
      )[];
      edges: {
        source: string;
        target: string;
        /**
         * Edge kind: `annotation-of` (an annotation → the resource it lives
         * on), `cites` (a citing linking annotation → the focal resource), or
         * `link` (a resource → a resource it links to)
         */
        type: string;
        /**
         * Whether the connection goes both ways. Absent on a `link` edge found
         * through what cites a resource, which says nothing of the way back
         */
        bidirectional?: boolean;
        metadata?: { [key: string]: unknown };
      }[];
      /**
       * Whether the graph stopped taking resources at its ceiling of 200
       * resource nodes, so that a resource within the depth asked for is not in
       * it. Present, and true, only then
       */
      truncated?: boolean;
    };
    /**
     * Everything a Librarian reads at boot: nothing in it is defaulted by the
     * Librarian. Whoever starts a Librarian writes it, from the knowledge
     * base's stack documents, and the Librarian reads it from the path its
     * `--config` flag names. This schema is the contract, and a Librarian needs
     * no launcher. Started without `--config`, or with a path that names no
     * file, the Librarian refuses to start and says which. No secret is a value
     * here: the graph database's password, an embedding provider's key and a
     * model provider's key are each named by the environment variable that
     * holds it, and the Librarian's own service account is
     * `XYNOLOG_OIDC_CLIENT_ID` and `XYNOLOG_OIDC_CLIENT_SECRET` in its
     * environment. A document that does not validate is refused at boot, naming
     * each failing field.
     */
    LibrarianConfig: {
      kb: components['schemas']['KbIdentity'];
      /** The URL the Librarian reaches the gateway at: its route to the bus. */
      gatewayUrl: string;
      /** The issuer the Librarian's service account signs in at. */
      identity: components['schemas']['ServiceIdentity'];
      /**
       * Where the Archivist listens. The Librarian reads a resource's bytes
       * from it, as its service account.
       */
      archivist: components['schemas']['ServiceAddress'];
      graph: components['schemas']['GraphConfig'];
      vectors: components['schemas']['VectorsConfig'];
      embedding: components['schemas']['EmbeddingConfig'];
      matcher: components['schemas']['LibrarianEngineConfig'];
      gatherer: components['schemas']['LibrarianEngineConfig'];
      /**
       * The path of a model catalogue file: what each model of a provider can
       * take, for the providers whose own APIs do not say (`google`, `openai`,
       * `together`). A Librarian whose matcher or gatherer is of one of those
       * providers refuses to start where the file cannot be read, and where it
       * states nothing of that model. A Librarian with no such model does not
       * read it.
       */
      modelCatalogue: string;
      /** The bound on a gather. */
      gather: {
        /**
         * How long a gather around a resource waits for the Smelter's decision
         * on it before answering without similar passages, in milliseconds.
         */
        settleTimeoutMs: number;
      };
      /** The bound on a search by meaning. */
      search: {
        /** The least similarity a hit by meaning must have. */
        semanticFloor: number;
      };
      /** The port the Librarian answers `/health` on. */
      port: number;
      logLevel: components['schemas']['LogLevel'];
      logFormat: components['schemas']['LogFormat'];
    };
    /**
     * The engine a Librarian actor asks: which it is, and where its provider is
     * reached.
     */
    LibrarianEngineConfig: {
      engine: components['schemas']['Engine'];
      /** The address the provider's API is reached at. */
      baseUrl: string;
      /**
       * The environment variable holding the provider's API key, when the
       * provider requires one.
       */
      apiKeyEnv?: string;
    };
    /** An ErrorResponse that names, in `code`, the limit the request met. */
    LimitRefusal: components['schemas']['ErrorResponse'] & {
      /**
       * `streams`: the principal already holds as many streams as its
       * coefficient of `x-xynolog-limits.streamsPerPrincipal` allows.
       * `emit-rate`: the principal's emits have used its bucket, whose rate and
       * burst are its coefficient of `x-xynolog-limits.emitsPerPrincipal`, per
       * gateway process. `unanswered-requests`: the client already awaits as
       * many replies as `BusSubscribeRequest.pendingReplies` may name.
       * `capacity`: the gateway holds as many queued bytes as it can.
       * `refusal-rate`: the request's credential was refused, and the requests
       * its holder has had refused have used their allowance; it answers only a
       * request whose token has already failed verification, so it says what a
       * 401 says, and a client that can renew its token renews it and sends the
       * request again rather than waiting (contract/TRANSPORT-CONTRACT.md § A
       * refused credential).
       */
      code:
        | 'streams'
        | 'emit-rate'
        | 'unanswered-requests'
        | 'capacity'
        | 'refusal-rate';
    };
    /**
     * What a linking job takes: mentions of the named entity types are marked
     * as references, each unresolved until it is bound to a resource.
     */
    LinkingJobParams: {
      motivation: 'linking';
      /**
       * The entity types to find mentions of. Each is one the knowledge base
       * registers.
       */
      entityTypes: string[];
      /**
       * Whether a description that stands for an entity ("the wily hero")
       * counts as a mention of it, beside its name.
       */
      includeDescriptiveReferences?: boolean;
      /** The language the annotations' own text is written in. BCP 47. */
      language?: string;
      /** The language of the resource being read. BCP 47. */
      sourceLanguage?: string;
    };
    ListResourcesResponse: {
      resources: components['schemas']['ResourceDescriptor'][];
      total: number;
      offset: number;
      limit: number;
    };
    /**
     * A knowledge base the host process has loaded and reaches through a
     * transport with no wire.
     */
    LocalEndpoint: {
      /** Discriminant: the endpoint is in the host process. */
      kind: 'local';
      /**
       * Which loaded knowledge base, named by an id that means something to the
       * host process alone.
       */
      kbId: string;
    };
    /**
     * How each log line is written to stdout: `json`, one JSON object per line
     * carrying the active trace's `trace_id` and `span_id`; or `simple`,
     * `<timestamp> [<LEVEL>] <message>` followed by any metadata as JSON.
     */
    LogFormat: 'json' | 'simple';
    /**
     * How much a service logs: the least severe level it writes, from error,
     * the most severe, to debug.
     */
    LogLevel: 'error' | 'warn' | 'info' | 'http' | 'debug';
    /** Bus command to archive a resource and optionally remove its file. */
    MarkArchiveCommand: {
      /**
       * Authenticated user's DID, injected by the /bus/emit gateway. Clients do
       * not set this.
       */
      _userId?: components['schemas']['UserId'];
      resourceId: components['schemas']['ResourceId'];
      /**
       * Optional: where the resource's bytes live, so the archive can act on
       * the file. An instruction to this handler, not a copy of the stored fact
       * (that lives on the primary Representation). Working-tree URI, only
       * file:// is supported.
       */
      storageUri?: string;
      keepFile?: boolean;
    };
    /**
     * Bus command to persist a detection unit's annotations as one acknowledged
     * batch. It is answered only after every annotation is in the event log, so
     * a worker can gate unit completion on durability rather than on emission.
     * The batch is the unit: a partial commit is reported as a failure, and the
     * worker retries the whole unit, which is safe because annotation ids are
     * deterministic: content-addressed, so re-emitting one is a no-op.
     */
    MarkCommitCommand: {
      /**
       * Authenticated user's DID, injected by the /bus/emit gateway. Clients do
       * not set this.
       */
      _userId?: components['schemas']['UserId'];
      /**
       * The emitter's capabilities (the token's `roles`), injected by the
       * /bus/emit gateway. Clients do not set this. An emitter carrying the
       * worker role must cite the job this batch fulfils in `jobId`; the Stower
       * refuses the batch otherwise.
       */
      _roles?: string[];
      /**
       * The job this batch fulfils. Required when the emitter carries the
       * worker role; absent for self-initiated work (a person, or an agent
       * acting on its own). The knowledge base derives who requested these
       * annotations from the cited job's own events — the emitter never says
       * who the work was for.
       */
      jobId?: components['schemas']['JobId'];
      /** Resource every annotation in this batch targets. */
      resourceId: components['schemas']['ResourceId'];
      /**
       * The unit's annotations, already built with deterministic ids.
       * Re-committing an identical batch is a no-op rather than a duplicate.
       */
      annotations: components['schemas']['Annotation'][];
    };
    /**
     * Durability acknowledgement for a mark:commit batch: every annotation
     * named by the command is in the event log at the moment this is emitted.
     */
    MarkCommitOk: {
      /** What the commit persisted. */
      response: {
        /**
         * Annotations the command named that are durable in the event log.
         * Equals the batch size on success, on a first commit and on a retry
         * alike — the commit appends only what the resource does not already
         * hold, so a wholly-redundant retry has still succeeded and says so.
         * Not an append tally: a caller must never have to read a 0 as 'all
         * good'.
         */
        persisted: number;
        /** Ids the batch covers, whether appended now or already present. */
        annotationIds: components['schemas']['AnnotationId'][];
      };
    };
    /**
     * Success reply after creating an annotation, matched to the originating
     * command by correlationId.
     */
    MarkCreateOk: {
      response: components['schemas']['MarkCreateOkResponse'];
    };
    /** The created annotation's identity. */
    MarkCreateOkResponse: {
      annotationId: components['schemas']['AnnotationId'];
    };
    /**
     * Raw annotation creation intent — bus handler assembles the W3C annotation
     */
    MarkCreateRequest: {
      resourceId: components['schemas']['ResourceId'];
      request: components['schemas']['CreateAnnotationRequest'];
    };
    /**
     * The payload of `mark:delegate-timeout`, a client-local signal: a
     * delegated job went silent past its deadline, with no progress, no
     * completion and no `job:fail`. A real job failure arrives as `job:fail`
     * and never produces this.
     */
    MarkDelegateTimeoutEvent: {
      /** The resource the job was delegated for. */
      resourceId: components['schemas']['ResourceId'];
      motivation: components['schemas']['Motivation'];
    };
    /** Bus command to delete an annotation. */
    MarkDeleteCommand: {
      /**
       * Authenticated user's DID, injected by the /bus/emit gateway. Clients do
       * not set this.
       */
      _userId?: components['schemas']['UserId'];
      annotationId: components['schemas']['AnnotationId'];
      resourceId?: components['schemas']['ResourceId'];
    };
    /**
     * Success reply after deleting an annotation, matched to the originating
     * command by correlationId.
     */
    MarkDeleteOk: {
      /** The deleted annotation's identity. */
      response: {
        annotationId: components['schemas']['AnnotationId'];
      };
    };
    /**
     * A `mark` job's worker says the job is complete, with what a `mark` job
     * reports.
     */
    MarkJobCompleteCommand: {
      /**
       * Authenticated user's DID, injected by the /bus/emit gateway. Clients do
       * not set this.
       */
      _userId?: components['schemas']['UserId'];
      resourceId: components['schemas']['ResourceId'];
      jobId: components['schemas']['JobId'];
      jobType: 'mark';
      /**
       * Which attempt produced this event, 1-based (a first run is 1). ALWAYS
       * present: the queue re-runs a failed job silently, so an operator
       * reading progress or a terminal record has no other way to tell a re-run
       * from a first run — and provider spend, already counted in
       * xynolog_inference_tokens_total, cannot be attributed to a repeated
       * document without it. Stated rather than inferred from absence, because
       * 'attempt 1' is a fact the emitter always knows.
       */
      attempt?: number;
      result?: components['schemas']['MarkJobResult'];
      durability?: components['schemas']['DurabilityEvidence'];
    };
    /** Create a `mark` job: annotate one resource for one motivation. */
    MarkJobCreateCommand: {
      /**
       * The emitter's verified DID, injected by the gateway. Clients do not set
       * this.
       */
      _userId?: components['schemas']['UserId'];
      /**
       * The emitter's roles, injected by the gateway when it has any. Clients
       * do not set this.
       */
      _roles?: string[];
      jobType: 'mark';
      /** The resource to annotate. */
      resourceId: components['schemas']['ResourceId'];
      params: components['schemas']['MarkJobParams'];
    };
    /**
     * What a `mark` job reports when it has done its work, whatever its
     * motivation.
     */
    MarkJobDone: {
      /**
       * What the model proposed, before anything was checked against the text.
       */
      found: number;
      /**
       * What the log holds: the annotations committed, after the ones that
       * could not be anchored were dropped and repeats were collapsed.
       */
      persisted: number;
      /**
       * How many of the proposed could not be anchored in the text. Absent
       * means none.
       */
      errors?: number;
      /**
       * The annotations persisted per category. A tagging job's; absent from
       * every other.
       */
      byCategory?: { [key: string]: number };
      /**
       * Total floor-accepted under-reported pieces across the job's units.
       * Absent means none — the per-unit evidence rides the terminal progress
       * frame's completedItems; this keeps the result self-describing without
       * the progress stream.
       */
      underReportedPieces?: number;
      /**
       * Pieces whose yield was to be checked against a count and was not: the
       * count failed, was cut off, or answered no count. What they found was
       * kept unchecked. Absent means none: every piece that was to be checked
       * was. A job whose provider checks no yield has none.
       */
      uncheckedPieces?: number;
    };
    /** `mark` jobs of one motivation. */
    MarkJobFilter: {
      jobType: 'mark';
      params: {
        motivation: components['schemas']['Motivation'];
      };
    };
    /**
     * The parameters of a `mark` job, told apart by `motivation`. Each
     * motivation takes its own parameters and no others: a parameter a job does
     * not take is refused where the job is created.
     */
    MarkJobParams:
      | components['schemas']['HighlightingJobParams']
      | components['schemas']['CommentingJobParams']
      | components['schemas']['AssessingJobParams']
      | components['schemas']['LinkingJobParams']
      | components['schemas']['TaggingJobParams'];
    /**
     * A pending `mark` job, announced with its parameters as it was created.
     */
    MarkJobQueuedEvent: {
      jobId: components['schemas']['JobId'];
      jobType: 'mark';
      /** The resource the job is about. */
      resourceId: components['schemas']['ResourceId'];
      /** The DID of the principal whose `job:create` created the job. */
      userId: components['schemas']['UserId'];
      params: components['schemas']['MarkJobParams'];
    };
    /**
     * What a `mark` job reports when it concludes without failing: its counts,
     * or a decline. Neither names its kind: a decline is the one with
     * `declined`.
     */
    MarkJobResult:
      | components['schemas']['MarkJobDone']
      | components['schemas']['JobDeclined'];
    /** Emitted when the user requests a new mark (annotation) on a resource */
    MarkRequestedEvent: {
      /**
       * The '@id' of the resource the mark belongs to (W3C target.source).
       * Routes the event to the right viewer/state unit when a host mounts many
       * viewers on one session.
       */
      source: components['schemas']['ResourceId'];
      /** One or more W3C selectors */
      selector: components['schemas']['AnnotationSelector'];
      motivation: components['schemas']['Motivation'];
    };
    /** Emitted when a mark is submitted with its annotation body */
    MarkSubmitEvent: {
      /**
       * The '@id' of the resource the mark belongs to (W3C target.source).
       * Routes the submit to the state unit bound to that resource — without
       * it, N mounted units each create the annotation (N copies on N
       * resources).
       */
      source: components['schemas']['ResourceId'];
      motivation: components['schemas']['Motivation'];
      /** One or more W3C selectors */
      selector: components['schemas']['AnnotationSelector'];
      /**
       * Optional body. Omit for annotations whose motivation alone is
       * meaningful (e.g. highlighting) or whose user-supplied content is empty
       * (e.g. an assessing annotation saved without comment text). Shape
       * matches Annotation.body.
       */
      body?: components['schemas']['AnnotationBodies'];
    };
    /** Bus command to unarchive a previously archived resource. */
    MarkUnarchiveCommand: {
      /**
       * Authenticated user's DID, injected by the /bus/emit gateway. Clients do
       * not set this.
       */
      _userId?: components['schemas']['UserId'];
      resourceId: components['schemas']['ResourceId'];
      /**
       * Optional: where the resource's bytes are expected to be. When present
       * the handler VERIFIES the file exists and fails loudly if it does not,
       * rather than succeeding as a no-op. An instruction, not a copy of the
       * stored fact (that lives on the primary Representation). Working-tree
       * URI, only file:// is supported.
       */
      storageUri?: string;
    };
    /** Bus command to update an annotation's body with patch operations. */
    MarkUpdateBodyCommand: {
      /**
       * Authenticated user's DID, injected by the /bus/emit gateway. Clients do
       * not set this.
       */
      _userId?: components['schemas']['UserId'];
      annotationId: components['schemas']['AnnotationId'];
      resourceId: components['schemas']['ResourceId'];
      operations: components['schemas']['BodyOperation'][];
    };
    /** Bus command to replace the entity types on a resource. */
    MarkUpdateEntityTypesCommand: {
      resourceId: components['schemas']['ResourceId'];
      /**
       * Authenticated user's DID, injected by the /bus/emit gateway. Clients do
       * not set this.
       */
      _userId?: components['schemas']['UserId'];
      currentEntityTypes: string[];
      updatedEntityTypes: string[];
    };
    /**
     * Request to search the knowledge base's resources by text. The Librarian
     * answers: it matches the text lexically, and when nothing matches, by
     * meaning.
     */
    MatchResourcesRequest: {
      /** The text to search for. */
      search: string;
      archived?: boolean;
      entityType?: string;
      /**
       * How many of the resources the search finds are passed over before the
       * page begins.
       */
      offset?: number;
      /** The most resources a page has. */
      limit?: number;
    };
    /**
     * One page of the resources a text search found, and which kind of answer
     * it is.
     */
    MatchResourcesResponse: {
      resources: components['schemas']['ResourceDescriptor'][];
      /**
       * How many resources the search found in all, and not only on this page.
       */
      total: number;
      /**
       * How many of the resources the search found were passed over before this
       * page, as the request stated.
       */
      offset: number;
      /** The limit the search was made with. */
      limit: number;
      /**
       * What kind of answer this is: 'lexical' — the resources matched the
       * query text; 'semantic' — no lexical match existed, and these resources
       * discuss the query per the vector index. Required so every producer
       * labels its answer; a UI can render semantic results as a different kind
       * of page ('no title matches, but these documents discuss it').
       */
      matchKind: 'lexical' | 'semantic';
    };
    /** Result of searching resources by text */
    MatchResourcesResult: {
      response: components['schemas']['MatchResourcesResponse'];
    };
    /**
     * The payload of `match:search-failed`: a CommandError that names the
     * reference whose candidates could not be searched for.
     */
    MatchSearchFailed: components['schemas']['CommandError'] & {
      /** The reference the search was asked for. */
      referenceId: components['schemas']['AnnotationId'];
    };
    /**
     * Request payload sent on the match:search-request bus channel to find
     * candidate matches.
     */
    MatchSearchRequest: {
      /**
       * Resource ID the reference annotation belongs to. Used to scope result
       * events on the EventBus so the events-stream delivers them to
       * participants viewing this resource.
       */
      resourceId: components['schemas']['ResourceId'];
      /** Annotation ID of the reference to search candidates for */
      referenceId: components['schemas']['AnnotationId'];
      /** Gathered context for the reference annotation */
      context: components['schemas']['GatheredContext'];
      /** Maximum number of candidate results to return */
      limit?: number;
      /** Enable semantic similarity scoring in addition to keyword matching */
      useSemanticScoring?: boolean;
    };
    /** Search results payload emitted on match:search-results SSE channel. */
    MatchSearchResult: {
      referenceId: components['schemas']['AnnotationId'];
      /** The scored candidates, best first. */
      response: components['schemas']['ScoredResource'][];
    };
    MediaTokenRequest: {
      /** The resource ID to generate a media token for */
      resourceId: components['schemas']['ResourceId'];
    };
    MediaTokenResponse: {
      /**
       * Short-lived media token for use as ?token= query parameter on resource
       * URLs
       */
      token: string;
    };
    /**
     * A graph held in the memory of the one process that is given it: for a
     * test. It cannot be shared between processes, so a service that writes the
     * graph for another to read, or reads what another wrote, refuses it.
     */
    MemoryGraphConfig: {
      type: 'memory';
    };
    /**
     * A vector index held in the memory of the one process that is given it:
     * for a test. It cannot be shared between processes, so a service that
     * writes the index for another to search, or searches what another wrote,
     * refuses it.
     */
    MemoryVectorsConfig: {
      type: 'memory';
    };
    /**
     * Xynolog-supported W3C Web Annotation motivations -
     * https://www.w3.org/TR/annotation-vocab/#motivation
     */
    Motivation:
      'assessing' | 'commenting' | 'highlighting' | 'linking' | 'tagging';
    /** A graph kept in a Neo4j database. */
    Neo4jGraphConfig: {
      type: 'neo4j';
      /** Where the database is reached (`bolt://host:7687`). */
      uri: string;
      /** The user the service connects as. */
      username: string;
      /**
       * The environment variable holding that user's password. The password is
       * never a value here.
       */
      passwordEnv: string;
      /** Which of the server's databases holds the graph. */
      database: string;
    };
    /**
     * A graph kept in Amazon Neptune, asked in Gremlin. No service has been run
     * against one.
     */
    NeptuneGraphConfig: {
      type: 'neptune';
      /** The cluster's endpoint: its host name. */
      endpoint: string;
      /** The port its Gremlin endpoint listens on. */
      port: number;
    };
    /**
     * What registering a knowledge base takes: everything a registered one
     * holds but its id, which the client's list makes. It has a did, because
     * registering follows a sign-in: the knowledge base has already said what
     * it is.
     */
    NewKnowledgeBase: {
      /**
       * What a person reads the knowledge base as. Once the knowledge base has
       * described itself, its own name.
       */
      label: string;
      endpoint: components['schemas']['KbEndpoint'];
      /** The did the knowledge base reported of itself. */
      did: string;
      /**
       * The last time the knowledge base described itself. Absent until it has,
       * in an answer that carried this entry's did.
       */
      lastRead?: components['schemas']['KbRead'];
    };
    /** How well an OCR engine read the pixels. */
    OcrConfidence: {
      /** Mean per-word confidence, 0-100. */
      mean: number;
      /** Words the engine was unsure of. */
      lowConfidenceWords: number;
      totalWords: number;
    };
    /** An embedding model served by an Ollama. */
    OllamaEmbeddingConfig: {
      type: 'ollama';
      /** The model asked for, by the name the Ollama serves it under. */
      model: string;
      /** The address the Ollama's API is reached at (`http://host:11434`). */
      baseUrl: string;
    };
    /**
     * One Agent, or a non-empty list of them: the parties PROV-O and the Web
     * Annotation model let a resource or an annotation name in one place, as
     * one agent or several.
     */
    OneOrMoreAgents:
      components['schemas']['Agent'] | components['schemas']['Agent'][];
    /**
     * One string, or a non-empty list of them: a JSON-LD term that may take one
     * value or several.
     */
    OneOrMoreStrings: string | string[];
    /**
     * One URI, or a non-empty list of them: a JSON-LD term that may name one
     * resource or several.
     */
    OneOrMoreUris: string | string[];
    /**
     * The class a PDF is sorted into, which decides how its text is read.
     * smelter/extraction-cases.json states what each class is.
     */
    PdfClass: 'A' | 'B' | 'C' | 'D' | 'E' | 'F' | 'G';
    /**
     * One positioned text run. Coordinates are PDF points with the origin at
     * the bottom-left of the page, Y increasing upward; the flip to canvas
     * pixels happens in the browser.
     */
    PdfTextItem: {
      /**
       * Offset into AnchoredText.text, in Unicode code points from its start,
       * inclusive.
       */
      start: number;
      /**
       * Offset into AnchoredText.text, in Unicode code points from its start,
       * exclusive.
       */
      end: number;
      /** 1-indexed page number. */
      page: number;
      x: number;
      y: number;
      width: number;
      height: number;
    };
    /**
     * `p-<scope>-<sequenceNumber>` — the id of a persisted event delivered on a
     * scoped subscription. Resumable: send it back as that scope's
     * `lastEventId`. Stable across connections, so a client dedups by it.
     */
    PersistedEventId: string;
    /**
     * Bus command saying what a principal is called. The gateway emits it when
     * a principal ACTS, carrying the display name it just verified on its
     * token; a principal may also emit it itself, for itself, which is how an
     * agent, whose token carries no name, says what it is called. Either way
     * the gateway stamps `_userId` with the sender's verified DID, so a
     * principal names only itself. The Stower persists it as
     * principal:profiled, and only when the name differs from the latest one
     * recorded for that DID — so the log holds one line per name a principal
     * has had, not one per act. A name is a fact ABOUT an identity, never part
     * of the record of an act: no artifact carries it, and readers resolve it
     * from the profiles projection. Emitted for a person and for an agent
     * alike; never for a request that merely reads.
     */
    PrincipalProfileCommand: {
      /**
       * The principal's DID, injected by the /bus/emit gateway from the
       * verified token. Clients do not set this.
       */
      _userId?: components['schemas']['UserId'];
      /**
       * The display name: from the issuer's `name` claim, as verified on the
       * token that carried an act, or what the principal said of itself. A
       * token with no name produces no command from the gateway — the issuer is
       * where a person's name is set, and absence is recorded as absence.
       */
      name: string;
    };
    /**
     * Payload for principal:profiled — what this principal is called, as the
     * issuer's verified `name` claim said or as the principal said of itself,
     * recorded once per change (system-level, no resourceId). The event's
     * `userId` is the principal's DID; this payload is the fact about it.
     * Provenance never reads it: every artifact joins on the DID alone, and
     * this is projected into profiles.json for readers to resolve against. Two
     * lines for one DID mean the name changed, and the timestamps say when —
     * which is why no artifact ever had to freeze a copy.
     */
    PrincipalProfiledPayload: {
      /**
       * The display name as of this event: from the issuer's verified `name`
       * claim, or what the principal said of itself.
       */
      name: string;
    };
    /**
     * What a principal last said it is called, and when: the profile a
     * `principal:profiled` event gives.
     */
    Profile: {
      /** The name the principal last gave. */
      name: string;
      /** The timestamp of the event that gave it. */
      since: string;
    };
    /**
     * What the principals of a knowledge base are called: the file
     * `projections/__system__/profiles.json` under the state directory, the sum
     * of the `principal:profiled` events. The Archivist writes it; the
     * Archivist and the Librarian read it to name the principals a reply
     * mentions. Written as JSON indented by two spaces.
     */
    ProfilesProjection: {
      /** Each principal's current profile, keyed by its DID. */
      profiles: { [key: string]: components['schemas']['Profile'] };
    };
    /**
     * OAuth 2.0 Protected Resource Metadata (RFC 9728): which authorization
     * server this knowledge base trusts, served at
     * /.well-known/oauth-protected-resource so a client — the Browser, an MCP
     * client — learns where to send a user to sign in without configuration. A
     * 401 from any protected route points here in its WWW-Authenticate
     * challenge.
     */
    ProtectedResourceMetadata: {
      /**
       * This knowledge base's resource identifier: its did:web identity
       * resolved to an https URL (did:web:example.github.io:my-kb identifies
       * https://example.github.io/my-kb). This is the exact value a token's aud
       * claim must carry. It is an identifier, not an address — nothing
       * dereferences it, and a knowledge base reached over http in local
       * development still names itself by the https form, which is what makes
       * the value stable across every host, port and proxy it is reached
       * through.
       */
      resource: string;
      /**
       * Issuer identifiers whose tokens this resource accepts — the configured
       * identity issuer.
       */
      authorization_servers: string[];
      /**
       * How a bearer token reaches this resource: the Authorization header
       * only.
       */
      bearer_methods_supported: 'header'[];
      /** The knowledge base's name, for a client's sign-in prompt. */
      resource_name?: string;
    };
    /**
     * A vector index kept in a Qdrant server, asked over its REST API with a
     * token.
     */
    QdrantVectorsConfig: {
      type: 'qdrant';
      /** The server's host. */
      host: string;
      /** The port its REST API listens on. */
      port: number;
      /**
       * The environment variable holding the token the service presents to the
       * server on every request, which says what of the index it may read and
       * write. The token is never a value here.
       */
      tokenEnv: string;
    };
    /**
     * `e-<channel>:<correlationId>` — the id of a frame that carries a
     * correlationId. Deterministic: the same reply has the same id on every
     * connection, so a copy arriving on two connections (a reconnect overlap,
     * or a replay of a retained reply) dedups. Never a resumption watermark.
     */
    ReplyEventId: string;
    /**
     * A specific, byte-addressable rendition of a resource
     * (file/asset/variant).
     */
    Representation: {
      /** Stable ID for this representation. */
      '@id'?: string;
      /** Type(s), e.g., schema:MediaObject. */
      '@type'?: components['schemas']['OneOrMoreStrings'];
      /** MIME/media type (e.g., text/markdown, image/png). */
      mediaType: string;
      /**
       * Working-tree URI identifying where this rendition's bytes live. Only
       * file:// is supported (e.g. file://docs/overview.md). The single home of
       * the storage location: maintained across moves (yield:moved relocates
       * it), absent when the resource has no stored bytes.
       */
      storageUri?: string;
      filename?: string;
      /** Size of the payload in bytes. */
      byteSize?: number;
      /**
       * The SHA-256 of the bytes, as 64 lower-case hexadecimal digits with
       * nothing before them. Whatever compares the checksums of two
       * representations compares this text.
       */
      checksum?: string;
      /** Compression/transfer encoding if applicable. */
      encoding?: string;
      /** IETF BCP 47 language tag (e.g., en, es-ES). */
      language?: string;
      /** Pixels (images/video). */
      width?: number;
      /** Pixels (images/video). */
      height?: number;
      /** Seconds (audio/video). */
      duration?: number;
      created?: string;
      modified?: string;
      /**
       * Profile/shape the bytes conform to (e.g., a JSON profile or SVG
       * profile).
       */
      conformsTo?: components['schemas']['OneOrMoreUris'];
      tags?: string[];
      /**
       * Semantics of this rendition relative to the resource (e.g., original,
       * thumbnail, preview, derived).
       */
      rel?:
        | 'original'
        | 'thumbnail'
        | 'preview'
        | 'optimized'
        | 'derived'
        | 'other';
    } & { [key: string]: unknown };
    /** Payload for yield:representation-added domain event */
    RepresentationAddedPayload: {
      representation: components['schemas']['Representation'];
    };
    /**
     * The Archivist's 404 for a resource's bytes: an ErrorResponse whose `code`
     * says which half of the lookup failed — `resource` when the record holds
     * no such resource, `representation` when it holds the resource but not its
     * bytes. Each reader answers the two differently.
     */
    RepresentationNotFound: components['schemas']['ErrorResponse'] & {
      code: 'resource' | 'representation';
    };
    /** Payload for yield:representation-removed domain event */
    RepresentationRemovedPayload: {
      /** Checksum of the representation to remove */
      checksum: string;
    };
    /** The annotations on one resource, as its materialized view holds them. */
    ResourceAnnotations: {
      resourceId: components['schemas']['ResourceId'];
      /**
       * Each annotation as the `mark:added` event that recorded it carried it,
       * with the body changes recorded since applied. In the order they were
       * first recorded.
       */
      annotations: components['schemas']['Annotation'][];
      /** How many of the resource's events the view has applied. */
      version: number;
      /**
       * The timestamp of the last event applied; the empty string before any.
       */
      updatedAt: string;
    };
    /** Payload for mark:archived domain event */
    ResourceArchivedPayload: {
      reason?: string;
    };
    /** Payload for yield:cloned domain event */
    ResourceClonedPayload: {
      name: string;
      format: components['schemas']['ContentFormat'];
      contentChecksum: string;
      contentByteSize?: number;
      /**
       * Where the clone's bytes are, on the resource's primary Representation —
       * the same single home `yield:created` writes to.
       */
      storageUri?: string;
      parentResourceId: components['schemas']['ResourceId'];
      entityTypes?: string[];
      language?: string;
      creator?: components['schemas']['Agent'];
      /**
       * PROV-O wasAttributedTo, derived at write time: the cloner alone. The
       * value the resource view carries.
       */
      wasAttributedTo?: components['schemas']['OneOrMoreAgents'];
    };
    /** Payload for yield:created domain event */
    ResourceCreatedPayload: {
      name: string;
      format: components['schemas']['ContentFormat'];
      /** SHA-256 of content */
      contentChecksum: string;
      contentByteSize?: number;
      entityTypes?: string[];
      /**
       * The creating instruction's URI, recorded on the event. Append-only, so
       * this value never changes — the LOCATION the projection serves is
       * maintained across moves and lives on the resource's primary
       * Representation, relocated by yield:moved. Optional: a resource may have
       * no bytes. Working-tree URI, only file:// is supported (e.g.
       * file://docs/overview.md).
       */
      storageUri?: string;
      language?: string;
      isDraft?: boolean;
      /**
       * The job this resource was made in fulfilment of, when its create cited
       * one. A write that cites the same job on this resource, by the one who
       * made it, is attributed to that job's requester: the `creator` here.
       */
      jobId?: components['schemas']['JobId'];
      /**
       * What this resource was generated from: the resource, and the annotation
       * on it when the generation was for one. The resource's descriptor names
       * the resource as `wasDerivedFrom`.
       */
      generatedFrom?: {
        resourceId: components['schemas']['ResourceId'];
        annotationId?: components['schemas']['AnnotationId'];
      };
      generationPrompt?: string;
      generator?: components['schemas']['OneOrMoreAgents'];
      creator?: components['schemas']['Agent'];
      /**
       * PROV-O wasAttributedTo, derived at write time from `creator` and the
       * executor: both parties when they differ, one when they are the same.
       * The value the resource view carries; readers do not re-derive it.
       */
      wasAttributedTo?: components['schemas']['OneOrMoreAgents'];
    };
    /**
     * Metadata about a resource (1:1 with its URI). JSON-LD subject is @id.
     * Link to concrete bytes via representations.
     */
    ResourceDescriptor: {
      /** JSON-LD context; URI, object, or array of these. */
      '@context':
        | string
        | { [key: string]: unknown }
        | (string | { [key: string]: unknown })[];
      /** The id of the resource being described. */
      '@id': components['schemas']['ResourceId'];
      /** Type(s) of the resource (IRIs/CURIEs via @context). */
      '@type'?: components['schemas']['OneOrMoreStrings'];
      name: string;
      description?: string;
      /** Persistent identifiers (e.g., DOI, URN). */
      identifier?:
        | string
        | string[]
        | ({
            '@id'?: string;
            value?: string;
            scheme?: string;
          } & { [key: string]: unknown });
      /** Topics (IRIs or strings). */
      about?: components['schemas']['OneOrMoreStrings'];
      /** Equivalent/authoritative references. */
      sameAs?: string[];
      isPartOf?: string[];
      hasPart?: string[];
      license?: string;
      version?: string;
      dateCreated?: string;
      dateModified?: string;
      /**
       * W3C PROV: the resource, or resources, this one was derived from, each
       * by its id
       */
      wasDerivedFrom?:
        | components['schemas']['ResourceId']
        | components['schemas']['ResourceId'][];
      /**
       * W3C PROV — every party responsible for this resource, derived by the
       * knowledge base at creation from verified identities: `[requester,
       * generator]` for a resource a job produced, collapsed to the one agent
       * when the requester produced it. Never accepted from an emitter.
       */
      wasAttributedTo?: components['schemas']['OneOrMoreAgents'];
      /**
       * Software peer that produced this resource (W3C Web Annotation model).
       * Its identity is the verified emitter of the create; the parameters are
       * the producer's to state.
       */
      generator?: components['schemas']['OneOrMoreAgents'];
      /** Profile/shape URI this resource description conforms to. */
      conformsTo?: components['schemas']['OneOrMoreUris'];
      /** Convenience set summarizing media types across representations. */
      availableFormats?: string[];
      /** Managed or referenced byte-level renditions of this resource. */
      representations:
        | components['schemas']['Representation']
        | components['schemas']['Representation'][];
      /** Application-specific: Whether this resource is archived */
      archived?: boolean;
      /** Application-specific: Entity types for this resource */
      entityTypes?: string[];
      /** Application-specific: Whether this resource is a draft */
      isDraft?: boolean;
      /** Application-specific: ID of annotation that triggered generation */
      sourceAnnotationId?: components['schemas']['AnnotationId'];
      /** Application-specific: ID of source resource for clones/derivatives */
      sourceResourceId?: components['schemas']['ResourceId'];
      /**
       * Original URI from a source knowledge base when this resource was
       * imported
       */
      originatedFrom?: string;
    } & { [key: string]: unknown };
    /**
     * A client-local notice that a command on a resource failed, for a UI to
     * show: the payload of `mark:create-error`, `mark:delete-error` and
     * `bind:body-error`. Emitted by the caller that awaited the command, which
     * knows whose command failed on which resource. The `*-failed` wire replies
     * are correlation plumbing and are not for this.
     */
    ResourceErrorEvent: {
      /** The resource the command addressed. */
      resourceId: components['schemas']['ResourceId'];
      /** Human-readable error message. */
      message: string;
    };
    /**
     * A resource's id: a name, never the resource's URI or a path. 1 to 128 of
     * the letters `A`–`Z` and `a`–`z`, the digits, `_` and `-`. It is one
     * segment of a URL and one name in a file system, and it is held to that
     * wherever it enters: a gateway refuses a payload that carries anything
     * else. How one is made is no part of the rule. `__system__` is the one
     * that names no resource: the scope events about the knowledge base itself
     * are logged under.
     */
    ResourceId: string & { readonly __brand: 'ResourceId' };
    /** Payload for yield:moved domain event */
    ResourceMovedPayload: {
      /** Previous file:// URI */
      fromUri: string;
      /** New file:// URI */
      toUri: string;
    };
    /** Payload for mark:unarchived domain event (empty payload) */
    ResourceUnarchivedPayload: Record<string, never>;
    /** Payload for yield:updated domain event */
    ResourceUpdatedPayload: {
      /** SHA-256 of new content */
      contentChecksum: string;
      contentByteSize?: number;
    };
    /**
     * The multipart upload that creates a resource. A client sends it to the
     * gateway's `POST /resources`; the gateway forwards it untouched to the
     * Archivist's `POST /resources`, which stores the bytes and records the
     * resource. One body, two hops.
     */
    ResourceUpload: {
      /** Human-readable resource name */
      name: string;
      /** Binary content */
      file: string;
      /**
       * Media type of the content (e.g. text/plain, text/markdown, image/png)
       */
      format: string;
      /**
       * Where the content lives (file://... for local). Required — the client
       * names the location; the server does not derive one.
       */
      storageUri: string;
      /** ISO 639-1 language code */
      language?: string;
      /** JSON-stringified array of entity type names */
      entityTypes?: string;
      /**
       * For AI-generated resources: the annotation that triggered generation.
       * Nested into generatedFrom.annotationId on the persisted event.
       */
      sourceAnnotationId?: components['schemas']['AnnotationId'];
      /**
       * For AI-generated resources: the source resource the generating
       * annotation lives on. Nested into generatedFrom.resourceId on the
       * persisted event.
       */
      sourceResourceId?: components['schemas']['ResourceId'];
      /** For AI-generated resources: the prompt that drove generation */
      generationPrompt?: string;
      /**
       * For AI-generated resources: JSON-stringified Agent naming the
       * model/worker that produced the content. Its identity must be the
       * uploading agent's own — the knowledge base refuses a generator naming
       * anyone else. `creator` and `wasAttributedTo` are never sent; the
       * knowledge base derives them from the cited job.
       */
      generator?: string;
      /**
       * The job this resource fulfils, when a worker is creating it. Forwarded
       * onto yield:create; the knowledge base derives who requested the
       * resource from the cited job's own events, and refuses a worker-role
       * create that cites none. Absent for a person's own upload.
       */
      jobId?: components['schemas']['JobId'];
      /** 'true' or 'false' — whether the resource is a draft */
      isDraft?: string;
      /**
       * A clone token from `yield:clone-token-requested`. With it, the resource
       * is created as a clone of the token's source, inheriting its entity
       * types; `language`, `entityTypes` and the generation fields are then not
       * read.
       */
      cloneToken?: string;
      /**
       * With `cloneToken`: 'true' archives the source once the clone exists.
       */
      archiveOriginal?: string;
    };
    /**
     * A resource's materialized view: the file the Archivist writes at
     * `resources/<ab>/<cd>/<resourceId>.json` under the knowledge base's state
     * directory, and every reader of that file reads. It is what the resource's
     * events add up to, and is rebuilt from the event log whenever it is
     * missing. Written as JSON indented by two spaces, by writing a sibling
     * temporary file and renaming it onto the path, so a reader sees a whole
     * document or none.
     */
    ResourceView: {
      resource: components['schemas']['ResourceDescriptor'];
      annotations: components['schemas']['ResourceAnnotations'];
      /**
       * The sequence number of the last event applied. A graph read that
       * follows a write waits for the graph projection to reach it.
       */
      lastSequence: number;
    };
    /**
     * A resource returned by a search, carrying its relevance score and the
     * reason it matched.
     */
    ScoredResource: components['schemas']['ResourceDescriptor'] & {
      /**
       * Relevance score assigned by the matcher; higher is a better candidate.
       */
      score?: number;
      /** Human-readable reason for the match. */
      matchReason?: string;
    };
    /**
     * One W3C selector: a way of finding a segment of a resource. Tell them
     * apart by `type`, which is required on each and single-valued.
     */
    Selector:
      | components['schemas']['TextPositionSelector']
      | components['schemas']['TextQuoteSelector']
      | components['schemas']['SvgSelector']
      | components['schemas']['FragmentSelector'];
    SemanticMatch: {
      /** The chunk text that matched */
      text: string;
      /** Source resource ID */
      resourceId: components['schemas']['ResourceId'];
      /**
       * The source resource's display name, resolved from its view at gather
       * time. Required: a match card must name its source, and corpus matches
       * routinely come from outside the graph neighborhood, so there is no node
       * to borrow a name from. A match whose source no longer resolves to a
       * view is dropped by the producer rather than served nameless.
       */
      resourceName: string;
      /** Source annotation ID, if the match is from an annotation */
      annotationId?: components['schemas']['AnnotationId'];
      /** Cosine similarity score (0-1) */
      score: number;
      /** Entity types on the matched passage */
      entityTypes?: string[];
      /**
       * True when this passage's text was recognized from pixels (OCR of a
       * scanned page) rather than read from the document. Absent means read
       * directly — the common case — so the flag is only present where it
       * changes how the text should be trusted. It travels with the passage
       * because a consumer receives the chunk with no document attached and
       * cannot recompute how the text was obtained.
       */
      machineRead?: boolean;
    };
    /** The host and port a service listens at. */
    ServiceAddress: {
      host: string;
      port: number;
    };
    /** The identity provider a service's account signs in at, by its issuer. */
    ServiceIdentity: {
      /** The issuer URL, exactly as tokens carry it in `iss`. */
      issuer: string;
    };
    /**
     * A participant opened a live connection to this KB — an SSE stream on
     * /bus/subscribe. Presence is CONNECTION lifecycle, not login: a token can
     * be minted and sit unused, so what this reports is that someone is
     * WATCHING. One person with two tabs produces two of these, which is why
     * connectionId is required — the DID alone cannot tell two connections
     * apart, and a consumer that counts DIDs will undercount viewers.
     */
    SessionJoinedEvent: {
      /**
       * DID of the authenticated principal on that connection. A person or a
       * software agent — the bus does not distinguish.
       */
      participant: components['schemas']['UserId'];
      /**
       * Identifies this connection for its lifetime. The matching session:left
       * carries the same value.
       */
      connectionId: string;
    };
    /**
     * A participant's live connection to this KB ended — the SSE stream
     * aborted. Carries the same connectionId as the session:joined that opened
     * it, so a consumer tracking who is present can retire the right connection
     * rather than assuming one per participant.
     */
    SessionLeftEvent: {
      /** DID of the authenticated principal on that connection. */
      participant: components['schemas']['UserId'];
      /** The connectionId announced by the matching session:joined. */
      connectionId: string;
    };
    /** Emitted when the hover delay setting changes */
    SettingsHoverDelayChangedEvent: {
      hoverDelayMs: number;
    };
    /** Emitted when the UI locale setting changes */
    SettingsLocaleChangedEvent: {
      locale: string;
    };
    /** Emitted when the UI theme setting changes */
    SettingsThemeChangedEvent: {
      theme: 'light' | 'dark' | 'system';
    };
    /**
     * Bus command to rebuild anchored-text artifacts by re-running extraction —
     * every geometry-capable resource when resourceId is absent, one resource
     * when present. Served by the Smelter, serialized (each unit can be a
     * multi-second OCR pass), and never destructive: nothing is deleted first,
     * stale entries are simply overwritten. Re-anchoring makes zero embedding
     * calls — the vectors are already correct; only the derived map is re-made.
     * Partial completion replies failed, with counts: a rebuild that quietly
     * skipped resources would present exactly like a document with no text.
     */
    SmeltRebuildAnchorsCommand: {
      /**
       * When present, re-anchor only this resource; otherwise every
       * geometry-capable resource in the catalog.
       */
      resourceId?: components['schemas']['ResourceId'];
      /**
       * Authenticated user's DID, injected by the /bus/emit gateway. Clients do
       * not set this.
       */
      _userId?: components['schemas']['UserId'];
    };
    /**
     * The payload of `smelt:settled`: the Smelter's decision for one resource's
     * content, keyed by the checksum of the bytes it inspected. `indexed`: the
     * content is in the vector index. `skipped`: it declined, and `reason` says
     * why.
     */
    SmeltSettled: {
      /** The resource whose content was inspected. */
      resourceId: components['schemas']['ResourceId'];
      /** The checksum of the bytes inspected. */
      contentChecksum: string;
      outcome: 'indexed' | 'skipped';
      /** Why the content was skipped. */
      reason?:
        | 'no-extractor'
        | 'empty'
        | 'no-text-layer'
        | 'encrypted'
        | 'corrupt'
        | 'too-large';
    };
    /**
     * Everything a Smelter reads at boot: nothing in it is defaulted by the
     * Smelter. Whoever starts a Smelter writes it, from the knowledge base's
     * stack documents, and the Smelter reads it from the path its `--config`
     * flag names. This schema is the contract, and a Smelter needs no launcher.
     * Started without `--config`, or with a path that names no file, the
     * Smelter refuses to start and says which. No secret is a value here: an
     * embedding provider's key is named by the environment variable that holds
     * it, and the Smelter's own service account is `XYNOLOG_OIDC_CLIENT_ID` and
     * `XYNOLOG_OIDC_CLIENT_SECRET` in its environment. A document that does not
     * validate is refused at boot, naming each failing field.
     */
    SmelterConfig: {
      kb: components['schemas']['KbIdentity'];
      /** The URL the Smelter reaches the gateway at: its route to the bus. */
      gatewayUrl: string;
      /** The issuer the Smelter's service account signs in at. */
      identity: components['schemas']['ServiceIdentity'];
      /**
       * Where the Archivist listens. The Smelter reads a resource's bytes from
       * it, and keeps the anchored-text store there, as its service account.
       */
      archivist: components['schemas']['ServiceAddress'];
      embedding: components['schemas']['EmbeddingConfig'];
      vectors: components['schemas']['VectorsConfig'];
      /**
       * The two numbers a text is cut by before it is embedded, both in tokens,
       * a token being taken as four code points.
       */
      chunking: {
        /** The size of a chunk. */
        chunkSize: number;
        /** How much of a chunk the next one repeats. */
        overlap: number;
      };
      /**
       * How many PDFs the Smelter works on at once. Each one under way holds
       * its bytes, a page of a scan in pixels beside the OCR process reading
       * it, and its text and vectors, so whoever starts a Smelter sizes this
       * with the memory it gives it. Every other resource is indexed beside
       * them.
       */
      pdfsAtOnce: number;
      cursorsPath: components['schemas']['CursorsPath'];
      /** The port the Smelter answers `/health` on. */
      port: number;
      logLevel: components['schemas']['LogLevel'];
      logFormat: components['schemas']['LogFormat'];
    };
    SpecificResource: {
      type: 'SpecificResource';
      /** The id of the resource this body leads to */
      source: components['schemas']['ResourceId'];
      /** Why this body is included */
      purpose?: components['schemas']['BodyPurpose'];
    };
    StatusResponse: {
      status: string;
      version: string;
      features: {
        semanticContent: string;
        collaboration: string;
      };
      message: string;
      authenticatedAs?: string;
    };
    /**
     * One entry of the storage-uri index: the file
     * `projections/storage-uri/<ab>/<cd>/<sha256 of the URI, hex>.json` under
     * the state directory. It answers which resource's content is at a place in
     * the working tree. Written as JSON indented by two spaces, `uri` first.
     */
    StorageUriEntry: {
      /**
       * The `file://` URI of a place in the working tree, relative to the
       * knowledge base's root.
       */
      uri: string;
      resourceId: components['schemas']['ResourceId'];
    };
    /**
     * A persisted domain event with metadata. Flat shape — event fields and
     * metadata are peers.
     */
    StoredEventResponse: {
      /** Unique event ID (UUID) */
      id: string;
      /** Event type (flow verb name, e.g. mark:added) */
      type: string;
      /** When the event occurred */
      timestamp: string;
      /** DID of the user who triggered the event */
      userId: components['schemas']['UserId'];
      /** Resource this event affects (absent for system events) */
      resourceId?: components['schemas']['ResourceId'];
      /** Event schema version */
      version: number;
      /** Event-type-specific payload */
      payload: { [key: string]: unknown };
      metadata: components['schemas']['EventMetadata'];
    };
    /**
     * Base MIME types (no parameters) admitted by Xynolog. Membership is the
     * create/yield gate — every member is storable, nameable, and uploadable.
     * What more the system can do with a type (render, annotate, extract text,
     * author) is curated per type in @xynolog/core's media-type registry, which
     * is keyed by this enum.
     */
    SupportedMediaType:
      | 'text/plain'
      | 'text/markdown'
      | 'text/html'
      | 'text/css'
      | 'text/csv'
      | 'text/xml'
      | 'application/json'
      | 'application/xml'
      | 'application/yaml'
      | 'application/x-yaml'
      | 'application/pdf'
      | 'application/msword'
      | 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'
      | 'application/vnd.ms-excel'
      | 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
      | 'application/vnd.ms-powerpoint'
      | 'application/vnd.openxmlformats-officedocument.presentationml.presentation'
      | 'application/zip'
      | 'application/gzip'
      | 'application/x-tar'
      | 'application/x-7z-compressed'
      | 'application/octet-stream'
      | 'application/wasm'
      | 'image/png'
      | 'image/jpeg'
      | 'image/gif'
      | 'image/webp'
      | 'image/svg+xml'
      | 'image/bmp'
      | 'image/tiff'
      | 'image/x-icon'
      | 'video/mp4'
      | 'video/mpeg'
      | 'video/webm'
      | 'video/ogg'
      | 'video/quicktime'
      | 'video/x-msvideo'
      | 'audio/mpeg'
      | 'audio/wav'
      | 'audio/ogg'
      | 'audio/webm'
      | 'audio/aac'
      | 'audio/flac'
      | 'text/javascript'
      | 'application/javascript'
      | 'text/x-typescript'
      | 'application/typescript'
      | 'text/x-python'
      | 'text/x-java'
      | 'text/x-c'
      | 'text/x-c++'
      | 'text/x-csharp'
      | 'text/x-go'
      | 'text/x-rust'
      | 'text/x-ruby'
      | 'text/x-php'
      | 'text/x-swift'
      | 'text/x-kotlin'
      | 'text/x-shell'
      | 'font/woff'
      | 'font/woff2'
      | 'font/ttf'
      | 'font/otf';
    SvgSelector: {
      type: 'SvgSelector';
      /** SVG markup defining the region (must include xmlns attribute) */
      value: string;
    };
    /**
     * A single category within a tag schema (e.g. 'Issue' in IRAC,
     * 'distinguished' in legal-citation-treatment). Each category carries
     * methodology-bound semantics: a name, a description, and examples used in
     * the LLM prompt.
     */
    TagCategory: {
      name: string;
      description: string;
      examples: string[];
    };
    /**
     * A structural-analysis schema (e.g. legal-irac, scientific-imrad,
     * argument-toulmin). Defines a methodology framework as an id, name,
     * description, domain hint, and an ordered list of categories. KBs and
     * their skills register schemas with the runtime registry via
     * `frame.addTagSchema(...)` at session start.
     */
    TagSchema: {
      id: string;
      name: string;
      description: string;
      /**
       * Free-form domain hint (e.g. 'legal', 'scientific', 'general'). Used in
       * the LLM prompt to tune the model's analysis voice. KB authors choose.
       */
      domain: string;
      tags: components['schemas']['TagCategory'][];
    };
    /**
     * Payload for frame:tag-schema-added domain event (system-level, no
     * resourceId — fan-out is global to the KB).
     */
    TagSchemaAddedPayload: {
      schema: components['schemas']['TagSchema'];
    };
    /**
     * The knowledge base's tag schemas: the file
     * `projections/__system__/tagschemas.json` under the state directory, the
     * sum of the `frame:tag-schema-added` events. Written as JSON indented by
     * two spaces.
     */
    TagSchemasProjection: {
      /**
       * Every tag schema added, sorted by `id`. A schema added again under an
       * `id` replaces the one held.
       */
      tagSchemas: components['schemas']['TagSchema'][];
    };
    /**
     * What a tagging job takes: passages of the resource are marked with
     * categories of one tag schema.
     */
    TaggingJobParams: {
      motivation: 'tagging';
      /** The tag schema to tag by. It is one the knowledge base registers. */
      schemaId: string;
      /** The categories of that schema to tag with. */
      categories: string[];
      /** The language the annotations' own text is written in. BCP 47. */
      language?: string;
      /** The language of the resource being read. BCP 47. */
      sourceLanguage?: string;
    };
    TextPositionSelector: {
      type: 'TextPositionSelector';
      /**
       * Offset into the resource's decoded text, exactly as decoded, in Unicode
       * code points from its start: where the selected text starts.
       */
      start: number;
      /**
       * Offset into the resource's decoded text, exactly as decoded, in Unicode
       * code points from its start: just past where the selected text ends.
       */
      end: number;
    };
    TextQuoteSelector: {
      type: 'TextQuoteSelector';
      exact: string;
      prefix?: string;
      suffix?: string;
    };
    TextualBody: {
      type: 'TextualBody';
      /** The text content (e.g., entity type name) */
      value: string;
      /** Why this body is included */
      purpose?: components['schemas']['BodyPurpose'];
      /** MIME type (defaults to text/plain) */
      format?: string;
      /** BCP 47 language tag */
      language?: string;
    };
    /**
     * The furthest a single unit got, and what it had counted when it got
     * there. A unit left partway is resumed from its cursor rather than redone.
     * A finished unit keeps its cursor: `next` at the length of the text,
     * `size` the size its last piece was cut at, and its final `found`,
     * `emitted` and `errors`, so that an attempt that skips the unit still
     * counts it. A cursor never says a unit is finished, wherever it stands:
     * `completedUnits` does. A unit is an entity type for a linking job, a
     * category for a tagging job, and the job's own motivation for every other
     * — which is why a unit-grain checkpoint alone is too coarse: those three
     * have exactly one unit, so nothing could be recorded until the whole
     * document was done.
     *
     * MERGE IS MONOTONE PER UNIT, not a union. `completedUnits` is a set and
     * converges under concurrent snapshots because a set only grows; a cursor
     * converges only if a stale snapshot can never move it backward.
     *
     * IT CARRIES THE UNIT'S RUNNING TALLIES TOO, and they are required. A
     * resumed unit counts only the chunks it actually runs, so without them a
     * retry's terminal record reports the remainder of the document as if it
     * were the whole — measured at a `found` of 19 where the document yielded
     * 25. The position and the tallies are ONE observation of the same
     * committed chunk; splitting them would let a resume take the saving and
     * still report a number nobody can trust.
     */
    UnitCursor: {
      /**
       * Unicode code points of the text consumed once the last COMMITTED chunk
       * completed — the resume position, and the length of the text for a unit
       * whose last chunk it was. Deliberately the chunk's `next`, never its
       * `at`: the checkpoint must not lead the log, so it records where a chunk
       * that is already durable ended, not where the in-flight one began.
       * Recording `at` would make a resume re-run the chunk it already paid
       * for.
       */
      next: number;
      /**
       * The token size that last committed chunk was cut at — the calibration
       * the attempt paid for over the chunks before it. A resume seeds from
       * this and then takes ONE adaptive step, as if the last outcome were a
       * failure, which it was: the job died. Seeding alone would re-cut the
       * failing piece identically; opening at the default would discard the
       * calibration.
       */
      size: number;
      /**
       * Items detection has returned for this unit through the last committed
       * chunk — the numerator a resumed attempt continues from rather than
       * restarting at zero. Counts what the model reported, before dedupe.
       */
      found: number;
      /**
       * Annotations actually committed for this unit through the last committed
       * chunk, after dedupe. With `found` and `errors` it is what the job's
       * terminal result reports, so a resumed unit seeds all three and its
       * record describes the whole document rather than one attempt's share.
       */
      emitted: number;
      /**
       * Items detection returned for this unit through the last committed chunk
       * that could not be anchored in the text. Carried with the other two
       * tallies so that a resumed job reports the whole document's, and not
       * only its last attempt's.
       */
      errors: number;
    };
    UpdateAnnotationBodyRequest: {
      /**
       * Resource ID containing the annotation (required for O(1) Layer 3
       * lookup)
       */
      resourceId: components['schemas']['ResourceId'];
      /** Array of body modification operations to apply */
      operations: components['schemas']['BodyOperation'][];
    };
    /**
     * The identity of whoever did something, a person or a software agent
     * alike: a DID (`did:web:<domain>:users:<subject>`,
     * `did:web:<domain>:agents:<subject>`), with no whitespace in it. Never a
     * name, an address, or a row in a table. What follows `did:` is not
     * constrained further: a subject is the issuer's, percent-encoded, and that
     * encoding leaves some punctuation as it is.
     */
    UserId: string & { readonly __brand: 'UserId' };
    /**
     * The authenticated principal, as this knowledge base names it.
     *
     * The `did` is the identity: it is what the bus stamps on every event, what
     * resource creation is attributed to, and what a client must compare
     * against to recognise its own work in the data. It is the only identifier:
     * a row id would appear nowhere else in the system and correlate with
     * nothing.
     *
     * The remaining fields exist to be displayed, and all of them come from the
     * token's own claims.
     */
    UserResponse: {
      /**
       * The authenticated principal's DID: `did:web:<domain>:agents:<subject>`
       * for an agent, whose token's `kind` claim is `agent`, and
       * `did:web:<domain>:users:<subject>` for a person, where the subject is
       * the issuer claim the knowledge base names its principals by
       * (`identity.subjectClaim`).
       */
      did: components['schemas']['UserId'];
      /**
       * The address the token carries, when it carries one: an agent's account
       * need not have one.
       */
      email: string | null;
      name: string | null;
      image: string | null;
      /**
       * The knowledge base's domain: the authority the principal is named
       * under.
       */
      domain: string;
    };
    /**
     * The vector index a service writes or searches, and what that kind of
     * index needs to be reached: one of the kinds `xynolog-vectors` has a store
     * for, told apart by `type`.
     */
    VectorsConfig:
      | components['schemas']['QdrantVectorsConfig']
      | components['schemas']['MemoryVectorsConfig'];
    /**
     * An embedding model served by Voyage AI. No service has been run against
     * Voyage itself.
     */
    VoyageEmbeddingConfig: {
      type: 'voyage';
      /** The model asked for, by Voyage's name for it. */
      model: string;
      /**
       * The whole address of Voyage's embeddings call
       * (`https://api.voyageai.com/v1/embeddings`).
       */
      endpoint: string;
      /**
       * The environment variable holding the Voyage API key. The key is never a
       * value here.
       */
      apiKeyEnv: string;
    };
    /**
     * The payload of `weave:applied`: the Weaver has applied a resource's
     * events to the graph up to this sequence number. Emitted after applying an
     * event, or a batch's last event.
     */
    WeaveApplied: {
      /** The resource whose events were applied. */
      resourceId: components['schemas']['ResourceId'];
      /** The resource-stream sequence of the last applied event. */
      sequenceNumber: number;
    };
    /**
     * Bus command to rebuild the graph projection from the event log — the
     * whole graph when resourceId is absent, one resource when present. Served
     * by the Weaver; replaces direct rebuild access, which does not survive the
     * Weaver's container split.
     */
    WeaveRebuildCommand: {
      /**
       * When present, rebuild only this resource; otherwise clear and rebuild
       * the entire graph.
       */
      resourceId?: components['schemas']['ResourceId'];
      /**
       * Authenticated user's DID, injected by the /bus/emit gateway. Clients do
       * not set this.
       */
      _userId?: components['schemas']['UserId'];
    };
    /**
     * Everything a Weaver reads at boot: nothing in it is defaulted by the
     * Weaver. The launcher writes it for the Weaver it starts, from the
     * knowledge base's stack documents, and the Weaver reads it from the path
     * its `--config` flag names (its image passes `/etc/xynolog/weaver.json`).
     * Whoever starts a Weaver another way writes the same document: this schema
     * is the contract, and a Weaver needs no launcher. Started without
     * `--config`, or with a path that names no file, the Weaver refuses to
     * start and says which. No secret is a value here: the graph database's
     * password is named by the environment variable that holds it, and the
     * Weaver's own service account is `XYNOLOG_OIDC_CLIENT_ID` and
     * `XYNOLOG_OIDC_CLIENT_SECRET` in its environment. A document that does not
     * validate is refused at boot, naming each failing field.
     */
    WeaverConfig: {
      kb: components['schemas']['KbIdentity'];
      /** The URL the Weaver reaches the gateway at: its route to the bus. */
      gatewayUrl: string;
      /** The issuer the Weaver's service account signs in at. */
      identity: components['schemas']['ServiceIdentity'];
      /**
       * Where the Archivist listens. The Weaver reads the record by position
       * from it, and a resource's annotations, as its service account.
       */
      archivist: components['schemas']['ServiceAddress'];
      graph: components['schemas']['GraphConfig'];
      cursorsPath: components['schemas']['CursorsPath'];
      /** The port the Weaver answers `/health` on. */
      port: number;
      logLevel: components['schemas']['LogLevel'];
      logFormat: components['schemas']['LogFormat'];
    };
    /**
     * Everything a worker reads at boot: nothing in it is defaulted by the
     * worker. The launcher writes it for the machine's worker, from the
     * knowledge bases on that worker's list: each local knowledge base as its
     * start places it, from its stack documents, and each added by `xynolog
     * worker kb add`, offered the engines of the local one it was added from.
     * The worker reads it from the path its `--config` flag names (its image
     * passes `/etc/xynolog/worker.json`). Whoever starts a worker another way
     * writes the same document: this schema is the contract, and a worker needs
     * no launcher. Started without `--config`, or with a path that names no
     * file, the worker refuses to start and says which. No secret is a value
     * here: a provider's key is named by the environment variable that holds
     * it, and the key the worker signs in with at every knowledge base is
     * `XYNOLOG_OIDC_CLIENT_KEY` in its environment, an RSA private key; each
     * knowledge base names the client that holds its public half there. A
     * document that does not validate is refused at boot, naming each failing
     * field.
     */
    WorkerConfig: {
      /**
       * The knowledge bases this worker does jobs for. At each it signs in,
       * confirms which knowledge base it reached and claims for its engines,
       * apart from every other: one knowledge base's trouble stops that
       * knowledge base's work alone (`contract/WORKER-SERVICE.md` § Knowledge
       * bases). No two name one `domain`, which the worker refuses at boot.
       */
      knowledgeBases: components['schemas']['WorkerKnowledgeBaseConfig'][];
      /**
       * The path of a model catalogue file: what each model of a provider can
       * take, for the providers whose own APIs do not say (`google`, `openai`,
       * `together`). A worker with an engine of one of those providers refuses
       * to start where the file cannot be read, and where it states nothing of
       * that engine's model. A worker with no such engine does not read it.
       */
      modelCatalogue: string;
      /** The port the worker answers `/health` on. */
      port: number;
      logLevel: components['schemas']['LogLevel'];
      logFormat: components['schemas']['LogFormat'];
    };
    /**
     * One engine a worker runs: which it is, the jobs the worker claims to do
     * with it, and where its provider is reached.
     */
    WorkerEngineConfig: {
      engine: components['schemas']['Engine'];
      /**
       * The jobs the worker claims to do with this engine, as a claim names
       * them (`job:claim`'s `accepts`): it claims with these filters and no
       * other.
       */
      jobs: components['schemas']['JobFilter'][];
      /** The address the provider's API is reached at. */
      baseUrl: string;
      /**
       * The environment variable holding the provider's API key, when the
       * provider requires one.
       */
      apiKeyEnv?: string;
    };
    /**
     * One engine at one knowledge base: which it is, the jobs it claims, and
     * what its claims can say of themselves (WORKER-CONTRACT V1).
     */
    WorkerEngineHealth: {
      engine: components['schemas']['Engine'];
      /** The jobs it claims, as its claims state them. */
      jobs: components['schemas']['JobFilter'][];
      /** When a `job:queued` last reached it, or null. */
      lastQueuedEventAt: string | null;
      /**
       * When it was last handed a job, or null. A claim answered with none
       * pending is not one.
       */
      lastClaimAt: string | null;
      /** When a job it held last settled, or null. */
      lastFinishedAt: string | null;
      /** When it was last active, or null. */
      lastActivityAt: string | null;
      /** The job it holds, or null. */
      activeJob: {
        jobId: components['schemas']['JobId'];
        type: components['schemas']['JobType'];
        /** When it was handed the job. */
        since: string;
      } | null;
      /** How many jobs it has completed since the service started. */
      jobsCompleted: number;
    };
    /**
     * The Worker service's health answer (WORKER-SERVICE H1). It answers only
     * once a knowledge base of its document is confirmed, so a 200 means it is
     * working somewhere.
     */
    WorkerHealth: {
      status: 'ok';
      /**
       * One entry for each of the document's `knowledgeBases`, in its order.
       */
      knowledgeBases: components['schemas']['WorkerKnowledgeBaseHealth'][];
    };
    /**
     * One knowledge base a worker does jobs for: which it is, where its gateway
     * is, the account the worker signs in as there, and the engines it offers
     * it. The worker signs in, confirms the knowledge base and claims at each
     * knowledge base apart from every other.
     */
    WorkerKnowledgeBaseConfig: {
      /**
       * The knowledge base's did:web domain, as it answers
       * `browse:kb-requested`: which knowledge base this is. The worker
       * confirms it there before it claims, and refuses a knowledge base that
       * answers another domain, or none.
       */
      domain: string;
      /**
       * The URL the worker reaches the knowledge base's gateway at: its route
       * to the bus and to a resource's bytes, and the only address of the
       * knowledge base it holds.
       */
      gatewayUrl: string;
      /**
       * Where the worker signs in for this knowledge base, and as which client.
       */
      identity: {
        /** The issuer URL, exactly as tokens carry it in `iss`. */
        issuer: string;
        /**
         * The client the issuer holds the public half of the worker's key on:
         * the worker's account at this knowledge base. It is also what the
         * worker says it is called there (`principal:profile`).
         */
        clientId: string;
      };
      /**
       * The engines the worker offers this knowledge base, and the jobs it does
       * with each: its own choice, on its own providers' keys. It claims each
       * engine's jobs there for it, so a job no engine here is used for is not
       * claimed at this knowledge base.
       */
      engines: components['schemas']['WorkerEngineConfig'][];
    };
    /**
     * One knowledge base the worker serves, as its health says it. `did` and
     * `engines` are there while it is `working`, and only then.
     */
    WorkerKnowledgeBaseHealth: {
      /** The entry's `domain`. */
      domain: string;
      /**
       * `starting`: signing in, opening its stream, confirming it, or waiting
       * to start again. `working`: confirmed, its engines claiming. `refused`:
       * refused, until the service is started again.
       */
      state: 'starting' | 'working' | 'refused';
      /** The agent's DID at this knowledge base, as its gateway named it. */
      did?: string;
      /** One entry for each of the entry's engines, in its order. */
      engines?: components['schemas']['WorkerEngineHealth'][];
    };
    /**
     * Bus command to create a cloned resource from a clone token. Bytes are
     * stored by the upload path BEFORE this command is emitted, because bytes
     * travel over HTTP and never over the bus — the command carries the storage
     * coordinates, never content.
     */
    YieldCloneCreateCommand: {
      /**
       * Authenticated user's DID, injected by the /bus/emit gateway. Clients do
       * not set this.
       */
      _userId?: components['schemas']['UserId'];
      token: string;
      name: string;
      /**
       * Where the caller already wrote the clone's bytes — an instruction, not
       * a copy of the stored fact (that lives on the primary Representation).
       * Bytes are stored through the byte door BEFORE this command is sent, so
       * this names an existing file. Working-tree URI, only file:// is
       * supported.
       */
      storageUri: string;
      contentChecksum: string;
      byteSize: number;
      format: components['schemas']['ContentFormat'];
      archiveOriginal?: boolean;
    };
    /** Success response after creating a cloned resource. */
    YieldCloneCreated: {
      response: components['schemas']['YieldedResource'];
    };
    /**
     * Command: stow an already-uploaded clone's bytes and append
     * `yield:cloned`.
     *
     * The INNER half of the clone flow. `yield:clone-create` reaches the
     * CloneTokenManager, which alone can validate the token and read the
     * source's entity types; it then emits this so the Stower — the only
     * appendEvent caller — writes the domain event.
     *
     * Distinct from `yield:create` because a clone is a distinct operation, not
     * a creation with an extra field. It REQUIRES a parent, and that
     * requirement is what a separate command expresses: an optional
     * `parentResourceId` on the create command could not say that a clone
     * without a parent is not a clone. `ResourceClonedPayload` requires it for
     * the same reason.
     *
     * Generated resources are NOT clones: they carry provenance in
     * `generatedFrom` and stay on `yield:create`.
     */
    YieldClonePersistCommand: {
      /**
       * Injected by the gateway from the authenticated principal; never
       * supplied by a wire caller.
       */
      _userId?: components['schemas']['UserId'];
      name: string;
      /**
       * The caller's instruction for WHERE the bytes are — the uploader wrote
       * them before emitting this. The stored location lives on the clone's
       * primary Representation, the one home of a storage URI.
       */
      storageUri: string;
      contentChecksum: string;
      byteSize: number;
      format: components['schemas']['ContentFormat'];
      language?: string;
      /**
       * Inherited from the source resource by the CloneTokenManager, which is
       * the only party that knows the token is valid.
       */
      entityTypes?: string[];
      /**
       * The resource this one is cloned FROM. Required: it is what makes this a
       * clone rather than a creation.
       */
      parentResourceId: components['schemas']['ResourceId'];
    };
    /**
     * Success reply after cloning a resource, matched to the originating
     * command by correlationId.
     */
    YieldClonePersistOk: {
      /** The clone's identity — a new resource, distinct from its parent. */
      response: components['schemas']['YieldedResource'];
    };
    /** Bus command to request cloning a resource using a clone token. */
    YieldCloneResourceRequest: {
      token: string;
    };
    /** Bus command to request a clone token for a resource. */
    YieldCloneTokenRequest: {
      resourceId: components['schemas']['ResourceId'];
    };
    /** Bus command to create a yielded resource in the knowledge base. */
    YieldCreateCommand: {
      /**
       * Authenticated user's DID, injected by the /bus/emit gateway. Clients do
       * not set this.
       */
      _userId?: components['schemas']['UserId'];
      /**
       * The emitter's capabilities (the token's `roles`), injected by the
       * /bus/emit gateway. Clients do not set this. An emitter carrying the
       * worker role must cite the job this resource fulfils in `jobId`; the
       * Stower refuses the create otherwise.
       */
      _roles?: string[];
      /**
       * The job this resource fulfils. Required when the emitter carries the
       * worker role; absent for self-initiated work (a person, or an agent
       * acting on its own). The knowledge base derives who requested this
       * resource from the cited job's own events — the emitter never says who
       * the work was for.
       */
      jobId?: components['schemas']['JobId'];
      name: string;
      /**
       * The caller's instruction for WHERE the bytes are — not a copy of the
       * stored fact. The stored location lives on the resource's primary
       * Representation (`Representation.storageUri`), which is its single home;
       * this field is the message that puts it there. Working-tree URI, only
       * file:// is supported (e.g. file://docs/overview.md).
       */
      storageUri: string;
      contentChecksum: string;
      byteSize: number;
      format: components['schemas']['ContentFormat'];
      language?: string;
      entityTypes?: string[];
      isDraft?: boolean;
      generatedFrom?: {
        resourceId?: components['schemas']['ResourceId'];
        annotationId?: components['schemas']['AnnotationId'];
      };
      generationPrompt?: string;
      /**
       * The Software peer that produced the content, when software did. Its
       * identity must be the emitter's own — the knowledge base refuses a
       * generator naming anyone else, and supplies it from the verified emitter
       * when omitted. `creator` and `wasAttributedTo` are never sent; the
       * knowledge base derives them from the emitter and the cited job.
       */
      generator?: components['schemas']['OneOrMoreAgents'];
    };
    /**
     * Success reply after creating a yielded resource, matched to the
     * originating command by correlationId.
     */
    YieldCreateOk: {
      /** The created resource's identity. */
      response: components['schemas']['YieldedResource'];
    };
    /**
     * A `yield` job's worker says the job is complete, with what a `yield` job
     * reports.
     */
    YieldJobCompleteCommand: {
      /**
       * Authenticated user's DID, injected by the /bus/emit gateway. Clients do
       * not set this.
       */
      _userId?: components['schemas']['UserId'];
      resourceId: components['schemas']['ResourceId'];
      jobId: components['schemas']['JobId'];
      jobType: 'yield';
      /**
       * Which attempt produced this event, 1-based (a first run is 1). ALWAYS
       * present: the queue re-runs a failed job silently, so an operator
       * reading progress or a terminal record has no other way to tell a re-run
       * from a first run — and provider spend, already counted in
       * xynolog_inference_tokens_total, cannot be attributed to a repeated
       * document without it. Stated rather than inferred from absence, because
       * 'attempt 1' is a fact the emitter always knows.
       */
      attempt?: number;
      /**
       * The annotation the job's context was focused on, when it was focused on
       * one. Lets a client route the completion to that annotation.
       */
      annotationId?: components['schemas']['AnnotationId'];
      result?: components['schemas']['YieldJobResult'];
      durability?: components['schemas']['DurabilityEvidence'];
    };
    /**
     * Create a `yield` job: make a resource from a gathered context. It names
     * no resource of its own: the job is about the resource its context focuses
     * on, which the Dispatcher reads from `params.context.focus`.
     */
    YieldJobCreateCommand: {
      /**
       * The emitter's verified DID, injected by the gateway. Clients do not set
       * this.
       */
      _userId?: components['schemas']['UserId'];
      /**
       * The emitter's roles, injected by the gateway when it has any. Clients
       * do not set this.
       */
      _roles?: string[];
      jobType: 'yield';
      params: components['schemas']['GenerationJobParams'];
    };
    /**
     * What a `yield` job reports when it has made its resource. The worker
     * creates the resource first (the create round trip returns its id), then
     * emits job:complete carrying it, so resourceId is always present on the
     * wire.
     */
    YieldJobDone: {
      /**
       * ID of the generated resource, obtained by the worker from the create
       * round-trip before job:complete is emitted
       */
      resourceId: components['schemas']['ResourceId'];
      /** Name of the generated resource */
      resourceName: string;
      /**
       * True when the model stopped at the maxTokens ceiling — the artifact is
       * cut off, not complete. Derived at the producer from the provider's
       * stopReason ('max_tokens' → true); required because the worker always
       * knows.
       */
      truncated: boolean;
    };
    /** `yield` jobs. */
    YieldJobFilter: {
      jobType: 'yield';
    };
    /**
     * A pending `yield` job, announced with what it is asked to make and
     * without its `context`.
     */
    YieldJobQueuedEvent: {
      jobId: components['schemas']['JobId'];
      jobType: 'yield';
      /** The resource the job is about. */
      resourceId: components['schemas']['ResourceId'];
      /** The DID of the principal whose `job:create` created the job. */
      userId: components['schemas']['UserId'];
      params: components['schemas']['GenerationJobRequest'];
    };
    /**
     * What a `yield` job reports when it concludes without failing: the
     * resource it made, or a decline. Neither names its kind: a decline is the
     * one with `declined`.
     */
    YieldJobResult:
      | components['schemas']['YieldJobDone']
      | components['schemas']['JobDeclined'];
    /** Bus command to update a yielded resource's storage content. */
    YieldUpdateCommand: {
      /**
       * Authenticated user's DID, injected by the /bus/emit gateway. Clients do
       * not set this.
       */
      _userId?: components['schemas']['UserId'];
      resourceId: components['schemas']['ResourceId'];
      /**
       * The caller's instruction for WHERE the bytes are — not a copy of the
       * stored fact. The stored location lives on the resource's primary
       * Representation (`Representation.storageUri`), which is its single home;
       * this field is the message that puts it there. Working-tree URI, only
       * file:// is supported (e.g. file://docs/overview.md).
       */
      storageUri: string;
      contentChecksum: string;
      byteSize: number;
    };
    /**
     * Success reply after updating a yielded resource, matched to the
     * originating command by correlationId.
     */
    YieldUpdateOk: {
      /** The updated resource's identity. */
      response: components['schemas']['YieldedResource'];
    };
    /** The resource a yield command wrote, by its id. */
    YieldedResource: {
      resourceId: components['schemas']['ResourceId'];
    };
  };
}
