// Code generated from protocol/specs/src/sign-in-store/README.md — DO NOT EDIT.
//
// Regenerate: make generate (codegen/lib/sign_in/store_names.ml)

package xynolog

// SignInFile: The store's file in the launcher's state home, beside its lock.
const SignInFile = "tokens.json"

// signInLock: The file every writer of the store locks, beside the store.
const signInLock = "tokens.lock"

// signInLockOffsetHigh: The high word of the offset of the one byte of the
// lock a Windows writer locks, far past anything a lock file holds; a writer
// that locks the whole file holds it too.
const signInLockOffsetHigh = 0x40000000
