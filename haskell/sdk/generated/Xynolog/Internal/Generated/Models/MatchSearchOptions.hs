-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.MatchSearchOptions (MatchSearchOptions(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject)
import qualified Data.Aeson.KeyMap as KM
import Xynolog.Internal.Codec
data MatchSearchOptions = MatchSearchOptions
  { matchSearchOptionsLimit :: Maybe Integer
  , matchSearchOptionsUseSemanticScoring :: Maybe Bool
  , matchSearchOptionsAdditionalProperties :: KM.KeyMap Value
  } deriving (Eq, Show)
instance FromJSON MatchSearchOptions where parseJSON = checked "MatchSearchOptions" $ withObject "MatchSearchOptions" (\fields -> MatchSearchOptions <$> optional fields "limit" <*> optional fields "useSemanticScoring" <*> traverse parseJSON (withoutFields ["limit", "useSemanticScoring"] fields))
instance ToJSON MatchSearchOptions where toJSON value = Object (KM.fromList (concat [optionalPair "limit" (matchSearchOptionsLimit value), optionalPair "useSemanticScoring" (matchSearchOptionsUseSemanticScoring value)]) <> fmap toJSON (withoutFields ["limit", "useSemanticScoring"] (matchSearchOptionsAdditionalProperties value)))
