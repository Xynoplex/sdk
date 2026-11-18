-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.YieldJobDone (YieldJobDone (..)) where

import Data.Aeson (FromJSON (..), ToJSON (..), Value (..), withObject, (.:))
import Data.Aeson.KeyMap qualified as KM
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.ResourceId

data YieldJobDone = YieldJobDone
  { yieldJobDoneResourceId :: ResourceId,
    yieldJobDoneResourceName :: Text,
    yieldJobDoneTruncated :: Bool
  }
  deriving (Eq, Show)

instance FromJSON YieldJobDone where parseJSON = checked "YieldJobDone" $ withObject "YieldJobDone" (\fields -> YieldJobDone <$> (fields .: "resourceId") <*> (fields .: "resourceName") <*> (fields .: "truncated"))

instance ToJSON YieldJobDone where toJSON value = Object (KM.fromList (concat [[("resourceId", toJSON (yieldJobDoneResourceId value))], [("resourceName", toJSON (yieldJobDoneResourceName value))], [("truncated", toJSON (yieldJobDoneTruncated value))]]))
