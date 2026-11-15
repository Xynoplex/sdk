-- Generated from protocol/specs/src. Run xynolog-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynolog.Internal.Generated.Models.GetResourceByTokenResponse
  ( GetResourceByTokenResponse(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Types.Presence (Presence)
import Xynolog.Internal.Generated.Models.ResourceDescriptor
data GetResourceByTokenResponse = GetResourceByTokenResponse { getResourceByTokenResponseExpiresAt :: Text, getResourceByTokenResponseSourceResource :: ResourceDescriptor, getResourceByTokenResponseAdditionalProperties :: KM.KeyMap (Value) } deriving (Eq, Show)
instance FromJSON GetResourceByTokenResponse where
  parseJSON = checked "GetResourceByTokenResponse" $ withObject "GetResourceByTokenResponse" (\fields -> GetResourceByTokenResponse <$> fields .: "expiresAt" <*> fields .: "sourceResource" <*> traverse parseJSON (withoutFields ["expiresAt", "sourceResource"] fields))
instance ToJSON GetResourceByTokenResponse where toJSON value = Object (KM.fromList (concat [[("expiresAt", toJSON (getResourceByTokenResponseExpiresAt value))], [("sourceResource", toJSON (getResourceByTokenResponseSourceResource value))]]) <> fmap toJSON (withoutFields ["expiresAt", "sourceResource"] (getResourceByTokenResponseAdditionalProperties value)))
