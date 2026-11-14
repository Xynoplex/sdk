-- Generated from protocol/specs/src. Run xynoplex-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynoplex.Internal.Generated.Models.FrameAddEntityTypeCommand
  ( FrameAddEntityTypeCommand(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynoplex.Internal.Codec
import Xynoplex.Types.Presence (Presence)
import Xynoplex.Internal.Generated.Models.UserId
data FrameAddEntityTypeCommand = FrameAddEntityTypeCommand { frameAddEntityTypeCommandU5f_userId :: Maybe (UserId), frameAddEntityTypeCommandTag :: Text, frameAddEntityTypeCommandAdditionalProperties :: KM.KeyMap (Value) } deriving (Eq, Show)
instance FromJSON FrameAddEntityTypeCommand where
  parseJSON = checked "FrameAddEntityTypeCommand" $ withObject "FrameAddEntityTypeCommand" (\fields -> FrameAddEntityTypeCommand <$> optional fields "_userId" <*> fields .: "tag" <*> traverse parseJSON (withoutFields ["_userId", "tag"] fields))
instance ToJSON FrameAddEntityTypeCommand where toJSON value = Object (KM.fromList (concat [optionalPair "_userId" (frameAddEntityTypeCommandU5f_userId value), [("tag", toJSON (frameAddEntityTypeCommandTag value))]]) <> fmap toJSON (withoutFields ["_userId", "tag"] (frameAddEntityTypeCommandAdditionalProperties value)))
