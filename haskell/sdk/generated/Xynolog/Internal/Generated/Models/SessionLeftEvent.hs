-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.SessionLeftEvent (SessionLeftEvent(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.UserId
data SessionLeftEvent = SessionLeftEvent
  { sessionLeftEventConnectionId :: Text
  , sessionLeftEventParticipant :: UserId
  , sessionLeftEventAdditionalProperties :: KM.KeyMap Value
  } deriving (Eq, Show)
instance FromJSON SessionLeftEvent where parseJSON = checked "SessionLeftEvent" $ withObject "SessionLeftEvent" (\fields -> SessionLeftEvent <$> (fields .: "connectionId") <*> (fields .: "participant") <*> traverse parseJSON (withoutFields ["connectionId", "participant"] fields))
instance ToJSON SessionLeftEvent where toJSON value = Object (KM.fromList (concat [[("connectionId", toJSON (sessionLeftEventConnectionId value))], [("participant", toJSON (sessionLeftEventParticipant value))]]) <> fmap toJSON (withoutFields ["connectionId", "participant"] (sessionLeftEventAdditionalProperties value)))
