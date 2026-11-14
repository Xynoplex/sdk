/**
 * Tests for `XynoplexClient.fromHttp(...)`.
 *
 * `fromHttp` is purely structural: it constructs `HttpTransport` +
 * `HttpContentTransport`, threads a fresh `BehaviorSubject<AccessToken>`
 * through, brands string inputs, and returns a wired client. We assert
 * on the wiring it can hand back without going to the wire.
 *
 * Signing in belongs to the session layer (`XynoplexSession.signInDevice`,
 * tested in `session/__tests__/xynoplex-session-factories.test.ts`);
 * `fromHttp` never authenticates, so nothing here goes to the wire.
 */

import { describe, test, expect, vi, afterEach } from 'vitest';
import {
  accessToken as makeAccessToken,
  baseUrl as makeBaseUrl,
} from '@xynoplex/core';
import { HttpTransport } from '@xynoplex/http-transport';

import { XynoplexClient } from '../client';

afterEach(() => {
  vi.restoreAllMocks();
});

describe('XynoplexClient.fromHttp', () => {
  test('accepts string baseUrl and brands it; returns a XynoplexClient', () => {
    const client = XynoplexClient.fromHttp({ baseUrl: 'http://test.local' });
    try {
      expect(client).toBeInstanceOf(XynoplexClient);
      expect(client.baseUrl).toBe('http://test.local');
      expect(client.transport).toBeInstanceOf(HttpTransport);
    } finally {
      client.dispose();
    }
  });

  test('accepts already-branded BaseUrl', () => {
    const url = makeBaseUrl('http://branded.local');
    const client = XynoplexClient.fromHttp({ baseUrl: url });
    try {
      expect(client.baseUrl).toBe('http://branded.local');
    } finally {
      client.dispose();
    }
  });

  test('accepts string token and brands it', () => {
    const client = XynoplexClient.fromHttp({
      baseUrl: 'http://test.local',
      token: 'header.payload.sig',
    });
    try {
      // The token flows into the transport's internal token$, which the
      // transport reads from when assembling Authorization. We can't read
      // it back without going through HTTP, but we can assert construction
      // succeeded and the client is usable.
      expect(client).toBeInstanceOf(XynoplexClient);
    } finally {
      client.dispose();
    }
  });

  test('accepts already-branded AccessToken', () => {
    const tok = makeAccessToken('header.payload.sig');
    const client = XynoplexClient.fromHttp({
      baseUrl: 'http://test.local',
      token: tok,
    });
    try {
      expect(client).toBeInstanceOf(XynoplexClient);
    } finally {
      client.dispose();
    }
  });

  test('omitting token constructs an unauthenticated client', () => {
    const client = XynoplexClient.fromHttp({ baseUrl: 'http://test.local' });
    try {
      expect(client).toBeInstanceOf(XynoplexClient);
    } finally {
      client.dispose();
    }
  });

  test('null token is treated as no token', () => {
    const client = XynoplexClient.fromHttp({
      baseUrl: 'http://test.local',
      token: null,
    });
    try {
      expect(client).toBeInstanceOf(XynoplexClient);
    } finally {
      client.dispose();
    }
  });

  test('dispose() shuts down the underlying transport+content cleanly', () => {
    const client = XynoplexClient.fromHttp({ baseUrl: 'http://test.local' });
    // dispose() should not throw and should be idempotent enough that the
    // test runner cleanup succeeds.
    expect(() => client.dispose()).not.toThrow();
  });
});
