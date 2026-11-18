-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.ResourceErrorEvent (ResourceErrorEvent(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.ResourceId
data ResourceErrorEvent = ResourceErrorEvent
  { resourceErrorEventMessage :: Text
  , resourceErrorEventResourceId :: ResourceId
  , resourceErrorEventAdditionalProperties :: KM.KeyMap Value
  } deriving (Eq, Show)
instance FromJSON ResourceErrorEvent where parseJSON = checked "ResourceErrorEvent" $ withObject "ResourceErrorEvent" (\fields -> ResourceErrorEvent <$> (fields .: "message") <*> (fields .: "resourceId") <*> traverse parseJSON (withoutFields ["message", "resourceId"] fields))
instance ToJSON ResourceErrorEvent where toJSON value = Object (KM.fromList (concat [[("message", toJSON (resourceErrorEventMessage value))], [("resourceId", toJSON (resourceErrorEventResourceId value))]]) <> fmap toJSON (withoutFields ["message", "resourceId"] (resourceErrorEventAdditionalProperties value)))
