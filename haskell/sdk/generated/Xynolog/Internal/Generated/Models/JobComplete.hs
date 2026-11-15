-- Generated from protocol/specs/src. Run xynolog-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynolog.Internal.Generated.Models.JobComplete
  ( JobComplete(..)
  , JobCompleteStatus(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Types.Presence (Presence)
import Xynolog.Internal.Generated.Models.JobMetadata
import Xynolog.Internal.Generated.Models.JobParams
import Xynolog.Internal.Generated.Models.JobStoredResult
data JobComplete = JobComplete { jobCompleteCompletedAt :: Text, jobCompleteMetadata :: JobMetadata, jobCompleteParams :: JobParams, jobCompleteResult :: JobStoredResult, jobCompleteStartedAt :: Text, jobCompleteStatus :: JobCompleteStatus } deriving (Eq, Show)
instance FromJSON JobComplete where
  parseJSON = checked "JobComplete" $ withObject "JobComplete" (\fields -> JobComplete <$> fields .: "completedAt" <*> fields .: "metadata" <*> fields .: "params" <*> fields .: "result" <*> fields .: "startedAt" <*> fields .: "status")
instance ToJSON JobComplete where toJSON value = Object (KM.fromList (concat [[("completedAt", toJSON (jobCompleteCompletedAt value))], [("metadata", toJSON (jobCompleteMetadata value))], [("params", toJSON (jobCompleteParams value))], [("result", toJSON (jobCompleteResult value))], [("startedAt", toJSON (jobCompleteStartedAt value))], [("status", toJSON (jobCompleteStatus value))]]))

data JobCompleteStatus = JobCompleteStatusComplete deriving (Eq, Show)
instance FromJSON JobCompleteStatus where
  parseJSON = checked "JobCompleteStatus" $ \value -> if value == (String "complete") then pure JobCompleteStatusComplete else fail "unknown enumeration member"
instance ToJSON JobCompleteStatus where
  toJSON JobCompleteStatusComplete = String "complete"
