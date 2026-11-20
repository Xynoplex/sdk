# Generated from protocol/specs/src/sign-in-store/README.md; do not edit.
# Regenerate: make generate (codegen/lib/sign_in/store_names.ml)
# ruff: noqa: E501, I001, RUF002, RUF022, RUF100

"""The names the sign-in store's contract gives its files, and the byte a Windows
writer locks."""

from typing import Final

__all__ = ["FILE_NAME", "LOCK_NAME", "LOCK_OFFSET_HIGH"]

# The store's file in the launcher's state home, beside its lock.
FILE_NAME: Final = "tokens.json"

# The file every writer of the store locks, beside the store.
LOCK_NAME: Final = "tokens.lock"

# The high word of the offset of the one byte of the lock a Windows writer locks, far past
# anything a lock file holds; a writer that locks the whole file holds it too.
LOCK_OFFSET_HIGH: Final = 0x40000000
