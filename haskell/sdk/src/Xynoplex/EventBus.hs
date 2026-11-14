-- | A client's own in-process signal plane, separate from the transport's wire.
module Xynoplex.EventBus (EventBus, newEventBus, local, events, closeEventBus) where
import Xynoplex.Internal.Transport
