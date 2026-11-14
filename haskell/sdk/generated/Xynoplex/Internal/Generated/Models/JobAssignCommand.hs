-- Generated from protocol/specs/src. Run xynoplex-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynoplex.Internal.Generated.Models.JobAssignCommand
  ( JobAssignCommand(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynoplex.Internal.Codec
import Xynoplex.Types.Presence (Presence)
import Xynoplex.Internal.Generated.Models.JobId
import Xynoplex.Internal.Generated.Models.JobType
import Xynoplex.Internal.Generated.Models.ResourceId
import Xynoplex.Internal.Generated.Models.UserId
data JobAssignCommand = JobAssignCommand { jobAssignCommandU5f_userId :: Maybe (UserId), jobAssignCommandHolder :: UserId, jobAssignCommandJobId :: JobId, jobAssignCommandJobType :: JobType, jobAssignCommandRequester :: UserId, jobAssignCommandResourceId :: ResourceId, jobAssignCommandAdditionalProperties :: KM.KeyMap (Value) } deriving (Eq, Show)
instance FromJSON JobAssignCommand where
  parseJSON = checked "JobAssignCommand" $ withObject "JobAssignCommand" (\fields -> JobAssignCommand <$> optional fields "_userId" <*> fields .: "holder" <*> fields .: "jobId" <*> fields .: "jobType" <*> fields .: "requester" <*> fields .: "resourceId" <*> traverse parseJSON (withoutFields ["_userId", "holder", "jobId", "jobType", "requester", "resourceId"] fields))
instance ToJSON JobAssignCommand where toJSON value = Object (KM.fromList (concat [optionalPair "_userId" (jobAssignCommandU5f_userId value), [("holder", toJSON (jobAssignCommandHolder value))], [("jobId", toJSON (jobAssignCommandJobId value))], [("jobType", toJSON (jobAssignCommandJobType value))], [("requester", toJSON (jobAssignCommandRequester value))], [("resourceId", toJSON (jobAssignCommandResourceId value))]]) <> fmap toJSON (withoutFields ["_userId", "holder", "jobId", "jobType", "requester", "resourceId"] (jobAssignCommandAdditionalProperties value)))
