-- Generated from protocol/specs/src. Run xynoplex-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynoplex.Internal.Generated.Models.YieldCloneTokenRequest
  ( YieldCloneTokenRequest(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynoplex.Internal.Codec
import Xynoplex.Types.Presence (Presence)
import Xynoplex.Internal.Generated.Models.ResourceId
data YieldCloneTokenRequest = YieldCloneTokenRequest { yieldCloneTokenRequestResourceId :: ResourceId, yieldCloneTokenRequestAdditionalProperties :: KM.KeyMap (Value) } deriving (Eq, Show)
instance FromJSON YieldCloneTokenRequest where
  parseJSON = checked "YieldCloneTokenRequest" $ withObject "YieldCloneTokenRequest" (\fields -> YieldCloneTokenRequest <$> fields .: "resourceId" <*> traverse parseJSON (withoutFields ["resourceId"] fields))
instance ToJSON YieldCloneTokenRequest where toJSON value = Object (KM.fromList (concat [[("resourceId", toJSON (yieldCloneTokenRequestResourceId value))]]) <> fmap toJSON (withoutFields ["resourceId"] (yieldCloneTokenRequestAdditionalProperties value)))
