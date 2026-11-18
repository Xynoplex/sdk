-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.OneOrMoreStrings (OneOrMoreStrings(..)) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..))
import Data.Text (Text)
import Xynolog.Internal.Codec
data OneOrMoreStrings = OneOrMoreStringsBranch1 Text | OneOrMoreStringsBranch2 [Text] deriving (Eq, Show)
instance FromJSON OneOrMoreStrings where parseJSON = checked "OneOrMoreStrings" $ \value -> (OneOrMoreStringsBranch1 <$> parseJSON value) <|> (OneOrMoreStringsBranch2 <$> parseJSON value)
instance ToJSON OneOrMoreStrings where
  toJSON (OneOrMoreStringsBranch1 value) = toJSON value
  toJSON (OneOrMoreStringsBranch2 value) = toJSON value
