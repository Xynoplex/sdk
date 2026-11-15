-- Generated from protocol/specs/src. Run xynolog-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynolog.Internal.Generated.Models.MatchResourcesResult
  ( MatchResourcesResult(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Types.Presence (Presence)
import Xynolog.Internal.Generated.Models.MatchResourcesResponse
data MatchResourcesResult = MatchResourcesResult { matchResourcesResultResponse :: MatchResourcesResponse, matchResourcesResultAdditionalProperties :: KM.KeyMap (Value) } deriving (Eq, Show)
instance FromJSON MatchResourcesResult where
  parseJSON = checked "MatchResourcesResult" $ withObject "MatchResourcesResult" (\fields -> MatchResourcesResult <$> fields .: "response" <*> traverse parseJSON (withoutFields ["response"] fields))
instance ToJSON MatchResourcesResult where toJSON value = Object (KM.fromList (concat [[("response", toJSON (matchResourcesResultResponse value))]]) <> fmap toJSON (withoutFields ["response"] (matchResourcesResultAdditionalProperties value)))
