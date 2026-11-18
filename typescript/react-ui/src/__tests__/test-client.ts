/**
 * makeTestClient — structurally-typed `XynologClient` stand-in for state unit
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
 * The `client` is cast `as unknown as XynologClient`, matching the
 * established pattern for structural mocks in this codebase.
 */

import { BehaviorSubject, Subject, type Observable, map as rxMap } from 'rxjs';
import { EventBus } from '@xynolog/core';
import type { ConnectionState, XynologError } from '@xynolog/core';
import type { CacheState } from '@xynolog/sdk';
import type { XynologClient, XynologSession } from '@xynolog/sdk';
import {
  XynologSession as RealXynologSession,
  httpKb,
  MemorySignIn,
} from '@xynolog/sdk';
import type { AccessToken } from '@xynolog/core';

export interface TestClient {
  /** The real bus backing `client.bus` — exposed so tests can
   *  destroy() it in afterEach. Same instance as `client.bus`. */
  bus: EventBus;
  client: XynologClient;
}

export function makeTestClient(
  overrides: Record<string, unknown> = {},
): TestClient {
  const bus = new EventBus();
  const client = {
    // Surfaces a REAL `XynologSession` reads at construction — present by
    // default so `makeTestSession` can wrap this client; overridable.
    state$: new BehaviorSubject<ConnectionState>('open').asObservable(),
    transport: { errors$: new Subject<XynologError>().asObservable() },
    ...overrides,
    bus,
  } as unknown as XynologClient;
  return { bus, client };
}

export interface TestSession extends TestClient {
  /** A REAL `XynologSession` wrapping the structural client above — for
   *  state-unit factories, which take a session rather than a client. The
   *  session machinery (id, kb, token$) is real; only the client seam is
   *  scripted. */
  session: XynologSession;
}

export function makeTestSession(
  overrides: Record<string, unknown> = {},
): TestSession {
  const { bus, client } = makeTestClient(overrides);
  const session = new RealXynologSession({
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
 * Wrap a structural client mock in a REAL `XynologSession` — the bridge for
 * factory tests whose subject is unit logic over a scripted client seam
 * (a state-unit factory takes a session, never a bare client). Supplies the
 * two surfaces the session constructor reads (`state$`, `transport.errors$`)
 * when the mock lacks them; the mock's own members win when present. Same
 * documented structural-mock cast this helper already uses.
 */
export function sessionOf(client: XynologClient): XynologSession {
  const complete = {
    state$: new BehaviorSubject<ConnectionState>('open').asObservable(),
    transport: { errors$: new Subject<XynologError>().asObservable() },
    ...(client as unknown as Record<string, unknown>),
  } as unknown as XynologClient;
  return new RealXynologSession({
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
export function asStates<T>(
  source: Observable<T | undefined>,
): Observable<CacheState<T>> {
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
