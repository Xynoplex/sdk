/**
 * @xynoplex/http-transport
 *
 * HTTP-specific transport adapters for the Xynoplex SDK. The dev-facing
 * surface (`XynoplexClient`, namespaces, session, state units, helpers)
 * lives in `@xynoplex/sdk`. The shared transport contract
 * (`ITransport`, `IContentTransport`, `BRIDGED_CHANNELS`,
 * `ConnectionState`, response types) lives in `@xynoplex/core`.
 *
 * Most consumers do not import from this package directly — `@xynoplex/sdk`
 * re-exports the HTTP adapters so a typical app does:
 *
 * ```ts
 * import { XynoplexClient, HttpTransport, HttpContentTransport } from '@xynoplex/sdk';
 * ```
 *
 * Direct imports are appropriate when constructing the transport stack
 * by hand, as the MCP server does.
 */

export {
  HttpTransport,
  currentUserOf,
  type HttpTransportConfig,
  type TokenRefresher,
} from './transport/http-transport';
export { APIError } from './transport/api-error';
export { agentToken, type AgentSignIn } from './transport/agent-token';

export { HttpContentTransport } from './transport/http-content-transport';
