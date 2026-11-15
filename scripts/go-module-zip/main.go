// go-module-zip writes a module's proxy zip with Go's own packager, from a git
// revision, so the bundle's zip is the one any module proxy builds from the
// release tag: the same files, and the repository's LICENSE when the module
// directory has none.
//
// Usage: go-module-zip <module path> <version> <repository> <revision> <module directory> <output zip>
package main

import (
	"fmt"
	"os"

	"golang.org/x/mod/module"
	"golang.org/x/mod/zip"
)

func main() {
	if len(os.Args) != 7 {
		fmt.Fprintln(os.Stderr, "usage: go-module-zip <module path> <version> <repository> <revision> <module directory> <output zip>")
		os.Exit(2)
	}
	version := module.Version{Path: os.Args[1], Version: os.Args[2]}
	out, err := os.Create(os.Args[6])
	if err != nil {
		fmt.Fprintln(os.Stderr, err)
		os.Exit(1)
	}
	if err := zip.CreateFromVCS(out, version, os.Args[3], os.Args[4], os.Args[5]); err != nil {
		fmt.Fprintln(os.Stderr, err)
		os.Exit(1)
	}
	if err := out.Close(); err != nil {
		fmt.Fprintln(os.Stderr, err)
		os.Exit(1)
	}
}
