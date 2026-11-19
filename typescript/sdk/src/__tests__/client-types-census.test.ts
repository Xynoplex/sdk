/**
 * SearchState and JobEvent are generic, so they are written by hand; this
 * census holds each to its schema in protocol/specs/src/client/types. The
 * compiler holds each list below to the type's members and branches, and the
 * test holds the list to the schema's, so a member or a branch either side
 * gains or loses fails.
 */

import { readFileSync } from 'node:fs';
import { describe, expect, expectTypeOf, it } from 'vitest';
import type { JobEvent } from '../awaitable';
import type { SearchState } from '../state/lib/search-pipeline';

interface ObjectSchema {
  properties: Record<string, ObjectSchema & { enum?: string[] }>;
}

function schema<T>(name: string): T {
  return JSON.parse(
    readFileSync(
      new URL(
        `../../../../protocol/specs/src/client/types/${name}.json`,
        import.meta.url,
      ),
      'utf8',
    ),
  );
}

const sorted = (names: readonly string[]) => [...names].sort();

const SEARCH_STATE = [
  'results',
  'isSearching',
] as const satisfies readonly (keyof SearchState<unknown>)[];

type Branch<K extends JobEvent['kind']> = Extract<JobEvent, { kind: K }>;

const JOB_EVENT = {
  created: ['kind', 'data'],
  progress: ['kind', 'data'],
  failed: ['kind', 'data'],
  refused: ['kind', 'data'],
  complete: ['kind', 'data'],
} as const satisfies { [K in JobEvent['kind']]: readonly (keyof Branch<K>)[] };

const REFUSED_DATA = [
  'channel',
  'member',
  'reason',
] as const satisfies readonly (keyof Branch<'refused'>['data'])[];

describe('the generic client types (protocol/specs/src/client/types)', () => {
  it('SearchState has the schema’s members', () => {
    expectTypeOf<
      Exclude<keyof SearchState<unknown>, (typeof SEARCH_STATE)[number]>
    >().toBeNever();
    const { properties } = schema<ObjectSchema>('SearchState');
    expect(sorted(Object.keys(properties))).toEqual(sorted(SEARCH_STATE));
  });

  it('JobEvent has the schema’s branches, each of its members', () => {
    expectTypeOf<
      Exclude<keyof Branch<'created'>, (typeof JOB_EVENT.created)[number]>
    >().toBeNever();
    expectTypeOf<
      Exclude<keyof Branch<'progress'>, (typeof JOB_EVENT.progress)[number]>
    >().toBeNever();
    expectTypeOf<
      Exclude<keyof Branch<'failed'>, (typeof JOB_EVENT.failed)[number]>
    >().toBeNever();
    expectTypeOf<
      Exclude<keyof Branch<'refused'>, (typeof JOB_EVENT.refused)[number]>
    >().toBeNever();
    expectTypeOf<
      Exclude<keyof Branch<'complete'>, (typeof JOB_EVENT.complete)[number]>
    >().toBeNever();
    expectTypeOf<
      Exclude<keyof Branch<'refused'>['data'], (typeof REFUSED_DATA)[number]>
    >().toBeNever();

    const { oneOf } = schema<{ oneOf: ObjectSchema[] }>('JobEvent');
    const branches = new Map(
      oneOf.map((branch) => [branch.properties.kind!.enum![0]!, branch]),
    );
    expect(sorted([...branches.keys()])).toEqual(
      sorted(Object.keys(JOB_EVENT)),
    );
    for (const [kind, members] of Object.entries(JOB_EVENT)) {
      expect(sorted(Object.keys(branches.get(kind)!.properties))).toEqual(
        sorted(members),
      );
    }
    expect(
      sorted(Object.keys(branches.get('refused')!.properties.data!.properties)),
    ).toEqual(sorted(REFUSED_DATA));
  });
});
