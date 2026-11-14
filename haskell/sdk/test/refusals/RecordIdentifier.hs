{-# LANGUAGE OverloadedStrings #-}
module RecordIdentifier where
import Xynoplex.Types
value :: ResourceId -> ResourceId
value identifier = identifier { resourceIdValue = "unchecked" }
