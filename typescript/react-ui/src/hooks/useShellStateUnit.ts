'use client';

import { createShellStateUnit, type ShellStateUnit, type ToolbarPanelType } from '../state/shell-state-unit';
import { useXynoplex } from '../session/XynoplexProvider';
import { useStateUnit } from './useStateUnit';

function readPanel(): ToolbarPanelType | null {
  if (typeof window === 'undefined') return null;
  const saved = localStorage.getItem('activeToolbarPanel');
  return (saved as ToolbarPanelType) || 'knowledge-base';
}

function persistPanel(panel: ToolbarPanelType | null): void {
  if (typeof window === 'undefined') return;
  if (panel) localStorage.setItem('activeToolbarPanel', panel);
  else localStorage.removeItem('activeToolbarPanel');
}

/**
 * `ShellStateUnit` is app-scoped — it owns toolbar panel state and lives on
 * the `XynoplexBrowser`'s own bus. Unlike session-scoped VMs, this hook
 * does not need to wait for an active KB session; `useXynoplex()`
 * always returns the module-scoped `XynoplexBrowser` singleton.
 */
export function useShellStateUnit(): ShellStateUnit {
  const xynoplex = useXynoplex();
  return useStateUnit(() => createShellStateUnit(xynoplex, {
    initialPanel: readPanel(),
    onPanelChange: persistPanel,
  }));
}
