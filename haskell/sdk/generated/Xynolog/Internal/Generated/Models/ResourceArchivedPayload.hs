-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.ResourceArchivedPayload (ResourceArchivedPayload (..)) where

import Data.Aeson (FromJSON (..), ToJSON (..), Value (..), withObject)
import Data.Aeson.KeyMap qualified as KM
import Data.Text (Text)
import Xynolog.Internal.Codec

data ResourceArchivedPayload = ResourceArchivedPayload
  { resourceArchivedPayloadReason :: Maybe Text,
    resourceArchivedPayloadAdditionalProperties :: KM.KeyMap Value
  }
  deriving (Eq, Show)

instance FromJSON ResourceArchivedPayload where parseJSON = checked "ResourceArchivedPayload" $ withObject "ResourceArchivedPayload" (\fields -> ResourceArchivedPayload <$> optional fields "reason" <*> traverse parseJSON (withoutFields ["reason"] fields))

instance ToJSON ResourceArchivedPayload where toJSON value = Object (KM.fromList (concat [optionalPair "reason" (resourceArchivedPayloadReason value)]) <> fmap toJSON (withoutFields ["reason"] (resourceArchivedPayloadAdditionalProperties value)))
