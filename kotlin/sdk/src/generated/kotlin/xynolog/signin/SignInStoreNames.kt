// Generated from protocol/specs/src/sign-in-store/README.md; do not edit.
// Regenerate: make generate (codegen/lib/sign_in/store_names.ml)

package xynolog.signin

/**
 * The store's file in the launcher's state home, beside its lock.
 */
public const val FILE_NAME: String = "tokens.json"

/**
 * The file every writer of the store locks, beside the store.
 */
internal const val LOCK_NAME: String = "tokens.lock"

/**
 * The high word of the offset of the one byte of the lock a Windows writer locks, far past anything a lock file holds; a writer that locks the whole file holds it too.
 */
internal const val LOCK_OFFSET_HIGH: Long = 0x40000000
