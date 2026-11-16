/**
 * Session-bound state units are made with `useSessionStateUnit`, never with
 * `useStateUnit` and a non-null-asserted client.
 *
 * A state unit's factory takes the lifetime it must not outlive, a
 * `XynologSession`. `useSessionStateUnit` makes the unit only under a live
 * session and makes it again, disposing the old one first, when the session
 * changes. A `!` on a client or session inside a factory call is the sign of a
 * call site that makes its unit outside that guarantee, and it crashes a page
 * rendered with no session.
 *
 * 1. No `!`-asserted name on a `useStateUnit` or `useSessionStateUnit` call's
 *    line (`createX(xynolog!, …)`).
 * 2. `useStateUnit(` only in react-ui's own two hooks whose units outlive any
 *    session: the hook itself, and the shell's, which spans sessions. A host
 *    has no such unit of its own.
 *
 * Tests are not read.
 */
export const name = 'session-bound state units are made with useSessionStateUnit';

const SESSIONLESS = new Set(['hooks/useStateUnit.ts', 'hooks/useShellStateUnit.ts']);

export function check(tree) {
  const failures = [];
  for (const file of tree.files.filter((file) => /\.tsx?$/.test(file) && !file.includes('__tests__'))) {
    tree.read(file).split('\n').forEach((line, i) => {
      const site = `${tree.show(file)}:${i + 1}`;
      if (/use(Session)?StateUnit\(/.test(line) && /[A-Za-z_]+!(,|\.|\))/.test(line)) {
        failures.push(`${site}: a non-null-asserted client or session inside a state unit's factory call`);
      }
      if (/useStateUnit\(/.test(line) && !line.includes('useSessionStateUnit(') && !(tree.own && SESSIONLESS.has(file))) {
        failures.push(`${site}: useStateUnit( makes a unit no session bounds; a session-bound unit uses useSessionStateUnit`);
      }
    });
  }
  return { failures, notes: [] };
}
