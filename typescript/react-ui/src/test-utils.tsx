/**
 * Test utilities for @xynoplex/react-ui
 *
 * Provides a renderWithProviders helper that wraps components with all necessary providers
 * for testing, with customizable mock implementations.
 *
 * THE DOUBLES LIVE IN `@xynoplex/sdk/testing`, NOT HERE — `createTestClient` /
 * `createTestSession` (real client and session over `FaultyTransport`),
 * `stubGateway`, `inMemoryContent`, `refuseUnscriptedOperation`. This module
 * only assembles them into React providers. Reach for the SDK's first; a
 * hand-rolled double here encodes its author's model of a contract the SDK
 * already owns, and a wrong belief encoded that way ships inside green tests.
 */

import React, { ReactElement } from 'react';
import { render, RenderOptions, RenderResult } from '@testing-library/react';
import { vi, afterEach } from 'vitest';
import { XynoplexBrowser, createSessionSignals, type XynoplexClient, type XynoplexSession, type SessionEndReason } from '@xynoplex/sdk';
import { createTestSession, stubGateway } from '@xynoplex/sdk/testing';
import { EventBus } from '@xynoplex/core';
import { TranslationProvider } from './contexts/TranslationContext';
import { LineNumbersProvider } from './contexts/LineNumbersContext';
import { ToastProvider } from './components/Toast';
import type { TranslationManager } from './types/TranslationManager';
import { createTranslationManager } from './lib/translation-manager';
import { XynoplexProvider } from './session/XynoplexProvider';
import en from '../translations/en.json';

/**
  * Every browser below is a REAL `XynoplexBrowser` over the SDK's own
  * in-memory doubles — no HTTP, no localhost, no network. Clients are
  * disposed at test end all the same: a chain straddling teardown dies in the
  * cache's B16 disposed-guard rather than logging while the vitest worker's RPC
  * closes (an `EnvironmentTeardownError`). Registered at module scope:
  * every file that imports test-utils — exactly the files that create
  * clients — gets the hook.
  */
const liveTestClients: XynoplexClient[] = [];
const liveTestBrowsers: XynoplexBrowser[] = [];
afterEach(async () => {
  // Browsers first: `XynoplexBrowser`'s constructor opens standing
  // subscriptions (kbs$/activeKbId$ persistence, the open-resources
  // projection) and owns an EventBus. These are REAL browsers, so leaving
  // them live leaks a growing set of subscriptions across a 179-file run.
  for (const browser of liveTestBrowsers.splice(0)) await browser.dispose();
  for (const client of liveTestClients.splice(0)) client.dispose();
});

/**
 * A real `XynoplexBrowser` for tests, carrying a real `XynoplexSession` whose
 * client speaks to in-memory transports. Nothing here is impersonated, so a
 * test spying on `BindNamespace.prototype.body` — or reading
 * `browser.activeSession$` — sees the production surface.
 */

function createTestBrowser(): XynoplexBrowser {
  // A REAL `XynoplexBrowser` over real in-memory transports — not a
  // look-alike. `XynoplexBrowserConfig` is only `{storage, sessionFactory}`
  // and the class is transport-agnostic by design ("every HTTP-vs-local
  // construction concern lives in the factory"), so the double stops at the
  // transport layer and production code sees the production surface.
  // Both doubles refuse rather than invent: `stubGateway`'s ops reject by
  // name, and `FaultyTransport` refuses unscripted bus operations by
  // default — so a unit that reaches something the test never scripted fails
  // saying which one.
  const { session, client, storage } = createTestSession({ gateway: stubGateway() });
  liveTestClients.push(client);
  const browser = new XynoplexBrowser({ storage, sessionFactory: () => session });
  liveTestBrowsers.push(browser);
  // The browser populates these only by driving a real sign-in; tests want a
  // connected shape from the first render. Both values are real objects, so
  // seeding them states a fact rather than faking one.
  browser.activeSession$.next(session);
  browser.activeSignals$.next(createSessionSignals());
  return browser;
}

/**
 * Default mock implementations
 */
export const defaultMocks = {
  translationManager: {
    t: (namespace: string, key: string, params?: Record<string, unknown>) => {
      let result = `${namespace}.${key}`;
      if (params) {
        Object.entries(params).forEach(([k, v]) => {
          result = result.replace(`{${k}}`, String(v));
        });
      }
      return result;
    },
  } as TranslationManager,
};

/**
 * react-ui's own English strings, for a test that asserts on the copy. Nothing
 * in react-ui assumes a language, so a test that wants one names it.
 */
export const englishTranslationManager = createTranslationManager('en', en);

/**
 * Render under react-ui's English translations. A `wrapper` in the options is
 * mounted inside them; no other provider is added.
 */
export function renderInEnglish(ui: ReactElement, options?: RenderOptions): RenderResult {
  const Wrapper = options?.wrapper;
  return render(ui, {
    ...options,
    wrapper: ({ children }) => (
      <TranslationProvider translationManager={englishTranslationManager}>
        {Wrapper ? <Wrapper>{children}</Wrapper> : children}
      </TranslationProvider>
    ),
  });
}

/**
 * Options for renderWithProviders
 */
export interface TestProvidersOptions {
  translationManager?: TranslationManager;
  /** Inject a specific XynoplexBrowser (e.g. one seeded with a kbs list). */
  browser?: XynoplexBrowser;
}

/**
 * Test access to the client's local bus. Production code uses typed
 * namespace methods, and the event hooks read a channel by name through
 * `session/channel-subscription.ts` — never direct bus access. Tests need the bus itself to drive
 * `bus.emit(channel, payload)` / `bus.on(channel).subscribe(...)` against the
 * live client wiring; `client.bus` is read-only public for that.
 */
