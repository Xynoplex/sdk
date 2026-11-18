-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.StoredSession (StoredSession(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Data.Text (Text)
import Xynolog.Internal.Codec
data StoredSession = StoredSession
  { storedSessionAccess :: Text
  , storedSessionClientId :: Text
  , storedSessionPersonKey :: Maybe Text
  , storedSessionRefresh :: Text
  , storedSessionRevocationEndpoint :: Maybe Text
  , storedSessionTokenEndpoint :: Text
  , storedSessionAdditionalProperties :: KM.KeyMap Value
  } deriving (Eq, Show)
instance FromJSON StoredSession where parseJSON = checked "StoredSession" $ withObject "StoredSession" (\fields -> StoredSession <$> (fields .: "access") <*> (fields .: "clientId") <*> optional fields "personKey" <*> (fields .: "refresh") <*> optional fields "revocationEndpoint" <*> (fields .: "tokenEndpoint") <*> traverse parseJSON (withoutFields ["access", "clientId", "personKey", "refresh", "revocationEndpoint", "tokenEndpoint"] fields))
instance ToJSON StoredSession where toJSON value = Object (KM.fromList (concat [[("access", toJSON (storedSessionAccess value))], [("clientId", toJSON (storedSessionClientId value))], optionalPair "personKey" (storedSessionPersonKey value), [("refresh", toJSON (storedSessionRefresh value))], optionalPair "revocationEndpoint" (storedSessionRevocationEndpoint value), [("tokenEndpoint", toJSON (storedSessionTokenEndpoint value))]]) <> fmap toJSON (withoutFields ["access", "clientId", "personKey", "refresh", "revocationEndpoint", "tokenEndpoint"] (storedSessionAdditionalProperties value)))
