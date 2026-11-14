import type { Subscription } from 'rxjs';
import type { XynoplexClient } from '../../client';
import { FrameRefusal, type StateUnit } from '@xynoplex/core';

export interface MatchStateUnit extends StateUnit {}

export function createMatchStateUnit(client: XynoplexClient): MatchStateUnit {
  const subs: Subscription[] = [];

  subs.push(client.bus.frames('match:search-requested').subscribe(({ payload: event, correlationId }) => {
    // A request that is not a search's names nothing to search for.
    if (event instanceof FrameRefusal) return;
    const searchSub = client.match.search(
      event.resourceId,
      event.referenceId,
      event.context,
      { limit: event.limit, useSemanticScoring: event.useSemanticScoring },
    ).subscribe({
      next: (result) => client.bus.emit('match:search-results', result, { correlationId }),
      error: (err) => client.bus.emit('match:search-failed', { referenceId: event.referenceId,
        message: err instanceof Error ? err.message : String(err), }, { correlationId }),
    });
    subs.push(searchSub);
  }));

  return {
    dispose() {
      subs.forEach(s => s.unsubscribe());
    },
  };
}
