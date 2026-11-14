'use client';

import { Dialog, DialogPanel, DialogTitle, Transition, TransitionChild } from '@headlessui/react';
import { useXynoplex } from '../../session/XynoplexProvider';
import { useObservable } from '../../hooks/useObservable';
import { useTranslations } from '../../contexts/TranslationContext';

/**
 * Modal that surfaces when a 403 forbidden error is reported via
 * the active session's `signals.notifyPermissionDenied(...)`.
 *
 * Its own copy is in the person's language. Beneath it is the refusal's own
 * message, unaltered and marked as the knowledge base's: it is the only part
 * that names what was refused, and a client cannot translate it.
 *
 * Reads `permissionDenied$` from the active `SessionSignals`. The signals instance clears the
 * flag when the user dismisses the modal. Modal state lives on
 * signals (not the session itself) so headless sessions
 * (workers/CLIs) don't carry dead observables.
 */
export function PermissionDeniedModal() {
  const t = useTranslations('PermissionDeniedModal');
  const signals = useObservable(useXynoplex().activeSignals$);
  const permissionDenied = useObservable(signals?.permissionDenied$) ?? null;
  const acknowledgePermissionDenied = () => signals?.acknowledgePermissionDenied();
  const showModal = permissionDenied !== null;
  const detail = permissionDenied?.detail ?? null;

  const handleGoBack = () => {
    acknowledgePermissionDenied();
    window.history.back();
  };

  const handleGoHome = () => {
    acknowledgePermissionDenied();
    window.location.href = '/';
  };

  const handleSwitchAccount = () => {
    acknowledgePermissionDenied();
    window.location.href = `/auth/connect?callbackUrl=${encodeURIComponent(window.location.pathname)}`;
  };

  return (
    <Transition appear show={showModal}>
      <Dialog as="div" className="xynoplex-modal" onClose={handleGoBack}>
        <TransitionChild
          enter="ease-out duration-200"
          enterFrom="opacity-0"
          enterTo="opacity-100"
          leave="ease-in duration-150"
          leaveFrom="opacity-100"
          leaveTo="opacity-0"
        >
          <div className="xynoplex-modal__backdrop" />
        </TransitionChild>

        <div className="xynoplex-modal__container">
          <div className="xynoplex-modal__wrapper">
            <TransitionChild
              enter="ease-out duration-200"
              enterFrom="opacity-0 scale-95"
              enterTo="opacity-100 scale-100"
              leave="ease-in duration-150"
              leaveFrom="opacity-100 scale-100"
              leaveTo="opacity-0 scale-95"
            >
              <DialogPanel className="xynoplex-modal__panel xynoplex-modal__panel--medium">
                <div className="xynoplex-modal__icon-wrapper">
                  <div className="xynoplex-modal__icon">
                    <svg style={{ width: '1.5rem', height: '1.5rem', color: 'var(--xynoplex-color-amber-600, #d97706)' }} fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                      <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z" />
                    </svg>
                  </div>
                </div>

                <div className="xynoplex-modal__content">
                  <DialogTitle className="xynoplex-modal__title xynoplex-modal__title--centered">
                    {t('title')}
                  </DialogTitle>
                </div>

                <div style={{
                  padding: '0.75rem',
                  backgroundColor: 'var(--xynoplex-bg-secondary)',
                  borderRadius: 'var(--xynoplex-radius-md, 0.375rem)',
                  border: '1px solid var(--xynoplex-border-primary)',
                  fontSize: 'var(--xynoplex-text-sm, 0.875rem)',
                  marginBottom: '1rem',
                }}>
                  <p style={{ color: 'var(--xynoplex-text-secondary)', marginBottom: '0.5rem' }}>
                    {t('reasonsIntro')}
                  </p>
                  <ul style={{
                    listStyle: 'disc',
                    listStylePosition: 'inside',
                    color: 'var(--xynoplex-text-tertiary)',
                    display: 'flex',
                    flexDirection: 'column',
                    gap: '0.25rem',
                  }}>
                    <li>{t('reasonPermissions')}</li>
                    <li>{t('reasonRestricted')}</li>
                    <li>{t('reasonAccountType')}</li>
                  </ul>
                </div>

                {detail !== null && (
                  <figure style={{
                    margin: '0 0 1rem',
                    fontSize: 'var(--xynoplex-text-sm, 0.875rem)',
                  }}>
                    <figcaption style={{ color: 'var(--xynoplex-text-secondary)', marginBottom: '0.25rem' }}>
                      {t('detailLabel')}
                    </figcaption>
                    <blockquote style={{
                      margin: 0,
                      paddingLeft: '0.75rem',
                      borderLeft: '2px solid var(--xynoplex-border-primary)',
                      color: 'var(--xynoplex-text-primary)',
                    }}>
                      {detail}
                    </blockquote>
                  </figure>
                )}

                <div className="xynoplex-modal__actions">
                  <button
                    type="button"
                    onClick={handleGoBack}
                    className="xynoplex-button--primary xynoplex-button--flex"
                  >
                    {t('goBack')}
                  </button>
                  <button
                    type="button"
                    onClick={handleGoHome}
                    className="xynoplex-button--secondary xynoplex-button--flex"
                  >
                    {t('goHome')}
                  </button>
                </div>
                <div className="xynoplex-modal__actions" style={{ marginTop: '0.5rem', paddingTop: '0.5rem', borderTop: '1px solid var(--xynoplex-border-primary)' }}>
                  <button
                    type="button"
                    onClick={handleSwitchAccount}
                    className="xynoplex-button--secondary xynoplex-button--flex"
                    style={{ fontSize: 'var(--xynoplex-text-sm, 0.875rem)' }}
                  >
                    {t('switchAccount')}
                  </button>
                </div>
              </DialogPanel>
            </TransitionChild>
          </div>
        </div>
      </Dialog>
    </Transition>
  );
}
