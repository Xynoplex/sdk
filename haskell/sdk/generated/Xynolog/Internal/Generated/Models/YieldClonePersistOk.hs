-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.YieldClonePersistOk (YieldClonePersistOk (..), YieldClonePersistOkResponse (..)) where

import Data.Aeson (FromJSON (..), ToJSON (..), Value (..), withObject, (.:))
import Data.Aeson.KeyMap qualified as KM
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.ResourceId

data YieldClonePersistOk = YieldClonePersistOk
  { yieldClonePersistOkResponse :: YieldClonePersistOkResponse,
    yieldClonePersistOkAdditionalProperties :: KM.KeyMap Value
  }
  deriving (Eq, Show)

instance FromJSON YieldClonePersistOk where parseJSON = checked "YieldClonePersistOk" $ withObject "YieldClonePersistOk" (\fields -> YieldClonePersistOk <$> (fields .: "response") <*> traverse parseJSON (withoutFields ["response"] fields))

instance ToJSON YieldClonePersistOk where toJSON value = Object (KM.fromList (concat [[("response", toJSON (yieldClonePersistOkResponse value))]]) <> fmap toJSON (withoutFields ["response"] (yieldClonePersistOkAdditionalProperties value)))

data YieldClonePersistOkResponse = YieldClonePersistOkResponse
  { yieldClonePersistOkResponseResourceId :: ResourceId,
    yieldClonePersistOkResponseAdditionalProperties :: KM.KeyMap Value
  }
  deriving (Eq, Show)

instance FromJSON YieldClonePersistOkResponse where parseJSON = checked "YieldClonePersistOkResponse" $ withObject "YieldClonePersistOkResponse" (\fields -> YieldClonePersistOkResponse <$> (fields .: "resourceId") <*> traverse parseJSON (withoutFields ["resourceId"] fields))

instance ToJSON YieldClonePersistOkResponse where toJSON value = Object (KM.fromList (concat [[("resourceId", toJSON (yieldClonePersistOkResponseResourceId value))]]) <> fmap toJSON (withoutFields ["resourceId"] (yieldClonePersistOkResponseAdditionalProperties value)))
