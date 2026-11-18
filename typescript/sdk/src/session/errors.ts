/**
 * Session-level error surface: a session's own errors, said on its
 * `errors$` (its sign-in could not be checked or renewed, the gateway
 * refused a token just issued, what its client keeps could not be kept, its
 * storage refused a write of it), which a registry says on
 * `XynologBrowser.error$`, with a session it could not make. Per-request
 * errors stay with the caller as normal Promise rejections.
 *
 * `XynologSessionError` extends `XynologError` (the unified Xynolog base)
 * so consumers can catch with `instanceof XynologError` for any error
 * surfaced through the SDK.
 */

import { XynologError, type XynologSessionErrorCode } from '@xynolog/core';

export class XynologSessionError extends XynologError {
  declare code: XynologSessionErrorCode;
  readonly kbId: string | null;

  constructor(
    code: XynologSessionErrorCode,
    message: string,
    kbId: string | null = null,
  ) {
    super(message, code, { kbId });
    this.name = 'XynologSessionError';
    this.kbId = kbId;
  }
}
