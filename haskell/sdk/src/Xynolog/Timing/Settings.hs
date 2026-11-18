module Xynolog.Timing.Settings (Settings (..), protocolSettings, withOverrides) where

import Data.Aeson (Result (..), Value (..), fromJSON, toJSON)
import Data.Aeson.KeyMap qualified as KM
import Xynolog.Internal.Generated.TimingSettings (Settings (..), protocolSettings)

-- | Protocol's timing with each member 'overrides' states in its place.
withOverrides :: Value -> Either String Settings
withOverrides (Object overrides) = case toJSON protocolSettings of
  Object fields -> case fromJSON (Object (KM.union overrides fields)) of Error reason -> Left reason; Success value -> Right value
  _ -> Left "Protocol timing is not an object"
withOverrides _ = Left "Timing overrides are not an object"
