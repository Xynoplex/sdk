-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.ArchivistStreamsResponse (ArchivistStreamsResponse(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.ArchivistStream
data ArchivistStreamsResponse = ArchivistStreamsResponse
  { archivistStreamsResponseStreams :: [ArchivistStream]
  } deriving (Eq, Show)
instance FromJSON ArchivistStreamsResponse where parseJSON = checked "ArchivistStreamsResponse" $ withObject "ArchivistStreamsResponse" (\fields -> ArchivistStreamsResponse <$> (fields .: "streams"))
instance ToJSON ArchivistStreamsResponse where toJSON value = Object (KM.fromList (concat [[("streams", toJSON (archivistStreamsResponseStreams value))]]))
