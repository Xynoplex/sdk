-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.YieldedResource (YieldedResource (..)) where

import Data.Aeson (FromJSON (..), ToJSON (..), Value (..), withObject, (.:))
import Data.Aeson.KeyMap qualified as KM
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.ResourceId

data YieldedResource = YieldedResource
  { yieldedResourceResourceId :: ResourceId,
    yieldedResourceAdditionalProperties :: KM.KeyMap Value
  }
  deriving (Eq, Show)

instance FromJSON YieldedResource where parseJSON = checked "YieldedResource" $ withObject "YieldedResource" (\fields -> YieldedResource <$> (fields .: "resourceId") <*> traverse parseJSON (withoutFields ["resourceId"] fields))

instance ToJSON YieldedResource where toJSON value = Object (KM.fromList (concat [[("resourceId", toJSON (yieldedResourceResourceId value))]]) <> fmap toJSON (withoutFields ["resourceId"] (yieldedResourceAdditionalProperties value)))
