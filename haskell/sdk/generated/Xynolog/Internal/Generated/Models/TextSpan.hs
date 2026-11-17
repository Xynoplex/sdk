-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.TextSpan (TextSpan(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Data.Text (Text)
import Xynolog.Internal.Codec
data TextSpan = TextSpan
  { textSpanEnd :: Integer
  , textSpanExact :: Text
  , textSpanPrefix :: Maybe Text
  , textSpanStart :: Integer
  , textSpanSuffix :: Maybe Text
  , textSpanAdditionalProperties :: KM.KeyMap Value
  } deriving (Eq, Show)
instance FromJSON TextSpan where parseJSON = checked "TextSpan" $ withObject "TextSpan" (\fields -> TextSpan <$> (fields .: "end") <*> (fields .: "exact") <*> optional fields "prefix" <*> (fields .: "start") <*> optional fields "suffix" <*> traverse parseJSON (withoutFields ["end", "exact", "prefix", "start", "suffix"] fields))
instance ToJSON TextSpan where toJSON value = Object (KM.fromList (concat [[("end", toJSON (textSpanEnd value))], [("exact", toJSON (textSpanExact value))], optionalPair "prefix" (textSpanPrefix value), [("start", toJSON (textSpanStart value))], optionalPair "suffix" (textSpanSuffix value)]) <> fmap toJSON (withoutFields ["end", "exact", "prefix", "start", "suffix"] (textSpanAdditionalProperties value)))
