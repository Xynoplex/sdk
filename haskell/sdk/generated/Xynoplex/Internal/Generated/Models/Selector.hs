-- Generated from protocol/specs/src. Run xynoplex-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynoplex.Internal.Generated.Models.Selector
  ( Selector(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynoplex.Internal.Codec
import Xynoplex.Types.Presence (Presence)
import Xynoplex.Internal.Generated.Models.FragmentSelector
import Xynoplex.Internal.Generated.Models.SvgSelector
import Xynoplex.Internal.Generated.Models.TextPositionSelector
import Xynoplex.Internal.Generated.Models.TextQuoteSelector
data Selector = SelectorBranch1 (TextPositionSelector) | SelectorBranch2 (TextQuoteSelector) | SelectorBranch3 (SvgSelector) | SelectorBranch4 (FragmentSelector) deriving (Eq, Show)
instance FromJSON Selector where
  parseJSON = checked "Selector" $ \value -> (SelectorBranch1 <$> parseJSON value) <|> (SelectorBranch2 <$> parseJSON value) <|> (SelectorBranch3 <$> parseJSON value) <|> (SelectorBranch4 <$> parseJSON value)
instance ToJSON Selector where
  toJSON (SelectorBranch1 value) = toJSON value
  toJSON (SelectorBranch2 value) = toJSON value
  toJSON (SelectorBranch3 value) = toJSON value
  toJSON (SelectorBranch4 value) = toJSON value
