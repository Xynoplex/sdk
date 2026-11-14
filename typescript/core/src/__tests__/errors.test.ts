import { describe, it, expect } from 'vitest';
import { XynoplexError } from '../errors.js';

describe('@xynoplex/core - errors', () => {
  describe('XynoplexError', () => {
    it('exposes message, code, and details', () => {
      const err = new XynoplexError('boom', 'TEST_CODE', { foo: 'bar' });
      expect(err.message).toBe('boom');
      expect(err.code).toBe('TEST_CODE');
      expect(err.details).toEqual({ foo: 'bar' });
      expect(err.name).toBe('XynoplexError');
    });

    it('details is optional', () => {
      const err = new XynoplexError('msg', 'CODE');
      expect(err.details).toBeUndefined();
    });

    it('is an Error and instanceof XynoplexError', () => {
      const err = new XynoplexError('m', 'c');
      expect(err).toBeInstanceOf(Error);
      expect(err).toBeInstanceOf(XynoplexError);
    });

    it('captures a stack trace', () => {
      const err = new XynoplexError('m', 'c');
      expect(typeof err.stack).toBe('string');
      expect(err.stack).toContain('XynoplexError');
    });
  });
});
