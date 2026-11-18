module BusWrongPayload where

import qualified Xynolog.Bus as Bus
import Xynolog.Channels (Channel (..), ScopeArg (..))
import Xynolog.Types (BrowseResourceRequest)

wrong :: Bus.Bus -> BrowseResourceRequest -> IO (Maybe Integer)
wrong bus payload = Bus.emit bus BeckonFocus payload NoScope Nothing
