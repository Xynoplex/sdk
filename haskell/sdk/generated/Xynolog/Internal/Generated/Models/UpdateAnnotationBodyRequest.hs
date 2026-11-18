-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.UpdateAnnotationBodyRequest (UpdateAnnotationBodyRequest (..), UpdateAnnotationBodyRequestOperationsItem (..)) where

import Control.Applicative ((<|>))
import Data.Aeson (FromJSON (..), ToJSON (..), Value (..), withObject, (.:))
import Data.Aeson.KeyMap qualified as KM
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.BodyOperationAdd
import Xynolog.Internal.Generated.Models.BodyOperationRemove
import Xynolog.Internal.Generated.Models.BodyOperationReplace
import Xynolog.Internal.Generated.Models.ResourceId

data UpdateAnnotationBodyRequest = UpdateAnnotationBodyRequest
  { updateAnnotationBodyRequestOperations :: [UpdateAnnotationBodyRequestOperationsItem],
    updateAnnotationBodyRequestResourceId :: ResourceId,
    updateAnnotationBodyRequestAdditionalProperties :: KM.KeyMap Value
  }
  deriving (Eq, Show)

instance FromJSON UpdateAnnotationBodyRequest where parseJSON = checked "UpdateAnnotationBodyRequest" $ withObject "UpdateAnnotationBodyRequest" (\fields -> UpdateAnnotationBodyRequest <$> (fields .: "operations") <*> (fields .: "resourceId") <*> traverse parseJSON (withoutFields ["operations", "resourceId"] fields))

instance ToJSON UpdateAnnotationBodyRequest where toJSON value = Object (KM.fromList (concat [[("operations", toJSON (updateAnnotationBodyRequestOperations value))], [("resourceId", toJSON (updateAnnotationBodyRequestResourceId value))]]) <> fmap toJSON (withoutFields ["operations", "resourceId"] (updateAnnotationBodyRequestAdditionalProperties value)))

data UpdateAnnotationBodyRequestOperationsItem = UpdateAnnotationBodyRequestOperationsItemBranch1 BodyOperationAdd | UpdateAnnotationBodyRequestOperationsItemBranch2 BodyOperationRemove | UpdateAnnotationBodyRequestOperationsItemBranch3 BodyOperationReplace deriving (Eq, Show)

instance FromJSON UpdateAnnotationBodyRequestOperationsItem where parseJSON = checked "UpdateAnnotationBodyRequestOperationsItem" $ \value -> (UpdateAnnotationBodyRequestOperationsItemBranch1 <$> parseJSON value) <|> (UpdateAnnotationBodyRequestOperationsItemBranch2 <$> parseJSON value) <|> (UpdateAnnotationBodyRequestOperationsItemBranch3 <$> parseJSON value)

instance ToJSON UpdateAnnotationBodyRequestOperationsItem where
  toJSON (UpdateAnnotationBodyRequestOperationsItemBranch1 value) = toJSON value
  toJSON (UpdateAnnotationBodyRequestOperationsItemBranch2 value) = toJSON value
  toJSON (UpdateAnnotationBodyRequestOperationsItemBranch3 value) = toJSON value
