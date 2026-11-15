-- Generated from protocol/specs/src. Run xynolog-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynolog.Internal.Generated.Models.QuotedText
  ( QuotedText(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Types.Presence (Presence)
data QuotedText = QuotedText { quotedTextExact :: Text, quotedTextPrefix :: Maybe (Text), quotedTextSuffix :: Maybe (Text), quotedTextAdditionalProperties :: KM.KeyMap (Value) } deriving (Eq, Show)
instance FromJSON QuotedText where
  parseJSON = checked "QuotedText" $ withObject "QuotedText" (\fields -> QuotedText <$> fields .: "exact" <*> optional fields "prefix" <*> optional fields "suffix" <*> traverse parseJSON (withoutFields ["exact", "prefix", "suffix"] fields))
instance ToJSON QuotedText where toJSON value = Object (KM.fromList (concat [[("exact", toJSON (quotedTextExact value))], optionalPair "prefix" (quotedTextPrefix value), optionalPair "suffix" (quotedTextSuffix value)]) <> fmap toJSON (withoutFields ["exact", "prefix", "suffix"] (quotedTextAdditionalProperties value)))
