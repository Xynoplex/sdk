-- Generated from protocol/specs/src. Run xynolog-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynolog.Internal.Generated.Models.MatchSearchResult
  ( MatchSearchResult(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Types.Presence (Presence)
import Xynolog.Internal.Generated.Models.AnnotationId
import Xynolog.Internal.Generated.Models.ScoredResource
data MatchSearchResult = MatchSearchResult { matchSearchResultReferenceId :: AnnotationId, matchSearchResultResponse :: [ScoredResource], matchSearchResultAdditionalProperties :: KM.KeyMap (Value) } deriving (Eq, Show)
instance FromJSON MatchSearchResult where
  parseJSON = checked "MatchSearchResult" $ withObject "MatchSearchResult" (\fields -> MatchSearchResult <$> fields .: "referenceId" <*> fields .: "response" <*> traverse parseJSON (withoutFields ["referenceId", "response"] fields))
instance ToJSON MatchSearchResult where toJSON value = Object (KM.fromList (concat [[("referenceId", toJSON (matchSearchResultReferenceId value))], [("response", toJSON (matchSearchResultResponse value))]]) <> fmap toJSON (withoutFields ["referenceId", "response"] (matchSearchResultAdditionalProperties value)))
