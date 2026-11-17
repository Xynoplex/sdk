-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.BrowseKbResult (BrowseKbResult(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.KbDescription
data BrowseKbResult = BrowseKbResult
  { browseKbResultResponse :: KbDescription
  , browseKbResultAdditionalProperties :: KM.KeyMap Value
  } deriving (Eq, Show)
instance FromJSON BrowseKbResult where parseJSON = checked "BrowseKbResult" $ withObject "BrowseKbResult" (\fields -> BrowseKbResult <$> (fields .: "response") <*> traverse parseJSON (withoutFields ["response"] fields))
instance ToJSON BrowseKbResult where toJSON value = Object (KM.fromList (concat [[("response", toJSON (browseKbResultResponse value))]]) <> fmap toJSON (withoutFields ["response"] (browseKbResultAdditionalProperties value)))
