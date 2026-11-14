-- Generated from protocol/specs/src. Run xynoplex-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynoplex.Internal.Generated.Models.SignedIn
  ( SignedIn(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynoplex.Internal.Codec
import Xynoplex.Types.Presence (Presence)
import Xynoplex.Internal.Generated.Models.KbDescription
import Xynoplex.Internal.Generated.Models.KbEndpoint
import Xynoplex.Internal.Generated.Models.StoredSession
data SignedIn = SignedIn { signedInDescription :: KbDescription, signedInEndpoint :: KbEndpoint, signedInExpectedDid :: Maybe (Text), signedInExpectedName :: Maybe (Text), signedInKbId :: Maybe (Text), signedInSession :: StoredSession } deriving (Eq, Show)
instance FromJSON SignedIn where
  parseJSON = checked "SignedIn" $ withObject "SignedIn" (\fields -> SignedIn <$> fields .: "description" <*> fields .: "endpoint" <*> optional fields "expectedDid" <*> optional fields "expectedName" <*> optional fields "kbId" <*> fields .: "session")
instance ToJSON SignedIn where toJSON value = Object (KM.fromList (concat [[("description", toJSON (signedInDescription value))], [("endpoint", toJSON (signedInEndpoint value))], optionalPair "expectedDid" (signedInExpectedDid value), optionalPair "expectedName" (signedInExpectedName value), optionalPair "kbId" (signedInKbId value), [("session", toJSON (signedInSession value))]]))
