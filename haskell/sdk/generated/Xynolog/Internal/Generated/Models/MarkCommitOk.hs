-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.MarkCommitOk (MarkCommitOk(..), MarkCommitOkResponse(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.AnnotationId
data MarkCommitOk = MarkCommitOk
  { markCommitOkResponse :: MarkCommitOkResponse
  , markCommitOkAdditionalProperties :: KM.KeyMap Value
  } deriving (Eq, Show)
instance FromJSON MarkCommitOk where parseJSON = checked "MarkCommitOk" $ withObject "MarkCommitOk" (\fields -> MarkCommitOk <$> (fields .: "response") <*> traverse parseJSON (withoutFields ["response"] fields))
instance ToJSON MarkCommitOk where toJSON value = Object (KM.fromList (concat [[("response", toJSON (markCommitOkResponse value))]]) <> fmap toJSON (withoutFields ["response"] (markCommitOkAdditionalProperties value)))
data MarkCommitOkResponse = MarkCommitOkResponse
  { markCommitOkResponseAnnotationIds :: [AnnotationId]
  , markCommitOkResponsePersisted :: Integer
  , markCommitOkResponseAdditionalProperties :: KM.KeyMap Value
  } deriving (Eq, Show)
instance FromJSON MarkCommitOkResponse where parseJSON = checked "MarkCommitOkResponse" $ withObject "MarkCommitOkResponse" (\fields -> MarkCommitOkResponse <$> (fields .: "annotationIds") <*> (fields .: "persisted") <*> traverse parseJSON (withoutFields ["annotationIds", "persisted"] fields))
instance ToJSON MarkCommitOkResponse where toJSON value = Object (KM.fromList (concat [[("annotationIds", toJSON (markCommitOkResponseAnnotationIds value))], [("persisted", toJSON (markCommitOkResponsePersisted value))]]) <> fmap toJSON (withoutFields ["annotationIds", "persisted"] (markCommitOkResponseAdditionalProperties value)))
