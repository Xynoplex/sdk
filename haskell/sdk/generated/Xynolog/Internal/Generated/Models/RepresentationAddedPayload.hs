-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.RepresentationAddedPayload (RepresentationAddedPayload(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.Representation
data RepresentationAddedPayload = RepresentationAddedPayload
  { representationAddedPayloadRepresentation :: Representation
  , representationAddedPayloadAdditionalProperties :: KM.KeyMap Value
  } deriving (Eq, Show)
instance FromJSON RepresentationAddedPayload where parseJSON = checked "RepresentationAddedPayload" $ withObject "RepresentationAddedPayload" (\fields -> RepresentationAddedPayload <$> (fields .: "representation") <*> traverse parseJSON (withoutFields ["representation"] fields))
instance ToJSON RepresentationAddedPayload where toJSON value = Object (KM.fromList (concat [[("representation", toJSON (representationAddedPayloadRepresentation value))]]) <> fmap toJSON (withoutFields ["representation"] (representationAddedPayloadAdditionalProperties value)))
