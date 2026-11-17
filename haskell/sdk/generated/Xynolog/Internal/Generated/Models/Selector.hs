-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.Selector (Selector(..)) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..))
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.FragmentSelector
import Xynolog.Internal.Generated.Models.SvgSelector
import Xynolog.Internal.Generated.Models.TextPositionSelector
import Xynolog.Internal.Generated.Models.TextQuoteSelector
data Selector = SelectorBranch1 TextPositionSelector | SelectorBranch2 TextQuoteSelector | SelectorBranch3 SvgSelector | SelectorBranch4 FragmentSelector deriving (Eq, Show)
instance FromJSON Selector where parseJSON = checked "Selector" $ \value -> (SelectorBranch1 <$> parseJSON value) <|> (SelectorBranch2 <$> parseJSON value) <|> (SelectorBranch3 <$> parseJSON value) <|> (SelectorBranch4 <$> parseJSON value)
instance ToJSON Selector where
  toJSON (SelectorBranch1 value) = toJSON value
  toJSON (SelectorBranch2 value) = toJSON value
  toJSON (SelectorBranch3 value) = toJSON value
  toJSON (SelectorBranch4 value) = toJSON value
