-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.AnchoredTextEntries (AnchoredTextEntries(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Data.Text (Text)
import Xynolog.Internal.Codec
data AnchoredTextEntries = AnchoredTextEntries
  { anchoredTextEntriesChecksums :: [Text]
  } deriving (Eq, Show)
instance FromJSON AnchoredTextEntries where parseJSON = checked "AnchoredTextEntries" $ withObject "AnchoredTextEntries" (\fields -> AnchoredTextEntries <$> (fields .: "checksums"))
instance ToJSON AnchoredTextEntries where toJSON value = Object (KM.fromList (concat [[("checksums", toJSON (anchoredTextEntriesChecksums value))]]))
