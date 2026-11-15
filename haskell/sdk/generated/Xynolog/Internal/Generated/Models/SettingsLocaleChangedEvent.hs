-- Generated from protocol/specs/src. Run xynolog-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynolog.Internal.Generated.Models.SettingsLocaleChangedEvent
  ( SettingsLocaleChangedEvent(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Types.Presence (Presence)
data SettingsLocaleChangedEvent = SettingsLocaleChangedEvent { settingsLocaleChangedEventLocale :: Text, settingsLocaleChangedEventAdditionalProperties :: KM.KeyMap (Value) } deriving (Eq, Show)
instance FromJSON SettingsLocaleChangedEvent where
  parseJSON = checked "SettingsLocaleChangedEvent" $ withObject "SettingsLocaleChangedEvent" (\fields -> SettingsLocaleChangedEvent <$> fields .: "locale" <*> traverse parseJSON (withoutFields ["locale"] fields))
instance ToJSON SettingsLocaleChangedEvent where toJSON value = Object (KM.fromList (concat [[("locale", toJSON (settingsLocaleChangedEventLocale value))]]) <> fmap toJSON (withoutFields ["locale"] (settingsLocaleChangedEventAdditionalProperties value)))
