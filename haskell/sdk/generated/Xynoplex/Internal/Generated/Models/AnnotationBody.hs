-- Generated from protocol/specs/src. Run xynoplex-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynoplex.Internal.Generated.Models.AnnotationBody
  ( AnnotationBody(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynoplex.Internal.Codec
import Xynoplex.Types.Presence (Presence)
import Xynoplex.Internal.Generated.Models.SpecificResource
import Xynoplex.Internal.Generated.Models.TextualBody
data AnnotationBody = AnnotationBodyBranch1 (TextualBody) | AnnotationBodyBranch2 (SpecificResource) deriving (Eq, Show)
instance FromJSON AnnotationBody where
  parseJSON = checked "AnnotationBody" $ \value -> (AnnotationBodyBranch1 <$> parseJSON value) <|> (AnnotationBodyBranch2 <$> parseJSON value)
instance ToJSON AnnotationBody where
  toJSON (AnnotationBodyBranch1 value) = toJSON value
  toJSON (AnnotationBodyBranch2 value) = toJSON value
