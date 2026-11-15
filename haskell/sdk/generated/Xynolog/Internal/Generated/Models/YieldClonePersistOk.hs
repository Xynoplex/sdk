-- Generated from protocol/specs/src. Run xynolog-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynolog.Internal.Generated.Models.YieldClonePersistOk
  ( YieldClonePersistOk(..)
  , YieldClonePersistOkResponse(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Types.Presence (Presence)
import Xynolog.Internal.Generated.Models.ResourceId
data YieldClonePersistOk = YieldClonePersistOk { yieldClonePersistOkResponse :: YieldClonePersistOkResponse, yieldClonePersistOkAdditionalProperties :: KM.KeyMap (Value) } deriving (Eq, Show)
instance FromJSON YieldClonePersistOk where
  parseJSON = checked "YieldClonePersistOk" $ withObject "YieldClonePersistOk" (\fields -> YieldClonePersistOk <$> fields .: "response" <*> traverse parseJSON (withoutFields ["response"] fields))
instance ToJSON YieldClonePersistOk where toJSON value = Object (KM.fromList (concat [[("response", toJSON (yieldClonePersistOkResponse value))]]) <> fmap toJSON (withoutFields ["response"] (yieldClonePersistOkAdditionalProperties value)))

data YieldClonePersistOkResponse = YieldClonePersistOkResponse { yieldClonePersistOkResponseResourceId :: ResourceId, yieldClonePersistOkResponseAdditionalProperties :: KM.KeyMap (Value) } deriving (Eq, Show)
instance FromJSON YieldClonePersistOkResponse where
  parseJSON = checked "YieldClonePersistOkResponse" $ withObject "YieldClonePersistOkResponse" (\fields -> YieldClonePersistOkResponse <$> fields .: "resourceId" <*> traverse parseJSON (withoutFields ["resourceId"] fields))
instance ToJSON YieldClonePersistOkResponse where toJSON value = Object (KM.fromList (concat [[("resourceId", toJSON (yieldClonePersistOkResponseResourceId value))]]) <> fmap toJSON (withoutFields ["resourceId"] (yieldClonePersistOkResponseAdditionalProperties value)))
