module WorkerWrongResult where
import qualified Xynolog.Worker as Worker
import Xynolog.Types (MarkJobResult, YieldJobResult)

wrongResult :: Worker.HeldJob MarkJobResult -> YieldJobResult -> IO ()
wrongResult = Worker.complete
