-- Generated from protocol/specs/src. Run xynolog-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynolog.Internal.Generated.Models.ArchivistStream
  ( ArchivistStream(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Types.Presence (Presence)
import Xynolog.Internal.Generated.Models.ResourceId
data ArchivistStream = ArchivistStream { archivistStreamLastSequence :: Integer, archivistStreamResourceId :: ResourceId } deriving (Eq, Show)
instance FromJSON ArchivistStream where
  parseJSON = checked "ArchivistStream" $ withObject "ArchivistStream" (\fields -> ArchivistStream <$> fields .: "lastSequence" <*> fields .: "resourceId")
instance ToJSON ArchivistStream where toJSON value = Object (KM.fromList (concat [[("lastSequence", toJSON (archivistStreamLastSequence value))], [("resourceId", toJSON (archivistStreamResourceId value))]]))
