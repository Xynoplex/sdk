-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.AnchoredTextStamp (AnchoredTextStamp(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Data.Text (Text)
import Xynolog.Internal.Codec
data AnchoredTextStamp = AnchoredTextStamp
  { anchoredTextStampStamp :: Text
  } deriving (Eq, Show)
instance FromJSON AnchoredTextStamp where parseJSON = checked "AnchoredTextStamp" $ withObject "AnchoredTextStamp" (\fields -> AnchoredTextStamp <$> (fields .: "stamp"))
instance ToJSON AnchoredTextStamp where toJSON value = Object (KM.fromList (concat [[("stamp", toJSON (anchoredTextStampStamp value))]]))
