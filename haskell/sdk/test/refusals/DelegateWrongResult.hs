module DelegateWrongResult where

import Xynolog.Client (Client, yield)
import Xynolog.Delegation (JobEvent)
import Xynolog.Running (Running)
import Xynolog.Types (GenerationJobParams, MarkJobCompleteCommand)
import qualified Xynolog.Yield as Yield

bad :: Client -> GenerationJobParams -> IO (Running (JobEvent MarkJobCompleteCommand) MarkJobCompleteCommand)
bad client params = Yield.delegate (yield client) params Nothing
