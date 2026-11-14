module BusWrongPayload where
import qualified Xynoplex.Bus as Bus
import Xynoplex.Channels (Channel(..), ScopeArg(..))
import Xynoplex.Types (BrowseResourceRequest)
wrong :: Bus.Bus -> BrowseResourceRequest -> IO (Maybe Integer)
wrong bus payload = Bus.emit bus BeckonFocus payload NoScope Nothing
