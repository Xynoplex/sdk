-- Generated from protocol/specs/src. Run xynoplex-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynoplex.Internal.Generated.Models.MediaTokenResponse
  ( MediaTokenResponse(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynoplex.Internal.Codec
import Xynoplex.Types.Presence (Presence)
data MediaTokenResponse = MediaTokenResponse { mediaTokenResponseToken :: Text, mediaTokenResponseAdditionalProperties :: KM.KeyMap (Value) } deriving (Eq, Show)
instance FromJSON MediaTokenResponse where
  parseJSON = checked "MediaTokenResponse" $ withObject "MediaTokenResponse" (\fields -> MediaTokenResponse <$> fields .: "token" <*> traverse parseJSON (withoutFields ["token"] fields))
instance ToJSON MediaTokenResponse where toJSON value = Object (KM.fromList (concat [[("token", toJSON (mediaTokenResponseToken value))]]) <> fmap toJSON (withoutFields ["token"] (mediaTokenResponseAdditionalProperties value)))
