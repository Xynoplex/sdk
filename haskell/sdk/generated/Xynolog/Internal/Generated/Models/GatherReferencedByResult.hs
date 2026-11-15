-- Generated from protocol/specs/src. Run xynolog-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynolog.Internal.Generated.Models.GatherReferencedByResult
  ( GatherReferencedByResult(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Types.Presence (Presence)
import Xynolog.Internal.Generated.Models.GetReferencedByResponse
data GatherReferencedByResult = GatherReferencedByResult { gatherReferencedByResultResponse :: GetReferencedByResponse, gatherReferencedByResultAdditionalProperties :: KM.KeyMap (Value) } deriving (Eq, Show)
instance FromJSON GatherReferencedByResult where
  parseJSON = checked "GatherReferencedByResult" $ withObject "GatherReferencedByResult" (\fields -> GatherReferencedByResult <$> fields .: "response" <*> traverse parseJSON (withoutFields ["response"] fields))
instance ToJSON GatherReferencedByResult where toJSON value = Object (KM.fromList (concat [[("response", toJSON (gatherReferencedByResultResponse value))]]) <> fmap toJSON (withoutFields ["response"] (gatherReferencedByResultAdditionalProperties value)))
