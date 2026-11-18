//go:build unix

package xynolog

import "os"

// ownerOnlyDir keeps a directory to its owner: the sign-in store's mode
// (OwnerOnlyDirMode), as the launcher keeps its state home.
func ownerOnlyDir(dir string) error {
	return os.Chmod(dir, OwnerOnlyDirMode)
}
