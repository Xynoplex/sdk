-- Generated from protocol/specs/src. Run xynoplex-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynoplex.Internal.Generated.Models.BindInitiateCommand
  ( BindInitiateCommand(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynoplex.Internal.Codec
import Xynoplex.Types.Presence (Presence)
import Xynoplex.Internal.Generated.Models.AnnotationId
import Xynoplex.Internal.Generated.Models.ResourceId
data BindInitiateCommand = BindInitiateCommand { bindInitiateCommandAnnotationId :: AnnotationId, bindInitiateCommandDefaultTitle :: Text, bindInitiateCommandEntityTypes :: [Text], bindInitiateCommandResourceId :: ResourceId, bindInitiateCommandAdditionalProperties :: KM.KeyMap (Value) } deriving (Eq, Show)
instance FromJSON BindInitiateCommand where
  parseJSON = checked "BindInitiateCommand" $ withObject "BindInitiateCommand" (\fields -> BindInitiateCommand <$> fields .: "annotationId" <*> fields .: "defaultTitle" <*> fields .: "entityTypes" <*> fields .: "resourceId" <*> traverse parseJSON (withoutFields ["annotationId", "defaultTitle", "entityTypes", "resourceId"] fields))
instance ToJSON BindInitiateCommand where toJSON value = Object (KM.fromList (concat [[("annotationId", toJSON (bindInitiateCommandAnnotationId value))], [("defaultTitle", toJSON (bindInitiateCommandDefaultTitle value))], [("entityTypes", toJSON (bindInitiateCommandEntityTypes value))], [("resourceId", toJSON (bindInitiateCommandResourceId value))]]) <> fmap toJSON (withoutFields ["annotationId", "defaultTitle", "entityTypes", "resourceId"] (bindInitiateCommandAdditionalProperties value)))
