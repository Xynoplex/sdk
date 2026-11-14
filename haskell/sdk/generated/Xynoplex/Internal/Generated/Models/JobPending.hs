-- Generated from protocol/specs/src. Run xynoplex-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynoplex.Internal.Generated.Models.JobPending
  ( JobPending(..)
  , JobPendingStatus(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynoplex.Internal.Codec
import Xynoplex.Types.Presence (Presence)
import Xynoplex.Internal.Generated.Models.JobMetadata
import Xynoplex.Internal.Generated.Models.JobParams
data JobPending = JobPending { jobPendingMetadata :: JobMetadata, jobPendingParams :: JobParams, jobPendingStatus :: JobPendingStatus } deriving (Eq, Show)
instance FromJSON JobPending where
  parseJSON = checked "JobPending" $ withObject "JobPending" (\fields -> JobPending <$> fields .: "metadata" <*> fields .: "params" <*> fields .: "status")
instance ToJSON JobPending where toJSON value = Object (KM.fromList (concat [[("metadata", toJSON (jobPendingMetadata value))], [("params", toJSON (jobPendingParams value))], [("status", toJSON (jobPendingStatus value))]]))

data JobPendingStatus = JobPendingStatusPending deriving (Eq, Show)
instance FromJSON JobPendingStatus where
  parseJSON = checked "JobPendingStatus" $ \value -> if value == (String "pending") then pure JobPendingStatusPending else fail "unknown enumeration member"
instance ToJSON JobPendingStatus where
  toJSON JobPendingStatusPending = String "pending"
