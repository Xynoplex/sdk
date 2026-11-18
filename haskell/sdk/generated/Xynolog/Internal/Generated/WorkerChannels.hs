-- Generated from typescript/sdk/src/claims.ts and bus/registry.json; do not edit.
-- Regenerate: make generate (codegen/lib/haskell_sdk/worker.ml)
module Xynolog.Internal.Generated.WorkerChannels (jobClaimChannels, jobCommitChannels) where

import Data.Text (Text)
import Xynolog.Bus (replyChannelsFor)
import Xynolog.Channels

jobClaimChannels :: [Text]
jobClaimChannels = replyChannelsFor [SomeOperation JobClaimOperation] ++ [channelName JobQueued, channelName JobCancelRequested]

jobCommitChannels :: [Text]
jobCommitChannels = replyChannelsFor [SomeOperation MarkCommitOperation, SomeOperation BrowseAnnotationRequestedOperation]
