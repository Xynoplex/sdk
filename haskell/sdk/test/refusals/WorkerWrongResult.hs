module WorkerWrongResult where

import Xynolog.Types (MarkJobResult, YieldJobResult)
import qualified Xynolog.Worker as Worker

wrongResult :: Worker.HeldJob MarkJobResult -> YieldJobResult -> IO ()
wrongResult = Worker.complete
