-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.BrowsePanelToggleEvent (BrowsePanelToggleEvent(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Data.Text (Text)
import Xynolog.Internal.Codec
data BrowsePanelToggleEvent = BrowsePanelToggleEvent
  { browsePanelToggleEventPanel :: Text
  , browsePanelToggleEventAdditionalProperties :: KM.KeyMap Value
  } deriving (Eq, Show)
instance FromJSON BrowsePanelToggleEvent where parseJSON = checked "BrowsePanelToggleEvent" $ withObject "BrowsePanelToggleEvent" (\fields -> BrowsePanelToggleEvent <$> (fields .: "panel") <*> traverse parseJSON (withoutFields ["panel"] fields))
instance ToJSON BrowsePanelToggleEvent where toJSON value = Object (KM.fromList (concat [[("panel", toJSON (browsePanelToggleEventPanel value))]]) <> fmap toJSON (withoutFields ["panel"] (browsePanelToggleEventAdditionalProperties value)))
