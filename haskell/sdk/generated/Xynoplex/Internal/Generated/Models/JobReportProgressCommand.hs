-- Generated from protocol/specs/src. Run xynoplex-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynoplex.Internal.Generated.Models.JobReportProgressCommand
  ( JobReportProgressCommand(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynoplex.Internal.Codec
import Xynoplex.Types.Presence (Presence)
import Xynoplex.Internal.Generated.Models.AnnotationId
import Xynoplex.Internal.Generated.Models.JobId
import Xynoplex.Internal.Generated.Models.JobProgress
import Xynoplex.Internal.Generated.Models.JobType
import Xynoplex.Internal.Generated.Models.ResourceId
import Xynoplex.Internal.Generated.Models.UserId
data JobReportProgressCommand = JobReportProgressCommand { jobReportProgressCommandU5f_userId :: Maybe (UserId), jobReportProgressCommandAnnotationId :: Maybe (AnnotationId), jobReportProgressCommandAttempt :: Maybe (Integer), jobReportProgressCommandJobId :: JobId, jobReportProgressCommandJobType :: JobType, jobReportProgressCommandPercentage :: Scientific, jobReportProgressCommandProgress :: Maybe (JobProgress), jobReportProgressCommandResourceId :: ResourceId, jobReportProgressCommandAdditionalProperties :: KM.KeyMap (Value) } deriving (Eq, Show)
instance FromJSON JobReportProgressCommand where
  parseJSON = checked "JobReportProgressCommand" $ withObject "JobReportProgressCommand" (\fields -> JobReportProgressCommand <$> optional fields "_userId" <*> optional fields "annotationId" <*> optional fields "attempt" <*> fields .: "jobId" <*> fields .: "jobType" <*> fields .: "percentage" <*> optional fields "progress" <*> fields .: "resourceId" <*> traverse parseJSON (withoutFields ["_userId", "annotationId", "attempt", "jobId", "jobType", "percentage", "progress", "resourceId"] fields))
instance ToJSON JobReportProgressCommand where toJSON value = Object (KM.fromList (concat [optionalPair "_userId" (jobReportProgressCommandU5f_userId value), optionalPair "annotationId" (jobReportProgressCommandAnnotationId value), optionalPair "attempt" (jobReportProgressCommandAttempt value), [("jobId", toJSON (jobReportProgressCommandJobId value))], [("jobType", toJSON (jobReportProgressCommandJobType value))], [("percentage", toJSON (jobReportProgressCommandPercentage value))], optionalPair "progress" (jobReportProgressCommandProgress value), [("resourceId", toJSON (jobReportProgressCommandResourceId value))]]) <> fmap toJSON (withoutFields ["_userId", "annotationId", "attempt", "jobId", "jobType", "percentage", "progress", "resourceId"] (jobReportProgressCommandAdditionalProperties value)))
