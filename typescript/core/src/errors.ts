/**
 * The unified Xynolog error hierarchy.
 *
 * `XynologError` is the base every other Xynolog error class extends:
 * `APIError` (http-transport), `BusRequestError` (here, in `bus-request.ts`)
 * and `XynologSessionError` (sdk). Subclasses tighten the `code` field to a
 * literal-union for discriminated handling.
 */

export class XynologError extends Error {
  constructor(
    message: string,
    public code: string,
    public details?: Record<string, unknown>,
  ) {
    super(message);
    this.name = 'XynologError';
    Error.captureStackTrace(this, this.constructor);
  }
}
