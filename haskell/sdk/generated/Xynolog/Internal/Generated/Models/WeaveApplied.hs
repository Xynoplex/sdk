-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.WeaveApplied (WeaveApplied (..)) where

import Data.Aeson (FromJSON (..), ToJSON (..), Value (..), withObject, (.:))
import Data.Aeson.KeyMap qualified as KM
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.ResourceId

data WeaveApplied = WeaveApplied
  { weaveAppliedResourceId :: ResourceId,
    weaveAppliedSequenceNumber :: Integer,
    weaveAppliedAdditionalProperties :: KM.KeyMap Value
  }
  deriving (Eq, Show)

instance FromJSON WeaveApplied where parseJSON = checked "WeaveApplied" $ withObject "WeaveApplied" (\fields -> WeaveApplied <$> (fields .: "resourceId") <*> (fields .: "sequenceNumber") <*> traverse parseJSON (withoutFields ["resourceId", "sequenceNumber"] fields))

instance ToJSON WeaveApplied where toJSON value = Object (KM.fromList (concat [[("resourceId", toJSON (weaveAppliedResourceId value))], [("sequenceNumber", toJSON (weaveAppliedSequenceNumber value))]]) <> fmap toJSON (withoutFields ["resourceId", "sequenceNumber"] (weaveAppliedAdditionalProperties value)))
