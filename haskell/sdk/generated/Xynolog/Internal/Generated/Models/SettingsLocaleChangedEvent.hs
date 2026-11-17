-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.SettingsLocaleChangedEvent (SettingsLocaleChangedEvent(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Data.Text (Text)
import Xynolog.Internal.Codec
data SettingsLocaleChangedEvent = SettingsLocaleChangedEvent
  { settingsLocaleChangedEventLocale :: Text
  , settingsLocaleChangedEventAdditionalProperties :: KM.KeyMap Value
  } deriving (Eq, Show)
instance FromJSON SettingsLocaleChangedEvent where parseJSON = checked "SettingsLocaleChangedEvent" $ withObject "SettingsLocaleChangedEvent" (\fields -> SettingsLocaleChangedEvent <$> (fields .: "locale") <*> traverse parseJSON (withoutFields ["locale"] fields))
instance ToJSON SettingsLocaleChangedEvent where toJSON value = Object (KM.fromList (concat [[("locale", toJSON (settingsLocaleChangedEventLocale value))]]) <> fmap toJSON (withoutFields ["locale"] (settingsLocaleChangedEventAdditionalProperties value)))
