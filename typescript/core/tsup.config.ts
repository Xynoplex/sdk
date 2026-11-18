import { defineConfig } from 'tsup';

export default defineConfig({
  // Silenced: tsup lists every emitted artifact, and with `splitting` plus
  // `sourcemap` that is ~2 lines per chunk — react-ui alone printed ~88 for a
  // 619ms build. Failures still fail the command; build.sh prints the per-package
  // check mark. Drop this line temporarily when you want the size column.
  silent: true,
  // Two test-only subpaths, split so the optional `fast-check` peer is really
  // optional:
  //   `src/testing.ts`        → `@xynolog/core/testing`        — doubles, fc-FREE
  //   `src/testing/axioms.ts` → `@xynolog/core/testing/axioms` — needs fc
  // `fast-check` is externalized either way (consumers provide it), and neither
  // enters the runtime `.` entry, which imports no testing module.
  entry: [
    'src/index.ts',
    // `@xynolog/core/openapi` — the spec's limits.
    'src/openapi.ts',
    'src/testing.ts',
    'src/testing/axioms.ts',
    // `@xynolog/core/testing/issuer` — the in-process OIDC issuer double. Its
    // own entry so neither `.` nor the `testing` barrel pulls `jose` in behind it.
    // `typescript/core/scripts/check-core-subpath-isolation.mjs` fails if `.` re-exports it.
    'src/testing/issuer.ts',
  ],
  external: ['fast-check'],
  format: ['esm'],
  dts: false,
  clean: true,
  sourcemap: true,
  // REQUIRED, not cosmetic: both testing entries pull `faulty-transport`, and
  // without splitting each bundle gets its OWN class copy — a consumer that
  // spies on `FaultyTransport.prototype` from one entry would miss the
  // instance the other constructs. The sdk hit exactly this (its `dist/
  // testing.js` held private copies and prototype spies silently missed).
  splitting: true,
  treeshake: true,
});
