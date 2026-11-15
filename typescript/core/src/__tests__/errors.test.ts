import { describe, it, expect } from 'vitest';
import { XynologError } from '../errors.js';

describe('@xynolog/core - errors', () => {
  describe('XynologError', () => {
    it('exposes message, code, and details', () => {
      const err = new XynologError('boom', 'TEST_CODE', { foo: 'bar' });
      expect(err.message).toBe('boom');
      expect(err.code).toBe('TEST_CODE');
      expect(err.details).toEqual({ foo: 'bar' });
      expect(err.name).toBe('XynologError');
    });

    it('details is optional', () => {
      const err = new XynologError('msg', 'CODE');
      expect(err.details).toBeUndefined();
    });

    it('is an Error and instanceof XynologError', () => {
      const err = new XynologError('m', 'c');
      expect(err).toBeInstanceOf(Error);
      expect(err).toBeInstanceOf(XynologError);
    });

    it('captures a stack trace', () => {
      const err = new XynologError('m', 'c');
      expect(typeof err.stack).toBe('string');
      expect(err.stack).toContain('XynologError');
    });
  });
});
