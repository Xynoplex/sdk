-- Generated from protocol/specs/src. Run xynoplex-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynoplex.Internal.Generated.Models.RepresentationAddedPayload
  ( RepresentationAddedPayload(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynoplex.Internal.Codec
import Xynoplex.Types.Presence (Presence)
import Xynoplex.Internal.Generated.Models.Representation
data RepresentationAddedPayload = RepresentationAddedPayload { representationAddedPayloadRepresentation :: Representation, representationAddedPayloadAdditionalProperties :: KM.KeyMap (Value) } deriving (Eq, Show)
instance FromJSON RepresentationAddedPayload where
  parseJSON = checked "RepresentationAddedPayload" $ withObject "RepresentationAddedPayload" (\fields -> RepresentationAddedPayload <$> fields .: "representation" <*> traverse parseJSON (withoutFields ["representation"] fields))
instance ToJSON RepresentationAddedPayload where toJSON value = Object (KM.fromList (concat [[("representation", toJSON (representationAddedPayloadRepresentation value))]]) <> fmap toJSON (withoutFields ["representation"] (representationAddedPayloadAdditionalProperties value)))
