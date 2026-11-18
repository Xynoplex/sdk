-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.Models.GetReferencedByResponseReferencedByItem (GetReferencedByResponseReferencedByItem(..), GetReferencedByResponseReferencedByItemTarget(..), GetReferencedByResponseReferencedByItemTargetSelector(..)) where
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import qualified Data.Aeson.KeyMap as KM
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Internal.Generated.Models.AnnotationId
import Xynolog.Internal.Generated.Models.ResourceId
data GetReferencedByResponseReferencedByItem = GetReferencedByResponseReferencedByItem
  { getReferencedByResponseReferencedByItemId :: AnnotationId
  , getReferencedByResponseReferencedByItemResourceName :: Maybe Text
  , getReferencedByResponseReferencedByItemTarget :: GetReferencedByResponseReferencedByItemTarget
  , getReferencedByResponseReferencedByItemAdditionalProperties :: KM.KeyMap Value
  } deriving (Eq, Show)
instance FromJSON GetReferencedByResponseReferencedByItem where parseJSON = checked "GetReferencedByResponseReferencedByItem" $ withObject "GetReferencedByResponseReferencedByItem" (\fields -> GetReferencedByResponseReferencedByItem <$> (fields .: "id") <*> optional fields "resourceName" <*> (fields .: "target") <*> traverse parseJSON (withoutFields ["id", "resourceName", "target"] fields))
instance ToJSON GetReferencedByResponseReferencedByItem where toJSON value = Object (KM.fromList (concat [[("id", toJSON (getReferencedByResponseReferencedByItemId value))], optionalPair "resourceName" (getReferencedByResponseReferencedByItemResourceName value), [("target", toJSON (getReferencedByResponseReferencedByItemTarget value))]]) <> fmap toJSON (withoutFields ["id", "resourceName", "target"] (getReferencedByResponseReferencedByItemAdditionalProperties value)))
data GetReferencedByResponseReferencedByItemTarget = GetReferencedByResponseReferencedByItemTarget
  { getReferencedByResponseReferencedByItemTargetSelector :: GetReferencedByResponseReferencedByItemTargetSelector
  , getReferencedByResponseReferencedByItemTargetSource :: ResourceId
  , getReferencedByResponseReferencedByItemTargetAdditionalProperties :: KM.KeyMap Value
  } deriving (Eq, Show)
instance FromJSON GetReferencedByResponseReferencedByItemTarget where parseJSON = checked "GetReferencedByResponseReferencedByItemTarget" $ withObject "GetReferencedByResponseReferencedByItemTarget" (\fields -> GetReferencedByResponseReferencedByItemTarget <$> (fields .: "selector") <*> (fields .: "source") <*> traverse parseJSON (withoutFields ["selector", "source"] fields))
instance ToJSON GetReferencedByResponseReferencedByItemTarget where toJSON value = Object (KM.fromList (concat [[("selector", toJSON (getReferencedByResponseReferencedByItemTargetSelector value))], [("source", toJSON (getReferencedByResponseReferencedByItemTargetSource value))]]) <> fmap toJSON (withoutFields ["selector", "source"] (getReferencedByResponseReferencedByItemTargetAdditionalProperties value)))
data GetReferencedByResponseReferencedByItemTargetSelector = GetReferencedByResponseReferencedByItemTargetSelector
  { getReferencedByResponseReferencedByItemTargetSelectorExact :: Text
  , getReferencedByResponseReferencedByItemTargetSelectorAdditionalProperties :: KM.KeyMap Value
  } deriving (Eq, Show)
instance FromJSON GetReferencedByResponseReferencedByItemTargetSelector where parseJSON = checked "GetReferencedByResponseReferencedByItemTargetSelector" $ withObject "GetReferencedByResponseReferencedByItemTargetSelector" (\fields -> GetReferencedByResponseReferencedByItemTargetSelector <$> (fields .: "exact") <*> traverse parseJSON (withoutFields ["exact"] fields))
instance ToJSON GetReferencedByResponseReferencedByItemTargetSelector where toJSON value = Object (KM.fromList (concat [[("exact", toJSON (getReferencedByResponseReferencedByItemTargetSelectorExact value))]]) <> fmap toJSON (withoutFields ["exact"] (getReferencedByResponseReferencedByItemTargetSelectorAdditionalProperties value)))
