/**
 * Invariant A5: gathered context is SDK state, never component state.
 *
 * 1. No `useResourceGather`: a hook of that name holds a GatheredContext in
 *    component-local useState.
 * 2. No source holds a GatheredContext in useState. The page reads the gather
 *    state unit's slots (`context$`, `resourceContext$` and the rest) and
 *    threads props. A component that needs gathered context receives it; one
 *    that needs a gather calls the unit.
 */
export const name = 'gathered context is SDK state, never component state (A5)';

const RULES = [
  ['useResourceGather', 'useResourceGather: a component receives gather state as props'],
  ['useState<GatheredContext', "GatheredContext held in useState: gather state lives in the SDK's units"],
];

export function check(tree) {
  const failures = [];
  for (const file of tree.files.filter((file) => /\.tsx?$/.test(file))) {
    tree.read(file).split('\n').forEach((line, i) => {
      for (const [text, problem] of RULES) {
        if (line.includes(text)) failures.push(`${tree.show(file)}:${i + 1}: ${problem}`);
      }
    });
  }
  return { failures, notes: [] };
}
