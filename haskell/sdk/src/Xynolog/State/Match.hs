{-# LANGUAGE OverloadedStrings #-}
-- | Run correlated matching requests on the client's signal plane.
module Xynolog.State.Match (MatchStateUnit, newMatchStateUnit, dispose) where

import Control.Concurrent.STM (atomically)
import Control.Exception (catches, Handler(..))
import Data.Aeson (Value(..))
import Data.Text (Text)
import qualified Xynolog.Client as Client
import Xynolog.Channels
import Xynolog.Errors (BusRequestError(..), TransportError(..))
import qualified Xynolog.Internal.Local as Local
import qualified Xynolog.Internal.StateTasks as Tasks
import qualified Xynolog.Internal.Transport as Transport
import qualified Xynolog.Match as Match
import qualified Xynolog.Running as Running
import Xynolog.Types hiding (MatchSearchFailed)
import qualified Xynolog.Types as Types

newtype MatchStateUnit = MatchStateUnit Tasks.Tasks
newMatchStateUnit :: Client.Client -> IO MatchStateUnit
newMatchStateUnit client = do
  tasks <- Tasks.newTasks "match state unit is closed"
  Tasks.listen tasks (Client.bus client) [channelName MatchSearchRequested] $ \frame -> do
    let envelope=Transport.wireFrame frame
    case decodePayload MatchSearchRequested (Object (busFramePayloadAdditionalProperties (busFramePayload envelope))) of
      Left _ -> pure ()
      Right input -> Tasks.fork tasks $ do
        let reply :: Text -> IO ()
            reply message=atomically (Local.signalWithCorrelation (Client.bus client) MatchSearchFailed
              (Types.MatchSearchFailed Nothing Nothing message (matchSearchRequestReferenceId input) mempty) NoScope (busFrameCorrelationId envelope))
            work=do
              found <- Match.search (Client.match client) (matchSearchRequestResourceId input) (matchSearchRequestReferenceId input)
                (matchSearchRequestContext input) (Just (MatchSearchOptions (matchSearchRequestLimit input) (matchSearchRequestUseSemanticScoring input) (matchSearchRequestAdditionalProperties input))) >>= Running.await
              atomically (Local.signalWithCorrelation (Client.bus client) MatchSearchResults found NoScope (busFrameCorrelationId envelope))
        work `catches` [Handler (reply . busRequestErrorMessage),Handler (reply . transportErrorMessage)]
  pure (MatchStateUnit tasks)
dispose :: MatchStateUnit -> IO ()
dispose (MatchStateUnit tasks) = Tasks.dispose tasks
