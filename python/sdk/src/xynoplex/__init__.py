"""Xynoplex's Python SDK.

What the protocol states, as Python types: the kinds of id
(`xynoplex.identifiers`), the shapes it sends and answers with
(`xynoplex.types`), the channels of its bus and the requests made over them
(`xynoplex.channels`, `xynoplex.operations`), and the tables a client keeps to
(`xynoplex.error_codes`, `xynoplex.timing`, `xynoplex.refresh`,
`xynoplex.telemetry_table`). All of it is generated from `protocol/specs/`.

The wire itself: what a client needs of whatever carries its bus, its content
and a gateway's own answers (`xynoplex.transport`), the bus typed by channel
(`xynoplex.bus`), a knowledge base's gateway as the carrier, and how a process
signs in there (`xynoplex.http`), and what is told to OpenTelemetry of it
(`xynoplex.telemetry`).

And the client every Xynoplex SDK has (`xynoplex.client`): its namespaces
(`xynoplex.namespaces`), each method a row of `protocol/specs/src/client/surface.json`,
its own bus (`xynoplex.event_bus`), and a session with one knowledge base
(`xynoplex.session`).
"""
