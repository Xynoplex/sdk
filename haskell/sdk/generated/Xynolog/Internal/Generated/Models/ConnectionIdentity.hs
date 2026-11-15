-- Generated from protocol/specs/src. Run xynolog-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynolog.Internal.Generated.Models.ConnectionIdentity
  ( ConnectionIdentity(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Types.Presence (Presence)
import Xynolog.Internal.Generated.Models.KbDescription
import Xynolog.Internal.Generated.Models.UserId
data ConnectionIdentity = ConnectionIdentity { connectionIdentityDescription :: KbDescription, connectionIdentityDid :: UserId } deriving (Eq, Show)
instance FromJSON ConnectionIdentity where
  parseJSON = checked "ConnectionIdentity" $ withObject "ConnectionIdentity" (\fields -> ConnectionIdentity <$> fields .: "description" <*> fields .: "did")
instance ToJSON ConnectionIdentity where toJSON value = Object (KM.fromList (concat [[("description", toJSON (connectionIdentityDescription value))], [("did", toJSON (connectionIdentityDid value))]]))
