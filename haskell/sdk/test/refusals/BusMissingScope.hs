module BusMissingScope where
import qualified Xynolog.Bus as Bus
import Xynolog.Channels (Channel(..), ScopeArg(..))
import qualified Streaming.Prelude as Stream
wrong :: Bus.Bus -> IO ()
wrong bus = Bus.frames bus MarkAdded NoScope Stream.effects
