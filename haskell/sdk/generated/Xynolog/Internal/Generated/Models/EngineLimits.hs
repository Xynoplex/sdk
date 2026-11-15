-- Generated from protocol/specs/src. Run xynolog-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynolog.Internal.Generated.Models.EngineLimits
  ( EngineLimits(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Types.Presence (Presence)
import Xynolog.Internal.Generated.Models.Engine
import Xynolog.Internal.Generated.Models.InferenceLimits
data EngineLimits = EngineLimits { engineLimitsEngine :: Engine, engineLimitsLimits :: InferenceLimits } deriving (Eq, Show)
instance FromJSON EngineLimits where
  parseJSON = checked "EngineLimits" $ withObject "EngineLimits" (\fields -> EngineLimits <$> fields .: "engine" <*> fields .: "limits")
instance ToJSON EngineLimits where toJSON value = Object (KM.fromList (concat [[("engine", toJSON (engineLimitsEngine value))], [("limits", toJSON (engineLimitsLimits value))]]))
