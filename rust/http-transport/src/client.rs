//! A client of a knowledge base over its gateway: the SDK's `XynologClient`
//! with this crate's transport under all three of its contracts, so `auth`
//! and `system` are there.

use crate::content::HttpContentTransport;
use crate::transport::{HttpTransport, HttpTransportConfig};
use std::sync::Arc;
use xynolog::client::{ClientOptions, XynologClient};

/// A client over the gateway `config` names. The transport opens its stream
/// when it is first needed.
pub fn client(config: HttpTransportConfig, options: ClientOptions) -> XynologClient {
    let transport = Arc::new(HttpTransport::new(config));
    let content = Arc::new(HttpContentTransport::new(&transport));
    XynologClient::new(transport.clone(), content, Some(transport), options)
}
