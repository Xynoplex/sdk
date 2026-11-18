-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.PendingAuthorization (PendingAuthorization (..)) where

import Data.Aeson (FromJSON (..), ToJSON (..), Value (..), withObject, (.:))
import Data.Aeson.KeyMap qualified as KM
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.HttpEndpoint
import Xynolog.Internal.Generated.Models.IssuerEndpoints

data PendingAuthorization = PendingAuthorization
  { pendingAuthorizationExpectedDid :: Maybe Text,
    pendingAuthorizationExpectedName :: Maybe Text,
    pendingAuthorizationIssuer :: IssuerEndpoints,
    pendingAuthorizationKbId :: Maybe Text,
    pendingAuthorizationRedirectUri :: Text,
    pendingAuthorizationState :: Text,
    pendingAuthorizationTarget :: HttpEndpoint,
    pendingAuthorizationVerifier :: Text,
    pendingAuthorizationAdditionalProperties :: KM.KeyMap Value
  }
  deriving (Eq, Show)

instance FromJSON PendingAuthorization where parseJSON = checked "PendingAuthorization" $ withObject "PendingAuthorization" (\fields -> PendingAuthorization <$> optional fields "expectedDid" <*> optional fields "expectedName" <*> (fields .: "issuer") <*> optional fields "kbId" <*> (fields .: "redirectUri") <*> (fields .: "state") <*> (fields .: "target") <*> (fields .: "verifier") <*> traverse parseJSON (withoutFields ["expectedDid", "expectedName", "issuer", "kbId", "redirectUri", "state", "target", "verifier"] fields))

instance ToJSON PendingAuthorization where toJSON value = Object (KM.fromList (concat [optionalPair "expectedDid" (pendingAuthorizationExpectedDid value), optionalPair "expectedName" (pendingAuthorizationExpectedName value), [("issuer", toJSON (pendingAuthorizationIssuer value))], optionalPair "kbId" (pendingAuthorizationKbId value), [("redirectUri", toJSON (pendingAuthorizationRedirectUri value))], [("state", toJSON (pendingAuthorizationState value))], [("target", toJSON (pendingAuthorizationTarget value))], [("verifier", toJSON (pendingAuthorizationVerifier value))]]) <> fmap toJSON (withoutFields ["expectedDid", "expectedName", "issuer", "kbId", "redirectUri", "state", "target", "verifier"] (pendingAuthorizationAdditionalProperties value)))
