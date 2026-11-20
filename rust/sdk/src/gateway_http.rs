//! The gateway's HTTP surface as the transport says it: each operation's
//! method, path and media types, the headers the operations name, an
//! upload's members and the client secret form. Filling a path and sending a
//! form are the transport's own.

include!("generated/gateway_http.rs");
