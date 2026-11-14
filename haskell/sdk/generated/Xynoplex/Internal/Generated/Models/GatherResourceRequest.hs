-- Generated from protocol/specs/src. Run xynoplex-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynoplex.Internal.Generated.Models.GatherResourceRequest
  ( GatherResourceRequest(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynoplex.Internal.Codec
import Xynoplex.Types.Presence (Presence)
import Xynoplex.Internal.Generated.Models.GatherResourceRequestOptions
import Xynoplex.Internal.Generated.Models.ResourceId
data GatherResourceRequest = GatherResourceRequest { gatherResourceRequestOptions :: GatherResourceRequestOptions, gatherResourceRequestResourceId :: ResourceId, gatherResourceRequestAdditionalProperties :: KM.KeyMap (Value) } deriving (Eq, Show)
instance FromJSON GatherResourceRequest where
  parseJSON = checked "GatherResourceRequest" $ withObject "GatherResourceRequest" (\fields -> GatherResourceRequest <$> fields .: "options" <*> fields .: "resourceId" <*> traverse parseJSON (withoutFields ["options", "resourceId"] fields))
instance ToJSON GatherResourceRequest where toJSON value = Object (KM.fromList (concat [[("options", toJSON (gatherResourceRequestOptions value))], [("resourceId", toJSON (gatherResourceRequestResourceId value))]]) <> fmap toJSON (withoutFields ["options", "resourceId"] (gatherResourceRequestAdditionalProperties value)))
