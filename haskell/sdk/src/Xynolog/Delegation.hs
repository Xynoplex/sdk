-- | Typed job lifecycle reports and job-following failures.
module Xynolog.Delegation (JobEvent (..), UploadEvent (..), JobError (..), deriveStallDeadlineMs) where

import Xynolog.Internal.Delegation
