-- | A lazy operation, consumed once by awaiting its result or following reports.
-- 'withReports' cancels and joins the operation when its consumer leaves scope.
module Xynoplex.Running (Running, ConsumptionError(..), await, withReports) where

import Xynoplex.Internal.Running
