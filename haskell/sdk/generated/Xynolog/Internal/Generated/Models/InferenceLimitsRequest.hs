-- Generated from protocol/specs/src. Run xynolog-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynolog.Internal.Generated.Models.InferenceLimitsRequest
  ( InferenceLimitsRequest(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Types.Presence (Presence)
data InferenceLimitsRequest = InferenceLimitsRequest { inferenceLimitsRequestAdditionalProperties :: KM.KeyMap (Value) } deriving (Eq, Show)
instance FromJSON InferenceLimitsRequest where
  parseJSON = checked "InferenceLimitsRequest" $ withObject "InferenceLimitsRequest" (\fields -> InferenceLimitsRequest <$> traverse parseJSON (withoutFields [] fields))
instance ToJSON InferenceLimitsRequest where toJSON value = Object (KM.fromList (concat []) <> fmap toJSON (withoutFields [] (inferenceLimitsRequestAdditionalProperties value)))
