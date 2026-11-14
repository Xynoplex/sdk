'use client';

/**
 * XynoplexProvider — the single React provider for session state.
 * Puts the module-scoped XynoplexBrowser singleton into context so
 * `useXynoplex()` can hand it back. Does not own the browser's lifetime
 * — the browser lives outside React, constructed lazily by `getBrowser()`
 * and disposed only via `__resetForTests` (never in production).
 *
 * Defaults to `WebBrowserStorage` + `createHttpSessionFactory()` (the
 * canonical web setup). Hosts that need a different shape — Electron /
 * Tauri with a filesystem-backed storage, a session factory for a
 * non-HTTP transport, etc. — pass `storage` and/or
 * `sessionFactory` to override the defaults. Tests typically construct
 * a `XynoplexBrowser` directly and inject it via `browser`.
 */

import { createContext, useContext, useMemo, type ReactNode } from 'react';
import {
  XynoplexBrowser,
  createHttpSessionFactory,
  getBrowser,
  type SessionFactory,
  type SessionStorage,
} from '@xynoplex/sdk';
import { WebBrowserStorage } from './web-browser-storage';

const XynoplexContext = createContext<XynoplexBrowser | null>(null);

export interface XynoplexProviderProps {
  /** Inject a fully-constructed browser (tests, embedded hosts that build their own). Omit to use the default. */
  browser?: XynoplexBrowser;
  /** Override the default `WebBrowserStorage`. Useful for non-browser hosts (Electron/Tauri filesystem-backed adapters). */
  storage?: SessionStorage;
  /** Override the default HTTP session factory. Useful for non-HTTP transports. */
  sessionFactory?: SessionFactory;
  children: ReactNode;
}

export function XynoplexProvider({ browser, storage, sessionFactory, children }: XynoplexProviderProps) {
  // `useMemo` here is a stable read, not a factory: `getBrowser()` returns
  // the module singleton, so re-renders observe the same instance. The
  // first call to `getBrowser` wins; subsequent renders see the same
  // instance regardless of prop changes.
  const value = useMemo(
    () => browser ?? getBrowser({
      storage: storage ?? new WebBrowserStorage(),
      sessionFactory: sessionFactory ?? createHttpSessionFactory(),
    }),
    [browser, storage, sessionFactory],
  );
  return <XynoplexContext.Provider value={value}>{children}</XynoplexContext.Provider>;
}

export function useXynoplex(): XynoplexBrowser {
  const ctx = useContext(XynoplexContext);
  if (!ctx) {
    throw new Error('useXynoplex must be used within a <XynoplexProvider>');
  }
  return ctx;
}
