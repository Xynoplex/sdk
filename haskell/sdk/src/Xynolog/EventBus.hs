-- | A client's own in-process signal plane, separate from the transport's wire.
module Xynolog.EventBus (EventBus, newEventBus, local, events, closeEventBus) where
import Xynolog.Internal.Transport
