-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.GatherResourceRequest (GatherResourceRequest(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.GatherResourceRequestOptions
import Xynolog.Internal.Generated.Models.ResourceId
data GatherResourceRequest = GatherResourceRequest
  { gatherResourceRequestOptions :: GatherResourceRequestOptions
  , gatherResourceRequestResourceId :: ResourceId
  , gatherResourceRequestAdditionalProperties :: KM.KeyMap Value
  } deriving (Eq, Show)
instance FromJSON GatherResourceRequest where parseJSON = checked "GatherResourceRequest" $ withObject "GatherResourceRequest" (\fields -> GatherResourceRequest <$> (fields .: "options") <*> (fields .: "resourceId") <*> traverse parseJSON (withoutFields ["options", "resourceId"] fields))
instance ToJSON GatherResourceRequest where toJSON value = Object (KM.fromList (concat [[("options", toJSON (gatherResourceRequestOptions value))], [("resourceId", toJSON (gatherResourceRequestResourceId value))]]) <> fmap toJSON (withoutFields ["options", "resourceId"] (gatherResourceRequestAdditionalProperties value)))
