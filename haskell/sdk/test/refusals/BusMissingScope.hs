module BusMissingScope where

import qualified Streaming.Prelude as Stream
import qualified Xynolog.Bus as Bus
import Xynolog.Channels (Channel (..), ScopeArg (..))

wrong :: Bus.Bus -> IO ()
wrong bus = Bus.frames bus MarkAdded NoScope Stream.effects
