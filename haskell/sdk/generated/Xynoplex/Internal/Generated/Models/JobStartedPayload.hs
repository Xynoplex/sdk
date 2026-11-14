-- Generated from protocol/specs/src. Run xynoplex-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynoplex.Internal.Generated.Models.JobStartedPayload
  ( JobStartedPayload(..)
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
import Xynoplex.Internal.Generated.Models.JobType
data JobStartedPayload = JobStartedPayload { jobStartedPayloadAnnotationId :: Maybe (AnnotationId), jobStartedPayloadJobId :: JobId, jobStartedPayloadJobType :: JobType, jobStartedPayloadTotalSteps :: Maybe (Integer), jobStartedPayloadAdditionalProperties :: KM.KeyMap (Value) } deriving (Eq, Show)
instance FromJSON JobStartedPayload where
  parseJSON = checked "JobStartedPayload" $ withObject "JobStartedPayload" (\fields -> JobStartedPayload <$> optional fields "annotationId" <*> fields .: "jobId" <*> fields .: "jobType" <*> optional fields "totalSteps" <*> traverse parseJSON (withoutFields ["annotationId", "jobId", "jobType", "totalSteps"] fields))
instance ToJSON JobStartedPayload where toJSON value = Object (KM.fromList (concat [optionalPair "annotationId" (jobStartedPayloadAnnotationId value), [("jobId", toJSON (jobStartedPayloadJobId value))], [("jobType", toJSON (jobStartedPayloadJobType value))], optionalPair "totalSteps" (jobStartedPayloadTotalSteps value)]) <> fmap toJSON (withoutFields ["annotationId", "jobId", "jobType", "totalSteps"] (jobStartedPayloadAdditionalProperties value)))
