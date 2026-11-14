module BusMissingScope where
import qualified Xynoplex.Bus as Bus
import Xynoplex.Channels (Channel(..), ScopeArg(..))
import qualified Streaming.Prelude as Stream
wrong :: Bus.Bus -> IO ()
wrong bus = Bus.frames bus MarkAdded NoScope Stream.effects
