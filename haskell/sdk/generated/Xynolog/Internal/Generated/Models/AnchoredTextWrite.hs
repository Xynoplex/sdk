-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.AnchoredTextWrite (AnchoredTextWrite(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.AnchoredTextEntry
data AnchoredTextWrite = AnchoredTextWrite
  { anchoredTextWriteContentChecksum :: Text
  , anchoredTextWriteEntry :: AnchoredTextEntry
  } deriving (Eq, Show)
instance FromJSON AnchoredTextWrite where parseJSON = checked "AnchoredTextWrite" $ withObject "AnchoredTextWrite" (\fields -> AnchoredTextWrite <$> (fields .: "contentChecksum") <*> (fields .: "entry"))
instance ToJSON AnchoredTextWrite where toJSON value = Object (KM.fromList (concat [[("contentChecksum", toJSON (anchoredTextWriteContentChecksum value))], [("entry", toJSON (anchoredTextWriteEntry value))]]))
