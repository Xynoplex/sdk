-- | A lazy operation, consumed once by awaiting its result or following reports.
-- 'withReports' cancels and joins the operation when its consumer leaves scope.
module Xynolog.Running (Running, ConsumptionError(..), await, withReports) where

import Xynolog.Internal.Running
