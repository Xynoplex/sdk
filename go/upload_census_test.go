package xynolog

// form writes an upload's members by uploadSent, which is written by hand;
// this census holds it to uploadFields, generated from ResourceUpload, so a
// member either side gains or loses fails.

import (
	"slices"
	"testing"
)

func TestUploadSentIsEveryMemberButTheFile(t *testing.T) {
	var members []string
	for _, member := range uploadFields {
		if member.name != uploadFieldFile {
			members = append(members, member.name)
		}
	}
	var sent []string
	for name := range uploadSent {
		sent = append(sent, name)
	}
	slices.Sort(members)
	slices.Sort(sent)
	if !slices.Equal(members, sent) {
		t.Fatalf("uploadSent writes %v; an upload's members but its file are %v", sent, members)
	}
}
