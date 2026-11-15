-- Generated from protocol/specs/src. Run xynolog-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynolog.Internal.Generated.Models.JobCheckpointCommand
  ( JobCheckpointCommand(..)
  , JobCheckpointCommandUnitCursors(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Types.Presence (Presence)
import Xynolog.Internal.Generated.Models.JobId
import Xynolog.Internal.Generated.Models.UnitCursor
import Xynolog.Internal.Generated.Models.UserId
data JobCheckpointCommand = JobCheckpointCommand { jobCheckpointCommandU5f_userId :: Maybe (UserId), jobCheckpointCommandCompletedUnits :: [Text], jobCheckpointCommandJobId :: JobId, jobCheckpointCommandUnitCursors :: Maybe (JobCheckpointCommandUnitCursors), jobCheckpointCommandAdditionalProperties :: KM.KeyMap (Value) } deriving (Eq, Show)
instance FromJSON JobCheckpointCommand where
  parseJSON = checked "JobCheckpointCommand" $ withObject "JobCheckpointCommand" (\fields -> JobCheckpointCommand <$> optional fields "_userId" <*> fields .: "completedUnits" <*> fields .: "jobId" <*> optional fields "unitCursors" <*> traverse parseJSON (withoutFields ["_userId", "completedUnits", "jobId", "unitCursors"] fields))
instance ToJSON JobCheckpointCommand where toJSON value = Object (KM.fromList (concat [optionalPair "_userId" (jobCheckpointCommandU5f_userId value), [("completedUnits", toJSON (jobCheckpointCommandCompletedUnits value))], [("jobId", toJSON (jobCheckpointCommandJobId value))], optionalPair "unitCursors" (jobCheckpointCommandUnitCursors value)]) <> fmap toJSON (withoutFields ["_userId", "completedUnits", "jobId", "unitCursors"] (jobCheckpointCommandAdditionalProperties value)))

data JobCheckpointCommandUnitCursors = JobCheckpointCommandUnitCursors { jobCheckpointCommandUnitCursorsAdditionalProperties :: KM.KeyMap (UnitCursor) } deriving (Eq, Show)
instance FromJSON JobCheckpointCommandUnitCursors where
  parseJSON = checked "JobCheckpointCommandUnitCursors" $ withObject "JobCheckpointCommandUnitCursors" (\fields -> JobCheckpointCommandUnitCursors <$> traverse parseJSON (withoutFields [] fields))
instance ToJSON JobCheckpointCommandUnitCursors where toJSON value = Object (KM.fromList (concat []) <> fmap toJSON (withoutFields [] (jobCheckpointCommandUnitCursorsAdditionalProperties value)))
