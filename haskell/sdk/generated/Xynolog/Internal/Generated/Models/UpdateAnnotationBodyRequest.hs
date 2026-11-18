-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.UpdateAnnotationBodyRequest (UpdateAnnotationBodyRequest(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.BodyOperation
import Xynolog.Internal.Generated.Models.ResourceId
data UpdateAnnotationBodyRequest = UpdateAnnotationBodyRequest
  { updateAnnotationBodyRequestOperations :: [BodyOperation]
  , updateAnnotationBodyRequestResourceId :: ResourceId
  , updateAnnotationBodyRequestAdditionalProperties :: KM.KeyMap Value
  } deriving (Eq, Show)
instance FromJSON UpdateAnnotationBodyRequest where parseJSON = checked "UpdateAnnotationBodyRequest" $ withObject "UpdateAnnotationBodyRequest" (\fields -> UpdateAnnotationBodyRequest <$> (fields .: "operations") <*> (fields .: "resourceId") <*> traverse parseJSON (withoutFields ["operations", "resourceId"] fields))
instance ToJSON UpdateAnnotationBodyRequest where toJSON value = Object (KM.fromList (concat [[("operations", toJSON (updateAnnotationBodyRequestOperations value))], [("resourceId", toJSON (updateAnnotationBodyRequestResourceId value))]]) <> fmap toJSON (withoutFields ["operations", "resourceId"] (updateAnnotationBodyRequestAdditionalProperties value)))
