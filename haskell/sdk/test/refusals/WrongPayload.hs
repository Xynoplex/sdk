module WrongPayload where
import Data.Aeson (Value)
import qualified Xynoplex.Channels as Channels
value :: Value
value = Channels.encodePayload Channels.BrowseResourceRequested (42 :: Int)
