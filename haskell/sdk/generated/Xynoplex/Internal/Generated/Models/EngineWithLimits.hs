-- Generated from protocol/specs/src. Run xynoplex-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynoplex.Internal.Generated.Models.EngineWithLimits
  ( EngineWithLimits(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynoplex.Internal.Codec
import Xynoplex.Types.Presence (Presence)
import Xynoplex.Internal.Generated.Models.Engine
import Xynoplex.Internal.Generated.Models.InferenceLimits
import Xynoplex.Internal.Generated.Models.JobFilter
data EngineWithLimits = EngineWithLimits { engineWithLimitsEngine :: Engine, engineWithLimitsJobs :: Maybe ([JobFilter]), engineWithLimitsLimits :: Maybe (InferenceLimits) } deriving (Eq, Show)
instance FromJSON EngineWithLimits where
  parseJSON = checked "EngineWithLimits" $ withObject "EngineWithLimits" (\fields -> EngineWithLimits <$> fields .: "engine" <*> optional fields "jobs" <*> optional fields "limits")
instance ToJSON EngineWithLimits where toJSON value = Object (KM.fromList (concat [[("engine", toJSON (engineWithLimitsEngine value))], optionalPair "jobs" (engineWithLimitsJobs value), optionalPair "limits" (engineWithLimitsLimits value)]))
