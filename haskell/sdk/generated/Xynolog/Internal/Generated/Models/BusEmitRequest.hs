-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.BusEmitRequest (BusEmitRequest(..), BusEmitRequestPayload(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.ResourceId
data BusEmitRequest = BusEmitRequest
  { busEmitRequestChannel :: Text
  , busEmitRequestClientId :: Maybe Text
  , busEmitRequestCorrelationId :: Maybe Text
  , busEmitRequestPayload :: BusEmitRequestPayload
  , busEmitRequestScope :: Maybe ResourceId
  , busEmitRequestAdditionalProperties :: KM.KeyMap Value
  } deriving (Eq, Show)
instance FromJSON BusEmitRequest where parseJSON = checked "BusEmitRequest" $ withObject "BusEmitRequest" (\fields -> BusEmitRequest <$> (fields .: "channel") <*> optional fields "clientId" <*> optional fields "correlationId" <*> (fields .: "payload") <*> optional fields "scope" <*> traverse parseJSON (withoutFields ["channel", "clientId", "correlationId", "payload", "scope"] fields))
instance ToJSON BusEmitRequest where toJSON value = Object (KM.fromList (concat [[("channel", toJSON (busEmitRequestChannel value))], optionalPair "clientId" (busEmitRequestClientId value), optionalPair "correlationId" (busEmitRequestCorrelationId value), [("payload", toJSON (busEmitRequestPayload value))], optionalPair "scope" (busEmitRequestScope value)]) <> fmap toJSON (withoutFields ["channel", "clientId", "correlationId", "payload", "scope"] (busEmitRequestAdditionalProperties value)))
data BusEmitRequestPayload = BusEmitRequestPayload
  { busEmitRequestPayloadAdditionalProperties :: KM.KeyMap Value
  } deriving (Eq, Show)
instance FromJSON BusEmitRequestPayload where parseJSON = checked "BusEmitRequestPayload" $ withObject "BusEmitRequestPayload" (\fields -> BusEmitRequestPayload <$> traverse parseJSON (withoutFields [] fields))
instance ToJSON BusEmitRequestPayload where toJSON value = Object (KM.fromList (concat []) <> fmap toJSON (withoutFields [] (busEmitRequestPayloadAdditionalProperties value)))
