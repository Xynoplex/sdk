-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.ServiceIdentity (ServiceIdentity(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Data.Text (Text)
import Xynolog.Internal.Codec
data ServiceIdentity = ServiceIdentity
  { serviceIdentityIssuer :: Text
  } deriving (Eq, Show)
instance FromJSON ServiceIdentity where parseJSON = checked "ServiceIdentity" $ withObject "ServiceIdentity" (\fields -> ServiceIdentity <$> (fields .: "issuer"))
instance ToJSON ServiceIdentity where toJSON value = Object (KM.fromList (concat [[("issuer", toJSON (serviceIdentityIssuer value))]]))
