/**
 * A valid `ResourceDescriptor`, for tests that need one to exist rather than
 * to be interesting. Shared for the same reason as `mockAnnotation`: it was
 * hand-written per file, and under-shaped versions (`{ '@id': rid }`,
 * `{ id: 'res-1' }`) rode into typed bus channels behind the transport
 * doubles' `as unknown as` casts.
 */

import { resourceId } from '@xynolog/core';
import type { ResourceDescriptor } from '@xynolog/core';

export function mockResource(id: string, overrides: Partial<ResourceDescriptor> = {}): ResourceDescriptor {
  return {
    '@context': 'https://xynolog.dev/context/v1',
    '@id': resourceId(id),
    name: `Resource ${id}`,
    representations: [],
    ...overrides,
  };
}
