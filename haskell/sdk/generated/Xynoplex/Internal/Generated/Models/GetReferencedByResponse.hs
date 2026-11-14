-- Generated from protocol/specs/src. Run xynoplex-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynoplex.Internal.Generated.Models.GetReferencedByResponse
  ( GetReferencedByResponse(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynoplex.Internal.Codec
import Xynoplex.Types.Presence (Presence)
import Xynoplex.Internal.Generated.Models.GetReferencedByResponseReferencedByItem
data GetReferencedByResponse = GetReferencedByResponse { getReferencedByResponseReferencedBy :: [GetReferencedByResponseReferencedByItem], getReferencedByResponseAdditionalProperties :: KM.KeyMap (Value) } deriving (Eq, Show)
instance FromJSON GetReferencedByResponse where
  parseJSON = checked "GetReferencedByResponse" $ withObject "GetReferencedByResponse" (\fields -> GetReferencedByResponse <$> fields .: "referencedBy" <*> traverse parseJSON (withoutFields ["referencedBy"] fields))
instance ToJSON GetReferencedByResponse where toJSON value = Object (KM.fromList (concat [[("referencedBy", toJSON (getReferencedByResponseReferencedBy value))]]) <> fmap toJSON (withoutFields ["referencedBy"] (getReferencedByResponseAdditionalProperties value)))
