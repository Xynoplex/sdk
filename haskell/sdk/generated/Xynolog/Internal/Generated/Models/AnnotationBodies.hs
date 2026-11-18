-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.AnnotationBodies (AnnotationBodies (..)) where

import Control.Applicative ((<|>))
import Data.Aeson (FromJSON (..), ToJSON (..))
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.AnnotationBody

data AnnotationBodies = AnnotationBodiesBranch1 AnnotationBody | AnnotationBodiesBranch2 [AnnotationBody] deriving (Eq, Show)

instance FromJSON AnnotationBodies where parseJSON = checked "AnnotationBodies" $ \value -> (AnnotationBodiesBranch1 <$> parseJSON value) <|> (AnnotationBodiesBranch2 <$> parseJSON value)

instance ToJSON AnnotationBodies where
  toJSON (AnnotationBodiesBranch1 value) = toJSON value
  toJSON (AnnotationBodiesBranch2 value) = toJSON value
