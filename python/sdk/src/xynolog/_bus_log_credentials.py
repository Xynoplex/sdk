# Generated from protocol/specs/src/bus/log-cases.json; do not edit.
# Regenerate: make generate (codegen/lib/bus/credentials.ml)
# ruff: noqa: E501, I001, RUF002, RUF022, RUF100

"""The names a credential goes by, which the bus log withholds."""

from typing import Final

__all__ = ["CREDENTIALS"]

CREDENTIALS: Final = frozenset(
    {
        "token",
        "cloneToken",
        "accessToken",
        "access_token",
        "refreshToken",
        "refresh_token",
        "apiKey",
        "api_key",
        "clientSecret",
        "client_secret",
        "secret",
        "password",
        "authorization",
        "Authorization",
        "x-api-key",
        "x-goog-api-key",
    }
)
"""The names a credential goes by: a bus log line shows `[withheld]` for the value of a member under any of them."""
