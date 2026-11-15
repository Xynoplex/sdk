-- Generated from protocol/specs/src. Run xynolog-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynolog.Internal.Generated.Models.AnchoredTextEntries
  ( AnchoredTextEntries(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Types.Presence (Presence)
data AnchoredTextEntries = AnchoredTextEntries { anchoredTextEntriesChecksums :: [Text] } deriving (Eq, Show)
instance FromJSON AnchoredTextEntries where
  parseJSON = checked "AnchoredTextEntries" $ withObject "AnchoredTextEntries" (\fields -> AnchoredTextEntries <$> fields .: "checksums")
instance ToJSON AnchoredTextEntries where toJSON value = Object (KM.fromList (concat [[("checksums", toJSON (anchoredTextEntriesChecksums value))]]))
