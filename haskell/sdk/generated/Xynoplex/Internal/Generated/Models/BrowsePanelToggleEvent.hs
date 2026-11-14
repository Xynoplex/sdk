-- Generated from protocol/specs/src. Run xynoplex-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynoplex.Internal.Generated.Models.BrowsePanelToggleEvent
  ( BrowsePanelToggleEvent(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynoplex.Internal.Codec
import Xynoplex.Types.Presence (Presence)
data BrowsePanelToggleEvent = BrowsePanelToggleEvent { browsePanelToggleEventPanel :: Text, browsePanelToggleEventAdditionalProperties :: KM.KeyMap (Value) } deriving (Eq, Show)
instance FromJSON BrowsePanelToggleEvent where
  parseJSON = checked "BrowsePanelToggleEvent" $ withObject "BrowsePanelToggleEvent" (\fields -> BrowsePanelToggleEvent <$> fields .: "panel" <*> traverse parseJSON (withoutFields ["panel"] fields))
instance ToJSON BrowsePanelToggleEvent where toJSON value = Object (KM.fromList (concat [[("panel", toJSON (browsePanelToggleEventPanel value))]]) <> fmap toJSON (withoutFields ["panel"] (browsePanelToggleEventAdditionalProperties value)))
