package xynolog

// CacheQuery is a live query a client's cache answers.
type CacheQuery string

// CacheRefreshTrigger is what refreshes a client's cache: a channel of the
// bus, the stream open again after a drop, or an event on one of the table's
// channels that cannot be read.
type CacheRefreshTrigger string

// CacheRefreshReach is which keys a row acts on: those the event names
// (subject), or every key the client holds (held).
type CacheRefreshReach string

// The reaches of a row.
const (
	CacheRefreshReachSubject CacheRefreshReach = "subject"
	CacheRefreshReachHeld    CacheRefreshReach = "held"
)

// CacheRefreshWhen splits a channel whose events come two ways: enriched
// with the annotation's new value, or unenriched without. A row of a channel
// whose events come one way states none ("").
type CacheRefreshWhen string

// The two ways a split channel's events come.
const (
	CacheRefreshWhenEnriched   CacheRefreshWhen = "enriched"
	CacheRefreshWhenUnenriched CacheRefreshWhen = "unenriched"
)

// CacheRefreshWay is a way to a member of an event: the names of the members
// it is within, and its own. Nil where a row states none.
type CacheRefreshWay []string

// CacheRefreshNames is where in its event a row that reaches its subject
// finds it: the way to the resource it names (a ResourceId), and to the
// annotation (an AnnotationId).
type CacheRefreshNames struct {
	Resource   CacheRefreshWay
	Annotation CacheRefreshWay
}

// CacheRefresh is one row of the table: where its event names what it
// reaches; the way to the value it writes (an Annotation); the queries a
// trigger asks again for, keeping the value shown meanwhile; those whose new
// value its event carries; and those whose entity its event says is gone.
type CacheRefresh struct {
	When      CacheRefreshWhen
	Reach     CacheRefreshReach
	Names     CacheRefreshNames
	Carries   CacheRefreshWay
	Refetches []CacheQuery
	Writes    []CacheQuery
	Removes   []CacheQuery
}
