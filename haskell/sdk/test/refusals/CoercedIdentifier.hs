{-# LANGUAGE OverloadedStrings #-}

module CoercedIdentifier where

import Data.Coerce (coerce)
import Data.Text (Text)
import Xynolog.Types

value :: ResourceId
value = coerce ("unchecked" :: Text)
