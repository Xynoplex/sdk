-- Generated from protocol/specs/src. Run xynoplex-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynoplex.Internal.Generated.Models.JobFailedPayload
  ( JobFailedPayload(..)
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
import Xynoplex.Internal.Generated.Models.DurabilityEvidence
import Xynoplex.Internal.Generated.Models.FailureClass
import Xynoplex.Internal.Generated.Models.JobId
import Xynoplex.Internal.Generated.Models.JobType
data JobFailedPayload = JobFailedPayload { jobFailedPayloadAnnotationId :: Maybe (AnnotationId), jobFailedPayloadAttempt :: Maybe (Integer), jobFailedPayloadDurability :: Maybe (DurabilityEvidence), jobFailedPayloadError :: Text, jobFailedPayloadFailureClass :: Maybe (FailureClass), jobFailedPayloadJobId :: JobId, jobFailedPayloadJobType :: JobType, jobFailedPayloadWillRetry :: Maybe (Bool), jobFailedPayloadAdditionalProperties :: KM.KeyMap (Value) } deriving (Eq, Show)
instance FromJSON JobFailedPayload where
  parseJSON = checked "JobFailedPayload" $ withObject "JobFailedPayload" (\fields -> JobFailedPayload <$> optional fields "annotationId" <*> optional fields "attempt" <*> optional fields "durability" <*> fields .: "error" <*> optional fields "failureClass" <*> fields .: "jobId" <*> fields .: "jobType" <*> optional fields "willRetry" <*> traverse parseJSON (withoutFields ["annotationId", "attempt", "durability", "error", "failureClass", "jobId", "jobType", "willRetry"] fields))
instance ToJSON JobFailedPayload where toJSON value = Object (KM.fromList (concat [optionalPair "annotationId" (jobFailedPayloadAnnotationId value), optionalPair "attempt" (jobFailedPayloadAttempt value), optionalPair "durability" (jobFailedPayloadDurability value), [("error", toJSON (jobFailedPayloadError value))], optionalPair "failureClass" (jobFailedPayloadFailureClass value), [("jobId", toJSON (jobFailedPayloadJobId value))], [("jobType", toJSON (jobFailedPayloadJobType value))], optionalPair "willRetry" (jobFailedPayloadWillRetry value)]) <> fmap toJSON (withoutFields ["annotationId", "attempt", "durability", "error", "failureClass", "jobId", "jobType", "willRetry"] (jobFailedPayloadAdditionalProperties value)))
