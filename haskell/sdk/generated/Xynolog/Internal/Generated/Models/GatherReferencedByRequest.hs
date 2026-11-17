-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.GatherReferencedByRequest (GatherReferencedByRequest(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.Motivation
import Xynolog.Internal.Generated.Models.ResourceId
data GatherReferencedByRequest = GatherReferencedByRequest
  { gatherReferencedByRequestMotivation :: Maybe Motivation
  , gatherReferencedByRequestResourceId :: ResourceId
  , gatherReferencedByRequestAdditionalProperties :: KM.KeyMap Value
  } deriving (Eq, Show)
instance FromJSON GatherReferencedByRequest where parseJSON = checked "GatherReferencedByRequest" $ withObject "GatherReferencedByRequest" (\fields -> GatherReferencedByRequest <$> optional fields "motivation" <*> (fields .: "resourceId") <*> traverse parseJSON (withoutFields ["motivation", "resourceId"] fields))
instance ToJSON GatherReferencedByRequest where toJSON value = Object (KM.fromList (concat [optionalPair "motivation" (gatherReferencedByRequestMotivation value), [("resourceId", toJSON (gatherReferencedByRequestResourceId value))]]) <> fmap toJSON (withoutFields ["motivation", "resourceId"] (gatherReferencedByRequestAdditionalProperties value)))
