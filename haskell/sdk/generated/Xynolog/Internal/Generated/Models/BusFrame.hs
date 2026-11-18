-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.BusFrame (BusFrame (..), BusFramePayload (..)) where

import Data.Aeson (FromJSON (..), ToJSON (..), Value (..), withObject, (.:))
import Data.Aeson.KeyMap qualified as KM
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.ResourceId

data BusFrame = BusFrame
  { busFrameChannel :: Text,
    busFrameCorrelationId :: Maybe Text,
    busFramePayload :: BusFramePayload,
    busFrameScope :: Maybe ResourceId
  }
  deriving (Eq, Show)

instance FromJSON BusFrame where parseJSON = checked "BusFrame" $ withObject "BusFrame" (\fields -> BusFrame <$> (fields .: "channel") <*> optional fields "correlationId" <*> (fields .: "payload") <*> optional fields "scope")

instance ToJSON BusFrame where toJSON value = Object (KM.fromList (concat [[("channel", toJSON (busFrameChannel value))], optionalPair "correlationId" (busFrameCorrelationId value), [("payload", toJSON (busFramePayload value))], optionalPair "scope" (busFrameScope value)]))

data BusFramePayload = BusFramePayload
  { busFramePayloadAdditionalProperties :: KM.KeyMap Value
  }
  deriving (Eq, Show)

instance FromJSON BusFramePayload where parseJSON = checked "BusFramePayload" $ withObject "BusFramePayload" (\fields -> BusFramePayload <$> traverse parseJSON (withoutFields [] fields))

instance ToJSON BusFramePayload where toJSON value = Object (KM.fromList (concat []) <> fmap toJSON (withoutFields [] (busFramePayloadAdditionalProperties value)))
