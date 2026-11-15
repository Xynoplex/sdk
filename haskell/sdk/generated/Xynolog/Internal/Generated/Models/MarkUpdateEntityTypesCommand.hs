-- Generated from protocol/specs/src. Run xynolog-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynolog.Internal.Generated.Models.MarkUpdateEntityTypesCommand
  ( MarkUpdateEntityTypesCommand(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Types.Presence (Presence)
import Xynolog.Internal.Generated.Models.ResourceId
import Xynolog.Internal.Generated.Models.UserId
data MarkUpdateEntityTypesCommand = MarkUpdateEntityTypesCommand { markUpdateEntityTypesCommandU5f_userId :: Maybe (UserId), markUpdateEntityTypesCommandCurrentEntityTypes :: [Text], markUpdateEntityTypesCommandResourceId :: ResourceId, markUpdateEntityTypesCommandUpdatedEntityTypes :: [Text], markUpdateEntityTypesCommandAdditionalProperties :: KM.KeyMap (Value) } deriving (Eq, Show)
instance FromJSON MarkUpdateEntityTypesCommand where
  parseJSON = checked "MarkUpdateEntityTypesCommand" $ withObject "MarkUpdateEntityTypesCommand" (\fields -> MarkUpdateEntityTypesCommand <$> optional fields "_userId" <*> fields .: "currentEntityTypes" <*> fields .: "resourceId" <*> fields .: "updatedEntityTypes" <*> traverse parseJSON (withoutFields ["_userId", "currentEntityTypes", "resourceId", "updatedEntityTypes"] fields))
instance ToJSON MarkUpdateEntityTypesCommand where toJSON value = Object (KM.fromList (concat [optionalPair "_userId" (markUpdateEntityTypesCommandU5f_userId value), [("currentEntityTypes", toJSON (markUpdateEntityTypesCommandCurrentEntityTypes value))], [("resourceId", toJSON (markUpdateEntityTypesCommandResourceId value))], [("updatedEntityTypes", toJSON (markUpdateEntityTypesCommandUpdatedEntityTypes value))]]) <> fmap toJSON (withoutFields ["_userId", "currentEntityTypes", "resourceId", "updatedEntityTypes"] (markUpdateEntityTypesCommandAdditionalProperties value)))
