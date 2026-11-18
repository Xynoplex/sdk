'use client';

import { useCallback } from 'react';
import type { AnnotationId } from '@xynolog/core';
import { HOVER_DELAY_MS, type XynologSession } from '@xynolog/sdk';
import { useHoverDwell } from './useHoverDwell';

export interface HoverEmitterProps {
  onMouseEnter: () => void;
  onMouseLeave: () => void;
}

/** The pointer's dwell on one annotation's entry, as the entry's mouse handlers. */
export function useHoverEmitter(
  session: XynologSession | null,
  annotationId: AnnotationId,
  hoverDelayMs: number = HOVER_DELAY_MS,
): HoverEmitterProps {
  const dwell = useHoverDwell(session, hoverDelayMs);
  const onMouseEnter = useCallback(
    () => dwell?.enter(annotationId),
    [dwell, annotationId],
  );
  const onMouseLeave = useCallback(() => dwell?.leave(), [dwell]);
  return { onMouseEnter, onMouseLeave };
}
