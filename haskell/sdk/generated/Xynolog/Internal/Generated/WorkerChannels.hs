-- Generated from typescript/sdk/src/claims.ts and bus descriptors. Do not edit.
module Xynolog.Internal.Generated.WorkerChannels (jobClaimChannels, jobCommitChannels) where
import Data.Text (Text)
import Xynolog.Bus (replyChannelsFor)
import Xynolog.Channels
jobClaimChannels :: [Text]
jobClaimChannels = replyChannelsFor [SomeOperation JobClaimOperation] ++ [channelName JobQueued, channelName JobCancelRequested]
jobCommitChannels :: [Text]
jobCommitChannels = replyChannelsFor [SomeOperation MarkCommitOperation, SomeOperation BrowseAnnotationRequestedOperation]
