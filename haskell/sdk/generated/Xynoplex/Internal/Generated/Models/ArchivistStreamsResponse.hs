-- Generated from protocol/specs/src. Run xynoplex-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynoplex.Internal.Generated.Models.ArchivistStreamsResponse
  ( ArchivistStreamsResponse(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynoplex.Internal.Codec
import Xynoplex.Types.Presence (Presence)
import Xynoplex.Internal.Generated.Models.ArchivistStream
data ArchivistStreamsResponse = ArchivistStreamsResponse { archivistStreamsResponseStreams :: [ArchivistStream] } deriving (Eq, Show)
instance FromJSON ArchivistStreamsResponse where
  parseJSON = checked "ArchivistStreamsResponse" $ withObject "ArchivistStreamsResponse" (\fields -> ArchivistStreamsResponse <$> fields .: "streams")
instance ToJSON ArchivistStreamsResponse where toJSON value = Object (KM.fromList (concat [[("streams", toJSON (archivistStreamsResponseStreams value))]]))
