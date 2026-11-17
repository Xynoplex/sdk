/** The subject a job is published on, under job-storage.ts's root. */

import { JOBS_SUBJECT_ROOT } from './job-storage';

/** The subject a job of this type is published on. */
export function jobSubject(type: string): string {
  return `${JOBS_SUBJECT_ROOT}.${type}`;
}
