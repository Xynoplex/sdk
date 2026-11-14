-- Generated from protocol/specs/src. Run xynoplex-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynoplex.Internal.Generated.Models.UpdateAnnotationBodyRequest
  ( UpdateAnnotationBodyRequest(..)
  , UpdateAnnotationBodyRequestOperationsItem(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynoplex.Internal.Codec
import Xynoplex.Types.Presence (Presence)
import Xynoplex.Internal.Generated.Models.BodyOperationAdd
import Xynoplex.Internal.Generated.Models.BodyOperationRemove
import Xynoplex.Internal.Generated.Models.BodyOperationReplace
import Xynoplex.Internal.Generated.Models.ResourceId
data UpdateAnnotationBodyRequest = UpdateAnnotationBodyRequest { updateAnnotationBodyRequestOperations :: [UpdateAnnotationBodyRequestOperationsItem], updateAnnotationBodyRequestResourceId :: ResourceId, updateAnnotationBodyRequestAdditionalProperties :: KM.KeyMap (Value) } deriving (Eq, Show)
instance FromJSON UpdateAnnotationBodyRequest where
  parseJSON = checked "UpdateAnnotationBodyRequest" $ withObject "UpdateAnnotationBodyRequest" (\fields -> UpdateAnnotationBodyRequest <$> fields .: "operations" <*> fields .: "resourceId" <*> traverse parseJSON (withoutFields ["operations", "resourceId"] fields))
instance ToJSON UpdateAnnotationBodyRequest where toJSON value = Object (KM.fromList (concat [[("operations", toJSON (updateAnnotationBodyRequestOperations value))], [("resourceId", toJSON (updateAnnotationBodyRequestResourceId value))]]) <> fmap toJSON (withoutFields ["operations", "resourceId"] (updateAnnotationBodyRequestAdditionalProperties value)))

data UpdateAnnotationBodyRequestOperationsItem = UpdateAnnotationBodyRequestOperationsItemBranch1 (BodyOperationAdd) | UpdateAnnotationBodyRequestOperationsItemBranch2 (BodyOperationRemove) | UpdateAnnotationBodyRequestOperationsItemBranch3 (BodyOperationReplace) deriving (Eq, Show)
instance FromJSON UpdateAnnotationBodyRequestOperationsItem where
  parseJSON = checked "UpdateAnnotationBodyRequestOperationsItem" $ \value -> (UpdateAnnotationBodyRequestOperationsItemBranch1 <$> parseJSON value) <|> (UpdateAnnotationBodyRequestOperationsItemBranch2 <$> parseJSON value) <|> (UpdateAnnotationBodyRequestOperationsItemBranch3 <$> parseJSON value)
instance ToJSON UpdateAnnotationBodyRequestOperationsItem where
  toJSON (UpdateAnnotationBodyRequestOperationsItemBranch1 value) = toJSON value
  toJSON (UpdateAnnotationBodyRequestOperationsItemBranch2 value) = toJSON value
  toJSON (UpdateAnnotationBodyRequestOperationsItemBranch3 value) = toJSON value
