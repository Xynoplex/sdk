-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.YieldUpdateOk (YieldUpdateOk(..), YieldUpdateOkResponse(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.ResourceId
data YieldUpdateOk = YieldUpdateOk
  { yieldUpdateOkResponse :: YieldUpdateOkResponse
  , yieldUpdateOkAdditionalProperties :: KM.KeyMap Value
  } deriving (Eq, Show)
instance FromJSON YieldUpdateOk where parseJSON = checked "YieldUpdateOk" $ withObject "YieldUpdateOk" (\fields -> YieldUpdateOk <$> (fields .: "response") <*> traverse parseJSON (withoutFields ["response"] fields))
instance ToJSON YieldUpdateOk where toJSON value = Object (KM.fromList (concat [[("response", toJSON (yieldUpdateOkResponse value))]]) <> fmap toJSON (withoutFields ["response"] (yieldUpdateOkAdditionalProperties value)))
data YieldUpdateOkResponse = YieldUpdateOkResponse
  { yieldUpdateOkResponseResourceId :: ResourceId
  , yieldUpdateOkResponseAdditionalProperties :: KM.KeyMap Value
  } deriving (Eq, Show)
instance FromJSON YieldUpdateOkResponse where parseJSON = checked "YieldUpdateOkResponse" $ withObject "YieldUpdateOkResponse" (\fields -> YieldUpdateOkResponse <$> (fields .: "resourceId") <*> traverse parseJSON (withoutFields ["resourceId"] fields))
instance ToJSON YieldUpdateOkResponse where toJSON value = Object (KM.fromList (concat [[("resourceId", toJSON (yieldUpdateOkResponseResourceId value))]]) <> fmap toJSON (withoutFields ["resourceId"] (yieldUpdateOkResponseAdditionalProperties value)))
