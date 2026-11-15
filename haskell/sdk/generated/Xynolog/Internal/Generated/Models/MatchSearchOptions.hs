-- Generated from protocol/specs/src. Run xynolog-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynolog.Internal.Generated.Models.MatchSearchOptions
  ( MatchSearchOptions(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Types.Presence (Presence)
data MatchSearchOptions = MatchSearchOptions { matchSearchOptionsLimit :: Maybe (Integer), matchSearchOptionsUseSemanticScoring :: Maybe (Bool), matchSearchOptionsAdditionalProperties :: KM.KeyMap (Value) } deriving (Eq, Show)
instance FromJSON MatchSearchOptions where
  parseJSON = checked "MatchSearchOptions" $ withObject "MatchSearchOptions" (\fields -> MatchSearchOptions <$> optional fields "limit" <*> optional fields "useSemanticScoring" <*> traverse parseJSON (withoutFields ["limit", "useSemanticScoring"] fields))
instance ToJSON MatchSearchOptions where toJSON value = Object (KM.fromList (concat [optionalPair "limit" (matchSearchOptionsLimit value), optionalPair "useSemanticScoring" (matchSearchOptionsUseSemanticScoring value)]) <> fmap toJSON (withoutFields ["limit", "useSemanticScoring"] (matchSearchOptionsAdditionalProperties value)))
