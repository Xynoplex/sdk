-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.MarkCreateOk (MarkCreateOk(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.MarkCreateOkResponse
data MarkCreateOk = MarkCreateOk
  { markCreateOkResponse :: MarkCreateOkResponse
  , markCreateOkAdditionalProperties :: KM.KeyMap Value
  } deriving (Eq, Show)
instance FromJSON MarkCreateOk where parseJSON = checked "MarkCreateOk" $ withObject "MarkCreateOk" (\fields -> MarkCreateOk <$> (fields .: "response") <*> traverse parseJSON (withoutFields ["response"] fields))
instance ToJSON MarkCreateOk where toJSON value = Object (KM.fromList (concat [[("response", toJSON (markCreateOkResponse value))]]) <> fmap toJSON (withoutFields ["response"] (markCreateOkAdditionalProperties value)))
