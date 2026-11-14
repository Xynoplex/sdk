package state

// Attention, as the state of a viewer of one resource: which annotation is
// hovered.
//
// It hears the viewer's hover (Beckon.Hover) and holds it, and sparkles an
// annotation the moment it is hovered. It hears an annotation opened, by this
// viewer or by another participant driving it, and turns the viewer's focus
// to it. Every focus it says names its resource.

import (
	xynoplex "github.com/Xynoplex/sdk/go"
	"github.com/Xynoplex/sdk/go/api"
	"github.com/Xynoplex/sdk/go/bus"
)

// BeckonStateUnit is attention, as this viewer's state: see the file's
// documentation.
type BeckonStateUnit struct {
	client     *xynoplex.Client
	resourceID api.ResourceId
	life

	hovered *xynoplex.Variable[api.AnnotationId]
}

var _ xynoplex.StateUnit = (*BeckonStateUnit)(nil)

// NewBeckonStateUnit is a unit of attention on resourceID over client. It
// hears the client's own bus from now on.
func NewBeckonStateUnit(client *xynoplex.Client, resourceID api.ResourceId) *BeckonStateUnit {
	u := &BeckonStateUnit{client: client, resourceID: resourceID, life: newLife(), hovered: xynoplex.NewVariable(api.AnnotationId{})}
	// One reader of both, taken now, so what is said from here on is heard in the order it was said.
	u.listen(client.Bus.FramesAmong(u.alive, bus.BeckonHover.Channel(), bus.BrowseClick.Channel()), u.heard)
	return u
}

// HoveredAnnotationId is the annotation this viewer hovers, or the zero
// AnnotationId when it hovers none.
func (u *BeckonStateUnit) HoveredAnnotationId() xynoplex.Watched[api.AnnotationId] {
	return u.hovered.Reading()
}

// Focus signals: turn this viewer's focus to an annotation of its resource.
func (u *BeckonStateUnit) Focus(annotationID api.AnnotationId) {
	u.mu.Lock()
	defer u.mu.Unlock()
	if u.closed {
		return
	}
	u.focus(annotationID)
}

// focus says the focus. Called with mu held.
func (u *BeckonStateUnit) focus(annotationID api.AnnotationId) {
	_ = xynoplex.Publish(u.client.Bus, bus.BeckonFocus, api.BeckonFocusEvent{ResourceId: u.resourceID, AnnotationId: &annotationID}, xynoplex.Envelope{})
}

// heard acts on a hover or a click. A frame that is not its channel's, or
// was refused, is nobody's to act on.
func (u *BeckonStateUnit) heard(frame xynoplex.Frame, refused error) {
	switch frame.Channel {
	case bus.BeckonHover.Channel():
		hover, err := xynoplex.Decoded(bus.BeckonHover, frame, refused)
		if err != nil {
			return
		}
		if hover.Payload.AnnotationId == nil {
			u.hovered.Set(api.AnnotationId{})
			return
		}
		hovered := *hover.Payload.AnnotationId
		u.hovered.Set(hovered)
		_ = xynoplex.Publish(u.client.Bus, bus.BeckonSparkle, api.BeckonSparkleEvent{AnnotationId: hovered}, xynoplex.Envelope{})
	case bus.BrowseClick.Channel():
		click, err := xynoplex.Decoded(bus.BrowseClick, frame, refused)
		if err == nil {
			u.focus(click.Payload.AnnotationId)
		}
	}
}

// Close ends the unit: it hears nothing more and says nothing more, and what
// is hovered ends. Closing twice is closing once.
func (u *BeckonStateUnit) Close() {
	u.mu.Lock()
	defer u.mu.Unlock()
	if !u.close() {
		return
	}
	u.hovered.End()
}
