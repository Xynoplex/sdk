-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.EngineEntry (EngineEntry(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.Engine
import Xynolog.Internal.Generated.Models.JobFilter
data EngineEntry = EngineEntry
  { engineEntryEngine :: Engine
  , engineEntryJobs :: Maybe [JobFilter]
  } deriving (Eq, Show)
instance FromJSON EngineEntry where parseJSON = checked "EngineEntry" $ withObject "EngineEntry" (\fields -> EngineEntry <$> (fields .: "engine") <*> optional fields "jobs")
instance ToJSON EngineEntry where toJSON value = Object (KM.fromList (concat [[("engine", toJSON (engineEntryEngine value))], optionalPair "jobs" (engineEntryJobs value)]))
