-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.InferenceLimitsResult (InferenceLimitsResult (..), InferenceLimitsResultResponse (..)) where

import Data.Aeson (FromJSON (..), ToJSON (..), Value (..), withObject, (.:))
import Data.Aeson.KeyMap qualified as KM
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.EngineLimits

data InferenceLimitsResult = InferenceLimitsResult
  { inferenceLimitsResultResponse :: InferenceLimitsResultResponse,
    inferenceLimitsResultAdditionalProperties :: KM.KeyMap Value
  }
  deriving (Eq, Show)

instance FromJSON InferenceLimitsResult where parseJSON = checked "InferenceLimitsResult" $ withObject "InferenceLimitsResult" (\fields -> InferenceLimitsResult <$> (fields .: "response") <*> traverse parseJSON (withoutFields ["response"] fields))

instance ToJSON InferenceLimitsResult where toJSON value = Object (KM.fromList (concat [[("response", toJSON (inferenceLimitsResultResponse value))]]) <> fmap toJSON (withoutFields ["response"] (inferenceLimitsResultAdditionalProperties value)))

data InferenceLimitsResultResponse = InferenceLimitsResultResponse
  { inferenceLimitsResultResponseLimits :: [EngineLimits],
    inferenceLimitsResultResponseAdditionalProperties :: KM.KeyMap Value
  }
  deriving (Eq, Show)

instance FromJSON InferenceLimitsResultResponse where parseJSON = checked "InferenceLimitsResultResponse" $ withObject "InferenceLimitsResultResponse" (\fields -> InferenceLimitsResultResponse <$> (fields .: "limits") <*> traverse parseJSON (withoutFields ["limits"] fields))

instance ToJSON InferenceLimitsResultResponse where toJSON value = Object (KM.fromList (concat [[("limits", toJSON (inferenceLimitsResultResponseLimits value))]]) <> fmap toJSON (withoutFields ["limits"] (inferenceLimitsResultResponseAdditionalProperties value)))
