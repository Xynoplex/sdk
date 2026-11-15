-- Generated from protocol/specs/src. Run xynolog-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynolog.Internal.Generated.Models.AnnotationBodies
  ( AnnotationBodies(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Types.Presence (Presence)
import Xynolog.Internal.Generated.Models.AnnotationBody
data AnnotationBodies = AnnotationBodiesBranch1 (AnnotationBody) | AnnotationBodiesBranch2 ([AnnotationBody]) deriving (Eq, Show)
instance FromJSON AnnotationBodies where
  parseJSON = checked "AnnotationBodies" $ \value -> (AnnotationBodiesBranch1 <$> parseJSON value) <|> (AnnotationBodiesBranch2 <$> parseJSON value)
instance ToJSON AnnotationBodies where
  toJSON (AnnotationBodiesBranch1 value) = toJSON value
  toJSON (AnnotationBodiesBranch2 value) = toJSON value
