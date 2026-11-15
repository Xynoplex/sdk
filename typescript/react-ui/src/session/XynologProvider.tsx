'use client';

/**
 * XynologProvider — the single React provider for session state.
 * Puts the module-scoped XynologBrowser singleton into context so
 * `useXynolog()` can hand it back. Does not own the browser's lifetime
 * — the browser lives outside React, constructed lazily by `getBrowser()`
 * and disposed only via `__resetForTests` (never in production).
 *
 * Defaults to `WebBrowserStorage` + `createHttpSessionFactory()` (the
 * canonical web setup). Hosts that need a different shape — Electron /
 * Tauri with a filesystem-backed storage, a session factory for a
 * non-HTTP transport, etc. — pass `storage` and/or
 * `sessionFactory` to override the defaults. Tests typically construct
 * a `XynologBrowser` directly and inject it via `browser`.
 */

import { createContext, useContext, useMemo, type ReactNode } from 'react';
import {
  XynologBrowser,
  createHttpSessionFactory,
  getBrowser,
  type SessionFactory,
  type SessionStorage,
} from '@xynolog/sdk';
import { WebBrowserStorage } from './web-browser-storage';

const XynologContext = createContext<XynologBrowser | null>(null);

export interface XynologProviderProps {
  /** Inject a fully-constructed browser (tests, embedded hosts that build their own). Omit to use the default. */
  browser?: XynologBrowser;
  /** Override the default `WebBrowserStorage`. Useful for non-browser hosts (Electron/Tauri filesystem-backed adapters). */
  storage?: SessionStorage;
  /** Override the default HTTP session factory. Useful for non-HTTP transports. */
  sessionFactory?: SessionFactory;
  children: ReactNode;
}

export function XynologProvider({ browser, storage, sessionFactory, children }: XynologProviderProps) {
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
  return <XynologContext.Provider value={value}>{children}</XynologContext.Provider>;
}

export function useXynolog(): XynologBrowser {
  const ctx = useContext(XynologContext);
  if (!ctx) {
    throw new Error('useXynolog must be used within a <XynologProvider>');
  }
  return ctx;
}
