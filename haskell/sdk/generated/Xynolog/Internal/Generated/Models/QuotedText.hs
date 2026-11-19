-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.QuotedText (QuotedText (..)) where

import Data.Aeson (FromJSON (..), ToJSON (..), Value (..), withObject, (.:))
import Data.Aeson.KeyMap qualified as KM
import Data.Text (Text)
import Xynolog.Internal.Codec

data QuotedText = QuotedText
  { quotedTextExact :: Text,
    quotedTextPrefix :: Maybe Text,
    quotedTextSuffix :: Maybe Text
  }
  deriving (Eq, Show)

instance FromJSON QuotedText where parseJSON = checked "QuotedText" $ withObject "QuotedText" (\fields -> QuotedText <$> (fields .: "exact") <*> optional fields "prefix" <*> optional fields "suffix")

instance ToJSON QuotedText where toJSON value = Object (KM.fromList (concat [[("exact", toJSON (quotedTextExact value))], optionalPair "prefix" (quotedTextPrefix value), optionalPair "suffix" (quotedTextSuffix value)]))
