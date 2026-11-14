-- Generated from protocol/specs/src. Run xynoplex-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynoplex.Internal.Generated.Models.SmeltRebuildAnchorsCommand
  ( SmeltRebuildAnchorsCommand(..)
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
data SmeltRebuildAnchorsCommand = SmeltRebuildAnchorsCommand { smeltRebuildAnchorsCommandU5f_userId :: Maybe (UserId), smeltRebuildAnchorsCommandResourceId :: Maybe (ResourceId), smeltRebuildAnchorsCommandAdditionalProperties :: KM.KeyMap (Value) } deriving (Eq, Show)
instance FromJSON SmeltRebuildAnchorsCommand where
  parseJSON = checked "SmeltRebuildAnchorsCommand" $ withObject "SmeltRebuildAnchorsCommand" (\fields -> SmeltRebuildAnchorsCommand <$> optional fields "_userId" <*> optional fields "resourceId" <*> traverse parseJSON (withoutFields ["_userId", "resourceId"] fields))
instance ToJSON SmeltRebuildAnchorsCommand where toJSON value = Object (KM.fromList (concat [optionalPair "_userId" (smeltRebuildAnchorsCommandU5f_userId value), optionalPair "resourceId" (smeltRebuildAnchorsCommandResourceId value)]) <> fmap toJSON (withoutFields ["_userId", "resourceId"] (smeltRebuildAnchorsCommandAdditionalProperties value)))
