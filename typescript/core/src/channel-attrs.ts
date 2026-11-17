/**
 * A channel's attributes (`CHANNEL_ATTRS`, bus-classification.ts) read by a
 * name that is not yet known to be a channel's.
 */

import { CHANNEL_ATTRS, type ChannelAttrs } from './bus-classification';

const BY_CHANNEL: ReadonlyMap<string, ChannelAttrs> = new Map(Object.entries(CHANNEL_ATTRS));

/** String-keyed accessor for boundary code that has not yet narrowed to
 *  EventName. Undefined means "not a channel", never "unclassified" — the
 *  `satisfies` on CHANNEL_ATTRS makes unclassified unrepresentable. */
export const channelAttrsOf = (channel: string): ChannelAttrs | undefined => BY_CHANNEL.get(channel);

/** Did emitting this channel CHANGE the knowledge base? False for a read, and
 *  for anything nobody emits — both are "no act happened", which is the
 *  question every caller is actually asking. */
export const channelWrites = (channel: string): boolean => BY_CHANNEL.get(channel)?.writes === true;
