#!/usr/bin/env node
/**
 * xynolog-react-ui-check <source-directory>
 *
 * Holds a source directory to react-ui's rules: react-ui's own `src`, or the
 * source of an app that uses react-ui. Each gate reads the files git says the
 * directory holds, so git is needed where this runs. The hooks-ordering gate
 * parses TypeScript with the `typescript` package, the host's own.
 *
 * Every gate runs; the exit status is 1 when any of them fails, and 2 when
 * the command is not given one directory that holds source, or a gate cannot
 * run.
 */
import * as cssClasses from './css-classes.mjs';
import * as cssVariables from './css-variables.mjs';
import * as gatheredContext from './gathered-context.mjs';
import * as hooksOrdering from './hooks-ordering.mjs';
import * as sessionStateUnits from './session-state-units.mjs';
import { sourceTree } from './source-tree.mjs';
import * as toolbarPrefs from './toolbar-prefs.mjs';

const GATES = [gatheredContext, sessionStateUnits, hooksOrdering, toolbarPrefs, cssVariables, cssClasses];

const args = process.argv.slice(2);
if (args.length !== 1 || args[0].startsWith('-')) {
  console.error('Usage: xynolog-react-ui-check <source-directory>');
  process.exit(2);
}

let tree;
try {
  tree = sourceTree(args[0]);
} catch (error) {
  console.error(`xynolog-react-ui-check: ${error.message}`);
  process.exit(2);
}

console.log(`Checking ${tree.show('') || '.'} as ${tree.own ? "react-ui's own source" : 'the source of an app that uses react-ui'}`);
let failed = false;
for (const gate of GATES) {
  let result;
  try {
    result = await gate.check(tree);
  } catch (error) {
    console.error(`xynolog-react-ui-check: ${gate.name}: ${error.message}`);
    process.exit(2);
  }
  const { failures, notes } = result;
  if (failures.length === 0) {
    console.log(`✅ ${gate.name}`);
  } else {
    failed = true;
    console.error(`\n❌ ${gate.name}:\n`);
    for (const failure of failures) console.error(`  ${failure}`);
    console.error('');
  }
  for (const note of notes) console.log(`   ${note}`);
}
process.exit(failed ? 1 : 0);
