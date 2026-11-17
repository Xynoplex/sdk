-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.EnrichedResourceEvent (EnrichedResourceEvent(..), EnrichedResourceEventPayload(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.Annotation
import Xynolog.Internal.Generated.Models.EventMetadata
import Xynolog.Internal.Generated.Models.ResourceId
import Xynolog.Internal.Generated.Models.UserId
data EnrichedResourceEvent = EnrichedResourceEvent
  { enrichedResourceEventAnnotation :: Maybe Annotation
  , enrichedResourceEventId :: Text
  , enrichedResourceEventMetadata :: EventMetadata
  , enrichedResourceEventPayload :: EnrichedResourceEventPayload
  , enrichedResourceEventResourceId :: Maybe ResourceId
  , enrichedResourceEventTimestamp :: Text
  , enrichedResourceEventType :: Text
  , enrichedResourceEventUserId :: UserId
  , enrichedResourceEventVersion :: Integer
  , enrichedResourceEventAdditionalProperties :: KM.KeyMap Value
  } deriving (Eq, Show)
instance FromJSON EnrichedResourceEvent where parseJSON = checked "EnrichedResourceEvent" $ withObject "EnrichedResourceEvent" (\fields -> EnrichedResourceEvent <$> optional fields "annotation" <*> (fields .: "id") <*> (fields .: "metadata") <*> (fields .: "payload") <*> optional fields "resourceId" <*> (fields .: "timestamp") <*> (fields .: "type") <*> (fields .: "userId") <*> (fields .: "version") <*> traverse parseJSON (withoutFields ["annotation", "id", "metadata", "payload", "resourceId", "timestamp", "type", "userId", "version"] fields))
instance ToJSON EnrichedResourceEvent where toJSON value = Object (KM.fromList (concat [optionalPair "annotation" (enrichedResourceEventAnnotation value), [("id", toJSON (enrichedResourceEventId value))], [("metadata", toJSON (enrichedResourceEventMetadata value))], [("payload", toJSON (enrichedResourceEventPayload value))], optionalPair "resourceId" (enrichedResourceEventResourceId value), [("timestamp", toJSON (enrichedResourceEventTimestamp value))], [("type", toJSON (enrichedResourceEventType value))], [("userId", toJSON (enrichedResourceEventUserId value))], [("version", toJSON (enrichedResourceEventVersion value))]]) <> fmap toJSON (withoutFields ["annotation", "id", "metadata", "payload", "resourceId", "timestamp", "type", "userId", "version"] (enrichedResourceEventAdditionalProperties value)))
data EnrichedResourceEventPayload = EnrichedResourceEventPayload
  { enrichedResourceEventPayloadAdditionalProperties :: KM.KeyMap Value
  } deriving (Eq, Show)
instance FromJSON EnrichedResourceEventPayload where parseJSON = checked "EnrichedResourceEventPayload" $ withObject "EnrichedResourceEventPayload" (\fields -> EnrichedResourceEventPayload <$> traverse parseJSON (withoutFields [] fields))
instance ToJSON EnrichedResourceEventPayload where toJSON value = Object (KM.fromList (concat []) <> fmap toJSON (withoutFields [] (enrichedResourceEventPayloadAdditionalProperties value)))
