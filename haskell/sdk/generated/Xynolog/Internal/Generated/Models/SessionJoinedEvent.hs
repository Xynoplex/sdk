-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.SessionJoinedEvent (SessionJoinedEvent(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.UserId
data SessionJoinedEvent = SessionJoinedEvent
  { sessionJoinedEventConnectionId :: Text
  , sessionJoinedEventParticipant :: UserId
  , sessionJoinedEventAdditionalProperties :: KM.KeyMap Value
  } deriving (Eq, Show)
instance FromJSON SessionJoinedEvent where parseJSON = checked "SessionJoinedEvent" $ withObject "SessionJoinedEvent" (\fields -> SessionJoinedEvent <$> (fields .: "connectionId") <*> (fields .: "participant") <*> traverse parseJSON (withoutFields ["connectionId", "participant"] fields))
instance ToJSON SessionJoinedEvent where toJSON value = Object (KM.fromList (concat [[("connectionId", toJSON (sessionJoinedEventConnectionId value))], [("participant", toJSON (sessionJoinedEventParticipant value))]]) <> fmap toJSON (withoutFields ["connectionId", "participant"] (sessionJoinedEventAdditionalProperties value)))
