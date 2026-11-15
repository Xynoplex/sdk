-- Generated from protocol/specs/src. Run xynolog-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynolog.Internal.Generated.Models.JobProgressCreatingResource
  ( JobProgressCreatingResource(..)
  , JobProgressCreatingResourceCode(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Types.Presence (Presence)
data JobProgressCreatingResource = JobProgressCreatingResource { jobProgressCreatingResourceCode :: JobProgressCreatingResourceCode, jobProgressCreatingResourceAdditionalProperties :: KM.KeyMap (Value) } deriving (Eq, Show)
instance FromJSON JobProgressCreatingResource where
  parseJSON = checked "JobProgressCreatingResource" $ withObject "JobProgressCreatingResource" (\fields -> JobProgressCreatingResource <$> fields .: "code" <*> traverse parseJSON (withoutFields ["code"] fields))
instance ToJSON JobProgressCreatingResource where toJSON value = Object (KM.fromList (concat [[("code", toJSON (jobProgressCreatingResourceCode value))]]) <> fmap toJSON (withoutFields ["code"] (jobProgressCreatingResourceAdditionalProperties value)))

data JobProgressCreatingResourceCode = JobProgressCreatingResourceCodeCreatingU2d_resource deriving (Eq, Show)
instance FromJSON JobProgressCreatingResourceCode where
  parseJSON = checked "JobProgressCreatingResourceCode" $ \value -> if value == (String "creating-resource") then pure JobProgressCreatingResourceCodeCreatingU2d_resource else fail "unknown enumeration member"
instance ToJSON JobProgressCreatingResourceCode where
  toJSON JobProgressCreatingResourceCodeCreatingU2d_resource = String "creating-resource"
