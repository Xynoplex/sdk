-- Generated from protocol/specs/src. Run xynolog-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynolog.Internal.Generated.Models.ResourceView
  ( ResourceView(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Types.Presence (Presence)
import Xynolog.Internal.Generated.Models.ResourceAnnotations
import Xynolog.Internal.Generated.Models.ResourceDescriptor
data ResourceView = ResourceView { resourceViewAnnotations :: ResourceAnnotations, resourceViewLastSequence :: Integer, resourceViewResource :: ResourceDescriptor } deriving (Eq, Show)
instance FromJSON ResourceView where
  parseJSON = checked "ResourceView" $ withObject "ResourceView" (\fields -> ResourceView <$> fields .: "annotations" <*> fields .: "lastSequence" <*> fields .: "resource")
instance ToJSON ResourceView where toJSON value = Object (KM.fromList (concat [[("annotations", toJSON (resourceViewAnnotations value))], [("lastSequence", toJSON (resourceViewLastSequence value))], [("resource", toJSON (resourceViewResource value))]]))
