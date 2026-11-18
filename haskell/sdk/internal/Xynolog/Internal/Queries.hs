module Xynolog.Internal.Queries (cacheOptions, oneReport) where

import Xynolog.Bus qualified as Bus
import Xynolog.Internal.Cache qualified as Cache
import Xynolog.Internal.Running qualified as Running
import Xynolog.Timing.Settings qualified as Timing

cacheOptions :: Bus.BusOptions -> Timing.Settings -> (key -> IO (IO ())) -> Cache.CacheOptions key value
cacheOptions clock timing scope =
  Cache.CacheOptions
    (Bus.requestNow clock)
    (Bus.requestWaitUntil clock)
    (Timing.saveDebounceMs timing)
    Nothing
    scope

oneReport :: IO value -> IO (Running.Running value value)
oneReport action = Running.newRunning $ \report -> do
  value <- action
  report value
  pure value
