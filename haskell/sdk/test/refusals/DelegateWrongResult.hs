module DelegateWrongResult where
import Xynoplex.Client (Client, yield)
import Xynoplex.Delegation (JobEvent)
import Xynoplex.Running (Running)
import Xynoplex.Types (GenerationJobParams, MarkJobCompleteCommand)
import qualified Xynoplex.Yield as Yield
bad :: Client -> GenerationJobParams -> IO (Running (JobEvent MarkJobCompleteCommand) MarkJobCompleteCommand)
bad client params = Yield.delegate (yield client) params Nothing
