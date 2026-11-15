-- Generated from protocol/specs/src. Run xynolog-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynolog.Internal.Generated.Models.GatherResourceComplete
  ( GatherResourceComplete(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Types.Presence (Presence)
import Xynolog.Internal.Generated.Models.GatheredContext
import Xynolog.Internal.Generated.Models.ResourceId
data GatherResourceComplete = GatherResourceComplete { gatherResourceCompleteResourceId :: ResourceId, gatherResourceCompleteResponse :: GatheredContext, gatherResourceCompleteAdditionalProperties :: KM.KeyMap (Value) } deriving (Eq, Show)
instance FromJSON GatherResourceComplete where
  parseJSON = checked "GatherResourceComplete" $ withObject "GatherResourceComplete" (\fields -> GatherResourceComplete <$> fields .: "resourceId" <*> fields .: "response" <*> traverse parseJSON (withoutFields ["resourceId", "response"] fields))
instance ToJSON GatherResourceComplete where toJSON value = Object (KM.fromList (concat [[("resourceId", toJSON (gatherResourceCompleteResourceId value))], [("response", toJSON (gatherResourceCompleteResponse value))]]) <> fmap toJSON (withoutFields ["resourceId", "response"] (gatherResourceCompleteAdditionalProperties value)))
