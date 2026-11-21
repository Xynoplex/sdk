-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.SmelterReconcileSummary (SmelterReconcileSummary (..), SmelterReconcileSummaryResourcesSkipped (..)) where

import Data.Aeson (FromJSON (..), ToJSON (..), Value (..), withObject, (.:))
import Data.Aeson.KeyMap qualified as KM
import Xynolog.Internal.Codec

data SmelterReconcileSummary = SmelterReconcileSummary
  { smelterReconcileSummaryAnnotationVectorsDeleted :: Integer,
    smelterReconcileSummaryAnnotationsEmbedded :: Integer,
    smelterReconcileSummaryAnnotationsRestamped :: Integer,
    smelterReconcileSummaryResourceVectorsDeleted :: Integer,
    smelterReconcileSummaryResourcesEligible :: Integer,
    smelterReconcileSummaryResourcesEmbedded :: Integer,
    smelterReconcileSummaryResourcesFailed :: Integer,
    smelterReconcileSummaryResourcesIndexed :: Integer,
    smelterReconcileSummaryResourcesReanchored :: Integer,
    smelterReconcileSummaryResourcesRestamped :: Integer,
    smelterReconcileSummaryResourcesSkipped :: SmelterReconcileSummaryResourcesSkipped,
    smelterReconcileSummaryResourcesUnavailable :: Integer
  }
  deriving (Eq, Show)

instance FromJSON SmelterReconcileSummary where parseJSON = checked "SmelterReconcileSummary" $ withObject "SmelterReconcileSummary" (\fields -> SmelterReconcileSummary <$> (fields .: "annotationVectorsDeleted") <*> (fields .: "annotationsEmbedded") <*> (fields .: "annotationsRestamped") <*> (fields .: "resourceVectorsDeleted") <*> (fields .: "resourcesEligible") <*> (fields .: "resourcesEmbedded") <*> (fields .: "resourcesFailed") <*> (fields .: "resourcesIndexed") <*> (fields .: "resourcesReanchored") <*> (fields .: "resourcesRestamped") <*> (fields .: "resourcesSkipped") <*> (fields .: "resourcesUnavailable"))

instance ToJSON SmelterReconcileSummary where toJSON value = Object (KM.fromList (concat [[("annotationVectorsDeleted", toJSON (smelterReconcileSummaryAnnotationVectorsDeleted value))], [("annotationsEmbedded", toJSON (smelterReconcileSummaryAnnotationsEmbedded value))], [("annotationsRestamped", toJSON (smelterReconcileSummaryAnnotationsRestamped value))], [("resourceVectorsDeleted", toJSON (smelterReconcileSummaryResourceVectorsDeleted value))], [("resourcesEligible", toJSON (smelterReconcileSummaryResourcesEligible value))], [("resourcesEmbedded", toJSON (smelterReconcileSummaryResourcesEmbedded value))], [("resourcesFailed", toJSON (smelterReconcileSummaryResourcesFailed value))], [("resourcesIndexed", toJSON (smelterReconcileSummaryResourcesIndexed value))], [("resourcesReanchored", toJSON (smelterReconcileSummaryResourcesReanchored value))], [("resourcesRestamped", toJSON (smelterReconcileSummaryResourcesRestamped value))], [("resourcesSkipped", toJSON (smelterReconcileSummaryResourcesSkipped value))], [("resourcesUnavailable", toJSON (smelterReconcileSummaryResourcesUnavailable value))]]))

data SmelterReconcileSummaryResourcesSkipped = SmelterReconcileSummaryResourcesSkipped
  { smelterReconcileSummaryResourcesSkippedAdditionalProperties :: KM.KeyMap Integer
  }
  deriving (Eq, Show)

instance FromJSON SmelterReconcileSummaryResourcesSkipped where parseJSON = checked "SmelterReconcileSummaryResourcesSkipped" $ withObject "SmelterReconcileSummaryResourcesSkipped" (\fields -> SmelterReconcileSummaryResourcesSkipped <$> traverse parseJSON (withoutFields [] fields))

instance ToJSON SmelterReconcileSummaryResourcesSkipped where toJSON value = Object (KM.fromList (concat []) <> fmap toJSON (withoutFields [] (smelterReconcileSummaryResourcesSkippedAdditionalProperties value)))
