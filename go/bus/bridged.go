package bus

// BridgedChannels: everything a transport delivers — the broadcasts plus
// every operation's reply channels. Derived from Operations, so a reply can
// never be missing from the set (the recurring unbridged-reply bug).
var BridgedChannels = func() []Channel {
	out := append([]Channel(nil), BridgedBroadcasts...)
	for _, op := range Operations {
		out = append(out, op.Result, op.Failure)
	}
	return out
}()

// Bridged reports whether a channel can be received over a transport at all.
// Subscribing to anything else delivers nothing, silently — the trap the bus
// docs warn about.
func Bridged(c Channel) bool {
	for _, b := range BridgedChannels {
		if b == c {
			return true
		}
	}
	return false
}
