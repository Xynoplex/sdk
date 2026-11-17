-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.CloneResourceWithTokenResponse (CloneResourceWithTokenResponse(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.ResourceDescriptor
data CloneResourceWithTokenResponse = CloneResourceWithTokenResponse
  { cloneResourceWithTokenResponseExpiresAt :: Text
  , cloneResourceWithTokenResponseResource :: ResourceDescriptor
  , cloneResourceWithTokenResponseToken :: Text
  , cloneResourceWithTokenResponseAdditionalProperties :: KM.KeyMap Value
  } deriving (Eq, Show)
instance FromJSON CloneResourceWithTokenResponse where parseJSON = checked "CloneResourceWithTokenResponse" $ withObject "CloneResourceWithTokenResponse" (\fields -> CloneResourceWithTokenResponse <$> (fields .: "expiresAt") <*> (fields .: "resource") <*> (fields .: "token") <*> traverse parseJSON (withoutFields ["expiresAt", "resource", "token"] fields))
instance ToJSON CloneResourceWithTokenResponse where toJSON value = Object (KM.fromList (concat [[("expiresAt", toJSON (cloneResourceWithTokenResponseExpiresAt value))], [("resource", toJSON (cloneResourceWithTokenResponseResource value))], [("token", toJSON (cloneResourceWithTokenResponseToken value))]]) <> fmap toJSON (withoutFields ["expiresAt", "resource", "token"] (cloneResourceWithTokenResponseAdditionalProperties value)))
