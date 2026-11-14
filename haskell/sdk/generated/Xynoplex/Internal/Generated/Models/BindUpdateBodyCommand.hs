-- Generated from protocol/specs/src. Run xynoplex-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynoplex.Internal.Generated.Models.BindUpdateBodyCommand
  ( BindUpdateBodyCommand(..)
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
import Xynoplex.Internal.Generated.Models.BindBodyOperation
import Xynoplex.Internal.Generated.Models.ResourceId
import Xynoplex.Internal.Generated.Models.UserId
data BindUpdateBodyCommand = BindUpdateBodyCommand { bindUpdateBodyCommandU5f_userId :: Maybe (UserId), bindUpdateBodyCommandAnnotationId :: AnnotationId, bindUpdateBodyCommandOperations :: [BindBodyOperation], bindUpdateBodyCommandResourceId :: ResourceId, bindUpdateBodyCommandAdditionalProperties :: KM.KeyMap (Value) } deriving (Eq, Show)
instance FromJSON BindUpdateBodyCommand where
  parseJSON = checked "BindUpdateBodyCommand" $ withObject "BindUpdateBodyCommand" (\fields -> BindUpdateBodyCommand <$> optional fields "_userId" <*> fields .: "annotationId" <*> fields .: "operations" <*> fields .: "resourceId" <*> traverse parseJSON (withoutFields ["_userId", "annotationId", "operations", "resourceId"] fields))
instance ToJSON BindUpdateBodyCommand where toJSON value = Object (KM.fromList (concat [optionalPair "_userId" (bindUpdateBodyCommandU5f_userId value), [("annotationId", toJSON (bindUpdateBodyCommandAnnotationId value))], [("operations", toJSON (bindUpdateBodyCommandOperations value))], [("resourceId", toJSON (bindUpdateBodyCommandResourceId value))]]) <> fmap toJSON (withoutFields ["_userId", "annotationId", "operations", "resourceId"] (bindUpdateBodyCommandAdditionalProperties value)))
