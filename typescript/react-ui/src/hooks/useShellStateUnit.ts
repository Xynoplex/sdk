'use client';

import {
  createShellStateUnit,
  type ShellStateUnit,
  type ToolbarPanelType,
} from '../state/shell-state-unit';
import { useXynolog } from '../session/XynologProvider';
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
 * the `XynologBrowser`'s own bus. Unlike session-scoped VMs, this hook
 * does not need to wait for an active KB session; `useXynolog()`
 * always returns the module-scoped `XynologBrowser` singleton.
 */
export function useShellStateUnit(): ShellStateUnit {
  const xynolog = useXynolog();
  return useStateUnit(() =>
    createShellStateUnit(xynolog, {
      initialPanel: readPanel(),
      onPanelChange: persistPanel,
    }),
  );
}
