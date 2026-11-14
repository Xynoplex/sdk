/**
 * The unified Xynoplex error hierarchy.
 *
 * `XynoplexError` is the base every other Xynoplex error class extends:
 * `APIError` (http-transport), `BusRequestError` (here, in `bus-request.ts`)
 * and `XynoplexSessionError` (sdk). Subclasses tighten the `code` field to a
 * literal-union for discriminated handling.
 */

export class XynoplexError extends Error {
  constructor(
    message: string,
    public code: string,
    public details?: Record<string, unknown>,
  ) {
    super(message);
    this.name = 'XynoplexError';
    Error.captureStackTrace(this, this.constructor);
  }
}
