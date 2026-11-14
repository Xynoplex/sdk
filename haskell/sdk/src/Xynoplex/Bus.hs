module Xynoplex.Bus
  ( Bus, BusOptions(..), newBus, emit, frames, request
  , Delivered(..), FrameRefusal(..), Heard(..), Carried(..), Fault(..), FaultReason(..)
  , replyChannelsFor, unsubscribed, persistedEventTypes
  ) where
import Xynoplex.Internal.Bus
