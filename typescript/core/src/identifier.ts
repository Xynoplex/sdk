/**
 * What the kinds of id share (identifiers.ts declares each): text held to the
 * kind's rule, which is its schema's pattern, wherever it is made.
 */

/** A kind of id: whether text is one, and text as one. */
export interface IdentifierKind<Id extends string> {
  readonly is: (value: string) => value is Id;
  readonly of: (value: string) => Id;
}

/** The kind named `name` whose rule is `pattern`, matched against the whole text. */
export function identifierKind<Id extends string>(name: string, pattern: string): IdentifierKind<Id> {
  const rule = new RegExp(pattern, 'u');
  const is = (value: string): value is Id => rule.test(value);
  return {
    is,
    of: (value) => {
      if (!is(value)) {
        throw new TypeError(`${JSON.stringify(value)} is not a ${name}: it does not match ${rule.source}`);
      }
      return value;
    },
  };
}
