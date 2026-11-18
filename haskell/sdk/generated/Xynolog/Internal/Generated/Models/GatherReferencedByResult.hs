-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.GatherReferencedByResult (GatherReferencedByResult(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.GetReferencedByResponse
data GatherReferencedByResult = GatherReferencedByResult
  { gatherReferencedByResultResponse :: GetReferencedByResponse
  , gatherReferencedByResultAdditionalProperties :: KM.KeyMap Value
  } deriving (Eq, Show)
instance FromJSON GatherReferencedByResult where parseJSON = checked "GatherReferencedByResult" $ withObject "GatherReferencedByResult" (\fields -> GatherReferencedByResult <$> (fields .: "response") <*> traverse parseJSON (withoutFields ["response"] fields))
instance ToJSON GatherReferencedByResult where toJSON value = Object (KM.fromList (concat [[("response", toJSON (gatherReferencedByResultResponse value))]]) <> fmap toJSON (withoutFields ["response"] (gatherReferencedByResultAdditionalProperties value)))
