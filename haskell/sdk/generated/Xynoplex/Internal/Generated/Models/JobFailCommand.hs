-- Generated from protocol/specs/src. Run xynoplex-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynoplex.Internal.Generated.Models.JobFailCommand
  ( JobFailCommand(..)
  , JobFailCommandUnitCursors(..)
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
import Xynoplex.Internal.Generated.Models.ResourceId
import Xynoplex.Internal.Generated.Models.UnitCursor
import Xynoplex.Internal.Generated.Models.UserId
data JobFailCommand = JobFailCommand { jobFailCommandU5f_userId :: Maybe (UserId), jobFailCommandAnnotationId :: Maybe (AnnotationId), jobFailCommandAttempt :: Maybe (Integer), jobFailCommandCompletedUnits :: Maybe ([Text]), jobFailCommandDurability :: Maybe (DurabilityEvidence), jobFailCommandError :: Text, jobFailCommandFailureClass :: Maybe (FailureClass), jobFailCommandJobId :: JobId, jobFailCommandJobType :: JobType, jobFailCommandResourceId :: ResourceId, jobFailCommandUnitCursors :: Maybe (JobFailCommandUnitCursors), jobFailCommandWillRetry :: Maybe (Bool), jobFailCommandAdditionalProperties :: KM.KeyMap (Value) } deriving (Eq, Show)
instance FromJSON JobFailCommand where
  parseJSON = checked "JobFailCommand" $ withObject "JobFailCommand" (\fields -> JobFailCommand <$> optional fields "_userId" <*> optional fields "annotationId" <*> optional fields "attempt" <*> optional fields "completedUnits" <*> optional fields "durability" <*> fields .: "error" <*> optional fields "failureClass" <*> fields .: "jobId" <*> fields .: "jobType" <*> fields .: "resourceId" <*> optional fields "unitCursors" <*> optional fields "willRetry" <*> traverse parseJSON (withoutFields ["_userId", "annotationId", "attempt", "completedUnits", "durability", "error", "failureClass", "jobId", "jobType", "resourceId", "unitCursors", "willRetry"] fields))
instance ToJSON JobFailCommand where toJSON value = Object (KM.fromList (concat [optionalPair "_userId" (jobFailCommandU5f_userId value), optionalPair "annotationId" (jobFailCommandAnnotationId value), optionalPair "attempt" (jobFailCommandAttempt value), optionalPair "completedUnits" (jobFailCommandCompletedUnits value), optionalPair "durability" (jobFailCommandDurability value), [("error", toJSON (jobFailCommandError value))], optionalPair "failureClass" (jobFailCommandFailureClass value), [("jobId", toJSON (jobFailCommandJobId value))], [("jobType", toJSON (jobFailCommandJobType value))], [("resourceId", toJSON (jobFailCommandResourceId value))], optionalPair "unitCursors" (jobFailCommandUnitCursors value), optionalPair "willRetry" (jobFailCommandWillRetry value)]) <> fmap toJSON (withoutFields ["_userId", "annotationId", "attempt", "completedUnits", "durability", "error", "failureClass", "jobId", "jobType", "resourceId", "unitCursors", "willRetry"] (jobFailCommandAdditionalProperties value)))

data JobFailCommandUnitCursors = JobFailCommandUnitCursors { jobFailCommandUnitCursorsAdditionalProperties :: KM.KeyMap (UnitCursor) } deriving (Eq, Show)
instance FromJSON JobFailCommandUnitCursors where
  parseJSON = checked "JobFailCommandUnitCursors" $ withObject "JobFailCommandUnitCursors" (\fields -> JobFailCommandUnitCursors <$> traverse parseJSON (withoutFields [] fields))
instance ToJSON JobFailCommandUnitCursors where toJSON value = Object (KM.fromList (concat []) <> fmap toJSON (withoutFields [] (jobFailCommandUnitCursorsAdditionalProperties value)))
