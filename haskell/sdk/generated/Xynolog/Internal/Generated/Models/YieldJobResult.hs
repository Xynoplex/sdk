-- Generated from protocol/specs/src. Run xynolog-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynolog.Internal.Generated.Models.YieldJobResult
  ( YieldJobResult(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynolog.Internal.Codec
import Xynolog.Types.Presence (Presence)
import Xynolog.Internal.Generated.Models.JobDeclined
import Xynolog.Internal.Generated.Models.YieldJobDone
data YieldJobResult = YieldJobResultBranch1 (YieldJobDone) | YieldJobResultBranch2 (JobDeclined) deriving (Eq, Show)
instance FromJSON YieldJobResult where
  parseJSON = checked "YieldJobResult" $ \value -> (YieldJobResultBranch1 <$> parseJSON value) <|> (YieldJobResultBranch2 <$> parseJSON value)
instance ToJSON YieldJobResult where
  toJSON (YieldJobResultBranch1 value) = toJSON value
  toJSON (YieldJobResultBranch2 value) = toJSON value
