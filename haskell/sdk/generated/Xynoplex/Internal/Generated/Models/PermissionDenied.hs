-- Generated from protocol/specs/src. Run xynoplex-codegen; do not edit.
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -Wno-unused-imports #-}
module Xynoplex.Internal.Generated.Models.PermissionDenied
  ( PermissionDenied(..)
  ) where
import Control.Applicative ((<|>))
import Data.Aeson (FromJSON(..), ToJSON(..), Value(..), withObject, (.:))
import Data.Aeson.Types (parseEither)
import qualified Data.Aeson.KeyMap as KM
import Data.Scientific (Scientific)
import Data.Text (Text)
import Xynoplex.Internal.Codec
import Xynoplex.Types.Presence (Presence)
data PermissionDenied = PermissionDenied { permissionDeniedDetail :: Maybe (Text) } deriving (Eq, Show)
instance FromJSON PermissionDenied where
  parseJSON = checked "PermissionDenied" $ withObject "PermissionDenied" (\fields -> PermissionDenied <$> fields .: "detail")
instance ToJSON PermissionDenied where toJSON value = Object (KM.fromList (concat [[("detail", toJSON (permissionDeniedDetail value))]]))
