{-# LANGUAGE OverloadedStrings #-}
module RecordIdentifier where
import Xynolog.Types
value :: ResourceId -> ResourceId
value identifier = identifier { resourceIdValue = "unchecked" }
