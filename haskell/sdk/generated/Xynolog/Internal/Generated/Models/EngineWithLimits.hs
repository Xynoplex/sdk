-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.EngineWithLimits (EngineWithLimits(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.Engine
import Xynolog.Internal.Generated.Models.InferenceLimits
import Xynolog.Internal.Generated.Models.JobFilter
data EngineWithLimits = EngineWithLimits
  { engineWithLimitsEngine :: Engine
  , engineWithLimitsJobs :: Maybe [JobFilter]
  , engineWithLimitsLimits :: Maybe InferenceLimits
  } deriving (Eq, Show)
instance FromJSON EngineWithLimits where parseJSON = checked "EngineWithLimits" $ withObject "EngineWithLimits" (\fields -> EngineWithLimits <$> (fields .: "engine") <*> optional fields "jobs" <*> optional fields "limits")
instance ToJSON EngineWithLimits where toJSON value = Object (KM.fromList (concat [[("engine", toJSON (engineWithLimitsEngine value))], optionalPair "jobs" (engineWithLimitsJobs value), optionalPair "limits" (engineWithLimitsLimits value)]))
