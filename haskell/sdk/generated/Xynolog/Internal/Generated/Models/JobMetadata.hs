-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.JobMetadata (JobMetadata (..), JobMetadataUnitCursors (..)) where

import Data.Aeson (FromJSON (..), ToJSON (..), Value (..), withObject, (.:))
import Data.Aeson.KeyMap qualified as KM
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.JobId
import Xynolog.Internal.Generated.Models.JobType
import Xynolog.Internal.Generated.Models.UnitCursor
import Xynolog.Internal.Generated.Models.UserId

data JobMetadata = JobMetadata
  { jobMetadataCompletedUnits :: Maybe [Text],
    jobMetadataCreated :: Text,
    jobMetadataId :: JobId,
    jobMetadataMaxRetries :: Integer,
    jobMetadataRetryCount :: Integer,
    jobMetadataType :: JobType,
    jobMetadataUnitCursors :: Maybe JobMetadataUnitCursors,
    jobMetadataUserId :: UserId
  }
  deriving (Eq, Show)

instance FromJSON JobMetadata where parseJSON = checked "JobMetadata" $ withObject "JobMetadata" (\fields -> JobMetadata <$> optional fields "completedUnits" <*> (fields .: "created") <*> (fields .: "id") <*> (fields .: "maxRetries") <*> (fields .: "retryCount") <*> (fields .: "type") <*> optional fields "unitCursors" <*> (fields .: "userId"))

instance ToJSON JobMetadata where toJSON value = Object (KM.fromList (concat [optionalPair "completedUnits" (jobMetadataCompletedUnits value), [("created", toJSON (jobMetadataCreated value))], [("id", toJSON (jobMetadataId value))], [("maxRetries", toJSON (jobMetadataMaxRetries value))], [("retryCount", toJSON (jobMetadataRetryCount value))], [("type", toJSON (jobMetadataType value))], optionalPair "unitCursors" (jobMetadataUnitCursors value), [("userId", toJSON (jobMetadataUserId value))]]))

data JobMetadataUnitCursors = JobMetadataUnitCursors
  { jobMetadataUnitCursorsAdditionalProperties :: KM.KeyMap UnitCursor
  }
  deriving (Eq, Show)

instance FromJSON JobMetadataUnitCursors where parseJSON = checked "JobMetadataUnitCursors" $ withObject "JobMetadataUnitCursors" (\fields -> JobMetadataUnitCursors <$> traverse parseJSON (withoutFields [] fields))

instance ToJSON JobMetadataUnitCursors where toJSON value = Object (KM.fromList (concat []) <> fmap toJSON (withoutFields [] (jobMetadataUnitCursorsAdditionalProperties value)))
