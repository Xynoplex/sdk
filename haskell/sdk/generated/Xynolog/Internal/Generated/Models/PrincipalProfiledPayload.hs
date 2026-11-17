-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.PrincipalProfiledPayload (PrincipalProfiledPayload(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Data.Text (Text)
import Xynolog.Internal.Codec
data PrincipalProfiledPayload = PrincipalProfiledPayload
  { principalProfiledPayloadName :: Text
  , principalProfiledPayloadAdditionalProperties :: KM.KeyMap Value
  } deriving (Eq, Show)
instance FromJSON PrincipalProfiledPayload where parseJSON = checked "PrincipalProfiledPayload" $ withObject "PrincipalProfiledPayload" (\fields -> PrincipalProfiledPayload <$> (fields .: "name") <*> traverse parseJSON (withoutFields ["name"] fields))
instance ToJSON PrincipalProfiledPayload where toJSON value = Object (KM.fromList (concat [[("name", toJSON (principalProfiledPayloadName value))]]) <> fmap toJSON (withoutFields ["name"] (principalProfiledPayloadAdditionalProperties value)))
