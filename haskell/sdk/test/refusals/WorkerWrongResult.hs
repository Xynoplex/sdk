module WorkerWrongResult where
import qualified Xynoplex.Worker as Worker
import Xynoplex.Types (MarkJobResult, YieldJobResult)

wrongResult :: Worker.HeldJob MarkJobResult -> YieldJobResult -> IO ()
wrongResult = Worker.complete