function busOf(client: XynoplexClient): EventBus {
  return client.bus;
}

export interface RenderWithProvidersOptions extends TestProvidersOptions, Omit<RenderOptions, 'wrapper'> {
  /**
   * If true, returns the session (client) EventBus — session-scoped
   * channels (mark:*, beckon:*, gather:*, match:*, bind:*, yield:*,
   * browse:click, browse:resource-open, browse:entity-type-clicked).
   */
  returnEventBus?: boolean;
  /**
   * If true, returns the `XynoplexBrowser` itself, whose `stream(channel)`
   * reads the app-scoped channels — panel:*, shell:*, tabs:*, nav:*,
   * settings:*. (Its bus is private; `stream` is the published reader.)
   */
  returnShellBus?: boolean;
}

export interface RenderWithProvidersResult extends RenderResult {
  /** Session-scoped bus (from the client inside the browser). */
  eventBus?: EventBus;
  /** The browser — `browser.stream(channel)` reads app-scoped channels. */
  browser?: XynoplexBrowser;
  /** The session — pass as the `session` prop to provider-free components. */
  session: XynoplexSession | null;
}

export function renderWithProviders(
  ui: ReactElement,
  options?: RenderWithProvidersOptions
): RenderWithProvidersResult {
  const {
    translationManager = defaultMocks.translationManager,
    browser,
    returnEventBus = false,
    returnShellBus = false,
    ...renderOptions
  } = options || {};

  const testBrowser = browser ?? createTestBrowser();
  const testSession = testBrowser.activeSession$.getValue();
  const client = testSession?.client;

  function Wrapper({ children }: { children: React.ReactNode }) {
    return (
      <TranslationProvider translationManager={translationManager}>
        <XynoplexProvider browser={testBrowser}>
          <ToastProvider>
            <LineNumbersProvider>
              {children}
            </LineNumbersProvider>
          </ToastProvider>
        </XynoplexProvider>
      </TranslationProvider>
    );
  }

  const result = render(ui, { wrapper: Wrapper, ...renderOptions });

  const extras: Partial<RenderWithProvidersResult> = {};
  if (returnEventBus && client) extras.eventBus = busOf(client);
  if (returnShellBus) extras.browser = testBrowser;
  return { ...result, session: testSession, ...extras };
}

/**
 * Build a minimal `<XynoplexProvider>` wrapper for tests that roll their
 * own render wrapper (instead of `renderWithProviders`). The returned
 * `eventBus` is the bus backing the session's client — the same
 * instance the client's namespace methods emit on.
 */
export function createTestXynoplexWrapper(): {
  XynoplexWrapper: React.ComponentType<{ children: React.ReactNode }>;
  /** Session-scoped bus (from the client). */
  eventBus: EventBus;
  /** The browser — `browser.stream(channel)` reads app-scoped channels. */
  browser: XynoplexBrowser;
  /** The session's client — for tests that need to spy on namespace methods. */
  client: XynoplexClient;
  /** The session — pass as the `session` prop to provider-free components. */
  session: XynoplexSession;
} {
  const testBrowser = createTestBrowser();
  const testSession = testBrowser.activeSession$.getValue()!;
  const client = testSession.client;
  const XynoplexWrapper = ({ children }: { children: React.ReactNode }) => (
    <XynoplexProvider browser={testBrowser}>{children}</XynoplexProvider>
  );
  return {
    XynoplexWrapper,
    eventBus: busOf(client),
    browser: testBrowser,
    client,
    session: testSession,
  };
}

/**
 * Create a mock translation manager with custom translations
 */
export function createMockTranslationManager(
  translations: Record<string, Record<string, string>>
): TranslationManager {
  return {
    t: (namespace: string, key: string) => {
      return translations[namespace]?.[key] || key;
    },
  };
}

/**
 * A real `XynoplexBrowser` whose `SessionSignals` are pre-populated. Used by SessionEndedModal and
 * PermissionDeniedModal tests that need to control the modal flags
 * without driving a real session through its state machine.
 */
export function createTestBrowserWithSignals(overrides: {
  /** Raise permission-denied with this detail: the gateway's own words, or null when it gave none. */
  permissionDenied?: { detail: string | null };
  /** Raise session-ended with this reason. */
  sessionEnded?: { reason: SessionEndReason };
  acknowledgePermissionDenied?: () => void;
  acknowledgeSessionEnded?: () => void;
} = {}): XynoplexBrowser {
  const browser = createTestBrowser();
  const signals = browser.activeSignals$.getValue()!;

  // Raise the signals the modals read, through the methods production calls.
  if (overrides.permissionDenied !== undefined) {
    signals.notifyPermissionDenied(overrides.permissionDenied.detail);
  }
  if (overrides.sessionEnded !== undefined) {
    signals.notifySessionEnded(overrides.sessionEnded.reason);
  }

  // Spies on the REAL methods, not replacements for them: a test asserting
  // "the modal acknowledged" is asserting about the method production calls.
  if (overrides.acknowledgePermissionDenied) {
    vi.spyOn(signals, 'acknowledgePermissionDenied').mockImplementation(
      overrides.acknowledgePermissionDenied,
    );
  }
  if (overrides.acknowledgeSessionEnded) {
    vi.spyOn(signals, 'acknowledgeSessionEnded').mockImplementation(
      overrides.acknowledgeSessionEnded,
    );
  }

  return browser;
}

// Re-export testing library utilities
export * from '@testing-library/react';
export { vi } from 'vitest';
