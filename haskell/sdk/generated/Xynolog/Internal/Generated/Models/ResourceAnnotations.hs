-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.ResourceAnnotations (ResourceAnnotations(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.Annotation
import Xynolog.Internal.Generated.Models.ResourceId
data ResourceAnnotations = ResourceAnnotations
  { resourceAnnotationsAnnotations :: [Annotation]
  , resourceAnnotationsResourceId :: ResourceId
  , resourceAnnotationsUpdatedAt :: Text
  , resourceAnnotationsVersion :: Integer
  } deriving (Eq, Show)
instance FromJSON ResourceAnnotations where parseJSON = checked "ResourceAnnotations" $ withObject "ResourceAnnotations" (\fields -> ResourceAnnotations <$> (fields .: "annotations") <*> (fields .: "resourceId") <*> (fields .: "updatedAt") <*> (fields .: "version"))
instance ToJSON ResourceAnnotations where toJSON value = Object (KM.fromList (concat [[("annotations", toJSON (resourceAnnotationsAnnotations value))], [("resourceId", toJSON (resourceAnnotationsResourceId value))], [("updatedAt", toJSON (resourceAnnotationsUpdatedAt value))], [("version", toJSON (resourceAnnotationsVersion value))]]))
