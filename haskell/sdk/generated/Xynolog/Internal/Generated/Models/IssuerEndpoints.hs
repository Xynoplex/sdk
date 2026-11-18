-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.IssuerEndpoints (IssuerEndpoints (..)) where

import Data.Aeson (FromJSON (..), ToJSON (..), Value (..), withObject, (.:))
import Data.Aeson.KeyMap qualified as KM
import Data.Text (Text)
import Xynolog.Internal.Codec

data IssuerEndpoints = IssuerEndpoints
  { issuerEndpointsAuthorization :: Text,
    issuerEndpointsDevice :: Maybe Text,
    issuerEndpointsIssuer :: Text,
    issuerEndpointsRevocation :: Maybe Text,
    issuerEndpointsToken :: Text,
    issuerEndpointsAdditionalProperties :: KM.KeyMap Value
  }
  deriving (Eq, Show)

instance FromJSON IssuerEndpoints where parseJSON = checked "IssuerEndpoints" $ withObject "IssuerEndpoints" (\fields -> IssuerEndpoints <$> (fields .: "authorization") <*> optional fields "device" <*> (fields .: "issuer") <*> optional fields "revocation" <*> (fields .: "token") <*> traverse parseJSON (withoutFields ["authorization", "device", "issuer", "revocation", "token"] fields))

instance ToJSON IssuerEndpoints where toJSON value = Object (KM.fromList (concat [[("authorization", toJSON (issuerEndpointsAuthorization value))], optionalPair "device" (issuerEndpointsDevice value), [("issuer", toJSON (issuerEndpointsIssuer value))], optionalPair "revocation" (issuerEndpointsRevocation value), [("token", toJSON (issuerEndpointsToken value))]]) <> fmap toJSON (withoutFields ["authorization", "device", "issuer", "revocation", "token"] (issuerEndpointsAdditionalProperties value)))
