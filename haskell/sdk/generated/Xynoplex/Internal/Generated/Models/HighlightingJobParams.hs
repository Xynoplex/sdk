-- Generated from protocol/specs/src. Run xynoplex-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynoplex.Internal.Generated.Models.HighlightingJobParams
  ( HighlightingJobParams(..)
  , HighlightingJobParamsMotivation(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynoplex.Internal.Codec
import Xynoplex.Types.Presence (Presence)
data HighlightingJobParams = HighlightingJobParams { highlightingJobParamsDensity :: Maybe (Scientific), highlightingJobParamsInstructions :: Maybe (Text), highlightingJobParamsMotivation :: HighlightingJobParamsMotivation, highlightingJobParamsSourceLanguage :: Maybe (Text) } deriving (Eq, Show)
instance FromJSON HighlightingJobParams where
  parseJSON = checked "HighlightingJobParams" $ withObject "HighlightingJobParams" (\fields -> HighlightingJobParams <$> optional fields "density" <*> optional fields "instructions" <*> fields .: "motivation" <*> optional fields "sourceLanguage")
instance ToJSON HighlightingJobParams where toJSON value = Object (KM.fromList (concat [optionalPair "density" (highlightingJobParamsDensity value), optionalPair "instructions" (highlightingJobParamsInstructions value), [("motivation", toJSON (highlightingJobParamsMotivation value))], optionalPair "sourceLanguage" (highlightingJobParamsSourceLanguage value)]))

data HighlightingJobParamsMotivation = HighlightingJobParamsMotivationHighlighting deriving (Eq, Show)
instance FromJSON HighlightingJobParamsMotivation where
  parseJSON = checked "HighlightingJobParamsMotivation" $ \value -> if value == (String "highlighting") then pure HighlightingJobParamsMotivationHighlighting else fail "unknown enumeration member"
instance ToJSON HighlightingJobParamsMotivation where
  toJSON HighlightingJobParamsMotivationHighlighting = String "highlighting"
