package state

// Gathering, as state: the context around an annotation of one resource, and
// the context around a whole resource.
//
// Each is held with whether it is being gathered and the failure it met. The
// two are held apart because both can be in flight at once. Each is asked of
// the unit itself (GatherAnnotation, GatherResource), so a gather asked of
// one resource's unit reaches no other.
//
// A new request clears what the last one left. Requests are not cancelled by
// the next: each lands when it is answered.

import (
	"context"

	xynolog "github.com/xynolog/sdk/go"
	"github.com/xynolog/sdk/go/api"
)

// gathering is one gather's state.
type gathering struct {
	context *xynolog.Variable[*api.GatheredContext]
	loading *xynolog.Variable[bool]
	err     *xynolog.Variable[error]
}

func newGathering() gathering {
	return gathering{
		context: xynolog.NewVariable[*api.GatheredContext](nil),
		loading: xynolog.NewVariable(false),
		err:     xynolog.NewVariable[error](nil),
	}
}

// begin clears what the last gather left. Called with the unit's mu held.
func (g gathering) begin() {
	g.loading.Set(true)
	g.err.Set(nil)
	g.context.Set(nil)
}

// end ends each of its states.
func (g gathering) end() {
	g.context.End()
	g.loading.End()
	g.err.End()
}

// GatherStateUnit gathers the annotations of one resource, and any resource:
// see the file's documentation. A state holding none is nil, or the zero
// AnnotationId.
type GatherStateUnit struct {
	client     *xynolog.Client
	resourceID api.ResourceId
	life

	annotation   gathering
	annotationID *xynolog.Variable[api.AnnotationId]
	resource     gathering
}

var _ xynolog.StateUnit = (*GatherStateUnit)(nil)

// NewGatherStateUnit is a unit gathering the annotations of resourceID over
// client.
func NewGatherStateUnit(client *xynolog.Client, resourceID api.ResourceId) *GatherStateUnit {
	return &GatherStateUnit{
		client:       client,
		resourceID:   resourceID,
		life:         newLife(),
		annotation:   newGathering(),
		annotationID: xynolog.NewVariable(api.AnnotationId{}),
		resource:     newGathering(),
	}
}

// Context is the context around the annotation last asked about.
func (u *GatherStateUnit) Context() xynolog.Watched[*api.GatheredContext] {
	return u.annotation.context.Reading()
}

// Loading is whether the annotation's gather is under way.
func (u *GatherStateUnit) Loading() xynolog.Watched[bool] { return u.annotation.loading.Reading() }

// Error is the failure the annotation's gather met.
func (u *GatherStateUnit) Error() xynolog.Watched[error] { return u.annotation.err.Reading() }

// AnnotationId is the annotation last asked about.
func (u *GatherStateUnit) AnnotationId() xynolog.Watched[api.AnnotationId] {
	return u.annotationID.Reading()
}

// ResourceContext is the context around the resource last asked about.
func (u *GatherStateUnit) ResourceContext() xynolog.Watched[*api.GatheredContext] {
	return u.resource.context.Reading()
}

// ResourceLoading is whether the resource's gather is under way.
func (u *GatherStateUnit) ResourceLoading() xynolog.Watched[bool] {
	return u.resource.loading.Reading()
}

// ResourceError is the failure the resource's gather met.
func (u *GatherStateUnit) ResourceError() xynolog.Watched[error] { return u.resource.err.Reading() }

// GatherAnnotation gathers the context around an annotation of this unit's
// resource, taking what Gather.Annotation takes.
func (u *GatherStateUnit) GatherAnnotation(annotationID api.AnnotationId, options api.GatherAnnotationOptions) {
	u.mu.Lock()
	defer u.mu.Unlock()
	if u.closed {
		return
	}
	u.annotation.begin()
	u.annotationID.Set(annotationID)
	go u.land(u.annotation, func(ctx context.Context) (api.GatheredContext, error) {
		complete, err := u.client.Gather.Annotation(u.resourceID, annotationID, options).Wait(ctx)
		return complete.Response, err
	})
}

// GatherResource gathers the context around a whole resource, as
// Gather.Resource does given options (xynolog.GatherResourceDefaults, when
// nothing else is to be stated).
func (u *GatherStateUnit) GatherResource(resourceID api.ResourceId, options api.GatherResourceRequestOptions) {
	u.mu.Lock()
	defer u.mu.Unlock()
	if u.closed {
		return
	}
	u.resource.begin()
	go u.land(u.resource, func(ctx context.Context) (api.GatheredContext, error) {
		return u.client.Gather.Resource(ctx, resourceID, options)
	})
}

// land holds what the gather gather does comes to: the context is there
// before the gather is said to be over, for a reader told so. One answered
// after the unit closed lands nowhere.
func (u *GatherStateUnit) land(into gathering, gather func(ctx context.Context) (api.GatheredContext, error)) {
	gathered, err := gather(u.alive)
	u.mu.Lock()
	defer u.mu.Unlock()
	if u.closed {
		return
	}
	if err != nil {
		into.err.Set(err)
	} else {
		into.context.Set(&gathered)
	}
	into.loading.Set(false)
}

// Close ends the unit: the gathers under way are abandoned, and every state
// ends. Closing twice is closing once.
func (u *GatherStateUnit) Close() {
	u.mu.Lock()
	defer u.mu.Unlock()
	if !u.close() {
		return
	}
	u.annotation.end()
	u.annotationID.End()
	u.resource.end()
}
