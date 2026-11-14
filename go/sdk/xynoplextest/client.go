package xynoplextest

// A real client for tests. Every namespace, cache and deadline is the
// client's own; only what it speaks through is a double.

import (
	xynoplex "github.com/Xynoplex/sdk/go"
	"github.com/Xynoplex/sdk/go/bus"
)

// TestClient is a client, and the doubles it speaks through.
type TestClient struct {
	Client    *xynoplex.Client
	Transport *FaultyTransport
	Content   *InMemoryContent
	Gateway   *StubGateway
}

// TestClientConfig is what a test client is made of. Each double is the one
// given, as the test scripted it; absent, one that nothing is scripted to
// answer and that holds nothing. The transport made for a client that is
// given none names what a client's stream names, bus.BridgedChannels.
type TestClientConfig struct {
	Transport *FaultyTransport
	Content   *InMemoryContent
	Gateway   *StubGateway
	// Timing is the client's waits: xynoplex.DefaultTiming() for the ones a
	// client keeps unless told otherwise.
	Timing xynoplex.Timing
	// Persistence is where the client keeps its queries; nil for a client
	// that keeps nothing.
	Persistence *xynoplex.CachePersistence
}

// NewTestClient is a real xynoplex.Client over a FaultyTransport, an
// InMemoryContent and a StubGateway. The client is closed as any other is,
// and whoever made the transport closes it, after the client.
func NewTestClient(config TestClientConfig) TestClient {
	made := TestClient{Transport: config.Transport, Content: config.Content, Gateway: config.Gateway}
	if made.Transport == nil {
		made.Transport = NewFaultyTransport(FaultyConfig{Channels: bus.BridgedChannels})
	}
	if made.Content == nil {
		made.Content = NewInMemoryContent()
	}
	if made.Gateway == nil {
		made.Gateway = &StubGateway{}
	}
	made.Client = xynoplex.NewClient(xynoplex.ClientConfig{
		Transport:   made.Transport,
		Content:     made.Content,
		Gateway:     made.Gateway,
		Timing:      config.Timing,
		Persistence: config.Persistence,
	})
	return made
}
