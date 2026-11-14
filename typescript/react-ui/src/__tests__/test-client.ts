/**
 * makeTestClient — structurally-typed `XynoplexClient` stand-in for state unit
 * factory tests. Exposes a real `EventBus` as `client.bus` (the same
 * shape production code reads), plus whatever HTTP namespaces the caller
 * supplies via `overrides`.
 *
 * Usage:
 *
 * ```ts
 * // bus-only state unit
 * const { bus, client } = makeTestClient();
 * const stateUnit = createBeckonStateUnit(client, resourceId);
 * client.bus.emit('beckon:hover', { annotationId: 'ann-1' });
 * bus.destroy(); // in afterEach
 *
 * // state unit that also calls HTTP namespaces
 * const { client } = makeTestClient({
 *   mark: {
 *     annotation: vi.fn().mockResolvedValue({ annotationId: 'ann-new' }),
 *     delete: vi.fn().mockResolvedValue(undefined),
 *   },
 * });
 * const stateUnit = createMarkStateUnit(client, resourceId);
 * ```
 *
 * The `client` is cast `as unknown as XynoplexClient`, matching the
 * established pattern for structural mocks in this codebase.
 */

import { BehaviorSubject, Subject, type Observable, map as rxMap } from 'rxjs';
import { EventBus } from '@xynoplex/core';
import type { ConnectionState, XynoplexError } from '@xynoplex/core';
import type { CacheState } from '@xynoplex/sdk';
import type { XynoplexClient, XynoplexSession } from '@xynoplex/sdk';
import { XynoplexSession as RealXynoplexSession, httpKb, MemorySignIn } from '@xynoplex/sdk';
import type { AccessToken } from '@xynoplex/core';

export interface TestClient {
  /** The real bus backing `client.bus` — exposed so tests can
   *  destroy() it in afterEach. Same instance as `client.bus`. */
  bus: EventBus;
  client: XynoplexClient;
}

export function makeTestClient(
  overrides: Record<string, unknown> = {},
): TestClient {
  const bus = new EventBus();
  const client = {
    // Surfaces a REAL `XynoplexSession` reads at construction — present by
    // default so `makeTestSession` can wrap this client; overridable.
    state$: new BehaviorSubject<ConnectionState>('open').asObservable(),
    transport: { errors$: new Subject<XynoplexError>().asObservable() },
    ...overrides,
    bus,
  } as unknown as XynoplexClient;
  return { bus, client };
}

export interface TestSession extends TestClient {
  /** A REAL `XynoplexSession` wrapping the structural client above — for
   *  state-unit factories, which take a session rather than a client. The
   *  session machinery (id, kb, token$) is real; only the client seam is
   *  scripted. */
  session: XynoplexSession;
}

export function makeTestSession(
  overrides: Record<string, unknown> = {},
): TestSession {
  const { bus, client } = makeTestClient(overrides);
  const session = new RealXynoplexSession({
    kb: httpKb({
      id: 'test-kb',
      label: 'Test KB',
      host: 'localhost',
      port: 4000,
      protocol: 'http',
    }),
    kept: new MemorySignIn(),
    client,
    token$: new BehaviorSubject<AccessToken | null>(null),
  });
  return { bus, client, session };
}

/**
 * Wrap a structural client mock in a REAL `XynoplexSession` — the bridge for
 * factory tests whose subject is unit logic over a scripted client seam
 * (a state-unit factory takes a session, never a bare client). Supplies the
 * two surfaces the session constructor reads (`state$`, `transport.errors$`)
 * when the mock lacks them; the mock's own members win when present. Same
 * documented structural-mock cast this helper already uses.
 */
export function sessionOf(client: XynoplexClient): XynoplexSession {
  const complete = {
    state$: new BehaviorSubject<ConnectionState>('open').asObservable(),
    transport: { errors$: new Subject<XynoplexError>().asObservable() },
    ...(client as unknown as Record<string, unknown>),
  } as unknown as XynoplexClient;
  return new RealXynoplexSession({
    kb: httpKb({
      id: 'test-kb',
      label: 'Test KB',
      host: 'localhost',
      port: 4000,
      protocol: 'http',
    }),
    kept: new MemorySignIn(),
    client: complete,
    token$: new BehaviorSubject<AccessToken | null>(null),
  });
}

/**
 * Adapt a value-typed fixture stream to the cache's CacheState emission
 * (pending, ready or failed): `undefined` → pending, values → ready. Failure
 * is an EMISSION too, so B15-driving fixtures push
 * `{ status: 'failed', error }` themselves rather than erroring the stream.
 */
export function asStates<T>(source: Observable<T | undefined>): Observable<CacheState<T>> {
  return source.pipe(
    rxMap((v) => {
      // Passthrough for fixtures that push explicit states (a `failed`
      // emission has no value-shaped spelling).
      if (v !== null && typeof v === 'object' && 'status' in (v as object)) {
        return v as unknown as CacheState<T>;
      }
      return v === undefined
        ? ({ status: 'pending' } as CacheState<T>)
        : ({ status: 'ready', value: v } as CacheState<T>);
    }),
  );
}
