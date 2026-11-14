-- Generated from protocol/specs/src. Run xynoplex-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynoplex.Internal.Generated.Models.JobClaimCommand
  ( JobClaimCommand(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynoplex.Internal.Codec
import Xynoplex.Types.Presence (Presence)
import Xynoplex.Internal.Generated.Models.JobFilter
import Xynoplex.Internal.Generated.Models.UserId
data JobClaimCommand = JobClaimCommand { jobClaimCommandU5f_roles :: Maybe ([Text]), jobClaimCommandU5f_userId :: Maybe (UserId), jobClaimCommandAccepts :: [JobFilter], jobClaimCommandAdditionalProperties :: KM.KeyMap (Value) } deriving (Eq, Show)
instance FromJSON JobClaimCommand where
  parseJSON = checked "JobClaimCommand" $ withObject "JobClaimCommand" (\fields -> JobClaimCommand <$> optional fields "_roles" <*> optional fields "_userId" <*> fields .: "accepts" <*> traverse parseJSON (withoutFields ["_roles", "_userId", "accepts"] fields))
instance ToJSON JobClaimCommand where toJSON value = Object (KM.fromList (concat [optionalPair "_roles" (jobClaimCommandU5f_roles value), optionalPair "_userId" (jobClaimCommandU5f_userId value), [("accepts", toJSON (jobClaimCommandAccepts value))]]) <> fmap toJSON (withoutFields ["_roles", "_userId", "accepts"] (jobClaimCommandAdditionalProperties value)))
