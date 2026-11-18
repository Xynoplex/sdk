-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.AnnotationSelector (AnnotationSelector (..)) where

import Control.Applicative ((<|>))
import Data.Aeson (FromJSON (..), ToJSON (..))
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.Selector

data AnnotationSelector = AnnotationSelectorBranch1 Selector | AnnotationSelectorBranch2 [Selector] deriving (Eq, Show)

instance FromJSON AnnotationSelector where parseJSON = checked "AnnotationSelector" $ \value -> (AnnotationSelectorBranch1 <$> parseJSON value) <|> (AnnotationSelectorBranch2 <$> parseJSON value)

instance ToJSON AnnotationSelector where
  toJSON (AnnotationSelectorBranch1 value) = toJSON value
  toJSON (AnnotationSelectorBranch2 value) = toJSON value
