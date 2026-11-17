-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.EngineLimits (EngineLimits(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.Engine
import Xynolog.Internal.Generated.Models.InferenceLimits
data EngineLimits = EngineLimits
  { engineLimitsEngine :: Engine
  , engineLimitsLimits :: InferenceLimits
  } deriving (Eq, Show)
instance FromJSON EngineLimits where parseJSON = checked "EngineLimits" $ withObject "EngineLimits" (\fields -> EngineLimits <$> (fields .: "engine") <*> (fields .: "limits"))
instance ToJSON EngineLimits where toJSON value = Object (KM.fromList (concat [[("engine", toJSON (engineLimitsEngine value))], [("limits", toJSON (engineLimitsLimits value))]]))
