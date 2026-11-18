-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.ServiceAddress (ServiceAddress(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Data.Text (Text)
import Xynolog.Internal.Codec
data ServiceAddress = ServiceAddress
  { serviceAddressHost :: Text
  , serviceAddressPort :: Integer
  } deriving (Eq, Show)
instance FromJSON ServiceAddress where parseJSON = checked "ServiceAddress" $ withObject "ServiceAddress" (\fields -> ServiceAddress <$> (fields .: "host") <*> (fields .: "port"))
instance ToJSON ServiceAddress where toJSON value = Object (KM.fromList (concat [[("host", toJSON (serviceAddressHost value))], [("port", toJSON (serviceAddressPort value))]]))
