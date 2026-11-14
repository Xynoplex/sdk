-- Generated from protocol/specs/src. Run xynoplex-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynoplex.Internal.Generated.Models.ArchivistStream
  ( ArchivistStream(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynoplex.Internal.Codec
import Xynoplex.Types.Presence (Presence)
import Xynoplex.Internal.Generated.Models.ResourceId
data ArchivistStream = ArchivistStream { archivistStreamLastSequence :: Integer, archivistStreamResourceId :: ResourceId } deriving (Eq, Show)
instance FromJSON ArchivistStream where
  parseJSON = checked "ArchivistStream" $ withObject "ArchivistStream" (\fields -> ArchivistStream <$> fields .: "lastSequence" <*> fields .: "resourceId")
instance ToJSON ArchivistStream where toJSON value = Object (KM.fromList (concat [[("lastSequence", toJSON (archivistStreamLastSequence value))], [("resourceId", toJSON (archivistStreamResourceId value))]]))
