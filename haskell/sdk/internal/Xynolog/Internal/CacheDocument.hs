{-# LANGUAGE OverloadedStrings #-}

-- | What a client keeps across a restart, as JSON (session/stored.json): the
-- key a whole query keeps its one entry under, a query's cache document, and
-- where each stream was.
module Xynolog.Internal.CacheDocument (Whole (..), CacheDocument (..), lastEventIds) where

import Control.Monad (unless)
import Data.Aeson (FromJSON (..), Result (..), ToJSON (..), Value (..), fromJSON, object, withObject, withText, (.:), (.=))
import Data.Aeson.Key qualified as Key
import Data.Aeson.KeyMap qualified as KM
import Data.Map.Strict qualified as Map
import Numeric.Natural (Natural)
import Xynolog.Internal.Generated.CachePersistence (cacheDocumentVersion, wholeKey)
import Xynolog.Internal.Generated.Models.PersistedEventId (PersistedEventId)
import Xynolog.Internal.Generated.Models.ResourceId (ResourceId)

-- | The key a kept query per nothing keeps its one entry under.
data Whole = Whole deriving (Eq, Ord, Show)

instance ToJSON Whole where toJSON Whole = String wholeKey

instance FromJSON Whole where
  parseJSON = withText "Whole" (\key -> if key == wholeKey then pure Whole else fail "not the whole key")

-- | What a client keeps of one query: each entry's key, value and stamp. A document of another
-- version, or one whose entries are not each a key, a value and a stamp, does not decode.
newtype CacheDocument = CacheDocument [(Value, Value, Natural)] deriving (Eq, Show)

instance FromJSON CacheDocument where
  parseJSON = withObject "CacheDocument" $ \fields -> do
    version <- fields .: "version"
    unless (version == cacheDocumentVersion) (fail "a cache document of another version")
    CacheDocument <$> fields .: "entries"

instance ToJSON CacheDocument where
  toJSON (CacheDocument entries) = object ["version" .= cacheDocumentVersion, "entries" .= entries]

-- | Where a stream was: a pair that is not a ResourceId and a PersistedEventId is skipped, and a value that is no object is none.
lastEventIds :: Value -> Map.Map ResourceId PersistedEventId
lastEventIds (Object fields) =
  Map.fromList
    [(named, value) | (key, raw) <- KM.toList fields, Success named <- [fromJSON (String (Key.toText key))], Success value <- [fromJSON raw]]
lastEventIds _ = Map.empty
