-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.TextSpan (TextSpan (..)) where

import Data.Aeson (FromJSON (..), ToJSON (..), Value (..), withObject, (.:))
import Data.Aeson.KeyMap qualified as KM
import Data.Text (Text)
import Xynolog.Internal.Codec

data TextSpan = TextSpan
  { textSpanEnd :: Integer,
    textSpanExact :: Text,
    textSpanPrefix :: Maybe Text,
    textSpanStart :: Integer,
    textSpanSuffix :: Maybe Text
  }
  deriving (Eq, Show)

instance FromJSON TextSpan where parseJSON = checked "TextSpan" $ withObject "TextSpan" (\fields -> TextSpan <$> (fields .: "end") <*> (fields .: "exact") <*> optional fields "prefix" <*> (fields .: "start") <*> optional fields "suffix")

instance ToJSON TextSpan where toJSON value = Object (KM.fromList (concat [[("end", toJSON (textSpanEnd value))], [("exact", toJSON (textSpanExact value))], optionalPair "prefix" (textSpanPrefix value), [("start", toJSON (textSpanStart value))], optionalPair "suffix" (textSpanSuffix value)]))
