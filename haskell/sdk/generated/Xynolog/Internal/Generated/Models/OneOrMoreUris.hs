-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.OneOrMoreUris (OneOrMoreUris (..)) where

import Control.Applicative ((<|>))
import Data.Aeson (FromJSON (..), ToJSON (..))
import Data.Text (Text)
import Xynolog.Internal.Codec

data OneOrMoreUris = OneOrMoreUrisBranch1 Text | OneOrMoreUrisBranch2 [Text] deriving (Eq, Show)

instance FromJSON OneOrMoreUris where parseJSON = checked "OneOrMoreUris" $ \value -> (OneOrMoreUrisBranch1 <$> parseJSON value) <|> (OneOrMoreUrisBranch2 <$> parseJSON value)

instance ToJSON OneOrMoreUris where
  toJSON (OneOrMoreUrisBranch1 value) = toJSON value
  toJSON (OneOrMoreUrisBranch2 value) = toJSON value
