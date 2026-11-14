-- Generated from protocol/specs/src. Run xynoplex-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynoplex.Internal.Generated.Models.WeaveRebuildCommand
  ( WeaveRebuildCommand(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynoplex.Internal.Codec
import Xynoplex.Types.Presence (Presence)
import Xynoplex.Internal.Generated.Models.ResourceId
import Xynoplex.Internal.Generated.Models.UserId
data WeaveRebuildCommand = WeaveRebuildCommand { weaveRebuildCommandU5f_userId :: Maybe (UserId), weaveRebuildCommandResourceId :: Maybe (ResourceId), weaveRebuildCommandAdditionalProperties :: KM.KeyMap (Value) } deriving (Eq, Show)
instance FromJSON WeaveRebuildCommand where
  parseJSON = checked "WeaveRebuildCommand" $ withObject "WeaveRebuildCommand" (\fields -> WeaveRebuildCommand <$> optional fields "_userId" <*> optional fields "resourceId" <*> traverse parseJSON (withoutFields ["_userId", "resourceId"] fields))
instance ToJSON WeaveRebuildCommand where toJSON value = Object (KM.fromList (concat [optionalPair "_userId" (weaveRebuildCommandU5f_userId value), optionalPair "resourceId" (weaveRebuildCommandResourceId value)]) <> fmap toJSON (withoutFields ["_userId", "resourceId"] (weaveRebuildCommandAdditionalProperties value)))
