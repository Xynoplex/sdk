/**
 * Event Type Guards and Extraction Utilities
 *
 * Domain logic for working with resource events.
 * No React dependencies - safe to use in any JavaScript environment.
 */

import { isAnnotationId, type AnnotationId } from './identifiers';
import { isObject, isString } from './type-guards';
import type { components } from './types';

// =============================================================================
// EVENT TYPE GUARDS AND EXTRACTION
// =============================================================================

/**
 * The annotation a stored event is about, or null when it is about none.
 *
 * A `mark:added` carries the annotation; a `mark:removed` and a
 * `mark:body-updated` name it by id.
 */
export function getAnnotationIdFromEvent(
  event: components['schemas']['StoredEventResponse'],
): AnnotationId | null {
  const payload = event.payload;
  let id: unknown;
  if (event.type === 'mark:added') {
    id = isObject(payload.annotation) ? payload.annotation.id : undefined;
  } else if (
    event.type === 'mark:removed' ||
    event.type === 'mark:body-updated'
  ) {
    id = payload.annotationId;
  }
  return isString(id) && isAnnotationId(id) ? id : null;
}
