-- Generated from protocol/specs/src. Run xynoplex-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynoplex.Internal.Generated.Models.JobClaimedResult
  ( JobClaimedResult(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynoplex.Internal.Codec
import Xynoplex.Types.Presence (Presence)
import Xynoplex.Internal.Generated.Models.JobRunning
data JobClaimedResult = JobClaimedResult { jobClaimedResultResponse :: JobRunning } deriving (Eq, Show)
instance FromJSON JobClaimedResult where
  parseJSON = checked "JobClaimedResult" $ withObject "JobClaimedResult" (\fields -> JobClaimedResult <$> fields .: "response")
instance ToJSON JobClaimedResult where toJSON value = Object (KM.fromList (concat [[("response", toJSON (jobClaimedResultResponse value))]]))
