-- Generated from protocol/specs/src; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/haskell_sdk.ml)
{-# LANGUAGE OverloadedStrings #-}

module Xynolog.Internal.Generated.Models.WeaverHealth (WeaverHealth (..), WeaverHealthFollowing (..), WeaverHealthFollowingSweep (..), WeaverHealthReconcile (..), WeaverHealthReconcilePhase (..), WeaverHealthReconcileSummary (..), WeaverHealthStatus (..)) where

import Data.Aeson (FromJSON (..), ToJSON (..), Value (..), withObject, (.:))
import Data.Aeson.KeyMap qualified as KM
import Data.Text (Text)
import Xynolog.Internal.Codec

data WeaverHealth = WeaverHealth
  { weaverHealthFollowing :: WeaverHealthFollowing,
    weaverHealthKb :: Text,
    weaverHealthReconcile :: WeaverHealthReconcile,
    weaverHealthStatus :: WeaverHealthStatus
  }
  deriving (Eq, Show)

instance FromJSON WeaverHealth where parseJSON = checked "WeaverHealth" $ withObject "WeaverHealth" (\fields -> WeaverHealth <$> (fields .: "following") <*> (fields .: "kb") <*> (fields .: "reconcile") <*> (fields .: "status"))

instance ToJSON WeaverHealth where toJSON value = Object (KM.fromList (concat [[("following", toJSON (weaverHealthFollowing value))], [("kb", toJSON (weaverHealthKb value))], [("reconcile", toJSON (weaverHealthReconcile value))], [("status", toJSON (weaverHealthStatus value))]]))

data WeaverHealthFollowing = WeaverHealthFollowing
  { weaverHealthFollowingRefused :: Integer,
    weaverHealthFollowingStopped :: Integer,
    weaverHealthFollowingStreamDrops :: Integer,
    weaverHealthFollowingSweep :: WeaverHealthFollowingSweep
  }
  deriving (Eq, Show)

instance FromJSON WeaverHealthFollowing where parseJSON = checked "WeaverHealthFollowing" $ withObject "WeaverHealthFollowing" (\fields -> WeaverHealthFollowing <$> (fields .: "refused") <*> (fields .: "stopped") <*> (fields .: "streamDrops") <*> (fields .: "sweep"))

instance ToJSON WeaverHealthFollowing where toJSON value = Object (KM.fromList (concat [[("refused", toJSON (weaverHealthFollowingRefused value))], [("stopped", toJSON (weaverHealthFollowingStopped value))], [("streamDrops", toJSON (weaverHealthFollowingStreamDrops value))], [("sweep", toJSON (weaverHealthFollowingSweep value))]]))

data WeaverHealthFollowingSweep = WeaverHealthFollowingSweepPending | WeaverHealthFollowingSweepRunning | WeaverHealthFollowingSweepDone | WeaverHealthFollowingSweepDue deriving (Eq, Show)

instance FromJSON WeaverHealthFollowingSweep where parseJSON = checked "WeaverHealthFollowingSweep" $ \value -> if value == String "pending" then pure WeaverHealthFollowingSweepPending else if value == String "running" then pure WeaverHealthFollowingSweepRunning else if value == String "done" then pure WeaverHealthFollowingSweepDone else if value == String "due" then pure WeaverHealthFollowingSweepDue else fail "unknown enumeration member"

instance ToJSON WeaverHealthFollowingSweep where
  toJSON WeaverHealthFollowingSweepPending = String "pending"
  toJSON WeaverHealthFollowingSweepRunning = String "running"
  toJSON WeaverHealthFollowingSweepDone = String "done"
  toJSON WeaverHealthFollowingSweepDue = String "due"

data WeaverHealthReconcile = WeaverHealthReconcile
  { weaverHealthReconcileError :: Maybe Text,
    weaverHealthReconcilePhase :: WeaverHealthReconcilePhase,
    weaverHealthReconcileSummary :: Maybe WeaverHealthReconcileSummary
  }
  deriving (Eq, Show)

instance FromJSON WeaverHealthReconcile where parseJSON = checked "WeaverHealthReconcile" $ withObject "WeaverHealthReconcile" (\fields -> WeaverHealthReconcile <$> optional fields "error" <*> (fields .: "phase") <*> optional fields "summary")

instance ToJSON WeaverHealthReconcile where toJSON value = Object (KM.fromList (concat [optionalPair "error" (weaverHealthReconcileError value), [("phase", toJSON (weaverHealthReconcilePhase value))], optionalPair "summary" (weaverHealthReconcileSummary value)]))

data WeaverHealthReconcilePhase = WeaverHealthReconcilePhasePending | WeaverHealthReconcilePhaseRunning | WeaverHealthReconcilePhaseDone | WeaverHealthReconcilePhaseFailed deriving (Eq, Show)

instance FromJSON WeaverHealthReconcilePhase where parseJSON = checked "WeaverHealthReconcilePhase" $ \value -> if value == String "pending" then pure WeaverHealthReconcilePhasePending else if value == String "running" then pure WeaverHealthReconcilePhaseRunning else if value == String "done" then pure WeaverHealthReconcilePhaseDone else if value == String "failed" then pure WeaverHealthReconcilePhaseFailed else fail "unknown enumeration member"

instance ToJSON WeaverHealthReconcilePhase where
  toJSON WeaverHealthReconcilePhasePending = String "pending"
  toJSON WeaverHealthReconcilePhaseRunning = String "running"
  toJSON WeaverHealthReconcilePhaseDone = String "done"
  toJSON WeaverHealthReconcilePhaseFailed = String "failed"

data WeaverHealthReconcileSummary = WeaverHealthReconcileSummary
  { weaverHealthReconcileSummaryDivergent :: Integer,
    weaverHealthReconcileSummaryHealFailures :: Integer,
    weaverHealthReconcileSummaryHealed :: Integer,
    weaverHealthReconcileSummaryOrphaned :: Integer,
    weaverHealthReconcileSummaryResourcesChecked :: Integer
  }
  deriving (Eq, Show)

instance FromJSON WeaverHealthReconcileSummary where parseJSON = checked "WeaverHealthReconcileSummary" $ withObject "WeaverHealthReconcileSummary" (\fields -> WeaverHealthReconcileSummary <$> (fields .: "divergent") <*> (fields .: "healFailures") <*> (fields .: "healed") <*> (fields .: "orphaned") <*> (fields .: "resourcesChecked"))

instance ToJSON WeaverHealthReconcileSummary where toJSON value = Object (KM.fromList (concat [[("divergent", toJSON (weaverHealthReconcileSummaryDivergent value))], [("healFailures", toJSON (weaverHealthReconcileSummaryHealFailures value))], [("healed", toJSON (weaverHealthReconcileSummaryHealed value))], [("orphaned", toJSON (weaverHealthReconcileSummaryOrphaned value))], [("resourcesChecked", toJSON (weaverHealthReconcileSummaryResourcesChecked value))]]))

data WeaverHealthStatus = WeaverHealthStatusOk deriving (Eq, Show)

instance FromJSON WeaverHealthStatus where parseJSON = checked "WeaverHealthStatus" $ \value -> if value == String "ok" then pure WeaverHealthStatusOk else fail "unknown enumeration member"

instance ToJSON WeaverHealthStatus where toJSON WeaverHealthStatusOk = String "ok"
