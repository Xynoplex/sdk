-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.KbTarget (KbTarget(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.KbEndpoint
data KbTarget = KbTarget
  { kbTargetEndpoint :: KbEndpoint
  , kbTargetId :: Text
  , kbTargetLabel :: Text
  , kbTargetAdditionalProperties :: KM.KeyMap Value
  } deriving (Eq, Show)
instance FromJSON KbTarget where parseJSON = checked "KbTarget" $ withObject "KbTarget" (\fields -> KbTarget <$> (fields .: "endpoint") <*> (fields .: "id") <*> (fields .: "label") <*> traverse parseJSON (withoutFields ["endpoint", "id", "label"] fields))
instance ToJSON KbTarget where toJSON value = Object (KM.fromList (concat [[("endpoint", toJSON (kbTargetEndpoint value))], [("id", toJSON (kbTargetId value))], [("label", toJSON (kbTargetLabel value))]]) <> fmap toJSON (withoutFields ["endpoint", "id", "label"] (kbTargetAdditionalProperties value)))
