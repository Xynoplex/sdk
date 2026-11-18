'use client';

import {
  Dialog,
  DialogPanel,
  DialogTitle,
  Transition,
  TransitionChild,
} from '@headlessui/react';
import { useXynolog } from '../../session/XynologProvider';
import { useObservable } from '../../hooks/useObservable';
import { useTranslations } from '../../contexts/TranslationContext';

/**
 * A registered KB's address answered with a DIFFERENT did at activation. By
 * the time this renders, the SDK has already voided the tab list and
 * last-viewed state that claimed to be about the old KB — this modal only
 * TELLS, honestly: the entry the user registered and the identity that
 * answered are two distinct facts, both dids verbatim, and the newcomer is
 * never presented under the registered label. The forward route is the
 * Knowledge Base panel, which owns re-registration; the registry entry itself
 * is left exactly as the user wrote it — it is the evidence.
 *
 * Third member of the signals-modal family (SessionEndedModal,
 * PermissionDeniedModal): reads the active `SessionSignals`, dismiss
 * acknowledges. Like them it is fully translated — new strings go through
 * the census gate.
 *
 * @emits panel:open - Open the knowledge-base panel. Payload: { panel: 'knowledge-base' }
 */
export function KbIdentityConflictModal() {
  const t = useTranslations('KbIdentityConflictModal');
  const xynolog = useXynolog();
  const signals = useObservable(xynolog.activeSignals$);
  const conflict = useObservable(signals?.kbIdentityConflict$) ?? null;
  const kb = useObservable(xynolog.activeSession$)?.kb ?? null;

  if (conflict === null) return null;

  const acknowledge = () => signals?.acknowledgeKbIdentityConflict();
  const handleReview = () => {
    acknowledge();
    xynolog.emit('panel:open', { panel: 'knowledge-base' });
  };

  return (
    <Transition appear show>
      <Dialog as="div" className="xynolog-modal" onClose={acknowledge}>
        <TransitionChild
          enter="ease-out duration-200"
          enterFrom="opacity-0"
          enterTo="opacity-100"
          leave="ease-in duration-150"
          leaveFrom="opacity-100"
          leaveTo="opacity-0"
        >
          <div className="xynolog-modal__backdrop" aria-hidden="true" />
        </TransitionChild>
        <div className="xynolog-modal__container">
          <div className="xynolog-modal__wrapper">
            <TransitionChild
              enter="ease-out duration-200"
              enterFrom="opacity-0 scale-95"
              enterTo="opacity-100 scale-100"
              leave="ease-in duration-150"
              leaveFrom="opacity-100 scale-100"
              leaveTo="opacity-0 scale-95"
            >
              <DialogPanel className="xynolog-modal__panel xynolog-modal__panel--medium">
                <div className="xynolog-modal__content">
                  <DialogTitle className="xynolog-modal__title xynolog-modal__title--centered">
                    {t('title')}
                  </DialogTitle>
                  <div className="xynolog-modal__description">
                    <div className="xynolog-kb-conflict__fact">
                      <span className="xynolog-kb-conflict__fact-label">
                        {t('registeredIdentity')}
                      </span>
                      {kb?.label && (
                        <span className="xynolog-kb-conflict__kb-name">
                          {kb.label}
                        </span>
                      )}
                      <code className="xynolog-kb-conflict__did">
                        {conflict.expectedDid}
                      </code>
                    </div>
                    <div className="xynolog-kb-conflict__fact">
                      <span className="xynolog-kb-conflict__fact-label">
                        {t('answeringNow')}
                      </span>
                      <code className="xynolog-kb-conflict__did">
                        {conflict.observedDid}
                      </code>
                    </div>
                    <p>{t('stateCleared')}</p>
                  </div>
                </div>
                <div className="xynolog-modal__actions">
                  <button
                    type="button"
                    onClick={acknowledge}
                    className="xynolog-button--secondary xynolog-button--flex"
                  >
                    {t('dismiss')}
                  </button>
                  <button
                    type="button"
                    onClick={handleReview}
                    className="xynolog-button--primary xynolog-button--flex"
                  >
                    {t('reviewKnowledgeBases')}
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
