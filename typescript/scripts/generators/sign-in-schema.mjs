// sign-in-schema.mjs — read and check a flat schema: the stored session of
// protocol/specs/src/session/stored.json, for generate-stored-python.mjs. The
// sign-in store's entry is one too, and codegen/lib/sign_in/flat.ml reads it
// by the same rules.
//
// The schema is flat: every property is a string, some of them a date-time.
// Anything else is refused here, by name, rather than rendered as a guess.

/** A flat schema's title, description, properties and what it requires; `refuse` says what is wrong with it. */
export function readFlatSchema(schema, refuse) {
  const stated = (value) => typeof value === 'string' && value !== '';

  for (const keyword of Object.keys(schema)) {
    if (!['title', 'type', 'description', 'properties', 'required'].includes(keyword)) {
      refuse(`uses \`${keyword}\`, which this generator does not render`);
    }
  }
  if (schema.type !== 'object') refuse('is not an object schema');
  if (!stated(schema.title) || !/^[A-Z][A-Za-z]*$/.test(schema.title)) refuse('has no title that names a type');
  if (!stated(schema.description)) refuse('has no description');
  const properties = Object.entries(schema.properties ?? {});
  if (properties.length === 0) refuse('states no properties');
  const required = schema.required ?? [];
  if (!Array.isArray(required) || required.length === 0) refuse('requires nothing');
  for (const name of required) {
    if (!Object.hasOwn(schema.properties, name)) refuse(`requires \`${name}\`, which is not a property`);
  }

  const fields = properties.map(([name, property]) => {
    if (!/^[a-z][A-Za-z]*$/.test(name)) refuse(`\`${name}\` is not a camelCase property name`);
    for (const keyword of Object.keys(property)) {
      if (!['type', 'format', 'description'].includes(keyword)) {
        refuse(`\`${name}\` uses \`${keyword}\`, which this generator does not render`);
      }
    }
    if (property.type !== 'string') refuse(`\`${name}\` is not a string`);
    if (property.format !== undefined && property.format !== 'date-time') {
      refuse(`\`${name}\` has the format ${JSON.stringify(property.format)}; only date-time is rendered`);
    }
    if (!stated(property.description)) refuse(`\`${name}\` has no description`);
    return { name, description: property.description, isTime: property.format === 'date-time', required: required.includes(name) };
  });

  return { title: schema.title, description: schema.description, fields, required };
}
