-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.CreateAnnotationRequest (CreateAnnotationRequest (..)) where

import Data.Aeson (FromJSON (..), ToJSON (..), Value (..), withObject, (.:))
import Data.Aeson.KeyMap qualified as KM
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.AnnotationBodies
import Xynolog.Internal.Generated.Models.AnnotationTarget
import Xynolog.Internal.Generated.Models.Motivation

data CreateAnnotationRequest = CreateAnnotationRequest
  { createAnnotationRequestBody :: Maybe AnnotationBodies,
    createAnnotationRequestMotivation :: Motivation,
    createAnnotationRequestTarget :: AnnotationTarget,
    createAnnotationRequestAdditionalProperties :: KM.KeyMap Value
  }
  deriving (Eq, Show)

instance FromJSON CreateAnnotationRequest where parseJSON = checked "CreateAnnotationRequest" $ withObject "CreateAnnotationRequest" (\fields -> CreateAnnotationRequest <$> optional fields "body" <*> (fields .: "motivation") <*> (fields .: "target") <*> traverse parseJSON (withoutFields ["body", "motivation", "target"] fields))

instance ToJSON CreateAnnotationRequest where toJSON value = Object (KM.fromList (concat [optionalPair "body" (createAnnotationRequestBody value), [("motivation", toJSON (createAnnotationRequestMotivation value))], [("target", toJSON (createAnnotationRequestTarget value))]]) <> fmap toJSON (withoutFields ["body", "motivation", "target"] (createAnnotationRequestAdditionalProperties value)))
