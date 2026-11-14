{-# LANGUAGE OverloadedStrings #-}
module Xynoplex.Internal.Persistence (CachePersistence(..), persister) where

import Data.Aeson (FromJSON, ToJSON, Value)
import Data.Aeson.Types (Parser)
import Data.Scientific (Scientific)
import Data.Text (Text)
import qualified Xynoplex.SessionStorage as Storage
import qualified Xynoplex.StoragePersister as Stored
import qualified Xynoplex.Cache as Cache
import qualified Xynoplex.Internal.Coupled as Coupled
import Xynoplex.Internal.Kept (cacheKey)
import qualified Xynoplex.Timing.Settings as Timing
import Xynoplex.Internal.Generated.CachePersistence (KeptQuery)

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
