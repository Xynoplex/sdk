module Xynoplex.Bind (BindNamespace, newBind, body, initiate, reportBodyError) where

import Control.Concurrent.STM (STM)
import qualified Xynoplex.Bus as Bus
import Xynoplex.Channels
import Xynoplex.EventBus (EventBus)
import qualified Xynoplex.Internal.Local as Local
import qualified Xynoplex.Timing.Settings as Timing
import Xynoplex.Types

data BindNamespace = BindNamespace Bus.Bus EventBus Timing.Settings
newBind :: Bus.Bus -> EventBus -> Timing.Settings -> BindNamespace
newBind = BindNamespace
body :: BindNamespace -> ResourceId -> AnnotationId -> [BindBodyOperation] -> IO BindBodyUpdated
body (BindNamespace wire _ timing) resource annotation operations =
  Bus.request wire BindUpdateBodyOperation (BindUpdateBodyCommand Nothing annotation operations resource mempty) (Timing.busRequestTimeoutMs timing)
initiate :: BindNamespace -> BindInitiateCommand -> STM ()
initiate (BindNamespace _ bus _) input = Local.signal bus BindInitiate input NoScope
reportBodyError :: BindNamespace -> ResourceErrorEvent -> STM ()
reportBodyError (BindNamespace _ bus _) input = Local.signal bus BindBodyError input NoScope
