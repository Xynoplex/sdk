{-# LANGUAGE GADTs #-}
module MissingScope where
import Xynoplex.Channels
accept :: ScopeArg scope -> Channel scope payload -> Bool
accept _ = channelIsScoped
value :: Bool
value = accept NoScope MarkAdded
