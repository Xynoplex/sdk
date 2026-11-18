// openapi-schema.mjs — the spec's component schemas as standard JSON Schema.
//
// The components (protocol/specs/src/components/schemas) are OpenAPI 3.0 schemas, and
// one of 3.0's keywords means something JSON Schema has no keyword for:
// `nullable`. Every generator that reads a component as JSON Schema
// translates it here, in one place:
//
//   - typescript/scripts/generators/generate-validators.mjs, TypeScript's validators (draft-07,
//     through the bundled spec)
//
// `discriminator` is left as it is written: a dispatch hint beside the `oneOf`
// that decides, which is OpenAPI's own meaning for it, and a keyword a JSON
// Schema validator does not know.

/**
 * OpenAPI 3.0 `nullable` → JSON Schema.
 *
 * Two idioms, and BOTH are load-bearing — a generator missing either fails on
 * valid schemas:
 *   - `nullable` beside a string `type` → `type: [original, 'null']`
 *   - `nullable` beside `allOf` → `anyOf: [{type:'null'}, <the rest>]`. This is
 *     3.0's only way to express a nullable `$ref` (a bare `$ref` takes no
 *     siblings).
 * Mutates in place; caller passes a deep clone.
 */
export function convertNullable(obj) {
  if (obj === null || obj === undefined || typeof obj !== 'object') return;
  if (obj.nullable === true) {
    delete obj.nullable;
    if (typeof obj.type === 'string') {
      obj.type = [obj.type, 'null'];
    } else {
      const inner = {};
      for (const key of Object.keys(obj)) {
        inner[key] = obj[key];
        delete obj[key];
      }
      obj.anyOf = [{ type: 'null' }, inner];
    }
  }
  for (const value of Object.values(obj)) {
    if (typeof value === 'object') convertNullable(value);
  }
}

/** `schema` as standard JSON Schema: a deep copy, its `nullable` translated. */
export function translated(schema) {
  const copy = structuredClone(schema);
  convertNullable(copy);
  return copy;
}
