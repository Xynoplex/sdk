// Code generated from protocol/specs/src/client/testing.json; DO NOT EDIT.
//
// Regenerate: make generate (codegen/lib/testing/go.ml)

package xynologtest

import (
	"encoding/json"
	"testing"
	"time"

	"github.com/xynolog/sdk/go/api"
	"github.com/xynolog/sdk/go/bus"
)

// FaultAction is what the wire does to one request: Deliver, DropReply,
// Delay, DuplicateReply or RejectEmit. Read it with a type switch; Kind is
// the word a request log names it by.
type FaultAction interface {
	Kind() string
	faultAction()
}

// Deliver is a fault. The request's reply is delivered.
type Deliver struct{}

func (Deliver) Kind() string { return "deliver" }
func (Deliver) faultAction() {}

// DropReply is a fault. The request's reply is lost.
type DropReply struct{}

func (DropReply) Kind() string { return "drop-reply" }
func (DropReply) faultAction() {}

// Delay is a fault. The request's reply is delivered after `ms` milliseconds.
type Delay struct {
	// For is how long after the request its reply comes: ms milliseconds.
	For time.Duration
}

func (Delay) Kind() string { return "delay" }
func (Delay) faultAction() {}

// DuplicateReply is a fault. The request's reply is delivered twice.
type DuplicateReply struct{}

func (DuplicateReply) Kind() string { return "duplicate-reply" }
func (DuplicateReply) faultAction() {}

// RejectEmit is a fault. The emit itself is refused: the request never
// reaches the gateway.
type RejectEmit struct{}

func (RejectEmit) Kind() string { return "reject-emit" }
func (RejectEmit) faultAction() {}

// faults is every fault, each holding nothing yet: what a schedule is drawn
// from.
var faults = []FaultAction{Deliver{}, DropReply{}, Delay{}, DuplicateReply{}, RejectEmit{}}

// The delays a drawn fault is of, in milliseconds.
const (
	delayMsMinimum = 0
	delayMsMaximum = 5
)

// How many faults a drawn schedule is of.
const (
	scheduleLengthMinimum = 1
	scheduleLengthMaximum = 8
)

// slack is how many times its reckoned bound a case is given: the room a
// scheduler's jitter takes.
const slack = 4

// DeliveryOp is one step of an interleaving: a write, or a client-initiated
// transition.
type DeliveryOp string

const (
	// DeliveryOpWrite is the step "write".
	DeliveryOpWrite DeliveryOp = "write"
	// DeliveryOpTransition is the step "transition".
	DeliveryOpTransition DeliveryOp = "transition"
)

// deliveryOps is every delivery step.
var deliveryOps = []DeliveryOp{DeliveryOpWrite, DeliveryOpTransition}

// RequestLogEntry is one request the transport was sent.
type RequestLogEntry struct {
	// Channel is the channel it was sent on.
	Channel bus.Channel
	// Action is what the schedule did to it.
	Action FaultAction
	// CorrelationID is what pairs it with its reply; empty for a request that
	// awaits none.
	CorrelationID string
	// RetryKey is its identity across retries: two entries with the same key are
	// one logical request, sent again (RetryKeyOf).
	RetryKey string
	// Payload is its payload, as it was sent.
	Payload json.RawMessage
	// Scope is the resource whose scope it was sent on; the zero ResourceId for
	// a request on no scope.
	Scope api.ResourceId
}

// LivenessScenario is what one fresh run of a composition exposes to the
// axioms.
type LivenessScenario struct {
	// Outputs is one channel per output, closed when the output has said
	// something, a value or a failure (L1).
	Outputs []<-chan struct{}
	// Settlements is one channel per awaited path, closed when it has settled,
	// either way (L2).
	Settlements []<-chan struct{}
}

// LivenessSpec is a composition, and the schedules it is run under.
type LivenessSpec struct {
	// Setup is what builds a fresh composition over the transport it is given,
	// whose stream names what a client's does (bus.BridgedChannels). It is
	// called once per schedule, inside the case's bubble; what it opens it
	// closes by t.Cleanup, which runs before the transport is closed. What it
	// starts must end once the transport has closed: a goroutine still blocked
	// then fails the test as the bubble's deadlock.
	Setup func(*testing.T, *FaultyTransport) LivenessScenario
	// Timeout is the time the composition gives a bus request. The bound is
	// derived from it: (Timeout × (1 + RetryBudget) + the schedule's delays) ×
	// the slack.
	Timeout time.Duration
	// RetryBudget is how often the composition may send a logical request again.
	RetryBudget int
	// Cases is how many schedules are drawn (FaultSchedules) when Schedules
	// states none.
	Cases int
	// Schedules is the fault schedules to run, one case each, in place of drawn
	// ones.
	Schedules [][]FaultAction
	// MakeResponse is what the gateway answers a request no queued response
	// answers, as FaultyConfig.MakeResponse is.
	MakeResponse MakeResponse
}
