'use client';

import React, { useEffect } from 'react';
import { LOCALES } from '@xynolog/core';
import { useTranslations } from '../../contexts/TranslationContext';
import { useLanguageChangeAnnouncements } from '../LiveRegion';
import { useXynolog } from '../../session/XynologProvider';
import { useLineNumbers } from '../../contexts/LineNumbersContext';
import './SettingsPanel.css';

interface SettingsPanelProps {
  theme: 'light' | 'dark' | 'system';
  locale: string;
  isPendingLocaleChange?: boolean;
  hoverDelayMs: number;
  /**
   * What the About section shows and links to.
   *
   * REQUIRED, not optional: react-ui cannot know the host's build version or
   * reach its keyboard-shortcuts context, so the host must answer — and there
   * is exactly one host (ToolbarPanels). An optional prop here would be a seam
   * with nothing behind it.
   */
  version: string;
  sourceCodeUrl: string;
  onOpenKeyboardHelp: () => void;
}

/**
 * Settings panel for application preferences
 *
 * @emits settings:locale-changed - Locale changed by user. Payload: { locale: string }
 * @emits settings:line-numbers-toggled - Line numbers toggled on/off. Payload: undefined
 * @emits settings:theme-changed - Theme changed by user. Payload: { theme: 'light' | 'dark' | 'system' }
 * @emits settings:hover-delay-changed - Hover delay changed by user. Payload: { hoverDelayMs: number }
 */
