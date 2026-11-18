-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.MarkDelegateTimeoutEvent (MarkDelegateTimeoutEvent(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.Motivation
import Xynolog.Internal.Generated.Models.ResourceId
data MarkDelegateTimeoutEvent = MarkDelegateTimeoutEvent
  { markDelegateTimeoutEventMotivation :: Motivation
  , markDelegateTimeoutEventResourceId :: ResourceId
  , markDelegateTimeoutEventAdditionalProperties :: KM.KeyMap Value
  } deriving (Eq, Show)
instance FromJSON MarkDelegateTimeoutEvent where parseJSON = checked "MarkDelegateTimeoutEvent" $ withObject "MarkDelegateTimeoutEvent" (\fields -> MarkDelegateTimeoutEvent <$> (fields .: "motivation") <*> (fields .: "resourceId") <*> traverse parseJSON (withoutFields ["motivation", "resourceId"] fields))
instance ToJSON MarkDelegateTimeoutEvent where toJSON value = Object (KM.fromList (concat [[("motivation", toJSON (markDelegateTimeoutEventMotivation value))], [("resourceId", toJSON (markDelegateTimeoutEventResourceId value))]]) <> fmap toJSON (withoutFields ["motivation", "resourceId"] (markDelegateTimeoutEventAdditionalProperties value)))
