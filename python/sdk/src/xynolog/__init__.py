"""Xynolog's Python SDK.

What the protocol states, as Python types: the kinds of id
(`xynolog.identifiers`), the shapes it sends and answers with
(`xynolog.types`), the channels of its bus and the requests made over them
(`xynolog.channels`, `xynolog.operations`), and the tables a client keeps to
(`xynolog.error_codes`, `xynolog.timing`, `xynolog.refresh`,
`xynolog.telemetry_table`). All of it is generated from `protocol/specs/`.

The wire itself: what a client needs of whatever carries its bus, its content
and a gateway's own answers (`xynolog.transport`), the bus typed by channel
(`xynolog.bus`), a knowledge base's gateway as the carrier, and how a process
signs in there (`xynolog.http`), and what is told to OpenTelemetry of it
(`xynolog.telemetry`).

And the client every Xynolog SDK has (`xynolog.client`): its namespaces
(`xynolog.namespaces`), each method a row of `protocol/specs/src/client/surface.json`,
its own bus (`xynolog.event_bus`), and a session with one knowledge base
(`xynolog.session`).
"""
