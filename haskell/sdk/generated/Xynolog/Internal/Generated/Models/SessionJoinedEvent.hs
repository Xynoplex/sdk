-- Generated from protocol/specs/src. Run xynolog-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynolog.Internal.Generated.Models.SessionJoinedEvent
  ( SessionJoinedEvent(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Types.Presence (Presence)
import Xynolog.Internal.Generated.Models.UserId
data SessionJoinedEvent = SessionJoinedEvent { sessionJoinedEventConnectionId :: Text, sessionJoinedEventParticipant :: UserId, sessionJoinedEventAdditionalProperties :: KM.KeyMap (Value) } deriving (Eq, Show)
instance FromJSON SessionJoinedEvent where
  parseJSON = checked "SessionJoinedEvent" $ withObject "SessionJoinedEvent" (\fields -> SessionJoinedEvent <$> fields .: "connectionId" <*> fields .: "participant" <*> traverse parseJSON (withoutFields ["connectionId", "participant"] fields))
instance ToJSON SessionJoinedEvent where toJSON value = Object (KM.fromList (concat [[("connectionId", toJSON (sessionJoinedEventConnectionId value))], [("participant", toJSON (sessionJoinedEventParticipant value))]]) <> fmap toJSON (withoutFields ["connectionId", "participant"] (sessionJoinedEventAdditionalProperties value)))
