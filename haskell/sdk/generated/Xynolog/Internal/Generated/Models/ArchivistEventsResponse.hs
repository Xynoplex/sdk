-- Generated from protocol/specs/src. Run xynolog-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynolog.Internal.Generated.Models.ArchivistEventsResponse
  ( ArchivistEventsResponse(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Types.Presence (Presence)
import Xynolog.Internal.Generated.Models.StoredEventResponse
data ArchivistEventsResponse = ArchivistEventsResponse { archivistEventsResponseEvents :: [StoredEventResponse], archivistEventsResponseLastSequence :: Integer, archivistEventsResponseAdditionalProperties :: KM.KeyMap (Value) } deriving (Eq, Show)
instance FromJSON ArchivistEventsResponse where
  parseJSON = checked "ArchivistEventsResponse" $ withObject "ArchivistEventsResponse" (\fields -> ArchivistEventsResponse <$> fields .: "events" <*> fields .: "lastSequence" <*> traverse parseJSON (withoutFields ["events", "lastSequence"] fields))
instance ToJSON ArchivistEventsResponse where toJSON value = Object (KM.fromList (concat [[("events", toJSON (archivistEventsResponseEvents value))], [("lastSequence", toJSON (archivistEventsResponseLastSequence value))]]) <> fmap toJSON (withoutFields ["events", "lastSequence"] (archivistEventsResponseAdditionalProperties value)))
