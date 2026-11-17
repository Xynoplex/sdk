-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.InferenceLimitsRequest (InferenceLimitsRequest(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject)
import qualified Data.Aeson.KeyMap as KM
import Xynolog.Internal.Codec
data InferenceLimitsRequest = InferenceLimitsRequest
  { inferenceLimitsRequestAdditionalProperties :: KM.KeyMap Value
  } deriving (Eq, Show)
instance FromJSON InferenceLimitsRequest where parseJSON = checked "InferenceLimitsRequest" $ withObject "InferenceLimitsRequest" (\fields -> InferenceLimitsRequest <$> traverse parseJSON (withoutFields [] fields))
instance ToJSON InferenceLimitsRequest where toJSON value = Object (KM.fromList (concat []) <> fmap toJSON (withoutFields [] (inferenceLimitsRequestAdditionalProperties value)))
