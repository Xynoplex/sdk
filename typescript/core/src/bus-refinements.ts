/**
 * What TypeScript adds to the payloads the bus registry states.
 *
 * Identifier discipline: where a payload carries an annotation or
 * resource id, the TypeScript layer narrows the OpenAPI `string` to the
 * branded type (`AnnotationId`, `ResourceId`, `UserId`). The runtime
 * wire shape is unchanged (brands have no runtime representation);
 * what this buys us is that command handlers don't have to re-brand
 * at every seam. Brand once at the entry boundary (HTTP route handler,
 * DOM attribute read, URL param parse), not at every bus hop in
 * between.
 *
 * `EventMap` (bus-protocol.ts) is each channel's stated payload with the
 * channel's refinement here in its place, and the persisted-event catalog
 * (persisted-events.ts) each event's payload with its refinement here.
 * Each refinement narrows the type it replaces, and names a channel or an
 * event of the registry: __tests__/bus-refinements.test.ts holds both.
 */

import type { components } from './types';
import type { AnnotationId, ResourceId } from './identifiers';
import type { Annotation } from './annotation-types';
import type { ResourceDescriptor } from './graph';
import type { AnchorRect } from './bus-ui-types';

type Schemas = components['schemas'];

/**
 * Each channel whose payload this layer narrows, and the payload it is.
 *
 * `_userId` is the gateway-injected authenticated DID (string at the
 * schema layer); handlers that need a `UserId` brand it locally.
 */
export type ChannelRefinements = {
  'mark:delete': Schemas['MarkDeleteCommand'] & {
    annotationId: AnnotationId;
    resourceId?: ResourceId;
  };
  'mark:update-body': Schemas['MarkUpdateBodyCommand'] & {
    annotationId: AnnotationId;
    resourceId: ResourceId;
  };
  'bind:initiate': Schemas['BindInitiateCommand'] & {
    annotationId: AnnotationId;
    resourceId: ResourceId;
  };
  'bind:update-body': Schemas['BindUpdateBodyCommand'] & {
    annotationId: AnnotationId;
    resourceId: ResourceId;
  };
  'match:resources-result': {
    response: Omit<Schemas['MatchResourcesResponse'], 'resources'> & {
      resources: ResourceDescriptor[];
    };
  };
  'browse:resource-result': {
    response: Omit<Schemas['BrowseResourceResult']['response'], 'resource'> & {
      resource: ResourceDescriptor;
    };
  };
  'browse:resources-result': {
    response: Omit<Schemas['ListResourcesResponse'], 'resources'> & {
      resources: ResourceDescriptor[];
    };
  };
  'browse:annotation-result': {
    response: Omit<
      Schemas['GetAnnotationResponse'],
      'annotation' | 'resource' | 'resolvedResource'
    > & {
      annotation: Annotation;
      resource: ResourceDescriptor | null;
      resolvedResource: ResourceDescriptor | null;
    };
  };
  'browse:click': Schemas['BrowseClickEvent'] & { anchorRect?: AnchorRect };
  'panel:open': Schemas['BrowsePanelOpenEvent'] & { anchorRect?: AnchorRect };
  'nav:external': Schemas['BrowseExternalNavigateEvent'] & {
    cancelFallback: () => void;
  };
};

/** Each persisted event whose payload this layer narrows, and the payload it is. */
export type EventPayloadRefinements = {
  'mark:added': Schemas['AnnotationAddedPayload'] & { annotation: Annotation };
  'mark:removed': Schemas['AnnotationRemovedPayload'] & {
    annotationId: AnnotationId;
  };
  'mark:body-updated': Schemas['AnnotationBodyUpdatedPayload'] & {
    annotationId: AnnotationId;
  };
};
