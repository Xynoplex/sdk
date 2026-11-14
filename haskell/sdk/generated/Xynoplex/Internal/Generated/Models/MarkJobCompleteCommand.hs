-- Generated from protocol/specs/src. Run xynoplex-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynoplex.Internal.Generated.Models.MarkJobCompleteCommand
  ( MarkJobCompleteCommand(..)
  , MarkJobCompleteCommandJobType(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynoplex.Internal.Codec
import Xynoplex.Types.Presence (Presence)
import Xynoplex.Internal.Generated.Models.DurabilityEvidence
import Xynoplex.Internal.Generated.Models.JobId
import Xynoplex.Internal.Generated.Models.MarkJobResult
import Xynoplex.Internal.Generated.Models.ResourceId
import Xynoplex.Internal.Generated.Models.UserId
data MarkJobCompleteCommand = MarkJobCompleteCommand { markJobCompleteCommandU5f_userId :: Maybe (UserId), markJobCompleteCommandAttempt :: Maybe (Integer), markJobCompleteCommandDurability :: Maybe (DurabilityEvidence), markJobCompleteCommandJobId :: JobId, markJobCompleteCommandJobType :: MarkJobCompleteCommandJobType, markJobCompleteCommandResourceId :: ResourceId, markJobCompleteCommandResult :: Maybe (MarkJobResult), markJobCompleteCommandAdditionalProperties :: KM.KeyMap (Value) } deriving (Eq, Show)
instance FromJSON MarkJobCompleteCommand where
  parseJSON = checked "MarkJobCompleteCommand" $ withObject "MarkJobCompleteCommand" (\fields -> MarkJobCompleteCommand <$> optional fields "_userId" <*> optional fields "attempt" <*> optional fields "durability" <*> fields .: "jobId" <*> fields .: "jobType" <*> fields .: "resourceId" <*> optional fields "result" <*> traverse parseJSON (withoutFields ["_userId", "attempt", "durability", "jobId", "jobType", "resourceId", "result"] fields))
instance ToJSON MarkJobCompleteCommand where toJSON value = Object (KM.fromList (concat [optionalPair "_userId" (markJobCompleteCommandU5f_userId value), optionalPair "attempt" (markJobCompleteCommandAttempt value), optionalPair "durability" (markJobCompleteCommandDurability value), [("jobId", toJSON (markJobCompleteCommandJobId value))], [("jobType", toJSON (markJobCompleteCommandJobType value))], [("resourceId", toJSON (markJobCompleteCommandResourceId value))], optionalPair "result" (markJobCompleteCommandResult value)]) <> fmap toJSON (withoutFields ["_userId", "attempt", "durability", "jobId", "jobType", "resourceId", "result"] (markJobCompleteCommandAdditionalProperties value)))

data MarkJobCompleteCommandJobType = MarkJobCompleteCommandJobTypeMark deriving (Eq, Show)
instance FromJSON MarkJobCompleteCommandJobType where
  parseJSON = checked "MarkJobCompleteCommandJobType" $ \value -> if value == (String "mark") then pure MarkJobCompleteCommandJobTypeMark else fail "unknown enumeration member"
instance ToJSON MarkJobCompleteCommandJobType where
  toJSON MarkJobCompleteCommandJobTypeMark = String "mark"
