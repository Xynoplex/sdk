// Code generated from the component schemas of protocol/specs/src/openapi.json — DO NOT EDIT.
//
// Regenerate: make generate (codegen/lib/go_types/go_types.ml)

package api

import "encoding/json"

// Agent Web Annotation / W3C PROV Agent. Discriminated by @type — Person,
// Organization, or Software (named member schemas: AgentPerson,
// AgentOrganization, AgentSoftware). Software peers are first-class
// participants, not a sub-class of Person.
type Agent struct {
	union[agentMember]
}

// agentMember is a member of Agent: AgentPerson, AgentOrganization,
// AgentSoftware.
type agentMember interface {
	memberOfAgent()
}

// Discriminator is the `@type` this value states.
func (u Agent) Discriminator() (string, error) { return u.stated("@type") }

// ValueByDiscriminator is the member this value's `@type` names.
func (u Agent) ValueByDiscriminator() (any, error) {
	tag, err := u.Discriminator()
	if err != nil {
		return nil, err
	}
	switch tag {
	case "Person":
		return as[AgentPerson](u.union)
	case "Organization":
		return as[AgentOrganization](u.union)
	case "Software":
		return as[AgentSoftware](u.union)
	}
	return nil, unnamedMember("Agent", "@type", tag)
}

func (Agent) memberOfOneOrMoreAgents() {}

// AgentOrganization An organization — the Organization branch of Agent.
type AgentOrganization struct {
	Id       *string               `json:"@id,omitempty"`
	Type     AgentOrganizationType `json:"@type"`
	Homepage *string               `json:"homepage,omitempty"`
	Name     string                `json:"name"`
	// AdditionalProperties is every member the schema does not name, as it came.
	AdditionalProperties map[string]any `json:"-"`
}

func (AgentOrganization) memberOfAgent()         {}
func (AgentOrganization) told() (string, string) { return "@type", "Organization" }

// MarshalJSON writes v with the members its schema does not name, and each
// list its schema requires that Go holds as nil as the empty list.
func (v AgentOrganization) MarshalJSON() ([]byte, error) {
	type written AgentOrganization
	return writeOpen(written(v), v.AdditionalProperties)
}

// UnmarshalJSON reads v, and each member its schema does not name into its
// AdditionalProperties.
func (v *AgentOrganization) UnmarshalJSON(raw []byte) error {
	type read AgentOrganization
	return readOpen(raw, (*read)(v), &v.AdditionalProperties)
}

type AgentOrganizationType string

// The values of AgentOrganizationType.
const (
	AgentOrganizationTypeOrganization AgentOrganizationType = "Organization"
)

// Valid is whether e is one of AgentOrganizationType's values.
func (e AgentOrganizationType) Valid() bool {
	switch e {
	case AgentOrganizationTypeOrganization:
		return true
	}
	return false
}

// AgentPerson A human participant — the Person branch of Agent.
type AgentPerson struct {
	// Id DID-shaped identifier (e.g. did:web:host:users:email%40host)
	Id        *string         `json:"@id,omitempty"`
	Type      AgentPersonType `json:"@type"`
	Email     *string         `json:"email,omitempty"`
	EmailSha1 *string         `json:"email_sha1,omitempty"`
	Homepage  *string         `json:"homepage,omitempty"`
	// Name Display name. ABSENT until resolved: a Person is identified by `@id`
	// and nothing else, and what they are called is recorded once per change on
	// the knowledge base's own log and filled in when a record is read. An
	// artifact therefore never freezes a name, which is what lets a correction
	// reach every artifact its subject ever wrote. Absent also means genuinely
	// unknown — a DID this knowledge base has no profile for.
	Name     *string `json:"name,omitempty"`
	Nickname *string `json:"nickname,omitempty"`
	// AdditionalProperties is every member the schema does not name, as it came.
	AdditionalProperties map[string]any `json:"-"`
}

func (AgentPerson) memberOfAgent()         {}
func (AgentPerson) told() (string, string) { return "@type", "Person" }

// MarshalJSON writes v with the members its schema does not name, and each
// list its schema requires that Go holds as nil as the empty list.
func (v AgentPerson) MarshalJSON() ([]byte, error) {
	type written AgentPerson
	return writeOpen(written(v), v.AdditionalProperties)
}

// UnmarshalJSON reads v, and each member its schema does not name into its
// AdditionalProperties.
func (v *AgentPerson) UnmarshalJSON(raw []byte) error {
	type read AgentPerson
	return readOpen(raw, (*read)(v), &v.AdditionalProperties)
}

type AgentPersonType string

// The values of AgentPersonType.
const (
	AgentPersonTypePerson AgentPersonType = "Person"
)

// Valid is whether e is one of AgentPersonType's values.
func (e AgentPersonType) Valid() bool {
	switch e {
	case AgentPersonTypePerson:
		return true
	}
	return false
}

// AgentSoftware A software peer, the Software branch of Agent: an agent,
// which is an account as a person is. Its `provider` and `model` are what it
// says of itself, attributed to it and not checked; the knowledge base reads
// neither from its DID. Its `name` is no part of what it writes: what it last
// said it is called is its profile, and readers fill it in, as they do a
// person's. A generator the knowledge base supplies, for an agent that
// supplied none, carries `@type` and `@id` alone.
type AgentSoftware struct {
	// Id The agent's DID: did:web:<domain>:agents:<subject>, its account at the
	// knowledge base's issuer
	Id   *string           `json:"@id,omitempty"`
	Type AgentSoftwareType `json:"@type"`
	// Model Model identifier (e.g. gemma2:27b, claude-3-5-sonnet)
	Model *string `json:"model,omitempty"`
	// Name What the agent last said it is called. ABSENT until resolved: filled
	// in from its profile when a record is read, as a Person's name is. Absent
	// also where it has said nothing. Not parsed.
	Name *string `json:"name,omitempty"`
	// Parameters Inference parameters (temperature, maxTokens, systemPrompt,
	// etc.). Runtime metadata, not part of identity.
	Parameters *map[string]any `json:"parameters,omitempty"`
	// Provider Inference provider (e.g. ollama, anthropic)
	Provider *string `json:"provider,omitempty"`
	// AdditionalProperties is every member the schema does not name, as it came.
	AdditionalProperties map[string]any `json:"-"`
}

func (AgentSoftware) memberOfAgent()         {}
func (AgentSoftware) told() (string, string) { return "@type", "Software" }

// MarshalJSON writes v with the members its schema does not name, and each
// list its schema requires that Go holds as nil as the empty list.
func (v AgentSoftware) MarshalJSON() ([]byte, error) {
	type written AgentSoftware
	return writeOpen(written(v), v.AdditionalProperties)
}

// UnmarshalJSON reads v, and each member its schema does not name into its
// AdditionalProperties.
func (v *AgentSoftware) UnmarshalJSON(raw []byte) error {
	type read AgentSoftware
	return readOpen(raw, (*read)(v), &v.AdditionalProperties)
}

type AgentSoftwareType string

// The values of AgentSoftwareType.
const (
	AgentSoftwareTypeSoftware AgentSoftwareType = "Software"
)

// Valid is whether e is one of AgentSoftwareType's values.
func (e AgentSoftwareType) Valid() bool {
	switch e {
	case AgentSoftwareTypeSoftware:
		return true
	}
	return false
}

// AnchoredText Text paired with the geometry that indexes it — the minimum
// needed to turn a range of the text, two offsets counted in Unicode code
// points, into a selection, or a rectangle into a quote. Whole-resource: a
// producer iterates page by page, but every consumer wants one map.
type AnchoredText struct {
	// Items Positioned runs indexing `text`, roughly one per word.
	Items []PdfTextItem `json:"items"`
	// Text Reading-order text of the whole resource.
	Text string `json:"text"`
}

// MarshalJSON writes v, each list its schema requires that Go holds as nil
// written as the empty list.
func (v AnchoredText) MarshalJSON() ([]byte, error) {
	type written AnchoredText
	v.Items = listOf(v.Items)
	return json.Marshal(written(v))
}

// AnchoredTextAbsent There is no coordinate map to serve, and WHY — the
// distinction a bare null could not carry. One member covers all three
// absences because none carries a payload; `kind` alone is the fact.
// Retryability is legible from the name, deliberately: a caller must not need
// a lookup table to decide whether to come back.
type AnchoredTextAbsent struct {
	// Kind Discriminant, sharing the `kind` field with the
	// ExtractedText/ExtractionDeclined members so the whole answer is one flat
	// union. `not-yet` — the resource's media type has text that is derived by
	// reading its content, and the store holds no entry for this content: the
	// Smelter has not read it yet, or the entry was lost (a loss the Smelter's
	// reconcile pass re-derives). RETRY. `no-map` — the resource's media type
	// has no derived text, so no entry exists and none will until the type is
	// given a reader. Decided by the media type alone, and answered at once.
	// TERMINAL. `unknown` — no content identity to look up: the resource is not
	// in the view store, or its primary representation carries no checksum.
	// TERMINAL.
	Kind AnchoredTextAbsentKind `json:"kind"`
}

func (AnchoredTextAbsent) memberOfAnchoredTextAnswer() {}

// AnchoredTextAbsentKind Discriminant, sharing the `kind` field with the
// ExtractedText/ExtractionDeclined members so the whole answer is one flat
// union. `not-yet` — the resource's media type has text that is derived by
// reading its content, and the store holds no entry for this content: the
// Smelter has not read it yet, or the entry was lost (a loss the Smelter's
// reconcile pass re-derives). RETRY. `no-map` — the resource's media type has
// no derived text, so no entry exists and none will until the type is given a
// reader. Decided by the media type alone, and answered at once. TERMINAL.
// `unknown` — no content identity to look up: the resource is not in the view
// store, or its primary representation carries no checksum. TERMINAL.
type AnchoredTextAbsentKind string

// The values of AnchoredTextAbsentKind.
const (
	AnchoredTextAbsentKindNotYet  AnchoredTextAbsentKind = "not-yet"
	AnchoredTextAbsentKindNoMap   AnchoredTextAbsentKind = "no-map"
	AnchoredTextAbsentKindUnknown AnchoredTextAbsentKind = "unknown"
)

// Valid is whether e is one of AnchoredTextAbsentKind's values.
func (e AnchoredTextAbsentKind) Valid() bool {
	switch e {
	case AnchoredTextAbsentKindNotYet, AnchoredTextAbsentKindNoMap, AnchoredTextAbsentKindUnknown:
		return true
	}
	return false
}

// AnchoredTextAnswer What a reader gets when it asks for a resource's
// coordinate map: the map, a stored decline, or a named absence. Distinct
// from `ExtractionOutcome` on purpose. That type is what the STORE holds and
// what an extractor RETURNS — neither of which can ever be 'not yet'. This is
// the read answer, which can, so widening ExtractionOutcome itself would have
// put an impossible state into the store's own type. Flat, one discriminant:
// every member carries `kind`, rather than nesting an outcome inside a status
// envelope and giving the wire two `kind` fields at different depths.
type AnchoredTextAnswer struct {
	union[anchoredTextAnswerMember]
}

// anchoredTextAnswerMember is a member of AnchoredTextAnswer: ExtractedText,
// ExtractionDeclined, AnchoredTextAbsent.
type anchoredTextAnswerMember interface {
	memberOfAnchoredTextAnswer()
}

// Discriminator is the `kind` this value states.
func (u AnchoredTextAnswer) Discriminator() (string, error) { return u.stated("kind") }

// ValueByDiscriminator is the member this value's `kind` names.
func (u AnchoredTextAnswer) ValueByDiscriminator() (any, error) {
	tag, err := u.Discriminator()
	if err != nil {
		return nil, err
	}
	switch tag {
	case "extracted":
		return as[ExtractedText](u.union)
	case "declined":
		return as[ExtractionDeclined](u.union)
	case "not-yet", "no-map", "unknown":
		return as[AnchoredTextAbsent](u.union)
	}
	return nil, unnamedMember("AnchoredTextAnswer", "kind", tag)
}

// AnchoredTextDeclinedEntry The bytes were declined: no text is extracted
// from them.
type AnchoredTextDeclinedEntry struct {
	// Declined Why extraction yielded nothing, by class.
	Declined ExtractionDeclinedReason `json:"declined"`
	// Stamp The stamp the entry was derived under: the PDF reader's and the OCR
	// engine's. A reader takes the entry only when it equals the stamp the
	// Smelter last stated.
	Stamp string `json:"stamp"`
	// V The entry format.
	V AnchoredTextDeclinedEntryV `json:"v"`
}

func (AnchoredTextDeclinedEntry) memberOfAnchoredTextEntry() {}

// AnchoredTextDeclinedEntryV The entry format.
type AnchoredTextDeclinedEntryV int

// The values of AnchoredTextDeclinedEntryV.
const (
	AnchoredTextDeclinedEntryV3 AnchoredTextDeclinedEntryV = 3
)

// Valid is whether e is one of AnchoredTextDeclinedEntryV's values.
func (e AnchoredTextDeclinedEntryV) Valid() bool {
	switch e {
	case AnchoredTextDeclinedEntryV3:
		return true
	}
	return false
}

// AnchoredTextEntries The keys of the entries the anchored-text store holds
// under the stamp last stated: one checksum for each set of bytes whose text
// is stored, in no order.
type AnchoredTextEntries struct {
	Checksums []string `json:"checksums"`
}

// MarshalJSON writes v, each list its schema requires that Go holds as nil
// written as the empty list.
func (v AnchoredTextEntries) MarshalJSON() ([]byte, error) {
	type written AnchoredTextEntries
	v.Checksums = listOf(v.Checksums)
	return json.Marshal(written(v))
}

// AnchoredTextEntry One entry of the anchored-text store: the file
// `<ab>/<cd>/<key>.json` under the store's directory, where the key is the
// SHA-256 of the bytes the text was extracted from, in hex. The Smelter
// derives it and stores it over the Archivist's HTTP surface
// (`AnchoredTextWrite`); the Archivist writes it, as compact JSON with `v`
// and `stamp` first, to a sibling temporary file renamed onto the path. The
// stamp the Smelter states (`AnchoredTextStamp`) is kept, followed by a
// newline, in the file `STAMP` at the store's root.
type AnchoredTextEntry struct {
	union[anchoredTextEntryMember]
}

// anchoredTextEntryMember is a member of AnchoredTextEntry:
// AnchoredTextExtractedEntry, AnchoredTextDeclinedEntry.
type anchoredTextEntryMember interface {
	memberOfAnchoredTextEntry()
}

// AnchoredTextExtractedEntry The text extracted from the bytes, where each
// word is on the page, and how it was extracted.
type AnchoredTextExtractedEntry struct {
	// Lines Where each word of `text` is, line by line, in reading order.
	Lines []AnchoredTextExtractedEntryLinesItem `json:"lines"`
	// Method How the text was extracted.
	Method ExtractionMethod `json:"method"`
	// OcrConfidence How well the engine read the pixels, when any of this text
	// came from OCR.
	OcrConfidence *OcrConfidence `json:"ocrConfidence,omitempty"`
	// PdfClass PDF classification, when the source was a PDF.
	PdfClass *PdfClass `json:"pdfClass,omitempty"`
	// Stamp The stamp the entry was derived under: the PDF reader's and the OCR
	// engine's. A reader takes the entry only when it equals the stamp the
	// Smelter last stated.
	Stamp string `json:"stamp"`
	// Text The extracted text.
	Text string `json:"text"`
	// UnreadPages 1-indexed pages this extraction could not read — present only
	// for partially covered documents (class C).
	UnreadPages *[]int `json:"unreadPages,omitempty"`
	// V The entry format.
	V AnchoredTextExtractedEntryV `json:"v"`
}

func (AnchoredTextExtractedEntry) memberOfAnchoredTextEntry() {}

// MarshalJSON writes v, each list its schema requires that Go holds as nil
// written as the empty list.
func (v AnchoredTextExtractedEntry) MarshalJSON() ([]byte, error) {
	type written AnchoredTextExtractedEntry
	v.Lines = listOf(v.Lines)
	return json.Marshal(written(v))
}

// AnchoredTextExtractedEntryLinesItem One line of text: the words that share
// a page, a baseline and a height.
type AnchoredTextExtractedEntryLinesItem struct {
	// H The line's height in PDF points.
	H float64 `json:"h"`
	// P The page, counted from 1.
	P int `json:"p"`
	// Words Each word as `[x, width, start, end]`: its horizontal position and
	// width in PDF points, and the offsets of its text in `text`, which are
	// whole numbers of Unicode code points from the start of `text`.
	Words [][]float64 `json:"words"`
	// Y The line's vertical position in PDF points, from the bottom of the page.
	Y float64 `json:"y"`
}

// MarshalJSON writes v, each list its schema requires that Go holds as nil
// written as the empty list.
func (v AnchoredTextExtractedEntryLinesItem) MarshalJSON() ([]byte, error) {
	type written AnchoredTextExtractedEntryLinesItem
	v.Words = listOf(v.Words)
	return json.Marshal(written(v))
}

// AnchoredTextExtractedEntryV The entry format.
type AnchoredTextExtractedEntryV int

// The values of AnchoredTextExtractedEntryV.
const (
	AnchoredTextExtractedEntryV3 AnchoredTextExtractedEntryV = 3
)

// Valid is whether e is one of AnchoredTextExtractedEntryV's values.
func (e AnchoredTextExtractedEntryV) Valid() bool {
	switch e {
	case AnchoredTextExtractedEntryV3:
		return true
	}
	return false
}

// AnchoredTextStamp The stamp an anchored-text store's entries are taken
// under: which PDF reader and which OCR engine derived them. Its writer
// states it before it writes or lists an entry; an entry stored under another
// stamp is answered to no reader.
type AnchoredTextStamp struct {
	// Stamp The stamp: no white space, since it is held in a file of one line.
	Stamp string `json:"stamp"`
}

// AnchoredTextWrite A write of an anchored-text entry for the bytes of one
// resource: what the Smelter derived from them, and their checksum. The
// Archivist files the entry under the checksum, so every resource whose bytes
// those are has it, and refuses the write when the resource's first
// representation has other bytes.
type AnchoredTextWrite struct {
	// ContentChecksum The SHA-256 of the bytes the text was derived from, as 64
	// lower-case hexadecimal digits: the key the entry is filed under.
	ContentChecksum string            `json:"contentChecksum"`
	Entry           AnchoredTextEntry `json:"entry"`
}

type Annotation struct {
	// Context W3C Web Annotation JSON-LD context
	Context AnnotationContext `json:"@context"`
	// Body W3C Web Annotation body. Optional per the W3C spec — annotations
	// whose motivation alone is meaningful (highlighting) legitimately omit it.
	// Present values are either a single body or a non-empty array of bodies;
	// there is no empty array.
	Body *AnnotationBodies `json:"body,omitempty"`
	// Created When the annotation was MADE — the authoring moment, carried from
	// the event that created it. Not when a projection happened to write it: a
	// store that rebuilds from the log must preserve this value, never restamp
	// it.
	Created string `json:"created"`
	// Creator Web Annotation creator — who requested the annotation. DERIVED by
	// the knowledge base at write time, never accepted from an emitter (a
	// payload carrying it is refused): the verified emitter of the write, or,
	// when the write cites a job, the verified emitter of the job:create that
	// produced it. A Person for human-requested work; a Software peer for
	// autonomous-agent work.
	Creator *Agent `json:"creator,omitempty"`
	// Generator Web Annotation generator — the Software peer that produced the
	// annotation, when software did. Absent for a person's own annotation. An
	// emitter may supply it to carry the model's parameters, but its identity
	// must be the emitter's own: the knowledge base refuses a generator naming
	// anyone else, and supplies it from the verified emitter when omitted. One
	// producer per write — a write carrying the array form is refused.
	Generator  *OneOrMoreAgents `json:"generator,omitempty"`
	Id         AnnotationId     `json:"id"`
	Modified   *string          `json:"modified,omitempty"`
	Motivation Motivation       `json:"motivation"`
	// Target W3C Web Annotation target: the id of the resource annotated, when
	// the whole of it is, or an object with source and optional selector
	// (fragment)
	Target AnnotationTargetValue `json:"target"`
	// Type W3C Annotation type
	Type AnnotationType `json:"type"`
	// WasAttributedTo PROV-O wasAttributedTo — every party responsible for this
	// annotation, DERIVED by the knowledge base from `creator` and the verified
	// executor of the write: `[creator, generator]` when one agent requested the
	// work and software produced it; collapsed to the one agent when requester
	// and producer are the same. Never accepted from an emitter.
	WasAttributedTo *OneOrMoreAgents `json:"wasAttributedTo,omitempty"`
}

// AnnotationAddedPayload Payload for mark:added domain event
type AnnotationAddedPayload struct {
	Annotation Annotation `json:"annotation"`
	// ContentChecksum SHA-256 of resource content at annotation time
	ContentChecksum *string `json:"contentChecksum,omitempty"`
}

// AnnotationBodies What an annotation's `body` holds: one body, or a
// non-empty list of them. There is no empty list: an annotation with nothing
// to say has no `body`.
type AnnotationBodies struct {
	union[annotationBodiesMember]
}

// annotationBodiesMember is a member of AnnotationBodies: AnnotationBody,
// AnnotationBodiesList.
type annotationBodiesMember interface {
	memberOfAnnotationBodies()
}

// AnnotationBodiesList is a AnnotationBodies that is a list.
type AnnotationBodiesList []AnnotationBody

func (AnnotationBodiesList) memberOfAnnotationBodies() {}

// AnnotationBody An annotation's body: a TextualBody carries text the
// annotation states (entity tags, descriptions, comments), a SpecificResource
// points at what it links to. Tell them apart by `type`, which is required on
// both and single-valued — a consumer never has to probe for which fields
// happen to be present.
type AnnotationBody struct {
	union[annotationBodyMember]
}

// annotationBodyMember is a member of AnnotationBody: TextualBody,
// SpecificResource.
type annotationBodyMember interface {
	memberOfAnnotationBody()
}

// Discriminator is the `type` this value states.
func (u AnnotationBody) Discriminator() (string, error) { return u.stated("type") }

// ValueByDiscriminator is the member this value's `type` names.
func (u AnnotationBody) ValueByDiscriminator() (any, error) {
	tag, err := u.Discriminator()
	if err != nil {
		return nil, err
	}
	switch tag {
	case "TextualBody":
		return as[TextualBody](u.union)
	case "SpecificResource":
		return as[SpecificResource](u.union)
	}
	return nil, unnamedMember("AnnotationBody", "type", tag)
}

func (AnnotationBody) memberOfAnnotationBodies() {}

// AnnotationBodyUpdatedPayload Payload for mark:body-updated domain event
type AnnotationBodyUpdatedPayload struct {
	AnnotationId AnnotationId    `json:"annotationId"`
	Operations   []BodyOperation `json:"operations"`
}

// MarshalJSON writes v, each list its schema requires that Go holds as nil
// written as the empty list.
func (v AnnotationBodyUpdatedPayload) MarshalJSON() ([]byte, error) {
	type written AnnotationBodyUpdatedPayload
	v.Operations = listOf(v.Operations)
	return json.Marshal(written(v))
}

// AnnotationContext W3C Web Annotation JSON-LD context
type AnnotationContext string

// The values of AnnotationContext.
const (
	AnnotationContextHttpWwwW3OrgNsAnnoJsonld AnnotationContext = "http://www.w3.org/ns/anno.jsonld"
)

// Valid is whether e is one of AnnotationContext's values.
func (e AnnotationContext) Valid() bool {
	switch e {
	case AnnotationContextHttpWwwW3OrgNsAnnoJsonld:
		return true
	}
	return false
}

// AnnotationRemovedPayload Payload for mark:removed domain event
type AnnotationRemovedPayload struct {
	AnnotationId AnnotationId `json:"annotationId"`
}

// AnnotationSelector What a target's `selector` holds: one W3C selector, or
// several of the same segment.
type AnnotationSelector struct {
	union[annotationSelectorMember]
}

// annotationSelectorMember is a member of AnnotationSelector: Selector,
// AnnotationSelectorList.
type annotationSelectorMember interface {
	memberOfAnnotationSelector()
}

// AnnotationSelectorList is a AnnotationSelector that is a list.
type AnnotationSelectorList []Selector

func (AnnotationSelectorList) memberOfAnnotationSelector() {}

// AnnotationTarget W3C Web Annotation target object - source is required,
// selector is optional
type AnnotationTarget struct {
	// Selector Optional selector to identify a specific segment of the source
	// resource
	Selector *AnnotationSelector `json:"selector,omitempty"`
	// Source The id of the resource being annotated
	Source ResourceId `json:"source"`
	// Type Stated by the annotation of a span: the target is a part of its
	// source, which the selector picks out. An annotation of a resource as a
	// whole states none.
	Type *AnnotationTargetType `json:"type,omitempty"`
}

func (AnnotationTarget) memberOfAnnotationTargetValue() {}

// AnnotationTargetType Stated by the annotation of a span: the target is a
// part of its source, which the selector picks out. An annotation of a
// resource as a whole states none.
type AnnotationTargetType string

// The values of AnnotationTargetType.
const (
	AnnotationTargetTypeSpecificResource AnnotationTargetType = "SpecificResource"
)

// Valid is whether e is one of AnnotationTargetType's values.
func (e AnnotationTargetType) Valid() bool {
	switch e {
	case AnnotationTargetTypeSpecificResource:
		return true
	}
	return false
}

// AnnotationTargetValue W3C Web Annotation target: the id of the resource
// annotated, when the whole of it is, or an object with source and optional
// selector (fragment)
type AnnotationTargetValue struct {
	union[annotationTargetValueMember]
}

// annotationTargetValueMember is a member of AnnotationTargetValue:
// ResourceId, AnnotationTarget.
type annotationTargetValueMember interface {
	memberOfAnnotationTargetValue()
}

// AnnotationType W3C Annotation type
type AnnotationType string

// The values of AnnotationType.
const (
	AnnotationTypeAnnotation AnnotationType = "Annotation"
)

// Valid is whether e is one of AnnotationType's values.
func (e AnnotationType) Valid() bool {
	switch e {
	case AnnotationTypeAnnotation:
		return true
	}
	return false
}

// ArchivistConfig Everything the Archivist reads at boot: nothing in it is
// defaulted by the Archivist. The launcher writes it for the Archivist it
// starts, from the knowledge base's stack documents, and the Archivist reads
// it from the path its `--config` flag names (its image passes
// `/etc/xynolog/archivist.json`). Started without `--config`, or with a path
// that names no file, the Archivist refuses to start and says which. No
// secret is a value here. What the knowledge base says of itself is not here
// either: its name, its `site.domain` and its `git.sync` are read from the
// committed `.xynolog/config.yaml` of the tree at `root`. The Archivist's
// other inputs are the environment variables
// specs/src/service-environment/variables.json lists for it. A document that
// does not validate is refused at boot, naming each failing field.
type ArchivistConfig struct {
	// AnchoredTextDir The anchored-text store, which only the Archivist mounts:
	// the Smelter stores each entry in it over HTTP, and the Archivist serves
	// it.
	AnchoredTextDir string           `json:"anchoredTextDir"`
	Engines         ArchivistEngines `json:"engines"`
	// GatewayUrl The URL the Archivist reaches the gateway at: its only route to
	// the bus.
	GatewayUrl string `json:"gatewayUrl"`
	// Identity The issuer the Archivist's service account signs in at, and whose
	// tokens it admits callers of its HTTP surface by.
	Identity  ServiceIdentity `json:"identity"`
	LogFormat LogFormat       `json:"logFormat"`
	LogLevel  LogLevel        `json:"logLevel"`
	// Port The port the Archivist's HTTP surface answers on, `/health` included.
	Port int `json:"port"`
	// Root The knowledge base's working tree: the directory holding `.xynolog/`.
	// The event log, the content and the committed config are under it.
	Root string `json:"root"`
	// SkipRebuild Whether the Archivist serves the views it finds at boot
	// instead of rebuilding them from the event log first.
	SkipRebuild bool `json:"skipRebuild"`
	// Staging The bounds on how far the staging driver may run behind the
	// working tree, in milliseconds. A knowledge base that does not sync git
	// stages nothing, and reads neither.
	Staging ArchivistConfigStaging `json:"staging"`
	// StateHome The state volume, this knowledge base's alone: the Archivist
	// keeps the knowledge base's views and projections in it, at its top.
	StateHome string `json:"stateHome"`
}

// ArchivistConfigStaging The bounds on how far the staging driver may run
// behind the working tree, in milliseconds. A knowledge base that does not
// sync git stages nothing, and reads neither.
type ArchivistConfigStaging struct {
	// FlushMs The quiet period after the last change before pending changes are
	// staged.
	FlushMs int `json:"flushMs"`
	// MaxWaitMs The longest a change waits to be staged while others keep
	// arriving, measured from the oldest pending change.
	MaxWaitMs int `json:"maxWaitMs"`
}

// ArchivistEngines The engine for each job and each Librarian actor, behind
// `browse:engines`: a provider and a model, and no credential. It is the
// knowledge base's Inference document's `engines` as they stand, with no
// fallback, so a job or an actor absent here has no engine.
type ArchivistEngines struct {
	// Actors The engine each Librarian actor that calls a model asks.
	Actors ArchivistEnginesActors `json:"actors"`
	// Jobs The engine each job is done with when software does it, keyed as a
	// job description is: by `jobType`, and for `mark` by motivation.
	Jobs ArchivistEnginesJobs `json:"jobs"`
}

// ArchivistEnginesActors The engine each Librarian actor that calls a model
// asks.
type ArchivistEnginesActors struct {
	Gatherer *Engine `json:"gatherer,omitempty"`
	Matcher  *Engine `json:"matcher,omitempty"`
}

// ArchivistEnginesJobs The engine each job is done with when software does
// it, keyed as a job description is: by `jobType`, and for `mark` by
// motivation.
type ArchivistEnginesJobs struct {
	// Mark The engine for `mark` jobs of each motivation.
	Mark  *ArchivistEnginesJobsMark `json:"mark,omitempty"`
	Yield *Engine                   `json:"yield,omitempty"`
}

// ArchivistEnginesJobsMark The engine for `mark` jobs of each motivation.
type ArchivistEnginesJobsMark struct {
	Assessing    *Engine `json:"assessing,omitempty"`
	Commenting   *Engine `json:"commenting,omitempty"`
	Highlighting *Engine `json:"highlighting,omitempty"`
	Linking      *Engine `json:"linking,omitempty"`
	Tagging      *Engine `json:"tagging,omitempty"`
}

// ArchivistEventsResponse A page of one stream's events from one sequence
// number, inclusive, in log order, and the sequence number of the stream's
// last event: the Archivist's answer to `GET /events/{resourceId}`.
type ArchivistEventsResponse struct {
	Events []StoredEventResponse `json:"events"`
	// LastSequence The sequence number of the stream's last event when it was
	// read: 0 for a stream with none. More events follow the page while its last
	// event's number is below it.
	LastSequence int `json:"lastSequence"`
}

// MarshalJSON writes v, each list its schema requires that Go holds as nil
// written as the empty list.
func (v ArchivistEventsResponse) MarshalJSON() ([]byte, error) {
	type written ArchivistEventsResponse
	v.Events = listOf(v.Events)
	return json.Marshal(written(v))
}

// ArchivistHealth The Archivist's liveness answer: it serves, and the actors
// it hosts.
type ArchivistHealth struct {
	// Actors The record actors this process hosts.
	Actors []string              `json:"actors"`
	Status ArchivistHealthStatus `json:"status"`
}

// MarshalJSON writes v, each list its schema requires that Go holds as nil
// written as the empty list.
func (v ArchivistHealth) MarshalJSON() ([]byte, error) {
	type written ArchivistHealth
	v.Actors = listOf(v.Actors)
	return json.Marshal(written(v))
}

type ArchivistHealthStatus string

// The values of ArchivistHealthStatus.
const (
	ArchivistHealthStatusOk ArchivistHealthStatus = "ok"
)

// Valid is whether e is one of ArchivistHealthStatus's values.
func (e ArchivistHealthStatus) Valid() bool {
	switch e {
	case ArchivistHealthStatusOk:
		return true
	}
	return false
}

// ArchivistStream One stream of the event log, and where it stands: the
// resource it is of, or `__system__` for the knowledge base's own, and the
// sequence number of its last event.
type ArchivistStream struct {
	// LastSequence The sequence number of the stream's last event when it was
	// read: 0 for a stream with none.
	LastSequence int        `json:"lastSequence"`
	ResourceId   ResourceId `json:"resourceId"`
}

// ArchivistStreamsResponse Every stream of the event log, `__system__` among
// them, each with the sequence number of its last event, in no order: the
// Archivist's answer to `GET /events`.
type ArchivistStreamsResponse struct {
	Streams []ArchivistStream `json:"streams"`
}

// MarshalJSON writes v, each list its schema requires that Go holds as nil
// written as the empty list.
func (v ArchivistStreamsResponse) MarshalJSON() ([]byte, error) {
	type written ArchivistStreamsResponse
	v.Streams = listOf(v.Streams)
	return json.Marshal(written(v))
}

// AssessingJobParams What an assessing job takes: passages of the resource
// are marked, each with an assessment the model writes.
type AssessingJobParams struct {
	// Density How many annotations to aim for per 2000 words of the resource.
	Density *float64 `json:"density,omitempty"`
	// Instructions What to look for, in the caller's words. Added to the prompt.
	Instructions *string `json:"instructions,omitempty"`
	// Language The language the annotations' own text is written in. BCP 47.
	Language   *string                      `json:"language,omitempty"`
	Motivation AssessingJobParamsMotivation `json:"motivation"`
	// SourceLanguage The language of the resource being read. BCP 47.
	SourceLanguage *string `json:"sourceLanguage,omitempty"`
	// Tone The stance the assessments are written from.
	Tone *AssessingJobParamsTone `json:"tone,omitempty"`
}

func (AssessingJobParams) memberOfMarkJobParams() {}
func (AssessingJobParams) told() (string, string) { return "motivation", "assessing" }

type AssessingJobParamsMotivation string

// The values of AssessingJobParamsMotivation.
const (
	AssessingJobParamsMotivationAssessing AssessingJobParamsMotivation = "assessing"
)

// Valid is whether e is one of AssessingJobParamsMotivation's values.
func (e AssessingJobParamsMotivation) Valid() bool {
	switch e {
	case AssessingJobParamsMotivationAssessing:
		return true
	}
	return false
}

// AssessingJobParamsTone The stance the assessments are written from.
type AssessingJobParamsTone string

// The values of AssessingJobParamsTone.
const (
	AssessingJobParamsToneAnalytical   AssessingJobParamsTone = "analytical"
	AssessingJobParamsToneCritical     AssessingJobParamsTone = "critical"
	AssessingJobParamsToneBalanced     AssessingJobParamsTone = "balanced"
	AssessingJobParamsToneConstructive AssessingJobParamsTone = "constructive"
)

// Valid is whether e is one of AssessingJobParamsTone's values.
func (e AssessingJobParamsTone) Valid() bool {
	switch e {
	case AssessingJobParamsToneAnalytical, AssessingJobParamsToneCritical, AssessingJobParamsToneBalanced, AssessingJobParamsToneConstructive:
		return true
	}
	return false
}

// AttributedEvent A persisted event as a history reply carries it: the stored
// event, and the agent its `userId` identifies. The agent is derived when the
// reply is made — the DID read into a Person or a Software agent, and a
// Person's name filled in from the knowledge base's profiles — and is stored
// nowhere. A Person the record does not name carries no `name`.
type AttributedEvent struct {
	// Agent Who `userId` is.
	Agent Agent `json:"agent"`
	// Id Unique event ID (UUID)
	Id       string        `json:"id"`
	Metadata EventMetadata `json:"metadata"`
	// Payload Event-type-specific payload
	Payload map[string]any `json:"payload"`
	// ResourceId Resource this event affects (absent for system events)
	ResourceId *ResourceId `json:"resourceId,omitempty"`
	// Timestamp When the event occurred
	Timestamp string `json:"timestamp"`
	// Type Event type (flow verb name, e.g. mark:added)
	Type string `json:"type"`
	// UserId DID of the user who triggered the event
	UserId UserId `json:"userId"`
	// Version Event schema version
	Version int `json:"version"`
}

// BeckonFocusEvent Emitted to draw attention to a resource: to one of its
// annotations, or, with no annotation, to the resource as a whole. The
// resource is always named. A focus on an annotation scrolls a viewer showing
// that resource to it, and a viewer showing a different resource ignores it —
// a deliberate ignore rather than a silent no-op. A focus on the resource as
// a whole brings that resource forward, opened if it is not open, at its top.
type BeckonFocusEvent struct {
	AnnotationId *AnnotationId `json:"annotationId,omitempty"`
	// ResourceId The resource this focus applies to, always named. With an
	// annotation it is a guard: a viewer showing a different resource ignores
	// the event. With none it is the resource the focus brings forward.
	ResourceId ResourceId `json:"resourceId"`
}

// BeckonHoverEvent Emitted when an annotation is hovered over for beckoning
type BeckonHoverEvent struct {
	AnnotationId *AnnotationId `json:"annotationId"`
}

// BeckonSparkleEvent Emitted when a sparkle effect is triggered on an
// annotation
type BeckonSparkleEvent struct {
	AnnotationId AnnotationId `json:"annotationId"`
}

// BindBodyOperation One edit to a linking annotation's body list: add or
// remove a body item, or replace an existing one.
type BindBodyOperation struct {
	// Item Body item for add operations
	Item *AnnotationBody `json:"item,omitempty"`
	// NewItem Replacement body item for replace operations
	NewItem *AnnotationBody `json:"newItem,omitempty"`
	// OldItem Previous body item for replace operations
	OldItem *AnnotationBody `json:"oldItem,omitempty"`
	// Op The type of body operation
	Op BindBodyOperationOp `json:"op"`
}

// BindBodyOperationOp The type of body operation
type BindBodyOperationOp string

// The values of BindBodyOperationOp.
const (
	BindBodyOperationOpAdd     BindBodyOperationOp = "add"
	BindBodyOperationOpRemove  BindBodyOperationOp = "remove"
	BindBodyOperationOpReplace BindBodyOperationOp = "replace"
)

// Valid is whether e is one of BindBodyOperationOp's values.
func (e BindBodyOperationOp) Valid() bool {
	switch e {
	case BindBodyOperationOpAdd, BindBodyOperationOpRemove, BindBodyOperationOpReplace:
		return true
	}
	return false
}

// BindBodyUpdated Void success reply emitted on the bind:body-updated channel
// after bind:update-body has been applied, matched to the originating command
// by correlationId.
type (
	BindBodyUpdated = map[string]any
)

// BindInitiateCommand Command payload sent on the bind:initiate bus channel
// to start a bind flow.
type BindInitiateCommand struct {
	// AnnotationId Branded AnnotationId of the annotation being bound
	AnnotationId AnnotationId `json:"annotationId"`
	// DefaultTitle Default title for the bound annotation
	DefaultTitle string `json:"defaultTitle"`
	// EntityTypes Entity types to associate with the annotation
	EntityTypes []string `json:"entityTypes"`
	// ResourceId Branded ResourceId of the resource being bound to
	ResourceId ResourceId `json:"resourceId"`
}

// MarshalJSON writes v, each list its schema requires that Go holds as nil
// written as the empty list.
func (v BindInitiateCommand) MarshalJSON() ([]byte, error) {
	type written BindInitiateCommand
	v.EntityTypes = listOf(v.EntityTypes)
	return json.Marshal(written(v))
}

// BindUpdateBodyCommand Command payload sent on the bind:update-body bus
// channel to modify annotation bodies.
type BindUpdateBodyCommand struct {
	// UserId Authenticated user's DID, injected by the /bus/emit gateway.
	// Clients do not set this.
	UserId *UserId `json:"_userId,omitempty"`
	// AnnotationId Branded AnnotationId of the annotation whose body is being
	// updated
	AnnotationId AnnotationId `json:"annotationId"`
	// Operations Ordered body-list edits to apply.
	Operations []BindBodyOperation `json:"operations"`
	// ResourceId Branded ResourceId of the resource the annotation belongs to
	ResourceId ResourceId `json:"resourceId"`
}

// MarshalJSON writes v, each list its schema requires that Go holds as nil
// written as the empty list.
func (v BindUpdateBodyCommand) MarshalJSON() ([]byte, error) {
	type written BindUpdateBodyCommand
	v.Operations = listOf(v.Operations)
	return json.Marshal(written(v))
}

// BodyOperation One change to an annotation's bodies: a body added, a body
// removed, or one body replaced by another.
type BodyOperation struct {
	union[bodyOperationMember]
}

// bodyOperationMember is a member of BodyOperation: BodyOperationAdd,
// BodyOperationRemove, BodyOperationReplace.
type bodyOperationMember interface {
	memberOfBodyOperation()
}

type BodyOperationAdd struct {
	Item AnnotationBody     `json:"item"`
	Op   BodyOperationAddOp `json:"op"`
}

func (BodyOperationAdd) memberOfBodyOperation() {}

type BodyOperationAddOp string

// The values of BodyOperationAddOp.
const (
	BodyOperationAddOpAdd BodyOperationAddOp = "add"
)

// Valid is whether e is one of BodyOperationAddOp's values.
func (e BodyOperationAddOp) Valid() bool {
	switch e {
	case BodyOperationAddOpAdd:
		return true
	}
	return false
}

type BodyOperationRemove struct {
	Item AnnotationBody        `json:"item"`
	Op   BodyOperationRemoveOp `json:"op"`
}

func (BodyOperationRemove) memberOfBodyOperation() {}

type BodyOperationRemoveOp string

// The values of BodyOperationRemoveOp.
const (
	BodyOperationRemoveOpRemove BodyOperationRemoveOp = "remove"
)

// Valid is whether e is one of BodyOperationRemoveOp's values.
func (e BodyOperationRemoveOp) Valid() bool {
	switch e {
	case BodyOperationRemoveOpRemove:
		return true
	}
	return false
}

type BodyOperationReplace struct {
	NewItem AnnotationBody         `json:"newItem"`
	OldItem AnnotationBody         `json:"oldItem"`
	Op      BodyOperationReplaceOp `json:"op"`
}

func (BodyOperationReplace) memberOfBodyOperation() {}

type BodyOperationReplaceOp string

// The values of BodyOperationReplaceOp.
const (
	BodyOperationReplaceOpReplace BodyOperationReplaceOp = "replace"
)

// Valid is whether e is one of BodyOperationReplaceOp's values.
func (e BodyOperationReplaceOp) Valid() bool {
	switch e {
	case BodyOperationReplaceOpReplace:
		return true
	}
	return false
}

// BodyPurpose W3C Web Annotation body purpose vocabulary -
// https://www.w3.org/TR/annotation-vocab/#motivation
type BodyPurpose string

// The values of BodyPurpose.
const (
	BodyPurposeAssessing    BodyPurpose = "assessing"
	BodyPurposeBookmarking  BodyPurpose = "bookmarking"
	BodyPurposeClassifying  BodyPurpose = "classifying"
	BodyPurposeCommenting   BodyPurpose = "commenting"
	BodyPurposeDescribing   BodyPurpose = "describing"
	BodyPurposeEditing      BodyPurpose = "editing"
	BodyPurposeHighlighting BodyPurpose = "highlighting"
	BodyPurposeIdentifying  BodyPurpose = "identifying"
	BodyPurposeLinking      BodyPurpose = "linking"
	BodyPurposeModerating   BodyPurpose = "moderating"
	BodyPurposeQuestioning  BodyPurpose = "questioning"
	BodyPurposeReplying     BodyPurpose = "replying"
	BodyPurposeTagging      BodyPurpose = "tagging"
)

// Valid is whether e is one of BodyPurpose's values.
func (e BodyPurpose) Valid() bool {
	switch e {
	case BodyPurposeAssessing, BodyPurposeBookmarking, BodyPurposeClassifying, BodyPurposeCommenting, BodyPurposeDescribing, BodyPurposeEditing, BodyPurposeHighlighting, BodyPurposeIdentifying, BodyPurposeLinking, BodyPurposeModerating, BodyPurposeQuestioning, BodyPurposeReplying, BodyPurposeTagging:
		return true
	}
	return false
}

// BrowseAnnotationHistoryRequest Request to browse the history of an
// annotation
type BrowseAnnotationHistoryRequest struct {
	AnnotationId AnnotationId `json:"annotationId"`
	ResourceId   ResourceId   `json:"resourceId"`
}

// BrowseAnnotationHistoryResult Result of browsing annotation history
type BrowseAnnotationHistoryResult struct {
	Response GetAnnotationHistoryResponse `json:"response"`
}

// BrowseAnnotationRequest Request to browse a single annotation
type BrowseAnnotationRequest struct {
	AnnotationId AnnotationId `json:"annotationId"`
	ResourceId   ResourceId   `json:"resourceId"`
}

// BrowseAnnotationResult Result of browsing a single annotation
type BrowseAnnotationResult struct {
	Response GetAnnotationResponse `json:"response"`
}

// BrowseClickEvent An annotation was clicked — open it: the viewer selects
// its entry in the annotations panel and relays a focus signal to scroll to
// it. The annotation id is the whole address; it identifies exactly one
// annotation on exactly one resource, so no resource field is carried and
// none is needed to scope the event. Motivation is NOT on the wire either:
// the viewer derives it from the annotation the id names, so the wire states
// the fact once. A viewer that has not loaded that annotation finds nothing
// and does nothing. Emitted locally by every clickable annotation surface,
// and over the wire by a driver opening an annotation on another
// participant's screen.
type BrowseClickEvent struct {
	AnnotationId AnnotationId `json:"annotationId"`
}

// BrowseDirectoryFailed The payload of `browse:directory-failed`: a
// CommandError that names the directory that could not be read.
type BrowseDirectoryFailed struct {
	// Code Machine-readable failure class, for consumers that must BRANCH on why
	// a command failed rather than log it. Optional and deliberately sparse:
	// absent means 'no class declared', and every existing failure stays that
	// way. An enum rather than a free string so the vocabulary has an owner — an
	// unconstrained code is a mirror with no gate, and adding one should be a
	// deliberate spec change. `message` remains the human-readable text and is
	// unaffected. Members: `peer-unavailable` — the channel this command was
	// sent on has no subscriber, i.e. the service that answers it has not
	// connected yet. Transient by nature (a peer still starting), which is what
	// distinguishes it from a refusal: retrying is the correct response.
	// `not-found` — the resource this command addressed does not exist in this
	// knowledge base. A verdict, not a symptom: it is emitted only where the
	// answer comes from the event store, which is the system of record, and
	// never from a projection that may merely be lagging. Deterministic, so
	// unlike `peer-unavailable` retrying is pointless — and consumers may act
	// destructively on it (the SDK deletes a restored tab). Absence is not
	// denial: a future 'exists, but not for you' must travel as its own code,
	// never as this one. `unauthorized` — that code: the caller is authenticated
	// but not permitted to do what it asked. A verdict about the CALLER, not the
	// resource, so retrying under the same credential cannot succeed and a
	// consumer must never spin on it; emitted by `job:claim` for a caller whose
	// token carries no worker role. `none-pending` — a declined claim, not an
	// error: the queue holds no pending job of the requested types. Nothing went
	// wrong; the one code a consumer PARKS on, meaning 'nothing to do until a
	// wake-up'. Emitted by `job:claim` only. A `job:claim` refusal carrying
	// neither is unclassified — a malformed record or a missing injection — and
	// a consumer treats it as 'log it, assume nothing'.
	Code *CommandErrorCode `json:"code,omitempty"`
	// Details Optional additional context (stack trace, field name, etc.)
	Details *string `json:"details,omitempty"`
	// Message Human-readable error message
	Message string `json:"message"`
	// Path The path the read was asked for.
	Path string `json:"path"`
}

// BrowseDirectoryRequest Request to browse a directory listing
type BrowseDirectoryRequest struct {
	Path string                      `json:"path"`
	Sort *BrowseDirectoryRequestSort `json:"sort,omitempty"`
}

type BrowseDirectoryRequestSort string

// The values of BrowseDirectoryRequestSort.
const (
	BrowseDirectoryRequestSortName            BrowseDirectoryRequestSort = "name"
	BrowseDirectoryRequestSortMtime           BrowseDirectoryRequestSort = "mtime"
	BrowseDirectoryRequestSortAnnotationCount BrowseDirectoryRequestSort = "annotationCount"
)

// Valid is whether e is one of BrowseDirectoryRequestSort's values.
func (e BrowseDirectoryRequestSort) Valid() bool {
	switch e {
	case BrowseDirectoryRequestSortName, BrowseDirectoryRequestSortMtime, BrowseDirectoryRequestSortAnnotationCount:
		return true
	}
	return false
}

// BrowseDirectoryResult Result of browsing a directory listing
type BrowseDirectoryResult struct {
	Response BrowseDirectoryResultResponse `json:"response"`
}

type BrowseDirectoryResultResponse struct {
	Entries []DirectoryEntry `json:"entries"`
	Path    string           `json:"path"`
}

// MarshalJSON writes v, each list its schema requires that Go holds as nil
// written as the empty list.
func (v BrowseDirectoryResultResponse) MarshalJSON() ([]byte, error) {
	type written BrowseDirectoryResultResponse
	v.Entries = listOf(v.Entries)
	return json.Marshal(written(v))
}

// BrowseEnginesRequest Request for the knowledge base's engines: those its
// Inference document names
type (
	BrowseEnginesRequest = map[string]any
)

// BrowseEnginesResult The knowledge base's engines: those its Inference
// document names, and the jobs it has each used for
type BrowseEnginesResult struct {
	Response BrowseEnginesResultResponse `json:"response"`
}

type BrowseEnginesResultResponse struct {
	Engines []EngineEntry `json:"engines"`
}

// MarshalJSON writes v, each list its schema requires that Go holds as nil
// written as the empty list.
func (v BrowseEnginesResultResponse) MarshalJSON() ([]byte, error) {
	type written BrowseEnginesResultResponse
	v.Engines = listOf(v.Engines)
	return json.Marshal(written(v))
}

// BrowseEntityTypeClickedEvent Emitted when an entity type is clicked in the
// browse panel
type BrowseEntityTypeClickedEvent struct {
	EntityType string `json:"entityType"`
}

// BrowseEntityTypesRequest Request to browse available entity types
type (
	BrowseEntityTypesRequest = map[string]any
)

// BrowseEntityTypesResult Result of browsing entity types
type BrowseEntityTypesResult struct {
	Response GetEntityTypesResponse `json:"response"`
}

// BrowseEventsRequest Request to browse events for a resource
type BrowseEventsRequest struct {
	Limit      *int       `json:"limit,omitempty"`
	ResourceId ResourceId `json:"resourceId"`
	Type       *string    `json:"type,omitempty"`
	UserId     *UserId    `json:"userId,omitempty"`
}

// BrowseEventsResult Result of browsing events for a resource
type BrowseEventsResult struct {
	Response GetEventsResponse `json:"response"`
}

// BrowseExternalNavigateEvent Emitted when navigation to an external URL is
// requested
type BrowseExternalNavigateEvent struct {
	ResourceId *ResourceId `json:"resourceId,omitempty"`
	Url        string      `json:"url"`
}

type BrowseFilesResponse struct {
	Entries []DirectoryEntry `json:"entries"`
	// Path The directory path that was listed, relative to project root
	Path string `json:"path"`
}

// MarshalJSON writes v, each list its schema requires that Go holds as nil
// written as the empty list.
func (v BrowseFilesResponse) MarshalJSON() ([]byte, error) {
	type written BrowseFilesResponse
	v.Entries = listOf(v.Entries)
	return json.Marshal(written(v))
}

// BrowseKbRequest Request for the knowledge base's description of itself
type (
	BrowseKbRequest = map[string]any
)

// BrowseKbResult Result of browse:kb-requested
type BrowseKbResult struct {
	Response KbDescription `json:"response"`
}

// BrowseLinkClickedEvent Emitted when a link is clicked in the browse panel
type BrowseLinkClickedEvent struct {
	Href  string  `json:"href"`
	Label *string `json:"label,omitempty"`
}

// BrowsePanelOpenEvent Emitted when a browse panel is opened
type BrowsePanelOpenEvent struct {
	Motivation           *Motivation   `json:"motivation,omitempty"`
	Panel                string        `json:"panel"`
	ScrollToAnnotationId *AnnotationId `json:"scrollToAnnotationId,omitempty"`
}

// BrowsePanelToggleEvent Emitted when a browse panel is toggled
type BrowsePanelToggleEvent struct {
	Panel string `json:"panel"`
}

// BrowseProfilesRequest Request for the profiles of some principals: the DIDs
// a reply mentions. Bounded by the question: a reader that has more asks in
// parts.
type BrowseProfilesRequest struct {
	// Dids The principals asked after.
	Dids []UserId `json:"dids"`
}

// MarshalJSON writes v, each list its schema requires that Go holds as nil
// written as the empty list.
func (v BrowseProfilesRequest) MarshalJSON() ([]byte, error) {
	type written BrowseProfilesRequest
	v.Dids = listOf(v.Dids)
	return json.Marshal(written(v))
}

// BrowseProfilesResult The profiles of the principals asked after: each that
// has one, keyed by DID. A DID with no profile is absent, and is named by no
// one.
type BrowseProfilesResult struct {
	Response BrowseProfilesResultResponse `json:"response"`
}

type BrowseProfilesResultResponse struct {
	// Profiles Each profile, keyed by DID.
	Profiles map[string]Profile `json:"profiles"`
}

// BrowseResourceCloseEvent Emitted when a resource is closed in the browse
// panel
type BrowseResourceCloseEvent struct {
	ResourceId ResourceId `json:"resourceId"`
}

// BrowseResourceOpenEvent Domain intent to open a resource in the viewer:
// emitted locally by in-app link handlers and remotely by the launcher's tour
// verbs; the viewer translates it to host routing (nav:push), which never
// crosses the wire. Deliberately not named 'navigate' — that word and the
// nav:* prefix belong to the host-local framework layer.
type BrowseResourceOpenEvent struct {
	ResourceId ResourceId `json:"resourceId"`
}

// BrowseResourceReorderEvent Emitted when resources are reordered in the
// browse panel
type BrowseResourceReorderEvent struct {
	NewIndex int `json:"newIndex"`
	OldIndex int `json:"oldIndex"`
}

// BrowseResourceRequest Request to browse a single resource
type BrowseResourceRequest struct {
	ResourceId ResourceId `json:"resourceId"`
}

// BrowseResourceResult A resource's descriptor, and the sequence number of
// the last of its events the descriptor reflects. Its annotations are not
// here: their number follows the document's, so they are read over HTTP (`GET
// /resources/{id}/annotations`).
type BrowseResourceResult struct {
	Response BrowseResourceResultResponse `json:"response"`
}

type BrowseResourceResultResponse struct {
	// LastSequence The sequence number of the resource's last event. A graph
	// read that follows a write waits for the graph projection to reach it.
	LastSequence int                `json:"lastSequence"`
	Resource     ResourceDescriptor `json:"resource"`
}

// BrowseResourceViewedEvent REPORT that a resource has loaded in a viewer —
// emitted on arrival by ANY means: a followed cue, an in-app link, the back
// button, a typed URL. Deliberately distinct from the imperative
// browse:resource-open: drive and report never share a channel, or the driver
// hears its own commands and one viewer's arrival steers another's page.
type BrowseResourceViewedEvent struct {
	ResourceId ResourceId `json:"resourceId"`
}

// BrowseResourcesRequest Request to browse resources with optional filtering
// and pagination
type BrowseResourcesRequest struct {
	Archived   *bool   `json:"archived,omitempty"`
	EntityType *string `json:"entityType,omitempty"`
	// Limit The most resources a page has.
	Limit *int `json:"limit,omitempty"`
	// Offset How many of the resources the filters admit are passed over before
	// the page begins.
	Offset *int `json:"offset,omitempty"`
}

// BrowseResourcesResult Result of browsing resources
type BrowseResourcesResult struct {
	Response ListResourcesResponse `json:"response"`
}

// BrowseRouterPushEvent Emitted when the browse panel requests a router
// navigation
type BrowseRouterPushEvent struct {
	Path   string  `json:"path"`
	Reason *string `json:"reason,omitempty"`
}

// BrowseTagSchemasRequest Request to browse registered tag schemas
type (
	BrowseTagSchemasRequest = map[string]any
)

// BrowseTagSchemasResult Result of browsing tag schemas
type BrowseTagSchemasResult struct {
	Response GetTagSchemasResponse `json:"response"`
}

// BusEmitAccepted Result of publishing one event. `subscribers` is the number
// of observers attached to the target subject at dispatch — the GLOBAL
// subject for an unscoped emit, the scoped one when `scope` is set. Zero
// means the signal reached nobody: /bus/subscribe enforces no channel
// allowlist and the emit handler publishes unconditionally, so a client can
// emit a channel no participant subscribes to and otherwise receive a clean
// 202 with no way to tell. Deliberately NOT named `delivered`: this is the
// count at dispatch, and a subscriber may still drop the frame downstream, so
// the field is named after what the server can actually observe.
type BusEmitAccepted struct {
	// Subscribers Observers on the target subject when the event was dispatched.
	// ABSENT means the gateway could not count: under a broker signal plane (the
	// KnowledgeBase document's `spec.messaging.signal.type: nats`) the event is
	// published to a fabric whose observers the gateway cannot see. The one zero
	// a broker plane states is a registry operation's request with a
	// `correlationId` that reached nobody, which the broker itself reports (no
	// responders). Never defaulted: a zero here is the claim that nobody was
	// listening, and a gateway that did not observe that never makes it.
	Subscribers *int `json:"subscribers,omitempty"`
}

// BusEmitRequest One event for the bus. `channel` names a channel of the bus
// registry (specs/src/bus/registry.json) and `payload` must match the schema
// the registry's `validate` names for it. `scope` publishes a resource-bound
// broadcast to that resource's subscribers only; everything else is unscoped.
// `clientId` and `correlationId` are routing facts beside the payload, never
// inside it.
type BusEmitRequest struct {
	// Channel A channel of the bus registry.
	Channel string `json:"channel"`
	// ClientId The address this request's reply is delivered to: the emit claims
	// `correlationId` for this clientId and the verified principal. Required
	// when `channel` is a registry operation's request and a correlationId is
	// present; ignored otherwise. An empty string counts as absent.
	ClientId *string `json:"clientId,omitempty"`
	// CorrelationId Pairs a reply with its request. On a registry operation's
	// request it claims the id: a second claim of a live id is refused with 409.
	// Replies carry it back on the frame, never in the payload.
	CorrelationId *string `json:"correlationId,omitempty"`
	// Payload The channel's payload, validated against the schema its registry
	// entry names. `_userId` and `_roles` are the gateway's to write: whatever a
	// caller puts there is replaced.
	Payload map[string]any `json:"payload"`
	// Scope The resource scope of a resource-bound broadcast. Publishers of
	// those broadcasts only; a command or request never carries one.
	Scope *ResourceId `json:"scope,omitempty"`
}

// BusEventMessage A bus frame on the stream: `event: bus-event`, an `id:`
// line, and one `data:` line holding the JSON-serialised BusFrame. This
// schema describes the message with `data` already parsed.
type BusEventMessage struct {
	Data  BusFrame             `json:"data"`
	Event BusEventMessageEvent `json:"event"`
	Id    string               `json:"id"`
}

func (BusEventMessage) memberOfBusStreamMessage() {}

type BusEventMessageEvent string

// The values of BusEventMessageEvent.
const (
	BusEventMessageEventBusEvent BusEventMessageEvent = "bus-event"
)

// Valid is whether e is one of BusEventMessageEvent's values.
func (e BusEventMessageEvent) Valid() bool {
	switch e {
	case BusEventMessageEventBusEvent:
		return true
	}
	return false
}

// BusFrame One frame of the bus stream, as the `data` line of a `bus-event`
// message carries it (JSON-serialised on one line). `payload` is the
// channel's payload as its registry entry declares it. A frame on a scoped
// subscription carries the scope it was published on; a correlated reply
// carries the `correlationId` of the request it answers.
type BusFrame struct {
	// Channel A channel of the bus registry (specs/src/bus/registry.json).
	Channel string `json:"channel"`
	// CorrelationId The request this frame answers. Present on correlated
	// replies; absent otherwise.
	CorrelationId *string `json:"correlationId,omitempty"`
	// Payload The channel's payload. A replayed persisted event is the stored
	// event itself, whose `metadata.sequenceNumber` the message id carries.
	Payload map[string]any `json:"payload"`
	// Scope The resource scope the frame was published on. Present exactly when
	// it arrived through a `scoped` entry of the subscription.
	Scope *ResourceId `json:"scope,omitempty"`
}

// BusPingMessage The heartbeat: `event: ping` with an empty `data:` line. The
// first is written once the stream has caught up (after any replay), then one
// every `x-xynolog-limits.heartbeatSeconds`. It carries no id, so it never
// disturbs a client's last-seen ids.
type BusPingMessage struct {
	Data  string              `json:"data"`
	Event BusPingMessageEvent `json:"event"`
}

func (BusPingMessage) memberOfBusStreamMessage() {}

type BusPingMessageEvent string

// The values of BusPingMessageEvent.
const (
	BusPingMessageEventPing BusPingMessageEvent = "ping"
)

// Valid is whether e is one of BusPingMessageEvent's values.
func (e BusPingMessageEvent) Valid() bool {
	switch e {
	case BusPingMessageEventPing:
		return true
	}
	return false
}

// BusResumeGap The payload of `bus:resume-gap`: a scope's `lastEventId` could
// not be honoured, so the client cannot trust that it has every persisted
// event of that scope and must refetch what it caches for it. Written by the
// gateway, never by a participant.
type BusResumeGap struct {
	// LastSeenId The watermark the entry carried.
	LastSeenId string `json:"lastSeenId"`
	// Reason `unparseable-last-event-id`: the watermark is not a
	// PersistedEventId. `scope-mismatch`: it names another scope.
	// `retention-exceeded`: the record no longer holds the events after it (what
	// it still holds is replayed first). `query-error`: the record could not be
	// read.
	Reason BusResumeGapReason `json:"reason"`
	// Scope The scope of the subscription entry whose watermark failed.
	Scope ResourceId `json:"scope"`
}

// BusResumeGapReason `unparseable-last-event-id`: the watermark is not a
// PersistedEventId. `scope-mismatch`: it names another scope.
// `retention-exceeded`: the record no longer holds the events after it (what
// it still holds is replayed first). `query-error`: the record could not be
// read.
type BusResumeGapReason string

// The values of BusResumeGapReason.
const (
	BusResumeGapReasonUnparseableLastEventId BusResumeGapReason = "unparseable-last-event-id"
	BusResumeGapReasonScopeMismatch          BusResumeGapReason = "scope-mismatch"
	BusResumeGapReasonRetentionExceeded      BusResumeGapReason = "retention-exceeded"
	BusResumeGapReasonQueryError             BusResumeGapReason = "query-error"
)

// Valid is whether e is one of BusResumeGapReason's values.
func (e BusResumeGapReason) Valid() bool {
	switch e {
	case BusResumeGapReasonUnparseableLastEventId, BusResumeGapReasonScopeMismatch, BusResumeGapReasonRetentionExceeded, BusResumeGapReasonQueryError:
		return true
	}
	return false
}

// BusStreamMessage Every message the bus stream carries. A client ignores an
// `event` it does not know; the gateway writes no other.
type BusStreamMessage struct {
	union[busStreamMessageMember]
}

// busStreamMessageMember is a member of BusStreamMessage: BusEventMessage,
// BusPingMessage.
type busStreamMessageMember interface {
	memberOfBusStreamMessage()
}

// BusSubscribeRequest Subscription matrix for the bus stream. `global`
// channels are delivered unscoped; each `scoped` entry subscribes the
// connection to one resource scope's channels, optionally resuming from that
// scope's last-seen persisted event id. At least one global channel or one
// scoped entry is required, and no scope may appear in two entries.
type BusSubscribeRequest struct {
	// ClientId Routing address for correlated replies: a UUID minted once per
	// bus-client lifetime — per actor, not per connection, so it survives a
	// reconnect and two overlapping connections share it. A correlated reply is
	// delivered to a connection only when its request was emitted under the same
	// clientId by the same principal. Not authentication — the bearer token
	// stays that — and never echoed into any payload or broadcast frame.
	ClientId string `json:"clientId"`
	// Global Unscoped channels to subscribe to.
	Global *[]string `json:"global,omitempty"`
	// PendingReplies Correlation ids of requests this client still awaits a
	// reply to. The gateway writes every reply it still retains for them (for
	// `x-xynolog-limits.replyRetentionSeconds` after it was published) as an
	// ordinary frame with its ReplyEventId, so a reply that also arrived live
	// dedups client-side. A client can have no more pending than it may have
	// unanswered requests, so this bound is also the number of unanswered
	// requests `POST /bus/emit` allows a client.
	PendingReplies *[]string `json:"pendingReplies,omitempty"`
	// Scoped Per-resource-scope subscriptions, at most 512 on one connection.
	// Scopes must be unique across entries.
	Scoped *[]BusSubscribeRequestScopedItem `json:"scoped,omitempty"`
}

type BusSubscribeRequestScopedItem struct {
	// Channels Channels to subscribe within this scope.
	Channels []string `json:"channels"`
	// LastEventId This scope's last-seen PersistedEventId. The gateway replays
	// this scope's persisted events after it — those on the entry's channels —
	// before the live tail, and writes a scoped `bus:resume-gap` (BusResumeGap)
	// when it cannot cover the gap.
	LastEventId *string `json:"lastEventId,omitempty"`
	// Scope Resource scope (a resourceId).
	Scope ResourceId `json:"scope"`
}

// MarshalJSON writes v, each list its schema requires that Go holds as nil
// written as the empty list.
func (v BusSubscribeRequestScopedItem) MarshalJSON() ([]byte, error) {
	type written BusSubscribeRequestScopedItem
	v.Channels = listOf(v.Channels)
	return json.Marshal(written(v))
}

type CloneResourceWithTokenResponse struct {
	// ExpiresAt ISO 8601 timestamp when token expires
	ExpiresAt string             `json:"expiresAt"`
	Resource  ResourceDescriptor `json:"resource"`
	// Token Generated clone token
	Token string `json:"token"`
}

// CommandError Error response for failed bus commands. Replaces native Error
// objects on the EventBus so payloads are serializable and OpenAPI-typed.
type CommandError struct {
	// Code Machine-readable failure class, for consumers that must BRANCH on why
	// a command failed rather than log it. Optional and deliberately sparse:
	// absent means 'no class declared', and every existing failure stays that
	// way. An enum rather than a free string so the vocabulary has an owner — an
	// unconstrained code is a mirror with no gate, and adding one should be a
	// deliberate spec change. `message` remains the human-readable text and is
	// unaffected. Members: `peer-unavailable` — the channel this command was
	// sent on has no subscriber, i.e. the service that answers it has not
	// connected yet. Transient by nature (a peer still starting), which is what
	// distinguishes it from a refusal: retrying is the correct response.
	// `not-found` — the resource this command addressed does not exist in this
	// knowledge base. A verdict, not a symptom: it is emitted only where the
	// answer comes from the event store, which is the system of record, and
	// never from a projection that may merely be lagging. Deterministic, so
	// unlike `peer-unavailable` retrying is pointless — and consumers may act
	// destructively on it (the SDK deletes a restored tab). Absence is not
	// denial: a future 'exists, but not for you' must travel as its own code,
	// never as this one. `unauthorized` — that code: the caller is authenticated
	// but not permitted to do what it asked. A verdict about the CALLER, not the
	// resource, so retrying under the same credential cannot succeed and a
	// consumer must never spin on it; emitted by `job:claim` for a caller whose
	// token carries no worker role. `none-pending` — a declined claim, not an
	// error: the queue holds no pending job of the requested types. Nothing went
	// wrong; the one code a consumer PARKS on, meaning 'nothing to do until a
	// wake-up'. Emitted by `job:claim` only. A `job:claim` refusal carrying
	// neither is unclassified — a malformed record or a missing injection — and
	// a consumer treats it as 'log it, assume nothing'.
	Code *CommandErrorCode `json:"code,omitempty"`
	// Details Optional additional context (stack trace, field name, etc.)
	Details *string `json:"details,omitempty"`
	// Message Human-readable error message
	Message string `json:"message"`
}

// CommandErrorCode Machine-readable failure class, for consumers that must
// BRANCH on why a command failed rather than log it. Optional and
// deliberately sparse: absent means 'no class declared', and every existing
// failure stays that way. An enum rather than a free string so the vocabulary
// has an owner — an unconstrained code is a mirror with no gate, and adding
// one should be a deliberate spec change. `message` remains the
// human-readable text and is unaffected. Members: `peer-unavailable` — the
// channel this command was sent on has no subscriber, i.e. the service that
// answers it has not connected yet. Transient by nature (a peer still
// starting), which is what distinguishes it from a refusal: retrying is the
// correct response. `not-found` — the resource this command addressed does
// not exist in this knowledge base. A verdict, not a symptom: it is emitted
// only where the answer comes from the event store, which is the system of
// record, and never from a projection that may merely be lagging.
// Deterministic, so unlike `peer-unavailable` retrying is pointless — and
// consumers may act destructively on it (the SDK deletes a restored tab).
// Absence is not denial: a future 'exists, but not for you' must travel as
// its own code, never as this one. `unauthorized` — that code: the caller is
// authenticated but not permitted to do what it asked. A verdict about the
// CALLER, not the resource, so retrying under the same credential cannot
// succeed and a consumer must never spin on it; emitted by `job:claim` for a
// caller whose token carries no worker role. `none-pending` — a declined
// claim, not an error: the queue holds no pending job of the requested types.
// Nothing went wrong; the one code a consumer PARKS on, meaning 'nothing to
// do until a wake-up'. Emitted by `job:claim` only. A `job:claim` refusal
// carrying neither is unclassified — a malformed record or a missing
// injection — and a consumer treats it as 'log it, assume nothing'.
type CommandErrorCode string

// The values of CommandErrorCode.
const (
	CommandErrorCodePeerUnavailable CommandErrorCode = "peer-unavailable"
	CommandErrorCodeNotFound        CommandErrorCode = "not-found"
	CommandErrorCodeUnauthorized    CommandErrorCode = "unauthorized"
	CommandErrorCodeNonePending     CommandErrorCode = "none-pending"
)

// Valid is whether e is one of CommandErrorCode's values.
func (e CommandErrorCode) Valid() bool {
	switch e {
	case CommandErrorCodePeerUnavailable, CommandErrorCodeNotFound, CommandErrorCodeUnauthorized, CommandErrorCodeNonePending:
		return true
	}
	return false
}

// CommentingJobParams What a commenting job takes: passages of the resource
// are marked, each with a comment the model writes.
type CommentingJobParams struct {
	// Density How many annotations to aim for per 2000 words of the resource.
	Density *float64 `json:"density,omitempty"`
	// Instructions What to look for, in the caller's words. Added to the prompt.
	Instructions *string `json:"instructions,omitempty"`
	// Language The language the annotations' own text is written in. BCP 47.
	Language   *string                       `json:"language,omitempty"`
	Motivation CommentingJobParamsMotivation `json:"motivation"`
	// SourceLanguage The language of the resource being read. BCP 47.
	SourceLanguage *string `json:"sourceLanguage,omitempty"`
	// Tone The voice the comments are written in.
	Tone *CommentingJobParamsTone `json:"tone,omitempty"`
}

func (CommentingJobParams) memberOfMarkJobParams() {}
func (CommentingJobParams) told() (string, string) { return "motivation", "commenting" }

type CommentingJobParamsMotivation string

// The values of CommentingJobParamsMotivation.
const (
	CommentingJobParamsMotivationCommenting CommentingJobParamsMotivation = "commenting"
)

// Valid is whether e is one of CommentingJobParamsMotivation's values.
func (e CommentingJobParamsMotivation) Valid() bool {
	switch e {
	case CommentingJobParamsMotivationCommenting:
		return true
	}
	return false
}

// CommentingJobParamsTone The voice the comments are written in.
type CommentingJobParamsTone string

// The values of CommentingJobParamsTone.
const (
	CommentingJobParamsToneScholarly      CommentingJobParamsTone = "scholarly"
	CommentingJobParamsToneExplanatory    CommentingJobParamsTone = "explanatory"
	CommentingJobParamsToneConversational CommentingJobParamsTone = "conversational"
	CommentingJobParamsToneTechnical      CommentingJobParamsTone = "technical"
)

// Valid is whether e is one of CommentingJobParamsTone's values.
func (e CommentingJobParamsTone) Valid() bool {
	switch e {
	case CommentingJobParamsToneScholarly, CommentingJobParamsToneExplanatory, CommentingJobParamsToneConversational, CommentingJobParamsToneTechnical:
		return true
	}
	return false
}

// ContentFormat Content format as a MIME type, optionally with parameters.
// The base type (everything before the first ';') MUST be a
// SupportedMediaType; parameters such as charset are preserved as metadata.
// Semantic validation happens in code at the create/yield boundary — there is
// deliberately no pattern here, the vocabulary lives in SupportedMediaType.
// Examples: text/plain, text/plain; charset=iso-8859-1, text/markdown;
// charset=windows-1252, image/png, application/pdf
type (
	ContentFormat = string
)

type ContextualSummaryResponse struct {
	Context ContextualSummaryResponseContext `json:"context"`
	// RelevantFields What the summary is of: the resource the annotation is on,
	// and the annotation's entity types.
	RelevantFields ContextualSummaryResponseRelevantFields `json:"relevantFields"`
	Summary        string                                  `json:"summary"`
}

type ContextualSummaryResponseContext struct {
	After    *string `json:"after,omitempty"`
	Before   *string `json:"before,omitempty"`
	Selected string  `json:"selected"`
}

// ContextualSummaryResponseRelevantFields What the summary is of: the
// resource the annotation is on, and the annotation's entity types.
type ContextualSummaryResponseRelevantFields struct {
	EntityTypes  []string   `json:"entityTypes"`
	ResourceId   ResourceId `json:"resourceId"`
	ResourceName string     `json:"resourceName"`
}

// MarshalJSON writes v, each list its schema requires that Go holds as nil
// written as the empty list.
func (v ContextualSummaryResponseRelevantFields) MarshalJSON() ([]byte, error) {
	type written ContextualSummaryResponseRelevantFields
	v.EntityTypes = listOf(v.EntityTypes)
	return json.Marshal(written(v))
}

type CreateAnnotationRequest struct {
	// Body Optional body. Omit for annotations whose motivation alone is
	// meaningful (highlighting) or whose user-supplied content is empty. Shape
	// matches Annotation.body.
	Body       *AnnotationBodies `json:"body,omitempty"`
	Motivation Motivation        `json:"motivation"`
	Target     AnnotationTarget  `json:"target"`
}

// CreateResourceResponse The id of the resource an upload created. The
// Archivist answers it (200) once it has stored the bytes and recorded the
// resource, and the gateway forwards it (202), so the id is the one the
// record minted and its creation event is persisted. What remains
// asynchronous is downstream projection: graph, views and vectors settle
// afterwards.
type CreateResourceResponse struct {
	// ResourceId The id of the newly created resource, as the record minted it.
	ResourceId ResourceId `json:"resourceId"`
}

// CursorsPath The file a follower of the record keeps its cursors in: for
// each log of the record it follows, the sequence number of the last event of
// it taken (contract/TRANSPORT-CONTRACT.md § What repairs a passing frame). A
// file of the service's own disk, never of the knowledge base: a service that
// finds none starts each log as it starts one with no cursor, so losing it
// costs time and never correctness.
type (
	CursorsPath = string
)

type DirEntry struct {
	// Mtime Last modified time (ISO 8601)
	Mtime string `json:"mtime"`
	// Name Entry name (basename)
	Name string `json:"name"`
	// Path Path relative to project root
	Path string       `json:"path"`
	Type DirEntryType `json:"type"`
}

func (DirEntry) memberOfDirectoryEntry() {}
func (DirEntry) told() (string, string)  { return "type", "dir" }

type DirEntryType string

// The values of DirEntryType.
const (
	DirEntryTypeDir DirEntryType = "dir"
)

// Valid is whether e is one of DirEntryType's values.
func (e DirEntryType) Valid() bool {
	switch e {
	case DirEntryTypeDir:
		return true
	}
	return false
}

// DirectoryEntry One entry in a directory listing: a file, which may carry
// the resource it was ingested as, or a subdirectory. Tell them apart by
// `type`, which is required on both and single-valued.
type DirectoryEntry struct {
	union[directoryEntryMember]
}

// directoryEntryMember is a member of DirectoryEntry: FileEntry, DirEntry.
type directoryEntryMember interface {
	memberOfDirectoryEntry()
}

// Discriminator is the `type` this value states.
func (u DirectoryEntry) Discriminator() (string, error) { return u.stated("type") }

// ValueByDiscriminator is the member this value's `type` names.
func (u DirectoryEntry) ValueByDiscriminator() (any, error) {
	tag, err := u.Discriminator()
	if err != nil {
		return nil, err
	}
	switch tag {
	case "file":
		return as[FileEntry](u.union)
	case "dir":
		return as[DirEntry](u.union)
	}
	return nil, unnamedMember("DirectoryEntry", "type", tag)
}

// DiscoveredKB One knowledge base the Xynolog launcher manages on this
// machine, as published in the discovery document (see DiscoveryDocument).
// Endpoints and identity only — never credentials; login remains the
// consumer's per-KB business.
type DiscoveredKB struct {
	// Did The KB's did:web identifier, from its committed .xynolog/config.yaml —
	// "did:web:" + its site.domain, verbatim. REQUIRED: a KB that declares no
	// domain has no identity to publish, and the launcher refuses to start it
	// rather than inventing or defaulting one. NOT unique within a document: a
	// did names the knowledge base, not a running copy of it, so a local clone
	// and a codespace of the same repo legitimately share one and both are
	// published. host:port is the unique field (at most one entry per address),
	// so consumers look up by ADDRESS and use the did to VERIFY that the copy
	// they reached is the KB they meant — an address alone cannot say which KB
	// is which, and an identity alone cannot say which copy.
	Did string `json:"did"`
	// Host Hostname the KB is reachable on from this machine (always "localhost"
	// — local stacks bind locally and codespace KBs arrive through a local port
	// forward)
	Host string `json:"host"`
	// ManagedBy The agent that owns this entry's lifecycle (the launcher writes
	// "xynolog-launcher"). Consumers treat managed entries as authoritative for
	// themselves — upsert on appearance, remove on disappearance — and never
	// touch entries they did not write.
	ManagedBy string `json:"managedBy"`
	// Placement Where the stack actually runs. "local": containers on this
	// machine. "codespace": a GitHub-hosted VM whose KB is port-forwarded here.
	Placement DiscoveredKBPlacement `json:"placement"`
	// Port Local TCP port of the KB's API (the gateway port for a local stack;
	// the allocated forward port for a codespace stack)
	Port int `json:"port"`
	// Repo owner/name GitHub slug — present for codespace placements, where the
	// repo is the stack's identity
	Repo *string `json:"repo,omitempty"`
	// SiteName Human-readable site name from the KB's .xynolog/config.yaml
	// (site.siteName), for display
	SiteName *string `json:"siteName,omitempty"`
}

// DiscoveredKBPlacement Where the stack actually runs. "local": containers on
// this machine. "codespace": a GitHub-hosted VM whose KB is port-forwarded
// here.
type DiscoveredKBPlacement string

// The values of DiscoveredKBPlacement.
const (
	DiscoveredKBPlacementLocal     DiscoveredKBPlacement = "local"
	DiscoveredKBPlacementCodespace DiscoveredKBPlacement = "codespace"
)

// Valid is whether e is one of DiscoveredKBPlacement's values.
func (e DiscoveredKBPlacement) Valid() bool {
	switch e {
	case DiscoveredKBPlacementLocal, DiscoveredKBPlacementCodespace:
		return true
	}
	return false
}

// DiscoveryDocument The launcher's KB discovery document — the schema
// authority for <stateDir>/discovery/kbs.json, which the Xynolog CLI
// (xynolog/cli) regenerates on every stack mutation and the Browser container
// mounts read-only at /discovery. NOT an API endpoint: a static document
// fetched same-origin by browsers (via the Browser's static server). An empty
// kbs list is meaningful ("the launcher manages nothing right now") and
// distinct from an absent file.
type DiscoveryDocument struct {
	// Kbs Every KB the launcher currently manages, local and forwarded
	Kbs []DiscoveredKB `json:"kbs"`
	// Version Document schema version. Consumers MUST check it and ignore
	// documents they do not understand.
	Version DiscoveryDocumentVersion `json:"version"`
}

// MarshalJSON writes v, each list its schema requires that Go holds as nil
// written as the empty list.
func (v DiscoveryDocument) MarshalJSON() ([]byte, error) {
	type written DiscoveryDocument
	v.Kbs = listOf(v.Kbs)
	return json.Marshal(written(v))
}

// DiscoveryDocumentVersion Document schema version. Consumers MUST check it
// and ignore documents they do not understand.
type DiscoveryDocumentVersion int

// The values of DiscoveryDocumentVersion.
const (
	DiscoveryDocumentVersion1 DiscoveryDocumentVersion = 1
)

// Valid is whether e is one of DiscoveryDocumentVersion's values.
func (e DiscoveryDocumentVersion) Valid() bool {
	switch e {
	case DiscoveryDocumentVersion1:
		return true
	}
	return false
}

// DispatcherConfig Everything the dispatcher reads at boot: nothing in it is
// defaulted by the dispatcher. The launcher writes it for the dispatcher it
// starts, from the knowledge base's stack documents, and the dispatcher reads
// it from the path its `--config` flag names (its image passes
// `/etc/xynolog/dispatcher.json`). Started without `--config`, or with a path
// that names no file, the dispatcher refuses to start and says which. Secrets
// are never values here: a field that needs one names the environment
// variable holding it. The dispatcher's other inputs are the environment
// variables specs/src/service-environment/variables.json lists for it, and
// the ones this document names. A document that does not validate is refused
// at boot, naming each failing field.
type DispatcherConfig struct {
	// GatewayUrl The URL the dispatcher reaches the gateway at: its only route
	// to the bus.
	GatewayUrl string `json:"gatewayUrl"`
	// Identity The issuer the dispatcher's service account signs in at.
	Identity  ServiceIdentity `json:"identity"`
	Kb        KbIdentity      `json:"kb"`
	LogFormat LogFormat       `json:"logFormat"`
	LogLevel  LogLevel        `json:"logLevel"`
	// Port The port the dispatcher answers `/health` on.
	Port int `json:"port"`
	// Queue The JetStream broker holding the job queue, whose layout is
	// specs/src/jobs/storage.json.
	Queue DispatcherConfigQueue `json:"queue"`
	// Timing The queue's clocks, in milliseconds. The launcher writes the values
	// a deployment runs with; a test harness shrinks them.
	Timing DispatcherConfigTiming `json:"timing"`
}

// DispatcherConfigQueue The JetStream broker holding the job queue, whose
// layout is specs/src/jobs/storage.json.
type DispatcherConfigQueue struct {
	// PasswordEnv The environment variable holding the broker password, when the
	// broker requires one.
	PasswordEnv *string `json:"passwordEnv,omitempty"`
	// Servers The broker's address (`host:port`, or several, comma-separated).
	Servers string `json:"servers"`
	// UserEnv The environment variable holding the broker user, when the broker
	// requires one.
	UserEnv *string `json:"userEnv,omitempty"`
}

// DispatcherConfigTiming The queue's clocks, in milliseconds. The launcher
// writes the values a deployment runs with; a test harness shrinks them.
type DispatcherConfigTiming struct {
	// AckWaitMs How long the broker waits, after this dispatcher stops renewing
	// a job's lease, before redelivering its message.
	AckWaitMs int `json:"ackWaitMs"`
	// BootDeadlineMs How long the dispatcher waits at boot for the broker before
	// it exits, so that a restart policy can retry.
	BootDeadlineMs int `json:"bootDeadlineMs"`
	// ProgressWriteIntervalMs The least time between two progress writes for one
	// job; reports closer together than this are not written.
	ProgressWriteIntervalMs int `json:"progressWriteIntervalMs"`
	// RetentionMs How long a concluded job is kept before it is deleted.
	RetentionMs int `json:"retentionMs"`
	// RetentionSweepMs How often concluded jobs past `retentionMs` are deleted.
	RetentionSweepMs int `json:"retentionSweepMs"`
	// StaleRunningMs How long a running job may go without progress, a
	// checkpoint or a claim before its worker is presumed dead.
	StaleRunningMs int `json:"staleRunningMs"`
	// TickMs How often the queue re-announces pending jobs and sweeps for dead
	// workers. The re-announcement is insurance against a lost wake-up, not
	// dispatch.
	TickMs int `json:"tickMs"`
}

// DispatcherHealth The dispatcher's liveness answer. It answers only once its
// queue has connected and its bus pumps are attached, so a 200 means it can
// take work.
type DispatcherHealth struct {
	// Queue The queue it holds.
	Queue  DispatcherHealthQueue  `json:"queue"`
	Status DispatcherHealthStatus `json:"status"`
}

// DispatcherHealthQueue The queue it holds.
type DispatcherHealthQueue string

// The values of DispatcherHealthQueue.
const (
	DispatcherHealthQueueJetstream DispatcherHealthQueue = "jetstream"
)

// Valid is whether e is one of DispatcherHealthQueue's values.
func (e DispatcherHealthQueue) Valid() bool {
	switch e {
	case DispatcherHealthQueueJetstream:
		return true
	}
	return false
}

type DispatcherHealthStatus string

// The values of DispatcherHealthStatus.
const (
	DispatcherHealthStatusOk DispatcherHealthStatus = "ok"
)

// Valid is whether e is one of DispatcherHealthStatus's values.
func (e DispatcherHealthStatus) Valid() bool {
	switch e {
	case DispatcherHealthStatusOk:
		return true
	}
	return false
}

// DurabilityEvidence How a job's annotations were established as durable —
// the OBSERVATION, never a conclusion drawn from it. 'acknowledged': the
// event log confirmed the batch (mark:commit-ok). 'probe-confirmed': the
// acknowledgement was lost and a later read found the batch's last annotation
// present — true, but a weaker claim than an ack, since it rests on the log
// appending a batch in order and stopping at the first failure.
// 'probe-refused': the read returned a failure reply; note this does NOT
// assert the annotations are absent, because a read that failed for its own
// reasons answers on the same channel. 'probe-unreachable': no answer came at
// all, so nothing was established either way. ABSENT means the question never
// arose — a job that committed no annotations. Never defaulted: a
// manufactured value here is a claim nobody made, in a log nobody can
// rewrite.
type DurabilityEvidence string

// The values of DurabilityEvidence.
const (
	DurabilityEvidenceAcknowledged     DurabilityEvidence = "acknowledged"
	DurabilityEvidenceProbeConfirmed   DurabilityEvidence = "probe-confirmed"
	DurabilityEvidenceProbeRefused     DurabilityEvidence = "probe-refused"
	DurabilityEvidenceProbeUnreachable DurabilityEvidence = "probe-unreachable"
)

// Valid is whether e is one of DurabilityEvidence's values.
func (e DurabilityEvidence) Valid() bool {
	switch e {
	case DurabilityEvidenceAcknowledged, DurabilityEvidenceProbeConfirmed, DurabilityEvidenceProbeRefused, DurabilityEvidenceProbeUnreachable:
		return true
	}
	return false
}

// EmbeddingConfig The embedding provider a service asks for vectors, and what
// that kind of provider needs to be asked: one of the providers
// `xynolog-vectors` has, told apart by `type`. Two services that share an
// index name the same provider and the same model: a vector is compared only
// with vectors of the model that made it. A secret is never a value here: a
// provider's key is named by the environment variable that holds it.
type EmbeddingConfig struct {
	union[embeddingConfigMember]
}

// embeddingConfigMember is a member of EmbeddingConfig:
// OllamaEmbeddingConfig, VoyageEmbeddingConfig.
type embeddingConfigMember interface {
	memberOfEmbeddingConfig()
}

// Discriminator is the `type` this value states.
func (u EmbeddingConfig) Discriminator() (string, error) { return u.stated("type") }

// ValueByDiscriminator is the member this value's `type` names.
func (u EmbeddingConfig) ValueByDiscriminator() (any, error) {
	tag, err := u.Discriminator()
	if err != nil {
		return nil, err
	}
	switch tag {
	case "ollama":
		return as[OllamaEmbeddingConfig](u.union)
	case "voyage":
		return as[VoyageEmbeddingConfig](u.union)
	}
	return nil, unnamedMember("EmbeddingConfig", "type", tag)
}

// EmptyObject is an object with no properties.
type EmptyObject struct{}

func (EmptyObject) memberOfJobStoredProgress() {}
func (EmptyObject) memberOfJobStoredResult()   {}

// Engine An engine: an inference provider and a model, which software does a
// job or an actor's step with. An engine is not a principal: the principal
// that used one names it on each write it produced with it (`generator`). A
// person who does a job uses none.
type Engine struct {
	// Model The model identifier, as the provider names it.
	Model string `json:"model"`
	// Provider The inference provider: who serves the model. `anthropic`,
	// `google`, `openai` and `together` are those companies' own APIs.
	// `llamacpp`, `ollama` and `vllm` are servers a deployment runs or reaches,
	// each named for the server's software.
	Provider EngineProvider `json:"provider"`
}

// EngineEntry One of the knowledge base's engines: a provider and a model its
// Inference document names, and the jobs the document has it used for. An
// engine is not a principal: whichever worker claims a job does it, under its
// own account, and names on each write the engine it used, if any. Carries no
// inference limits: the services that hold the inference credentials report
// those (InferenceLimitsResult).
type EngineEntry struct {
	Engine Engine `json:"engine"`
	// Jobs The jobs the knowledge base's Inference document has this engine used
	// for, as a claim names them. Absent for an engine only Librarian actors
	// ask.
	Jobs *[]JobFilter `json:"jobs,omitempty"`
}

// EngineLimits The discovered limits of one engine.
type EngineLimits struct {
	Engine Engine          `json:"engine"`
	Limits InferenceLimits `json:"limits"`
}

// EngineProvider The inference provider: who serves the model. `anthropic`,
// `google`, `openai` and `together` are those companies' own APIs.
// `llamacpp`, `ollama` and `vllm` are servers a deployment runs or reaches,
// each named for the server's software.
type EngineProvider string

// The values of EngineProvider.
const (
	EngineProviderAnthropic EngineProvider = "anthropic"
	EngineProviderGoogle    EngineProvider = "google"
	EngineProviderLlamacpp  EngineProvider = "llamacpp"
	EngineProviderOllama    EngineProvider = "ollama"
	EngineProviderOpenai    EngineProvider = "openai"
	EngineProviderTogether  EngineProvider = "together"
	EngineProviderVllm      EngineProvider = "vllm"
)

// Valid is whether e is one of EngineProvider's values.
func (e EngineProvider) Valid() bool {
	switch e {
	case EngineProviderAnthropic, EngineProviderGoogle, EngineProviderLlamacpp, EngineProviderOllama, EngineProviderOpenai, EngineProviderTogether, EngineProviderVllm:
		return true
	}
	return false
}

// EnrichedResourceEvent Wire format for persisted events delivered over the
// bus SSE stream (GET /bus/subscribe). Extends StoredEventResponse with
// optional enrichment fields the EventStore populates from the materialized
// view at publish time (persistence → view → enrich → notification).
// Subscribers read the enrichment fields directly to update local caches
// without an additional fetch.
type EnrichedResourceEvent struct {
	// Annotation Populated for events that mutate an annotation (mark:added,
	// mark:body-updated, mark:removed). Carries the post-materialization
	// annotation as it exists in the view, so subscribers can update local
	// caches in-place without refetching. Absent for events that don't touch
	// annotations.
	Annotation *Annotation `json:"annotation,omitempty"`
	// Id Unique event ID (UUID)
	Id       string        `json:"id"`
	Metadata EventMetadata `json:"metadata"`
	// Payload Event-type-specific payload
	Payload map[string]any `json:"payload"`
	// ResourceId Resource this event affects (absent for system events)
	ResourceId *ResourceId `json:"resourceId,omitempty"`
	// Timestamp When the event occurred
	Timestamp string `json:"timestamp"`
	// Type Event type (flow verb name, e.g. mark:added)
	Type string `json:"type"`
	// UserId DID of the user who triggered the event
	UserId UserId `json:"userId"`
	// Version Event schema version
	Version int `json:"version"`
}

// EntityTagChangedPayload Payload for mark:entity-tag-added and
// mark:entity-tag-removed domain events
type EntityTagChangedPayload struct {
	EntityType string `json:"entityType"`
}

// EntityTypeAddedPayload Payload for frame:entity-type-added domain event
// (system-level, no resourceId — fan-out is global)
type EntityTypeAddedPayload struct {
	EntityType string `json:"entityType"`
}

// EntityTypesProjection The knowledge base's entity-type vocabulary: the file
// `projections/__system__/entitytypes.json` under the state directory, the
// sum of the `frame:entity-type-added` events. Written as JSON indented by
// two spaces.
type EntityTypesProjection struct {
	// EntityTypes Every entity type added, each once, sorted.
	EntityTypes []string `json:"entityTypes"`
}

// MarshalJSON writes v, each list its schema requires that Go holds as nil
// written as the empty list.
func (v EntityTypesProjection) MarshalJSON() ([]byte, error) {
	type written EntityTypesProjection
	v.EntityTypes = listOf(v.EntityTypes)
	return json.Marshal(written(v))
}

// EphemeralEventId `e-<publishId>` — the id of any other frame, given once
// when the frame is published: the same on every connection that carries it,
// through every replica, so a copy arriving on two connections (a reconnect
// overlap) dedups. Never a resumption watermark.
type (
	EphemeralEventId = string
)

// ErrorResponse The body of every error the gateway answers, whatever the
// status and whatever the route — including a path it does not serve.
type ErrorResponse struct {
	// Code A machine-readable class, when the route defines one.
	Code    *string `json:"code,omitempty"`
	Details any     `json:"details,omitempty"`
	// Error What went wrong, in a sentence.
	Error string `json:"error"`
	// Hint What the caller can do about it, when there is something to say.
	Hint *string `json:"hint,omitempty"`
}

// EventMetadata Metadata added at persistence time. Part of every
// StoredEvent. Integrity is provided by git at the commit level (when gitSync
// is enabled), not by in-event metadata fields.
type EventMetadata struct {
	// SequenceNumber Monotonic position in the event log (ordering authority)
	SequenceNumber int `json:"sequenceNumber"`
}

// ExtractedText A successful extraction: the anchored text plus its
// provenance. The 'extracted' member of ExtractionOutcome, the record the
// anchored-text store holds.
type ExtractedText struct {
	// Items Positioned runs indexing `text`, roughly one per word.
	Items []PdfTextItem `json:"items"`
	// Kind Discriminant — both ExtractionOutcome members carry `kind`,
	// single-valued: the category here, the detail in `method`.
	Kind ExtractedTextKind `json:"kind"`
	// Method How the text was extracted.
	Method ExtractionMethod `json:"method"`
	// OcrConfidence How well the engine read the pixels, when any of this text
	// came from OCR.
	OcrConfidence *OcrConfidence `json:"ocrConfidence,omitempty"`
	// PdfClass PDF classification, when the source was a PDF.
	PdfClass *PdfClass `json:"pdfClass,omitempty"`
	// Text Reading-order text of the whole resource.
	Text string `json:"text"`
	// UnreadPages 1-indexed pages this extraction could not read — present only
	// for partially covered documents (class C).
	UnreadPages *[]int `json:"unreadPages,omitempty"`
}

func (ExtractedText) memberOfAnchoredTextAnswer() {}
func (ExtractedText) memberOfExtractionOutcome()  {}
func (ExtractedText) told() (string, string)      { return "kind", "extracted" }

// MarshalJSON writes v, each list its schema requires that Go holds as nil
// written as the empty list.
func (v ExtractedText) MarshalJSON() ([]byte, error) {
	type written ExtractedText
	v.Items = listOf(v.Items)
	return json.Marshal(written(v))
}

// ExtractedTextKind Discriminant — both ExtractionOutcome members carry
// `kind`, single-valued: the category here, the detail in `method`.
type ExtractedTextKind string

// The values of ExtractedTextKind.
const (
	ExtractedTextKindExtracted ExtractedTextKind = "extracted"
)

// Valid is whether e is one of ExtractedTextKind's values.
func (e ExtractedTextKind) Valid() bool {
	switch e {
	case ExtractedTextKindExtracted:
		return true
	}
	return false
}

// ExtractionDeclined A named decline: extraction ran and yielded nothing, by
// class. A first-class, cacheable outcome — 'we ran and there was nothing'
// costs a full recognition pass to discover.
type ExtractionDeclined struct {
	// Declined Why extraction yielded nothing, by class.
	Declined ExtractionDeclinedReason `json:"declined"`
	// Kind Discriminant — both ExtractionOutcome members carry `kind`,
	// single-valued: the category here, the detail in `declined`.
	Kind ExtractionDeclinedKind `json:"kind"`
}

func (ExtractionDeclined) memberOfAnchoredTextAnswer() {}
func (ExtractionDeclined) memberOfExtractionOutcome()  {}
func (ExtractionDeclined) told() (string, string)      { return "kind", "declined" }

// ExtractionDeclinedKind Discriminant — both ExtractionOutcome members carry
// `kind`, single-valued: the category here, the detail in `declined`.
type ExtractionDeclinedKind string

// The values of ExtractionDeclinedKind.
const (
	ExtractionDeclinedKindDeclined ExtractionDeclinedKind = "declined"
)

// Valid is whether e is one of ExtractionDeclinedKind's values.
func (e ExtractionDeclinedKind) Valid() bool {
	switch e {
	case ExtractionDeclinedKindDeclined:
		return true
	}
	return false
}

// ExtractionDeclinedReason Why extraction yielded nothing, by class.
type ExtractionDeclinedReason string

// The values of ExtractionDeclinedReason.
const (
	ExtractionDeclinedReasonNoTextLayer ExtractionDeclinedReason = "no-text-layer"
	ExtractionDeclinedReasonEncrypted   ExtractionDeclinedReason = "encrypted"
	ExtractionDeclinedReasonCorrupt     ExtractionDeclinedReason = "corrupt"
	ExtractionDeclinedReasonTooLarge    ExtractionDeclinedReason = "too-large"
)

// Valid is whether e is one of ExtractionDeclinedReason's values.
func (e ExtractionDeclinedReason) Valid() bool {
	switch e {
	case ExtractionDeclinedReasonNoTextLayer, ExtractionDeclinedReasonEncrypted, ExtractionDeclinedReasonCorrupt, ExtractionDeclinedReasonTooLarge:
		return true
	}
	return false
}

// ExtractionMethod How a text was extracted: a plain text taken as it is, a
// PDF's text layer read, a grid written as rows, a filled form's values read,
// or pixels read by OCR.
type ExtractionMethod string

// The values of ExtractionMethod.
const (
	ExtractionMethodTextPassthrough ExtractionMethod = "text-passthrough"
	ExtractionMethodPdfTextLayer    ExtractionMethod = "pdf-text-layer"
	ExtractionMethodTable           ExtractionMethod = "table"
	ExtractionMethodForm            ExtractionMethod = "form"
	ExtractionMethodOcr             ExtractionMethod = "ocr"
)

// Valid is whether e is one of ExtractionMethod's values.
func (e ExtractionMethod) Valid() bool {
	switch e {
	case ExtractionMethodTextPassthrough, ExtractionMethodPdfTextLayer, ExtractionMethodTable, ExtractionMethodForm, ExtractionMethodOcr:
		return true
	}
	return false
}

// ExtractionOutcome The full outcome of text extraction for one
// representation — the record the anchored-text store holds and the wire
// serves. Discriminated on `kind`: 'extracted' — the anchored text with its
// provenance; 'declined' — a named decline. ocrConfidence is extraction
// quality for operators, deliberately not anchor confidence.
type ExtractionOutcome struct {
	union[extractionOutcomeMember]
}

// extractionOutcomeMember is a member of ExtractionOutcome: ExtractedText,
// ExtractionDeclined.
type extractionOutcomeMember interface {
	memberOfExtractionOutcome()
}

// Discriminator is the `kind` this value states.
func (u ExtractionOutcome) Discriminator() (string, error) { return u.stated("kind") }

// ValueByDiscriminator is the member this value's `kind` names.
func (u ExtractionOutcome) ValueByDiscriminator() (any, error) {
	tag, err := u.Discriminator()
	if err != nil {
		return nil, err
	}
	switch tag {
	case "extracted":
		return as[ExtractedText](u.union)
	case "declined":
		return as[ExtractionDeclined](u.union)
	}
	return nil, unnamedMember("ExtractionOutcome", "kind", tag)
}

// FailureClass The class of a job's failure, stated by the worker, where the
// failure is still typed: at the gateway it is already text, and classing a
// failure by its text is what this exists to avoid. A job no worker
// concluded, because its worker stopped reporting, is classed by the
// dispatcher, as 'transient'. Each value is a claim. 'transient': nothing
// about the request was judged (the worker's own bound ran out, the provider
// said not now), so another attempt may succeed. 'deterministic': the same
// request cannot succeed on a second attempt. 'withheld': the model's
// provider had the request and withheld its answer, by a refusal or a content
// filter, and the same request is withheld again; nothing broke. A
// 'deterministic' or a 'withheld' failure is not retried, whatever retry
// budget is left. ABSENT means the failure was not classified, which is not
// the claim 'transient' makes; it is retried as a transient one is. Only a
// failure known to be deterministic or withheld is called so: calling a
// transient failure either one halves reliability, where the reverse costs
// one wasted attempt.
type FailureClass string

// The values of FailureClass.
const (
	FailureClassTransient     FailureClass = "transient"
	FailureClassDeterministic FailureClass = "deterministic"
	FailureClassWithheld      FailureClass = "withheld"
)

// Valid is whether e is one of FailureClass's values.
func (e FailureClass) Valid() bool {
	switch e {
	case FailureClassTransient, FailureClassDeterministic, FailureClassWithheld:
		return true
	}
	return false
}

type FileEntry struct {
	// AnnotationCount Number of annotations on this resource (only when tracked
	// is true)
	AnnotationCount *int `json:"annotationCount,omitempty"`
	// Creator DID of the resource's creator — the first of its derived
	// `wasAttributedTo`, the requester as the knowledge base recorded it (only
	// when tracked is true)
	Creator *string `json:"creator,omitempty"`
	// EntityTypes Entity types assigned to this resource (only when tracked is
	// true)
	EntityTypes *[]string `json:"entityTypes,omitempty"`
	// Mtime Last modified time (ISO 8601)
	Mtime string `json:"mtime"`
	// Name Entry name (basename)
	Name string `json:"name"`
	// Path Path relative to project root
	Path string `json:"path"`
	// ResourceId Resource ID (only when tracked is true)
	ResourceId *ResourceId `json:"resourceId,omitempty"`
	// Size File size in bytes
	Size int `json:"size"`
	// Tracked True if this file is a tracked resource in the Knowledge Base
	Tracked bool          `json:"tracked"`
	Type    FileEntryType `json:"type"`
}

func (FileEntry) memberOfDirectoryEntry() {}
func (FileEntry) told() (string, string)  { return "type", "file" }

type FileEntryType string

// The values of FileEntryType.
const (
	FileEntryTypeFile FileEntryType = "file"
)

// Valid is whether e is one of FileEntryType's values.
func (e FileEntryType) Valid() bool {
	switch e {
	case FileEntryTypeFile:
		return true
	}
	return false
}

// FragmentSelector W3C Web Annotation FragmentSelector for media fragment
// identifiers (RFC 3778 for PDFs)
type FragmentSelector struct {
	// ConformsTo URI identifying the fragment syntax specification
	ConformsTo *string              `json:"conformsTo,omitempty"`
	Type       FragmentSelectorType `json:"type"`
	// Value Media fragment identifier (e.g., 'page=1&viewrect=100,200,50,30' for
	// PDF)
	Value string `json:"value"`
}

func (FragmentSelector) memberOfSelector()      {}
func (FragmentSelector) told() (string, string) { return "type", "FragmentSelector" }

type FragmentSelectorType string

// The values of FragmentSelectorType.
const (
	FragmentSelectorTypeFragmentSelector FragmentSelectorType = "FragmentSelector"
)

// Valid is whether e is one of FragmentSelectorType's values.
func (e FragmentSelectorType) Valid() bool {
	switch e {
	case FragmentSelectorTypeFragmentSelector:
		return true
	}
	return false
}

// FrameAddEntityTypeCommand Bus command to add a new entity type to the KB's
// vocabulary. Carried on the `frame:add-entity-type` channel — Frame is the
// schema-layer flow that owns vocabulary writes.
type FrameAddEntityTypeCommand struct {
	// UserId Authenticated user's DID, injected by the /bus/emit gateway.
	// Clients do not set this.
	UserId *UserId `json:"_userId,omitempty"`
	Tag    string  `json:"tag"`
}

// FrameAddTagSchemaCommand Bus command to register a tag schema with the KB's
// runtime registry. Carried on the `frame:add-tag-schema` channel — Frame is
// the schema-layer flow that owns vocabulary writes. Most-recent registration
// of a given `schema.id` wins; the projection reflects the latest content.
// Identical re-registrations are silent; differing content overwrites and
// logs a warning.
type FrameAddTagSchemaCommand struct {
	// UserId Authenticated user's DID, injected by the /bus/emit gateway.
	// Clients do not set this.
	UserId *UserId   `json:"_userId,omitempty"`
	Schema TagSchema `json:"schema"`
}

// GatewayConfig Everything the gateway reads at boot: nothing in it is
// defaulted by the gateway. The launcher writes it for the gateway it starts
// — from the knowledge base's committed identity and its stack documents —
// and a gateway started any other way is given the same document at the path
// its `--config` flag names (the image passes `/etc/xynolog/gateway.json`).
// Started without `--config`, or with a path that names no file, the gateway
// refuses to start and says which. Secrets are never values here: a field
// that needs one names the environment variable holding it. The gateway's
// other inputs are the environment variables
// specs/src/service-environment/variables.json lists for it, and the ones
// this document names. A document that does not validate is refused at boot —
// the gateway exits without serving — and the refusal names each failing
// field by its JSON pointer.
type GatewayConfig struct {
	// Archivist Where the Archivist listens.
	Archivist ServiceAddress `json:"archivist"`
	// Capacity What this gateway process can hold, from the memory its
	// deployment gives it. `queuedBytes`: the bytes queued for all its streams
	// together; at it, a new stream is refused with 503 (`AtCapacity`, code
	// `capacity`) until the queues drain — each stream's own bound is
	// `x-xynolog-limits.pendingWriteBytes`. `connections`: the connections it
	// holds open at once; one past it is closed unanswered. The launcher derives
	// both from the memory it gives the gateway's container.
	Capacity GatewayConfigCapacity `json:"capacity"`
	// Identity The issuer this knowledge base trusts.
	Identity  GatewayConfigIdentity `json:"identity"`
	Kb        KbIdentity            `json:"kb"`
	LogFormat LogFormat             `json:"logFormat"`
	LogLevel  LogLevel              `json:"logLevel"`
	// Port The port the gateway listens on, on every address the host has: IPv4
	// and IPv6.
	Port int `json:"port"`
	// PublicUrl The URL clients reach this gateway at: the `servers` entry of
	// the OpenAPI document it serves.
	PublicUrl string `json:"publicUrl"`
	// Signal The signal plane: `in-process`, one gateway on its own fabric; or
	// `nats`, the fabric every replica on one broker shares, which requires
	// `servers` and a broker with JetStream.
	Signal GatewayConfigSignal `json:"signal"`
}

// GatewayConfigCapacity What this gateway process can hold, from the memory
// its deployment gives it. `queuedBytes`: the bytes queued for all its
// streams together; at it, a new stream is refused with 503 (`AtCapacity`,
// code `capacity`) until the queues drain — each stream's own bound is
// `x-xynolog-limits.pendingWriteBytes`. `connections`: the connections it
// holds open at once; one past it is closed unanswered. The launcher derives
// both from the memory it gives the gateway's container.
type GatewayConfigCapacity struct {
	Connections int `json:"connections"`
	QueuedBytes int `json:"queuedBytes"`
}

// GatewayConfigIdentity The issuer this knowledge base trusts.
type GatewayConfigIdentity struct {
	// Issuer The issuer URL, exactly as tokens carry it in `iss`.
	Issuer string `json:"issuer"`
	// SubjectClaim The claim a person's DID is built from:
	// `did:web:<domain>:users:<its value>`.
	SubjectClaim string `json:"subjectClaim"`
}

// GatewayConfigSignal The signal plane: `in-process`, one gateway on its own
// fabric; or `nats`, the fabric every replica on one broker shares, which
// requires `servers` and a broker with JetStream.
type GatewayConfigSignal struct {
	// PasswordEnv The environment variable holding the broker password, when the
	// broker requires one.
	PasswordEnv *string `json:"passwordEnv,omitempty"`
	// Servers The broker's address (`host:port`, or several, comma-separated).
	// Required for `nats`.
	Servers *string                 `json:"servers,omitempty"`
	Type    GatewayConfigSignalType `json:"type"`
	// UserEnv The environment variable holding the broker user, when the broker
	// requires one.
	UserEnv *string `json:"userEnv,omitempty"`
}

type GatewayConfigSignalType string

// The values of GatewayConfigSignalType.
const (
	GatewayConfigSignalTypeInProcess GatewayConfigSignalType = "in-process"
	GatewayConfigSignalTypeNats      GatewayConfigSignalType = "nats"
)

// Valid is whether e is one of GatewayConfigSignalType's values.
func (e GatewayConfigSignalType) Valid() bool {
	switch e {
	case GatewayConfigSignalTypeInProcess, GatewayConfigSignalTypeNats:
		return true
	}
	return false
}

// GatherAnnotationComplete Completion payload emitted on the
// gather:annotation-complete bus channel when annotation context gathering
// finishes.
type GatherAnnotationComplete struct {
	// AnnotationId Branded AnnotationId of the annotation whose context was
	// gathered
	AnnotationId AnnotationId `json:"annotationId"`
	// Response The gathered annotation context (unified GatheredContext,
	// focus.kind:'annotation')
	Response GatheredContext `json:"response"`
}

// GatherAnnotationOptions Optional configuration for an annotation-focus
// gather, which windows text around a mark. Distinct from the resource-focus
// options (depth / maxResources / includeContent / includeSummary), which
// traverse the resource graph.
type GatherAnnotationOptions struct {
	// ContextWindow How much of the text on each side of the annotation to
	// include, counted in Unicode code points
	ContextWindow *int `json:"contextWindow,omitempty"`
	// IncludeSourceContext Whether to include source context in the gathered
	// result
	IncludeSourceContext *bool `json:"includeSourceContext,omitempty"`
	// IncludeTargetContext Whether to include target context in the gathered
	// result
	IncludeTargetContext *bool `json:"includeTargetContext,omitempty"`
}

// GatherAnnotationRequest Request payload sent on the gather:requested bus
// channel to gather context for an annotation.
type GatherAnnotationRequest struct {
	// AnnotationId Branded AnnotationId of the annotation to gather context for
	AnnotationId AnnotationId             `json:"annotationId"`
	Options      *GatherAnnotationOptions `json:"options,omitempty"`
	// ResourceId Branded ResourceId of the resource the annotation belongs to
	ResourceId ResourceId `json:"resourceId"`
}

// GatherFailed The payload of `gather:failed`: a CommandError that names the
// annotation whose context could not be gathered.
type GatherFailed struct {
	// AnnotationId The annotation the gather was asked for.
	AnnotationId AnnotationId `json:"annotationId"`
	// Code Machine-readable failure class, for consumers that must BRANCH on why
	// a command failed rather than log it. Optional and deliberately sparse:
	// absent means 'no class declared', and every existing failure stays that
	// way. An enum rather than a free string so the vocabulary has an owner — an
	// unconstrained code is a mirror with no gate, and adding one should be a
	// deliberate spec change. `message` remains the human-readable text and is
	// unaffected. Members: `peer-unavailable` — the channel this command was
	// sent on has no subscriber, i.e. the service that answers it has not
	// connected yet. Transient by nature (a peer still starting), which is what
	// distinguishes it from a refusal: retrying is the correct response.
	// `not-found` — the resource this command addressed does not exist in this
	// knowledge base. A verdict, not a symptom: it is emitted only where the
	// answer comes from the event store, which is the system of record, and
	// never from a projection that may merely be lagging. Deterministic, so
	// unlike `peer-unavailable` retrying is pointless — and consumers may act
	// destructively on it (the SDK deletes a restored tab). Absence is not
	// denial: a future 'exists, but not for you' must travel as its own code,
	// never as this one. `unauthorized` — that code: the caller is authenticated
	// but not permitted to do what it asked. A verdict about the CALLER, not the
	// resource, so retrying under the same credential cannot succeed and a
	// consumer must never spin on it; emitted by `job:claim` for a caller whose
	// token carries no worker role. `none-pending` — a declined claim, not an
	// error: the queue holds no pending job of the requested types. Nothing went
	// wrong; the one code a consumer PARKS on, meaning 'nothing to do until a
	// wake-up'. Emitted by `job:claim` only. A `job:claim` refusal carrying
	// neither is unclassified — a malformed record or a missing injection — and
	// a consumer treats it as 'log it, assume nothing'.
	Code *CommandErrorCode `json:"code,omitempty"`
	// Details Optional additional context (stack trace, field name, etc.)
	Details *string `json:"details,omitempty"`
	// Message Human-readable error message
	Message string `json:"message"`
}

// GatherReferencedByRequest Request for the annotations elsewhere that refer
// to a resource. The Librarian answers from the graph.
type GatherReferencedByRequest struct {
	// Motivation The one motivation the annotations answered have. Every
	// annotation that refers to the resource is answered where none is stated.
	Motivation *Motivation `json:"motivation,omitempty"`
	ResourceId ResourceId  `json:"resourceId"`
}

// GatherReferencedByResult The annotations elsewhere that refer to a resource
type GatherReferencedByResult struct {
	Response GetReferencedByResponse `json:"response"`
}

// GatherResourceComplete Completion payload emitted on the
// gather:resource-complete bus channel when resource context gathering
// finishes.
type GatherResourceComplete struct {
	// ResourceId Branded ResourceId of the resource whose context was gathered
	ResourceId ResourceId `json:"resourceId"`
	// Response The gathered resource context (unified GatheredContext,
	// focus.kind:'resource')
	Response GatheredContext `json:"response"`
}

// GatherResourceFailed The payload of `gather:resource-failed`: a
// CommandError that names the resource whose context could not be gathered.
type GatherResourceFailed struct {
	// Code Machine-readable failure class, for consumers that must BRANCH on why
	// a command failed rather than log it. Optional and deliberately sparse:
	// absent means 'no class declared', and every existing failure stays that
	// way. An enum rather than a free string so the vocabulary has an owner — an
	// unconstrained code is a mirror with no gate, and adding one should be a
	// deliberate spec change. `message` remains the human-readable text and is
	// unaffected. Members: `peer-unavailable` — the channel this command was
	// sent on has no subscriber, i.e. the service that answers it has not
	// connected yet. Transient by nature (a peer still starting), which is what
	// distinguishes it from a refusal: retrying is the correct response.
	// `not-found` — the resource this command addressed does not exist in this
	// knowledge base. A verdict, not a symptom: it is emitted only where the
	// answer comes from the event store, which is the system of record, and
	// never from a projection that may merely be lagging. Deterministic, so
	// unlike `peer-unavailable` retrying is pointless — and consumers may act
	// destructively on it (the SDK deletes a restored tab). Absence is not
	// denial: a future 'exists, but not for you' must travel as its own code,
	// never as this one. `unauthorized` — that code: the caller is authenticated
	// but not permitted to do what it asked. A verdict about the CALLER, not the
	// resource, so retrying under the same credential cannot succeed and a
	// consumer must never spin on it; emitted by `job:claim` for a caller whose
	// token carries no worker role. `none-pending` — a declined claim, not an
	// error: the queue holds no pending job of the requested types. Nothing went
	// wrong; the one code a consumer PARKS on, meaning 'nothing to do until a
	// wake-up'. Emitted by `job:claim` only. A `job:claim` refusal carrying
	// neither is unclassified — a malformed record or a missing injection — and
	// a consumer treats it as 'log it, assume nothing'.
	Code *CommandErrorCode `json:"code,omitempty"`
	// Details Optional additional context (stack trace, field name, etc.)
	Details *string `json:"details,omitempty"`
	// Message Human-readable error message
	Message string `json:"message"`
	// ResourceId The resource the gather was asked for.
	ResourceId ResourceId `json:"resourceId"`
}

// GatherResourceRequest Request payload sent on the gather:resource-requested
// bus channel to gather context for a resource.
type GatherResourceRequest struct {
	Options GatherResourceRequestOptions `json:"options"`
	// ResourceId Branded ResourceId of the resource to gather context for
	ResourceId ResourceId `json:"resourceId"`
}

// GatherResourceRequestOptions Gathering configuration
type GatherResourceRequestOptions struct {
	// Depth How many links out from the resource the knowledge graph reaches,
	// nearest first: 1 is what the resource links to and what cites it, and each
	// further link out adds what those link to and what cites them
	Depth int `json:"depth"`
	// ExcludeEntityTypes Entity types to exclude from the semantic recall built
	// into this context (caller-supplied; e.g. a chat consumer passes
	// ['Question'] so prior questions never ground answer generation). Optional;
	// default none.
	ExcludeEntityTypes *[]string `json:"excludeEntityTypes,omitempty"`
	// IncludeContent Whether to include resource content in the gathered result
	IncludeContent bool `json:"includeContent"`
	// IncludeSummary Whether to include resource summaries in the gathered
	// result
	IncludeSummary bool `json:"includeSummary"`
	// MaxResources Maximum number of related resources to include
	MaxResources int `json:"maxResources"`
}

// GatherSummaryRequest Request to generate an AI summary of an annotation
type GatherSummaryRequest struct {
	AnnotationId AnnotationId `json:"annotationId"`
	ResourceId   ResourceId   `json:"resourceId"`
}

// GatheredContext Context gathered for a gather.* call — consumed by yield.*
// (generation) and the matcher. A shared base (graph, semanticContext,
// metadata, inferredRelationshipSummary) plus a discriminated `focus` that
// names the anchor: an annotation or a whole resource.
type GatheredContext struct {
	// Focus The gather anchor. Discriminated on `kind`.
	Focus GatheredContextFocus `json:"focus"`
	// Graph Knowledge graph backbone — resources AND annotations as typed nodes.
	// The flattened views (connections, citedBy, siblings) are derived from
	// this.
	Graph KnowledgeGraph `json:"graph"`
	// InferredRelationshipSummary LLM-generated summary of the focal anchor's
	// relationships in the knowledge graph
	InferredRelationshipSummary *string `json:"inferredRelationshipSummary,omitempty"`
	// Metadata Context metadata about the focal anchor and its source
	Metadata GatheredContextMetadata `json:"metadata"`
	// SemanticContext Semantically similar passages from across the knowledge
	// base, found via vector search
	SemanticContext *GatheredContextSemanticContext `json:"semanticContext,omitempty"`
}

// GatheredContextFocus The gather anchor. Discriminated on `kind`.
type GatheredContextFocus struct {
	union[gatheredContextFocusMember]
}

// gatheredContextFocusMember is a member of GatheredContextFocus:
// GatheredContextFocusAnnotation, GatheredContextFocusResource.
type gatheredContextFocusMember interface {
	memberOfGatheredContextFocus()
}

// GatheredContextFocusAnnotation Annotation-anchored focus.
type GatheredContextFocusAnnotation struct {
	// Annotation The annotation this context was gathered for
	Annotation Annotation                         `json:"annotation"`
	Kind       GatheredContextFocusAnnotationKind `json:"kind"`
	// Selected Text context around the annotation target
	Selected *GatheredContextFocusAnnotationSelected `json:"selected,omitempty"`
	// SourceResource The resource containing the annotation
	SourceResource ResourceDescriptor `json:"sourceResource"`
	// TargetContext Context about the annotation's link target. Dormant —
	// produced/exposed but not yet consumed.
	TargetContext *GatheredContextFocusAnnotationTargetContext `json:"targetContext,omitempty"`
	// TargetResource The resource the annotation links to, if it is a resolved
	// reference. Dormant capability — produced/exposed but not yet consumed.
	TargetResource *ResourceDescriptor `json:"targetResource,omitempty"`
	// UserHint User-provided hint to supplement or replace the selected text for
	// search and generation
	UserHint *string `json:"userHint,omitempty"`
}

func (GatheredContextFocusAnnotation) memberOfGatheredContextFocus() {}

type GatheredContextFocusAnnotationKind string

// The values of GatheredContextFocusAnnotationKind.
const (
	GatheredContextFocusAnnotationKindAnnotation GatheredContextFocusAnnotationKind = "annotation"
)

// Valid is whether e is one of GatheredContextFocusAnnotationKind's values.
func (e GatheredContextFocusAnnotationKind) Valid() bool {
	switch e {
	case GatheredContextFocusAnnotationKindAnnotation:
		return true
	}
	return false
}

// GatheredContextFocusAnnotationSelected Text context around the annotation
// target
type GatheredContextFocusAnnotationSelected struct {
	// After Text appearing after the selected passage
	After *string `json:"after,omitempty"`
	// Before Text appearing before the selected passage
	Before *string `json:"before,omitempty"`
	// Text The selected text passage (the annotation target)
	Text string `json:"text"`
}

// GatheredContextFocusAnnotationTargetContext Context about the annotation's
// link target. Dormant — produced/exposed but not yet consumed.
type GatheredContextFocusAnnotationTargetContext struct {
	Content string  `json:"content"`
	Summary *string `json:"summary,omitempty"`
}

// GatheredContextFocusResource Whole-resource focus.
type GatheredContextFocusResource struct {
	// Content Resource content (included when requested)
	Content *GatheredContextFocusResourceContent `json:"content,omitempty"`
	Kind    GatheredContextFocusResourceKind     `json:"kind"`
	// Resource The resource this context was gathered for
	Resource            ResourceDescriptor `json:"resource"`
	SuggestedReferences *[]string          `json:"suggestedReferences,omitempty"`
	Summary             *string            `json:"summary,omitempty"`
}

func (GatheredContextFocusResource) memberOfGatheredContextFocus() {}

// GatheredContextFocusResourceContent Resource content (included when
// requested)
type GatheredContextFocusResourceContent struct {
	// Main Content of the focal resource
	Main *string `json:"main,omitempty"`
	// Related Map of related resource IDs to their content
	Related *map[string]string `json:"related,omitempty"`
}

type GatheredContextFocusResourceKind string

// The values of GatheredContextFocusResourceKind.
const (
	GatheredContextFocusResourceKindResource GatheredContextFocusResourceKind = "resource"
)

// Valid is whether e is one of GatheredContextFocusResourceKind's values.
func (e GatheredContextFocusResourceKind) Valid() bool {
	switch e {
	case GatheredContextFocusResourceKindResource:
		return true
	}
	return false
}

// GatheredContextMetadata Context metadata about the focal anchor and its
// source
type GatheredContextMetadata struct {
	// EntityTypeFrequencies Global frequency counts for entity types (for
	// IDF-like weighting). A KB-wide statistic, not a neighborhood property —
	// kept here rather than on the graph.
	EntityTypeFrequencies *map[string]int `json:"entityTypeFrequencies,omitempty"`
	// EntityTypes Entity types associated with the focal anchor
	EntityTypes *[]string `json:"entityTypes,omitempty"`
	// Language BCP 47 language tag of source content
	Language *string `json:"language,omitempty"`
	// ResourceType Type of source resource (e.g., 'document', 'image', 'video')
	ResourceType *string `json:"resourceType,omitempty"`
}

// GatheredContextSemanticContext Semantically similar passages from across
// the knowledge base, found via vector search
type GatheredContextSemanticContext struct {
	// ExcludedEntityTypes Entity types excluded from this recall — a record of
	// how `similar` was filtered (e.g. ['Question'] so answer-generation never
	// surfaces prior questions). Absent when no exclusion was applied.
	ExcludedEntityTypes *[]string `json:"excludedEntityTypes,omitempty"`
	// Similar Passages ranked by cosine similarity to the focal text
	Similar []SemanticMatch `json:"similar"`
}

// MarshalJSON writes v, each list its schema requires that Go holds as nil
// written as the empty list.
func (v GatheredContextSemanticContext) MarshalJSON() ([]byte, error) {
	type written GatheredContextSemanticContext
	v.Similar = listOf(v.Similar)
	return json.Marshal(written(v))
}

// GenerationJobParams The parameters of a `yield` job: what it is asked to
// make (GenerationJobRequest) and the gathered context it is made from. The
// job's resource is derived from `context.focus` by the dispatcher (resource
// focus → focus.resource; annotation focus → focus.sourceResource, with the
// worker binding to focus.annotation), and the dispatcher refuses a parameter
// this schema does not name.
type GenerationJobParams struct {
	// Cite Ask the model to cite its sources, by the ids the gathered context
	// labels its passages with. The model wraps the words a source supports as
	// `[[<id>: <claim>]]`, the ids of several sources separated by commas; a
	// bare `[[<id>]]` is replaced by the source's name. The worker checks every
	// id against the gathered context (an id it did not show is dropped, with a
	// warning), takes every token out of the stored content, and mints a W3C
	// linking annotation on the new resource over exactly the words each token
	// cites.
	Cite *bool `json:"cite,omitempty"`
	// Context The gathered context that grounds the generation. Its `focus`
	// names the anchor: the DISPATCHER derives the job's resourceId from it
	// (resource focus → focus.resource; annotation focus → focus.sourceResource,
	// with the worker auto-binding to focus.annotation) and REJECTS a
	// caller-supplied id — the context is authoritative. Under `cite`, the ids
	// its embedding carries are the only valid citation targets.
	Context GatheredContext `json:"context"`
	// EntityTypes Entity-type tags to stamp on the synthesized resource. Used
	// both as a prompt bias for the generation worker and as the `entityTypes`
	// set on the resulting resource.
	EntityTypes *[]string `json:"entityTypes,omitempty"`
	// Language Annotation/resource body locale — language the generated resource
	// is written in (typically the user's UI locale). BCP-47.
	Language *string `json:"language,omitempty"`
	// MaxTokens Output token budget forwarded to the model. Length never
	// determines structure.
	MaxTokens *float64 `json:"maxTokens,omitempty"`
	// OutputMediaType Requested media type of the generated resource's content.
	// Default `text/markdown` at the worker, which validates it against its
	// supported output set and FAILS the job for anything it can't write — not a
	// silent fallback.
	OutputMediaType *SupportedMediaType `json:"outputMediaType,omitempty"`
	// Prompt Refining instruction, composed with `task` (task = what, prompt =
	// how).
	Prompt *string `json:"prompt,omitempty"`
	// SourceLanguage Source-resource locale — language of the resource being
	// referenced, used in the prompt so the LLM understands embedded
	// source-context snippets when source ≠ target language. BCP-47.
	SourceLanguage *string `json:"sourceLanguage,omitempty"`
	// StorageUri Storage URI for the generated resource's content —
	// AUTHORITATIVE: the worker writes exactly here and never derives a location
	// from the title. Not empty, and there is no fallback: the gateway refuses a
	// `job:create` whose storageUri is.
	StorageUri string `json:"storageUri"`
	// Structure How the output is internally segmented — shape for text-bearing
	// media, subordinate to `outputMediaType` (never its peer). Canonical
	// values: 'prose' (flowing paragraphs), 'sections' (titled sections +
	// title), 'chat' (speaker-labeled turns); any other string becomes a
	// freeform "organize as: …" directive (loud degrade). Unset ⇒ NO structure
	// directive at all — the task framing and the model determine shape.
	Structure *string `json:"structure,omitempty"`
	// Task What the model is asked to produce — the prompt's framing verb.
	// Canonical values ('resource', 'answer', 'summary') map to the worker's
	// tested framings; any other string is used VERBATIM as the framing
	// instruction (loud degrade: the worker warns, never silently falls back).
	// Unset ⇒ 'resource' (article framing).
	Task *string `json:"task,omitempty"`
	// Temperature Sampling temperature forwarded to the model.
	Temperature *float64 `json:"temperature,omitempty"`
	// Title Title of the generated resource. Not empty: the gateway refuses a
	// `job:create` whose title is.
	Title string `json:"title"`
}

// GenerationJobRequest What a `yield` job is asked to make: every parameter
// of GenerationJobParams but its `context`, the input the resource is made
// from. It is what an announcement of the job carries.
type GenerationJobRequest struct {
	// Cite Ask the model to cite its sources, by the ids the gathered context
	// labels its passages with. The model wraps the words a source supports as
	// `[[<id>: <claim>]]`, the ids of several sources separated by commas; a
	// bare `[[<id>]]` is replaced by the source's name. The worker checks every
	// id against the gathered context (an id it did not show is dropped, with a
	// warning), takes every token out of the stored content, and mints a W3C
	// linking annotation on the new resource over exactly the words each token
	// cites.
	Cite *bool `json:"cite,omitempty"`
	// EntityTypes Entity-type tags to stamp on the synthesized resource. Used
	// both as a prompt bias for the generation worker and as the `entityTypes`
	// set on the resulting resource.
	EntityTypes *[]string `json:"entityTypes,omitempty"`
	// Language Annotation/resource body locale — language the generated resource
	// is written in (typically the user's UI locale). BCP-47.
	Language *string `json:"language,omitempty"`
	// MaxTokens Output token budget forwarded to the model. Length never
	// determines structure.
	MaxTokens *float64 `json:"maxTokens,omitempty"`
	// OutputMediaType Requested media type of the generated resource's content.
	// Default `text/markdown` at the worker, which validates it against its
	// supported output set and FAILS the job for anything it can't write — not a
	// silent fallback.
	OutputMediaType *SupportedMediaType `json:"outputMediaType,omitempty"`
	// Prompt Refining instruction, composed with `task` (task = what, prompt =
	// how).
	Prompt *string `json:"prompt,omitempty"`
	// SourceLanguage Source-resource locale — language of the resource being
	// referenced, used in the prompt so the LLM understands embedded
	// source-context snippets when source ≠ target language. BCP-47.
	SourceLanguage *string `json:"sourceLanguage,omitempty"`
	// StorageUri Storage URI for the generated resource's content —
	// AUTHORITATIVE: the worker writes exactly here and never derives a location
	// from the title. Not empty, and there is no fallback: the gateway refuses a
	// `job:create` whose storageUri is.
	StorageUri string `json:"storageUri"`
	// Structure How the output is internally segmented — shape for text-bearing
	// media, subordinate to `outputMediaType` (never its peer). Canonical
	// values: 'prose' (flowing paragraphs), 'sections' (titled sections +
	// title), 'chat' (speaker-labeled turns); any other string becomes a
	// freeform "organize as: …" directive (loud degrade). Unset ⇒ NO structure
	// directive at all — the task framing and the model determine shape.
	Structure *string `json:"structure,omitempty"`
	// Task What the model is asked to produce — the prompt's framing verb.
	// Canonical values ('resource', 'answer', 'summary') map to the worker's
	// tested framings; any other string is used VERBATIM as the framing
	// instruction (loud degrade: the worker warns, never silently falls back).
	// Unset ⇒ 'resource' (article framing).
	Task *string `json:"task,omitempty"`
	// Temperature Sampling temperature forwarded to the model.
	Temperature *float64 `json:"temperature,omitempty"`
	// Title Title of the generated resource. Not empty: the gateway refuses a
	// `job:create` whose title is.
	Title string `json:"title"`
}

type GetAnnotationHistoryResponse struct {
	AnnotationId AnnotationId      `json:"annotationId"`
	Events       []AttributedEvent `json:"events"`
	ResourceId   ResourceId        `json:"resourceId"`
	Total        float64           `json:"total"`
}

// MarshalJSON writes v, each list its schema requires that Go holds as nil
// written as the empty list.
func (v GetAnnotationHistoryResponse) MarshalJSON() ([]byte, error) {
	type written GetAnnotationHistoryResponse
	v.Events = listOf(v.Events)
	return json.Marshal(written(v))
}

type GetAnnotationResponse struct {
	Annotation       Annotation          `json:"annotation"`
	ResolvedResource *ResourceDescriptor `json:"resolvedResource"`
	Resource         *ResourceDescriptor `json:"resource"`
}

type GetAnnotationsResponse struct {
	Annotations []Annotation `json:"annotations"`
	Motivation  *Motivation  `json:"motivation,omitempty"`
	// Total Total number of annotations
	Total float64 `json:"total"`
}

// MarshalJSON writes v, each list its schema requires that Go holds as nil
// written as the empty list.
func (v GetAnnotationsResponse) MarshalJSON() ([]byte, error) {
	type written GetAnnotationsResponse
	v.Annotations = listOf(v.Annotations)
	return json.Marshal(written(v))
}

type GetEntityTypesResponse struct {
	EntityTypes []string `json:"entityTypes"`
}

// MarshalJSON writes v, each list its schema requires that Go holds as nil
// written as the empty list.
func (v GetEntityTypesResponse) MarshalJSON() ([]byte, error) {
	type written GetEntityTypesResponse
	v.EntityTypes = listOf(v.EntityTypes)
	return json.Marshal(written(v))
}

type GetEventsResponse struct {
	Events     []AttributedEvent `json:"events"`
	ResourceId ResourceId        `json:"resourceId"`
	Total      float64           `json:"total"`
}

// MarshalJSON writes v, each list its schema requires that Go holds as nil
// written as the empty list.
func (v GetEventsResponse) MarshalJSON() ([]byte, error) {
	type written GetEventsResponse
	v.Events = listOf(v.Events)
	return json.Marshal(written(v))
}

type GetReferencedByResponse struct {
	ReferencedBy []GetReferencedByResponseReferencedByItem `json:"referencedBy"`
}

// MarshalJSON writes v, each list its schema requires that Go holds as nil
// written as the empty list.
func (v GetReferencedByResponse) MarshalJSON() ([]byte, error) {
	type written GetReferencedByResponse
	v.ReferencedBy = listOf(v.ReferencedBy)
	return json.Marshal(written(v))
}

type GetReferencedByResponseReferencedByItem struct {
	// Id Reference annotation ID
	Id AnnotationId `json:"id"`
	// ResourceName Name of the resource containing the reference. Absent where
	// no description of that resource is held, and where its name is empty.
	ResourceName *string                                       `json:"resourceName,omitempty"`
	Target       GetReferencedByResponseReferencedByItemTarget `json:"target"`
}

type GetReferencedByResponseReferencedByItemTarget struct {
	Selector GetReferencedByResponseReferencedByItemTargetSelector `json:"selector"`
	// Source ID of resource containing the reference
	Source ResourceId `json:"source"`
}

type GetReferencedByResponseReferencedByItemTargetSelector struct {
	// Exact The selected text that references this resource
	Exact string `json:"exact"`
}

type GetResourceByTokenResponse struct {
	// ExpiresAt ISO 8601 timestamp when token expires
	ExpiresAt      string             `json:"expiresAt"`
	SourceResource ResourceDescriptor `json:"sourceResource"`
}

type GetResourceResponse struct {
	// Annotations All annotations for the resource (highlights, references,
	// assessments, etc.)
	Annotations []Annotation       `json:"annotations"`
	Resource    ResourceDescriptor `json:"resource"`
}

// MarshalJSON writes v, each list its schema requires that Go holds as nil
// written as the empty list.
func (v GetResourceResponse) MarshalJSON() ([]byte, error) {
	type written GetResourceResponse
	v.Annotations = listOf(v.Annotations)
	return json.Marshal(written(v))
}

type GetTagSchemasResponse struct {
	TagSchemas []TagSchema `json:"tagSchemas"`
}

// MarshalJSON writes v, each list its schema requires that Go holds as nil
// written as the empty list.
func (v GetTagSchemasResponse) MarshalJSON() ([]byte, error) {
	type written GetTagSchemasResponse
	v.TagSchemas = listOf(v.TagSchemas)
	return json.Marshal(written(v))
}

// GraphAnnotationNode An annotation's graph presence. The node IS the
// annotation, so the full W3C object is required — selectors and body
// included, which is what lets a client place context annotations without a
// second fetch. Citations ride here too: an inbound reference is its linking
// annotation, anchored by an `annotation-of` edge to the resource it lives on
// and a `cites` edge to the focal resource.
type GraphAnnotationNode struct {
	Annotation Annotation `json:"annotation"`
	// EntityTypes Entity types carried by the annotation
	EntityTypes *[]string `json:"entityTypes,omitempty"`
	// Id The AnnotationId — the same value as annotation.id
	Id AnnotationId `json:"id"`
	// Label The annotation's motivation, as a display label
	Label    string                  `json:"label"`
	Metadata *map[string]any         `json:"metadata,omitempty"`
	Type     GraphAnnotationNodeType `json:"type"`
}

func (GraphAnnotationNode) memberOfKnowledgeGraphNodesItem() {}
func (GraphAnnotationNode) told() (string, string)           { return "type", "annotation" }

type GraphAnnotationNodeType string

// The values of GraphAnnotationNodeType.
const (
	GraphAnnotationNodeTypeAnnotation GraphAnnotationNodeType = "annotation"
)

// Valid is whether e is one of GraphAnnotationNodeType's values.
func (e GraphAnnotationNodeType) Valid() bool {
	switch e {
	case GraphAnnotationNodeTypeAnnotation:
		return true
	}
	return false
}

// GraphConfig The graph database a service writes or reads, and what that
// kind of database needs to be reached: one of the kinds `xynolog-graph` has
// a store for, told apart by `type`. A secret is never a value here: a
// database's password is named by the environment variable that holds it.
type GraphConfig struct {
	union[graphConfigMember]
}

// graphConfigMember is a member of GraphConfig: Neo4jGraphConfig,
// JanusGraphConfig, NeptuneGraphConfig, MemoryGraphConfig.
type graphConfigMember interface {
	memberOfGraphConfig()
}

// Discriminator is the `type` this value states.
func (u GraphConfig) Discriminator() (string, error) { return u.stated("type") }

// ValueByDiscriminator is the member this value's `type` names.
func (u GraphConfig) ValueByDiscriminator() (any, error) {
	tag, err := u.Discriminator()
	if err != nil {
		return nil, err
	}
	switch tag {
	case "neo4j":
		return as[Neo4jGraphConfig](u.union)
	case "janusgraph":
		return as[JanusGraphConfig](u.union)
	case "neptune":
		return as[NeptuneGraphConfig](u.union)
	case "memory":
		return as[MemoryGraphConfig](u.union)
	}
	return nil, unnamedMember("GraphConfig", "type", tag)
}

// GraphResourceNode A resource's presence in the gathered knowledge graph.
type GraphResourceNode struct {
	// EntityTypes Entity types on the resource
	EntityTypes *[]string `json:"entityTypes,omitempty"`
	// Id The resource's ResourceId
	Id ResourceId `json:"id"`
	// Label The resource's display name — its raw id when the resource's view
	// was missing at build time
	Label    string                `json:"label"`
	Metadata *map[string]any       `json:"metadata,omitempty"`
	Type     GraphResourceNodeType `json:"type"`
}

func (GraphResourceNode) memberOfKnowledgeGraphNodesItem() {}
func (GraphResourceNode) told() (string, string)           { return "type", "resource" }

type GraphResourceNodeType string

// The values of GraphResourceNodeType.
const (
	GraphResourceNodeTypeResource GraphResourceNodeType = "resource"
)

// Valid is whether e is one of GraphResourceNodeType's values.
func (e GraphResourceNodeType) Valid() bool {
	switch e {
	case GraphResourceNodeTypeResource:
		return true
	}
	return false
}

// HealthResponse Liveness: the process is up and serving. It asks nothing of
// the Archivist or the broker — a gateway that cannot reach them refuses to
// start, so one that answers here got past both at boot.
type HealthResponse struct {
	Message   string `json:"message"`
	Status    string `json:"status"`
	Timestamp string `json:"timestamp"`
	Version   string `json:"version"`
}

// HighlightingJobParams What a highlighting job takes: passages of the
// resource worth a reader's attention are marked, with no text of the job's
// own.
type HighlightingJobParams struct {
	// Density How many annotations to aim for per 2000 words of the resource.
	Density *float64 `json:"density,omitempty"`
	// Instructions What to look for, in the caller's words. Added to the prompt.
	Instructions *string                         `json:"instructions,omitempty"`
	Motivation   HighlightingJobParamsMotivation `json:"motivation"`
	// SourceLanguage The language of the resource being read. BCP 47.
	SourceLanguage *string `json:"sourceLanguage,omitempty"`
}

func (HighlightingJobParams) memberOfMarkJobParams() {}
func (HighlightingJobParams) told() (string, string) { return "motivation", "highlighting" }

type HighlightingJobParamsMotivation string

// The values of HighlightingJobParamsMotivation.
const (
	HighlightingJobParamsMotivationHighlighting HighlightingJobParamsMotivation = "highlighting"
)

// Valid is whether e is one of HighlightingJobParamsMotivation's values.
func (e HighlightingJobParamsMotivation) Valid() bool {
	switch e {
	case HighlightingJobParamsMotivationHighlighting:
		return true
	}
	return false
}

// HttpEndpoint A knowledge base reached through its gateway, over HTTP. The
// gateway's origin is the protocol, the host in lowercase and the port; a
// host that is not a host's name is refused before it is put into a URL
// (specs/src/session/gateway-url-cases.json).
type HttpEndpoint struct {
	// Host The gateway's host, as a person or a discovery document gave it.
	Host string `json:"host"`
	// Kind Discriminant: the endpoint is a gateway reached over HTTP.
	Kind HttpEndpointKind `json:"kind"`
	// Port The gateway's port.
	Port int `json:"port"`
	// Protocol What the gateway is reached over.
	Protocol HttpEndpointProtocol `json:"protocol"`
}

func (HttpEndpoint) memberOfKbEndpoint()    {}
func (HttpEndpoint) told() (string, string) { return "kind", "http" }

// HttpEndpointKind Discriminant: the endpoint is a gateway reached over HTTP.
type HttpEndpointKind string

// The values of HttpEndpointKind.
const (
	HttpEndpointKindHttp HttpEndpointKind = "http"
)

// Valid is whether e is one of HttpEndpointKind's values.
func (e HttpEndpointKind) Valid() bool {
	switch e {
	case HttpEndpointKindHttp:
		return true
	}
	return false
}

// HttpEndpointProtocol What the gateway is reached over.
type HttpEndpointProtocol string

// The values of HttpEndpointProtocol.
const (
	HttpEndpointProtocolHttp  HttpEndpointProtocol = "http"
	HttpEndpointProtocolHttps HttpEndpointProtocol = "https"
)

// Valid is whether e is one of HttpEndpointProtocol's values.
func (e HttpEndpointProtocol) Valid() bool {
	switch e {
	case HttpEndpointProtocolHttp, HttpEndpointProtocolHttps:
		return true
	}
	return false
}

// InferenceLimits A provider's actual ceilings for a model, discovered from
// the provider itself (Anthropic Models API; Ollama /api/show) — never
// hand-maintained constants. Semantics differ by provider shape: Anthropic
// reports maximum input tokens in contextTokens with a separate output
// ceiling in maxOutputTokens; Ollama reports the shared input+output window
// and mirrors it into both fields (there is no separate output ceiling), so
// maxOutputTokens === contextTokens signals a shared window.
type InferenceLimits struct {
	// AcceptsTemperature Whether this engine accepts a caller-supplied sampling
	// temperature, measured against the provider (Anthropic: an active probe at
	// discovery, because some models reject the parameter outright and the
	// Models API does not say; Ollama: always true). Consumers treat only an
	// explicit false as 'hide temperature controls' — absence means no claim.
	AcceptsTemperature *bool `json:"acceptsTemperature,omitempty"`
	// ContextTokens The context window in tokens. Anthropic: maximum input
	// tokens (output has its own ceiling). Ollama: the shared input+output
	// window.
	ContextTokens float64 `json:"contextTokens"`
	// MaxOutputTokens Maximum output tokens per generation. Equal to
	// contextTokens when the provider has a single shared window.
	MaxOutputTokens float64 `json:"maxOutputTokens"`
}

// InferenceLimitsRequest Request for the inference limits of the engines one
// service holds a client for. Answered on job:limits-requested by the worker,
// and on gather:limits-requested and match:limits-requested by the librarian:
// each service that holds an inference credential reports for its own
// engines, so no other service needs one.
type (
	InferenceLimitsRequest = map[string]any
)

// InferenceLimitsResult The inference limits one service discovered for the
// engines it holds a client for. An engine whose discovery is currently
// unavailable is absent.
type InferenceLimitsResult struct {
	Response InferenceLimitsResultResponse `json:"response"`
}

type InferenceLimitsResultResponse struct {
	Limits []EngineLimits `json:"limits"`
}

// MarshalJSON writes v, each list its schema requires that Go holds as nil
// written as the empty list.
func (v InferenceLimitsResultResponse) MarshalJSON() ([]byte, error) {
	type written InferenceLimitsResultResponse
	v.Limits = listOf(v.Limits)
	return json.Marshal(written(v))
}

// JanusGraphConfig A graph kept in a JanusGraph server, asked in Gremlin. No
// service has been run against one.
type JanusGraphConfig struct {
	// Host The server's host.
	Host string `json:"host"`
	// Port The port its Gremlin endpoint listens on.
	Port int                  `json:"port"`
	Type JanusGraphConfigType `json:"type"`
}

func (JanusGraphConfig) memberOfGraphConfig()   {}
func (JanusGraphConfig) told() (string, string) { return "type", "janusgraph" }

type JanusGraphConfigType string

// The values of JanusGraphConfigType.
const (
	JanusGraphConfigTypeJanusgraph JanusGraphConfigType = "janusgraph"
)

// Valid is whether e is one of JanusGraphConfigType's values.
func (e JanusGraphConfigType) Valid() bool {
	switch e {
	case JanusGraphConfigTypeJanusgraph:
		return true
	}
	return false
}

// Job A job as the dispatcher holds it. Its `status` decides which timestamps
// and outcome fields it carries. It is what a claim returns (`job:claimed`,
// always `running`) and what the queue stores, inside a JobRecord.
type Job struct {
	union[jobMember]
}

// jobMember is a member of Job: JobPending, JobRunning, JobComplete,
// JobFailed, JobCancelled.
type jobMember interface {
	memberOfJob()
}

// Discriminator is the `status` this value states.
func (u Job) Discriminator() (string, error) { return u.stated("status") }

// ValueByDiscriminator is the member this value's `status` names.
func (u Job) ValueByDiscriminator() (any, error) {
	tag, err := u.Discriminator()
	if err != nil {
		return nil, err
	}
	switch tag {
	case "pending":
		return as[JobPending](u.union)
	case "running":
		return as[JobRunning](u.union)
	case "complete":
		return as[JobComplete](u.union)
	case "failed":
		return as[JobFailed](u.union)
	case "cancelled":
		return as[JobCancelled](u.union)
	}
	return nil, unnamedMember("Job", "status", tag)
}

// JobAssignCommand Bus command the dispatcher emits, under its own service
// identity, immediately after it accepts a job:claim — the correlated
// job:claimed reply is unchanged. The Stower persists it as job:assigned. It
// is the one fact only the dispatcher can vouch for: which holder took which
// job, and who requested it. A later write citing `jobId` is checked against
// the holder and its `creator` derived from the requester by reading the
// resource's own log, with nothing outside the record.
type JobAssignCommand struct {
	// UserId The dispatcher's service DID, injected by the /bus/emit gateway.
	// Clients do not set this.
	UserId *UserId `json:"_userId,omitempty"`
	// Holder DID of the claimant whose claim was accepted — the `_userId` the
	// gateway stamped on the job:claim, restated by the dispatcher.
	Holder  UserId  `json:"holder"`
	JobId   JobId   `json:"jobId"`
	JobType JobType `json:"jobType"`
	// Requester DID of the emitter of the job:create that produced this job —
	// the `_userId` the gateway stamped on that create, restated by the
	// dispatcher.
	Requester UserId `json:"requester"`
	// ResourceId The job's resource — for a generation, the source it generates
	// from. The assignment is persisted on this resource's log.
	ResourceId ResourceId `json:"resourceId"`
}

// JobAssignedPayload Payload for job:assigned — the dispatcher's own record
// that it accepted a claim. Emitted by the dispatcher under its service
// identity after a successful job:claim (the correlated job:claimed reply is
// unchanged). This is the one fact only the dispatcher can vouch for: which
// holder took which job, and who requested it. The Stower persists it beside
// job:started so that a write citing `jobId` can be checked against the
// holder and its `creator` derived from the requester with no read outside
// the event log.
type JobAssignedPayload struct {
	// Holder DID of the emitter whose claim the dispatcher accepted. The bus
	// stamped it on the job:claim as `_userId`; the dispatcher restates it here
	// under its own identity.
	Holder  UserId  `json:"holder"`
	JobId   JobId   `json:"jobId"`
	JobType JobType `json:"jobType"`
	// Requester DID of the emitter of the job:create that produced this job. The
	// dispatcher restates the `_userId` the gateway stamped on that create.
	Requester UserId `json:"requester"`
	// ResourceId The job's resource — for a generation, the source it generates
	// from. Job events are scoped here.
	ResourceId ResourceId `json:"resourceId"`
}

// JobCancelCommand A worker's settling of a running job it holds whose work
// it has stopped for a cancellation — the queue moves the job to cancelled/.
// Distinct from JobCancelRequest (the client→worker REQUEST to stop): this is
// the worker announcing it did, so the running job is never yanked to
// cancelled/ out from under a live worker (the roach-motel race).
type JobCancelCommand struct {
	// UserId Authenticated user's DID, injected by the /bus/emit gateway.
	// Clients do not set this.
	UserId *UserId `json:"_userId,omitempty"`
	// AnnotationId Annotation this job is attached to, when applicable. Lets the
	// UI route cancellation feedback to a specific annotation.
	AnnotationId *AnnotationId `json:"annotationId,omitempty"`
	// CompletedUnits The units the worker had finished when it stopped. Recorded
	// on the cancelled job's metadata so the work already done stays visible.
	CompletedUnits *[]string  `json:"completedUnits,omitempty"`
	JobId          JobId      `json:"jobId"`
	JobType        JobType    `json:"jobType"`
	ResourceId     ResourceId `json:"resourceId"`
	// UnitCursors The furthest each unit begun got, keyed by unit, with what it
	// had counted there — the grain `completedUnits` cannot express. A unit
	// named in `completedUnits` is stated here too, by the cursor it ended at: a
	// later attempt skips it whole and counts it by that cursor. A cursor never
	// says a unit is finished; only `completedUnits` does. Merged monotonically
	// per unit, finished or not: a stale snapshot must never move a cursor
	// backward.
	UnitCursors *map[string]UnitCursor `json:"unitCursors,omitempty"`
}

// JobCancelRequest Request to cancel one job, named by its id. A pending job
// is cancelled immediately by the dispatcher. A running job is cancelled only
// by the worker that holds it: the worker stops its work and settles the job
// with `job:cancel` (JobCancelCommand). The queue is never made to yank a
// running job out from under a live worker.
type JobCancelRequest struct {
	JobId JobId `json:"jobId"`
}

// JobCancelResult What a cancel did, in the `response` of `job:cancel-ok`:
// whether the queue acted on the job it named. A pending job is cancelled
// outright; a running one is left to its worker, so for it true means
// accepted, not stopped.
type JobCancelResult struct {
	// Cancelled True when the queue acted on the job; false when the job is
	// unknown or already over.
	Cancelled bool `json:"cancelled"`
}

// JobCancelled A job cancelled before it concluded.
type JobCancelled struct {
	// CompletedAt When it was cancelled.
	CompletedAt string      `json:"completedAt"`
	Metadata    JobMetadata `json:"metadata"`
	Params      JobParams   `json:"params"`
	// StartedAt When its claim was made; absent when it was cancelled while
	// pending.
	StartedAt *string            `json:"startedAt,omitempty"`
	Status    JobCancelledStatus `json:"status"`
}

func (JobCancelled) memberOfJob()           {}
func (JobCancelled) told() (string, string) { return "status", "cancelled" }

type JobCancelledStatus string

// The values of JobCancelledStatus.
const (
	JobCancelledStatusCancelled JobCancelledStatus = "cancelled"
)

// Valid is whether e is one of JobCancelledStatus's values.
func (e JobCancelledStatus) Valid() bool {
	switch e {
	case JobCancelledStatusCancelled:
		return true
	}
	return false
}

// JobCheckpointCommand Command to persist a running job's completed-unit
// checkpoint AT unit completion. Distinct from JobFailCommand's checkpoint,
// which lands only on a clean failure: a worker that dies (crash/OOM/kill)
// never emits job:fail, so this durable, unthrottled write is what lets the
// janitor's stale-running recovery resume a dead worker's job rather than
// redo its finished units.
type JobCheckpointCommand struct {
	// UserId Authenticated user's DID, injected by the /bus/emit gateway.
	// Clients do not set this.
	UserId *UserId `json:"_userId,omitempty"`
	// CompletedUnits Entity-type units whose annotations have been fully emitted
	// so far. Unioned into the running job's metadata checkpoint; a retry after
	// recovery skips them.
	CompletedUnits []string `json:"completedUnits"`
	JobId          JobId    `json:"jobId"`
	// UnitCursors The furthest each unit begun got, keyed by unit, with what it
	// had counted there — the grain `completedUnits` cannot express. A unit
	// named in `completedUnits` is stated here too, by the cursor it ended at: a
	// later attempt skips it whole and counts it by that cursor. A cursor never
	// says a unit is finished; only `completedUnits` does. Merged monotonically
	// per unit, finished or not: a stale snapshot must never move a cursor
	// backward.
	UnitCursors *map[string]UnitCursor `json:"unitCursors,omitempty"`
}

// MarshalJSON writes v, each list its schema requires that Go holds as nil
// written as the empty list.
func (v JobCheckpointCommand) MarshalJSON() ([]byte, error) {
	type written JobCheckpointCommand
	v.CompletedUnits = listOf(v.CompletedUnits)
	return json.Marshal(written(v))
}

// JobClaimCommand Claim the NEXT pending job that matches one of `accepts`
// (atomic: pending → running). A job:queued announcement is a WAKE-UP, not a
// reservation: the claimed job may differ from the announced one, and two
// claims after one announcement both succeed on different jobs instead of
// racing for one. job:claimed carries the claimed job; job:claim-failed
// reports that nothing matching is pending.
type JobClaimCommand struct {
	// Roles The claimant's capabilities (the token's `roles`), injected by the
	// /bus/emit gateway. Clients do not set this. The dispatcher authorizes the
	// claim by capability — it admits the claim only when this carries the
	// worker role — so a claimant that is not a worker for this knowledge base
	// is refused before the queue is consulted.
	Roles *[]string `json:"_roles,omitempty"`
	// UserId Authenticated claimant's DID, injected by the /bus/emit gateway.
	// Clients do not set this. The dispatcher records it as the holder on
	// job:assigned.
	UserId *UserId `json:"_userId,omitempty"`
	// Accepts The jobs this claim takes. A job is handed over when it matches
	// any one of them.
	Accepts []JobFilter `json:"accepts"`
}

// MarshalJSON writes v, each list its schema requires that Go holds as nil
// written as the empty list.
func (v JobClaimCommand) MarshalJSON() ([]byte, error) {
	type written JobClaimCommand
	v.Accepts = listOf(v.Accepts)
	return json.Marshal(written(v))
}

// JobClaimedResult The reply to a successful `job:claim`: the claimed job,
// now running under the claimant.
type JobClaimedResult struct {
	Response JobRunning `json:"response"`
}

// JobComplete A job its worker completed.
type JobComplete struct {
	// CompletedAt When it completed.
	CompletedAt string          `json:"completedAt"`
	Metadata    JobMetadata     `json:"metadata"`
	Params      JobParams       `json:"params"`
	Result      JobStoredResult `json:"result"`
	// StartedAt When the claim that completed it was made.
	StartedAt string            `json:"startedAt"`
	Status    JobCompleteStatus `json:"status"`
}

func (JobComplete) memberOfJob()           {}
func (JobComplete) told() (string, string) { return "status", "complete" }

// JobCompleteCommand A job's worker says the job is complete. The result it
// carries is its verb's: a `mark` job's counts or the resource a `yield` job
// made, or a decline from either. A completion whose result is the other
// verb's is refused where the command is admitted.
type JobCompleteCommand struct {
	union[jobCompleteCommandMember]
}

// jobCompleteCommandMember is a member of JobCompleteCommand:
// MarkJobCompleteCommand, YieldJobCompleteCommand.
type jobCompleteCommandMember interface {
	memberOfJobCompleteCommand()
}

// Discriminator is the `jobType` this value states.
func (u JobCompleteCommand) Discriminator() (string, error) { return u.stated("jobType") }

// ValueByDiscriminator is the member this value's `jobType` names.
func (u JobCompleteCommand) ValueByDiscriminator() (any, error) {
	tag, err := u.Discriminator()
	if err != nil {
		return nil, err
	}
	switch tag {
	case "mark":
		return as[MarkJobCompleteCommand](u.union)
	case "yield":
		return as[YieldJobCompleteCommand](u.union)
	}
	return nil, unnamedMember("JobCompleteCommand", "jobType", tag)
}

type JobCompleteStatus string

// The values of JobCompleteStatus.
const (
	JobCompleteStatusComplete JobCompleteStatus = "complete"
)

// Valid is whether e is one of JobCompleteStatus's values.
func (e JobCompleteStatus) Valid() bool {
	switch e {
	case JobCompleteStatusComplete:
		return true
	}
	return false
}

// JobCompletedPayload Payload for job:completed domain event
type JobCompletedPayload struct {
	// AnnotationId Annotation this job was attached to, when applicable
	AnnotationId *AnnotationId `json:"annotationId,omitempty"`
	// AnnotationUri For generation: URI of annotation that triggered generation
	AnnotationUri *string `json:"annotationUri,omitempty"`
	// Attempt Which attempt produced this event, 1-based (a first run is 1).
	// ALWAYS present: the queue re-runs a failed job silently, so an operator
	// reading progress or a terminal record has no other way to tell a re-run
	// from a first run — and provider spend, already counted in
	// xynolog_inference_tokens_total, cannot be attributed to a repeated
	// document without it. Stated rather than inferred from absence, because
	// 'attempt 1' is a fact the emitter always knows.
	Attempt    *int                `json:"attempt,omitempty"`
	Durability *DurabilityEvidence `json:"durability,omitempty"`
	// FoundCount For detection: total entities found
	FoundCount *int    `json:"foundCount,omitempty"`
	JobId      JobId   `json:"jobId"`
	JobType    JobType `json:"jobType"`
	// Result Full result object for extensibility
	Result *map[string]any `json:"result,omitempty"`
	// ResultResourceId For generation: ID of generated resource
	ResultResourceId *ResourceId `json:"resultResourceId,omitempty"`
	TotalSteps       *int        `json:"totalSteps,omitempty"`
}

// JobCreateCommand Create a job. A job description is its `jobType` and
// enough parameters to be well formed: a `mark` job names its resource and,
// in its parameters, its motivation; a `yield` job names its context.
type JobCreateCommand struct {
	union[jobCreateCommandMember]
}

// jobCreateCommandMember is a member of JobCreateCommand:
// MarkJobCreateCommand, YieldJobCreateCommand.
type jobCreateCommandMember interface {
	memberOfJobCreateCommand()
}

// Discriminator is the `jobType` this value states.
func (u JobCreateCommand) Discriminator() (string, error) { return u.stated("jobType") }

// ValueByDiscriminator is the member this value's `jobType` names.
func (u JobCreateCommand) ValueByDiscriminator() (any, error) {
	tag, err := u.Discriminator()
	if err != nil {
		return nil, err
	}
	switch tag {
	case "mark":
		return as[MarkJobCreateCommand](u.union)
	case "yield":
		return as[YieldJobCreateCommand](u.union)
	}
	return nil, unnamedMember("JobCreateCommand", "jobType", tag)
}

// JobCreatedResult Result of a job:create command
type JobCreatedResult struct {
	Response JobCreatedResultResponse `json:"response"`
}

type JobCreatedResultResponse struct {
	JobId JobId `json:"jobId"`
}

// JobDeclined Result of a job that completed without doing its work because
// the resource could not be read. Distinct from a failure: nothing went
// wrong, there was simply no text to work with — an encrypted or damaged PDF,
// a scan whose text could not be recognized, or a document that yielded
// nothing. The reasons are the extraction vocabulary the Smelter reports on
// `smelt:settled`, MINUS `no-extractor`: a media type that can never yield
// text (a zip, an image) is a bad request rather than a decline, so a worker
// asked to detect over one throws and the job reports `job:fail`. Everything
// here is a resource-specific outcome — the same media type would have
// succeeded on a different document.
type JobDeclined struct {
	// Declined Always true. It is what tells a decline from the result of a job
	// that did its work, which never carries it.
	Declined JobDeclinedDeclined `json:"declined"`
	// Reason Why the resource could not be read. A CODE, not a sentence: the
	// client owns the wording, so a browser renders it in the user's language
	// and the CLI renders English terminal copy from the same value. A prose
	// `message` composed server-side would be English everywhere.
	Reason JobDeclinedReason `json:"reason"`
}

func (JobDeclined) memberOfJobResult()      {}
func (JobDeclined) memberOfMarkJobResult()  {}
func (JobDeclined) memberOfYieldJobResult() {}

// JobDeclinedDeclined Always true. It is what tells a decline from the result
// of a job that did its work, which never carries it.
type JobDeclinedDeclined bool

// The values of JobDeclinedDeclined.
const (
	JobDeclinedDeclinedTrue JobDeclinedDeclined = true
)

// Valid is whether e is one of JobDeclinedDeclined's values.
func (e JobDeclinedDeclined) Valid() bool {
	switch e {
	case JobDeclinedDeclinedTrue:
		return true
	}
	return false
}

// JobDeclinedReason Why the resource could not be read. A CODE, not a
// sentence: the client owns the wording, so a browser renders it in the
// user's language and the CLI renders English terminal copy from the same
// value. A prose `message` composed server-side would be English everywhere.
type JobDeclinedReason string

// The values of JobDeclinedReason.
const (
	JobDeclinedReasonNoTextLayer JobDeclinedReason = "no-text-layer"
	JobDeclinedReasonEncrypted   JobDeclinedReason = "encrypted"
	JobDeclinedReasonCorrupt     JobDeclinedReason = "corrupt"
	JobDeclinedReasonTooLarge    JobDeclinedReason = "too-large"
	JobDeclinedReasonEmpty       JobDeclinedReason = "empty"
)

// Valid is whether e is one of JobDeclinedReason's values.
func (e JobDeclinedReason) Valid() bool {
	switch e {
	case JobDeclinedReasonNoTextLayer, JobDeclinedReasonEncrypted, JobDeclinedReasonCorrupt, JobDeclinedReasonTooLarge, JobDeclinedReasonEmpty:
		return true
	}
	return false
}

// JobFailCommand Command to mark a job as failed
type JobFailCommand struct {
	// UserId Authenticated user's DID, injected by the /bus/emit gateway.
	// Clients do not set this.
	UserId *UserId `json:"_userId,omitempty"`
	// AnnotationId Annotation this job is attached to, when applicable. Lets the
	// UI route failure feedback (error toast, revert state) to a specific
	// annotation.
	AnnotationId *AnnotationId `json:"annotationId,omitempty"`
	// Attempt Which attempt produced this event, 1-based (a first run is 1).
	// ALWAYS present: the queue re-runs a failed job silently, so an operator
	// reading progress or a terminal record has no other way to tell a re-run
	// from a first run — and provider spend, already counted in
	// xynolog_inference_tokens_total, cannot be attributed to a repeated
	// document without it. Stated rather than inferred from absence, because
	// 'attempt 1' is a fact the emitter always knows.
	Attempt *int `json:"attempt,omitempty"`
	// CompletedUnits Entity-type units whose annotations were fully emitted
	// before this failure (checkpointed resume). The queue records them on the
	// retried job's metadata; a retried claim skips them so completed work is
	// neither redone nor duplicated.
	CompletedUnits *[]string           `json:"completedUnits,omitempty"`
	Durability     *DurabilityEvidence `json:"durability,omitempty"`
	Error          string              `json:"error"`
	FailureClass   *FailureClass       `json:"failureClass,omitempty"`
	JobId          JobId               `json:"jobId"`
	JobType        JobType             `json:"jobType"`
	ResourceId     ResourceId          `json:"resourceId"`
	// UnitCursors The furthest each unit begun got, keyed by unit, with what it
	// had counted there — the grain `completedUnits` cannot express. A unit
	// named in `completedUnits` is stated here too, by the cursor it ended at: a
	// later attempt skips it whole and counts it by that cursor. A cursor never
	// says a unit is finished; only `completedUnits` does. Merged monotonically
	// per unit, finished or not: a stale snapshot must never move a cursor
	// backward.
	UnitCursors *map[string]UnitCursor `json:"unitCursors,omitempty"`
	// WillRetry Whether the queue will re-queue this job for another attempt.
	// Computed by the worker from the SAME rule the queue applies when it takes
	// the failure (specs/src/jobs/retry-cases.json, which every SDK and the
	// dispatcher run) using the retry budget carried on the claimed record.
	// FALSE (or absent) means this failure is TERMINAL: a client's job-watch
	// stream ends here. TRUE means the work continues on a fresh attempt — the
	// failure is an event, not the end, and a stream that terminated on it would
	// report a recovering run as a failed one.
	WillRetry *bool `json:"willRetry,omitempty"`
}

// JobFailed A job that failed and will not be retried.
type JobFailed struct {
	// CompletedAt When it failed.
	CompletedAt string `json:"completedAt"`
	// Error The failure's message.
	Error        string        `json:"error"`
	FailureClass *FailureClass `json:"failureClass,omitempty"`
	Metadata     JobMetadata   `json:"metadata"`
	Params       JobParams     `json:"params"`
	// StartedAt When the last claim was made; absent when it failed without one.
	StartedAt *string         `json:"startedAt,omitempty"`
	Status    JobFailedStatus `json:"status"`
}

func (JobFailed) memberOfJob()           {}
func (JobFailed) told() (string, string) { return "status", "failed" }

// JobFailedPayload Payload for the job:failed domain event — a permanent fact
// of the resource, not operational state. It carries the judgments the worker
// COMPUTED, not just its message: at the log they are otherwise
// unrecoverable, the only remaining witness being a flattened English string.
type JobFailedPayload struct {
	// AnnotationId Annotation this job was attached to, when applicable
	AnnotationId *AnnotationId `json:"annotationId,omitempty"`
	// Attempt Which attempt produced this event, 1-based (a first run is 1).
	// ALWAYS present: the queue re-runs a failed job silently, so an operator
	// reading progress or a terminal record has no other way to tell a re-run
	// from a first run — and provider spend, already counted in
	// xynolog_inference_tokens_total, cannot be attributed to a repeated
	// document without it. Stated rather than inferred from absence, because
	// 'attempt 1' is a fact the emitter always knows.
	Attempt      *int                `json:"attempt,omitempty"`
	Durability   *DurabilityEvidence `json:"durability,omitempty"`
	Error        string              `json:"error"`
	FailureClass *FailureClass       `json:"failureClass,omitempty"`
	JobId        JobId               `json:"jobId"`
	JobType      JobType             `json:"jobType"`
	// WillRetry Whether the worker computed that the queue would re-queue this
	// job (same predicate the queue applies, `willRetryAfter`). Absent means the
	// worker stated nothing. Without it a reader of the log cannot tell a run
	// recovering across several job:failed events from that many dead jobs.
	WillRetry *bool `json:"willRetry,omitempty"`
}

type JobFailedStatus string

// The values of JobFailedStatus.
const (
	JobFailedStatusFailed JobFailedStatus = "failed"
)

// Valid is whether e is one of JobFailedStatus's values.
func (e JobFailedStatus) Valid() bool {
	switch e {
	case JobFailedStatusFailed:
		return true
	}
	return false
}

// JobFilter Some jobs, named by fields of the job description: a partial
// description, at the description's own paths. A job matches when every field
// stated here equals the job's. A `mark` filter always states its motivation.
type JobFilter struct {
	union[jobFilterMember]
}

// jobFilterMember is a member of JobFilter: MarkJobFilter, YieldJobFilter.
type jobFilterMember interface {
	memberOfJobFilter()
}

// Discriminator is the `jobType` this value states.
func (u JobFilter) Discriminator() (string, error) { return u.stated("jobType") }

// ValueByDiscriminator is the member this value's `jobType` names.
func (u JobFilter) ValueByDiscriminator() (any, error) {
	tag, err := u.Discriminator()
	if err != nil {
		return nil, err
	}
	switch tag {
	case "mark":
		return as[MarkJobFilter](u.union)
	case "yield":
		return as[YieldJobFilter](u.union)
	}
	return nil, unnamedMember("JobFilter", "jobType", tag)
}

// JobMetadata What the dispatcher records about a job beside its parameters.
// `completedUnits` and `unitCursors` appear once a worker has checkpointed.
// `retryCount` counts the times the queue has put the job back to pending
// after a failure it classes as transient.
type JobMetadata struct {
	// CompletedUnits The units a worker has finished, merged across checkpoints
	// and failures as a set.
	CompletedUnits *[]string `json:"completedUnits,omitempty"`
	// Created When the job was created, as an ISO 8601 timestamp.
	Created string `json:"created"`
	// Id The job's id: `job-` followed by a version 4 UUID written as 32
	// lowercase hex digits, without dashes.
	Id JobId `json:"id"`
	// MaxRetries How many transient failures the queue retries: 0 for
	// generation, whose re-run produces different content; 1 for every other
	// type.
	MaxRetries int     `json:"maxRetries"`
	RetryCount int     `json:"retryCount"`
	Type       JobType `json:"type"`
	// UnitCursors The furthest each unit begun got, keyed by unit, with what it
	// had counted there. A finished unit keeps its cursor: where it ended, and
	// its final counts.
	UnitCursors *map[string]UnitCursor `json:"unitCursors,omitempty"`
	// UserId The DID of the principal whose `job:create` created the job.
	UserId UserId `json:"userId"`
}

// JobParams A job's parameters as the Dispatcher holds them: the `params` of
// its `job:create`, and what the Dispatcher adds. It adds `resourceId`, the
// resource the job is about: a `mark` job's own, and for a `yield` job the
// one its context focuses on. For a tagging job it adds `schema`, the tag
// schema its `schemaId` names, so that whoever holds the job needs no
// registry. Nothing the caller sent is changed or removed.
type JobParams struct {
	ResourceId ResourceId `json:"resourceId"`
	// Schema The tag schema a tagging job's `schemaId` names, as the knowledge
	// base registered it when the job was created. On a tagging job, and on no
	// other.
	Schema *TagSchema `json:"schema,omitempty"`
	// AdditionalProperties is every member the schema does not name, as it came.
	AdditionalProperties map[string]any `json:"-"`
}

// MarshalJSON writes v with the members its schema does not name, and each
// list its schema requires that Go holds as nil as the empty list.
func (v JobParams) MarshalJSON() ([]byte, error) {
	type written JobParams
	return writeOpen(written(v), v.AdditionalProperties)
}

// UnmarshalJSON reads v, and each member its schema does not name into its
// AdditionalProperties.
func (v *JobParams) UnmarshalJSON(raw []byte) error {
	type read JobParams
	return readOpen(raw, (*read)(v), &v.AdditionalProperties)
}

// JobPending A job waiting for a worker to claim it.
type JobPending struct {
	Metadata JobMetadata      `json:"metadata"`
	Params   JobParams        `json:"params"`
	Status   JobPendingStatus `json:"status"`
}

func (JobPending) memberOfJob()           {}
func (JobPending) told() (string, string) { return "status", "pending" }

type JobPendingStatus string

// The values of JobPendingStatus.
const (
	JobPendingStatusPending JobPendingStatus = "pending"
)

// Valid is whether e is one of JobPendingStatus's values.
func (e JobPendingStatus) Valid() bool {
	switch e {
	case JobPendingStatusPending:
		return true
	}
	return false
}

// JobProgress Progress report from a running job. The required field is
// `percentage`; `message` carries the coded phase and the rest are optional
// job-shape fields. This is the single progress shape for every job type —
// annotation workers and generation alike. Terminality is signalled on
// `job:complete` / `job:fail`, not here. A flow that iterates a user-chosen
// list (entity types for references, categories for tags) reports its
// position as one `current`/`processed`/`total` triple, the same shape for
// both, so a client never needs to know which flow it is drawing.
type JobProgress struct {
	// AnnotationId Annotation this job is attached to, when applicable. Echoed
	// inside JobProgress (in addition to the outer command envelope) so
	// consumers that only see the inner progress object (e.g. what
	// `yield.delegate` returns) can still route visual feedback to a specific
	// annotation.
	AnnotationId *AnnotationId `json:"annotationId,omitempty"`
	// CompletedItems Per-item results for the items already finished, for the
	// UI's completed log. Generic across flows for the same reason `current` is.
	CompletedItems *[]JobProgressCompletedItemsItem `json:"completedItems,omitempty"`
	// Current What the run is working on right now. `kind` is a CODE the client
	// renders a localized name for; `value` is KB data (an entity type, a tag
	// category) shown verbatim — the same split as `requestParams`. Absent on
	// flows that iterate nothing, such as generation.
	Current *JobProgressCurrent `json:"current,omitempty"`
	// EntitiesEmitted Annotations emitted so far (a linking job)
	EntitiesEmitted *int `json:"entitiesEmitted,omitempty"`
	// EntitiesExpected Cumulative mentions the count-verifier priced across the
	// pieces accepted so far — the denominator for a real progress bar (found of
	// ~expected). Approximate by nature (the count saturates on very large
	// pieces) and monotonically growing within a run. ABSENT when the provider
	// does not verify detection yield, or before any piece has been priced: no
	// claim, never zero.
	EntitiesExpected *int `json:"entitiesExpected,omitempty"`
	// EntitiesFound Entities found so far (a linking job)
	EntitiesFound *int `json:"entitiesFound,omitempty"`
	// Message What the job is doing right now, as a code plus typed params; the
	// client renders the sentence. Optional: pure percentage heartbeats carry
	// none, and consumers render nothing message-shaped when it is absent.
	Message *JobProgressMessage `json:"message,omitempty"`
	// Percentage Completion percentage (0-100)
	Percentage float64 `json:"percentage"`
	// Processed Items completed so far, zero-based — the item in `current` is
	// the one after these. Paired with `total`.
	Processed *int `json:"processed,omitempty"`
	// RequestParams Echoed job parameters for display in the progress UI.
	// `label` is a CODE, not a sentence — the client owns the wording, same rule
	// as the progress message. `value` is the user's own input (an entity-type
	// list, their instructions) and is deliberately NOT translated: it is their
	// words, not ours.
	RequestParams *[]JobProgressRequestParamsItem `json:"requestParams,omitempty"`
	// Total Items this run will process in all.
	Total *int `json:"total,omitempty"`
}

func (JobProgress) memberOfJobStoredProgress() {}

// JobProgressAnalyzing Analyzing the content.
type JobProgressAnalyzing struct {
	Code JobProgressAnalyzingCode `json:"code"`
}

func (JobProgressAnalyzing) memberOfJobProgressMessage() {}
func (JobProgressAnalyzing) told() (string, string)      { return "code", "analyzing" }

type JobProgressAnalyzingCode string

// The values of JobProgressAnalyzingCode.
const (
	JobProgressAnalyzingCodeAnalyzing JobProgressAnalyzingCode = "analyzing"
)

// Valid is whether e is one of JobProgressAnalyzingCode's values.
func (e JobProgressAnalyzingCode) Valid() bool {
	switch e {
	case JobProgressAnalyzingCodeAnalyzing:
		return true
	}
	return false
}

// JobProgressAnalyzingTags Analyzing the content against the tag schema.
type JobProgressAnalyzingTags struct {
	Code JobProgressAnalyzingTagsCode `json:"code"`
}

func (JobProgressAnalyzingTags) memberOfJobProgressMessage() {}
func (JobProgressAnalyzingTags) told() (string, string)      { return "code", "analyzing-tags" }

type JobProgressAnalyzingTagsCode string

// The values of JobProgressAnalyzingTagsCode.
const (
	JobProgressAnalyzingTagsCodeAnalyzingTags JobProgressAnalyzingTagsCode = "analyzing-tags"
)

// Valid is whether e is one of JobProgressAnalyzingTagsCode's values.
func (e JobProgressAnalyzingTagsCode) Valid() bool {
	switch e {
	case JobProgressAnalyzingTagsCodeAnalyzingTags:
		return true
	}
	return false
}

// JobProgressCompleteCreated Terminal success summary.
type JobProgressCompleteCreated struct {
	Code JobProgressCompleteCreatedCode `json:"code"`
	// Count How many annotations were created
	Count int `json:"count"`
	// Motivation The motivation of the job, and so of what it created. A client
	// words it in its own language.
	Motivation Motivation `json:"motivation"`
}

func (JobProgressCompleteCreated) memberOfJobProgressMessage() {}
func (JobProgressCompleteCreated) told() (string, string)      { return "code", "complete-created" }

type JobProgressCompleteCreatedCode string

// The values of JobProgressCompleteCreatedCode.
const (
	JobProgressCompleteCreatedCodeCompleteCreated JobProgressCompleteCreatedCode = "complete-created"
)

// Valid is whether e is one of JobProgressCompleteCreatedCode's values.
func (e JobProgressCompleteCreatedCode) Valid() bool {
	switch e {
	case JobProgressCompleteCreatedCodeCompleteCreated:
		return true
	}
	return false
}

// JobProgressCompleteGenerated Generation's terminal success. Deliberately
// generic — the client already holds the title it typed, and the outcome
// (name + resource link) travels on job:complete, not on progress.
// `truncated` qualifies the completion: the same bit `YieldJobDone.truncated`
// carries, so the two surfaces cannot drift.
type JobProgressCompleteGenerated struct {
	Code JobProgressCompleteGeneratedCode `json:"code"`
	// Truncated True when the model stopped at the maxTokens ceiling — the
	// artifact is cut off, not complete.
	Truncated bool `json:"truncated"`
}

func (JobProgressCompleteGenerated) memberOfJobProgressMessage() {}
func (JobProgressCompleteGenerated) told() (string, string)      { return "code", "complete-generated" }

type JobProgressCompleteGeneratedCode string

// The values of JobProgressCompleteGeneratedCode.
const (
	JobProgressCompleteGeneratedCodeCompleteGenerated JobProgressCompleteGeneratedCode = "complete-generated"
)

// Valid is whether e is one of JobProgressCompleteGeneratedCode's values.
func (e JobProgressCompleteGeneratedCode) Valid() bool {
	switch e {
	case JobProgressCompleteGeneratedCodeCompleteGenerated:
		return true
	}
	return false
}

type JobProgressCompletedItemsItem struct {
	// FoundCount Annotations found for it.
	FoundCount int `json:"foundCount"`
	// PersistedCount Annotations actually persisted for it — post-dedupe and
	// post-durability-acknowledgement, so it counts what the event log holds,
	// not what the model proposed. Beside foundCount this is the per-unit yield
	// the sizing work is judged by. Present on flows whose units persist as they
	// complete (a linking job); the tagging flow reports the same fact as
	// byCategory on its result, because its annotations are built after the
	// per-category loop.
	PersistedCount *int `json:"persistedCount,omitempty"`
	// UnderReported Present only when pieces of this unit were accepted at the
	// subdivision floor while a count call said more was present. The unit
	// completed, but incompletely — this carries the EVIDENCE (found vs counted,
	// over how many pieces), never a judgment against any expected yield. Absent
	// means complete: genuinely absent, not defaulted.
	UnderReported *JobProgressCompletedItemsItemUnderReported `json:"underReported,omitempty"`
	// Value The item, shown verbatim.
	Value string `json:"value"`
}

// JobProgressCompletedItemsItemUnderReported Present only when pieces of this
// unit were accepted at the subdivision floor while a count call said more
// was present. The unit completed, but incompletely — this carries the
// EVIDENCE (found vs counted, over how many pieces), never a judgment against
// any expected yield. Absent means complete: genuinely absent, not defaulted.
type JobProgressCompletedItemsItemUnderReported struct {
	// Counted Mentions the count calls reported across those pieces (approximate
	// by nature).
	Counted int `json:"counted"`
	// Found Annotations extraction did find on those pieces — every span
	// write-time-verified.
	Found int `json:"found"`
	// Pieces Floor-accepted pieces in this unit.
	Pieces int `json:"pieces"`
}

// JobProgressCreatingAnnotations Writing detected annotations back to the
// resource.
type JobProgressCreatingAnnotations struct {
	Code JobProgressCreatingAnnotationsCode `json:"code"`
	// Count How many annotations are being created
	Count int `json:"count"`
}

func (JobProgressCreatingAnnotations) memberOfJobProgressMessage() {}
func (JobProgressCreatingAnnotations) told() (string, string)      { return "code", "creating-annotations" }

type JobProgressCreatingAnnotationsCode string

// The values of JobProgressCreatingAnnotationsCode.
const (
	JobProgressCreatingAnnotationsCodeCreatingAnnotations JobProgressCreatingAnnotationsCode = "creating-annotations"
)

// Valid is whether e is one of JobProgressCreatingAnnotationsCode's values.
func (e JobProgressCreatingAnnotationsCode) Valid() bool {
	switch e {
	case JobProgressCreatingAnnotationsCodeCreatingAnnotations:
		return true
	}
	return false
}

// JobProgressCreatingResource Writing the generated resource.
type JobProgressCreatingResource struct {
	Code JobProgressCreatingResourceCode `json:"code"`
}

func (JobProgressCreatingResource) memberOfJobProgressMessage() {}
func (JobProgressCreatingResource) told() (string, string)      { return "code", "creating-resource" }

type JobProgressCreatingResourceCode string

// The values of JobProgressCreatingResourceCode.
const (
	JobProgressCreatingResourceCodeCreatingResource JobProgressCreatingResourceCode = "creating-resource"
)

// Valid is whether e is one of JobProgressCreatingResourceCode's values.
func (e JobProgressCreatingResourceCode) Valid() bool {
	switch e {
	case JobProgressCreatingResourceCodeCreatingResource:
		return true
	}
	return false
}

// JobProgressCreatingTagAnnotations Writing detected tag annotations back to
// the resource.
type JobProgressCreatingTagAnnotations struct {
	Code JobProgressCreatingTagAnnotationsCode `json:"code"`
	// Count How many annotations are being created
	Count int `json:"count"`
}

func (JobProgressCreatingTagAnnotations) memberOfJobProgressMessage() {}
func (JobProgressCreatingTagAnnotations) told() (string, string) {
	return "code", "creating-tag-annotations"
}

type JobProgressCreatingTagAnnotationsCode string

// The values of JobProgressCreatingTagAnnotationsCode.
const (
	JobProgressCreatingTagAnnotationsCodeCreatingTagAnnotations JobProgressCreatingTagAnnotationsCode = "creating-tag-annotations"
)

// Valid is whether e is one of JobProgressCreatingTagAnnotationsCode's
// values.
func (e JobProgressCreatingTagAnnotationsCode) Valid() bool {
	switch e {
	case JobProgressCreatingTagAnnotationsCodeCreatingTagAnnotations:
		return true
	}
	return false
}

// JobProgressCurrent What the run is working on right now. `kind` is a CODE
// the client renders a localized name for; `value` is KB data (an entity
// type, a tag category) shown verbatim — the same split as `requestParams`.
// Absent on flows that iterate nothing, such as generation.
type JobProgressCurrent struct {
	// Kind What sort of thing `value` is. Adding a variant means adding client
	// copy for it in every locale.
	Kind JobProgressCurrentKind `json:"kind"`
	// Value The item itself, shown verbatim and never translated.
	Value string `json:"value"`
}

// JobProgressCurrentKind What sort of thing `value` is. Adding a variant
// means adding client copy for it in every locale.
type JobProgressCurrentKind string

// The values of JobProgressCurrentKind.
const (
	JobProgressCurrentKindEntityType JobProgressCurrentKind = "entity-type"
	JobProgressCurrentKindCategory   JobProgressCurrentKind = "category"
)

// Valid is whether e is one of JobProgressCurrentKind's values.
func (e JobProgressCurrentKind) Valid() bool {
	switch e {
	case JobProgressCurrentKindEntityType, JobProgressCurrentKindCategory:
		return true
	}
	return false
}

// JobProgressDetectingEntities Entity detection, one entity type at a time.
type JobProgressDetectingEntities struct {
	Code JobProgressDetectingEntitiesCode `json:"code"`
	// EntityType Entity type currently being detected
	EntityType string `json:"entityType"`
}

func (JobProgressDetectingEntities) memberOfJobProgressMessage() {}
func (JobProgressDetectingEntities) told() (string, string)      { return "code", "detecting-entities" }

type JobProgressDetectingEntitiesCode string

// The values of JobProgressDetectingEntitiesCode.
const (
	JobProgressDetectingEntitiesCodeDetectingEntities JobProgressDetectingEntitiesCode = "detecting-entities"
)

// Valid is whether e is one of JobProgressDetectingEntitiesCode's values.
func (e JobProgressDetectingEntitiesCode) Valid() bool {
	switch e {
	case JobProgressDetectingEntitiesCodeDetectingEntities:
		return true
	}
	return false
}

// JobProgressGeneratingResource The model is generating the resource.
type JobProgressGeneratingResource struct {
	Code JobProgressGeneratingResourceCode `json:"code"`
}

func (JobProgressGeneratingResource) memberOfJobProgressMessage() {}
func (JobProgressGeneratingResource) told() (string, string)      { return "code", "generating-resource" }

type JobProgressGeneratingResourceCode string

// The values of JobProgressGeneratingResourceCode.
const (
	JobProgressGeneratingResourceCodeGeneratingResource JobProgressGeneratingResourceCode = "generating-resource"
)

// Valid is whether e is one of JobProgressGeneratingResourceCode's values.
func (e JobProgressGeneratingResourceCode) Valid() bool {
	switch e {
	case JobProgressGeneratingResourceCodeGeneratingResource:
		return true
	}
	return false
}

// JobProgressLoading Loading the resource content.
type JobProgressLoading struct {
	Code JobProgressLoadingCode `json:"code"`
}

func (JobProgressLoading) memberOfJobProgressMessage() {}
func (JobProgressLoading) told() (string, string)      { return "code", "loading" }

type JobProgressLoadingCode string

// The values of JobProgressLoadingCode.
const (
	JobProgressLoadingCodeLoading JobProgressLoadingCode = "loading"
)

// Valid is whether e is one of JobProgressLoadingCode's values.
func (e JobProgressLoadingCode) Valid() bool {
	switch e {
	case JobProgressLoadingCodeLoading:
		return true
	}
	return false
}

// JobProgressMessage What a running job is doing right now, as a code plus
// typed params — never a prose sentence. The producer reports what happened;
// each client renders it in the user's language (react-ui from its
// translations, the Go launcher from its English map). One named schema per
// code, discriminated on `code`, so generated clients get typed variants and
// copy-map completeness is statically checkable. The vocabulary is every
// report Xynolog's worker makes (contract/WORKER-SERVICE.md, D16 to D19 and
// Y8); extending it means adding a named variant here and copy in every
// client, gated by the locale-completeness check.
type JobProgressMessage struct {
	union[jobProgressMessageMember]
}

// jobProgressMessageMember is a member of JobProgressMessage:
// JobProgressLoading, JobProgressAnalyzing, JobProgressAnalyzingTags,
// JobProgressGeneratingResource, JobProgressCreatingResource,
// JobProgressCompleteGenerated, JobProgressDetectingEntities,
// JobProgressCreatingAnnotations, JobProgressCreatingTagAnnotations,
// JobProgressCompleteCreated.
type jobProgressMessageMember interface {
	memberOfJobProgressMessage()
}

// Discriminator is the `code` this value states.
func (u JobProgressMessage) Discriminator() (string, error) { return u.stated("code") }

// ValueByDiscriminator is the member this value's `code` names.
func (u JobProgressMessage) ValueByDiscriminator() (any, error) {
	tag, err := u.Discriminator()
	if err != nil {
		return nil, err
	}
	switch tag {
	case "loading":
		return as[JobProgressLoading](u.union)
	case "analyzing":
		return as[JobProgressAnalyzing](u.union)
	case "analyzing-tags":
		return as[JobProgressAnalyzingTags](u.union)
	case "generating-resource":
		return as[JobProgressGeneratingResource](u.union)
	case "creating-resource":
		return as[JobProgressCreatingResource](u.union)
	case "complete-generated":
		return as[JobProgressCompleteGenerated](u.union)
	case "detecting-entities":
		return as[JobProgressDetectingEntities](u.union)
	case "creating-annotations":
		return as[JobProgressCreatingAnnotations](u.union)
	case "creating-tag-annotations":
		return as[JobProgressCreatingTagAnnotations](u.union)
	case "complete-created":
		return as[JobProgressCompleteCreated](u.union)
	}
	return nil, unnamedMember("JobProgressMessage", "code", tag)
}

type JobProgressRequestParamsItem struct {
	// Label Which parameter this is. The client renders a localized name for it.
	Label JobProgressRequestParamsItemLabel `json:"label"`
	// Value The user's own input, shown verbatim.
	Value string `json:"value"`
}

// JobProgressRequestParamsItemLabel Which parameter this is. The client
// renders a localized name for it.
type JobProgressRequestParamsItemLabel string

// The values of JobProgressRequestParamsItemLabel.
const (
	JobProgressRequestParamsItemLabelEntityTypes  JobProgressRequestParamsItemLabel = "entity-types"
	JobProgressRequestParamsItemLabelInstructions JobProgressRequestParamsItemLabel = "instructions"
	JobProgressRequestParamsItemLabelTone         JobProgressRequestParamsItemLabel = "tone"
	JobProgressRequestParamsItemLabelDensity      JobProgressRequestParamsItemLabel = "density"
)

// Valid is whether e is one of JobProgressRequestParamsItemLabel's values.
func (e JobProgressRequestParamsItemLabel) Valid() bool {
	switch e {
	case JobProgressRequestParamsItemLabelEntityTypes, JobProgressRequestParamsItemLabelInstructions, JobProgressRequestParamsItemLabelTone, JobProgressRequestParamsItemLabelDensity:
		return true
	}
	return false
}

// JobQueuedEvent A pending job, announced when it is created and again at
// each tick while it waits. It carries the job description less the job's
// input, so that a party deciding whether to claim reads here what its claim
// would be matched against. It is a wake-up and not an offer of this job: a
// claim is answered with the next pending job it matches.
type JobQueuedEvent struct {
	union[jobQueuedEventMember]
}

// jobQueuedEventMember is a member of JobQueuedEvent: MarkJobQueuedEvent,
// YieldJobQueuedEvent.
type jobQueuedEventMember interface {
	memberOfJobQueuedEvent()
}

// Discriminator is the `jobType` this value states.
func (u JobQueuedEvent) Discriminator() (string, error) { return u.stated("jobType") }

// ValueByDiscriminator is the member this value's `jobType` names.
func (u JobQueuedEvent) ValueByDiscriminator() (any, error) {
	tag, err := u.Discriminator()
	if err != nil {
		return nil, err
	}
	switch tag {
	case "mark":
		return as[MarkJobQueuedEvent](u.union)
	case "yield":
		return as[YieldJobQueuedEvent](u.union)
	}
	return nil, unnamedMember("JobQueuedEvent", "jobType", tag)
}

// JobRecord One job as the queue stores it: the job, and when it last showed
// life. The dead-worker sweep reads `lastProgressAt`: a running job whose
// worker has reported nothing for the configured interval is presumed dead.
// Where the queue keeps these records is the job storage layout,
// specs/src/jobs/storage.json.
type JobRecord struct {
	Job Job `json:"job"`
	// LastProgressAt When the job was created, claimed, checkpointed or last
	// reported progress, as an ISO 8601 timestamp.
	LastProgressAt string `json:"lastProgressAt"`
}

// JobReportProgressCommand Command to report progress on a job
type JobReportProgressCommand struct {
	// UserId Authenticated user's DID, injected by the /bus/emit gateway.
	// Clients do not set this.
	UserId *UserId `json:"_userId,omitempty"`
	// AnnotationId Annotation this job is attached to, when applicable. Lets the
	// UI attach progress visuals to a specific annotation (e.g. a reference
	// whose generation is running).
	AnnotationId *AnnotationId `json:"annotationId,omitempty"`
	// Attempt Which attempt produced this event, 1-based (a first run is 1).
	// ALWAYS present: the queue re-runs a failed job silently, so an operator
	// reading progress or a terminal record has no other way to tell a re-run
	// from a first run — and provider spend, already counted in
	// xynolog_inference_tokens_total, cannot be attributed to a repeated
	// document without it. Stated rather than inferred from absence, because
	// 'attempt 1' is a fact the emitter always knows.
	Attempt    *int         `json:"attempt,omitempty"`
	JobId      JobId        `json:"jobId"`
	JobType    JobType      `json:"jobType"`
	Percentage float64      `json:"percentage"`
	Progress   *JobProgress `json:"progress,omitempty"`
	ResourceId ResourceId   `json:"resourceId"`
}

// JobResult What a job reports when it concludes without failing: a `mark`
// job's counts, the resource a `yield` job made, or a decline from either. A
// result has no discriminant of its own: the job description beside it says
// which job it answers, and the three share no member, so each is told from
// the others by what it alone carries.
type JobResult struct {
	union[jobResultMember]
}

// jobResultMember is a member of JobResult: MarkJobDone, YieldJobDone,
// JobDeclined.
type jobResultMember interface {
	memberOfJobResult()
}

func (JobResult) memberOfJobStoredResult() {}

// JobRunning A job a worker has claimed and not yet concluded.
type JobRunning struct {
	Metadata JobMetadata       `json:"metadata"`
	Params   JobParams         `json:"params"`
	Progress JobStoredProgress `json:"progress"`
	// StartedAt When the claim that holds it was made, as an ISO 8601 timestamp.
	StartedAt string           `json:"startedAt"`
	Status    JobRunningStatus `json:"status"`
}

func (JobRunning) memberOfJob()           {}
func (JobRunning) told() (string, string) { return "status", "running" }

type JobRunningStatus string

// The values of JobRunningStatus.
const (
	JobRunningStatusRunning JobRunningStatus = "running"
)

// Valid is whether e is one of JobRunningStatus's values.
func (e JobRunningStatus) Valid() bool {
	switch e {
	case JobRunningStatusRunning:
		return true
	}
	return false
}

// JobStartCommand Command to start a job
type JobStartCommand struct {
	// UserId Authenticated user's DID, injected by the /bus/emit gateway.
	// Clients do not set this.
	UserId *UserId `json:"_userId,omitempty"`
	// AnnotationId Annotation this job is attached to, when applicable. Set for
	// annotation-scoped jobs like generation (from a specific reference). Unset
	// for resource-scoped jobs like bulk reference/tag/highlight detection.
	AnnotationId *AnnotationId `json:"annotationId,omitempty"`
	// Attempt Which attempt produced this event, 1-based (a first run is 1).
	// ALWAYS present: the queue re-runs a failed job silently, so an operator
	// reading progress or a terminal record has no other way to tell a re-run
	// from a first run — and provider spend, already counted in
	// xynolog_inference_tokens_total, cannot be attributed to a repeated
	// document without it. Stated rather than inferred from absence, because
	// 'attempt 1' is a fact the emitter always knows.
	Attempt    *int       `json:"attempt,omitempty"`
	JobId      JobId      `json:"jobId"`
	JobType    JobType    `json:"jobType"`
	ResourceId ResourceId `json:"resourceId"`
}

// JobStartedPayload Payload for job:started domain event
type JobStartedPayload struct {
	// AnnotationId Annotation this job is attached to, when applicable
	AnnotationId *AnnotationId `json:"annotationId,omitempty"`
	JobId        JobId         `json:"jobId"`
	JobType      JobType       `json:"jobType"`
	TotalSteps   *int          `json:"totalSteps,omitempty"`
}

// JobStatusRequest Request to check the status of a job
type JobStatusRequest struct {
	JobId JobId `json:"jobId"`
}

type JobStatusResponse struct {
	CompletedAt  *string                 `json:"completedAt,omitempty"`
	Created      string                  `json:"created"`
	Error        *string                 `json:"error,omitempty"`
	FailureClass *FailureClass           `json:"failureClass,omitempty"`
	JobId        JobId                   `json:"jobId"`
	Progress     *JobStoredProgress      `json:"progress,omitempty"`
	Result       *JobStoredResult        `json:"result,omitempty"`
	StartedAt    *string                 `json:"startedAt,omitempty"`
	Status       JobStatusResponseStatus `json:"status"`
	Type         JobType                 `json:"type"`
	UserId       UserId                  `json:"userId"`
}

type JobStatusResponseStatus string

// The values of JobStatusResponseStatus.
const (
	JobStatusResponseStatusPending   JobStatusResponseStatus = "pending"
	JobStatusResponseStatusRunning   JobStatusResponseStatus = "running"
	JobStatusResponseStatusComplete  JobStatusResponseStatus = "complete"
	JobStatusResponseStatusFailed    JobStatusResponseStatus = "failed"
	JobStatusResponseStatusCancelled JobStatusResponseStatus = "cancelled"
)

// Valid is whether e is one of JobStatusResponseStatus's values.
func (e JobStatusResponseStatus) Valid() bool {
	switch e {
	case JobStatusResponseStatusPending, JobStatusResponseStatusRunning, JobStatusResponseStatusComplete, JobStatusResponseStatusFailed, JobStatusResponseStatusCancelled:
		return true
	}
	return false
}

// JobStatusResult Result of a job status request
type JobStatusResult struct {
	Response JobStatusResponse `json:"response"`
}

// JobStoredProgress A running job's progress as the dispatcher stores it: the
// last JobProgress its worker reported with `job:report-progress`, or an
// empty object before the first report.
type JobStoredProgress struct {
	union[jobStoredProgressMember]
}

// jobStoredProgressMember is a member of JobStoredProgress: JobProgress,
// EmptyObject.
type jobStoredProgressMember interface {
	memberOfJobStoredProgress()
}

// JobStoredResult A completed job's result as the dispatcher stores it: the
// result its worker reported with `job:complete`, or an empty object when it
// reported none.
type JobStoredResult struct {
	union[jobStoredResultMember]
}

// jobStoredResultMember is a member of JobStoredResult: JobResult,
// EmptyObject.
type jobStoredResultMember interface {
	memberOfJobStoredResult()
}

// JobType What a job does, as the verb that asks for it: `mark` annotates a
// resource, `yield` makes one. A job description is its `jobType` and the
// parameters that verb takes; a `mark` job's parameters state its motivation.
type JobType string

// The values of JobType.
const (
	JobTypeMark  JobType = "mark"
	JobTypeYield JobType = "yield"
)

// Valid is whether e is one of JobType's values.
func (e JobType) Valid() bool {
	switch e {
	case JobTypeMark, JobTypeYield:
		return true
	}
	return false
}

// KbDescription What a knowledge base says about itself, answered by the
// Archivist from the committed .xynolog/config.yaml and the working tree it
// holds. The only source clients use for a knowledge base's name and domain.
type KbDescription struct {
	// Domain The committed site.domain: the knowledge base's permanent identity.
	// Its did is 'did:web:' + this domain (kbDid in @xynolog/core). It names
	// WHICH knowledge base this is, not which running copy: a local clone and a
	// codespace of one repo report the same domain, so use it to verify what you
	// connected to, never to select among copies. A knowledge base that commits
	// no .xynolog/config.yaml declares none, and is refused with
	// browse:kb-failed.
	Domain string `json:"domain"`
	// GitBranch The working tree's current git branch. Absent when the knowledge
	// base does not sync git (`git.sync` in its committed .xynolog/config.yaml),
	// and when its tree is not a git checkout.
	GitBranch *string `json:"gitBranch,omitempty"`
	// Name The committed project.name, or the knowledge base directory's name
	// when it commits no .xynolog/config.yaml.
	Name string `json:"name"`
}

// KbEndpoint How a knowledge base is reached: a gateway over HTTP, or a
// knowledge base the host process has loaded. Told apart by `kind`. Only what
// builds a transport, or signs in at an issuer, reads it.
type KbEndpoint struct {
	union[kbEndpointMember]
}

// kbEndpointMember is a member of KbEndpoint: HttpEndpoint, LocalEndpoint.
type kbEndpointMember interface {
	memberOfKbEndpoint()
}

// Discriminator is the `kind` this value states.
func (u KbEndpoint) Discriminator() (string, error) { return u.stated("kind") }

// ValueByDiscriminator is the member this value's `kind` names.
func (u KbEndpoint) ValueByDiscriminator() (any, error) {
	tag, err := u.Discriminator()
	if err != nil {
		return nil, err
	}
	switch tag {
	case "http":
		return as[HttpEndpoint](u.union)
	case "local":
		return as[LocalEndpoint](u.union)
	}
	return nil, unnamedMember("KbEndpoint", "kind", tag)
}

// KbIdentity A knowledge base's committed identity (`project.name` and
// `site.domain` in its .xynolog/config.yaml), as a service's document names
// the knowledge base it serves. Its telemetry names it by its DID
// (`xynolog.kb`, specs/src/service-telemetry/telemetry.json).
type KbIdentity struct {
	// Domain Its did:web domain: its permanent identity, the source of the
	// audience its tokens must carry, and the authority its people and agents
	// are named under.
	Domain string `json:"domain"`
	// Name Its name. The gateway publishes it as its resource metadata's
	// `resource_name`.
	Name string `json:"name"`
}

// KbRead When a knowledge base last described itself, and what it said beyond
// its name. A client shows it as current only while a session to the
// knowledge base is live, and as of `at` otherwise.
type KbRead struct {
	// At When the description arrived.
	At string `json:"at"`
	// GitBranch The branch of the knowledge base's working tree then. Absent
	// when the working tree was not a git checkout.
	GitBranch *string `json:"gitBranch,omitempty"`
}

// KbTarget Where to connect to a knowledge base: an endpoint, and the labels
// a client keeps of it. It carries no identity: which knowledge base answers
// at an address is known only once it has been reached with a token and
// asked, so a target is what every caller can build before then, and a
// session's whole input. A client keeps it locally; it is never sent.
type KbTarget struct {
	Endpoint KbEndpoint `json:"endpoint"`
	// Id The key the client stores a session's credentials under. Two sessions
	// that share one storage have two ids, or each overwrites the other's
	// tokens. Whoever builds the target chooses it; none is made up.
	Id string `json:"id"`
	// Label What a person reads the knowledge base as. Once the knowledge base
	// has described itself, its own name.
	Label string `json:"label"`
}

// KnowledgeBase A registered knowledge base: a target, and what registering
// it took, the identity the knowledge base reported of itself when it was
// reached (`did`) among it. What a client's list of knowledge bases holds. A
// did says which knowledge base, not which running copy: a clone and a
// codespace of one repository are one knowledge base at two addresses and
// report one did. So an entry is looked up by its endpoint, and its did is
// what an answer is verified against; nothing selects by did. Its `label` and
// `lastRead` are written only from an answer that carried its did.
type KnowledgeBase struct {
	// Did The did the knowledge base reported of itself.
	Did      string     `json:"did"`
	Endpoint KbEndpoint `json:"endpoint"`
	// Id The key the client stores a session's credentials under. Two sessions
	// that share one storage have two ids, or each overwrites the other's
	// tokens. Whoever builds the target chooses it; none is made up.
	Id string `json:"id"`
	// Label What a person reads the knowledge base as. Once the knowledge base
	// has described itself, its own name.
	Label string `json:"label"`
	// LastRead The last time the knowledge base described itself. Absent until
	// it has, in an answer that carried this entry's did.
	LastRead *KbRead `json:"lastRead,omitempty"`
}

// KnowledgeGraph Knowledge graph gathered for an LLM context — a shared
// backbone in which resources AND annotations are typed nodes, connected by
// typed (optionally bidirectional) edges. Flattened views the
// matcher/generation read (connections, citedBy, siblings) are derived from
// these nodes/edges.
type KnowledgeGraph struct {
	Edges []KnowledgeGraphEdgesItem `json:"edges"`
	Nodes []KnowledgeGraphNodesItem `json:"nodes"`
	// Truncated Whether the graph stopped taking resources at its ceiling of 200
	// resource nodes, so that a resource within the depth asked for is not in
	// it. Present, and true, only then
	Truncated *bool `json:"truncated,omitempty"`
}

// MarshalJSON writes v, each list its schema requires that Go holds as nil
// written as the empty list.
func (v KnowledgeGraph) MarshalJSON() ([]byte, error) {
	type written KnowledgeGraph
	v.Edges = listOf(v.Edges)
	v.Nodes = listOf(v.Nodes)
	return json.Marshal(written(v))
}

type KnowledgeGraphEdgesItem struct {
	// Bidirectional Whether the connection goes both ways. Absent on a `link`
	// edge found through what cites a resource, which says nothing of the way
	// back
	Bidirectional *bool           `json:"bidirectional,omitempty"`
	Metadata      *map[string]any `json:"metadata,omitempty"`
	Source        string          `json:"source"`
	Target        string          `json:"target"`
	// Type Edge kind: `annotation-of` (an annotation → the resource it lives
	// on), `cites` (a citing linking annotation → the focal resource), or `link`
	// (a resource → a resource it links to)
	Type string `json:"type"`
}

type KnowledgeGraphNodesItem struct {
	union[knowledgeGraphNodesItemMember]
}

// knowledgeGraphNodesItemMember is a member of KnowledgeGraphNodesItem:
// GraphResourceNode, GraphAnnotationNode.
type knowledgeGraphNodesItemMember interface {
	memberOfKnowledgeGraphNodesItem()
}

// Discriminator is the `type` this value states.
func (u KnowledgeGraphNodesItem) Discriminator() (string, error) { return u.stated("type") }

// ValueByDiscriminator is the member this value's `type` names.
func (u KnowledgeGraphNodesItem) ValueByDiscriminator() (any, error) {
	tag, err := u.Discriminator()
	if err != nil {
		return nil, err
	}
	switch tag {
	case "resource":
		return as[GraphResourceNode](u.union)
	case "annotation":
		return as[GraphAnnotationNode](u.union)
	}
	return nil, unnamedMember("KnowledgeGraphNodesItem", "type", tag)
}

// LibrarianConfig Everything a Librarian reads at boot: nothing in it is
// defaulted by the Librarian. Whoever starts a Librarian writes it, from the
// knowledge base's stack documents, and the Librarian reads it from the path
// its `--config` flag names. This schema is the contract, and a Librarian
// needs no launcher. Started without `--config`, or with a path that names no
// file, the Librarian refuses to start and says which. No secret is a value
// here: the graph database's password, an embedding provider's key and a
// model provider's key are each named by the environment variable that holds
// it, and the Librarian's own service account is `XYNOLOG_OIDC_CLIENT_ID` and
// `XYNOLOG_OIDC_CLIENT_SECRET` in its environment. A document that does not
// validate is refused at boot, naming each failing field.
type LibrarianConfig struct {
	// Archivist Where the Archivist listens. The Librarian reads a resource's
	// bytes from it, as its service account.
	Archivist ServiceAddress  `json:"archivist"`
	Embedding EmbeddingConfig `json:"embedding"`
	// GatewayUrl The URL the Librarian reaches the gateway at: its route to the
	// bus.
	GatewayUrl string `json:"gatewayUrl"`
	// Gather The bound on a gather.
	Gather   LibrarianConfigGather `json:"gather"`
	Gatherer LibrarianEngineConfig `json:"gatherer"`
	Graph    GraphConfig           `json:"graph"`
	// Identity The issuer the Librarian's service account signs in at.
	Identity  ServiceIdentity       `json:"identity"`
	Kb        KbIdentity            `json:"kb"`
	LogFormat LogFormat             `json:"logFormat"`
	LogLevel  LogLevel              `json:"logLevel"`
	Matcher   LibrarianEngineConfig `json:"matcher"`
	// ModelCatalogue The path of a model catalogue file: what each model of a
	// provider can take, for the providers whose own APIs do not say (`google`,
	// `openai`, `together`). A Librarian whose matcher or gatherer is of one of
	// those providers refuses to start where the file cannot be read, and where
	// it states nothing of that model. A Librarian with no such model does not
	// read it.
	ModelCatalogue string `json:"modelCatalogue"`
	// Port The port the Librarian answers `/health` on.
	Port int `json:"port"`
	// Search The bound on a search by meaning.
	Search  LibrarianConfigSearch `json:"search"`
	Vectors VectorsConfig         `json:"vectors"`
}

// LibrarianConfigGather The bound on a gather.
type LibrarianConfigGather struct {
	// SettleTimeoutMs How long a gather around a resource waits for the
	// Smelter's decision on it before answering without similar passages, in
	// milliseconds.
	SettleTimeoutMs int `json:"settleTimeoutMs"`
}

// LibrarianConfigSearch The bound on a search by meaning.
type LibrarianConfigSearch struct {
	// SemanticFloor The least similarity a hit by meaning must have.
	SemanticFloor float64 `json:"semanticFloor"`
}

// LibrarianEngineConfig The engine a Librarian actor asks: which it is, and
// where its provider is reached.
type LibrarianEngineConfig struct {
	// ApiKeyEnv The environment variable holding the provider's API key, when
	// the provider requires one.
	ApiKeyEnv *string `json:"apiKeyEnv,omitempty"`
	// BaseUrl The address the provider's API is reached at.
	BaseUrl string `json:"baseUrl"`
	Engine  Engine `json:"engine"`
}

// LimitRefusal An ErrorResponse that names, in `code`, the limit the request
// met.
type LimitRefusal struct {
	// Code `streams`: the principal already holds as many streams as its
	// coefficient of `x-xynolog-limits.streamsPerPrincipal` allows. `emit-rate`:
	// the principal's emits have used its bucket, whose rate and burst are its
	// coefficient of `x-xynolog-limits.emitsPerPrincipal`, per gateway process.
	// `unanswered-requests`: the client already awaits as many replies as
	// `BusSubscribeRequest.pendingReplies` may name. `capacity`: the gateway
	// holds as many queued bytes as it can. `refusal-rate`: the request's
	// credential was refused, and the requests its holder has had refused have
	// used their allowance; it answers only a request whose token has already
	// failed verification, so it says what a 401 says, and a client that can
	// renew its token renews it and sends the request again rather than waiting
	// (contract/TRANSPORT-CONTRACT.md § A refused credential).
	Code    LimitRefusalCode `json:"code"`
	Details any              `json:"details,omitempty"`
	// Error What went wrong, in a sentence.
	Error string `json:"error"`
	// Hint What the caller can do about it, when there is something to say.
	Hint *string `json:"hint,omitempty"`
}

// LimitRefusalCode `streams`: the principal already holds as many streams as
// its coefficient of `x-xynolog-limits.streamsPerPrincipal` allows.
// `emit-rate`: the principal's emits have used its bucket, whose rate and
// burst are its coefficient of `x-xynolog-limits.emitsPerPrincipal`, per
// gateway process. `unanswered-requests`: the client already awaits as many
// replies as `BusSubscribeRequest.pendingReplies` may name. `capacity`: the
// gateway holds as many queued bytes as it can. `refusal-rate`: the request's
// credential was refused, and the requests its holder has had refused have
// used their allowance; it answers only a request whose token has already
// failed verification, so it says what a 401 says, and a client that can
// renew its token renews it and sends the request again rather than waiting
// (contract/TRANSPORT-CONTRACT.md § A refused credential).
type LimitRefusalCode string

// The values of LimitRefusalCode.
const (
	LimitRefusalCodeStreams            LimitRefusalCode = "streams"
	LimitRefusalCodeEmitRate           LimitRefusalCode = "emit-rate"
	LimitRefusalCodeUnansweredRequests LimitRefusalCode = "unanswered-requests"
	LimitRefusalCodeCapacity           LimitRefusalCode = "capacity"
	LimitRefusalCodeRefusalRate        LimitRefusalCode = "refusal-rate"
)

// Valid is whether e is one of LimitRefusalCode's values.
func (e LimitRefusalCode) Valid() bool {
	switch e {
	case LimitRefusalCodeStreams, LimitRefusalCodeEmitRate, LimitRefusalCodeUnansweredRequests, LimitRefusalCodeCapacity, LimitRefusalCodeRefusalRate:
		return true
	}
	return false
}

// LinkingJobParams What a linking job takes: mentions of the named entity
// types are marked as references, each unresolved until it is bound to a
// resource.
type LinkingJobParams struct {
	// EntityTypes The entity types to find mentions of. Each is one the
	// knowledge base registers.
	EntityTypes []string `json:"entityTypes"`
	// IncludeDescriptiveReferences Whether a description that stands for an
	// entity ("the wily hero") counts as a mention of it, beside its name.
	IncludeDescriptiveReferences *bool `json:"includeDescriptiveReferences,omitempty"`
	// Language The language the annotations' own text is written in. BCP 47.
	Language   *string                    `json:"language,omitempty"`
	Motivation LinkingJobParamsMotivation `json:"motivation"`
	// SourceLanguage The language of the resource being read. BCP 47.
	SourceLanguage *string `json:"sourceLanguage,omitempty"`
}

func (LinkingJobParams) memberOfMarkJobParams() {}
func (LinkingJobParams) told() (string, string) { return "motivation", "linking" }

// MarshalJSON writes v, each list its schema requires that Go holds as nil
// written as the empty list.
func (v LinkingJobParams) MarshalJSON() ([]byte, error) {
	type written LinkingJobParams
	v.EntityTypes = listOf(v.EntityTypes)
	return json.Marshal(written(v))
}

type LinkingJobParamsMotivation string

// The values of LinkingJobParamsMotivation.
const (
	LinkingJobParamsMotivationLinking LinkingJobParamsMotivation = "linking"
)

// Valid is whether e is one of LinkingJobParamsMotivation's values.
func (e LinkingJobParamsMotivation) Valid() bool {
	switch e {
	case LinkingJobParamsMotivationLinking:
		return true
	}
	return false
}

type ListResourcesResponse struct {
	Limit     float64              `json:"limit"`
	Offset    float64              `json:"offset"`
	Resources []ResourceDescriptor `json:"resources"`
	Total     float64              `json:"total"`
}

// MarshalJSON writes v, each list its schema requires that Go holds as nil
// written as the empty list.
func (v ListResourcesResponse) MarshalJSON() ([]byte, error) {
	type written ListResourcesResponse
	v.Resources = listOf(v.Resources)
	return json.Marshal(written(v))
}

// LocalEndpoint A knowledge base the host process has loaded and reaches
// through a transport with no wire.
type LocalEndpoint struct {
	// KbId Which loaded knowledge base, named by an id that means something to
	// the host process alone.
	KbId string `json:"kbId"`
	// Kind Discriminant: the endpoint is in the host process.
	Kind LocalEndpointKind `json:"kind"`
}

func (LocalEndpoint) memberOfKbEndpoint()    {}
func (LocalEndpoint) told() (string, string) { return "kind", "local" }

// LocalEndpointKind Discriminant: the endpoint is in the host process.
type LocalEndpointKind string

// The values of LocalEndpointKind.
const (
	LocalEndpointKindLocal LocalEndpointKind = "local"
)

// Valid is whether e is one of LocalEndpointKind's values.
func (e LocalEndpointKind) Valid() bool {
	switch e {
	case LocalEndpointKindLocal:
		return true
	}
	return false
}

// LogFormat How each log line is written to stdout: `json`, one JSON object
// per line carrying the active trace's `trace_id` and `span_id`; or `simple`,
// `<timestamp> [<LEVEL>] <message>` followed by any metadata as JSON.
type LogFormat string

// The values of LogFormat.
const (
	LogFormatJson   LogFormat = "json"
	LogFormatSimple LogFormat = "simple"
)

// Valid is whether e is one of LogFormat's values.
func (e LogFormat) Valid() bool {
	switch e {
	case LogFormatJson, LogFormatSimple:
		return true
	}
	return false
}

// LogLevel How much a service logs: the least severe level it writes, from
// error, the most severe, to debug.
type LogLevel string

// The values of LogLevel.
const (
	LogLevelError LogLevel = "error"
	LogLevelWarn  LogLevel = "warn"
	LogLevelInfo  LogLevel = "info"
	LogLevelHttp  LogLevel = "http"
	LogLevelDebug LogLevel = "debug"
)

// Valid is whether e is one of LogLevel's values.
func (e LogLevel) Valid() bool {
	switch e {
	case LogLevelError, LogLevelWarn, LogLevelInfo, LogLevelHttp, LogLevelDebug:
		return true
	}
	return false
}

// MarkArchiveCommand Bus command to archive a resource and optionally remove
// its file.
type MarkArchiveCommand struct {
	// UserId Authenticated user's DID, injected by the /bus/emit gateway.
	// Clients do not set this.
	UserId     *UserId    `json:"_userId,omitempty"`
	KeepFile   *bool      `json:"keepFile,omitempty"`
	ResourceId ResourceId `json:"resourceId"`
	// StorageUri Optional: where the resource's bytes live, so the archive can
	// act on the file. An instruction to this handler, not a copy of the stored
	// fact (that lives on the primary Representation). Working-tree URI, only
	// file:// is supported.
	StorageUri *string `json:"storageUri,omitempty"`
}

// MarkCommitCommand Bus command to persist a detection unit's annotations as
// one acknowledged batch. It is answered only after every annotation is in
// the event log, so a worker can gate unit completion on durability rather
// than on emission. The batch is the unit: a partial commit is reported as a
// failure, and the worker retries the whole unit, which is safe because
// annotation ids are deterministic: content-addressed, so re-emitting one is
// a no-op.
type MarkCommitCommand struct {
	// Roles The emitter's capabilities (the token's `roles`), injected by the
	// /bus/emit gateway. Clients do not set this. An emitter carrying the worker
	// role must cite the job this batch fulfils in `jobId`; the Stower refuses
	// the batch otherwise.
	Roles *[]string `json:"_roles,omitempty"`
	// UserId Authenticated user's DID, injected by the /bus/emit gateway.
	// Clients do not set this.
	UserId *UserId `json:"_userId,omitempty"`
	// Annotations The unit's annotations, already built with deterministic ids.
	// Re-committing an identical batch is a no-op rather than a duplicate.
	Annotations []Annotation `json:"annotations"`
	// JobId The job this batch fulfils. Required when the emitter carries the
	// worker role; absent for self-initiated work (a person, or an agent acting
	// on its own). The knowledge base derives who requested these annotations
	// from the cited job's own events — the emitter never says who the work was
	// for.
	JobId *JobId `json:"jobId,omitempty"`
	// ResourceId Resource every annotation in this batch targets.
	ResourceId ResourceId `json:"resourceId"`
}

// MarshalJSON writes v, each list its schema requires that Go holds as nil
// written as the empty list.
func (v MarkCommitCommand) MarshalJSON() ([]byte, error) {
	type written MarkCommitCommand
	v.Annotations = listOf(v.Annotations)
	return json.Marshal(written(v))
}

// MarkCommitOk Durability acknowledgement for a mark:commit batch: every
// annotation named by the command is in the event log at the moment this is
// emitted.
type MarkCommitOk struct {
	// Response What the commit persisted.
	Response MarkCommitOkResponse `json:"response"`
}

// MarkCommitOkResponse What the commit persisted.
type MarkCommitOkResponse struct {
	// AnnotationIds Ids the batch covers, whether appended now or already
	// present.
	AnnotationIds []AnnotationId `json:"annotationIds"`
	// Persisted Annotations the command named that are durable in the event log.
	// Equals the batch size on success, on a first commit and on a retry alike —
	// the commit appends only what the resource does not already hold, so a
	// wholly-redundant retry has still succeeded and says so. Not an append
	// tally: a caller must never have to read a 0 as 'all good'.
	Persisted int `json:"persisted"`
}

// MarshalJSON writes v, each list its schema requires that Go holds as nil
// written as the empty list.
func (v MarkCommitOkResponse) MarshalJSON() ([]byte, error) {
	type written MarkCommitOkResponse
	v.AnnotationIds = listOf(v.AnnotationIds)
	return json.Marshal(written(v))
}

// MarkCreateOk Success reply after creating an annotation, matched to the
// originating command by correlationId.
type MarkCreateOk struct {
	Response MarkCreateOkResponse `json:"response"`
}

// MarkCreateOkResponse The created annotation's identity.
type MarkCreateOkResponse struct {
	AnnotationId AnnotationId `json:"annotationId"`
}

// MarkCreateRequest Raw annotation creation intent — bus handler assembles
// the W3C annotation
type MarkCreateRequest struct {
	Request    CreateAnnotationRequest `json:"request"`
	ResourceId ResourceId              `json:"resourceId"`
}

// MarkDelegateTimeoutEvent The payload of `mark:delegate-timeout`, a
// client-local signal: a delegated job went silent past its deadline, with no
// progress, no completion and no `job:fail`. A real job failure arrives as
// `job:fail` and never produces this.
type MarkDelegateTimeoutEvent struct {
	Motivation Motivation `json:"motivation"`
	// ResourceId The resource the job was delegated for.
	ResourceId ResourceId `json:"resourceId"`
}

// MarkDeleteCommand Bus command to delete an annotation.
type MarkDeleteCommand struct {
	// UserId Authenticated user's DID, injected by the /bus/emit gateway.
	// Clients do not set this.
	UserId       *UserId      `json:"_userId,omitempty"`
	AnnotationId AnnotationId `json:"annotationId"`
	ResourceId   *ResourceId  `json:"resourceId,omitempty"`
}

// MarkDeleteOk Success reply after deleting an annotation, matched to the
// originating command by correlationId.
type MarkDeleteOk struct {
	// Response The deleted annotation's identity.
	Response MarkDeleteOkResponse `json:"response"`
}

// MarkDeleteOkResponse The deleted annotation's identity.
type MarkDeleteOkResponse struct {
	AnnotationId AnnotationId `json:"annotationId"`
}

// MarkJobCompleteCommand A `mark` job's worker says the job is complete, with
// what a `mark` job reports.
type MarkJobCompleteCommand struct {
	// UserId Authenticated user's DID, injected by the /bus/emit gateway.
	// Clients do not set this.
	UserId *UserId `json:"_userId,omitempty"`
	// Attempt Which attempt produced this event, 1-based (a first run is 1).
	// ALWAYS present: the queue re-runs a failed job silently, so an operator
	// reading progress or a terminal record has no other way to tell a re-run
	// from a first run — and provider spend, already counted in
	// xynolog_inference_tokens_total, cannot be attributed to a repeated
	// document without it. Stated rather than inferred from absence, because
	// 'attempt 1' is a fact the emitter always knows.
	Attempt    *int                          `json:"attempt,omitempty"`
	Durability *DurabilityEvidence           `json:"durability,omitempty"`
	JobId      JobId                         `json:"jobId"`
	JobType    MarkJobCompleteCommandJobType `json:"jobType"`
	ResourceId ResourceId                    `json:"resourceId"`
	Result     *MarkJobResult                `json:"result,omitempty"`
}

func (MarkJobCompleteCommand) memberOfJobCompleteCommand() {}
func (MarkJobCompleteCommand) told() (string, string)      { return "jobType", "mark" }

type MarkJobCompleteCommandJobType string

// The values of MarkJobCompleteCommandJobType.
const (
	MarkJobCompleteCommandJobTypeMark MarkJobCompleteCommandJobType = "mark"
)

// Valid is whether e is one of MarkJobCompleteCommandJobType's values.
func (e MarkJobCompleteCommandJobType) Valid() bool {
	switch e {
	case MarkJobCompleteCommandJobTypeMark:
		return true
	}
	return false
}

// MarkJobCreateCommand Create a `mark` job: annotate one resource for one
// motivation.
type MarkJobCreateCommand struct {
	// Roles The emitter's roles, injected by the gateway when it has any.
	// Clients do not set this.
	Roles *[]string `json:"_roles,omitempty"`
	// UserId The emitter's verified DID, injected by the gateway. Clients do not
	// set this.
	UserId  *UserId                     `json:"_userId,omitempty"`
	JobType MarkJobCreateCommandJobType `json:"jobType"`
	Params  MarkJobParams               `json:"params"`
	// ResourceId The resource to annotate.
	ResourceId ResourceId `json:"resourceId"`
}

func (MarkJobCreateCommand) memberOfJobCreateCommand() {}
func (MarkJobCreateCommand) told() (string, string)    { return "jobType", "mark" }

type MarkJobCreateCommandJobType string

// The values of MarkJobCreateCommandJobType.
const (
	MarkJobCreateCommandJobTypeMark MarkJobCreateCommandJobType = "mark"
)

// Valid is whether e is one of MarkJobCreateCommandJobType's values.
func (e MarkJobCreateCommandJobType) Valid() bool {
	switch e {
	case MarkJobCreateCommandJobTypeMark:
		return true
	}
	return false
}

// MarkJobDone What a `mark` job reports when it has done its work, whatever
// its motivation.
type MarkJobDone struct {
	// ByCategory The annotations persisted per category. A tagging job's; absent
	// from every other.
	ByCategory *map[string]int `json:"byCategory,omitempty"`
	// Errors How many of the proposed could not be anchored in the text. Absent
	// means none.
	Errors *int `json:"errors,omitempty"`
	// Found What the model proposed, before anything was checked against the
	// text.
	Found int `json:"found"`
	// Persisted What the log holds: the annotations committed, after the ones
	// that could not be anchored were dropped and repeats were collapsed.
	Persisted int `json:"persisted"`
	// UncheckedPieces Pieces whose yield was to be checked against a count and
	// was not: the count failed, was cut off, or answered no count. What they
	// found was kept unchecked. Absent means none: every piece that was to be
	// checked was. A job whose provider checks no yield has none.
	UncheckedPieces *int `json:"uncheckedPieces,omitempty"`
	// UnderReportedPieces Total floor-accepted under-reported pieces across the
	// job's units. Absent means none — the per-unit evidence rides the terminal
	// progress frame's completedItems; this keeps the result self-describing
	// without the progress stream.
	UnderReportedPieces *int `json:"underReportedPieces,omitempty"`
}

func (MarkJobDone) memberOfJobResult()     {}
func (MarkJobDone) memberOfMarkJobResult() {}

// MarkJobFilter `mark` jobs of one motivation.
type MarkJobFilter struct {
	JobType MarkJobFilterJobType `json:"jobType"`
	Params  MarkJobFilterParams  `json:"params"`
}

func (MarkJobFilter) memberOfJobFilter()     {}
func (MarkJobFilter) told() (string, string) { return "jobType", "mark" }

type MarkJobFilterJobType string

// The values of MarkJobFilterJobType.
const (
	MarkJobFilterJobTypeMark MarkJobFilterJobType = "mark"
)

// Valid is whether e is one of MarkJobFilterJobType's values.
func (e MarkJobFilterJobType) Valid() bool {
	switch e {
	case MarkJobFilterJobTypeMark:
		return true
	}
	return false
}

type MarkJobFilterParams struct {
	Motivation Motivation `json:"motivation"`
}

// MarkJobParams The parameters of a `mark` job, told apart by `motivation`.
// Each motivation takes its own parameters and no others: a parameter a job
// does not take is refused where the job is created.
type MarkJobParams struct {
	union[markJobParamsMember]
}

// markJobParamsMember is a member of MarkJobParams: HighlightingJobParams,
// CommentingJobParams, AssessingJobParams, LinkingJobParams,
// TaggingJobParams.
type markJobParamsMember interface {
	memberOfMarkJobParams()
}

// Discriminator is the `motivation` this value states.
func (u MarkJobParams) Discriminator() (string, error) { return u.stated("motivation") }

// ValueByDiscriminator is the member this value's `motivation` names.
func (u MarkJobParams) ValueByDiscriminator() (any, error) {
	tag, err := u.Discriminator()
	if err != nil {
		return nil, err
	}
	switch tag {
	case "highlighting":
		return as[HighlightingJobParams](u.union)
	case "commenting":
		return as[CommentingJobParams](u.union)
	case "assessing":
		return as[AssessingJobParams](u.union)
	case "linking":
		return as[LinkingJobParams](u.union)
	case "tagging":
		return as[TaggingJobParams](u.union)
	}
	return nil, unnamedMember("MarkJobParams", "motivation", tag)
}

// MarkJobQueuedEvent A pending `mark` job, announced with its parameters as
// it was created.
type MarkJobQueuedEvent struct {
	JobId   JobId                     `json:"jobId"`
	JobType MarkJobQueuedEventJobType `json:"jobType"`
	Params  MarkJobParams             `json:"params"`
	// ResourceId The resource the job is about.
	ResourceId ResourceId `json:"resourceId"`
	// UserId The DID of the principal whose `job:create` created the job.
	UserId UserId `json:"userId"`
}

func (MarkJobQueuedEvent) memberOfJobQueuedEvent() {}
func (MarkJobQueuedEvent) told() (string, string)  { return "jobType", "mark" }

type MarkJobQueuedEventJobType string

// The values of MarkJobQueuedEventJobType.
const (
	MarkJobQueuedEventJobTypeMark MarkJobQueuedEventJobType = "mark"
)

// Valid is whether e is one of MarkJobQueuedEventJobType's values.
func (e MarkJobQueuedEventJobType) Valid() bool {
	switch e {
	case MarkJobQueuedEventJobTypeMark:
		return true
	}
	return false
}

// MarkJobResult What a `mark` job reports when it concludes without failing:
// its counts, or a decline. Neither names its kind: a decline is the one with
// `declined`.
type MarkJobResult struct {
	union[markJobResultMember]
}

// markJobResultMember is a member of MarkJobResult: MarkJobDone, JobDeclined.
type markJobResultMember interface {
	memberOfMarkJobResult()
}

// MarkRequestedEvent Emitted when the user requests a new mark (annotation)
// on a resource
type MarkRequestedEvent struct {
	Motivation Motivation `json:"motivation"`
	// Selector One or more W3C selectors
	Selector AnnotationSelector `json:"selector"`
	// Source The '@id' of the resource the mark belongs to (W3C target.source).
	// Routes the event to the right viewer/state unit when a host mounts many
	// viewers on one session.
	Source ResourceId `json:"source"`
}

// MarkSubmitEvent Emitted when a mark is submitted with its annotation body
type MarkSubmitEvent struct {
	// Body Optional body. Omit for annotations whose motivation alone is
	// meaningful (e.g. highlighting) or whose user-supplied content is empty
	// (e.g. an assessing annotation saved without comment text). Shape matches
	// Annotation.body.
	Body       *AnnotationBodies `json:"body,omitempty"`
	Motivation Motivation        `json:"motivation"`
	// Selector One or more W3C selectors
	Selector AnnotationSelector `json:"selector"`
	// Source The '@id' of the resource the mark belongs to (W3C target.source).
	// Routes the submit to the state unit bound to that resource — without it, N
	// mounted units each create the annotation (N copies on N resources).
	Source ResourceId `json:"source"`
}

// MarkUnarchiveCommand Bus command to unarchive a previously archived
// resource.
type MarkUnarchiveCommand struct {
	// UserId Authenticated user's DID, injected by the /bus/emit gateway.
	// Clients do not set this.
	UserId     *UserId    `json:"_userId,omitempty"`
	ResourceId ResourceId `json:"resourceId"`
	// StorageUri Optional: where the resource's bytes are expected to be. When
	// present the handler VERIFIES the file exists and fails loudly if it does
	// not, rather than succeeding as a no-op. An instruction, not a copy of the
	// stored fact (that lives on the primary Representation). Working-tree URI,
	// only file:// is supported.
	StorageUri *string `json:"storageUri,omitempty"`
}

// MarkUpdateBodyCommand Bus command to update an annotation's body with patch
// operations.
type MarkUpdateBodyCommand struct {
	// UserId Authenticated user's DID, injected by the /bus/emit gateway.
	// Clients do not set this.
	UserId       *UserId         `json:"_userId,omitempty"`
	AnnotationId AnnotationId    `json:"annotationId"`
	Operations   []BodyOperation `json:"operations"`
	ResourceId   ResourceId      `json:"resourceId"`
}

// MarshalJSON writes v, each list its schema requires that Go holds as nil
// written as the empty list.
func (v MarkUpdateBodyCommand) MarshalJSON() ([]byte, error) {
	type written MarkUpdateBodyCommand
	v.Operations = listOf(v.Operations)
	return json.Marshal(written(v))
}

// MarkUpdateEntityTypesCommand Bus command to replace the entity types on a
// resource.
type MarkUpdateEntityTypesCommand struct {
	// UserId Authenticated user's DID, injected by the /bus/emit gateway.
	// Clients do not set this.
	UserId             *UserId    `json:"_userId,omitempty"`
	CurrentEntityTypes []string   `json:"currentEntityTypes"`
	ResourceId         ResourceId `json:"resourceId"`
	UpdatedEntityTypes []string   `json:"updatedEntityTypes"`
}

// MarshalJSON writes v, each list its schema requires that Go holds as nil
// written as the empty list.
func (v MarkUpdateEntityTypesCommand) MarshalJSON() ([]byte, error) {
	type written MarkUpdateEntityTypesCommand
	v.CurrentEntityTypes = listOf(v.CurrentEntityTypes)
	v.UpdatedEntityTypes = listOf(v.UpdatedEntityTypes)
	return json.Marshal(written(v))
}

// MatchResourcesRequest Request to search the knowledge base's resources by
// text. The Librarian answers: it matches the text lexically, and when
// nothing matches, by meaning.
type MatchResourcesRequest struct {
	Archived   *bool   `json:"archived,omitempty"`
	EntityType *string `json:"entityType,omitempty"`
	// Limit The most resources a page has.
	Limit *int `json:"limit,omitempty"`
	// Offset How many of the resources the search finds are passed over before
	// the page begins.
	Offset *int `json:"offset,omitempty"`
	// Search The text to search for.
	Search string `json:"search"`
}

// MatchResourcesResponse One page of the resources a text search found, and
// which kind of answer it is.
type MatchResourcesResponse struct {
	// Limit The limit the search was made with.
	Limit int `json:"limit"`
	// MatchKind What kind of answer this is: 'lexical' — the resources matched
	// the query text; 'semantic' — no lexical match existed, and these resources
	// discuss the query per the vector index. Required so every producer labels
	// its answer; a UI can render semantic results as a different kind of page
	// ('no title matches, but these documents discuss it').
	MatchKind MatchResourcesResponseMatchKind `json:"matchKind"`
	// Offset How many of the resources the search found were passed over before
	// this page, as the request stated.
	Offset    int                  `json:"offset"`
	Resources []ResourceDescriptor `json:"resources"`
	// Total How many resources the search found in all, and not only on this
	// page.
	Total int `json:"total"`
}

// MarshalJSON writes v, each list its schema requires that Go holds as nil
// written as the empty list.
func (v MatchResourcesResponse) MarshalJSON() ([]byte, error) {
	type written MatchResourcesResponse
	v.Resources = listOf(v.Resources)
	return json.Marshal(written(v))
}

// MatchResourcesResponseMatchKind What kind of answer this is: 'lexical' —
// the resources matched the query text; 'semantic' — no lexical match
// existed, and these resources discuss the query per the vector index.
// Required so every producer labels its answer; a UI can render semantic
// results as a different kind of page ('no title matches, but these documents
// discuss it').
type MatchResourcesResponseMatchKind string

// The values of MatchResourcesResponseMatchKind.
const (
	MatchResourcesResponseMatchKindLexical  MatchResourcesResponseMatchKind = "lexical"
	MatchResourcesResponseMatchKindSemantic MatchResourcesResponseMatchKind = "semantic"
)

// Valid is whether e is one of MatchResourcesResponseMatchKind's values.
func (e MatchResourcesResponseMatchKind) Valid() bool {
	switch e {
	case MatchResourcesResponseMatchKindLexical, MatchResourcesResponseMatchKindSemantic:
		return true
	}
	return false
}

// MatchResourcesResult Result of searching resources by text
type MatchResourcesResult struct {
	Response MatchResourcesResponse `json:"response"`
}

// MatchSearchFailed The payload of `match:search-failed`: a CommandError that
// names the reference whose candidates could not be searched for.
type MatchSearchFailed struct {
	// Code Machine-readable failure class, for consumers that must BRANCH on why
	// a command failed rather than log it. Optional and deliberately sparse:
	// absent means 'no class declared', and every existing failure stays that
	// way. An enum rather than a free string so the vocabulary has an owner — an
	// unconstrained code is a mirror with no gate, and adding one should be a
	// deliberate spec change. `message` remains the human-readable text and is
	// unaffected. Members: `peer-unavailable` — the channel this command was
	// sent on has no subscriber, i.e. the service that answers it has not
	// connected yet. Transient by nature (a peer still starting), which is what
	// distinguishes it from a refusal: retrying is the correct response.
	// `not-found` — the resource this command addressed does not exist in this
	// knowledge base. A verdict, not a symptom: it is emitted only where the
	// answer comes from the event store, which is the system of record, and
	// never from a projection that may merely be lagging. Deterministic, so
	// unlike `peer-unavailable` retrying is pointless — and consumers may act
	// destructively on it (the SDK deletes a restored tab). Absence is not
	// denial: a future 'exists, but not for you' must travel as its own code,
	// never as this one. `unauthorized` — that code: the caller is authenticated
	// but not permitted to do what it asked. A verdict about the CALLER, not the
	// resource, so retrying under the same credential cannot succeed and a
	// consumer must never spin on it; emitted by `job:claim` for a caller whose
	// token carries no worker role. `none-pending` — a declined claim, not an
	// error: the queue holds no pending job of the requested types. Nothing went
	// wrong; the one code a consumer PARKS on, meaning 'nothing to do until a
	// wake-up'. Emitted by `job:claim` only. A `job:claim` refusal carrying
	// neither is unclassified — a malformed record or a missing injection — and
	// a consumer treats it as 'log it, assume nothing'.
	Code *CommandErrorCode `json:"code,omitempty"`
	// Details Optional additional context (stack trace, field name, etc.)
	Details *string `json:"details,omitempty"`
	// Message Human-readable error message
	Message string `json:"message"`
	// ReferenceId The reference the search was asked for.
	ReferenceId AnnotationId `json:"referenceId"`
}

// MatchSearchRequest Request payload sent on the match:search-request bus
// channel to find candidate matches.
type MatchSearchRequest struct {
	// Context Gathered context for the reference annotation
	Context GatheredContext `json:"context"`
	// Limit Maximum number of candidate results to return
	Limit *int `json:"limit,omitempty"`
	// ReferenceId Annotation ID of the reference to search candidates for
	ReferenceId AnnotationId `json:"referenceId"`
	// ResourceId Resource ID the reference annotation belongs to. Used to scope
	// result events on the EventBus so the events-stream delivers them to
	// participants viewing this resource.
	ResourceId ResourceId `json:"resourceId"`
	// UseSemanticScoring Enable semantic similarity scoring in addition to
	// keyword matching
	UseSemanticScoring *bool `json:"useSemanticScoring,omitempty"`
}

// MatchSearchResult Search results payload emitted on match:search-results
// SSE channel.
type MatchSearchResult struct {
	ReferenceId AnnotationId `json:"referenceId"`
	// Response The scored candidates, best first.
	Response []ScoredResource `json:"response"`
}

// MarshalJSON writes v, each list its schema requires that Go holds as nil
// written as the empty list.
func (v MatchSearchResult) MarshalJSON() ([]byte, error) {
	type written MatchSearchResult
	v.Response = listOf(v.Response)
	return json.Marshal(written(v))
}

type MediaTokenRequest struct {
	// ResourceId The resource ID to generate a media token for
	ResourceId ResourceId `json:"resourceId"`
}

type MediaTokenResponse struct {
	// Token Short-lived media token for use as ?token= query parameter on
	// resource URLs
	Token string `json:"token"`
}

// MemoryGraphConfig A graph held in the memory of the one process that is
// given it: for a test. It cannot be shared between processes, so a service
// that writes the graph for another to read, or reads what another wrote,
// refuses it.
type MemoryGraphConfig struct {
	Type MemoryGraphConfigType `json:"type"`
}

func (MemoryGraphConfig) memberOfGraphConfig()   {}
func (MemoryGraphConfig) told() (string, string) { return "type", "memory" }

type MemoryGraphConfigType string

// The values of MemoryGraphConfigType.
const (
	MemoryGraphConfigTypeMemory MemoryGraphConfigType = "memory"
)

// Valid is whether e is one of MemoryGraphConfigType's values.
func (e MemoryGraphConfigType) Valid() bool {
	switch e {
	case MemoryGraphConfigTypeMemory:
		return true
	}
	return false
}

// MemoryVectorsConfig A vector index held in the memory of the one process
// that is given it: for a test. It cannot be shared between processes, so a
// service that writes the index for another to search, or searches what
// another wrote, refuses it.
type MemoryVectorsConfig struct {
	Type MemoryVectorsConfigType `json:"type"`
}

func (MemoryVectorsConfig) memberOfVectorsConfig() {}
func (MemoryVectorsConfig) told() (string, string) { return "type", "memory" }

type MemoryVectorsConfigType string

// The values of MemoryVectorsConfigType.
const (
	MemoryVectorsConfigTypeMemory MemoryVectorsConfigType = "memory"
)

// Valid is whether e is one of MemoryVectorsConfigType's values.
func (e MemoryVectorsConfigType) Valid() bool {
	switch e {
	case MemoryVectorsConfigTypeMemory:
		return true
	}
	return false
}

// Motivation Xynolog-supported W3C Web Annotation motivations -
// https://www.w3.org/TR/annotation-vocab/#motivation
type Motivation string

// The values of Motivation.
const (
	MotivationAssessing    Motivation = "assessing"
	MotivationCommenting   Motivation = "commenting"
	MotivationHighlighting Motivation = "highlighting"
	MotivationLinking      Motivation = "linking"
	MotivationTagging      Motivation = "tagging"
)

// Valid is whether e is one of Motivation's values.
func (e Motivation) Valid() bool {
	switch e {
	case MotivationAssessing, MotivationCommenting, MotivationHighlighting, MotivationLinking, MotivationTagging:
		return true
	}
	return false
}

// Neo4jGraphConfig A graph kept in a Neo4j database.
type Neo4jGraphConfig struct {
	// Database Which of the server's databases holds the graph.
	Database string `json:"database"`
	// PasswordEnv The environment variable holding that user's password. The
	// password is never a value here.
	PasswordEnv string               `json:"passwordEnv"`
	Type        Neo4jGraphConfigType `json:"type"`
	// Uri Where the database is reached (`bolt://host:7687`).
	Uri string `json:"uri"`
	// Username The user the service connects as.
	Username string `json:"username"`
}

func (Neo4jGraphConfig) memberOfGraphConfig()   {}
func (Neo4jGraphConfig) told() (string, string) { return "type", "neo4j" }

type Neo4jGraphConfigType string

// The values of Neo4jGraphConfigType.
const (
	Neo4jGraphConfigTypeNeo4j Neo4jGraphConfigType = "neo4j"
)

// Valid is whether e is one of Neo4jGraphConfigType's values.
func (e Neo4jGraphConfigType) Valid() bool {
	switch e {
	case Neo4jGraphConfigTypeNeo4j:
		return true
	}
	return false
}

// NeptuneGraphConfig A graph kept in Amazon Neptune, asked in Gremlin. No
// service has been run against one.
type NeptuneGraphConfig struct {
	// Endpoint The cluster's endpoint: its host name.
	Endpoint string `json:"endpoint"`
	// Port The port its Gremlin endpoint listens on.
	Port int                    `json:"port"`
	Type NeptuneGraphConfigType `json:"type"`
}

func (NeptuneGraphConfig) memberOfGraphConfig()   {}
func (NeptuneGraphConfig) told() (string, string) { return "type", "neptune" }

type NeptuneGraphConfigType string

// The values of NeptuneGraphConfigType.
const (
	NeptuneGraphConfigTypeNeptune NeptuneGraphConfigType = "neptune"
)

// Valid is whether e is one of NeptuneGraphConfigType's values.
func (e NeptuneGraphConfigType) Valid() bool {
	switch e {
	case NeptuneGraphConfigTypeNeptune:
		return true
	}
	return false
}

// NewKnowledgeBase What registering a knowledge base takes: everything a
// registered one holds but its id, which the client's list makes. It has a
// did, because registering follows a sign-in: the knowledge base has already
// said what it is.
type NewKnowledgeBase struct {
	// Did The did the knowledge base reported of itself.
	Did      string     `json:"did"`
	Endpoint KbEndpoint `json:"endpoint"`
	// Label What a person reads the knowledge base as. Once the knowledge base
	// has described itself, its own name.
	Label string `json:"label"`
	// LastRead The last time the knowledge base described itself. Absent until
	// it has, in an answer that carried this entry's did.
	LastRead *KbRead `json:"lastRead,omitempty"`
}

// OcrConfidence How well an OCR engine read the pixels.
type OcrConfidence struct {
	// LowConfidenceWords Words the engine was unsure of.
	LowConfidenceWords int `json:"lowConfidenceWords"`
	// Mean Mean per-word confidence, 0-100.
	Mean       float64 `json:"mean"`
	TotalWords int     `json:"totalWords"`
}

// OllamaEmbeddingConfig An embedding model served by an Ollama.
type OllamaEmbeddingConfig struct {
	// BaseUrl The address the Ollama's API is reached at (`http://host:11434`).
	BaseUrl string `json:"baseUrl"`
	// Model The model asked for, by the name the Ollama serves it under.
	Model string                    `json:"model"`
	Type  OllamaEmbeddingConfigType `json:"type"`
}

func (OllamaEmbeddingConfig) memberOfEmbeddingConfig() {}
func (OllamaEmbeddingConfig) told() (string, string)   { return "type", "ollama" }

type OllamaEmbeddingConfigType string

// The values of OllamaEmbeddingConfigType.
const (
	OllamaEmbeddingConfigTypeOllama OllamaEmbeddingConfigType = "ollama"
)

// Valid is whether e is one of OllamaEmbeddingConfigType's values.
func (e OllamaEmbeddingConfigType) Valid() bool {
	switch e {
	case OllamaEmbeddingConfigTypeOllama:
		return true
	}
	return false
}

// OneOrMoreAgents One Agent, or a non-empty list of them: the parties PROV-O
// and the Web Annotation model let a resource or an annotation name in one
// place, as one agent or several.
type OneOrMoreAgents struct {
	union[oneOrMoreAgentsMember]
}

// oneOrMoreAgentsMember is a member of OneOrMoreAgents: Agent,
// OneOrMoreAgentsList.
type oneOrMoreAgentsMember interface {
	memberOfOneOrMoreAgents()
}

// OneOrMoreAgentsList is a OneOrMoreAgents that is a list.
type OneOrMoreAgentsList []Agent

func (OneOrMoreAgentsList) memberOfOneOrMoreAgents() {}

// OneOrMoreStrings One string, or a non-empty list of them: a JSON-LD term
// that may take one value or several.
type OneOrMoreStrings struct {
	union[oneOrMoreStringsMember]
}

// oneOrMoreStringsMember is a member of OneOrMoreStrings:
// OneOrMoreStringsText, OneOrMoreStringsList.
type oneOrMoreStringsMember interface {
	memberOfOneOrMoreStrings()
}

// OneOrMoreStringsList is a OneOrMoreStrings that is a list.
type OneOrMoreStringsList []string

func (OneOrMoreStringsList) memberOfOneOrMoreStrings() {}

// OneOrMoreStringsText is a OneOrMoreStrings that is text.
type OneOrMoreStringsText string

func (OneOrMoreStringsText) memberOfOneOrMoreStrings() {}

// OneOrMoreUris One URI, or a non-empty list of them: a JSON-LD term that may
// name one resource or several.
type OneOrMoreUris struct {
	union[oneOrMoreUrisMember]
}

// oneOrMoreUrisMember is a member of OneOrMoreUris: OneOrMoreUrisText,
// OneOrMoreUrisList.
type oneOrMoreUrisMember interface {
	memberOfOneOrMoreUris()
}

// OneOrMoreUrisList is a OneOrMoreUris that is a list.
type OneOrMoreUrisList []string

func (OneOrMoreUrisList) memberOfOneOrMoreUris() {}

// OneOrMoreUrisText is a OneOrMoreUris that is text.
type OneOrMoreUrisText string

func (OneOrMoreUrisText) memberOfOneOrMoreUris() {}

// PdfClass The class a PDF is sorted into, which decides how its text is
// read. smelter/extraction-cases.json states what each class is.
type PdfClass string

// The values of PdfClass.
const (
	PdfClassA PdfClass = "A"
	PdfClassB PdfClass = "B"
	PdfClassC PdfClass = "C"
	PdfClassD PdfClass = "D"
	PdfClassE PdfClass = "E"
	PdfClassF PdfClass = "F"
	PdfClassG PdfClass = "G"
)

// Valid is whether e is one of PdfClass's values.
func (e PdfClass) Valid() bool {
	switch e {
	case PdfClassA, PdfClassB, PdfClassC, PdfClassD, PdfClassE, PdfClassF, PdfClassG:
		return true
	}
	return false
}

// PdfTextItem One positioned text run. Coordinates are PDF points with the
// origin at the bottom-left of the page, Y increasing upward; the flip to
// canvas pixels happens in the browser.
type PdfTextItem struct {
	// End Offset into AnchoredText.text, in Unicode code points from its start,
	// exclusive.
	End    int     `json:"end"`
	Height float64 `json:"height"`
	// Page 1-indexed page number.
	Page int `json:"page"`
	// Start Offset into AnchoredText.text, in Unicode code points from its
	// start, inclusive.
	Start int     `json:"start"`
	Width float64 `json:"width"`
	X     float64 `json:"x"`
	Y     float64 `json:"y"`
}

// PersistedEventId `p-<scope>-<sequenceNumber>` — the id of a persisted event
// delivered on a scoped subscription. Resumable: send it back as that scope's
// `lastEventId`. Stable across connections, so a client dedups by it.
type (
	PersistedEventId = string
)

// PrincipalProfileCommand Bus command saying what a principal is called. The
// gateway emits it when a principal ACTS, carrying the display name it just
// verified on its token; a principal may also emit it itself, for itself,
// which is how an agent, whose token carries no name, says what it is called.
// Either way the gateway stamps `_userId` with the sender's verified DID, so
// a principal names only itself. The Stower persists it as
// principal:profiled, and only when the name differs from the latest one
// recorded for that DID — so the log holds one line per name a principal has
// had, not one per act. A name is a fact ABOUT an identity, never part of the
// record of an act: no artifact carries it, and readers resolve it from the
// profiles projection. Emitted for a person and for an agent alike; never for
// a request that merely reads.
type PrincipalProfileCommand struct {
	// UserId The principal's DID, injected by the /bus/emit gateway from the
	// verified token. Clients do not set this.
	UserId *UserId `json:"_userId,omitempty"`
	// Name The display name: from the issuer's `name` claim, as verified on the
	// token that carried an act, or what the principal said of itself. A token
	// with no name produces no command from the gateway — the issuer is where a
	// person's name is set, and absence is recorded as absence.
	Name string `json:"name"`
}

// PrincipalProfiledPayload Payload for principal:profiled — what this
// principal is called, as the issuer's verified `name` claim said or as the
// principal said of itself, recorded once per change (system-level, no
// resourceId). The event's `userId` is the principal's DID; this payload is
// the fact about it. Provenance never reads it: every artifact joins on the
// DID alone, and this is projected into profiles.json for readers to resolve
// against. Two lines for one DID mean the name changed, and the timestamps
// say when — which is why no artifact ever had to freeze a copy.
type PrincipalProfiledPayload struct {
	// Name The display name as of this event: from the issuer's verified `name`
	// claim, or what the principal said of itself.
	Name string `json:"name"`
}

// Profile What a principal last said it is called, and when: the profile a
// `principal:profiled` event gives.
type Profile struct {
	// Name The name the principal last gave.
	Name string `json:"name"`
	// Since The timestamp of the event that gave it.
	Since string `json:"since"`
}

// ProfilesProjection What the principals of a knowledge base are called: the
// file `projections/__system__/profiles.json` under the state directory, the
// sum of the `principal:profiled` events. The Archivist writes it; the
// Archivist and the Librarian read it to name the principals a reply
// mentions. Written as JSON indented by two spaces.
type ProfilesProjection struct {
	// Profiles Each principal's current profile, keyed by its DID.
	Profiles map[string]Profile `json:"profiles"`
}

// ProtectedResourceMetadata OAuth 2.0 Protected Resource Metadata (RFC 9728):
// which authorization server this knowledge base trusts, served at
// /.well-known/oauth-protected-resource so a client — the Browser, an MCP
// client — learns where to send a user to sign in without configuration. A
// 401 from any protected route points here in its WWW-Authenticate challenge.
type ProtectedResourceMetadata struct {
	// AuthorizationServers Issuer identifiers whose tokens this resource accepts
	// — the configured identity issuer.
	AuthorizationServers []string `json:"authorization_servers"`
	// BearerMethodsSupported How a bearer token reaches this resource: the
	// Authorization header only.
	BearerMethodsSupported []ProtectedResourceMetadataBearerMethodsSupportedItem `json:"bearer_methods_supported"`
	// Resource This knowledge base's resource identifier: its did:web identity
	// resolved to an https URL (did:web:example.github.io:my-kb identifies
	// https://example.github.io/my-kb). This is the exact value a token's aud
	// claim must carry. It is an identifier, not an address — nothing
	// dereferences it, and a knowledge base reached over http in local
	// development still names itself by the https form, which is what makes the
	// value stable across every host, port and proxy it is reached through.
	Resource string `json:"resource"`
	// ResourceName The knowledge base's name, for a client's sign-in prompt.
	ResourceName *string `json:"resource_name,omitempty"`
}

// MarshalJSON writes v, each list its schema requires that Go holds as nil
// written as the empty list.
func (v ProtectedResourceMetadata) MarshalJSON() ([]byte, error) {
	type written ProtectedResourceMetadata
	v.AuthorizationServers = listOf(v.AuthorizationServers)
	v.BearerMethodsSupported = listOf(v.BearerMethodsSupported)
	return json.Marshal(written(v))
}

type ProtectedResourceMetadataBearerMethodsSupportedItem string

// The values of ProtectedResourceMetadataBearerMethodsSupportedItem.
const (
	ProtectedResourceMetadataBearerMethodsSupportedItemHeader ProtectedResourceMetadataBearerMethodsSupportedItem = "header"
)

// Valid is whether e is one of
// ProtectedResourceMetadataBearerMethodsSupportedItem's values.
func (e ProtectedResourceMetadataBearerMethodsSupportedItem) Valid() bool {
	switch e {
	case ProtectedResourceMetadataBearerMethodsSupportedItemHeader:
		return true
	}
	return false
}

// QdrantVectorsConfig A vector index kept in a Qdrant server, asked over its
// REST API with a token.
type QdrantVectorsConfig struct {
	// Host The server's host.
	Host string `json:"host"`
	// Port The port its REST API listens on.
	Port int `json:"port"`
	// TokenEnv The environment variable holding the token the service presents
	// to the server on every request, which says what of the index it may read
	// and write. The token is never a value here.
	TokenEnv string                  `json:"tokenEnv"`
	Type     QdrantVectorsConfigType `json:"type"`
}

func (QdrantVectorsConfig) memberOfVectorsConfig() {}
func (QdrantVectorsConfig) told() (string, string) { return "type", "qdrant" }

type QdrantVectorsConfigType string

// The values of QdrantVectorsConfigType.
const (
	QdrantVectorsConfigTypeQdrant QdrantVectorsConfigType = "qdrant"
)

// Valid is whether e is one of QdrantVectorsConfigType's values.
func (e QdrantVectorsConfigType) Valid() bool {
	switch e {
	case QdrantVectorsConfigTypeQdrant:
		return true
	}
	return false
}

// ReplyEventId `e-<channel>:<correlationId>` — the id of a frame that carries
// a correlationId. Deterministic: the same reply has the same id on every
// connection, so a copy arriving on two connections (a reconnect overlap, or
// a replay of a retained reply) dedups. Never a resumption watermark.
type (
	ReplyEventId = string
)

// Representation A specific, byte-addressable rendition of a resource
// (file/asset/variant).
type Representation struct {
	// Id Stable ID for this representation.
	Id *string `json:"@id,omitempty"`
	// Type Type(s), e.g., schema:MediaObject.
	Type *OneOrMoreStrings `json:"@type,omitempty"`
	// ByteSize Size of the payload in bytes.
	ByteSize *int `json:"byteSize,omitempty"`
	// Checksum The SHA-256 of the bytes, as 64 lower-case hexadecimal digits
	// with nothing before them. Whatever compares the checksums of two
	// representations compares this text.
	Checksum *string `json:"checksum,omitempty"`
	// ConformsTo Profile/shape the bytes conform to (e.g., a JSON profile or SVG
	// profile).
	ConformsTo *OneOrMoreUris `json:"conformsTo,omitempty"`
	Created    *string        `json:"created,omitempty"`
	// Duration Seconds (audio/video).
	Duration *float64 `json:"duration,omitempty"`
	// Encoding Compression/transfer encoding if applicable.
	Encoding *string `json:"encoding,omitempty"`
	Filename *string `json:"filename,omitempty"`
	// Height Pixels (images/video).
	Height *int `json:"height,omitempty"`
	// Language IETF BCP 47 language tag (e.g., en, es-ES).
	Language *string `json:"language,omitempty"`
	// MediaType MIME/media type (e.g., text/markdown, image/png).
	MediaType string  `json:"mediaType"`
	Modified  *string `json:"modified,omitempty"`
	// Rel Semantics of this rendition relative to the resource (e.g., original,
	// thumbnail, preview, derived).
	Rel *RepresentationRel `json:"rel,omitempty"`
	// StorageUri Working-tree URI identifying where this rendition's bytes live.
	// Only file:// is supported (e.g. file://docs/overview.md). The single home
	// of the storage location: maintained across moves (yield:moved relocates
	// it), absent when the resource has no stored bytes.
	StorageUri *string   `json:"storageUri,omitempty"`
	Tags       *[]string `json:"tags,omitempty"`
	// Width Pixels (images/video).
	Width *int `json:"width,omitempty"`
	// AdditionalProperties is every member the schema does not name, as it came.
	AdditionalProperties map[string]any `json:"-"`
}

func (Representation) memberOfResourceDescriptorRepresentations() {}

// MarshalJSON writes v with the members its schema does not name, and each
// list its schema requires that Go holds as nil as the empty list.
func (v Representation) MarshalJSON() ([]byte, error) {
	type written Representation
	return writeOpen(written(v), v.AdditionalProperties)
}

// UnmarshalJSON reads v, and each member its schema does not name into its
// AdditionalProperties.
func (v *Representation) UnmarshalJSON(raw []byte) error {
	type read Representation
	return readOpen(raw, (*read)(v), &v.AdditionalProperties)
}

// RepresentationAddedPayload Payload for yield:representation-added domain
// event
type RepresentationAddedPayload struct {
	Representation Representation `json:"representation"`
}

// RepresentationNotFound The Archivist's 404 for a resource's bytes: an
// ErrorResponse whose `code` says which half of the lookup failed —
// `resource` when the record holds no such resource, `representation` when it
// holds the resource but not its bytes. Each reader answers the two
// differently.
type RepresentationNotFound struct {
	// Code A machine-readable class, when the route defines one.
	Code    RepresentationNotFoundCode `json:"code"`
	Details any                        `json:"details,omitempty"`
	// Error What went wrong, in a sentence.
	Error string `json:"error"`
	// Hint What the caller can do about it, when there is something to say.
	Hint *string `json:"hint,omitempty"`
}

// RepresentationNotFoundCode A machine-readable class, when the route defines
// one.
type RepresentationNotFoundCode string

// The values of RepresentationNotFoundCode.
const (
	RepresentationNotFoundCodeResource       RepresentationNotFoundCode = "resource"
	RepresentationNotFoundCodeRepresentation RepresentationNotFoundCode = "representation"
)

// Valid is whether e is one of RepresentationNotFoundCode's values.
func (e RepresentationNotFoundCode) Valid() bool {
	switch e {
	case RepresentationNotFoundCodeResource, RepresentationNotFoundCodeRepresentation:
		return true
	}
	return false
}

// RepresentationRel Semantics of this rendition relative to the resource
// (e.g., original, thumbnail, preview, derived).
type RepresentationRel string

// The values of RepresentationRel.
const (
	RepresentationRelOriginal  RepresentationRel = "original"
	RepresentationRelThumbnail RepresentationRel = "thumbnail"
	RepresentationRelPreview   RepresentationRel = "preview"
	RepresentationRelOptimized RepresentationRel = "optimized"
	RepresentationRelDerived   RepresentationRel = "derived"
	RepresentationRelOther     RepresentationRel = "other"
)

// Valid is whether e is one of RepresentationRel's values.
func (e RepresentationRel) Valid() bool {
	switch e {
	case RepresentationRelOriginal, RepresentationRelThumbnail, RepresentationRelPreview, RepresentationRelOptimized, RepresentationRelDerived, RepresentationRelOther:
		return true
	}
	return false
}

// RepresentationRemovedPayload Payload for yield:representation-removed
// domain event
type RepresentationRemovedPayload struct {
	// Checksum Checksum of the representation to remove
	Checksum string `json:"checksum"`
}

// ResourceAnnotations The annotations on one resource, as its materialized
// view holds them.
type ResourceAnnotations struct {
	// Annotations Each annotation as the `mark:added` event that recorded it
	// carried it, with the body changes recorded since applied. In the order
	// they were first recorded.
	Annotations []Annotation `json:"annotations"`
	ResourceId  ResourceId   `json:"resourceId"`
	// UpdatedAt The timestamp of the last event applied; the empty string before
	// any.
	UpdatedAt string `json:"updatedAt"`
	// Version How many of the resource's events the view has applied.
	Version int `json:"version"`
}

// MarshalJSON writes v, each list its schema requires that Go holds as nil
// written as the empty list.
func (v ResourceAnnotations) MarshalJSON() ([]byte, error) {
	type written ResourceAnnotations
	v.Annotations = listOf(v.Annotations)
	return json.Marshal(written(v))
}

// ResourceArchivedPayload Payload for mark:archived domain event
type ResourceArchivedPayload struct {
	Reason *string `json:"reason,omitempty"`
}

// ResourceClonedPayload Payload for yield:cloned domain event
type ResourceClonedPayload struct {
	ContentByteSize *int   `json:"contentByteSize,omitempty"`
	ContentChecksum string `json:"contentChecksum"`
	// Creator Who made the clone — the emitter, derived at write time. A clone
	// is never job-fulfilling. Absent on events written before derivation
	// existed, whose emitter was their only party.
	Creator          *Agent        `json:"creator,omitempty"`
	EntityTypes      *[]string     `json:"entityTypes,omitempty"`
	Format           ContentFormat `json:"format"`
	Language         *string       `json:"language,omitempty"`
	Name             string        `json:"name"`
	ParentResourceId ResourceId    `json:"parentResourceId"`
	// StorageUri Where the clone's bytes are, on the resource's primary
	// Representation — the same single home `yield:created` writes to.
	StorageUri *string `json:"storageUri,omitempty"`
	// WasAttributedTo PROV-O wasAttributedTo, derived at write time: the cloner
	// alone. The value the resource view carries.
	WasAttributedTo *OneOrMoreAgents `json:"wasAttributedTo,omitempty"`
}

// ResourceCreatedPayload Payload for yield:created domain event
type ResourceCreatedPayload struct {
	ContentByteSize *int `json:"contentByteSize,omitempty"`
	// ContentChecksum SHA-256 of content
	ContentChecksum string `json:"contentChecksum"`
	// Creator Who requested this resource — derived by the knowledge base at
	// write time, never sent by the emitter. For a resource created in
	// fulfilment of a job, the requester recorded on that job's job:assigned;
	// otherwise the emitter itself. Absent on events written before derivation
	// existed, whose emitter was their only party.
	Creator     *Agent        `json:"creator,omitempty"`
	EntityTypes *[]string     `json:"entityTypes,omitempty"`
	Format      ContentFormat `json:"format"`
	// GeneratedFrom What this resource was generated from: the resource, and the
	// annotation on it when the generation was for one. The resource's
	// descriptor names the resource as `wasDerivedFrom`.
	GeneratedFrom    *ResourceCreatedPayloadGeneratedFrom `json:"generatedFrom,omitempty"`
	GenerationPrompt *string                              `json:"generationPrompt,omitempty"`
	Generator        *OneOrMoreAgents                     `json:"generator,omitempty"`
	IsDraft          *bool                                `json:"isDraft,omitempty"`
	// JobId The job this resource was made in fulfilment of, when its create
	// cited one. A write that cites the same job on this resource, by the one
	// who made it, is attributed to that job's requester: the `creator` here.
	JobId    *JobId  `json:"jobId,omitempty"`
	Language *string `json:"language,omitempty"`
	Name     string  `json:"name"`
	// StorageUri The creating instruction's URI, recorded on the event.
	// Append-only, so this value never changes — the LOCATION the projection
	// serves is maintained across moves and lives on the resource's primary
	// Representation, relocated by yield:moved. Optional: a resource may have no
	// bytes. Working-tree URI, only file:// is supported (e.g.
	// file://docs/overview.md).
	StorageUri *string `json:"storageUri,omitempty"`
	// WasAttributedTo PROV-O wasAttributedTo, derived at write time from
	// `creator` and the executor: both parties when they differ, one when they
	// are the same. The value the resource view carries; readers do not
	// re-derive it.
	WasAttributedTo *OneOrMoreAgents `json:"wasAttributedTo,omitempty"`
}

// ResourceCreatedPayloadGeneratedFrom What this resource was generated from:
// the resource, and the annotation on it when the generation was for one. The
// resource's descriptor names the resource as `wasDerivedFrom`.
type ResourceCreatedPayloadGeneratedFrom struct {
	AnnotationId *AnnotationId `json:"annotationId,omitempty"`
	ResourceId   ResourceId    `json:"resourceId"`
}

// ResourceDescriptor Metadata about a resource (1:1 with its URI). JSON-LD
// subject is @id. Link to concrete bytes via representations.
type ResourceDescriptor struct {
	// Context JSON-LD context; URI, object, or array of these.
	Context ResourceDescriptorContext `json:"@context"`
	// Id The id of the resource being described.
	Id ResourceId `json:"@id"`
	// Type Type(s) of the resource (IRIs/CURIEs via @context).
	Type *OneOrMoreStrings `json:"@type,omitempty"`
	// About Topics (IRIs or strings).
	About *OneOrMoreStrings `json:"about,omitempty"`
	// Archived Application-specific: Whether this resource is archived
	Archived *bool `json:"archived,omitempty"`
	// AvailableFormats Convenience set summarizing media types across
	// representations.
	AvailableFormats *[]string `json:"availableFormats,omitempty"`
	// ConformsTo Profile/shape URI this resource description conforms to.
	ConformsTo   *OneOrMoreUris `json:"conformsTo,omitempty"`
	DateCreated  *string        `json:"dateCreated,omitempty"`
	DateModified *string        `json:"dateModified,omitempty"`
	Description  *string        `json:"description,omitempty"`
	// EntityTypes Application-specific: Entity types for this resource
	EntityTypes *[]string `json:"entityTypes,omitempty"`
	// Generator Software peer that produced this resource (W3C Web Annotation
	// model). Its identity is the verified emitter of the create; the parameters
	// are the producer's to state.
	Generator *OneOrMoreAgents `json:"generator,omitempty"`
	HasPart   *[]string        `json:"hasPart,omitempty"`
	// Identifier Persistent identifiers (e.g., DOI, URN).
	Identifier *ResourceDescriptorIdentifier `json:"identifier,omitempty"`
	// IsDraft Application-specific: Whether this resource is a draft
	IsDraft  *bool     `json:"isDraft,omitempty"`
	IsPartOf *[]string `json:"isPartOf,omitempty"`
	License  *string   `json:"license,omitempty"`
	Name     string    `json:"name"`
	// OriginatedFrom Original URI from a source knowledge base when this
	// resource was imported
	OriginatedFrom *string `json:"originatedFrom,omitempty"`
	// Representations Managed or referenced byte-level renditions of this
	// resource.
	Representations ResourceDescriptorRepresentations `json:"representations"`
	// SameAs Equivalent/authoritative references.
	SameAs *[]string `json:"sameAs,omitempty"`
	// SourceAnnotationId Application-specific: ID of annotation that triggered
	// generation
	SourceAnnotationId *AnnotationId `json:"sourceAnnotationId,omitempty"`
	// SourceResourceId Application-specific: ID of source resource for
	// clones/derivatives
	SourceResourceId *ResourceId `json:"sourceResourceId,omitempty"`
	Version          *string     `json:"version,omitempty"`
	// WasAttributedTo W3C PROV — every party responsible for this resource,
	// derived by the knowledge base at creation from verified identities:
	// `[requester, generator]` for a resource a job produced, collapsed to the
	// one agent when the requester produced it. Never accepted from an emitter.
	WasAttributedTo *OneOrMoreAgents `json:"wasAttributedTo,omitempty"`
	// WasDerivedFrom W3C PROV: the resource, or resources, this one was derived
	// from, each by its id
	WasDerivedFrom *ResourceDescriptorWasDerivedFrom `json:"wasDerivedFrom,omitempty"`
	// AdditionalProperties is every member the schema does not name, as it came.
	AdditionalProperties map[string]any `json:"-"`
}

// MarshalJSON writes v with the members its schema does not name, and each
// list its schema requires that Go holds as nil as the empty list.
func (v ResourceDescriptor) MarshalJSON() ([]byte, error) {
	type written ResourceDescriptor
	return writeOpen(written(v), v.AdditionalProperties)
}

// UnmarshalJSON reads v, and each member its schema does not name into its
// AdditionalProperties.
func (v *ResourceDescriptor) UnmarshalJSON(raw []byte) error {
	type read ResourceDescriptor
	return readOpen(raw, (*read)(v), &v.AdditionalProperties)
}

// ResourceDescriptorContext JSON-LD context; URI, object, or array of these.
type ResourceDescriptorContext struct {
	union[resourceDescriptorContextMember]
}

// resourceDescriptorContextMember is a member of ResourceDescriptorContext:
// ResourceDescriptorContextText, ResourceDescriptorContextObject,
// ResourceDescriptorContextList.
type resourceDescriptorContextMember interface {
	memberOfResourceDescriptorContext()
}

type ResourceDescriptorContextItem struct {
	union[resourceDescriptorContextItemMember]
}

// resourceDescriptorContextItemMember is a member of
// ResourceDescriptorContextItem: ResourceDescriptorContextItemText,
// ResourceDescriptorContextItemObject.
type resourceDescriptorContextItemMember interface {
	memberOfResourceDescriptorContextItem()
}

// ResourceDescriptorContextItemObject is a ResourceDescriptorContextItem that
// is an object.
type ResourceDescriptorContextItemObject map[string]any

func (ResourceDescriptorContextItemObject) memberOfResourceDescriptorContextItem() {}

// ResourceDescriptorContextItemText is a ResourceDescriptorContextItem that
// is text.
type ResourceDescriptorContextItemText string

func (ResourceDescriptorContextItemText) memberOfResourceDescriptorContextItem() {}

// ResourceDescriptorContextList is a ResourceDescriptorContext that is a
// list.
type ResourceDescriptorContextList []ResourceDescriptorContextItem

func (ResourceDescriptorContextList) memberOfResourceDescriptorContext() {}

// ResourceDescriptorContextObject is a ResourceDescriptorContext that is an
// object.
type ResourceDescriptorContextObject map[string]any

func (ResourceDescriptorContextObject) memberOfResourceDescriptorContext() {}

// ResourceDescriptorContextText is a ResourceDescriptorContext that is text.
type ResourceDescriptorContextText string

func (ResourceDescriptorContextText) memberOfResourceDescriptorContext() {}

// ResourceDescriptorIdentifier Persistent identifiers (e.g., DOI, URN).
type ResourceDescriptorIdentifier struct {
	union[resourceDescriptorIdentifierMember]
}

// resourceDescriptorIdentifierMember is a member of
// ResourceDescriptorIdentifier: ResourceDescriptorIdentifierText,
// ResourceDescriptorIdentifierList, ResourceDescriptorIdentifierObject.
type resourceDescriptorIdentifierMember interface {
	memberOfResourceDescriptorIdentifier()
}

// ResourceDescriptorIdentifierList is a ResourceDescriptorIdentifier that is
// a list.
type ResourceDescriptorIdentifierList []string

func (ResourceDescriptorIdentifierList) memberOfResourceDescriptorIdentifier() {}

type ResourceDescriptorIdentifierObject struct {
	Id     *string `json:"@id,omitempty"`
	Scheme *string `json:"scheme,omitempty"`
	Value  *string `json:"value,omitempty"`
	// AdditionalProperties is every member the schema does not name, as it came.
	AdditionalProperties map[string]any `json:"-"`
}

func (ResourceDescriptorIdentifierObject) memberOfResourceDescriptorIdentifier() {}

// MarshalJSON writes v with the members its schema does not name, and each
// list its schema requires that Go holds as nil as the empty list.
func (v ResourceDescriptorIdentifierObject) MarshalJSON() ([]byte, error) {
	type written ResourceDescriptorIdentifierObject
	return writeOpen(written(v), v.AdditionalProperties)
}

// UnmarshalJSON reads v, and each member its schema does not name into its
// AdditionalProperties.
func (v *ResourceDescriptorIdentifierObject) UnmarshalJSON(raw []byte) error {
	type read ResourceDescriptorIdentifierObject
	return readOpen(raw, (*read)(v), &v.AdditionalProperties)
}

// ResourceDescriptorIdentifierText is a ResourceDescriptorIdentifier that is
// text.
type ResourceDescriptorIdentifierText string

func (ResourceDescriptorIdentifierText) memberOfResourceDescriptorIdentifier() {}

// ResourceDescriptorRepresentations Managed or referenced byte-level
// renditions of this resource.
type ResourceDescriptorRepresentations struct {
	union[resourceDescriptorRepresentationsMember]
}

// resourceDescriptorRepresentationsMember is a member of
// ResourceDescriptorRepresentations: Representation,
// ResourceDescriptorRepresentationsList.
type resourceDescriptorRepresentationsMember interface {
	memberOfResourceDescriptorRepresentations()
}

// ResourceDescriptorRepresentationsList is a
// ResourceDescriptorRepresentations that is a list.
type ResourceDescriptorRepresentationsList []Representation

func (ResourceDescriptorRepresentationsList) memberOfResourceDescriptorRepresentations() {}

// ResourceDescriptorWasDerivedFrom W3C PROV: the resource, or resources, this
// one was derived from, each by its id
type ResourceDescriptorWasDerivedFrom struct {
	union[resourceDescriptorWasDerivedFromMember]
}

// resourceDescriptorWasDerivedFromMember is a member of
// ResourceDescriptorWasDerivedFrom: ResourceId,
// ResourceDescriptorWasDerivedFromList.
type resourceDescriptorWasDerivedFromMember interface {
	memberOfResourceDescriptorWasDerivedFrom()
}

// ResourceDescriptorWasDerivedFromList is a ResourceDescriptorWasDerivedFrom
// that is a list.
type ResourceDescriptorWasDerivedFromList []ResourceId

func (ResourceDescriptorWasDerivedFromList) memberOfResourceDescriptorWasDerivedFrom() {}

// ResourceErrorEvent A client-local notice that a command on a resource
// failed, for a UI to show: the payload of `mark:create-error`,
// `mark:delete-error` and `bind:body-error`. Emitted by the caller that
// awaited the command, which knows whose command failed on which resource.
// The `*-failed` wire replies are correlation plumbing and are not for this.
type ResourceErrorEvent struct {
	// Message Human-readable error message.
	Message string `json:"message"`
	// ResourceId The resource the command addressed.
	ResourceId ResourceId `json:"resourceId"`
}

func (ResourceId) memberOfAnnotationTargetValue()            {}
func (ResourceId) memberOfResourceDescriptorWasDerivedFrom() {}

// ResourceMovedPayload Payload for yield:moved domain event
type ResourceMovedPayload struct {
	// FromUri Previous file:// URI
	FromUri string `json:"fromUri"`
	// ToUri New file:// URI
	ToUri string `json:"toUri"`
}

// ResourceUnarchivedPayload Payload for mark:unarchived domain event (empty
// payload)
type (
	ResourceUnarchivedPayload = map[string]any
)

// ResourceUpdatedPayload Payload for yield:updated domain event
type ResourceUpdatedPayload struct {
	ContentByteSize *int `json:"contentByteSize,omitempty"`
	// ContentChecksum SHA-256 of new content
	ContentChecksum string `json:"contentChecksum"`
}

// ResourceUpload The multipart upload that creates a resource. A client sends
// it to the gateway's `POST /resources`; the gateway forwards it untouched to
// the Archivist's `POST /resources`, which stores the bytes and records the
// resource. One body, two hops.
type ResourceUpload struct {
	// ArchiveOriginal With `cloneToken`: 'true' archives the source once the
	// clone exists.
	ArchiveOriginal *string `json:"archiveOriginal,omitempty"`
	// CloneToken A clone token from `yield:clone-token-requested`. With it, the
	// resource is created as a clone of the token's source, inheriting its
	// entity types; `language`, `entityTypes` and the generation fields are then
	// not read.
	CloneToken *string `json:"cloneToken,omitempty"`
	// EntityTypes JSON-stringified array of entity type names
	EntityTypes *string `json:"entityTypes,omitempty"`
	// File Binary content
	File []byte `json:"file"`
	// Format Media type of the content (e.g. text/plain, text/markdown,
	// image/png)
	Format string `json:"format"`
	// GenerationPrompt For AI-generated resources: the prompt that drove
	// generation
	GenerationPrompt *string `json:"generationPrompt,omitempty"`
	// Generator For AI-generated resources: JSON-stringified Agent naming the
	// model/worker that produced the content. Its identity must be the uploading
	// agent's own — the knowledge base refuses a generator naming anyone else.
	// `creator` and `wasAttributedTo` are never sent; the knowledge base derives
	// them from the cited job.
	Generator *string `json:"generator,omitempty"`
	// IsDraft 'true' or 'false' — whether the resource is a draft
	IsDraft *string `json:"isDraft,omitempty"`
	// JobId The job this resource fulfils, when a worker is creating it.
	// Forwarded onto yield:create; the knowledge base derives who requested the
	// resource from the cited job's own events, and refuses a worker-role create
	// that cites none. Absent for a person's own upload.
	JobId *JobId `json:"jobId,omitempty"`
	// Language ISO 639-1 language code
	Language *string `json:"language,omitempty"`
	// Name Human-readable resource name
	Name string `json:"name"`
	// SourceAnnotationId For AI-generated resources: the annotation that
	// triggered generation. Nested into generatedFrom.annotationId on the
	// persisted event.
	SourceAnnotationId *AnnotationId `json:"sourceAnnotationId,omitempty"`
	// SourceResourceId For AI-generated resources: the source resource the
	// generating annotation lives on. Nested into generatedFrom.resourceId on
	// the persisted event.
	SourceResourceId *ResourceId `json:"sourceResourceId,omitempty"`
	// StorageUri Where the content lives (file://... for local). Required — the
	// client names the location; the server does not derive one.
	StorageUri string `json:"storageUri"`
}

// MarshalJSON writes v, each list its schema requires that Go holds as nil
// written as the empty list.
func (v ResourceUpload) MarshalJSON() ([]byte, error) {
	type written ResourceUpload
	v.File = listOf(v.File)
	return json.Marshal(written(v))
}

// ResourceView A resource's materialized view: the file the Archivist writes
// at `resources/<ab>/<cd>/<resourceId>.json` under the knowledge base's state
// directory, and every reader of that file reads. It is what the resource's
// events add up to, and is rebuilt from the event log whenever it is missing.
// Written as JSON indented by two spaces, by writing a sibling temporary file
// and renaming it onto the path, so a reader sees a whole document or none.
type ResourceView struct {
	Annotations ResourceAnnotations `json:"annotations"`
	// LastSequence The sequence number of the last event applied. A graph read
	// that follows a write waits for the graph projection to reach it.
	LastSequence int                `json:"lastSequence"`
	Resource     ResourceDescriptor `json:"resource"`
}

// ScoredResource A resource returned by a search, carrying its relevance
// score and the reason it matched.
type ScoredResource struct {
	// Context JSON-LD context; URI, object, or array of these.
	Context ResourceDescriptorContext `json:"@context"`
	// Id The id of the resource being described.
	Id ResourceId `json:"@id"`
	// Type Type(s) of the resource (IRIs/CURIEs via @context).
	Type *OneOrMoreStrings `json:"@type,omitempty"`
	// About Topics (IRIs or strings).
	About *OneOrMoreStrings `json:"about,omitempty"`
	// Archived Application-specific: Whether this resource is archived
	Archived *bool `json:"archived,omitempty"`
	// AvailableFormats Convenience set summarizing media types across
	// representations.
	AvailableFormats *[]string `json:"availableFormats,omitempty"`
	// ConformsTo Profile/shape URI this resource description conforms to.
	ConformsTo   *OneOrMoreUris `json:"conformsTo,omitempty"`
	DateCreated  *string        `json:"dateCreated,omitempty"`
	DateModified *string        `json:"dateModified,omitempty"`
	Description  *string        `json:"description,omitempty"`
	// EntityTypes Application-specific: Entity types for this resource
	EntityTypes *[]string `json:"entityTypes,omitempty"`
	// Generator Software peer that produced this resource (W3C Web Annotation
	// model). Its identity is the verified emitter of the create; the parameters
	// are the producer's to state.
	Generator *OneOrMoreAgents `json:"generator,omitempty"`
	HasPart   *[]string        `json:"hasPart,omitempty"`
	// Identifier Persistent identifiers (e.g., DOI, URN).
	Identifier *ResourceDescriptorIdentifier `json:"identifier,omitempty"`
	// IsDraft Application-specific: Whether this resource is a draft
	IsDraft  *bool     `json:"isDraft,omitempty"`
	IsPartOf *[]string `json:"isPartOf,omitempty"`
	License  *string   `json:"license,omitempty"`
	// MatchReason Human-readable reason for the match.
	MatchReason *string `json:"matchReason,omitempty"`
	Name        string  `json:"name"`
	// OriginatedFrom Original URI from a source knowledge base when this
	// resource was imported
	OriginatedFrom *string `json:"originatedFrom,omitempty"`
	// Representations Managed or referenced byte-level renditions of this
	// resource.
	Representations ResourceDescriptorRepresentations `json:"representations"`
	// SameAs Equivalent/authoritative references.
	SameAs *[]string `json:"sameAs,omitempty"`
	// Score Relevance score assigned by the matcher; higher is a better
	// candidate.
	Score *float64 `json:"score,omitempty"`
	// SourceAnnotationId Application-specific: ID of annotation that triggered
	// generation
	SourceAnnotationId *AnnotationId `json:"sourceAnnotationId,omitempty"`
	// SourceResourceId Application-specific: ID of source resource for
	// clones/derivatives
	SourceResourceId *ResourceId `json:"sourceResourceId,omitempty"`
	Version          *string     `json:"version,omitempty"`
	// WasAttributedTo W3C PROV — every party responsible for this resource,
	// derived by the knowledge base at creation from verified identities:
	// `[requester, generator]` for a resource a job produced, collapsed to the
	// one agent when the requester produced it. Never accepted from an emitter.
	WasAttributedTo *OneOrMoreAgents `json:"wasAttributedTo,omitempty"`
	// WasDerivedFrom W3C PROV: the resource, or resources, this one was derived
	// from, each by its id
	WasDerivedFrom *ResourceDescriptorWasDerivedFrom `json:"wasDerivedFrom,omitempty"`
	// AdditionalProperties is every member the schema does not name, as it came.
	AdditionalProperties map[string]any `json:"-"`
}

// MarshalJSON writes v with the members its schema does not name, and each
// list its schema requires that Go holds as nil as the empty list.
func (v ScoredResource) MarshalJSON() ([]byte, error) {
	type written ScoredResource
	return writeOpen(written(v), v.AdditionalProperties)
}

// UnmarshalJSON reads v, and each member its schema does not name into its
// AdditionalProperties.
func (v *ScoredResource) UnmarshalJSON(raw []byte) error {
	type read ScoredResource
	return readOpen(raw, (*read)(v), &v.AdditionalProperties)
}

// Selector One W3C selector: a way of finding a segment of a resource. Tell
// them apart by `type`, which is required on each and single-valued.
type Selector struct {
	union[selectorMember]
}

// selectorMember is a member of Selector: TextPositionSelector,
// TextQuoteSelector, SvgSelector, FragmentSelector.
type selectorMember interface {
	memberOfSelector()
}

// Discriminator is the `type` this value states.
func (u Selector) Discriminator() (string, error) { return u.stated("type") }

// ValueByDiscriminator is the member this value's `type` names.
func (u Selector) ValueByDiscriminator() (any, error) {
	tag, err := u.Discriminator()
	if err != nil {
		return nil, err
	}
	switch tag {
	case "TextPositionSelector":
		return as[TextPositionSelector](u.union)
	case "TextQuoteSelector":
		return as[TextQuoteSelector](u.union)
	case "SvgSelector":
		return as[SvgSelector](u.union)
	case "FragmentSelector":
		return as[FragmentSelector](u.union)
	}
	return nil, unnamedMember("Selector", "type", tag)
}

func (Selector) memberOfAnnotationSelector() {}

type SemanticMatch struct {
	// AnnotationId Source annotation ID, if the match is from an annotation
	AnnotationId *AnnotationId `json:"annotationId,omitempty"`
	// EntityTypes Entity types on the matched passage
	EntityTypes *[]string `json:"entityTypes,omitempty"`
	// MachineRead True when this passage's text was recognized from pixels (OCR
	// of a scanned page) rather than read from the document. Absent means read
	// directly — the common case — so the flag is only present where it changes
	// how the text should be trusted. It travels with the passage because a
	// consumer receives the chunk with no document attached and cannot recompute
	// how the text was obtained.
	MachineRead *bool `json:"machineRead,omitempty"`
	// ResourceId Source resource ID
	ResourceId ResourceId `json:"resourceId"`
	// ResourceName The source resource's display name, resolved from its view at
	// gather time. Required: a match card must name its source, and corpus
	// matches routinely come from outside the graph neighborhood, so there is no
	// node to borrow a name from. A match whose source no longer resolves to a
	// view is dropped by the producer rather than served nameless.
	ResourceName string `json:"resourceName"`
	// Score Cosine similarity score (0-1)
	Score float64 `json:"score"`
	// Text The chunk text that matched
	Text string `json:"text"`
}

// ServiceAddress The host and port a service listens at.
type ServiceAddress struct {
	Host string `json:"host"`
	Port int    `json:"port"`
}

// ServiceIdentity The identity provider a service's account signs in at, by
// its issuer.
type ServiceIdentity struct {
	// Issuer The issuer URL, exactly as tokens carry it in `iss`.
	Issuer string `json:"issuer"`
}

// SessionJoinedEvent A participant opened a live connection to this KB — an
// SSE stream on /bus/subscribe. Presence is CONNECTION lifecycle, not login:
// a token can be minted and sit unused, so what this reports is that someone
// is WATCHING. One person with two tabs produces two of these, which is why
// connectionId is required — the DID alone cannot tell two connections apart,
// and a consumer that counts DIDs will undercount viewers.
type SessionJoinedEvent struct {
	// ConnectionId Identifies this connection for its lifetime. The matching
	// session:left carries the same value.
	ConnectionId string `json:"connectionId"`
	// Participant DID of the authenticated principal on that connection. A
	// person or a software agent — the bus does not distinguish.
	Participant UserId `json:"participant"`
}

// SessionLeftEvent A participant's live connection to this KB ended — the SSE
// stream aborted. Carries the same connectionId as the session:joined that
// opened it, so a consumer tracking who is present can retire the right
// connection rather than assuming one per participant.
type SessionLeftEvent struct {
	// ConnectionId The connectionId announced by the matching session:joined.
	ConnectionId string `json:"connectionId"`
	// Participant DID of the authenticated principal on that connection.
	Participant UserId `json:"participant"`
}

// SettingsHoverDelayChangedEvent Emitted when the hover delay setting changes
type SettingsHoverDelayChangedEvent struct {
	HoverDelayMs int `json:"hoverDelayMs"`
}

// SettingsLocaleChangedEvent Emitted when the UI locale setting changes
type SettingsLocaleChangedEvent struct {
	Locale string `json:"locale"`
}

// SettingsThemeChangedEvent Emitted when the UI theme setting changes
type SettingsThemeChangedEvent struct {
	Theme SettingsThemeChangedEventTheme `json:"theme"`
}

type SettingsThemeChangedEventTheme string

// The values of SettingsThemeChangedEventTheme.
const (
	SettingsThemeChangedEventThemeLight  SettingsThemeChangedEventTheme = "light"
	SettingsThemeChangedEventThemeDark   SettingsThemeChangedEventTheme = "dark"
	SettingsThemeChangedEventThemeSystem SettingsThemeChangedEventTheme = "system"
)

// Valid is whether e is one of SettingsThemeChangedEventTheme's values.
func (e SettingsThemeChangedEventTheme) Valid() bool {
	switch e {
	case SettingsThemeChangedEventThemeLight, SettingsThemeChangedEventThemeDark, SettingsThemeChangedEventThemeSystem:
		return true
	}
	return false
}

// SmeltRebuildAnchorsCommand Bus command to rebuild anchored-text artifacts
// by re-running extraction — every geometry-capable resource when resourceId
// is absent, one resource when present. Served by the Smelter, serialized
// (each unit can be a multi-second OCR pass), and never destructive: nothing
// is deleted first, stale entries are simply overwritten. Re-anchoring makes
// zero embedding calls — the vectors are already correct; only the derived
// map is re-made. Partial completion replies failed, with counts: a rebuild
// that quietly skipped resources would present exactly like a document with
// no text.
type SmeltRebuildAnchorsCommand struct {
	// UserId Authenticated user's DID, injected by the /bus/emit gateway.
	// Clients do not set this.
	UserId *UserId `json:"_userId,omitempty"`
	// ResourceId When present, re-anchor only this resource; otherwise every
	// geometry-capable resource in the catalog.
	ResourceId *ResourceId `json:"resourceId,omitempty"`
}

// SmeltSettled The payload of `smelt:settled`: the Smelter's decision for one
// resource's content, keyed by the checksum of the bytes it inspected.
// `indexed`: the content is in the vector index. `skipped`: it declined, and
// `reason` says why.
type SmeltSettled struct {
	// ContentChecksum The checksum of the bytes inspected.
	ContentChecksum string              `json:"contentChecksum"`
	Outcome         SmeltSettledOutcome `json:"outcome"`
	// Reason Why the content was skipped.
	Reason *SmeltSettledReason `json:"reason,omitempty"`
	// ResourceId The resource whose content was inspected.
	ResourceId ResourceId `json:"resourceId"`
}

type SmeltSettledOutcome string

// The values of SmeltSettledOutcome.
const (
	SmeltSettledOutcomeIndexed SmeltSettledOutcome = "indexed"
	SmeltSettledOutcomeSkipped SmeltSettledOutcome = "skipped"
)

// Valid is whether e is one of SmeltSettledOutcome's values.
func (e SmeltSettledOutcome) Valid() bool {
	switch e {
	case SmeltSettledOutcomeIndexed, SmeltSettledOutcomeSkipped:
		return true
	}
	return false
}

// SmeltSettledReason Why the content was skipped.
type SmeltSettledReason string

// The values of SmeltSettledReason.
const (
	SmeltSettledReasonNoExtractor SmeltSettledReason = "no-extractor"
	SmeltSettledReasonEmpty       SmeltSettledReason = "empty"
	SmeltSettledReasonNoTextLayer SmeltSettledReason = "no-text-layer"
	SmeltSettledReasonEncrypted   SmeltSettledReason = "encrypted"
	SmeltSettledReasonCorrupt     SmeltSettledReason = "corrupt"
	SmeltSettledReasonTooLarge    SmeltSettledReason = "too-large"
)

// Valid is whether e is one of SmeltSettledReason's values.
func (e SmeltSettledReason) Valid() bool {
	switch e {
	case SmeltSettledReasonNoExtractor, SmeltSettledReasonEmpty, SmeltSettledReasonNoTextLayer, SmeltSettledReasonEncrypted, SmeltSettledReasonCorrupt, SmeltSettledReasonTooLarge:
		return true
	}
	return false
}

// SmelterConfig Everything a Smelter reads at boot: nothing in it is
// defaulted by the Smelter. Whoever starts a Smelter writes it, from the
// knowledge base's stack documents, and the Smelter reads it from the path
// its `--config` flag names. This schema is the contract, and a Smelter needs
// no launcher. Started without `--config`, or with a path that names no file,
// the Smelter refuses to start and says which. No secret is a value here: an
// embedding provider's key is named by the environment variable that holds
// it, and the Smelter's own service account is `XYNOLOG_OIDC_CLIENT_ID` and
// `XYNOLOG_OIDC_CLIENT_SECRET` in its environment. A document that does not
// validate is refused at boot, naming each failing field.
type SmelterConfig struct {
	// Archivist Where the Archivist listens. The Smelter reads a resource's
	// bytes from it, and keeps the anchored-text store there, as its service
	// account.
	Archivist ServiceAddress `json:"archivist"`
	// Chunking The two numbers a text is cut by before it is embedded, both in
	// tokens, a token being taken as four code points.
	Chunking    SmelterConfigChunking `json:"chunking"`
	CursorsPath CursorsPath           `json:"cursorsPath"`
	Embedding   EmbeddingConfig       `json:"embedding"`
	// GatewayUrl The URL the Smelter reaches the gateway at: its route to the
	// bus.
	GatewayUrl string `json:"gatewayUrl"`
	// Identity The issuer the Smelter's service account signs in at.
	Identity  ServiceIdentity `json:"identity"`
	Kb        KbIdentity      `json:"kb"`
	LogFormat LogFormat       `json:"logFormat"`
	LogLevel  LogLevel        `json:"logLevel"`
	// PdfsAtOnce How many PDFs the Smelter works on at once. Each one under way
	// holds its bytes, a page of a scan in pixels beside the OCR process reading
	// it, and its text and vectors, so whoever starts a Smelter sizes this with
	// the memory it gives it. Every other resource is indexed beside them.
	PdfsAtOnce int `json:"pdfsAtOnce"`
	// Port The port the Smelter answers `/health` on.
	Port    int           `json:"port"`
	Vectors VectorsConfig `json:"vectors"`
}

// SmelterConfigChunking The two numbers a text is cut by before it is
// embedded, both in tokens, a token being taken as four code points.
type SmelterConfigChunking struct {
	// ChunkSize The size of a chunk.
	ChunkSize int `json:"chunkSize"`
	// Overlap How much of a chunk the next one repeats.
	Overlap int `json:"overlap"`
}

type SpecificResource struct {
	// Purpose Why this body is included
	Purpose *BodyPurpose `json:"purpose,omitempty"`
	// Source The id of the resource this body leads to
	Source ResourceId           `json:"source"`
	Type   SpecificResourceType `json:"type"`
}

func (SpecificResource) memberOfAnnotationBody() {}
func (SpecificResource) told() (string, string)  { return "type", "SpecificResource" }

type SpecificResourceType string

// The values of SpecificResourceType.
const (
	SpecificResourceTypeSpecificResource SpecificResourceType = "SpecificResource"
)

// Valid is whether e is one of SpecificResourceType's values.
func (e SpecificResourceType) Valid() bool {
	switch e {
	case SpecificResourceTypeSpecificResource:
		return true
	}
	return false
}

type StatusResponse struct {
	AuthenticatedAs *string                `json:"authenticatedAs,omitempty"`
	Features        StatusResponseFeatures `json:"features"`
	Message         string                 `json:"message"`
	Status          string                 `json:"status"`
	Version         string                 `json:"version"`
}

type StatusResponseFeatures struct {
	Collaboration   string `json:"collaboration"`
	SemanticContent string `json:"semanticContent"`
}

// StorageUriEntry One entry of the storage-uri index: the file
// `projections/storage-uri/<ab>/<cd>/<sha256 of the URI, hex>.json` under the
// state directory. It answers which resource's content is at a place in the
// working tree. Written as JSON indented by two spaces, `uri` first.
type StorageUriEntry struct {
	ResourceId ResourceId `json:"resourceId"`
	// Uri The `file://` URI of a place in the working tree, relative to the
	// knowledge base's root.
	Uri string `json:"uri"`
}

// StoredEventResponse A persisted domain event with metadata. Flat shape —
// event fields and metadata are peers.
type StoredEventResponse struct {
	// Id Unique event ID (UUID)
	Id       string        `json:"id"`
	Metadata EventMetadata `json:"metadata"`
	// Payload Event-type-specific payload
	Payload map[string]any `json:"payload"`
	// ResourceId Resource this event affects (absent for system events)
	ResourceId *ResourceId `json:"resourceId,omitempty"`
	// Timestamp When the event occurred
	Timestamp string `json:"timestamp"`
	// Type Event type (flow verb name, e.g. mark:added)
	Type string `json:"type"`
	// UserId DID of the user who triggered the event
	UserId UserId `json:"userId"`
	// Version Event schema version
	Version int `json:"version"`
}

// SupportedMediaType Base MIME types (no parameters) admitted by Xynolog.
// Membership is the create/yield gate — every member is storable, nameable,
// and uploadable. What more the system can do with a type (render, annotate,
// extract text, author) is curated per type in @xynolog/core's media-type
// registry, which is keyed by this enum.
type SupportedMediaType string

// The values of SupportedMediaType.
const (
	SupportedMediaTypeTextPlain                                                            SupportedMediaType = "text/plain"
	SupportedMediaTypeTextMarkdown                                                         SupportedMediaType = "text/markdown"
	SupportedMediaTypeTextHtml                                                             SupportedMediaType = "text/html"
	SupportedMediaTypeTextCss                                                              SupportedMediaType = "text/css"
	SupportedMediaTypeTextCsv                                                              SupportedMediaType = "text/csv"
	SupportedMediaTypeTextXml                                                              SupportedMediaType = "text/xml"
	SupportedMediaTypeApplicationJson                                                      SupportedMediaType = "application/json"
	SupportedMediaTypeApplicationXml                                                       SupportedMediaType = "application/xml"
	SupportedMediaTypeApplicationYaml                                                      SupportedMediaType = "application/yaml"
	SupportedMediaTypeApplicationXYaml                                                     SupportedMediaType = "application/x-yaml"
	SupportedMediaTypeApplicationPdf                                                       SupportedMediaType = "application/pdf"
	SupportedMediaTypeApplicationMsword                                                    SupportedMediaType = "application/msword"
	SupportedMediaTypeApplicationVndOpenxmlformatsOfficedocumentWordprocessingmlDocument   SupportedMediaType = "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
	SupportedMediaTypeApplicationVndMsExcel                                                SupportedMediaType = "application/vnd.ms-excel"
	SupportedMediaTypeApplicationVndOpenxmlformatsOfficedocumentSpreadsheetmlSheet         SupportedMediaType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
	SupportedMediaTypeApplicationVndMsPowerpoint                                           SupportedMediaType = "application/vnd.ms-powerpoint"
	SupportedMediaTypeApplicationVndOpenxmlformatsOfficedocumentPresentationmlPresentation SupportedMediaType = "application/vnd.openxmlformats-officedocument.presentationml.presentation"
	SupportedMediaTypeApplicationZip                                                       SupportedMediaType = "application/zip"
	SupportedMediaTypeApplicationGzip                                                      SupportedMediaType = "application/gzip"
	SupportedMediaTypeApplicationXTar                                                      SupportedMediaType = "application/x-tar"
	SupportedMediaTypeApplicationX7zCompressed                                             SupportedMediaType = "application/x-7z-compressed"
	SupportedMediaTypeApplicationOctetStream                                               SupportedMediaType = "application/octet-stream"
	SupportedMediaTypeApplicationWasm                                                      SupportedMediaType = "application/wasm"
	SupportedMediaTypeImagePng                                                             SupportedMediaType = "image/png"
	SupportedMediaTypeImageJpeg                                                            SupportedMediaType = "image/jpeg"
	SupportedMediaTypeImageGif                                                             SupportedMediaType = "image/gif"
	SupportedMediaTypeImageWebp                                                            SupportedMediaType = "image/webp"
	SupportedMediaTypeImageSvgPlusXml                                                      SupportedMediaType = "image/svg+xml"
	SupportedMediaTypeImageBmp                                                             SupportedMediaType = "image/bmp"
	SupportedMediaTypeImageTiff                                                            SupportedMediaType = "image/tiff"
	SupportedMediaTypeImageXIcon                                                           SupportedMediaType = "image/x-icon"
	SupportedMediaTypeVideoMp4                                                             SupportedMediaType = "video/mp4"
	SupportedMediaTypeVideoMpeg                                                            SupportedMediaType = "video/mpeg"
	SupportedMediaTypeVideoWebm                                                            SupportedMediaType = "video/webm"
	SupportedMediaTypeVideoOgg                                                             SupportedMediaType = "video/ogg"
	SupportedMediaTypeVideoQuicktime                                                       SupportedMediaType = "video/quicktime"
	SupportedMediaTypeVideoXMsvideo                                                        SupportedMediaType = "video/x-msvideo"
	SupportedMediaTypeAudioMpeg                                                            SupportedMediaType = "audio/mpeg"
	SupportedMediaTypeAudioWav                                                             SupportedMediaType = "audio/wav"
	SupportedMediaTypeAudioOgg                                                             SupportedMediaType = "audio/ogg"
	SupportedMediaTypeAudioWebm                                                            SupportedMediaType = "audio/webm"
	SupportedMediaTypeAudioAac                                                             SupportedMediaType = "audio/aac"
	SupportedMediaTypeAudioFlac                                                            SupportedMediaType = "audio/flac"
	SupportedMediaTypeTextJavascript                                                       SupportedMediaType = "text/javascript"
	SupportedMediaTypeApplicationJavascript                                                SupportedMediaType = "application/javascript"
	SupportedMediaTypeTextXTypescript                                                      SupportedMediaType = "text/x-typescript"
	SupportedMediaTypeApplicationTypescript                                                SupportedMediaType = "application/typescript"
	SupportedMediaTypeTextXPython                                                          SupportedMediaType = "text/x-python"
	SupportedMediaTypeTextXJava                                                            SupportedMediaType = "text/x-java"
	SupportedMediaTypeTextXC                                                               SupportedMediaType = "text/x-c"
	SupportedMediaTypeTextXCPlusPlus                                                       SupportedMediaType = "text/x-c++"
	SupportedMediaTypeTextXCsharp                                                          SupportedMediaType = "text/x-csharp"
	SupportedMediaTypeTextXGo                                                              SupportedMediaType = "text/x-go"
	SupportedMediaTypeTextXRust                                                            SupportedMediaType = "text/x-rust"
	SupportedMediaTypeTextXRuby                                                            SupportedMediaType = "text/x-ruby"
	SupportedMediaTypeTextXPhp                                                             SupportedMediaType = "text/x-php"
	SupportedMediaTypeTextXSwift                                                           SupportedMediaType = "text/x-swift"
	SupportedMediaTypeTextXKotlin                                                          SupportedMediaType = "text/x-kotlin"
	SupportedMediaTypeTextXShell                                                           SupportedMediaType = "text/x-shell"
	SupportedMediaTypeFontWoff                                                             SupportedMediaType = "font/woff"
	SupportedMediaTypeFontWoff2                                                            SupportedMediaType = "font/woff2"
	SupportedMediaTypeFontTtf                                                              SupportedMediaType = "font/ttf"
	SupportedMediaTypeFontOtf                                                              SupportedMediaType = "font/otf"
)

// Valid is whether e is one of SupportedMediaType's values.
func (e SupportedMediaType) Valid() bool {
	switch e {
	case SupportedMediaTypeTextPlain, SupportedMediaTypeTextMarkdown, SupportedMediaTypeTextHtml, SupportedMediaTypeTextCss, SupportedMediaTypeTextCsv, SupportedMediaTypeTextXml, SupportedMediaTypeApplicationJson, SupportedMediaTypeApplicationXml, SupportedMediaTypeApplicationYaml, SupportedMediaTypeApplicationXYaml, SupportedMediaTypeApplicationPdf, SupportedMediaTypeApplicationMsword, SupportedMediaTypeApplicationVndOpenxmlformatsOfficedocumentWordprocessingmlDocument, SupportedMediaTypeApplicationVndMsExcel, SupportedMediaTypeApplicationVndOpenxmlformatsOfficedocumentSpreadsheetmlSheet, SupportedMediaTypeApplicationVndMsPowerpoint, SupportedMediaTypeApplicationVndOpenxmlformatsOfficedocumentPresentationmlPresentation, SupportedMediaTypeApplicationZip, SupportedMediaTypeApplicationGzip, SupportedMediaTypeApplicationXTar, SupportedMediaTypeApplicationX7zCompressed, SupportedMediaTypeApplicationOctetStream, SupportedMediaTypeApplicationWasm, SupportedMediaTypeImagePng, SupportedMediaTypeImageJpeg, SupportedMediaTypeImageGif, SupportedMediaTypeImageWebp, SupportedMediaTypeImageSvgPlusXml, SupportedMediaTypeImageBmp, SupportedMediaTypeImageTiff, SupportedMediaTypeImageXIcon, SupportedMediaTypeVideoMp4, SupportedMediaTypeVideoMpeg, SupportedMediaTypeVideoWebm, SupportedMediaTypeVideoOgg, SupportedMediaTypeVideoQuicktime, SupportedMediaTypeVideoXMsvideo, SupportedMediaTypeAudioMpeg, SupportedMediaTypeAudioWav, SupportedMediaTypeAudioOgg, SupportedMediaTypeAudioWebm, SupportedMediaTypeAudioAac, SupportedMediaTypeAudioFlac, SupportedMediaTypeTextJavascript, SupportedMediaTypeApplicationJavascript, SupportedMediaTypeTextXTypescript, SupportedMediaTypeApplicationTypescript, SupportedMediaTypeTextXPython, SupportedMediaTypeTextXJava, SupportedMediaTypeTextXC, SupportedMediaTypeTextXCPlusPlus, SupportedMediaTypeTextXCsharp, SupportedMediaTypeTextXGo, SupportedMediaTypeTextXRust, SupportedMediaTypeTextXRuby, SupportedMediaTypeTextXPhp, SupportedMediaTypeTextXSwift, SupportedMediaTypeTextXKotlin, SupportedMediaTypeTextXShell, SupportedMediaTypeFontWoff, SupportedMediaTypeFontWoff2, SupportedMediaTypeFontTtf, SupportedMediaTypeFontOtf:
		return true
	}
	return false
}

type SvgSelector struct {
	Type SvgSelectorType `json:"type"`
	// Value SVG markup defining the region (must include xmlns attribute)
	Value string `json:"value"`
}

func (SvgSelector) memberOfSelector()      {}
func (SvgSelector) told() (string, string) { return "type", "SvgSelector" }

type SvgSelectorType string

// The values of SvgSelectorType.
const (
	SvgSelectorTypeSvgSelector SvgSelectorType = "SvgSelector"
)

// Valid is whether e is one of SvgSelectorType's values.
func (e SvgSelectorType) Valid() bool {
	switch e {
	case SvgSelectorTypeSvgSelector:
		return true
	}
	return false
}

// TagCategory A single category within a tag schema (e.g. 'Issue' in IRAC,
// 'distinguished' in legal-citation-treatment). Each category carries
// methodology-bound semantics: a name, a description, and examples used in
// the LLM prompt.
type TagCategory struct {
	Description string   `json:"description"`
	Examples    []string `json:"examples"`
	Name        string   `json:"name"`
}

// MarshalJSON writes v, each list its schema requires that Go holds as nil
// written as the empty list.
func (v TagCategory) MarshalJSON() ([]byte, error) {
	type written TagCategory
	v.Examples = listOf(v.Examples)
	return json.Marshal(written(v))
}

// TagSchema A structural-analysis schema (e.g. legal-irac, scientific-imrad,
// argument-toulmin). Defines a methodology framework as an id, name,
// description, domain hint, and an ordered list of categories. KBs and their
// skills register schemas with the runtime registry via
// `frame.addTagSchema(...)` at session start.
type TagSchema struct {
	Description string `json:"description"`
	// Domain Free-form domain hint (e.g. 'legal', 'scientific', 'general'). Used
	// in the LLM prompt to tune the model's analysis voice. KB authors choose.
	Domain string        `json:"domain"`
	Id     string        `json:"id"`
	Name   string        `json:"name"`
	Tags   []TagCategory `json:"tags"`
}

// MarshalJSON writes v, each list its schema requires that Go holds as nil
// written as the empty list.
func (v TagSchema) MarshalJSON() ([]byte, error) {
	type written TagSchema
	v.Tags = listOf(v.Tags)
	return json.Marshal(written(v))
}

// TagSchemaAddedPayload Payload for frame:tag-schema-added domain event
// (system-level, no resourceId — fan-out is global to the KB).
type TagSchemaAddedPayload struct {
	Schema TagSchema `json:"schema"`
}

// TagSchemasProjection The knowledge base's tag schemas: the file
// `projections/__system__/tagschemas.json` under the state directory, the sum
// of the `frame:tag-schema-added` events. Written as JSON indented by two
// spaces.
type TagSchemasProjection struct {
	// TagSchemas Every tag schema added, sorted by `id`. A schema added again
	// under an `id` replaces the one held.
	TagSchemas []TagSchema `json:"tagSchemas"`
}

// MarshalJSON writes v, each list its schema requires that Go holds as nil
// written as the empty list.
func (v TagSchemasProjection) MarshalJSON() ([]byte, error) {
	type written TagSchemasProjection
	v.TagSchemas = listOf(v.TagSchemas)
	return json.Marshal(written(v))
}

// TaggingJobParams What a tagging job takes: passages of the resource are
// marked with categories of one tag schema.
type TaggingJobParams struct {
	// Categories The categories of that schema to tag with.
	Categories []string `json:"categories"`
	// Language The language the annotations' own text is written in. BCP 47.
	Language   *string                    `json:"language,omitempty"`
	Motivation TaggingJobParamsMotivation `json:"motivation"`
	// SchemaId The tag schema to tag by. It is one the knowledge base registers.
	SchemaId string `json:"schemaId"`
	// SourceLanguage The language of the resource being read. BCP 47.
	SourceLanguage *string `json:"sourceLanguage,omitempty"`
}

func (TaggingJobParams) memberOfMarkJobParams() {}
func (TaggingJobParams) told() (string, string) { return "motivation", "tagging" }

// MarshalJSON writes v, each list its schema requires that Go holds as nil
// written as the empty list.
func (v TaggingJobParams) MarshalJSON() ([]byte, error) {
	type written TaggingJobParams
	v.Categories = listOf(v.Categories)
	return json.Marshal(written(v))
}

type TaggingJobParamsMotivation string

// The values of TaggingJobParamsMotivation.
const (
	TaggingJobParamsMotivationTagging TaggingJobParamsMotivation = "tagging"
)

// Valid is whether e is one of TaggingJobParamsMotivation's values.
func (e TaggingJobParamsMotivation) Valid() bool {
	switch e {
	case TaggingJobParamsMotivationTagging:
		return true
	}
	return false
}

type TextPositionSelector struct {
	// End Offset into the resource's decoded text, exactly as decoded, in
	// Unicode code points from its start: just past where the selected text
	// ends.
	End int `json:"end"`
	// Start Offset into the resource's decoded text, exactly as decoded, in
	// Unicode code points from its start: where the selected text starts.
	Start int                      `json:"start"`
	Type  TextPositionSelectorType `json:"type"`
}

func (TextPositionSelector) memberOfSelector()      {}
func (TextPositionSelector) told() (string, string) { return "type", "TextPositionSelector" }

type TextPositionSelectorType string

// The values of TextPositionSelectorType.
const (
	TextPositionSelectorTypeTextPositionSelector TextPositionSelectorType = "TextPositionSelector"
)

// Valid is whether e is one of TextPositionSelectorType's values.
func (e TextPositionSelectorType) Valid() bool {
	switch e {
	case TextPositionSelectorTypeTextPositionSelector:
		return true
	}
	return false
}

type TextQuoteSelector struct {
	Exact  string                `json:"exact"`
	Prefix *string               `json:"prefix,omitempty"`
	Suffix *string               `json:"suffix,omitempty"`
	Type   TextQuoteSelectorType `json:"type"`
}

func (TextQuoteSelector) memberOfSelector()      {}
func (TextQuoteSelector) told() (string, string) { return "type", "TextQuoteSelector" }

type TextQuoteSelectorType string

// The values of TextQuoteSelectorType.
const (
	TextQuoteSelectorTypeTextQuoteSelector TextQuoteSelectorType = "TextQuoteSelector"
)

// Valid is whether e is one of TextQuoteSelectorType's values.
func (e TextQuoteSelectorType) Valid() bool {
	switch e {
	case TextQuoteSelectorTypeTextQuoteSelector:
		return true
	}
	return false
}

type TextualBody struct {
	// Format MIME type (defaults to text/plain)
	Format *string `json:"format,omitempty"`
	// Language BCP 47 language tag
	Language *string `json:"language,omitempty"`
	// Purpose Why this body is included
	Purpose *BodyPurpose    `json:"purpose,omitempty"`
	Type    TextualBodyType `json:"type"`
	// Value The text content (e.g., entity type name)
	Value string `json:"value"`
}

func (TextualBody) memberOfAnnotationBody() {}
func (TextualBody) told() (string, string)  { return "type", "TextualBody" }

type TextualBodyType string

// The values of TextualBodyType.
const (
	TextualBodyTypeTextualBody TextualBodyType = "TextualBody"
)

// Valid is whether e is one of TextualBodyType's values.
func (e TextualBodyType) Valid() bool {
	switch e {
	case TextualBodyTypeTextualBody:
		return true
	}
	return false
}

// UnitCursor The furthest a single unit got, and what it had counted when it
// got there. A unit left partway is resumed from its cursor rather than
// redone. A finished unit keeps its cursor: `next` at the length of the text,
// `size` the size its last piece was cut at, and its final `found`, `emitted`
// and `errors`, so that an attempt that skips the unit still counts it. A
// cursor never says a unit is finished, wherever it stands: `completedUnits`
// does. A unit is an entity type for a linking job, a category for a tagging
// job, and the job's own motivation for every other — which is why a
// unit-grain checkpoint alone is too coarse: those three have exactly one
// unit, so nothing could be recorded until the whole document was done. MERGE
// IS MONOTONE PER UNIT, not a union. `completedUnits` is a set and converges
// under concurrent snapshots because a set only grows; a cursor converges
// only if a stale snapshot can never move it backward. IT CARRIES THE UNIT'S
// RUNNING TALLIES TOO, and they are required. A resumed unit counts only the
// chunks it actually runs, so without them a retry's terminal record reports
// the remainder of the document as if it were the whole — measured at a
// `found` of 19 where the document yielded 25. The position and the tallies
// are ONE observation of the same committed chunk; splitting them would let a
// resume take the saving and still report a number nobody can trust.
type UnitCursor struct {
	// Emitted Annotations actually committed for this unit through the last
	// committed chunk, after dedupe. With `found` and `errors` it is what the
	// job's terminal result reports, so a resumed unit seeds all three and its
	// record describes the whole document rather than one attempt's share.
	Emitted int `json:"emitted"`
	// Errors Items detection returned for this unit through the last committed
	// chunk that could not be anchored in the text. Carried with the other two
	// tallies so that a resumed job reports the whole document's, and not only
	// its last attempt's.
	Errors int `json:"errors"`
	// Found Items detection has returned for this unit through the last
	// committed chunk — the numerator a resumed attempt continues from rather
	// than restarting at zero. Counts what the model reported, before dedupe.
	Found int `json:"found"`
	// Next Unicode code points of the text consumed once the last COMMITTED
	// chunk completed — the resume position, and the length of the text for a
	// unit whose last chunk it was. Deliberately the chunk's `next`, never its
	// `at`: the checkpoint must not lead the log, so it records where a chunk
	// that is already durable ended, not where the in-flight one began.
	// Recording `at` would make a resume re-run the chunk it already paid for.
	Next int `json:"next"`
	// Size The token size that last committed chunk was cut at — the calibration
	// the attempt paid for over the chunks before it. A resume seeds from this
	// and then takes ONE adaptive step, as if the last outcome were a failure,
	// which it was: the job died. Seeding alone would re-cut the failing piece
	// identically; opening at the default would discard the calibration.
	Size int `json:"size"`
}

type UpdateAnnotationBodyRequest struct {
	// Operations Array of body modification operations to apply
	Operations []BodyOperation `json:"operations"`
	// ResourceId Resource ID containing the annotation (required for O(1) Layer
	// 3 lookup)
	ResourceId ResourceId `json:"resourceId"`
}

// MarshalJSON writes v, each list its schema requires that Go holds as nil
// written as the empty list.
func (v UpdateAnnotationBodyRequest) MarshalJSON() ([]byte, error) {
	type written UpdateAnnotationBodyRequest
	v.Operations = listOf(v.Operations)
	return json.Marshal(written(v))
}

// UserResponse The authenticated principal, as this knowledge base names it.
// The `did` is the identity: it is what the bus stamps on every event, what
// resource creation is attributed to, and what a client must compare against
// to recognise its own work in the data. It is the only identifier: a row id
// would appear nowhere else in the system and correlate with nothing. The
// remaining fields exist to be displayed, and all of them come from the
// token's own claims.
type UserResponse struct {
	// Did The authenticated principal's DID: `did:web:<domain>:agents:<subject>`
	// for an agent, whose token's `kind` claim is `agent`, and
	// `did:web:<domain>:users:<subject>` for a person, where the subject is the
	// issuer claim the knowledge base names its principals by
	// (`identity.subjectClaim`).
	Did UserId `json:"did"`
	// Domain The knowledge base's domain: the authority the principal is named
	// under.
	Domain string `json:"domain"`
	// Email The address the token carries, when it carries one: an agent's
	// account need not have one.
	Email *string `json:"email"`
	Image *string `json:"image"`
	Name  *string `json:"name"`
}

// VectorsConfig The vector index a service writes or searches, and what that
// kind of index needs to be reached: one of the kinds `xynolog-vectors` has a
// store for, told apart by `type`.
type VectorsConfig struct {
	union[vectorsConfigMember]
}

// vectorsConfigMember is a member of VectorsConfig: QdrantVectorsConfig,
// MemoryVectorsConfig.
type vectorsConfigMember interface {
	memberOfVectorsConfig()
}

// Discriminator is the `type` this value states.
func (u VectorsConfig) Discriminator() (string, error) { return u.stated("type") }

// ValueByDiscriminator is the member this value's `type` names.
func (u VectorsConfig) ValueByDiscriminator() (any, error) {
	tag, err := u.Discriminator()
	if err != nil {
		return nil, err
	}
	switch tag {
	case "qdrant":
		return as[QdrantVectorsConfig](u.union)
	case "memory":
		return as[MemoryVectorsConfig](u.union)
	}
	return nil, unnamedMember("VectorsConfig", "type", tag)
}

// VoyageEmbeddingConfig An embedding model served by Voyage AI. No service
// has been run against Voyage itself.
type VoyageEmbeddingConfig struct {
	// ApiKeyEnv The environment variable holding the Voyage API key. The key is
	// never a value here.
	ApiKeyEnv string `json:"apiKeyEnv"`
	// Endpoint The whole address of Voyage's embeddings call
	// (`https://api.voyageai.com/v1/embeddings`).
	Endpoint string `json:"endpoint"`
	// Model The model asked for, by Voyage's name for it.
	Model string                    `json:"model"`
	Type  VoyageEmbeddingConfigType `json:"type"`
}

func (VoyageEmbeddingConfig) memberOfEmbeddingConfig() {}
func (VoyageEmbeddingConfig) told() (string, string)   { return "type", "voyage" }

type VoyageEmbeddingConfigType string

// The values of VoyageEmbeddingConfigType.
const (
	VoyageEmbeddingConfigTypeVoyage VoyageEmbeddingConfigType = "voyage"
)

// Valid is whether e is one of VoyageEmbeddingConfigType's values.
func (e VoyageEmbeddingConfigType) Valid() bool {
	switch e {
	case VoyageEmbeddingConfigTypeVoyage:
		return true
	}
	return false
}

// WeaveApplied The payload of `weave:applied`: the Weaver has applied a
// resource's events to the graph up to this sequence number. Emitted after
// applying an event, or a batch's last event.
type WeaveApplied struct {
	// ResourceId The resource whose events were applied.
	ResourceId ResourceId `json:"resourceId"`
	// SequenceNumber The resource-stream sequence of the last applied event.
	SequenceNumber int `json:"sequenceNumber"`
}

// WeaveRebuildCommand Bus command to rebuild the graph projection from the
// event log — the whole graph when resourceId is absent, one resource when
// present. Served by the Weaver; replaces direct rebuild access, which does
// not survive the Weaver's container split.
type WeaveRebuildCommand struct {
	// UserId Authenticated user's DID, injected by the /bus/emit gateway.
	// Clients do not set this.
	UserId *UserId `json:"_userId,omitempty"`
	// ResourceId When present, rebuild only this resource; otherwise clear and
	// rebuild the entire graph.
	ResourceId *ResourceId `json:"resourceId,omitempty"`
}

// WeaverConfig Everything a Weaver reads at boot: nothing in it is defaulted
// by the Weaver. The launcher writes it for the Weaver it starts, from the
// knowledge base's stack documents, and the Weaver reads it from the path its
// `--config` flag names (its image passes `/etc/xynolog/weaver.json`).
// Whoever starts a Weaver another way writes the same document: this schema
// is the contract, and a Weaver needs no launcher. Started without
// `--config`, or with a path that names no file, the Weaver refuses to start
// and says which. No secret is a value here: the graph database's password is
// named by the environment variable that holds it, and the Weaver's own
// service account is `XYNOLOG_OIDC_CLIENT_ID` and
// `XYNOLOG_OIDC_CLIENT_SECRET` in its environment. A document that does not
// validate is refused at boot, naming each failing field.
type WeaverConfig struct {
	// Archivist Where the Archivist listens. The Weaver reads the record by
	// position from it, and a resource's annotations, as its service account.
	Archivist   ServiceAddress `json:"archivist"`
	CursorsPath CursorsPath    `json:"cursorsPath"`
	// GatewayUrl The URL the Weaver reaches the gateway at: its route to the
	// bus.
	GatewayUrl string      `json:"gatewayUrl"`
	Graph      GraphConfig `json:"graph"`
	// Identity The issuer the Weaver's service account signs in at.
	Identity  ServiceIdentity `json:"identity"`
	Kb        KbIdentity      `json:"kb"`
	LogFormat LogFormat       `json:"logFormat"`
	LogLevel  LogLevel        `json:"logLevel"`
	// Port The port the Weaver answers `/health` on.
	Port int `json:"port"`
}

// WorkerConfig Everything a worker reads at boot: nothing in it is defaulted
// by the worker. The launcher writes it for the machine's worker, from the
// knowledge bases on that worker's list: each local knowledge base as its
// start places it, from its stack documents, and each added by `xynolog
// worker kb add`, offered the engines of the local one it was added from. The
// worker reads it from the path its `--config` flag names (its image passes
// `/etc/xynolog/worker.json`). Whoever starts a worker another way writes the
// same document: this schema is the contract, and a worker needs no launcher.
// Started without `--config`, or with a path that names no file, the worker
// refuses to start and says which. No secret is a value here: a provider's
// key is named by the environment variable that holds it, and the key the
// worker signs in with at every knowledge base is `XYNOLOG_OIDC_CLIENT_KEY`
// in its environment, an RSA private key; each knowledge base names the
// client that holds its public half there. A document that does not validate
// is refused at boot, naming each failing field.
type WorkerConfig struct {
	// KnowledgeBases The knowledge bases this worker does jobs for. At each it
	// signs in, confirms which knowledge base it reached and claims for its
	// engines, apart from every other: one knowledge base's trouble stops that
	// knowledge base's work alone (`contract/WORKER-SERVICE.md` § Knowledge
	// bases). No two name one `domain`, which the worker refuses at boot.
	KnowledgeBases []WorkerKnowledgeBaseConfig `json:"knowledgeBases"`
	LogFormat      LogFormat                   `json:"logFormat"`
	LogLevel       LogLevel                    `json:"logLevel"`
	// ModelCatalogue The path of a model catalogue file: what each model of a
	// provider can take, for the providers whose own APIs do not say (`google`,
	// `openai`, `together`). A worker with an engine of one of those providers
	// refuses to start where the file cannot be read, and where it states
	// nothing of that engine's model. A worker with no such engine does not read
	// it.
	ModelCatalogue string `json:"modelCatalogue"`
	// Port The port the worker answers `/health` on.
	Port int `json:"port"`
}

// MarshalJSON writes v, each list its schema requires that Go holds as nil
// written as the empty list.
func (v WorkerConfig) MarshalJSON() ([]byte, error) {
	type written WorkerConfig
	v.KnowledgeBases = listOf(v.KnowledgeBases)
	return json.Marshal(written(v))
}

// WorkerEngineConfig One engine a worker runs: which it is, the jobs the
// worker claims to do with it, and where its provider is reached.
type WorkerEngineConfig struct {
	// ApiKeyEnv The environment variable holding the provider's API key, when
	// the provider requires one.
	ApiKeyEnv *string `json:"apiKeyEnv,omitempty"`
	// BaseUrl The address the provider's API is reached at.
	BaseUrl string `json:"baseUrl"`
	Engine  Engine `json:"engine"`
	// Jobs The jobs the worker claims to do with this engine, as a claim names
	// them (`job:claim`'s `accepts`): it claims with these filters and no other.
	Jobs []JobFilter `json:"jobs"`
}

// MarshalJSON writes v, each list its schema requires that Go holds as nil
// written as the empty list.
func (v WorkerEngineConfig) MarshalJSON() ([]byte, error) {
	type written WorkerEngineConfig
	v.Jobs = listOf(v.Jobs)
	return json.Marshal(written(v))
}

// WorkerEngineHealth One engine at one knowledge base: which it is, the jobs
// it claims, and what its claims can say of themselves (WORKER-CONTRACT V1).
type WorkerEngineHealth struct {
	// ActiveJob The job it holds, or null.
	ActiveJob *WorkerEngineHealthActiveJob `json:"activeJob"`
	Engine    Engine                       `json:"engine"`
	// Jobs The jobs it claims, as its claims state them.
	Jobs []JobFilter `json:"jobs"`
	// JobsCompleted How many jobs it has completed since the service started.
	JobsCompleted int `json:"jobsCompleted"`
	// LastActivityAt When it was last active, or null.
	LastActivityAt *string `json:"lastActivityAt"`
	// LastClaimAt When it was last handed a job, or null. A claim answered with
	// none pending is not one.
	LastClaimAt *string `json:"lastClaimAt"`
	// LastFinishedAt When a job it held last settled, or null.
	LastFinishedAt *string `json:"lastFinishedAt"`
	// LastQueuedEventAt When a `job:queued` last reached it, or null.
	LastQueuedEventAt *string `json:"lastQueuedEventAt"`
}

// MarshalJSON writes v, each list its schema requires that Go holds as nil
// written as the empty list.
func (v WorkerEngineHealth) MarshalJSON() ([]byte, error) {
	type written WorkerEngineHealth
	v.Jobs = listOf(v.Jobs)
	return json.Marshal(written(v))
}

// WorkerEngineHealthActiveJob The job it holds, or null.
type WorkerEngineHealthActiveJob struct {
	JobId JobId `json:"jobId"`
	// Since When it was handed the job.
	Since string  `json:"since"`
	Type  JobType `json:"type"`
}

// WorkerHealth The Worker service's health answer (WORKER-SERVICE H1). It
// answers only once a knowledge base of its document is confirmed, so a 200
// means it is working somewhere.
type WorkerHealth struct {
	// KnowledgeBases One entry for each of the document's `knowledgeBases`, in
	// its order.
	KnowledgeBases []WorkerKnowledgeBaseHealth `json:"knowledgeBases"`
	Status         WorkerHealthStatus          `json:"status"`
}

// MarshalJSON writes v, each list its schema requires that Go holds as nil
// written as the empty list.
func (v WorkerHealth) MarshalJSON() ([]byte, error) {
	type written WorkerHealth
	v.KnowledgeBases = listOf(v.KnowledgeBases)
	return json.Marshal(written(v))
}

type WorkerHealthStatus string

// The values of WorkerHealthStatus.
const (
	WorkerHealthStatusOk WorkerHealthStatus = "ok"
)

// Valid is whether e is one of WorkerHealthStatus's values.
func (e WorkerHealthStatus) Valid() bool {
	switch e {
	case WorkerHealthStatusOk:
		return true
	}
	return false
}

// WorkerKnowledgeBaseConfig One knowledge base a worker does jobs for: which
// it is, where its gateway is, the account the worker signs in as there, and
// the engines it offers it. The worker signs in, confirms the knowledge base
// and claims at each knowledge base apart from every other.
type WorkerKnowledgeBaseConfig struct {
	// Domain The knowledge base's did:web domain, as it answers
	// `browse:kb-requested`: which knowledge base this is. The worker confirms
	// it there before it claims, and refuses a knowledge base that answers
	// another domain, or none.
	Domain string `json:"domain"`
	// Engines The engines the worker offers this knowledge base, and the jobs it
	// does with each: its own choice, on its own providers' keys. It claims each
	// engine's jobs there for it, so a job no engine here is used for is not
	// claimed at this knowledge base.
	Engines []WorkerEngineConfig `json:"engines"`
	// GatewayUrl The URL the worker reaches the knowledge base's gateway at: its
	// route to the bus and to a resource's bytes, and the only address of the
	// knowledge base it holds.
	GatewayUrl string `json:"gatewayUrl"`
	// Identity Where the worker signs in for this knowledge base, and as which
	// client.
	Identity WorkerKnowledgeBaseConfigIdentity `json:"identity"`
}

// MarshalJSON writes v, each list its schema requires that Go holds as nil
// written as the empty list.
func (v WorkerKnowledgeBaseConfig) MarshalJSON() ([]byte, error) {
	type written WorkerKnowledgeBaseConfig
	v.Engines = listOf(v.Engines)
	return json.Marshal(written(v))
}

// WorkerKnowledgeBaseConfigIdentity Where the worker signs in for this
// knowledge base, and as which client.
type WorkerKnowledgeBaseConfigIdentity struct {
	// ClientId The client the issuer holds the public half of the worker's key
	// on: the worker's account at this knowledge base. It is also what the
	// worker says it is called there (`principal:profile`).
	ClientId string `json:"clientId"`
	// Issuer The issuer URL, exactly as tokens carry it in `iss`.
	Issuer string `json:"issuer"`
}

// WorkerKnowledgeBaseHealth One knowledge base the worker serves, as its
// health says it. `did` and `engines` are there while it is `working`, and
// only then.
type WorkerKnowledgeBaseHealth struct {
	// Did The agent's DID at this knowledge base, as its gateway named it.
	Did *string `json:"did,omitempty"`
	// Domain The entry's `domain`.
	Domain string `json:"domain"`
	// Engines One entry for each of the entry's engines, in its order.
	Engines *[]WorkerEngineHealth `json:"engines,omitempty"`
	// State `starting`: signing in, opening its stream, confirming it, or
	// waiting to start again. `working`: confirmed, its engines claiming.
	// `refused`: refused, until the service is started again.
	State WorkerKnowledgeBaseHealthState `json:"state"`
}

// WorkerKnowledgeBaseHealthState `starting`: signing in, opening its stream,
// confirming it, or waiting to start again. `working`: confirmed, its engines
// claiming. `refused`: refused, until the service is started again.
type WorkerKnowledgeBaseHealthState string

// The values of WorkerKnowledgeBaseHealthState.
const (
	WorkerKnowledgeBaseHealthStateStarting WorkerKnowledgeBaseHealthState = "starting"
	WorkerKnowledgeBaseHealthStateWorking  WorkerKnowledgeBaseHealthState = "working"
	WorkerKnowledgeBaseHealthStateRefused  WorkerKnowledgeBaseHealthState = "refused"
)

// Valid is whether e is one of WorkerKnowledgeBaseHealthState's values.
func (e WorkerKnowledgeBaseHealthState) Valid() bool {
	switch e {
	case WorkerKnowledgeBaseHealthStateStarting, WorkerKnowledgeBaseHealthStateWorking, WorkerKnowledgeBaseHealthStateRefused:
		return true
	}
	return false
}

// YieldCloneCreateCommand Bus command to create a cloned resource from a
// clone token. Bytes are stored by the upload path BEFORE this command is
// emitted, because bytes travel over HTTP and never over the bus — the
// command carries the storage coordinates, never content.
type YieldCloneCreateCommand struct {
	// UserId Authenticated user's DID, injected by the /bus/emit gateway.
	// Clients do not set this.
	UserId          *UserId       `json:"_userId,omitempty"`
	ArchiveOriginal *bool         `json:"archiveOriginal,omitempty"`
	ByteSize        int           `json:"byteSize"`
	ContentChecksum string        `json:"contentChecksum"`
	Format          ContentFormat `json:"format"`
	Name            string        `json:"name"`
	// StorageUri Where the caller already wrote the clone's bytes — an
	// instruction, not a copy of the stored fact (that lives on the primary
	// Representation). Bytes are stored through the byte door BEFORE this
	// command is sent, so this names an existing file. Working-tree URI, only
	// file:// is supported.
	StorageUri string `json:"storageUri"`
	Token      string `json:"token"`
}

// YieldCloneCreated Success response after creating a cloned resource.
type YieldCloneCreated struct {
	Response YieldedResource `json:"response"`
}

// YieldClonePersistCommand Command: stow an already-uploaded clone's bytes
// and append `yield:cloned`. The INNER half of the clone flow.
// `yield:clone-create` reaches the CloneTokenManager, which alone can
// validate the token and read the source's entity types; it then emits this
// so the Stower — the only appendEvent caller — writes the domain event.
// Distinct from `yield:create` because a clone is a distinct operation, not a
// creation with an extra field. It REQUIRES a parent, and that requirement is
// what a separate command expresses: an optional `parentResourceId` on the
// create command could not say that a clone without a parent is not a clone.
// `ResourceClonedPayload` requires it for the same reason. Generated
// resources are NOT clones: they carry provenance in `generatedFrom` and stay
// on `yield:create`.
type YieldClonePersistCommand struct {
	// UserId Injected by the gateway from the authenticated principal; never
	// supplied by a wire caller.
	UserId          *UserId `json:"_userId,omitempty"`
	ByteSize        int     `json:"byteSize"`
	ContentChecksum string  `json:"contentChecksum"`
	// EntityTypes Inherited from the source resource by the CloneTokenManager,
	// which is the only party that knows the token is valid.
	EntityTypes *[]string     `json:"entityTypes,omitempty"`
	Format      ContentFormat `json:"format"`
	Language    *string       `json:"language,omitempty"`
	Name        string        `json:"name"`
	// ParentResourceId The resource this one is cloned FROM. Required: it is
	// what makes this a clone rather than a creation.
	ParentResourceId ResourceId `json:"parentResourceId"`
	// StorageUri The caller's instruction for WHERE the bytes are — the uploader
	// wrote them before emitting this. The stored location lives on the clone's
	// primary Representation, the one home of a storage URI.
	StorageUri string `json:"storageUri"`
}

// YieldClonePersistOk Success reply after cloning a resource, matched to the
// originating command by correlationId.
type YieldClonePersistOk struct {
	// Response The clone's identity — a new resource, distinct from its parent.
	Response YieldedResource `json:"response"`
}

// YieldCloneResourceRequest Bus command to request cloning a resource using a
// clone token.
type YieldCloneResourceRequest struct {
	Token string `json:"token"`
}

// YieldCloneTokenRequest Bus command to request a clone token for a resource.
type YieldCloneTokenRequest struct {
	ResourceId ResourceId `json:"resourceId"`
}

// YieldCreateCommand Bus command to create a yielded resource in the
// knowledge base.
type YieldCreateCommand struct {
	// Roles The emitter's capabilities (the token's `roles`), injected by the
	// /bus/emit gateway. Clients do not set this. An emitter carrying the worker
	// role must cite the job this resource fulfils in `jobId`; the Stower
	// refuses the create otherwise.
	Roles *[]string `json:"_roles,omitempty"`
	// UserId Authenticated user's DID, injected by the /bus/emit gateway.
	// Clients do not set this.
	UserId           *UserId                          `json:"_userId,omitempty"`
	ByteSize         int                              `json:"byteSize"`
	ContentChecksum  string                           `json:"contentChecksum"`
	EntityTypes      *[]string                        `json:"entityTypes,omitempty"`
	Format           ContentFormat                    `json:"format"`
	GeneratedFrom    *YieldCreateCommandGeneratedFrom `json:"generatedFrom,omitempty"`
	GenerationPrompt *string                          `json:"generationPrompt,omitempty"`
	// Generator The Software peer that produced the content, when software did.
	// Its identity must be the emitter's own — the knowledge base refuses a
	// generator naming anyone else, and supplies it from the verified emitter
	// when omitted. `creator` and `wasAttributedTo` are never sent; the
	// knowledge base derives them from the emitter and the cited job.
	Generator *OneOrMoreAgents `json:"generator,omitempty"`
	IsDraft   *bool            `json:"isDraft,omitempty"`
	// JobId The job this resource fulfils. Required when the emitter carries the
	// worker role; absent for self-initiated work (a person, or an agent acting
	// on its own). The knowledge base derives who requested this resource from
	// the cited job's own events — the emitter never says who the work was for.
	JobId    *JobId  `json:"jobId,omitempty"`
	Language *string `json:"language,omitempty"`
	Name     string  `json:"name"`
	// StorageUri The caller's instruction for WHERE the bytes are — not a copy
	// of the stored fact. The stored location lives on the resource's primary
	// Representation (`Representation.storageUri`), which is its single home;
	// this field is the message that puts it there. Working-tree URI, only
	// file:// is supported (e.g. file://docs/overview.md).
	StorageUri string `json:"storageUri"`
}

type YieldCreateCommandGeneratedFrom struct {
	AnnotationId *AnnotationId `json:"annotationId,omitempty"`
	ResourceId   *ResourceId   `json:"resourceId,omitempty"`
}

// YieldCreateOk Success reply after creating a yielded resource, matched to
// the originating command by correlationId.
type YieldCreateOk struct {
	// Response The created resource's identity.
	Response YieldedResource `json:"response"`
}

// YieldJobCompleteCommand A `yield` job's worker says the job is complete,
// with what a `yield` job reports.
type YieldJobCompleteCommand struct {
	// UserId Authenticated user's DID, injected by the /bus/emit gateway.
	// Clients do not set this.
	UserId *UserId `json:"_userId,omitempty"`
	// AnnotationId The annotation the job's context was focused on, when it was
	// focused on one. Lets a client route the completion to that annotation.
	AnnotationId *AnnotationId `json:"annotationId,omitempty"`
	// Attempt Which attempt produced this event, 1-based (a first run is 1).
	// ALWAYS present: the queue re-runs a failed job silently, so an operator
	// reading progress or a terminal record has no other way to tell a re-run
	// from a first run — and provider spend, already counted in
	// xynolog_inference_tokens_total, cannot be attributed to a repeated
	// document without it. Stated rather than inferred from absence, because
	// 'attempt 1' is a fact the emitter always knows.
	Attempt    *int                           `json:"attempt,omitempty"`
	Durability *DurabilityEvidence            `json:"durability,omitempty"`
	JobId      JobId                          `json:"jobId"`
	JobType    YieldJobCompleteCommandJobType `json:"jobType"`
	ResourceId ResourceId                     `json:"resourceId"`
	Result     *YieldJobResult                `json:"result,omitempty"`
}

func (YieldJobCompleteCommand) memberOfJobCompleteCommand() {}
func (YieldJobCompleteCommand) told() (string, string)      { return "jobType", "yield" }

type YieldJobCompleteCommandJobType string

// The values of YieldJobCompleteCommandJobType.
const (
	YieldJobCompleteCommandJobTypeYield YieldJobCompleteCommandJobType = "yield"
)

// Valid is whether e is one of YieldJobCompleteCommandJobType's values.
func (e YieldJobCompleteCommandJobType) Valid() bool {
	switch e {
	case YieldJobCompleteCommandJobTypeYield:
		return true
	}
	return false
}

// YieldJobCreateCommand Create a `yield` job: make a resource from a gathered
// context. It names no resource of its own: the job is about the resource its
// context focuses on, which the Dispatcher reads from `params.context.focus`.
type YieldJobCreateCommand struct {
	// Roles The emitter's roles, injected by the gateway when it has any.
	// Clients do not set this.
	Roles *[]string `json:"_roles,omitempty"`
	// UserId The emitter's verified DID, injected by the gateway. Clients do not
	// set this.
	UserId  *UserId                      `json:"_userId,omitempty"`
	JobType YieldJobCreateCommandJobType `json:"jobType"`
	Params  GenerationJobParams          `json:"params"`
}

func (YieldJobCreateCommand) memberOfJobCreateCommand() {}
func (YieldJobCreateCommand) told() (string, string)    { return "jobType", "yield" }

type YieldJobCreateCommandJobType string

// The values of YieldJobCreateCommandJobType.
const (
	YieldJobCreateCommandJobTypeYield YieldJobCreateCommandJobType = "yield"
)

// Valid is whether e is one of YieldJobCreateCommandJobType's values.
func (e YieldJobCreateCommandJobType) Valid() bool {
	switch e {
	case YieldJobCreateCommandJobTypeYield:
		return true
	}
	return false
}

// YieldJobDone What a `yield` job reports when it has made its resource. The
// worker creates the resource first (the create round trip returns its id),
// then emits job:complete carrying it, so resourceId is always present on the
// wire.
type YieldJobDone struct {
	// ResourceId ID of the generated resource, obtained by the worker from the
	// create round-trip before job:complete is emitted
	ResourceId ResourceId `json:"resourceId"`
	// ResourceName Name of the generated resource
	ResourceName string `json:"resourceName"`
	// Truncated True when the model stopped at the maxTokens ceiling — the
	// artifact is cut off, not complete. Derived at the producer from the
	// provider's stopReason ('max_tokens' → true); required because the worker
	// always knows.
	Truncated bool `json:"truncated"`
}

func (YieldJobDone) memberOfJobResult()      {}
func (YieldJobDone) memberOfYieldJobResult() {}

// YieldJobFilter `yield` jobs.
type YieldJobFilter struct {
	JobType YieldJobFilterJobType `json:"jobType"`
}

func (YieldJobFilter) memberOfJobFilter()     {}
func (YieldJobFilter) told() (string, string) { return "jobType", "yield" }

type YieldJobFilterJobType string

// The values of YieldJobFilterJobType.
const (
	YieldJobFilterJobTypeYield YieldJobFilterJobType = "yield"
)

// Valid is whether e is one of YieldJobFilterJobType's values.
func (e YieldJobFilterJobType) Valid() bool {
	switch e {
	case YieldJobFilterJobTypeYield:
		return true
	}
	return false
}

// YieldJobQueuedEvent A pending `yield` job, announced with what it is asked
// to make and without its `context`.
type YieldJobQueuedEvent struct {
	JobId   JobId                      `json:"jobId"`
	JobType YieldJobQueuedEventJobType `json:"jobType"`
	Params  GenerationJobRequest       `json:"params"`
	// ResourceId The resource the job is about.
	ResourceId ResourceId `json:"resourceId"`
	// UserId The DID of the principal whose `job:create` created the job.
	UserId UserId `json:"userId"`
}

func (YieldJobQueuedEvent) memberOfJobQueuedEvent() {}
func (YieldJobQueuedEvent) told() (string, string)  { return "jobType", "yield" }

type YieldJobQueuedEventJobType string

// The values of YieldJobQueuedEventJobType.
const (
	YieldJobQueuedEventJobTypeYield YieldJobQueuedEventJobType = "yield"
)

// Valid is whether e is one of YieldJobQueuedEventJobType's values.
func (e YieldJobQueuedEventJobType) Valid() bool {
	switch e {
	case YieldJobQueuedEventJobTypeYield:
		return true
	}
	return false
}

// YieldJobResult What a `yield` job reports when it concludes without
// failing: the resource it made, or a decline. Neither names its kind: a
// decline is the one with `declined`.
type YieldJobResult struct {
	union[yieldJobResultMember]
}

// yieldJobResultMember is a member of YieldJobResult: YieldJobDone,
// JobDeclined.
type yieldJobResultMember interface {
	memberOfYieldJobResult()
}

// YieldUpdateCommand Bus command to update a yielded resource's storage
// content.
type YieldUpdateCommand struct {
	// UserId Authenticated user's DID, injected by the /bus/emit gateway.
	// Clients do not set this.
	UserId          *UserId    `json:"_userId,omitempty"`
	ByteSize        int        `json:"byteSize"`
	ContentChecksum string     `json:"contentChecksum"`
	ResourceId      ResourceId `json:"resourceId"`
	// StorageUri The caller's instruction for WHERE the bytes are — not a copy
	// of the stored fact. The stored location lives on the resource's primary
	// Representation (`Representation.storageUri`), which is its single home;
	// this field is the message that puts it there. Working-tree URI, only
	// file:// is supported (e.g. file://docs/overview.md).
	StorageUri string `json:"storageUri"`
}

// YieldUpdateOk Success reply after updating a yielded resource, matched to
// the originating command by correlationId.
type YieldUpdateOk struct {
	// Response The updated resource's identity.
	Response YieldedResource `json:"response"`
}

// YieldedResource The resource a yield command wrote, by its id.
type YieldedResource struct {
	ResourceId ResourceId `json:"resourceId"`
}
