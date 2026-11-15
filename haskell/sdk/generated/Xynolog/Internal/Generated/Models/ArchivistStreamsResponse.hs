-- Generated from protocol/specs/src. Run xynolog-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynolog.Internal.Generated.Models.ArchivistStreamsResponse
  ( ArchivistStreamsResponse(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Types.Presence (Presence)
import Xynolog.Internal.Generated.Models.ArchivistStream
data ArchivistStreamsResponse = ArchivistStreamsResponse { archivistStreamsResponseStreams :: [ArchivistStream] } deriving (Eq, Show)
instance FromJSON ArchivistStreamsResponse where
  parseJSON = checked "ArchivistStreamsResponse" $ withObject "ArchivistStreamsResponse" (\fields -> ArchivistStreamsResponse <$> fields .: "streams")
instance ToJSON ArchivistStreamsResponse where toJSON value = Object (KM.fromList (concat [[("streams", toJSON (archivistStreamsResponseStreams value))]]))
