-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.MarkDeleteOk (MarkDeleteOk (..), MarkDeleteOkResponse (..)) where

import Data.Aeson (FromJSON (..), ToJSON (..), Value (..), withObject, (.:))
import Data.Aeson.KeyMap qualified as KM
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.AnnotationId

data MarkDeleteOk = MarkDeleteOk
  { markDeleteOkResponse :: MarkDeleteOkResponse,
    markDeleteOkAdditionalProperties :: KM.KeyMap Value
  }
  deriving (Eq, Show)

instance FromJSON MarkDeleteOk where parseJSON = checked "MarkDeleteOk" $ withObject "MarkDeleteOk" (\fields -> MarkDeleteOk <$> (fields .: "response") <*> traverse parseJSON (withoutFields ["response"] fields))

instance ToJSON MarkDeleteOk where toJSON value = Object (KM.fromList (concat [[("response", toJSON (markDeleteOkResponse value))]]) <> fmap toJSON (withoutFields ["response"] (markDeleteOkAdditionalProperties value)))

data MarkDeleteOkResponse = MarkDeleteOkResponse
  { markDeleteOkResponseAnnotationId :: AnnotationId,
    markDeleteOkResponseAdditionalProperties :: KM.KeyMap Value
  }
  deriving (Eq, Show)

instance FromJSON MarkDeleteOkResponse where parseJSON = checked "MarkDeleteOkResponse" $ withObject "MarkDeleteOkResponse" (\fields -> MarkDeleteOkResponse <$> (fields .: "annotationId") <*> traverse parseJSON (withoutFields ["annotationId"] fields))

instance ToJSON MarkDeleteOkResponse where toJSON value = Object (KM.fromList (concat [[("annotationId", toJSON (markDeleteOkResponseAnnotationId value))]]) <> fmap toJSON (withoutFields ["annotationId"] (markDeleteOkResponseAdditionalProperties value)))
