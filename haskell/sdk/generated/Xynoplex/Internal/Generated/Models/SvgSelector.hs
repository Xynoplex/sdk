-- Generated from protocol/specs/src. Run xynoplex-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynoplex.Internal.Generated.Models.SvgSelector
  ( SvgSelector(..)
  , SvgSelectorType(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynoplex.Internal.Codec
import Xynoplex.Types.Presence (Presence)
data SvgSelector = SvgSelector { svgSelectorType :: SvgSelectorType, svgSelectorValue :: Text, svgSelectorAdditionalProperties :: KM.KeyMap (Value) } deriving (Eq, Show)
instance FromJSON SvgSelector where
  parseJSON = checked "SvgSelector" $ withObject "SvgSelector" (\fields -> SvgSelector <$> fields .: "type" <*> fields .: "value" <*> traverse parseJSON (withoutFields ["type", "value"] fields))
instance ToJSON SvgSelector where toJSON value = Object (KM.fromList (concat [[("type", toJSON (svgSelectorType value))], [("value", toJSON (svgSelectorValue value))]]) <> fmap toJSON (withoutFields ["type", "value"] (svgSelectorAdditionalProperties value)))

data SvgSelectorType = SvgSelectorTypeSvgSelector deriving (Eq, Show)
instance FromJSON SvgSelectorType where
  parseJSON = checked "SvgSelectorType" $ \value -> if value == (String "SvgSelector") then pure SvgSelectorTypeSvgSelector else fail "unknown enumeration member"
instance ToJSON SvgSelectorType where
  toJSON SvgSelectorTypeSvgSelector = String "SvgSelector"
