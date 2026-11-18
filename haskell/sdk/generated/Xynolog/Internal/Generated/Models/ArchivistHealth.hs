-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.ArchivistHealth (ArchivistHealth (..), ArchivistHealthStatus (..)) where

import Data.Aeson (FromJSON (..), ToJSON (..), Value (..), withObject, (.:))
import Data.Aeson.KeyMap qualified as KM
import Data.Text (Text)
import Xynolog.Internal.Codec

data ArchivistHealth = ArchivistHealth
  { archivistHealthActors :: [Text],
    archivistHealthStatus :: ArchivistHealthStatus,
    archivistHealthAdditionalProperties :: KM.KeyMap Value
  }
  deriving (Eq, Show)

instance FromJSON ArchivistHealth where parseJSON = checked "ArchivistHealth" $ withObject "ArchivistHealth" (\fields -> ArchivistHealth <$> (fields .: "actors") <*> (fields .: "status") <*> traverse parseJSON (withoutFields ["actors", "status"] fields))

instance ToJSON ArchivistHealth where toJSON value = Object (KM.fromList (concat [[("actors", toJSON (archivistHealthActors value))], [("status", toJSON (archivistHealthStatus value))]]) <> fmap toJSON (withoutFields ["actors", "status"] (archivistHealthAdditionalProperties value)))

data ArchivistHealthStatus = ArchivistHealthStatusOk deriving (Eq, Show)

instance FromJSON ArchivistHealthStatus where parseJSON = checked "ArchivistHealthStatus" $ \value -> if value == String "ok" then pure ArchivistHealthStatusOk else fail "unknown enumeration member"

instance ToJSON ArchivistHealthStatus where toJSON ArchivistHealthStatusOk = String "ok"
