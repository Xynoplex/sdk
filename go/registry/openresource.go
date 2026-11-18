package registry

// One open resource of a knowledge base (a tab, where there are tabs), and
// what is a function of a list of them and nothing else: their order, and
// what checking them against their knowledge base keeps and drops.

import (
	"cmp"
	"slices"

	"github.com/xynolog/sdk/go/api"
)

// OpenResource is one resource open in a knowledge base.
type OpenResource struct {
	ID   api.ResourceId `json:"id"`
	Name string         `json:"name"`
	// OpenedAt is when it was opened, in milliseconds since the epoch.
	OpenedAt int64 `json:"openedAt"`
	// Order is its place among the others.
	Order int `json:"order"`
	// MediaType is "" when none is known.
	MediaType string `json:"mediaType,omitempty"`
	// StorageURI is where it is in the working tree, such as
	// file://docs/overview.md; "" when that is not known.
	StorageURI string `json:"storageUri,omitempty"`
}

// ApplyTabChecks applies each verdict to list: it drops what is gone, takes
// the name and media type of what was found, and leaves everything else as it
// was. One with no verdict is left: it was opened while the checks were in
// flight. Only gone removes: closing everything because a service was briefly
// down would be worse than the stale entries this removes.
func ApplyTabChecks(list []OpenResource, checks map[api.ResourceId]api.TabCheck) []OpenResource {
	kept := []OpenResource{}
	for _, tab := range list {
		if check, checked := checks[tab.ID]; checked {
			// A check that states no verdict of its members leaves the tab.
			member, _ := check.ValueByDiscriminator()
			switch verdict := member.(type) {
			case api.TabCheckGone:
				continue
			case api.TabCheckReady:
				tab.Name = verdict.Name
				if verdict.MediaType != nil {
					tab.MediaType = *verdict.MediaType
				}
			}
		}
		kept = append(kept, tab)
	}
	return kept
}

// SortOpenResources is resources by the place each has, and among those
// given the same place, by when each was opened.
func SortOpenResources(resources []OpenResource) []OpenResource {
	sorted := slices.Clone(resources)
	slices.SortStableFunc(sorted, func(a, b OpenResource) int {
		return cmp.Or(cmp.Compare(a.Order, b.Order), cmp.Compare(a.OpenedAt, b.OpenedAt))
	})
	return sorted
}
