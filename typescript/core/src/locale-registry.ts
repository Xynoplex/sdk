// ⚠ GENERATED FILE — do not edit.
//
// Authority:   protocol/specs/src/locales/registry.json
// Regenerate:  make generate  (codegen/lib/locales/locales.ml)

/** The code of every supported language, in the registry's order. */
export const LOCALE_CODES = ['ar', 'bn', 'cs', 'da', 'de', 'el', 'en', 'es', 'fa', 'fi', 'fr', 'he', 'hi', 'id', 'it', 'ja', 'ko', 'ms', 'nl', 'no', 'pl', 'pt', 'ro', 'sv', 'th', 'tr', 'uk', 'vi', 'zh'] as const;

/** The code of a supported language. */
export type LocaleCode = (typeof LOCALE_CODES)[number];

/** A supported language: its code, what it calls itself, and its name in English. */
export interface LocaleInfo {
  code: LocaleCode;
  nativeName: string;
  englishName: string;
}

/** A row per supported language, in the registry's order. */
export const LOCALES: readonly LocaleInfo[] = [
  { code: 'ar', nativeName: 'العربية', englishName: 'Arabic' },
  { code: 'bn', nativeName: 'বাংলা', englishName: 'Bengali' },
  { code: 'cs', nativeName: 'Čeština', englishName: 'Czech' },
  { code: 'da', nativeName: 'Dansk', englishName: 'Danish' },
  { code: 'de', nativeName: 'Deutsch', englishName: 'German' },
  { code: 'el', nativeName: 'Ελληνικά', englishName: 'Greek' },
  { code: 'en', nativeName: 'English', englishName: 'English' },
  { code: 'es', nativeName: 'Español', englishName: 'Spanish' },
  { code: 'fa', nativeName: 'فارسی', englishName: 'Persian' },
  { code: 'fi', nativeName: 'Suomi', englishName: 'Finnish' },
  { code: 'fr', nativeName: 'Français', englishName: 'French' },
  { code: 'he', nativeName: 'עברית', englishName: 'Hebrew' },
  { code: 'hi', nativeName: 'हिन्दी', englishName: 'Hindi' },
  { code: 'id', nativeName: 'Bahasa Indonesia', englishName: 'Indonesian' },
  { code: 'it', nativeName: 'Italiano', englishName: 'Italian' },
  { code: 'ja', nativeName: '日本語', englishName: 'Japanese' },
  { code: 'ko', nativeName: '한국어', englishName: 'Korean' },
  { code: 'ms', nativeName: 'Bahasa Melayu', englishName: 'Malay' },
  { code: 'nl', nativeName: 'Nederlands', englishName: 'Dutch' },
  { code: 'no', nativeName: 'Norsk', englishName: 'Norwegian' },
  { code: 'pl', nativeName: 'Polski', englishName: 'Polish' },
  { code: 'pt', nativeName: 'Português', englishName: 'Portuguese' },
  { code: 'ro', nativeName: 'Română', englishName: 'Romanian' },
  { code: 'sv', nativeName: 'Svenska', englishName: 'Swedish' },
  { code: 'th', nativeName: 'ไทย', englishName: 'Thai' },
  { code: 'tr', nativeName: 'Türkçe', englishName: 'Turkish' },
  { code: 'uk', nativeName: 'Українська', englishName: 'Ukrainian' },
  { code: 'vi', nativeName: 'Tiếng Việt', englishName: 'Vietnamese' },
  { code: 'zh', nativeName: '中文', englishName: 'Chinese' },
];
