/**
 * The languages Xynolog supports, and lookups over them. The table is
 * generated from protocol/specs/src/locales/registry.json.
 */

import { LOCALES, type LocaleInfo } from './locale-registry';

export { LOCALES, LOCALE_CODES } from './locale-registry';
export type { LocaleCode, LocaleInfo } from './locale-registry';

// Create lookup map for efficient access
const localeByCode = new Map<string, LocaleInfo>(
  LOCALES.map((locale) => [locale.code.toLowerCase(), locale]),
);

/**
 * Get locale information by code
 */
export function getLocaleInfo(
  code: string | undefined,
): LocaleInfo | undefined {
  if (!code) return undefined;
  return localeByCode.get(code.toLowerCase());
}

/**
 * Format locale code for display as "Native Name (code)"
 */
export function formatLocaleDisplay(
  code: string | undefined,
): string | undefined {
  if (!code) return undefined;

  const info = getLocaleInfo(code);
  if (!info) return code;

  return `${info.nativeName} (${code.toLowerCase()})`;
}