export function SettingsPanel({
  theme,
  locale,
  isPendingLocaleChange = false,
  hoverDelayMs,
  version,
  sourceCodeUrl,
  onOpenKeyboardHelp
}: SettingsPanelProps) {
  const t = useTranslations('Settings');
  const xynolog = useXynolog();
  // The switch renders the SHARED line-numbers state, not a prop snapshot:
  // its toggle is applied by a bus subscriber in ToolbarPanels, so a prop
  // fed from any per-route source is a second copy that never updates.
  const { showLineNumbers } = useLineNumbers();
  const { announceLanguageChanging, announceLanguageChanged } = useLanguageChangeAnnouncements();

  // Track previous locale to detect changes
  const [previousLocale, setPreviousLocale] = React.useState(locale);

  // Handle language change with announcement
  const handleLocaleChange = (newLocale: string) => {
    const localeName = LOCALES.find(l => l.code === newLocale)?.nativeName || newLocale;
    announceLanguageChanging(localeName);
    xynolog.emit('settings:locale-changed', { locale: newLocale });
  };

  // Announce when language has successfully changed
  useEffect(() => {
    if (locale !== previousLocale && !isPendingLocaleChange) {
      const localeName = LOCALES.find(l => l.code === locale)?.nativeName || locale;
      announceLanguageChanged(localeName);
      setPreviousLocale(locale);
    }
  }, [locale, previousLocale, isPendingLocaleChange]);

  return (
    <div className="xynolog-settings-panel">
      <h3 className="xynolog-settings-panel__title">
        {t('title')}
      </h3>

      <div className="xynolog-settings-panel__content">
        {/* Line Numbers Toggle */}
        <div className="xynolog-settings-panel__field">
          <label className="xynolog-toggle-label">
            <span className="xynolog-toggle-label__text">
              {t('lineNumbers')}
            </span>
            <button
              type="button"
              role="switch"
              aria-checked={showLineNumbers}
              onClick={() => xynolog.emit('settings:line-numbers-toggled', undefined)}
              className={`xynolog-toggle ${
                showLineNumbers ? 'xynolog-toggle--active' : ''
              }`}
            >
              <span
                className={`xynolog-toggle__slider ${
                  showLineNumbers ? 'xynolog-toggle__slider--active' : ''
                }`}
              />
            </button>
          </label>
          <p className="xynolog-form__help">
            {showLineNumbers ? t('lineNumbersVisible') : t('lineNumbersHidden')}
          </p>
        </div>

        {/* Theme Selection */}
        <div className="xynolog-settings-panel__field">
          <label className="xynolog-form__label">
            {t('theme')}
          </label>
          <div className="xynolog-settings-panel__button-group">
            <button
              onClick={() => xynolog.emit('settings:theme-changed', { theme: 'light' })}
              className={`xynolog-panel-button ${
                theme === 'light' ? 'xynolog-panel-button-active' : ''
              }`}
              aria-pressed={theme === 'light'}
            >
              ☀️ {t('themeLight')}
            </button>
            <button
              onClick={() => xynolog.emit('settings:theme-changed', { theme: 'dark' })}
              className={`xynolog-panel-button ${
                theme === 'dark' ? 'xynolog-panel-button-active' : ''
              }`}
              aria-pressed={theme === 'dark'}
            >
              🌙 {t('themeDark')}
            </button>
            <button
              onClick={() => xynolog.emit('settings:theme-changed', { theme: 'system' })}
              className={`xynolog-panel-button ${
                theme === 'system' ? 'xynolog-panel-button-active' : ''
              }`}
              aria-pressed={theme === 'system'}
            >
              💻 {t('themeSystem')}
            </button>
          </div>
          <p className="xynolog-form__help" aria-live="polite">
            {theme === 'system'
              ? t('themeSystemActive')
              : t('themeModeActive', { mode: theme.charAt(0).toUpperCase() + theme.slice(1) })}
          </p>
        </div>

        {/* Language Selection */}
        <div className="xynolog-settings-panel__field">
          <label htmlFor="language-select" className="xynolog-form__label">
            {t('language')}
          </label>
          <select
            id="language-select"
            value={locale}
            onChange={(e) => handleLocaleChange(e.target.value)}
            disabled={isPendingLocaleChange}
            className="xynolog-select"
            aria-busy={isPendingLocaleChange}
            aria-describedby="language-hint"
          >
            {LOCALES.map((lang) => (
              <option key={lang.code} value={lang.code}>
                {lang.nativeName}
              </option>
            ))}
          </select>
          <p id="language-hint" className="xynolog-form__help">
            {t('languageHint')}
          </p>
          {isPendingLocaleChange && (
            <p className="xynolog-settings-panel__loading" role="status" aria-live="polite">
              {t('languageChanging')}
            </p>
          )}
        </div>

        {/* Hover Delay Slider */}
        <div className="xynolog-settings-panel__field">
          <label htmlFor="hover-delay-slider" className="xynolog-form__label">
            {t('hoverDelay')}
          </label>
          <input
            id="hover-delay-slider"
            type="range"
            min="0"
            max="500"
            step="50"
            value={hoverDelayMs}
            onChange={(e) => xynolog.emit('settings:hover-delay-changed', { hoverDelayMs: Number(e.target.value) })}
            className="xynolog-slider"
            aria-describedby="hover-delay-description"
          />
          <div className="xynolog-slider__labels">
            <span>{t('hoverDelayFast')}</span>
            <span>{t('hoverDelaySlow')}</span>
          </div>
          <p id="hover-delay-description" className="xynolog-form__help">
            {t('hoverDelayDescription', { delay: hoverDelayMs })}
          </p>
        </div>

        {/* About */}
        <div className="xynolog-settings-panel__field xynolog-settings-panel__about">
          <h4 className="xynolog-settings-panel__about-name">Xynolog</h4>
          <p className="xynolog-settings-panel__about-tagline">{t('tagline')}</p>
          <p className="xynolog-settings-panel__about-version">
            {t('version', { version })}
          </p>
          <div className="xynolog-settings-panel__about-links">
            <button
              type="button"
              onClick={onOpenKeyboardHelp}
              className="xynolog-settings-panel__about-link"
            >
              {t('keyboardShortcuts')}
            </button>
            <a
              href={sourceCodeUrl}
              target="_blank"
              rel="noopener noreferrer"
              className="xynolog-settings-panel__about-link"
            >
              {t('sourceCode')}
            </a>
          </div>
        </div>
      </div>
    </div>
  );
}