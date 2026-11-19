/**
 * The translations directory, held to the locale registry: a file for every
 * code in `LOCALE_CODES` and for no other, and every file with exactly the
 * keys `en.json` has, so a string added in English and in no other language
 * fails here and not in front of a reader of that language.
 */
import { describe, it, expect } from 'vitest';
import { readdirSync, readFileSync } from 'node:fs';
import { resolve } from 'node:path';
import { LOCALE_CODES } from '@xynolog/core';

const DIRECTORY = resolve(__dirname, '../../../translations');

/** The dotted name of every string a translation file holds. */
function keysOf(messages: unknown, within = ''): string[] {
  if (typeof messages !== 'object' || messages === null) return [within];
  return Object.entries(messages).flatMap(([name, held]) =>
    keysOf(held, within === '' ? name : `${within}.${name}`),
  );
}

const keysIn = (code: string): string[] =>
  keysOf(
    JSON.parse(readFileSync(resolve(DIRECTORY, `${code}.json`), 'utf8')),
  ).sort();

describe('the translations directory', () => {
  it('holds a file for every locale code and for no other', () => {
    const files = readdirSync(DIRECTORY).sort();
    expect(files).toEqual(LOCALE_CODES.map((code) => `${code}.json`).sort());
  });

  const english = keysIn('en');

  it.each(LOCALE_CODES.filter((code) => code !== 'en'))(
    '%s holds exactly the keys en.json holds',
    (code) => {
      expect(keysIn(code)).toEqual(english);
    },
  );
});
