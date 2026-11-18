-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.YieldCloneCreated (YieldCloneCreated(..), YieldCloneCreatedResponse(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.ResourceId
data YieldCloneCreated = YieldCloneCreated
  { yieldCloneCreatedResponse :: YieldCloneCreatedResponse
  , yieldCloneCreatedAdditionalProperties :: KM.KeyMap Value
  } deriving (Eq, Show)
instance FromJSON YieldCloneCreated where parseJSON = checked "YieldCloneCreated" $ withObject "YieldCloneCreated" (\fields -> YieldCloneCreated <$> (fields .: "response") <*> traverse parseJSON (withoutFields ["response"] fields))
instance ToJSON YieldCloneCreated where toJSON value = Object (KM.fromList (concat [[("response", toJSON (yieldCloneCreatedResponse value))]]) <> fmap toJSON (withoutFields ["response"] (yieldCloneCreatedAdditionalProperties value)))
data YieldCloneCreatedResponse = YieldCloneCreatedResponse
  { yieldCloneCreatedResponseResourceId :: ResourceId
  , yieldCloneCreatedResponseAdditionalProperties :: KM.KeyMap Value
  } deriving (Eq, Show)
instance FromJSON YieldCloneCreatedResponse where parseJSON = checked "YieldCloneCreatedResponse" $ withObject "YieldCloneCreatedResponse" (\fields -> YieldCloneCreatedResponse <$> (fields .: "resourceId") <*> traverse parseJSON (withoutFields ["resourceId"] fields))
instance ToJSON YieldCloneCreatedResponse where toJSON value = Object (KM.fromList (concat [[("resourceId", toJSON (yieldCloneCreatedResponseResourceId value))]]) <> fmap toJSON (withoutFields ["resourceId"] (yieldCloneCreatedResponseAdditionalProperties value)))
