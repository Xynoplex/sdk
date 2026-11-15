-- Generated from protocol/specs/src. Run xynolog-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynolog.Internal.Generated.Models.JobId
  ( JobId, jobIdValue, mkJobId
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Types.Presence (Presence)
newtype JobId = JobId (Text) deriving (Eq, Ord, Show)
instance FromJSON JobId where
  parseJSON = checked "JobId" $ \value -> JobId <$> parseJSON value
instance ToJSON JobId where toJSON (JobId value) = toJSON value
jobIdValue :: JobId -> Text
jobIdValue (JobId value) = value
mkJobId :: Text -> Either String JobId
mkJobId value = parseEither parseJSON (toJSON value)
