-- Generated from protocol/specs/src. Run xynolog-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynolog.Internal.Generated.Models.AnnotationSelector
  ( AnnotationSelector(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Types.Presence (Presence)
import Xynolog.Internal.Generated.Models.Selector
data AnnotationSelector = AnnotationSelectorBranch1 (Selector) | AnnotationSelectorBranch2 ([Selector]) deriving (Eq, Show)
instance FromJSON AnnotationSelector where
  parseJSON = checked "AnnotationSelector" $ \value -> (AnnotationSelectorBranch1 <$> parseJSON value) <|> (AnnotationSelectorBranch2 <$> parseJSON value)
instance ToJSON AnnotationSelector where
  toJSON (AnnotationSelectorBranch1 value) = toJSON value
  toJSON (AnnotationSelectorBranch2 value) = toJSON value
