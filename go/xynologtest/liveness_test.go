package xynologtest_test

// The liveness harness against compositions that keep its axioms and ones
// built to break each: an axiom nothing can fail holds nothing.

import (
	"context"
	"encoding/json"
	"slices"
	"strings"
	"testing"
	"time"

	xynolog "github.com/xynolog/sdk/go"
	"github.com/xynolog/sdk/go/bus"
	"github.com/xynolog/sdk/go/xynologtest"
)

const timeout = 200 * time.Millisecond

var read = bus.BrowseResourceRequested

func asking() map[string]any { return map[string]any{"resourceId": "r1"} }

// answering answers every request with a reply that carries no response.
func answering(bus.Channel, json.RawMessage) (json.RawMessage, error) { return nil, nil }

func spec(setup func(*testing.T, *xynologtest.FaultyTransport) xynologtest.LivenessScenario, schedules [][]xynologtest.FaultAction) xynologtest.LivenessSpec {
	return xynologtest.LivenessSpec{
		Setup:        setup,
		Timeout:      timeout,
		RetryBudget:  1,
		Schedules:    schedules,
		MakeResponse: answering,
	}
}

// wantViolation fails t unless err is a violation that says said.
func wantViolation(t *testing.T, err error, said string) {
	t.Helper()
	if err == nil {
		t.Fatalf("no violation was given, where one that says %q was due", said)
	}
	if !strings.Contains(err.Error(), said) {
		t.Fatal(err)
	}
}

func TestARequestSettlesUnderEverySchedule(t *testing.T) {
	drawn := spec(
		func(_ *testing.T, transport *xynologtest.FaultyTransport) xynologtest.LivenessScenario {
			wire := xynolog.NewWire(transport)
			settled := make(chan struct{})
			go func() {
				defer close(settled)
				_, _ = wire.RequestOf(context.Background(), read.Request().Channel(), asking(), timeout)
			}()
			return xynologtest.LivenessScenario{Settlements: []<-chan struct{}{settled}}
		},
		nil,
	)
	drawn.Cases = 25
	if err := xynologtest.AssertLivenessAxioms(t, drawn); err != nil {
		t.Fatal(err)
	}
}

func TestAWaitWithNoDeadlineBreaksL2(t *testing.T) {
	err := xynologtest.AssertLivenessAxioms(t, spec(
		func(_ *testing.T, transport *xynologtest.FaultyTransport) xynologtest.LivenessScenario {
			settled := make(chan struct{})
			go func() {
				defer close(settled)
				pending := transport.TrackReply("cid", read.Result().Channel(), read.Failure().Channel())
				_, _, _ = transport.Emit(context.Background(), read.Request().Channel(), asking(), xynolog.Envelope{CorrelationID: "cid"})
				<-pending.Reply()
			}()
			return xynologtest.LivenessScenario{Settlements: []<-chan struct{}{settled}}
		},
		[][]xynologtest.FaultAction{{xynologtest.DropReply{}}},
	))
	wantViolation(t, err, "L2: settlement #0 did not settle")
}

func TestARequestSentAgainPastItsBudgetBreaksL2(t *testing.T) {
	err := xynologtest.AssertLivenessAxioms(t, spec(
		func(_ *testing.T, transport *xynologtest.FaultyTransport) xynologtest.LivenessScenario {
			wire := xynolog.NewWire(transport)
			settled := make(chan struct{})
			go func() {
				defer close(settled)
				for range 3 {
					if _, err := wire.RequestOf(context.Background(), read.Request().Channel(), asking(), timeout); err == nil {
						return
					}
				}
			}()
			return xynologtest.LivenessScenario{Settlements: []<-chan struct{}{settled}}
		},
		[][]xynologtest.FaultAction{{xynologtest.RejectEmit{}}},
	))
	wantViolation(t, err, "past the retry budget")
}

func TestASwallowedFailureBreaksL2(t *testing.T) {
	err := xynologtest.AssertLivenessAxioms(t, spec(
		func(_ *testing.T, transport *xynologtest.FaultyTransport) xynologtest.LivenessScenario {
			wire := xynolog.NewWire(transport)
			said := make(chan struct{})
			go func() {
				// The failure goes nowhere: the output is told only of success.
				if _, err := wire.RequestOf(context.Background(), read.Request().Channel(), asking(), timeout); err == nil {
					close(said)
				}
			}()
			return xynologtest.LivenessScenario{Outputs: []<-chan struct{}{said}}
		},
		[][]xynologtest.FaultAction{{xynologtest.RejectEmit{}}},
	))
	wantViolation(t, err, "its failure was swallowed")
}

func TestAnOutputThatSaysNothingBreaksL1(t *testing.T) {
	err := xynologtest.AssertLivenessAxioms(t, spec(
		func(*testing.T, *xynologtest.FaultyTransport) xynologtest.LivenessScenario {
			return xynologtest.LivenessScenario{Outputs: []<-chan struct{}{make(chan struct{})}}
		},
		[][]xynologtest.FaultAction{{xynologtest.Deliver{}}},
	))
	wantViolation(t, err, "L1: output #0 said nothing")
}

// retire is how a connection is retired when the client moves to another.
type retire int

const (
	// drain delivers what it had received and not delivered first.
	drain retire = iota
	// abort drops it with whatever it had received.
	abort
	// drainAndReplay drains it, and the next connection replays the same
	// events.
	drainAndReplay
)

// connections is a client's connections, each retired as retire says.
type connections struct {
	retire    retire
	received  []string
	delivered []string
}

func (c *connections) Write(eventID string) { c.received = append(c.received, eventID) }

func (c *connections) Transition() {
	switch c.retire {
	case drain:
		c.delivered = append(c.delivered, c.received...)
		c.received = nil
	case abort:
		c.received = nil
	case drainAndReplay:
		c.delivered = append(c.delivered, c.received...)
	}
}

func (c *connections) Delivered() []string {
	c.delivered = append(c.delivered, c.received...)
	c.received = nil
	return slices.Clone(c.delivered)
}

func delivery(t *testing.T, retire retire) error {
	return xynologtest.AssertExactlyOnceDelivery(t,
		func(*testing.T) xynologtest.DeliverySubject { return &connections{retire: retire} },
		[][]xynologtest.DeliveryOp{{xynologtest.DeliveryOpWrite, xynologtest.DeliveryOpTransition, xynologtest.DeliveryOpWrite}},
	)
}

func TestAConnectionRetiredByDrainDeliversOnce(t *testing.T) {
	if err := delivery(t, drain); err != nil {
		t.Fatal(err)
	}
}

func TestAConnectionRetiredByAbortBreaksL3(t *testing.T) {
	wantViolation(t, delivery(t, abort), "delivered 0 times")
}

func TestAnEventDeliveredByBothConnectionsBreaksL3(t *testing.T) {
	wantViolation(t, delivery(t, drainAndReplay), "delivered 2 times")
}
