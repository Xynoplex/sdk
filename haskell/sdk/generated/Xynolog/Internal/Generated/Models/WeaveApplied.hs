-- Generated from protocol/specs/src. Run xynolog-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynolog.Internal.Generated.Models.WeaveApplied
  ( WeaveApplied(..)
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
data WeaveApplied = WeaveApplied { weaveAppliedResourceId :: ResourceId, weaveAppliedSequenceNumber :: Integer, weaveAppliedAdditionalProperties :: KM.KeyMap (Value) } deriving (Eq, Show)
instance FromJSON WeaveApplied where
  parseJSON = checked "WeaveApplied" $ withObject "WeaveApplied" (\fields -> WeaveApplied <$> fields .: "resourceId" <*> fields .: "sequenceNumber" <*> traverse parseJSON (withoutFields ["resourceId", "sequenceNumber"] fields))
instance ToJSON WeaveApplied where toJSON value = Object (KM.fromList (concat [[("resourceId", toJSON (weaveAppliedResourceId value))], [("sequenceNumber", toJSON (weaveAppliedSequenceNumber value))]]) <> fmap toJSON (withoutFields ["resourceId", "sequenceNumber"] (weaveAppliedAdditionalProperties value)))
