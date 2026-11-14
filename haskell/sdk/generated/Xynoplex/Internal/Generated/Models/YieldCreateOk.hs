-- Generated from protocol/specs/src. Run xynoplex-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynoplex.Internal.Generated.Models.YieldCreateOk
  ( YieldCreateOk(..)
  , YieldCreateOkResponse(..)
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
data YieldCreateOk = YieldCreateOk { yieldCreateOkResponse :: YieldCreateOkResponse, yieldCreateOkAdditionalProperties :: KM.KeyMap (Value) } deriving (Eq, Show)
instance FromJSON YieldCreateOk where
  parseJSON = checked "YieldCreateOk" $ withObject "YieldCreateOk" (\fields -> YieldCreateOk <$> fields .: "response" <*> traverse parseJSON (withoutFields ["response"] fields))
instance ToJSON YieldCreateOk where toJSON value = Object (KM.fromList (concat [[("response", toJSON (yieldCreateOkResponse value))]]) <> fmap toJSON (withoutFields ["response"] (yieldCreateOkAdditionalProperties value)))

data YieldCreateOkResponse = YieldCreateOkResponse { yieldCreateOkResponseResourceId :: ResourceId, yieldCreateOkResponseAdditionalProperties :: KM.KeyMap (Value) } deriving (Eq, Show)
instance FromJSON YieldCreateOkResponse where
  parseJSON = checked "YieldCreateOkResponse" $ withObject "YieldCreateOkResponse" (\fields -> YieldCreateOkResponse <$> fields .: "resourceId" <*> traverse parseJSON (withoutFields ["resourceId"] fields))
instance ToJSON YieldCreateOkResponse where toJSON value = Object (KM.fromList (concat [[("resourceId", toJSON (yieldCreateOkResponseResourceId value))]]) <> fmap toJSON (withoutFields ["resourceId"] (yieldCreateOkResponseAdditionalProperties value)))
