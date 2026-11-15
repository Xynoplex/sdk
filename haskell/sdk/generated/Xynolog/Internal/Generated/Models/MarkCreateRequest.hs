-- Generated from protocol/specs/src. Run xynolog-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynolog.Internal.Generated.Models.MarkCreateRequest
  ( MarkCreateRequest(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Types.Presence (Presence)
import Xynolog.Internal.Generated.Models.CreateAnnotationRequest
import Xynolog.Internal.Generated.Models.ResourceId
data MarkCreateRequest = MarkCreateRequest { markCreateRequestRequest :: CreateAnnotationRequest, markCreateRequestResourceId :: ResourceId, markCreateRequestAdditionalProperties :: KM.KeyMap (Value) } deriving (Eq, Show)
instance FromJSON MarkCreateRequest where
  parseJSON = checked "MarkCreateRequest" $ withObject "MarkCreateRequest" (\fields -> MarkCreateRequest <$> fields .: "request" <*> fields .: "resourceId" <*> traverse parseJSON (withoutFields ["request", "resourceId"] fields))
instance ToJSON MarkCreateRequest where toJSON value = Object (KM.fromList (concat [[("request", toJSON (markCreateRequestRequest value))], [("resourceId", toJSON (markCreateRequestResourceId value))]]) <> fmap toJSON (withoutFields ["request", "resourceId"] (markCreateRequestAdditionalProperties value)))
