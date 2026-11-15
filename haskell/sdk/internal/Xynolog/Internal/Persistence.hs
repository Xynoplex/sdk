{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Persistence (CachePersistence(..), persister) where

import Data.Aeson (FromJSON, ToJSON, Value)
import Data.Aeson.Types (Parser)
import Data.Scientific (Scientific)
import Data.Text (Text)
import qualified Xynolog.SessionStorage as Storage
import qualified Xynolog.StoragePersister as Stored
import qualified Xynolog.Cache as Cache
import qualified Xynolog.Internal.Coupled as Coupled
import Xynolog.Internal.Kept (cacheKey)
import qualified Xynolog.Timing.Settings as Timing
import Xynolog.Internal.Generated.CachePersistence (KeptQuery)

-- | What a client keeps for one person on one knowledge base, under the
-- keys session/stored.json gives the knowledge base's id and the person's key.
data CachePersistence = CachePersistence
  { cacheStorage :: Storage.SessionStorage
  , cacheKbId :: Text
  , cachePersonKey :: Text
  , cacheWallNow :: IO Scientific
  -- ^ Epoch milliseconds supplied by the host. Protocol waits use BusOptions.
  }

-- | A kept query's persister, whose every recorded save writes the places noted.
persister :: (ToJSON key, ToJSON value, FromJSON value)
  => CachePersistence -> Coupled.Coupled -> Timing.Settings -> KeptQuery
  -> (Value -> value -> Parser key) -> IO (Cache.CachePersister key value)
persister options coupled timing query = Stored.newStoragePersister
  (Stored.StoragePersister (cacheStorage options) (cacheKey (cacheKbId options) (cachePersonKey options) query)
    (Timing.maxStoredBytesCount timing) (cacheWallNow options) (Coupled.written coupled))
