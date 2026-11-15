-- Generated from protocol/specs/src. Run xynolog-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynolog.Internal.Generated.Models.YieldJobDone
  ( YieldJobDone(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Types.Presence (Presence)
import Xynolog.Internal.Generated.Models.ResourceId
data YieldJobDone = YieldJobDone { yieldJobDoneResourceId :: ResourceId, yieldJobDoneResourceName :: Text, yieldJobDoneTruncated :: Bool } deriving (Eq, Show)
instance FromJSON YieldJobDone where
  parseJSON = checked "YieldJobDone" $ withObject "YieldJobDone" (\fields -> YieldJobDone <$> fields .: "resourceId" <*> fields .: "resourceName" <*> fields .: "truncated")
instance ToJSON YieldJobDone where toJSON value = Object (KM.fromList (concat [[("resourceId", toJSON (yieldJobDoneResourceId value))], [("resourceName", toJSON (yieldJobDoneResourceName value))], [("truncated", toJSON (yieldJobDoneTruncated value))]]))
