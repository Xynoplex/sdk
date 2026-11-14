/**
 * Session-level error surface: a session's own errors, said on its
 * `errors$` (its sign-in could not be checked or renewed, the gateway
 * refused a token just issued, what its client keeps could not be kept, its
 * storage refused a write of it), which a registry says on
 * `XynoplexBrowser.error$`, with a session it could not make. Per-request
 * errors stay with the caller as normal Promise rejections.
 *
 * `XynoplexSessionError` extends `XynoplexError` (the unified Xynoplex base)
 * so consumers can catch with `instanceof XynoplexError` for any error
 * surfaced through the SDK.
 */

import { XynoplexError, type XynoplexSessionErrorCode } from '@xynoplex/core';

export class XynoplexSessionError extends XynoplexError {
  declare code: XynoplexSessionErrorCode;
  readonly kbId: string | null;

  constructor(code: XynoplexSessionErrorCode, message: string, kbId: string | null = null) {
    super(message, code, { kbId });
    this.name = 'XynoplexSessionError';
    this.kbId = kbId;
  }
}
