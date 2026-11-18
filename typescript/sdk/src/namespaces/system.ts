/**
 * SystemNamespace — what a knowledge base says about itself. Gateway ops
 * only; no bus.
 *
 * Health and status, and no administration: user management lives at the
 * issuer. Status reports the service's version and features, and health is
 * the liveness probe. A knowledge base's identity and branch are not here:
 * `browse.kb()` answers those (`describeConnection`).
 */

import type {
  HealthCheckResponse,
  IGatewayOperations,
  StatusResponse,
} from '@xynolog/core';
import type { SystemNamespace as ISystemNamespace } from './types';

export class SystemNamespace implements ISystemNamespace {
  constructor(private readonly gateway: IGatewayOperations) {}

  async healthCheck(): Promise<HealthCheckResponse> {
    return this.gateway.healthCheck();
  }

  async status(): Promise<StatusResponse> {
    return this.gateway.getStatus();
  }
}
