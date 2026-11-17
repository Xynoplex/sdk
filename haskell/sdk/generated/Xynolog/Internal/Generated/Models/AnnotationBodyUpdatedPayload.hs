-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.AnnotationBodyUpdatedPayload (AnnotationBodyUpdatedPayload(..), AnnotationBodyUpdatedPayloadOperationsItem(..)) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.AnnotationId
import Xynolog.Internal.Generated.Models.BodyOperationAdd
import Xynolog.Internal.Generated.Models.BodyOperationRemove
import Xynolog.Internal.Generated.Models.BodyOperationReplace
data AnnotationBodyUpdatedPayload = AnnotationBodyUpdatedPayload
  { annotationBodyUpdatedPayloadAnnotationId :: AnnotationId
  , annotationBodyUpdatedPayloadOperations :: [AnnotationBodyUpdatedPayloadOperationsItem]
  , annotationBodyUpdatedPayloadAdditionalProperties :: KM.KeyMap Value
  } deriving (Eq, Show)
instance FromJSON AnnotationBodyUpdatedPayload where parseJSON = checked "AnnotationBodyUpdatedPayload" $ withObject "AnnotationBodyUpdatedPayload" (\fields -> AnnotationBodyUpdatedPayload <$> (fields .: "annotationId") <*> (fields .: "operations") <*> traverse parseJSON (withoutFields ["annotationId", "operations"] fields))
instance ToJSON AnnotationBodyUpdatedPayload where toJSON value = Object (KM.fromList (concat [[("annotationId", toJSON (annotationBodyUpdatedPayloadAnnotationId value))], [("operations", toJSON (annotationBodyUpdatedPayloadOperations value))]]) <> fmap toJSON (withoutFields ["annotationId", "operations"] (annotationBodyUpdatedPayloadAdditionalProperties value)))
data AnnotationBodyUpdatedPayloadOperationsItem = AnnotationBodyUpdatedPayloadOperationsItemBranch1 BodyOperationAdd | AnnotationBodyUpdatedPayloadOperationsItemBranch2 BodyOperationRemove | AnnotationBodyUpdatedPayloadOperationsItemBranch3 BodyOperationReplace deriving (Eq, Show)
instance FromJSON AnnotationBodyUpdatedPayloadOperationsItem where parseJSON = checked "AnnotationBodyUpdatedPayloadOperationsItem" $ \value -> (AnnotationBodyUpdatedPayloadOperationsItemBranch1 <$> parseJSON value) <|> (AnnotationBodyUpdatedPayloadOperationsItemBranch2 <$> parseJSON value) <|> (AnnotationBodyUpdatedPayloadOperationsItemBranch3 <$> parseJSON value)
instance ToJSON AnnotationBodyUpdatedPayloadOperationsItem where
  toJSON (AnnotationBodyUpdatedPayloadOperationsItemBranch1 value) = toJSON value
  toJSON (AnnotationBodyUpdatedPayloadOperationsItemBranch2 value) = toJSON value
  toJSON (AnnotationBodyUpdatedPayloadOperationsItemBranch3 value) = toJSON value
