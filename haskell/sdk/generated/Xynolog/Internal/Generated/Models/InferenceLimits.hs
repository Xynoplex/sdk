-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.InferenceLimits (InferenceLimits(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Xynolog.Internal.Codec
data InferenceLimits = InferenceLimits
  { inferenceLimitsAcceptsTemperature :: Maybe Bool
  , inferenceLimitsContextTokens :: Scientific
  , inferenceLimitsMaxOutputTokens :: Scientific
  , inferenceLimitsAdditionalProperties :: KM.KeyMap Value
  } deriving (Eq, Show)
instance FromJSON InferenceLimits where parseJSON = checked "InferenceLimits" $ withObject "InferenceLimits" (\fields -> InferenceLimits <$> optional fields "acceptsTemperature" <*> (fields .: "contextTokens") <*> (fields .: "maxOutputTokens") <*> traverse parseJSON (withoutFields ["acceptsTemperature", "contextTokens", "maxOutputTokens"] fields))
instance ToJSON InferenceLimits where toJSON value = Object (KM.fromList (concat [optionalPair "acceptsTemperature" (inferenceLimitsAcceptsTemperature value), [("contextTokens", toJSON (inferenceLimitsContextTokens value))], [("maxOutputTokens", toJSON (inferenceLimitsMaxOutputTokens value))]]) <> fmap toJSON (withoutFields ["acceptsTemperature", "contextTokens", "maxOutputTokens"] (inferenceLimitsAdditionalProperties value)))
