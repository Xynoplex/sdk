-- Generated from protocol/specs/src. Run xynoplex-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynoplex.Internal.Generated.Models.YieldJobCompleteCommand
  ( YieldJobCompleteCommand(..)
  , YieldJobCompleteCommandJobType(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynoplex.Internal.Codec
import Xynoplex.Types.Presence (Presence)
import Xynoplex.Internal.Generated.Models.AnnotationId
import Xynoplex.Internal.Generated.Models.DurabilityEvidence
import Xynoplex.Internal.Generated.Models.JobId
import Xynoplex.Internal.Generated.Models.ResourceId
import Xynoplex.Internal.Generated.Models.UserId
import Xynoplex.Internal.Generated.Models.YieldJobResult
data YieldJobCompleteCommand = YieldJobCompleteCommand { yieldJobCompleteCommandU5f_userId :: Maybe (UserId), yieldJobCompleteCommandAnnotationId :: Maybe (AnnotationId), yieldJobCompleteCommandAttempt :: Maybe (Integer), yieldJobCompleteCommandDurability :: Maybe (DurabilityEvidence), yieldJobCompleteCommandJobId :: JobId, yieldJobCompleteCommandJobType :: YieldJobCompleteCommandJobType, yieldJobCompleteCommandResourceId :: ResourceId, yieldJobCompleteCommandResult :: Maybe (YieldJobResult), yieldJobCompleteCommandAdditionalProperties :: KM.KeyMap (Value) } deriving (Eq, Show)
instance FromJSON YieldJobCompleteCommand where
  parseJSON = checked "YieldJobCompleteCommand" $ withObject "YieldJobCompleteCommand" (\fields -> YieldJobCompleteCommand <$> optional fields "_userId" <*> optional fields "annotationId" <*> optional fields "attempt" <*> optional fields "durability" <*> fields .: "jobId" <*> fields .: "jobType" <*> fields .: "resourceId" <*> optional fields "result" <*> traverse parseJSON (withoutFields ["_userId", "annotationId", "attempt", "durability", "jobId", "jobType", "resourceId", "result"] fields))
instance ToJSON YieldJobCompleteCommand where toJSON value = Object (KM.fromList (concat [optionalPair "_userId" (yieldJobCompleteCommandU5f_userId value), optionalPair "annotationId" (yieldJobCompleteCommandAnnotationId value), optionalPair "attempt" (yieldJobCompleteCommandAttempt value), optionalPair "durability" (yieldJobCompleteCommandDurability value), [("jobId", toJSON (yieldJobCompleteCommandJobId value))], [("jobType", toJSON (yieldJobCompleteCommandJobType value))], [("resourceId", toJSON (yieldJobCompleteCommandResourceId value))], optionalPair "result" (yieldJobCompleteCommandResult value)]) <> fmap toJSON (withoutFields ["_userId", "annotationId", "attempt", "durability", "jobId", "jobType", "resourceId", "result"] (yieldJobCompleteCommandAdditionalProperties value)))

data YieldJobCompleteCommandJobType = YieldJobCompleteCommandJobTypeYield deriving (Eq, Show)
instance FromJSON YieldJobCompleteCommandJobType where
  parseJSON = checked "YieldJobCompleteCommandJobType" $ \value -> if value == (String "yield") then pure YieldJobCompleteCommandJobTypeYield else fail "unknown enumeration member"
instance ToJSON YieldJobCompleteCommandJobType where
  toJSON YieldJobCompleteCommandJobTypeYield = String "yield"
