-- Generated from protocol/specs/src. Run xynolog-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynolog.Internal.Generated.Models.ListResourcesResponse
  ( ListResourcesResponse(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Types.Presence (Presence)
import Xynolog.Internal.Generated.Models.ResourceDescriptor
data ListResourcesResponse = ListResourcesResponse { listResourcesResponseLimit :: Scientific, listResourcesResponseOffset :: Scientific, listResourcesResponseResources :: [ResourceDescriptor], listResourcesResponseTotal :: Scientific, listResourcesResponseAdditionalProperties :: KM.KeyMap (Value) } deriving (Eq, Show)
instance FromJSON ListResourcesResponse where
  parseJSON = checked "ListResourcesResponse" $ withObject "ListResourcesResponse" (\fields -> ListResourcesResponse <$> fields .: "limit" <*> fields .: "offset" <*> fields .: "resources" <*> fields .: "total" <*> traverse parseJSON (withoutFields ["limit", "offset", "resources", "total"] fields))
instance ToJSON ListResourcesResponse where toJSON value = Object (KM.fromList (concat [[("limit", toJSON (listResourcesResponseLimit value))], [("offset", toJSON (listResourcesResponseOffset value))], [("resources", toJSON (listResourcesResponseResources value))], [("total", toJSON (listResourcesResponseTotal value))]]) <> fmap toJSON (withoutFields ["limit", "offset", "resources", "total"] (listResourcesResponseAdditionalProperties value)))
