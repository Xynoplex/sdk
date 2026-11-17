-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.GetResourceByTokenResponse (GetResourceByTokenResponse(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.ResourceDescriptor
data GetResourceByTokenResponse = GetResourceByTokenResponse
  { getResourceByTokenResponseExpiresAt :: Text
  , getResourceByTokenResponseSourceResource :: ResourceDescriptor
  , getResourceByTokenResponseAdditionalProperties :: KM.KeyMap Value
  } deriving (Eq, Show)
instance FromJSON GetResourceByTokenResponse where parseJSON = checked "GetResourceByTokenResponse" $ withObject "GetResourceByTokenResponse" (\fields -> GetResourceByTokenResponse <$> (fields .: "expiresAt") <*> (fields .: "sourceResource") <*> traverse parseJSON (withoutFields ["expiresAt", "sourceResource"] fields))
instance ToJSON GetResourceByTokenResponse where toJSON value = Object (KM.fromList (concat [[("expiresAt", toJSON (getResourceByTokenResponseExpiresAt value))], [("sourceResource", toJSON (getResourceByTokenResponseSourceResource value))]]) <> fmap toJSON (withoutFields ["expiresAt", "sourceResource"] (getResourceByTokenResponseAdditionalProperties value)))
