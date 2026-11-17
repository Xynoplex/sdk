"""The keys a registry of knowledge bases makes per knowledge base, per person and per kept query.

Each is one of `xynolog.stored`'s prefixes followed by what it is made for, as
`protocol/specs/src/session/stored.json` says, so a registry in another SDK over
the same storage finds what this one wrote.
"""

from xynolog._digest import base64url_sha256
from xynolog.stored import CACHE_KEY_PREFIX, LAST_EVENT_ID_KEY_PREFIX, SESSION_KEY_PREFIX, KeptQuery

__all__ = [
    "cache_key",
    "kb_of_session_key",
    "last_event_id_key",
    "person_key",
    "session_key",
]


def session_key(kb_id: str) -> str:
    """The key a knowledge base's session is kept under."""
    return f"{SESSION_KEY_PREFIX}{kb_id}"


def kb_of_session_key(key: str) -> str | None:
    """The knowledge base a key is the session of; nothing when it is no session's key."""
    return key.removeprefix(SESSION_KEY_PREFIX) if key.startswith(SESSION_KEY_PREFIX) else None


def person_key(did: str) -> str:
    """The key of the person whose did the gateway answered: what their caches and stream's places are kept under."""
    return base64url_sha256(did)


def last_event_id_key(kb_id: str, person_key: str) -> str:
    """The key a person's stream's places in a knowledge base are kept under, as `LastEventIds`."""
    return f"{LAST_EVENT_ID_KEY_PREFIX}{kb_id}.{person_key}"


def cache_key(kb_id: str, person_key: str, query: KeptQuery) -> str:
    """The key what a person's client keeps of `query` in a knowledge base is kept under."""
    return f"{CACHE_KEY_PREFIX}{kb_id}.{person_key}.{query}"
