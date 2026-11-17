-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.MediaTokenResponse (MediaTokenResponse(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Data.Text (Text)
import Xynolog.Internal.Codec
data MediaTokenResponse = MediaTokenResponse
  { mediaTokenResponseToken :: Text
  , mediaTokenResponseAdditionalProperties :: KM.KeyMap Value
  } deriving (Eq, Show)
instance FromJSON MediaTokenResponse where parseJSON = checked "MediaTokenResponse" $ withObject "MediaTokenResponse" (\fields -> MediaTokenResponse <$> (fields .: "token") <*> traverse parseJSON (withoutFields ["token"] fields))
instance ToJSON MediaTokenResponse where toJSON value = Object (KM.fromList (concat [[("token", toJSON (mediaTokenResponseToken value))]]) <> fmap toJSON (withoutFields ["token"] (mediaTokenResponseAdditionalProperties value)))
