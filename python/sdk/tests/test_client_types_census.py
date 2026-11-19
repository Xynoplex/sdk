"""SearchState and JobEvent, generic and written by hand, held to their schemas.

The schemas are in `protocol/specs/src/client/types`. Each type's members and branches are read off the type itself, so a member or
a branch either side gains or loses fails.
"""

from dataclasses import fields
from typing import get_args, get_origin

from pydantic import JsonValue
from spec import SPEC, JsonObject, read

from xynolog.namespaces.follow import JobEvent, RefusedFrame
from xynolog.state.search import SearchState


def _properties(schema: JsonValue) -> set[str]:
    assert isinstance(schema, dict)
    properties = schema["properties"]
    assert isinstance(properties, dict)
    return set(properties)


def _member(schema: JsonValue, name: str) -> JsonValue:
    assert isinstance(schema, dict)
    properties = schema["properties"]
    assert isinstance(properties, dict)
    return properties[name]


def _schema(name: str) -> JsonObject:
    return read(SPEC / "client/types" / f"{name}.json")


def test_search_state_has_the_schemas_members() -> None:
    written = {info.alias or name for name, info in SearchState.model_fields.items()}
    assert written == _properties(_schema("SearchState"))


def test_job_event_has_the_schemas_branches_each_of_its_members() -> None:
    one_of = _schema("JobEvent")["oneOf"]
    assert isinstance(one_of, list)
    branches: dict[str, JsonValue] = {}
    for branch in one_of:
        kind = _member(branch, "kind")
        assert isinstance(kind, dict)
        values = kind["enum"]
        assert isinstance(values, list)
        assert isinstance(values[0], str)
        branches[values[0]] = branch
    written: dict[str, set[str]] = {}
    for event in get_args(JobEvent.__value__):
        held = {field.name: field for field in fields(get_origin(event) or event)}
        told = held["kind"].default
        assert isinstance(told, str)
        written[told] = set(held)
    assert set(written) == set(branches)
    for told, members in written.items():
        assert members == _properties(branches[told]), told
    assert {field.name for field in fields(RefusedFrame)} == _properties(_member(branches["refused"], "data"))
