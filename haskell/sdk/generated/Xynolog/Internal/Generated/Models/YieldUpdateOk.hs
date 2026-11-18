-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.YieldUpdateOk (YieldUpdateOk(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.YieldedResource
data YieldUpdateOk = YieldUpdateOk
  { yieldUpdateOkResponse :: YieldedResource
  , yieldUpdateOkAdditionalProperties :: KM.KeyMap Value
  } deriving (Eq, Show)
instance FromJSON YieldUpdateOk where parseJSON = checked "YieldUpdateOk" $ withObject "YieldUpdateOk" (\fields -> YieldUpdateOk <$> (fields .: "response") <*> traverse parseJSON (withoutFields ["response"] fields))
instance ToJSON YieldUpdateOk where toJSON value = Object (KM.fromList (concat [[("response", toJSON (yieldUpdateOkResponse value))]]) <> fmap toJSON (withoutFields ["response"] (yieldUpdateOkAdditionalProperties value)))
