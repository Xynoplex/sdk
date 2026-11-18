-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.SignedIn (SignedIn (..)) where

import Data.Aeson (FromJSON (..), ToJSON (..), Value (..), withObject, (.:))
import Data.Aeson.KeyMap qualified as KM
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.KbDescription
import Xynolog.Internal.Generated.Models.KbEndpoint
import Xynolog.Internal.Generated.Models.StoredSession

data SignedIn = SignedIn
  { signedInDescription :: KbDescription,
    signedInEndpoint :: KbEndpoint,
    signedInExpectedDid :: Maybe Text,
    signedInExpectedName :: Maybe Text,
    signedInKbId :: Maybe Text,
    signedInSession :: StoredSession
  }
  deriving (Eq, Show)

instance FromJSON SignedIn where parseJSON = checked "SignedIn" $ withObject "SignedIn" (\fields -> SignedIn <$> (fields .: "description") <*> (fields .: "endpoint") <*> optional fields "expectedDid" <*> optional fields "expectedName" <*> optional fields "kbId" <*> (fields .: "session"))

instance ToJSON SignedIn where toJSON value = Object (KM.fromList (concat [[("description", toJSON (signedInDescription value))], [("endpoint", toJSON (signedInEndpoint value))], optionalPair "expectedDid" (signedInExpectedDid value), optionalPair "expectedName" (signedInExpectedName value), optionalPair "kbId" (signedInKbId value), [("session", toJSON (signedInSession value))]]))
